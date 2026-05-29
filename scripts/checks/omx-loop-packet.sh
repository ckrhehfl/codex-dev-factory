#!/usr/bin/env bash
set -euo pipefail

packet_type="omx_loop_status"
packet_version="1"
status_source="omx-status-adapter"
evidence_class="local-verified"
no_mutations_performed="unknown"

warnings="[]"
stop_condition=""
checklist_gate_result="halt"
next_safe_action="report_stop_condition"

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)
adapter_path="$repo_root/scripts/checks/omx-status-adapter.sh"

adapter_output=""
adapter_exit=0
if [[ -f "$adapter_path" ]]; then
  set +e
  adapter_output=$(bash "$adapter_path" 2>&1)
  adapter_exit=$?
  set -e
else
  adapter_exit=1
  adapter_output="stop_condition: STOPPED_VALIDATION_FAILED
warnings: status adapter is unavailable"
fi

adapter_field() {
  local key=$1
  printf '%s\n' "$adapter_output" | awk -v key="$key" '
    index($0, key ": ") == 1 {
      print substr($0, length(key) + 3)
      exit
    }
  '
}

normalize_stop_condition() {
  local value=$1
  case "$value" in
    ""|"none") printf '' ;;
    *) printf '%s' "$value" ;;
  esac
}

normalize_warnings() {
  local value=$1
  case "$value" in
    ""|"none") printf '[]' ;;
    *) printf '[%s]' "$value" ;;
  esac
}

add_warning() {
  local message=$1
  case "$warnings" in
    "[]") warnings="[$message]" ;;
    *) warnings="${warnings%]} ; $message]" ;;
  esac
}

repo_path=$(adapter_field "repo_path")
remote_url_sanitized=$(adapter_field "remote_url")
branch=$(adapter_field "branch")
working_tree_status=$(adapter_field "working_tree_status")
omx_version=$(adapter_field "omx_version")
adapter_warnings=$(adapter_field "warnings")
adapter_stop=$(adapter_field "stop_condition")
adapter_no_mutations=$(adapter_field "no_mutations_performed")

repo_path=${repo_path:-$repo_root}
branch=${branch:-unknown}
working_tree_status=${working_tree_status:-unknown}
omx_version=${omx_version:-unavailable}

warnings=$(normalize_warnings "$adapter_warnings")
stop_condition=$(normalize_stop_condition "$adapter_stop")

if [[ -z "$remote_url_sanitized" ]]; then
  remote_url_sanitized="<redacted-remote-url>"
  warnings="[remote URL sanitization could not be verified]"
  stop_condition=${stop_condition:-STOPPED_REMOTE_URL_SANITIZATION_UNCLEAR}
fi

case "$remote_url_sanitized" in
  *://*:*@*|https://*@*|*\?access_token=*|*\&access_token=*|*\?token=*|*\&token=*|*\?api_key=*|*\&api_key=*|*\?apikey=*|*\&apikey=*|*\?password=*|*\&password=*|*\?secret=*|*\&secret=*)
    remote_url_sanitized="<redacted-remote-url>"
    warnings="[remote URL contained credential-like material]"
    stop_condition=${stop_condition:-STOPPED_REMOTE_URL_SANITIZATION_UNCLEAR}
    ;;
esac

if [[ "$adapter_no_mutations" == "true" ]]; then
  no_mutations_performed="true"
else
  warnings="[adapter did not confirm no_mutations_performed=true]"
  stop_condition=${stop_condition:-STOPPED_VALIDATION_FAILED}
fi

if (( adapter_exit != 0 )) && [[ -z "$stop_condition" ]]; then
  stop_condition="STOPPED_VALIDATION_FAILED"
fi

if [[ "$branch" != "main" ]]; then
  add_warning "current branch is not main; MVP checklist gate would halt"
  stop_condition=${stop_condition:-STOPPED_VALIDATION_FAILED}
fi

if [[ -z "$stop_condition" ]]; then
  checklist_gate_result="pass"
  next_safe_action="continue_bounded_pm_loop"
else
  checklist_gate_result="halt"
  next_safe_action="report_stop_condition"
fi

cat <<EOF
packet_type: $packet_type
packet_version: $packet_version
repo_path: $repo_path
remote_url_sanitized: $remote_url_sanitized
branch: $branch
working_tree_status: $working_tree_status
omx_version: $omx_version
status_source: $status_source
evidence_class: $evidence_class
warnings: $warnings
stop_condition: "$stop_condition"
no_mutations_performed: $no_mutations_performed
checklist_gate_result: $checklist_gate_result
next_safe_action: $next_safe_action
EOF

if [[ -n "$stop_condition" ]]; then
  exit 1
fi
