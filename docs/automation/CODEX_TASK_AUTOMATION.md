# Codex Task Automation

This repository includes a small owner-facing prompt packet helper:

```bash
bash scripts/tasks/codex-task.sh <task-id>
```

The helper reduces repeated PM/Codex prompt copy-paste by generating stable prompt packets from repo-local templates under `docs/prompts/codex/`.

## Supported Task IDs

- `docs-folderize-operations`
- `review-fix`
- `compound`
- `branch-cleanup`

Use:

```bash
bash scripts/tasks/codex-task.sh --list
```

## Safety Boundary

The helper is read-only with respect to repository files. It prints the selected prompt packet for owner review and copies it to the Windows clipboard when `clip.exe` is available from WSL.

It does not:

- mutate repository files
- launch Codex directly
- merge PRs
- delete branches
- change GitHub settings, rulesets, branch protection, or permissions
- inspect secrets, credentials, auth files, tokens, or cookies
- run mutating OMX commands
- require `jq`, `gh`, npm packages, network setup, API keys, or new dependencies

Direct Codex launch is intentionally unsupported by this helper even though local `codex --help` shows a `[PROMPT]` positional argument and an `exec` subcommand. Prompt generation and optional clipboard copy keep owner review as the explicit launch gate.

## Default Gate

Each generated task packet instructs Codex to run:

```bash
bash scripts/checks/codex-task-preflight.sh
```

The canonical preflight and fixed-loop contracts remain in:

- `docs/operations/CODEX_TASK_PREFLIGHT.md`
- `docs/operations/CODEX_FIXED_LOOP_CONTRACTS.md`
- `docs/operations/TASK_LIFECYCLE.md`
- `docs/operations/TASK_CONTRACT.md`
- `docs/operations/PR_METADATA_GUARD.md`

## Stop Condition

The launcher reports:

```text
stop_condition: owner_reviews_prompt_before_launch
```

The generated prompt still carries the standard high/xhigh intelligence stop rule and owner gates. PR merge and branch cleanup remain owner-gated/manual.
