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

if ! command -v python3 >/dev/null 2>&1; then
  report_failure "python3 is required for text content guard checks"
else
  if ! python3 <<'PY'
import fnmatch
import pathlib
import subprocess
import sys


HIDDEN_CODE_POINTS = {
    0x061C,
    0x00AD,
    0x200B,
    0x200C,
    0x200D,
    0x200E,
    0x200F,
    0x202A,
    0x202B,
    0x202C,
    0x202D,
    0x202E,
    0x2066,
    0x2067,
    0x2068,
    0x2069,
    0xFEFF,
}

TEXT_EXTENSIONS = {
    ".bash",
    ".cfg",
    ".conf",
    ".css",
    ".csv",
    ".editorconfig",
    ".envrc",
    ".gitignore",
    ".html",
    ".ini",
    ".js",
    ".json",
    ".jsx",
    ".md",
    ".py",
    ".sh",
    ".toml",
    ".ts",
    ".tsx",
    ".txt",
    ".yaml",
    ".yml",
}

TEXT_NAMES = {
    ".gitattributes",
    ".gitignore",
    "AGENTS.md",
    "Dockerfile",
    "LICENSE",
    "Makefile",
    "README",
}

CREDENTIAL_PATTERNS = (
    ".env",
    ".env.*",
    "*.key",
    "*.p12",
    "*.pem",
    "*.pfx",
    "id_ed25519",
    "id_rsa",
)


def tracked_entries():
    result = subprocess.run(
        ["git", "ls-files", "-z", "-s"],
        check=True,
        stdout=subprocess.PIPE,
    )
    entries = []
    for record in result.stdout.decode("utf-8").split("\0"):
        if not record:
            continue
        metadata, path = record.split("\t", 1)
        mode = metadata.split(" ", 1)[0]
        entries.append((mode, path))
    return entries


def is_credential_like(path):
    name = pathlib.PurePosixPath(path).name
    return any(fnmatch.fnmatchcase(name, pattern) for pattern in CREDENTIAL_PATTERNS)


def is_text_candidate(path, data):
    if b"\0" in data:
        return False

    pure_path = pathlib.PurePosixPath(path)
    if pure_path.name in TEXT_NAMES or pure_path.suffix.lower() in TEXT_EXTENSIONS:
        return True

    first_line = data.splitlines()[0] if data.splitlines() else b""
    if first_line.startswith(b"#!"):
        return True

    try:
        data.decode("utf-8")
    except UnicodeDecodeError:
        return False
    return True


def line_column(text, index):
    line = text.count("\n", 0, index) + 1
    last_newline = text.rfind("\n", 0, index)
    column = index + 1 if last_newline == -1 else index - last_newline
    return line, column


failures = 0

for mode, path in tracked_entries():
    if mode == "120000":
        continue

    if is_credential_like(path):
        continue

    data = pathlib.Path(path).read_bytes()
    if not is_text_candidate(path, data):
        continue

    crlf_count = data.count(b"\r\n")
    bare_lf_count = data.replace(b"\r\n", b"").count(b"\n")
    if crlf_count and bare_lf_count:
        print(
            "repo-guard: ERROR: mixed line endings in "
            f"{path}: {crlf_count} CRLF line ending(s), "
            f"{bare_lf_count} LF line ending(s)",
            file=sys.stderr,
        )
        failures += 1

    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        continue

    for index, char in enumerate(text):
        code_point = ord(char)
        if code_point in HIDDEN_CODE_POINTS:
            line, column = line_column(text, index)
            print(
                "repo-guard: ERROR: hidden Unicode "
                f"U+{code_point:04X} in {path}:{line}:{column}",
                file=sys.stderr,
            )
            failures += 1

if failures:
    sys.exit(1)
PY
  then
    report_failure "tracked text files must not contain hidden Unicode or mixed line endings"
  fi
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
