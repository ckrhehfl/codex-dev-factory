#!/usr/bin/env bash
set -euo pipefail

expected_remote="git@github.com:ckrhehfl/codex-dev-factory.git"
expected_path_suffix="/codex-dev-factory"

failures=0

report_failure() {
  printf 'omx-loop-mvp: ERROR: %s\n' "$1" >&2
  failures=$((failures + 1))
}

print_stage() {
  printf '  - %s\n' "$1"
}

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
current_path=$(pwd -P)
remote_url=$(git remote get-url origin 2>/dev/null || true)
branch_name=$(git branch --show-current 2>/dev/null || true)
status_short=$(git --no-optional-locks status --short 2>/dev/null || true)
omx_version=$(omx --version 2>/dev/null | head -n 1 || true)

case "$repo_root" in
  *"$expected_path_suffix") ;;
  *) report_failure "repository root must end with $expected_path_suffix; got ${repo_root:-unknown}" ;;
esac

if [[ "$remote_url" != "$expected_remote" ]]; then
  report_failure "origin must be $expected_remote; got ${remote_url:-unknown}"
fi

if [[ -z "$omx_version" ]]; then
  report_failure "omx must be available for the OMX-backed loop contract"
fi

printf 'OMX local loop MVP preflight\n'
printf 'repo_path: %s\n' "${repo_root:-$current_path}"
printf 'remote_url: %s\n' "${remote_url:-unknown}"
printf 'current_branch: %s\n' "${branch_name:-unknown}"
if [[ -z "$status_short" ]]; then
  printf 'working_tree: clean\n'
else
  printf 'working_tree: dirty\n'
fi
printf 'omx_version: %s\n' "${omx_version:-unknown}"
printf 'codex_launch_readiness: cdfcheck\n'
printf 'codex_launch_bounded_work: cdfcodex\n'
printf 'codex_intelligence_default: medium/default\n'
printf '\n'

printf 'Safe local loop checklist:\n'
print_stage "Run cdfcheck for read-only readiness/status checks."
print_stage "Start new work only from a clean tree; finish or discard unrelated local changes first."
print_stage "Sync main with fetch/prune and fast-forward pull before branch work."
print_stage "Create one bounded task branch from clean main."
print_stage "Apply only the approved bounded change."
print_stage "Run local validation, including repo guard when applicable."
print_stage "Commit and push only after validation and self-review pass."
print_stage "Open a PR with validation, owner gates, non-goals, and confirmations."
print_stage "Use the review-fix loop only for in-scope review comments."
print_stage "Do post-merge branch cleanup manually only after owner approval."
print_stage "Run Compound triage only when review fixes produced a durable lesson."
printf '\n'

printf 'Stop instead of continuing when:\n'
print_stage "High or xhigh Codex Intelligence appears necessary."
print_stage "GitHub settings, rulesets, required checks, Actions permissions, secrets, API keys, or repository permissions are required."
print_stage "An OMX command would mutate setup, state, config, tasks, teams, plans, logs, or runtime behavior."
print_stage "The task asks for Zeroshot, Hermes, docs folderization, auto-merge, branch cleanup automation, sandbox/runtime changes, or a broad automation engine."
print_stage "Scope requires more than the approved files, risk tier, or owner gates."
printf '\n'

printf 'Current MVP boundary:\n'
print_stage "This script is a dry-run/checklist helper only."
print_stage "It does not run omx setup, omx doctor, omx explore, omx sparkshell, Codex, git writes, GitHub writes, or cleanup."
print_stage "Future safe integration point: replace checklist-only status with a reviewed, read-only OMX status adapter once its command contract is approved."

if (( failures > 0 )); then
  printf '\nomx-loop-mvp: failed with %d violation(s)\n' "$failures" >&2
  exit 1
fi

printf '\nomx-loop-mvp: passed\n'
