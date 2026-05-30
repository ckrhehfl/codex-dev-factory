#!/usr/bin/env bash
set -euo pipefail

script_path=${BASH_SOURCE[0]}
script_dir=$(cd -- "$(dirname -- "$script_path")" && pwd -P)
repo_root=$(cd -- "$script_dir/../.." && pwd -P)
repo="ckrhehfl/codex-dev-factory"
repo_owner="ckrhehfl"
repo_name="codex-dev-factory"
default_branch="main"

mode="assisted"
dry_run=false
max_loops=${MAX_REVIEW_FIX_LOOPS:-5}
poll_interval_seconds=${POLL_INTERVAL_SECONDS:-30}
max_wait_minutes=${MAX_CODEX_WAIT_MINUTES:-20}
github_writes_authorized=false
codex_edits_authorized=false

stop_condition=""
validation_passed=false

usage() {
  cat <<'EOF'
Usage:
  bash scripts/tasks/codex-review-loop.sh --help
  bash scripts/tasks/codex-review-loop.sh [--dry-run] [--mode assisted|autopilot] [options]

Options:
  --dry-run
      Read repository and PR state, classify review threads, and print intended
      actions without editing files, committing, pushing, posting comments, or
      resolving review threads.
  --mode assisted|autopilot
      assisted: report exact next actions and stop before file edits unless
        --codex-edits-authorized is explicitly supplied.
      autopilot: may invoke local `codex exec` for in-scope review fixes only
        when --codex-edits-authorized is supplied.
      Default: assisted.
  --max-loops N
      Maximum review-fix loops. Default: MAX_REVIEW_FIX_LOOPS or 5.
  --poll-interval-seconds N
      Seconds between Codex review polling attempts. Default:
      POLL_INTERVAL_SECONDS or 30.
  --max-wait-minutes N
      Maximum minutes to wait for a fresh Codex acknowledgement or result.
      Default: MAX_CODEX_WAIT_MINUTES or 20.
  --github-writes-authorized
      Allows task-contract-approved GitHub writes used by this runner:
      pushing the current PR branch, posting `@codex review`, and resolving
      review threads fixed by this loop. Do not use without explicit task
      contract approval.
  --codex-edits-authorized
      Allows local `codex exec` to edit only in-scope files for classified
      IN_SCOPE_FIX comments. In assisted mode this still requires explicit use
      of this flag. No high/xhigh model flags, yolo/full-access flags, merge,
      branch cleanup, force push, or secret inspection are used.

Behavior:
  Detects the current PR from the current branch with gh, reads PR metadata and
  unresolved review threads, classifies comments, applies only IN_SCOPE_FIX
  changes when explicitly authorized, validates changed files, commits and
  pushes only when changes exist and GitHub writes are authorized, requests a
  fresh Codex review, polls for a fresh result on the latest head, and stops
  before merge.

Safety boundaries:
  - Merge, auto-merge, branch cleanup, force push, force delete, branch delete,
    GitHub settings/rulesets/branch protection/permissions/workflow permission
    changes, secrets access, auth file inspection, env file inspection, and
    mutating OMX commands are not implemented.
  - Future gh writes such as PR comments, review requests, pushes, and review
    thread resolution require explicit task-contract approval plus
    --github-writes-authorized.
  - The runner validates local file changes against the PR changed-file scope.

Stop conditions:
  STOPPED_NO_CURRENT_PR_FOUND
  STOPPED_ON_PROTECTED_BRANCH
  STOPPED_WORKTREE_DIRTY
  STOPPED_GH_NOT_READY
  STOPPED_PR_METADATA_UNAVAILABLE
  STOPPED_REVIEW_COMMENTS_UNAVAILABLE
  STOPPED_ALLOWED_FILES_UNCLEAR
  STOPPED_FORBIDDEN_FILE_CHANGE
  STOPPED_OUT_OF_SCOPE_REVIEW_REQUEST
  STOPPED_OWNER_DECISION_REQUIRED
  STOPPED_UNSAFE_OR_FORBIDDEN_REVIEW_REQUEST
  STOPPED_VALIDATION_FAILED
  STOPPED_COMMIT_FAILED
  STOPPED_PUSH_FAILED
  STOPPED_REVIEW_THREAD_RESOLVE_FAILED
  STOPPED_CODEX_REVIEW_NOT_ACKNOWLEDGED
  STOPPED_CODEX_REVIEW_TIMEOUT
  STOPPED_LOOP_LIMIT_REACHED
  REVIEW_LOOP_COMPLETE
EOF
}

fail_usage() {
  printf 'codex_review_loop_status: failed\n' >&2
  printf 'stop_condition: invalid_arguments\n' >&2
  usage >&2
  exit 2
}

stop() {
  stop_condition=$1
  local message=${2:-}
  printf 'codex_review_loop_status: stopped\n'
  printf 'stop_condition: %s\n' "$stop_condition"
  if [[ -n "$message" ]]; then
    printf 'reason: %s\n' "$message"
  fi
  exit 0
}

complete() {
  printf 'codex_review_loop_status: complete\n'
  printf 'stop_condition: REVIEW_LOOP_COMPLETE\n'
  printf 'validation_passed: %s\n' "$validation_passed"
  exit 0
}

json_get() {
  local expr=$1
  python3 -c '
import json
import sys

data = json.load(sys.stdin)
value = data
for part in sys.argv[1].split("."):
    if not part:
        continue
    if isinstance(value, dict):
        value = value.get(part)
    else:
        value = None
        break
if value is None:
    sys.exit(1)
if isinstance(value, bool):
    print("true" if value else "false")
elif isinstance(value, (dict, list)):
    print(json.dumps(value, separators=(",", ":")))
else:
    print(value)
' "$expr"
}

require_positive_integer() {
  local name=$1
  local value=$2
  if ! [[ "$value" =~ ^[1-9][0-9]*$ ]]; then
    printf '%s must be a positive integer: %s\n' "$name" "$value" >&2
    fail_usage
  fi
}

current_branch() {
  git branch --show-current 2>/dev/null || true
}

worktree_clean() {
  [[ -z "$(git --no-optional-locks status --short --untracked-files=all)" ]]
}

require_gh_ready() {
  if ! command -v gh >/dev/null 2>&1; then
    stop "STOPPED_GH_NOT_READY" "gh is not installed"
  fi
  if ! gh auth status >/dev/null 2>&1; then
    stop "STOPPED_GH_NOT_READY" "gh is not authenticated"
  fi
  if ! gh api "repos/$repo" >/dev/null 2>&1; then
    stop "STOPPED_GH_NOT_READY" "gh cannot read $repo"
  fi
}

safe_gh() {
  gh "$@"
}

pr_json_for_branch() {
  local branch=$1
  local prs
  if ! prs=$(safe_gh pr list --repo "$repo" --head "$branch" --state open --limit 20 \
    --json number,state,isDraft,baseRefName,headRefName,headRepositoryOwner,headRefOid,url,changedFiles,files,updatedAt 2>/dev/null); then
    return 1
  fi
  python3 -c '
import json
import sys

branch = sys.argv[1]
owner = sys.argv[2]
items = json.load(sys.stdin)
matches = [
    item for item in items
    if item.get("headRefName") == branch
    and ((item.get("headRepositoryOwner") or {}).get("login") == owner)
]
if len(matches) != 1:
    print("{}")
else:
    print(json.dumps(matches[0], separators=(",", ":")))
' "$branch" "$repo_owner" <<<"$prs"
}

allowed_files_json() {
  python3 -c '
import json
import sys

data = json.load(sys.stdin)
paths = [item.get("path", "") for item in data.get("files") or [] if item.get("path")]
if data.get("changedFiles") != len(paths):
    print(json.dumps({"clear": False, "paths": paths}, separators=(",", ":")))
else:
    print(json.dumps({"clear": True, "paths": sorted(paths)}, separators=(",", ":")))
'
}

print_pr_metadata() {
  local pr_json=$1
  local number state draft base head head_sha changed_files url
  number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  state=$(printf '%s' "$pr_json" | json_get state 2>/dev/null || true)
  draft=$(printf '%s' "$pr_json" | json_get isDraft 2>/dev/null || true)
  base=$(printf '%s' "$pr_json" | json_get baseRefName 2>/dev/null || true)
  head=$(printf '%s' "$pr_json" | json_get headRefName 2>/dev/null || true)
  head_sha=$(printf '%s' "$pr_json" | json_get headRefOid 2>/dev/null || true)
  changed_files=$(printf '%s' "$pr_json" | json_get changedFiles 2>/dev/null || true)
  url=$(printf '%s' "$pr_json" | json_get url 2>/dev/null || true)

  cat <<EOF
pr:
  number: ${number:-unknown}
  url: ${url:-unknown}
  state: ${state:-unknown}
  draft: ${draft:-unknown}
  base: ${base:-unknown}
  head: ${head:-unknown}
  head_sha: ${head_sha:-unknown}
  changed_files: ${changed_files:-unknown}
EOF
}

review_threads_json() {
  local pr_number=$1
  local cursor=""
  local all_nodes="[]"
  local page nodes has_next next_cursor

  while :; do
    local args=(api graphql -f query='
query($owner:String!, $name:String!, $number:Int!, $after:String) {
  repository(owner:$owner, name:$name) {
    pullRequest(number:$number) {
      reviewThreads(first:100, after:$after) {
        pageInfo { hasNextPage endCursor }
        nodes {
          id
          isResolved
          isOutdated
          path
          line
          comments(first:100) {
            nodes {
              id
              databaseId
              body
              author { login }
              createdAt
              url
              path
              line
              replyTo { id }
            }
          }
        }
      }
    }
  }
}' -F owner="$repo_owner" -F name="$repo_name" -F number="$pr_number")
    if [[ -n "$cursor" ]]; then
      args+=(-F after="$cursor")
    fi
    if ! page=$(safe_gh "${args[@]}" 2>/dev/null); then
      return 1
    fi
    nodes=$(printf '%s' "$page" | json_get data.repository.pullRequest.reviewThreads.nodes 2>/dev/null || printf '[]')
    page_info=$(printf '%s' "$page" | json_get data.repository.pullRequest.reviewThreads.pageInfo 2>/dev/null || printf '{}')
    all_nodes=$(python3 -c '
import json
import sys
left = json.loads(sys.argv[1])
right = json.loads(sys.stdin.read())
print(json.dumps(left + right, separators=(",", ":")))
' "$all_nodes" <<<"$nodes")
    has_next=$(printf '%s' "$page_info" | json_get hasNextPage 2>/dev/null || printf 'false')
    next_cursor=$(printf '%s' "$page_info" | json_get endCursor 2>/dev/null || true)
    if [[ "$has_next" != "true" || -z "$next_cursor" ]]; then
      break
    fi
    cursor=$next_cursor
  done

  printf '%s\n' "$all_nodes"
}

classified_threads_json() {
  local allowed_json=$1
  python3 -c '
import json
import re
import sys

allowed_data = json.loads(sys.argv[1])
allowed = set(allowed_data.get("paths") or [])
threads = json.load(sys.stdin)

unsafe_re = re.compile(
    r"\b(secret|token|api key|credential|cookie|auth file|\.env|branch protection|"
    r"ruleset|permission|workflow permission|github setting|merge|auto-merge|"
    r"force push|force-push|force delete|delete branch|zeroshot|hermes|omx|yolo|"
    r"full access|danger-full-access|production)\b",
    re.I,
)
owner_re = re.compile(r"\b(owner decision|required decision|needs owner|product decision|policy decision|approve|approval)\b", re.I)
out_re = re.compile(r"\b(out of scope|outside scope|not in scope|separate pr|follow[- ]?up)\b", re.I)
clarify_re = re.compile(r"\b(question|clarify|clarification|nit|optional|consider)\b", re.I)

result = []
counts = {
    "IN_SCOPE_FIX": 0,
    "CLARIFICATION_ONLY": 0,
    "OWNER_DECISION_REQUIRED": 0,
    "OUT_OF_SCOPE": 0,
    "UNSAFE_OR_FORBIDDEN": 0,
}

for thread in threads:
    if thread.get("isResolved") or thread.get("isOutdated"):
        continue
    comments = (((thread.get("comments") or {}).get("nodes")) or [])
    actionable = []
    thread_path = thread.get("path") or ""
    for comment in comments:
        if comment.get("replyTo"):
            continue
        body = comment.get("body") or ""
        path = comment.get("path") or thread_path
        classification = "IN_SCOPE_FIX"
        reason = "comment appears actionable and path is in the PR changed-file scope"
        if unsafe_re.search(body):
            classification = "UNSAFE_OR_FORBIDDEN"
            reason = "comment mentions a forbidden or unsafe action/surface"
        elif owner_re.search(body):
            classification = "OWNER_DECISION_REQUIRED"
            reason = "comment appears to require owner approval or policy choice"
        elif out_re.search(body):
            classification = "OUT_OF_SCOPE"
            reason = "comment explicitly indicates out-of-scope or follow-up work"
        elif path and path not in allowed:
            classification = "OUT_OF_SCOPE"
            reason = "comment path is outside the current PR changed-file scope"
        elif clarify_re.search(body) and not re.search(r"\b(must|should|required|fix|bug|broken|incorrect|missing)\b", body, re.I):
            classification = "CLARIFICATION_ONLY"
            reason = "comment reads as clarification or optional discussion only"
        counts[classification] += 1
        actionable.append({
            "thread_id": thread.get("id"),
            "comment_id": comment.get("databaseId"),
            "comment_node_id": comment.get("id"),
            "author": ((comment.get("author") or {}).get("login") or ""),
            "path": path,
            "line": comment.get("line") or thread.get("line"),
            "url": comment.get("url"),
            "body": body,
            "classification": classification,
            "reason": reason,
        })
    if actionable:
        result.extend(actionable)

print(json.dumps({"counts": counts, "comments": result}, separators=(",", ":")))
' "$allowed_json"
}

print_classification_summary() {
  local classified=$1
  python3 -c '
import json
import sys

data = json.loads(sys.argv[1])
counts = data.get("counts") or {}
print("review_comment_classification:")
for key in ("IN_SCOPE_FIX", "CLARIFICATION_ONLY", "OWNER_DECISION_REQUIRED", "OUT_OF_SCOPE", "UNSAFE_OR_FORBIDDEN"):
    print(f"  {key}: {counts.get(key, 0)}")
for item in data.get("comments") or []:
    print(
        "  - {}: {}:{} {}".format(
            item.get("classification"),
            item.get("path") or "unknown",
            item.get("line") or "unknown",
            item.get("url") or "",
        )
    )
'
}

count_classification() {
  local classified=$1
  local key=$2
  python3 -c '
import json
import sys
data = json.loads(sys.argv[1])
print((data.get("counts") or {}).get(sys.argv[2], 0))
' "$classified" "$key"
}

write_fix_prompt() {
  local prompt_file=$1
  local pr_json=$2
  local allowed_json=$3
  local classified=$4
  python3 -c '
import json
import sys

pr = json.loads(sys.argv[1])
allowed = json.loads(sys.argv[2])
classified = json.loads(sys.argv[3])
in_scope = [item for item in classified.get("comments", []) if item.get("classification") == "IN_SCOPE_FIX"]

print("""You are fixing review comments for ckrhehfl/codex-dev-factory.

Task: apply only the IN_SCOPE_FIX review comments listed below.

Hard boundaries:
- Edit only files already changed in this PR.
- Do not inspect secrets, tokens, cookies, auth files, env files, API keys, GitHub secrets, or secret-looking files.
- Do not change GitHub workflows, settings, permissions, branch protection, rulesets, production/runtime/source code outside the PR scope, OMX state/config, Zeroshot, or Hermes configuration.
- Do not merge, enable auto-merge, cleanup branches, force push, force delete, or run mutating OMX commands.
- Keep changes minimal and validate shell syntax when shell scripts are touched.
""")
print("PR metadata:")
print(json.dumps({
    "number": pr.get("number"),
    "base": pr.get("baseRefName"),
    "head": pr.get("headRefName"),
    "head_sha": pr.get("headRefOid"),
    "allowed_files": allowed.get("paths") or [],
}, indent=2))
print("\nIN_SCOPE_FIX comments:")
print(json.dumps(in_scope, indent=2))
' "$pr_json" "$allowed_json" "$classified" >"$prompt_file"
}

validate_changed_files_within_scope() {
  local allowed_json=$1
  python3 -c '
import json
import subprocess
import sys

allowed = set((json.loads(sys.argv[1]).get("paths")) or [])
diff_result = subprocess.run(
    ["git", "diff", "--name-only", "HEAD"],
    check=True,
    stdout=subprocess.PIPE,
    text=True,
)
status_result = subprocess.run(
    ["git", "status", "--porcelain", "--untracked-files=all"],
    check=True,
    stdout=subprocess.PIPE,
    text=True,
)
changed = set(line for line in diff_result.stdout.splitlines() if line)
for line in status_result.stdout.splitlines():
    if not line:
        continue
    path = line[3:]
    if " -> " in path:
        path = path.split(" -> ", 1)[1]
    if path:
        changed.add(path)
for path in changed:
    if path not in allowed:
        print(path)
' "$allowed_json"
}

validate_lightweight() {
  local changed_shell
  if ! git diff --check; then
    return 1
  fi

  changed_shell=$(git diff --name-only -- '*.sh')
  while IFS= read -r path; do
    [[ -z "$path" ]] && continue
    if [[ -f "$path" ]]; then
      bash -n "$path" || return 1
    fi
  done <<<"$changed_shell"

  if [[ -x scripts/checks/repo-guard.sh || -f scripts/checks/repo-guard.sh ]]; then
    bash scripts/checks/repo-guard.sh || return 1
  fi
}

stage_allowed_files() {
  local allowed_json=$1
  python3 -c '
import json
import sys
for path in (json.loads(sys.argv[1]).get("paths") or []):
    print(path)
' "$allowed_json" | while IFS= read -r path; do
    [[ -z "$path" ]] && continue
    if [[ -e "$path" ]]; then
      git add -- "$path"
    else
      git add -u -- "$path"
    fi
  done
}

commit_changes() {
  local pr_number=$1
  local allowed_json=$2
  if worktree_clean; then
    return 0
  fi

  stage_allowed_files "$allowed_json"
  git commit -m "Keep Codex review loop moving safely

Constraint: PR review feedback was classified as in-scope for the current changed-file set.
Rejected: merge or branch cleanup automation | PR review-loop tasks stop before merge unless separately authorized.
Confidence: medium
Scope-risk: narrow
Directive: Keep future review-loop fixes inside the task contract and current PR changed-file scope.
Tested: git diff --check; bash -n for changed shell scripts; repo guard when available
Not-tested: full end-to-end GitHub review loop outside this PR-local runner" >/dev/null || return 1
  printf 'commit_created_for_pr: #%s\n' "$pr_number"
}

push_current_branch() {
  local branch=$1
  git push -u origin "$branch" >/dev/null
}

resolve_threads() {
  local classified=$1
  python3 -c '
import json
import sys
data = json.loads(sys.argv[1])
ids = []
for item in data.get("comments") or []:
    if item.get("classification") == "IN_SCOPE_FIX" and item.get("thread_id") not in ids:
        ids.append(item.get("thread_id"))
for thread_id in ids:
    if thread_id:
        print(thread_id)
' "$classified" | while IFS= read -r thread_id; do
    [[ -z "$thread_id" ]] && continue
    safe_gh api graphql -f query='
mutation($threadId:ID!) {
  resolveReviewThread(input:{threadId:$threadId}) {
    thread { id isResolved }
  }
}' -F threadId="$thread_id" >/dev/null || return 1
  done
}

post_codex_review() {
  local pr_number=$1
  safe_gh pr comment "$pr_number" --repo "$repo" --body "@codex review" >/dev/null
}

codex_result_json() {
  local pr_number=$1
  local head_sha=$2
  local since_epoch=$3
  local comments reviews
  comments=$(safe_gh api --paginate --slurp "repos/$repo/issues/$pr_number/comments?per_page=100" 2>/dev/null || printf '[]')
  reviews=$(safe_gh api --paginate --slurp "repos/$repo/pulls/$pr_number/reviews?per_page=100" 2>/dev/null || printf '[]')
  python3 -c '
from datetime import datetime, timezone
import json
import sys

comments_pages = json.loads(sys.argv[1])
reviews_pages = json.loads(sys.argv[2])
head = sys.argv[3]
since_epoch = int(sys.argv[4])

def flatten(value):
    if isinstance(value, dict):
        return [value]
    out = []
    for item in value:
        if isinstance(item, list):
            out.extend(item)
        elif isinstance(item, dict):
            out.append(item)
    return out

def parse_time(raw):
    if not raw:
        return 0
    try:
        return int(datetime.fromisoformat(raw.replace("Z", "+00:00")).timestamp())
    except ValueError:
        return 0

items = []
for item in flatten(comments_pages):
    item = dict(item)
    item["_kind"] = "issue_comment"
    items.append(item)
for item in flatten(reviews_pages):
    item = dict(item)
    item["_kind"] = "pull_review"
    items.append(item)

ack = []
success = []
blocking = []
for item in items:
    body = item.get("body") or ""
    author = ((item.get("user") or {}).get("login") or "").lower()
    created = item.get("created_at") or item.get("submitted_at") or ""
    created_epoch = parse_time(created)
    if "codex" not in author or created_epoch < since_epoch:
        continue
    lower = body.lower()
    explicit_head = bool(head and (head in body or head[:10] in body))
    fresh = explicit_head or created_epoch >= since_epoch
    if not fresh:
        continue
    if "review" in lower or "working" in lower or "queued" in lower or "started" in lower:
        ack.append({"created_at": created, "kind": item.get("_kind"), "body": body[:160]})
    if (
        "no major issues" in lower
        or "no suggestions" in lower
        or "no further suggestions" in lower
        or "looks good" in lower
        or "lgtm" in lower
    ):
        success.append({"created_at": created, "kind": item.get("_kind"), "body": body[:160]})
    if "major issue" in lower or "request changes" in lower or "needs changes" in lower:
        blocking.append({"created_at": created, "kind": item.get("_kind"), "body": body[:160]})

print(json.dumps({
    "acknowledged": bool(ack or success or blocking),
    "success": bool(success and not blocking),
    "blocking": bool(blocking),
    "ack": ack[-3:],
    "success_matches": success[-3:],
    "blocking_matches": blocking[-3:],
}, separators=(",", ":")))
' "$comments" "$reviews" "$head_sha" "$since_epoch"
}

poll_codex_review() {
  local pr_number=$1
  local head_sha=$2
  local since_epoch=$3
  local deadline=$((since_epoch + max_wait_minutes * 60))
  local acknowledged=false
  local result

  while (( $(date +%s) <= deadline )); do
    result=$(codex_result_json "$pr_number" "$head_sha" "$since_epoch")
    printf 'codex_review_poll_result: %s\n' "$result"
    if [[ "$(printf '%s' "$result" | json_get success 2>/dev/null || printf false)" == "true" ]]; then
      return 0
    fi
    if [[ "$(printf '%s' "$result" | json_get acknowledged 2>/dev/null || printf false)" == "true" ]]; then
      acknowledged=true
    fi
    sleep "$poll_interval_seconds"
  done

  if [[ "$acknowledged" != "true" ]]; then
    stop "STOPPED_CODEX_REVIEW_NOT_ACKNOWLEDGED" "no fresh Codex acknowledgement was observed before timeout"
  fi
  stop "STOPPED_CODEX_REVIEW_TIMEOUT" "no fresh no-major-issues result was observed before timeout"
}

parse_args() {
  while (($#)); do
    case "$1" in
      --help)
        usage
        exit 0
        ;;
      --dry-run)
        dry_run=true
        shift
        ;;
      --mode)
        [[ $# -ge 2 ]] || fail_usage
        mode=$2
        case "$mode" in
          assisted|autopilot) ;;
          *) fail_usage ;;
        esac
        shift 2
        ;;
      --max-loops)
        [[ $# -ge 2 ]] || fail_usage
        max_loops=$2
        shift 2
        ;;
      --poll-interval-seconds)
        [[ $# -ge 2 ]] || fail_usage
        poll_interval_seconds=$2
        shift 2
        ;;
      --max-wait-minutes)
        [[ $# -ge 2 ]] || fail_usage
        max_wait_minutes=$2
        shift 2
        ;;
      --github-writes-authorized)
        github_writes_authorized=true
        shift
        ;;
      --codex-edits-authorized)
        codex_edits_authorized=true
        shift
        ;;
      *)
        fail_usage
        ;;
    esac
  done

  require_positive_integer "--max-loops" "$max_loops"
  require_positive_integer "--poll-interval-seconds" "$poll_interval_seconds"
  require_positive_integer "--max-wait-minutes" "$max_wait_minutes"
}

main() {
  parse_args "$@"
  cd "$repo_root"

  local branch pr_json pr_number pr_state allowed_json allowed_clear loop threads classified
  branch=$(current_branch)

  cat <<EOF
codex_review_loop_status: evaluating
mode: $mode
dry_run: $dry_run
repo: $repo
branch: ${branch:-unknown}
max_loops: $max_loops
poll_interval_seconds: $poll_interval_seconds
max_wait_minutes: $max_wait_minutes
github_writes_authorized: $github_writes_authorized
codex_edits_authorized: $codex_edits_authorized
merge_authorized: false
branch_cleanup_authorized: false
EOF

  case "$branch" in
    ""|"$default_branch"|main|master|develop|dev|release|production)
      stop "STOPPED_ON_PROTECTED_BRANCH" "review-loop runner must run from a PR feature branch"
      ;;
  esac

  if ! worktree_clean; then
    stop "STOPPED_WORKTREE_DIRTY" "worktree must be clean before starting the loop"
  fi

  require_gh_ready

  if ! pr_json=$(pr_json_for_branch "$branch"); then
    stop "STOPPED_PR_METADATA_UNAVAILABLE" "gh failed to read PR metadata for current branch"
  fi
  if [[ "$pr_json" == "{}" ]]; then
    stop "STOPPED_NO_CURRENT_PR_FOUND" "no open PR found for current branch"
  fi
  print_pr_metadata "$pr_json"

  pr_number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  pr_state=$(printf '%s' "$pr_json" | json_get state 2>/dev/null || true)
  if [[ -z "$pr_number" || "$pr_state" != "OPEN" ]]; then
    stop "STOPPED_PR_METADATA_UNAVAILABLE" "current branch PR metadata is incomplete or PR is not open"
  fi

  allowed_json=$(printf '%s' "$pr_json" | allowed_files_json)
  allowed_clear=$(printf '%s' "$allowed_json" | json_get clear 2>/dev/null || printf false)
  printf 'allowed_files: %s\n' "$allowed_json"
  if [[ "$allowed_clear" != "true" ]]; then
    stop "STOPPED_ALLOWED_FILES_UNCLEAR" "gh changedFiles count did not match the PR file list"
  fi

  for ((loop = 1; loop <= max_loops; loop++)); do
    printf 'loop: %s\n' "$loop"
    if ! threads=$(review_threads_json "$pr_number"); then
      stop "STOPPED_REVIEW_COMMENTS_UNAVAILABLE" "gh failed to read review threads"
    fi
    classified=$(printf '%s' "$threads" | classified_threads_json "$allowed_json")
    print_classification_summary "$classified"

    local unsafe owner out_scope in_scope clarification forbidden_changes prompt_file since_epoch head_sha
    unsafe=$(count_classification "$classified" "UNSAFE_OR_FORBIDDEN")
    owner=$(count_classification "$classified" "OWNER_DECISION_REQUIRED")
    out_scope=$(count_classification "$classified" "OUT_OF_SCOPE")
    in_scope=$(count_classification "$classified" "IN_SCOPE_FIX")
    clarification=$(count_classification "$classified" "CLARIFICATION_ONLY")

    if (( unsafe > 0 )); then
      stop "STOPPED_UNSAFE_OR_FORBIDDEN_REVIEW_REQUEST" "unresolved review comments request forbidden or unsafe action"
    fi
    if (( owner > 0 )); then
      stop "STOPPED_OWNER_DECISION_REQUIRED" "unresolved review comments require owner decision"
    fi
    if (( out_scope > 0 )); then
      stop "STOPPED_OUT_OF_SCOPE_REVIEW_REQUEST" "unresolved review comments are outside current PR scope"
    fi

    if (( in_scope == 0 )); then
      if ! validate_lightweight; then
        stop "STOPPED_VALIDATION_FAILED" "lightweight validation failed"
      fi
      validation_passed=true
      if [[ "$dry_run" == "true" || "$github_writes_authorized" != "true" ]]; then
        printf 'review_request_status: skipped\n'
        printf 'review_request_reason: dry-run or GitHub writes are not task-contract authorized\n'
        printf 'unresolved_clarification_only_threads: %s\n' "$clarification"
        complete
      fi
      head_sha=$(git rev-parse HEAD)
      since_epoch=$(date +%s)
      post_codex_review "$pr_number"
      poll_codex_review "$pr_number" "$head_sha" "$since_epoch"
      complete
    fi

    if [[ "$dry_run" == "true" ]]; then
      stop "STOPPED_OWNER_DECISION_REQUIRED" "dry-run found in-scope fixes; rerun with an explicit task contract before editing"
    fi
    if [[ "$codex_edits_authorized" != "true" ]]; then
      stop "STOPPED_OWNER_DECISION_REQUIRED" "in-scope fixes exist, but local Codex edits were not authorized"
    fi
    if ! command -v codex >/dev/null 2>&1; then
      stop "STOPPED_OWNER_DECISION_REQUIRED" "codex CLI is unavailable for authorized local edits"
    fi

    prompt_file=$(mktemp)
    write_fix_prompt "$prompt_file" "$pr_json" "$allowed_json" "$classified"
    if [[ "$mode" == "assisted" ]]; then
      printf 'assisted_fix_prompt: %s\n' "$prompt_file"
      stop "STOPPED_OWNER_DECISION_REQUIRED" "assisted mode prepared the fix prompt and stopped before executing Codex edits"
    fi

    codex exec "$(cat "$prompt_file")"
    rm -f "$prompt_file"

    forbidden_changes=$(validate_changed_files_within_scope "$allowed_json")
    if [[ -n "$forbidden_changes" ]]; then
      printf 'forbidden_file_changes:\n%s\n' "$forbidden_changes"
      stop "STOPPED_FORBIDDEN_FILE_CHANGE" "local edits escaped the PR changed-file scope"
    fi
    if ! validate_lightweight; then
      stop "STOPPED_VALIDATION_FAILED" "lightweight validation failed after edits"
    fi
    validation_passed=true

    if [[ "$github_writes_authorized" != "true" ]]; then
      stop "STOPPED_OWNER_DECISION_REQUIRED" "changes are ready, but commit/push/thread resolution/re-review are not task-contract authorized"
    fi
    if ! commit_changes "$pr_number" "$allowed_json"; then
      stop "STOPPED_COMMIT_FAILED" "git commit failed"
    fi
    if ! push_current_branch "$branch"; then
      stop "STOPPED_PUSH_FAILED" "git push failed"
    fi
    if ! resolve_threads "$classified"; then
      stop "STOPPED_REVIEW_THREAD_RESOLVE_FAILED" "failed to resolve one or more review threads"
    fi

    pr_json=$(pr_json_for_branch "$branch")
    head_sha=$(printf '%s' "$pr_json" | json_get headRefOid 2>/dev/null || git rev-parse HEAD)
    since_epoch=$(date +%s)
    post_codex_review "$pr_number"
    poll_codex_review "$pr_number" "$head_sha" "$since_epoch"
  done

  stop "STOPPED_LOOP_LIMIT_REACHED" "maximum review-fix loops reached"
}

main "$@"
