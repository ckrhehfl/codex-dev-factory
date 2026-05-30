#!/usr/bin/env bash
set -euo pipefail

script_path=${BASH_SOURCE[0]}
script_dir=$(cd -- "$(dirname -- "$script_path")" && pwd -P)
repo_root=$(cd -- "$script_dir/../.." && pwd -P)
repo="ckrhehfl/codex-dev-factory"
expected_owner="ckrhehfl"
default_branch="main"
dry_run=false
mode="assisted"
latest_merged_pr_limit=200

usage() {
  cat <<'EOF'
Usage:
  bash scripts/tasks/codex-loop.sh --help
  bash scripts/tasks/codex-loop.sh --list
  bash scripts/tasks/codex-loop.sh [--dry-run] [--mode assisted|autopilot] <task-id>

Task IDs:
  docs-folderize-operations
  review-fix
  compound
  branch-cleanup
  current-pr
  latest-merged-pr

Behavior:
  Runs a repo-local B-mode PR lifecycle runner MVP readiness pass.
  Reads GitHub PR state with an existing authenticated gh CLI when available.
  Reports capability gaps instead of installing tools, logging in, inspecting
  credentials, mutating settings, force pushing, force deleting, or changing
  GitHub repository configuration.
  Evaluates merge, cleanup, review, and Compound gates for future safe-scope PRs.
  Does not auto-merge, auto-cleanup, or self-operate on PR #85.
EOF
}

list_tasks() {
  cat <<'EOF'
docs-folderize-operations
review-fix
compound
branch-cleanup
current-pr
latest-merged-pr
EOF
}

fail_usage() {
  printf 'codex_loop_status: failed\n' >&2
  printf 'stop_condition: invalid_arguments\n' >&2
  usage >&2
  exit 2
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

json_codex_no_major_summary() {
  local head_sha=$1
  local head_date=$2
  python3 -c '
from datetime import datetime, timezone
import json
import sys

head = sys.argv[1]
head_date_raw = sys.argv[2]

def parse_time(raw):
    if not raw:
        return None
    try:
        return datetime.fromisoformat(raw.replace("Z", "+00:00"))
    except ValueError:
        return None

head_date = parse_time(head_date_raw)
items = json.load(sys.stdin)
matches = []
for item in items:
    body = item.get("body") or ""
    author = (
        ((item.get("user") or {}).get("login") or "")
        or ((item.get("author") or {}).get("login") or "")
    ).lower()
    created = (
        item.get("created_at")
        or item.get("createdAt")
        or item.get("submitted_at")
        or item.get("submittedAt")
        or ""
    )
    created_date = parse_time(created)
    body_lower = body.lower()
    if "codex" not in author:
        continue
    if "no major issues" not in body_lower:
        continue
    explicit_head = head and (head in body or head[:10] in body or head[:7] in body)
    after_head = bool(head_date and created_date and created_date >= head_date)
    matches.append({
        "created_at": created,
        "explicit_head": bool(explicit_head),
        "after_latest_head": after_head,
        "fresh_for_latest_head": bool(explicit_head or after_head),
        "body": body[:120],
    })
print(json.dumps({
    "matches": matches,
    "fresh_match_count": sum(1 for match in matches if match["fresh_for_latest_head"]),
}, separators=(",", ":")))
' "$head_sha" "$head_date"
}

require_repo_root() {
  cd "$repo_root"
}

current_branch() {
  git branch --show-current 2>/dev/null || true
}

worktree_clean() {
  [[ -z "$(git --no-optional-locks status --short --untracked-files=all)" ]]
}

gh_available() {
  command -v gh >/dev/null 2>&1
}

gh_authed() {
  gh auth status >/dev/null 2>&1
}

gh_api_available() {
  gh api "repos/$repo" >/dev/null 2>&1
}

safe_gh() {
  gh "$@"
}

print_header() {
  cat <<EOF
codex_loop_status: evaluating
mode: $mode
dry_run: $dry_run
repo: $repo
branch: $(current_branch)
EOF
}

print_capability_inventory() {
  local gh_installed="false"
  local gh_auth="false"
  local gh_api="false"
  local pr_read="false"
  local pr_write_comment="확인 필요"
  local review_request="확인 필요"
  local checks_query="false"
  local review_query="false"
  local merge_endpoint="확인 필요"
  local remote_branch_delete="확인 필요"
  local codex_prompt="false"
  local codex_exec="false"

  if gh_available; then
    gh_installed="true"
    if gh_authed; then
      gh_auth="true"
    fi
    if gh_api_available; then
      gh_api="true"
      pr_read="true"
      checks_query="true"
      review_query="true"
      pr_write_comment="available_with_existing_auth_not_mutated"
      review_request="available_with_existing_auth_not_mutated"
      merge_endpoint="detectable_with_existing_auth_not_invoked"
      remote_branch_delete="detectable_with_existing_auth_not_invoked"
    fi
  fi

  if codex --help 2>/dev/null | grep -q '\[PROMPT\]'; then
    codex_prompt="true"
  fi
  if codex --help 2>/dev/null | grep -q '^  exec '; then
    codex_exec="true"
  fi

  cat <<EOF
capability_inventory:
  gh_installed: $gh_installed
  gh_auth_status_works: $gh_auth
  gh_api_works: $gh_api
  github_pr_read_possible: $pr_read
  github_pr_write_comment_possible: $pr_write_comment
  github_review_request_possible: $review_request
  github_actions_checks_query_possible: $checks_query
  github_review_comments_threads_submissions_query_possible: $review_query
  merge_endpoint_detectable_without_merging: $merge_endpoint
  remote_branch_deletion_detectable_without_deleting: $remote_branch_delete
  local_branch_cleanup_validation: safe_dry_run_reasoning_only
  codex_prompt_argument_supported: $codex_prompt
  codex_exec_supported: $codex_exec
  cdfcodex_alias_shape: user-reported normal Codex work after readiness passes
  cdfcheck_alias_shape: user-reported read-only readiness/status check
EOF

  if [[ "$gh_installed" != "true" || "$gh_auth" != "true" || "$gh_api" != "true" ]]; then
    cat <<'EOF'
capability_gap:
  evidence_class: local-verified
  stop_condition: owner_action_required
  reason: gh CLI is missing, unauthenticated, or API access failed; B-mode local loop automation needs gh or an approved equivalent GitHub API path.
EOF
  fi
}

find_current_pr_json() {
  local branch=$1
  safe_gh pr list --repo "$repo" --head "$branch" --state all --limit 100 \
    --json number,state,isDraft,baseRefName,headRefName,headRepositoryOwner,headRepository,headRefOid,mergeable,reviewDecision,url,changedFiles,files,author,createdAt,updatedAt
}

find_latest_merged_pr_json() {
  safe_gh pr list --repo "$repo" --state merged --limit "$latest_merged_pr_limit" \
    --json number,state,isDraft,baseRefName,headRefName,headRepositoryOwner,headRepository,headRefOid,mergeCommit,url,changedFiles,files,author,createdAt,updatedAt,mergedAt
}

current_pr_or_empty() {
  local branch=$1
  local owner=$2
  python3 -c '
import json
import sys

branch = sys.argv[1]
owner = sys.argv[2]
items = json.load(sys.stdin)

def owner_login(item):
    return ((item.get("headRepositoryOwner") or {}).get("login") or "")

candidates = [
    item for item in items
    if item.get("headRefName") == branch and owner_login(item) == owner
]
open_candidates = [item for item in candidates if item.get("state") == "OPEN"]
if len(open_candidates) == 1:
    print(json.dumps(open_candidates[0], separators=(",", ":")))
elif len(open_candidates) > 1:
    print("{}")
else:
    if len(candidates) == 1:
        print(json.dumps(candidates[0], separators=(",", ":")))
    else:
        print("{}")
' "$branch" "$owner"
}

latest_merged_pr_or_empty() {
  local limit=$1
  python3 -c '
from datetime import datetime
import json
import sys

limit = int(sys.argv[1])
items = json.load(sys.stdin)
if not items or len(items) >= limit:
    print("{}")
    sys.exit(0)

def merged_at(item):
    raw = item.get("mergedAt") or ""
    try:
        return datetime.fromisoformat(raw.replace("Z", "+00:00"))
    except ValueError:
        return datetime.min

print(json.dumps(max(items, key=merged_at), separators=(",", ":")))
' "$limit"
}

print_pr_summary() {
  local pr_json=$1
  local number state draft base head owner head_sha changed_files url
  number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  state=$(printf '%s' "$pr_json" | json_get state 2>/dev/null || true)
  draft=$(printf '%s' "$pr_json" | json_get isDraft 2>/dev/null || true)
  base=$(printf '%s' "$pr_json" | json_get baseRefName 2>/dev/null || true)
  head=$(printf '%s' "$pr_json" | json_get headRefName 2>/dev/null || true)
  owner=$(printf '%s' "$pr_json" | json_get headRepositoryOwner.login 2>/dev/null || true)
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
  head_owner: ${owner:-unknown}
  head_sha: ${head_sha:-unknown}
  changed_files: ${changed_files:-unknown}
EOF
}

allowed_scope_for_task() {
  local task_id=$1
  case "$task_id" in
    docs-folderize-operations)
      printf 'docs/**, README.md'
      ;;
    review-fix)
      printf 'existing PR changed files only'
      ;;
    compound)
      printf 'docs/solutions/** and PR metadata only'
      ;;
    branch-cleanup)
      printf 'no file edits'
      ;;
    current-pr|latest-merged-pr)
      printf 'read-only PR lifecycle inspection'
      ;;
    *)
      printf 'unknown'
      ;;
  esac
}

files_within_initial_safe_scope() {
  local task_id=$1
  local pr_json=$2
  python3 -c '
import json
import sys

task_id = sys.argv[1]
data = json.load(sys.stdin)
files = data.get("files") or []
paths = [f.get("path", "") for f in files]
changed_files = data.get("changedFiles")
if isinstance(changed_files, int) and changed_files != len(paths):
    print("false")
    sys.exit(0)
allowed = True
for path in paths:
    if task_id == "docs-folderize-operations":
        if path == "README.md" or path.startswith("docs/"):
            continue
    elif task_id == "compound":
        if path.startswith("docs/solutions/"):
            continue
    elif task_id == "review-fix":
        # Review-fix work is limited by the existing PR file set.
        continue
    elif task_id in ("current-pr", "latest-merged-pr"):
        if path in ("README.md", "scripts/tasks/codex-loop.sh") or path.startswith("docs/"):
            continue
    elif task_id == "branch-cleanup":
        pass
    allowed = False
print("true" if allowed else "false")
' "$task_id" <<<"$pr_json"
}

repo_guard_success_for_head() {
  local sha=$1
  local status_json check_json required_json status_state status_contexts check_result required_result

  status_json=$(safe_gh api "repos/$repo/commits/$sha/status" 2>/dev/null || printf '{}')
  status_state=$(printf '%s' "$status_json" | json_get state 2>/dev/null || printf 'unknown')
  status_contexts=$(printf '%s' "$status_json" | json_get statuses 2>/dev/null | python3 -c 'import json,sys; print(len(json.load(sys.stdin)))' 2>/dev/null || printf '0')
  check_json=$(safe_gh api "repos/$repo/commits/$sha/check-runs" 2>/dev/null || printf '{"check_runs":[]}')
  required_json=$(safe_gh api "repos/$repo/branches/$default_branch/protection/required_status_checks" 2>/dev/null || printf '{}')
  check_result=$(python3 -c '
import json
import sys

data = json.load(sys.stdin)
failed = []
pending = []
for run in data.get("check_runs", []):
    name = run.get("name") or ""
    conclusion = run.get("conclusion")
    status = run.get("status")
    if status != "completed":
        pending.append(f"{name}:{status}/{conclusion}")
        continue
    if conclusion not in ("success", "neutral", "skipped"):
        failed.append(f"{name}:{status}/{conclusion}")
print("{}|{}|{}".format(len(data.get("check_runs", [])), len(failed), len(pending)))
' <<<"$check_json"
)
  required_result=$(python3 -c '
import json
import sys

status_data = json.loads(sys.argv[1])
check_data = json.loads(sys.argv[2])
required_data = json.loads(sys.argv[3])

successful = set()
for status in status_data.get("statuses", []):
    if status.get("state") == "success":
        context = status.get("context")
        if context:
            successful.add(context)
for run in check_data.get("check_runs", []):
    if run.get("status") == "completed" and run.get("conclusion") in ("success", "neutral", "skipped"):
        name = run.get("name")
        if name:
            successful.add(name)

required = set(required_data.get("contexts") or [])
for item in required_data.get("checks") or []:
    context = item.get("context")
    if context:
        required.add(context)

missing = sorted(required - successful)
print("{}|{}".format(len(required), len(missing)))
' "$status_json" "$check_json" "$required_json")

  IFS='|' read -r check_count check_failures check_pending <<<"$check_result"
  IFS='|' read -r required_count required_missing <<<"$required_result"
  if (( check_count > 0 && check_failures == 0 && check_pending == 0 )) &&
    (( required_count > 0 && required_missing == 0 )) &&
    [[ "$status_state" == "success" || "$status_contexts" == "0" ]]; then
    printf 'true'
  else
    printf 'false'
  fi
}

review_threads_json_for_pr() {
  local pr_number=$1
  local all_nodes="[]"
  local cursor=""
  local complete="true"
  local page nodes page_info has_next next_cursor

  while :; do
    if ! page=$(safe_gh api graphql -f query='
query($owner:String!, $name:String!, $number:Int!, $after:String) {
  repository(owner:$owner, name:$name) {
    pullRequest(number:$number) {
      reviewThreads(first:100, after:$after) {
        pageInfo { hasNextPage endCursor }
        nodes { isResolved isOutdated }
      }
    }
  }
}' -F owner=ckrhehfl -F name=codex-dev-factory -F number="$pr_number" -F after="$cursor" 2>/dev/null); then
      complete="false"
      break
    fi

    nodes=$(python3 -c '
import json
import sys

data = json.load(sys.stdin)
threads = (((data.get("data") or {}).get("repository") or {}).get("pullRequest") or {}).get("reviewThreads") or {}
print(json.dumps(threads.get("nodes") or [], separators=(",", ":")))
' <<<"$page" 2>/dev/null || printf '[]')
    all_nodes=$(python3 -c '
import json
import sys

left = json.loads(sys.argv[1])
right = json.loads(sys.argv[2])
print(json.dumps(left + right, separators=(",", ":")))
' "$all_nodes" "$nodes")
    page_info=$(python3 -c '
import json
import sys

data = json.load(sys.stdin)
threads = (((data.get("data") or {}).get("repository") or {}).get("pullRequest") or {}).get("reviewThreads") or {}
page_info = threads.get("pageInfo") or {}
print("{}|{}".format("true" if page_info.get("hasNextPage") else "false", page_info.get("endCursor") or ""))
' <<<"$page" 2>/dev/null || printf 'true|')
    IFS='|' read -r has_next next_cursor <<<"$page_info"
    if [[ "$has_next" != "true" ]]; then
      break
    fi
    if [[ -z "$next_cursor" ]]; then
      complete="false"
      break
    fi
    cursor=$next_cursor
  done

  python3 -c '
import json
import sys

print(json.dumps({
    "complete": sys.argv[1] == "true",
    "nodes": json.loads(sys.argv[2]),
}, separators=(",", ":")))
' "$complete" "$all_nodes"
}

review_evidence_for_pr() {
  local pr_number=$1
  local head_sha=$2
  local comments reviews threads no_major unresolved commit_json head_date

  comments=$(safe_gh pr view "$pr_number" --repo "$repo" --comments --json comments 2>/dev/null || printf '{"comments":[]}')
  reviews=$(safe_gh pr view "$pr_number" --repo "$repo" --json reviews 2>/dev/null || printf '{"reviews":[]}')
  commit_json=$(safe_gh api "repos/$repo/commits/$head_sha" 2>/dev/null || printf '{}')
  head_date=$(printf '%s' "$commit_json" | json_get commit.committer.date 2>/dev/null || true)
  threads=$(review_threads_json_for_pr "$pr_number")

  no_major=$(
    python3 -c '
import json
import sys

comments = json.loads(sys.argv[1]).get("comments", [])
reviews = json.loads(sys.argv[2]).get("reviews", [])
print(json.dumps(comments + reviews, separators=(",", ":")))
' "$comments" "$reviews" | json_codex_no_major_summary "$head_sha" "$head_date" || printf '{"matches":[],"fresh_match_count":0}'
  )
  unresolved=$(python3 -c '
import json
import sys

data = json.load(sys.stdin)
if not data.get("complete", False):
    print("확인 필요")
    sys.exit(0)
nodes = data.get("nodes") or []
print(sum(1 for node in nodes if not node.get("isResolved", False)))
' <<<"$threads"
  )

  cat <<EOF
review_evidence:
  comments_read: true
  reviews_read: true
  review_threads_read: true
  latest_head_committer_date: ${head_date:-확인 필요}
  unresolved_review_threads: ${unresolved:-확인 필요}
  final_codex_no_major_issues_freshness: $no_major
EOF
}

decide_merge_safety() {
  local task_id=$1
  local pr_json=$2
  local number state draft base head owner head_sha scope_ok guard_ok clean branch_safe
  number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  state=$(printf '%s' "$pr_json" | json_get state 2>/dev/null || true)
  draft=$(printf '%s' "$pr_json" | json_get isDraft 2>/dev/null || true)
  base=$(printf '%s' "$pr_json" | json_get baseRefName 2>/dev/null || true)
  head=$(printf '%s' "$pr_json" | json_get headRefName 2>/dev/null || true)
  owner=$(printf '%s' "$pr_json" | json_get headRepositoryOwner.login 2>/dev/null || true)
  head_sha=$(printf '%s' "$pr_json" | json_get headRefOid 2>/dev/null || true)
  scope_ok=$(files_within_initial_safe_scope "$task_id" "$pr_json")
  guard_ok="확인 필요"
  if [[ -n "$head_sha" ]]; then
    guard_ok=$(repo_guard_success_for_head "$head_sha")
  fi
  clean="false"
  if worktree_clean; then
    clean="true"
  fi
  branch_safe="false"
  if [[ -n "$head" && "$head" != "$default_branch" && "$head" != "main" && "$head" != "master" ]]; then
    branch_safe="true"
  fi

  cat <<EOF
merge_safety:
  allowed_scope: $(allowed_scope_for_task "$task_id")
  pr_open: $([[ "$state" == "OPEN" ]] && printf true || printf false)
  not_draft: $([[ "$draft" == "false" ]] && printf true || printf false)
  base_is_main: $([[ "$base" == "$default_branch" ]] && printf true || printf false)
  head_owner_expected_repo: $([[ "$owner" == "$expected_owner" ]] && printf true || printf false)
  exact_safe_branch_identified: $branch_safe
  changed_files_within_allowed_scope: $scope_ok
  worktree_clean: $clean
  repo_guard_and_required_checks_success_latest_head: $guard_ok
  unresolved_review_threads: 확인 필요
  final_codex_no_major_issues_fresh_for_latest_head: 확인 필요
  owner_decision_required_items: 확인 필요
  forbidden_capability_needed: false
  merge_conflicts: 확인 필요
  merge_permitted: false
  stop_condition: blocked_by_validation
  note: MVP evaluates merge gates but does not invoke merge; PR #85 must not auto-merge itself.
EOF

  if [[ -n "$number" && -n "$head_sha" ]]; then
    review_evidence_for_pr "$number" "$head_sha"
  fi
}

decide_cleanup_safety() {
  local pr_json=$1
  local state head current clean branch_merged
  state=$(printf '%s' "$pr_json" | json_get state 2>/dev/null || true)
  head=$(printf '%s' "$pr_json" | json_get headRefName 2>/dev/null || true)
  current=$(current_branch)
  clean="false"
  if worktree_clean; then
    clean="true"
  fi
  branch_merged="확인 필요"
  if [[ -n "$head" ]] && git show-ref --verify --quiet "refs/heads/$head"; then
    if git branch --merged "$default_branch" | sed 's/^[* ]*//' | grep -Fxq "$head"; then
      branch_merged="true"
    else
      branch_merged="false"
    fi
  fi

  cat <<EOF
remote_branch_cleanup_safety:
  pr_merged: $([[ "$state" == "MERGED" ]] && printf true || printf false)
  exact_head_branch_identified: $([[ -n "$head" ]] && printf true || printf false)
  branch_not_default_or_protected: $([[ -n "$head" && "$head" != "$default_branch" && "$head" != "main" && "$head" != "master" ]] && printf true || printf false)
  open_unmerged_branch_ambiguity: 확인 필요
  force_delete_needed: false
  cleanup_permitted: false
  stop_condition: owner_action_required
local_branch_cleanup_safety:
  current_branch: ${current:-unknown}
  can_switch_to_main: $clean
  main_fetch_prune_pull_required_before_cleanup: true
  target_local_branch_merged: $branch_merged
  uses_git_branch_d_only: true
  cleanup_permitted: false
  stop_condition: owner_action_required
EOF
}

decide_compound() {
  local pr_json=$1
  local number
  number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  cat <<EOF
compound_safety:
  latest_or_current_pr: ${number:-unknown}
  trigger_when_review_fix_commits_existed: true
  trigger_when_nontrivial_review_comments_existed: true
  follow_up_pr_allowed_only_for_concrete_narrow_safe_scope: true
  compound_should_run: 확인 필요
  stop_condition: owner_decision_required
EOF
}

run_preflight() {
  local preflight_status="pass"
  local repo_guard="확인 필요"
  local worktree="dirty"
  if worktree_clean; then
    worktree="clean"
  fi
  if bash "$repo_root/scripts/checks/repo-guard.sh" >/dev/null 2>&1; then
    repo_guard="pass"
  else
    repo_guard="halt"
    preflight_status="halt"
  fi

  cat <<EOF
preflight:
  status: $preflight_status
  worktree_status: $worktree
  repo_guard_result: $repo_guard
  no_mutations_performed: true
EOF
}

run_with_pr_json() {
  local task_id=$1
  local pr_json=$2
  local number
  number=$(printf '%s' "$pr_json" | json_get number 2>/dev/null || true)
  if [[ -z "$number" ]]; then
    cat <<'EOF'
pr:
  status: not_found
  stop_condition: owner_action_required
EOF
    return 0
  fi

  print_pr_summary "$pr_json"
  decide_merge_safety "$task_id" "$pr_json"
  decide_cleanup_safety "$pr_json"
  decide_compound "$pr_json"
}

run_task() {
  local task_id=$1
  print_header
  run_preflight
  print_capability_inventory

  if ! gh_available || ! gh_authed || ! gh_api_available; then
    cat <<'EOF'
runner_result:
  status: stopped
  stop_condition: owner_action_required
  evidence_class: local-verified
  reason: gh CLI/API capability is unavailable in this WSL environment.
EOF
    return 0
  fi

  local pr_list pr_json branch
  case "$task_id" in
    current-pr|docs-folderize-operations|review-fix|compound|branch-cleanup)
      branch=$(current_branch)
      pr_list=$(find_current_pr_json "$branch")
      pr_json=$(printf '%s' "$pr_list" | current_pr_or_empty "$branch" "$expected_owner")
      run_with_pr_json "$task_id" "$pr_json"
      ;;
    latest-merged-pr)
      pr_list=$(find_latest_merged_pr_json)
      pr_json=$(printf '%s' "$pr_list" | latest_merged_pr_or_empty "$latest_merged_pr_limit")
      run_with_pr_json "$task_id" "$pr_json"
      ;;
    *)
      printf 'runner_result:\n  status: stopped\n  stop_condition: unknown_task_id\n' >&2
      exit 2
      ;;
  esac
}

while (($# > 0)); do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --list)
      list_tasks
      exit 0
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    --mode)
      (($# >= 2)) || fail_usage
      mode=$2
      case "$mode" in
        assisted|autopilot) ;;
        *) fail_usage ;;
      esac
      shift 2
      ;;
    --*)
      fail_usage
      ;;
    *)
      break
      ;;
  esac
done

(($# == 1)) || fail_usage
task_id=$1
if ! list_tasks | grep -Fxq "$task_id"; then
  printf 'codex_loop_status: failed\n' >&2
  printf 'task_id: %s\n' "$task_id" >&2
  printf 'stop_condition: unknown_task_id\n' >&2
  exit 2
fi

require_repo_root
run_task "$task_id"
