#!/usr/bin/env bash
set -euo pipefail

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)
packet_emitter="$repo_root/scripts/checks/omx-loop-packet.sh"

packet_output=""
packet_exit=0
set +e
packet_output=$(bash "$packet_emitter" 2>&1)
packet_exit=$?
set -e

packet_field() {
  local key=$1
  printf '%s\n' "$packet_output" | awk -v key="$key" '
    index($0, key ": ") == 1 {
      print substr($0, length(key) + 3)
      exit
    }
  '
}

normalize_stop_condition() {
  local value=$1
  case "$value" in
    '""'|""|"none") printf '' ;;
    \"*) printf '%s' "${value#\"}" | sed 's/"$//' ;;
    *) printf '%s' "$value" ;;
  esac
}

safe_value() {
  local value=$1
  local fallback=$2
  if [[ -n "$value" ]]; then
    printf '%s' "$value"
  else
    printf '%s' "$fallback"
  fi
}

repo_path=$(safe_value "$(packet_field "repo_path")" "unknown")
remote_url_sanitized=$(safe_value "$(packet_field "remote_url_sanitized")" "<redacted-remote-url>")
branch=$(safe_value "$(packet_field "branch")" "unknown")
working_tree_status=$(safe_value "$(packet_field "working_tree_status")" "unknown")
omx_version=$(safe_value "$(packet_field "omx_version")" "unavailable")
packet_status=$(safe_value "$(packet_field "checklist_gate_result")" "halt")
evidence_class=$(safe_value "$(packet_field "evidence_class")" "unknown")
next_safe_action=$(safe_value "$(packet_field "next_safe_action")" "report_stop_condition")
no_mutations_performed=$(safe_value "$(packet_field "no_mutations_performed")" "unknown")
warnings=$(safe_value "$(packet_field "warnings")" "[]")
stop_condition=$(normalize_stop_condition "$(packet_field "stop_condition")")

case "$remote_url_sanitized" in
  *://*:*@*|https://*@*|*\?access_token=*|*\&access_token=*|*\?token=*|*\&token=*|*\?api_key=*|*\&api_key=*|*\?apikey=*|*\&apikey=*|*\?password=*|*\&password=*|*\?secret=*|*\&secret=*)
    remote_url_sanitized="<redacted-remote-url>"
    warnings="[handoff redacted credential-like remote URL]"
    stop_condition=${stop_condition:-STOPPED_CREDENTIAL_OR_SECRET_CONTENT}
    packet_status="halt"
    next_safe_action="report_stop_condition"
    ;;
esac

normal_progression="blocked"
normal_progression_reason="stop condition or checklist halt is active"
if [[ -z "$stop_condition" && "$packet_status" == "pass" ]]; then
  normal_progression="allowed"
  normal_progression_reason="normalized packet gate passed"
fi

if [[ "$normal_progression" == "blocked" ]]; then
  next_safe_action="report_stop_condition"
fi

cat <<EOF
OMX PM/section handoff
repo_path: $repo_path
remote_url_sanitized: $remote_url_sanitized
branch: $branch
working_tree_status: $working_tree_status
omx_version: $omx_version
packet_status: $packet_status
stop_condition: ${stop_condition:-none}
normal_progression: $normal_progression
normal_progression_reason: $normal_progression_reason
next_safe_action: $next_safe_action
evidence_class: $evidence_class
warnings: $warnings
no_mutations_performed: $no_mutations_performed
owner_gated_items_preserved: merge; auto-merge; branch cleanup automation; GitHub settings; GitHub secrets; API keys; mutating OMX commands; omx setup; omx doctor; omx explore; omx sparkshell; Codex launch; Zeroshot; Hermes; docs folderization; workflow edits; config edits
handoff_boundary: read-only handoff only; sourced from scripts/checks/omx-loop-packet.sh
EOF

if (( packet_exit != 0 )) || [[ "$normal_progression" == "blocked" ]]; then
  exit 1
fi
