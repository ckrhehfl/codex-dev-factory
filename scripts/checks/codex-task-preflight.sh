#!/usr/bin/env bash
set -euo pipefail

expected_repo_name="codex-dev-factory"
expected_branch="main"
expected_remote_ssh="git@github.com:ckrhehfl/codex-dev-factory.git"
expected_remote_https="https://github.com/ckrhehfl/codex-dev-factory.git"

status="pass"
stop_condition="none"

set_halt() {
  if [[ "$status" == "pass" ]]; then
    status="halt"
    stop_condition="$1"
  fi
}

sanitize_remote_url() {
  local raw=$1

  case "$raw" in
    "$expected_remote_ssh"|"$expected_remote_https")
      printf '%s' "$raw"
      ;;
    "")
      printf 'unknown'
      ;;
    *://*:*@*|https://*@*|*\?access_token=*|*\&access_token=*|*\?token=*|*\&token=*|*\?api_key=*|*\&api_key=*|*\?apikey=*|*\&apikey=*|*\?password=*|*\&password=*|*\?secret=*|*\&secret=*)
      printf '<redacted-remote-url>'
      ;;
    *)
      printf '<redacted-remote-url>'
      ;;
  esac
}

command_first_line() {
  local fallback=$1
  shift

  local output
  if output=$("$@" 2>/dev/null); then
    printf '%s\n' "$output" | sed -n '1p'
  else
    printf '%s' "$fallback"
  fi
}

run_gate() {
  local command_label=$1
  shift

  local output
  local exit_code
  set +e
  output=$("$@" 2>&1)
  exit_code=$?
  set -e

  if (( exit_code == 0 )); then
    printf 'pass'
  else
    printf 'halt'
  fi
}

repo_path=$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)
repo_name=${repo_path##*/}
if [[ "$repo_name" != "$expected_repo_name" ]]; then
  set_halt "repo_path_mismatch"
fi

remote_url_raw=$(git remote get-url origin 2>/dev/null || true)
remote_url_sanitized=$(sanitize_remote_url "$remote_url_raw")
if [[ "$remote_url_raw" != "$expected_remote_ssh" && "$remote_url_raw" != "$expected_remote_https" ]]; then
  set_halt "remote_url_unexpected"
fi
if [[ "$remote_url_sanitized" == "<redacted-remote-url>" ]]; then
  set_halt "remote_url_redacted"
fi

branch=$(git branch --show-current 2>/dev/null || true)
branch=${branch:-unknown}
if [[ "$branch" != "$expected_branch" ]]; then
  set_halt "branch_not_main"
fi

status_short=$(git --no-optional-locks status --short --branch --untracked-files=all 2>/dev/null || true)
status_header=$(printf '%s\n' "$status_short" | sed -n '1p')
status_body=$(printf '%s\n' "$status_short" | sed '1d')
if [[ -z "$status_short" ]]; then
  working_tree_status="unknown"
  set_halt "working_tree_status_unavailable"
elif [[ -n "$status_body" ]]; then
  working_tree_status="dirty"
  set_halt "working_tree_dirty"
else
  working_tree_status="clean"
fi

if [[ "$branch" == "$expected_branch" ]]; then
  if [[ "$status_header" != "## main...origin/main" ]]; then
    set_halt "main_not_synced_looking_with_origin_main"
  else
    local_main=$(git rev-parse main 2>/dev/null || true)
    origin_main=$(git rev-parse origin/main 2>/dev/null || true)
    if [[ -z "$local_main" || -z "$origin_main" || "$local_main" != "$origin_main" ]]; then
      set_halt "main_not_synced_looking_with_origin_main"
    fi
  fi
fi

git_config_autocrlf=$(git config --local --get core.autocrlf 2>/dev/null || true)
git_config_autocrlf=${git_config_autocrlf:-unset}
if [[ "$git_config_autocrlf" != "true" ]]; then
  set_halt "git_config_autocrlf_not_true"
fi

git_config_filemode=$(git config --local --get core.filemode 2>/dev/null || true)
git_config_filemode=${git_config_filemode:-unset}
if [[ "$git_config_filemode" != "false" ]]; then
  set_halt "git_config_filemode_not_false"
fi

node_version=$(command_first_line "unavailable" node --version)
if [[ "$node_version" == "unavailable" ]]; then
  set_halt "node_unavailable"
fi

npm_version=$(command_first_line "unavailable" npm --version)
if [[ "$npm_version" == "unavailable" ]]; then
  set_halt "npm_unavailable"
fi

codex_version=$(command_first_line "unavailable" codex --version)
if [[ "$codex_version" == "unavailable" ]]; then
  set_halt "codex_unavailable"
fi

omx_version=$(command_first_line "unavailable" omx --version)
if [[ "$omx_version" == "unavailable" ]]; then
  set_halt "omx_unavailable"
fi

omx_state_ignore_output=$(git check-ignore -v .omx/state 2>/dev/null || true)
if [[ -n "$omx_state_ignore_output" ]]; then
  omx_state_ignore_result="pass"
else
  omx_state_ignore_result="halt"
  set_halt "omx_state_not_ignored"
fi

repo_guard_result=$(run_gate "repo guard" bash "$repo_path/scripts/checks/repo-guard.sh")
if [[ "$repo_guard_result" != "pass" ]]; then
  set_halt "repo_guard_failed"
fi

omx_handoff_result=$(run_gate "omx handoff" bash "$repo_path/scripts/checks/omx-loop-handoff.sh")
if [[ "$omx_handoff_result" != "pass" && "$stop_condition" == "none" ]]; then
  set_halt "omx_handoff_failed"
fi

cat <<EOF
codex_task_preflight_status: $status
stop_condition: $stop_condition
repo_path: $repo_path
remote_url_sanitized: $remote_url_sanitized
branch: $branch
working_tree_status: $working_tree_status
git_config_autocrlf: $git_config_autocrlf
git_config_filemode: $git_config_filemode
node_version: $node_version
npm_version: $npm_version
codex_version: $codex_version
omx_version: $omx_version
omx_state_ignore_result: $omx_state_ignore_result
repo_guard_result: $repo_guard_result
omx_handoff_result: $omx_handoff_result
no_mutations_performed: true
EOF

if [[ "$status" == "pass" ]]; then
  exit 0
fi

exit 1
