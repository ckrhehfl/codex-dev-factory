# OMX Local Loop MVP

## Purpose

This MVP gives the owner and PM a repeatable local checklist for bounded Codex tasks while keeping existing owner gates intact.

It is OMX-backed by the read-only status adapter: local OMX availability is checked through `scripts/checks/omx-status-adapter.sh`, whose only approved OMX discovery command is `omx --version`. This MVP does not run OMX setup, doctor, explore, sparkshell, task, team, or runtime commands.

## Operator Flow

1. Run `cdfcheck` for read-only readiness or status checks.
2. Start bounded work with `cdfcodex` after readiness passes.
3. Keep Codex Intelligence at `medium/default`.
4. Sync clean `main` with fetch/prune and fast-forward pull.
5. Create one bounded task branch.
6. Apply the approved change only.
7. Run local validation, including `bash scripts/checks/repo-guard.sh` when applicable.
8. Commit and push only after validation and self-review pass.
9. Open a PR with validation evidence, owner gates, non-goals, and confirmations.
10. Use the review-fix loop only for in-scope review comments.
11. After merge, perform branch cleanup manually only when the owner requests it.
12. Run Compound triage only when review fixes produced a durable lesson.

## Dry-Run Helper

Run:

```bash
bash scripts/checks/omx-loop-mvp.sh
```

The helper first runs:

```bash
bash scripts/checks/omx-status-adapter.sh
```

If the status adapter reports a stop condition or fails, the helper stops before printing the checklist.

The adapter verifies or reports:

- The repository root resolves to `codex-dev-factory`.
- `origin` is `git@github.com:ckrhehfl/codex-dev-factory.git` or `https://github.com/ckrhehfl/codex-dev-factory.git`.
- Whether the working tree is clean.
- `omx --version` is available.

The helper then prints the safe loop checklist. It does not create branches, modify files, commit, push, open PRs, run Codex, run OMX workflows, merge, auto-merge, or clean branches.

## Stop Conditions

Stop and report instead of continuing when:

- High or xhigh Codex Intelligence appears necessary.
- GitHub settings, rulesets, required checks, Actions permissions, secrets, API keys, or repository permissions are required.
- An OMX command would mutate setup, state, config, tasks, teams, plans, logs, or runtime behavior.
- The task asks for Zeroshot, Hermes, docs folderization, auto-merge, branch cleanup automation, sandbox/runtime changes, or a broad automation engine.
- Scope requires files, risk, or owner gates beyond the approved task contract.

## Current Boundary

This MVP is a small dry-run/checklist scaffold. It is not a scheduler, autonomous merge loop, branch cleanup tool, Zeroshot integration, Hermes integration, docs folderization step, or custom automation engine.

Any future OMX integration point still requires a separate reviewed task and an approved read-only command contract before any command beyond `omx --version` is used.
