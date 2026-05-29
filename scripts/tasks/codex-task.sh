#!/usr/bin/env bash
set -euo pipefail

script_path=${BASH_SOURCE[0]}
script_dir=$(cd -- "$(dirname -- "$script_path")" && pwd -P)
repo_root=$(cd -- "$script_dir/../.." && pwd -P)
template_dir="$repo_root/docs/prompts/codex"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/tasks/codex-task.sh --help
  bash scripts/tasks/codex-task.sh --list
  bash scripts/tasks/codex-task.sh <task-id>

Known task IDs:
  docs-folderize-operations
  review-fix
  compound
  branch-cleanup

Behavior:
  Generates a repo-local Codex prompt packet for owner review.
  Prints the prompt by default.
  Copies the prompt to the Windows clipboard when clip.exe is available.
  Does not mutate repository files, merge PRs, delete branches, change GitHub settings,
  inspect secrets, run mutating OMX commands, or launch Codex directly.
EOF
}

list_tasks() {
  cat <<'EOF'
docs-folderize-operations
review-fix
compound
branch-cleanup
EOF
}

loop_contract_for() {
  case "$1" in
    docs-folderize-operations)
      printf 'preflight-first docs folderization planning loop'
      ;;
    review-fix)
      printf 'fixed review-fix loop contract'
      ;;
    compound)
      printf 'post-merge Compound lesson capture loop'
      ;;
    branch-cleanup)
      printf 'owner-gated branch cleanup loop'
      ;;
    *)
      return 1
      ;;
  esac
}

template_for() {
  case "$1" in
    docs-folderize-operations|review-fix|compound|branch-cleanup)
      printf '%s/%s.md' "$template_dir" "$1"
      ;;
    *)
      return 1
      ;;
  esac
}

fail_unknown_task() {
  local task_id=$1

  {
    printf 'codex_task_launcher_status: failed\n'
    printf 'task_id: %s\n' "$task_id"
    printf 'stop_condition: unknown_task_id\n'
    printf 'valid_task_ids:\n'
    list_tasks | sed 's/^/  - /'
  } >&2
  exit 2
}

copy_to_clipboard_if_available() {
  local prompt_file=$1

  if command -v clip.exe >/dev/null 2>&1; then
    if clip.exe <"$prompt_file"; then
      printf 'clipboard_status: copied_with_clip.exe\n'
      return 0
    fi

    printf 'clipboard_status: copy_failed\n'
    return 1
  fi

  printf 'clipboard_status: unavailable\n'
  return 1
}

if (($# != 1)); then
  usage >&2
  exit 2
fi

case "$1" in
  --help|-h)
    usage
    exit 0
    ;;
  --list)
    list_tasks
    exit 0
    ;;
esac

task_id=$1
if ! prompt_template=$(template_for "$task_id"); then
  fail_unknown_task "$task_id"
fi
if ! loop_contract=$(loop_contract_for "$task_id"); then
  fail_unknown_task "$task_id"
fi
if [[ ! -f "$prompt_template" ]]; then
  printf 'codex_task_launcher_status: failed\n' >&2
  printf 'task_id: %s\n' "$task_id" >&2
  printf 'prompt_template: %s\n' "$prompt_template" >&2
  printf 'stop_condition: prompt_template_missing\n' >&2
  exit 1
fi

launch_mode="print_only"
clipboard_status=$(copy_to_clipboard_if_available "$prompt_template" || true)
if [[ "$clipboard_status" == "clipboard_status: copied_with_clip.exe" ]]; then
  launch_mode="clipboard"
fi

cat <<EOF
codex_task_launcher_status: ready
task_id: $task_id
prompt_template: ${prompt_template#"$repo_root/"}
launch_mode: $launch_mode
intended_loop_contract: $loop_contract
stop_condition: owner_reviews_prompt_before_launch
$clipboard_status
direct_launch_status: unsupported_by_this_helper
no_mutations_performed: true

--- BEGIN CODEX PROMPT ---
EOF

cat "$prompt_template"

cat <<'EOF'
--- END CODEX PROMPT ---
EOF
