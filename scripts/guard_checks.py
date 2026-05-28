#!/usr/bin/env python3
"""Repository-native guard checks for low-risk Codex automation PRs."""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
import unicodedata
from pathlib import Path
from urllib.parse import unquote


TEXT_SUFFIXES = {".md", ".py", ".ps1", ".yml", ".yaml", ".txt"}
MARKDOWN_SUFFIXES = {".md"}
WORKFLOW_SUFFIXES = {".yml", ".yaml"}
PROTECTED_BRANCHES = {"main", "master", "develop"}
AUTOMATION_BRANCH_PREFIX = "automation/"

ALLOWED_AUTOMATION_PATHS = (
    "README.md",
    "AGENTS.md",
    "docs/",
    "scripts/",
    ".github/workflows/",
)

FORBIDDEN_EXECUTABLE_PATTERNS = (
    ("codex_execution", re.compile(r"\b(openai/" + r"codex-action|codex(\.cmd|\.exe)?\s+(exec|run|login|auth|mcp|app|cloud))\b", re.I)),
    ("omx_execution", re.compile(r"\bomx(\.cmd|\.exe)?\s+(setup|doctor|team|exec|run|resume|hud|ralph|explore)\b", re.I)),
    ("hermes_execution", re.compile(r"\bhermes(\.cmd|\.exe)?\s+", re.I)),
    ("wsl_execution", re.compile(r"\bwsl(\.exe)?\b", re.I)),
    ("api_key_reference", re.compile(r"\b(" + "OPENAI" + r"_API_KEY|secrets\." + "OPENAI" + r"_API_KEY)\b", re.I)),
    ("github_secret_reference", re.compile(r"\bsecrets\." + r"[A-Z0-9_]+\b")),
    ("auto_merge_command", re.compile(r"\bgh\s+pr\s+merge\b.*\b(--auto|--merge|--squash|--rebase)\b", re.I)),
    ("force_delete_branch", re.compile(r"\bgit\s+branch\s+-D\b", re.I)),
    ("force_push", re.compile(r"\bgit\s+push\b.*\b(--force|-f)\b", re.I)),
)

MARKDOWN_LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")


def run_git(args: list[str]) -> str:
    completed = subprocess.run(
        ["git", *args],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return completed.stdout.strip()


def normalize_path(path: str) -> str:
    normalized = path.replace("\\", "/")
    if normalized.startswith("./"):
        return normalized[2:]
    return normalized


def get_changed_files(base_ref: str | None, head_ref: str, explicit: list[str]) -> list[str]:
    if explicit:
        return sorted({normalize_path(path) for path in explicit if path.strip()})

    diff_args = ["diff", "--name-only"]
    if base_ref:
        diff_args.append(f"{base_ref}...{head_ref}")
    else:
        diff_args.append("HEAD~1..HEAD")

    output = run_git(diff_args)
    return sorted({normalize_path(line) for line in output.splitlines() if line.strip()})


def is_protected_branch(branch: str) -> bool:
    return branch in PROTECTED_BRANCHES or branch.startswith("release/")


def is_allowed_automation_path(path: str) -> bool:
    if path in ALLOWED_AUTOMATION_PATHS:
        return True
    return any(path.startswith(prefix) for prefix in ALLOWED_AUTOMATION_PATHS if prefix.endswith("/"))


def is_warning_class(ch: str) -> bool:
    cp = ord(ch)
    category = unicodedata.category(ch)
    return (
        0x202A <= cp <= 0x202E
        or 0x2066 <= cp <= 0x2069
        or cp in {0x200B, 0x200C, 0x200D, 0x200E, 0x200F, 0xFEFF}
        or 0xE0000 <= cp <= 0xE007F
        or (category in {"Cf", "Cc"} and ch != "\t")
    )


def check_unicode(paths: list[str]) -> list[str]:
    failures: list[str] = []
    for path_text in paths:
        path = Path(path_text)
        if path.suffix.lower() not in TEXT_SUFFIXES or not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        for line_no, line in enumerate(text.splitlines(), 1):
            for col, ch in enumerate(line, 1):
                if is_warning_class(ch):
                    cp = ord(ch)
                    name = unicodedata.name(ch, "<unnamed>")
                    category = unicodedata.category(ch)
                    failures.append(f"{path_text}:{line_no}:{col}: U+{cp:04X} {name} {category}")
    return failures


def split_link_target(target: str) -> str:
    target = target.strip().strip("<>")
    if not target:
        return target
    if target[0] in {"'", '"'}:
        return target
    return target.split()[0]


def check_markdown_links(paths: list[str]) -> list[str]:
    failures: list[str] = []
    for path_text in paths:
        path = Path(path_text)
        if path.suffix.lower() not in MARKDOWN_SUFFIXES or not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        for line_no, line in enumerate(text.splitlines(), 1):
            for match in MARKDOWN_LINK_RE.finditer(line):
                target = split_link_target(match.group(1))
                if not target or target.startswith("#"):
                    continue
                lowered = target.lower()
                if re.match(r"^[a-z][a-z0-9+.-]*:", lowered):
                    continue
                target_path = unquote(target.split("#", 1)[0])
                if not target_path:
                    continue
                resolved = (path.parent / target_path).resolve()
                repo_root = Path.cwd().resolve()
                try:
                    resolved.relative_to(repo_root)
                except ValueError:
                    failures.append(f"{path_text}:{line_no}: link escapes repo: {target}")
                    continue
                if not resolved.exists():
                    failures.append(f"{path_text}:{line_no}: missing local link target: {target}")
    return failures


def check_allowed_files(branch: str, paths: list[str]) -> list[str]:
    if not branch.startswith(AUTOMATION_BRANCH_PREFIX):
        return []
    if is_protected_branch(branch):
        return [f"automation guard refused protected branch: {branch}"]
    return [path for path in paths if not is_allowed_automation_path(path)]


def check_forbidden_executable_text(paths: list[str]) -> list[str]:
    failures: list[str] = []
    for path_text in paths:
        path = Path(path_text)
        if not path.exists():
            continue
        path_norm = normalize_path(path_text)
        is_executable_surface = path_norm.startswith("scripts/") or path_norm.startswith(".github/workflows/")
        if not is_executable_surface:
            continue
        if path.suffix.lower() not in TEXT_SUFFIXES | WORKFLOW_SUFFIXES:
            continue
        text = path.read_text(encoding="utf-8")
        for line_no, line in enumerate(text.splitlines(), 1):
            for name, pattern in FORBIDDEN_EXECUTABLE_PATTERNS:
                if pattern.search(line):
                    failures.append(f"{path_text}:{line_no}: forbidden executable surface pattern: {name}")
    return failures


def print_section(title: str, rows: list[str]) -> None:
    print(f"## {title}")
    if rows:
        for row in rows:
            print(f"- {row}")
    else:
        print("- none")


def main() -> int:
    parser = argparse.ArgumentParser(description="Run Codex automation guard checks.")
    parser.add_argument("--base-ref", default=None, help="Base ref for changed-file detection.")
    parser.add_argument("--head-ref", default="HEAD", help="Head ref for changed-file detection.")
    parser.add_argument("--branch", default=os.environ.get("GITHUB_HEAD_REF") or os.environ.get("GITHUB_REF_NAME") or "")
    parser.add_argument("--changed-file", action="append", default=[], help="Explicit changed file path. May be repeated.")
    args = parser.parse_args()

    branch = args.branch or run_git(["branch", "--show-current"])
    changed_files = get_changed_files(args.base_ref, args.head_ref, args.changed_file)

    failures: list[str] = []
    allowed_failures = check_allowed_files(branch, changed_files)
    unicode_failures = check_unicode(changed_files)
    link_failures = check_markdown_links(changed_files)
    forbidden_failures = check_forbidden_executable_text(changed_files)

    print(f"branch: {branch}")
    print_section("Changed Files", changed_files)
    print_section("Allowed Files Failures", allowed_failures)
    print_section("Warning-Class Unicode Failures", unicode_failures)
    print_section("Markdown Link Failures", link_failures)
    print_section("Forbidden Executable Text Failures", forbidden_failures)

    failures.extend(f"allowed-files: {item}" for item in allowed_failures)
    failures.extend(f"unicode: {item}" for item in unicode_failures)
    failures.extend(f"markdown-link: {item}" for item in link_failures)
    failures.extend(f"forbidden-action: {item}" for item in forbidden_failures)

    if failures:
        print_section("Guard Result", ["failed", *failures])
        return 1

    print_section("Guard Result", ["passed"])
    return 0


if __name__ == "__main__":
    sys.exit(main())
