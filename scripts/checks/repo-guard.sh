#!/usr/bin/env bash
set -euo pipefail

failures=0

report_failure() {
  printf 'repo-guard: ERROR: %s\n' "$1" >&2
  failures=$((failures + 1))
}

if ! awk '{ sub(/\r$/, ""); if ($0 == ".omx/") found=1 } END { exit found ? 0 : 1 }' .gitignore; then
  report_failure ".gitignore must contain a root .omx/ ignore entry"
fi

if git ls-files --error-unmatch '.omx/*' >/dev/null 2>&1; then
  report_failure "tracked .omx/ files are not allowed"
fi

while IFS= read -r -d '' path; do
  name=${path##*/}

  case "$name" in
    .env|.env.*|*.pem|*.key|*.p12|*.pfx|id_rsa|id_ed25519)
      report_failure "tracked credential-like file path is not allowed: $path"
      ;;
  esac
done < <(git ls-files -z)

if (( failures > 0 )); then
  printf 'repo-guard: failed with %d violation(s)\n' "$failures" >&2
  exit 1
fi

printf 'repo-guard: passed\n'
