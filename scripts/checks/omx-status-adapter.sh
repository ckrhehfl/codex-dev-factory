#!/usr/bin/env bash
set -euo pipefail

adapter_name="omx-status-adapter"
adapter_version="0.1.0"
expected_repo_path_suffix="/codex-dev-factory"
expected_remote_ssh="git@github.com:ckrhehfl/codex-dev-factory.git"
expected_remote_https="https://github.com/ckrhehfl/codex-dev-factory.git"

warnings="none"
stop_condition="none"
exit_code=0

add_warning() {
  if [[ "$warnings" == "none" ]]; then
    warnings="$1"
  else
    warnings="$warnings; $1"
  fi
}

set_stop() {
  if [[ "$stop_condition" == "none" ]]; then
    stop_condition="$1"
    exit_code=1
  fi
}

sanitize_remote_url() {
  local raw_remote_url=$1

  case "$raw_remote_url" in
    "$expected_remote_ssh"|"$expected_remote_https")
      remote_url="$raw_remote_url"
      return 0
      ;;
    *://*:*@*)
      remote_url="<redacted-remote-url>"
      add_warning "origin URL contains credential-like userinfo and was redacted"
      set_stop "STOPPED_CREDENTIAL_OR_SECRET_CONTENT"
      return 0
      ;;
    https://*@*)
      remote_url="<redacted-remote-url>"
      add_warning "origin URL contains HTTPS userinfo and was redacted"
      set_stop "STOPPED_CREDENTIAL_OR_SECRET_CONTENT"
      return 0
      ;;
    git@github.com:ckrhehfl/codex-dev-factory.git)
      remote_url="$raw_remote_url"
      return 0
      ;;
    https://github.com/ckrhehfl/codex-dev-factory.git)
      remote_url="$raw_remote_url"
      return 0
      ;;
    "")
      remote_url="unknown"
      add_warning "origin URL is unavailable"
      set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR"
      return 0
      ;;
    *)
      remote_url="<redacted-remote-url>"
      add_warning "origin URL is not an approved canonical repository URL"
      set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR"
      return 0
      ;;
  esac
}

repo_path=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [[ -z "$repo_path" ]]; then
  repo_path=$(pwd -P)
  add_warning "repository root could not be resolved by git"
  set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR"
fi

remote_url_raw=$(git remote get-url origin 2>/dev/null || true)
remote_url="unknown"
sanitize_remote_url "$remote_url_raw"

branch=$(git branch --show-current 2>/dev/null || true)
if [[ -z "$branch" ]]; then
  branch="unknown"
  add_warning "current branch is unavailable"
  set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR"
fi

status_short=$(git --no-optional-locks status --short --branch --untracked-files=all 2>/dev/null || true)
working_tree_lines=$(printf '%s\n' "$status_short" | sed '1d')
if [[ -z "$status_short" ]]; then
  working_tree_status="unknown"
  add_warning "working tree status is unavailable"
  set_stop "STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD"
elif [[ -z "$working_tree_lines" ]]; then
  working_tree_status="clean"
else
  working_tree_status="dirty"
  add_warning "working tree has local changes; reported as status only"
fi

case "$repo_path" in
  *"$expected_repo_path_suffix") ;;
  *)
    add_warning "repository path does not resolve to codex-dev-factory"
    set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR"
    ;;
esac

case "$remote_url_raw" in
  "$expected_remote_ssh"|"$expected_remote_https") ;;
  *://*:*@*|https://*@*) ;;
  *) set_stop "STOPPED_SOURCE_OF_TRUTH_UNCLEAR" ;;
esac

omx_version=$(omx --version 2>/dev/null | sed -n '1p' || true)
if [[ -z "$omx_version" ]]; then
  omx_version="unavailable"
  add_warning "omx --version is unavailable"
  set_stop "STOPPED_OWNER_DECISION_REQUIRED"
fi

detected_omx_mode_scope="unavailable"

if [[ "$stop_condition" == "none" && "$working_tree_status" == "clean" ]]; then
  evidence_class="local-verified"
elif [[ "$stop_condition" == "none" ]]; then
  evidence_class="local-observed"
else
  evidence_class="local-verified-with-stop"
fi

cat <<EOF
adapter_name: $adapter_name
adapter_version: $adapter_version
repo_path: $repo_path
remote_url: $remote_url
branch: $branch
working_tree_status: $working_tree_status
omx_version: $omx_version
detected_omx_mode_scope: $detected_omx_mode_scope
status_source: git rev-parse --show-toplevel; git remote get-url origin; git branch --show-current; git --no-optional-locks status --short --branch --untracked-files=all; omx --version
evidence_class: $evidence_class
warnings: $warnings
stop_condition: $stop_condition
no_mutations_performed: true
EOF

exit "$exit_code"
