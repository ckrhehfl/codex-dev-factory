# Hermes Runtime Evaluation Plan

## Status

| Field | Value |
| --- | --- |
| Decision | `Option 2 — Conditional Hermes-first` |
| Phase | Runtime/orchestrator evaluation planning |
| Implementation status | `not_started` |
| Risk tier | Low-risk docs-only while this PR remains documentation-only |
| Source classification | Deep Research/input-derived evaluation plan, not production adoption |
| Source of truth after merge | This repository's merged documentation |

This document records Hermes as the first runtime/orchestrator evaluation track. It does not adopt Hermes as the production authority plane, install Hermes, run Hermes, connect a Codex runtime, execute a Codex worker, modify the sandbox repository, create workflows, change GitHub settings, add credentials, implement a publisher, implement cleanup automation, delete branches, mutate worktrees, enable auto-merge, set up Docker/VPS/Continue/MCP, or touch trading systems.

Deep Research reports are source input only. They may inform this evaluation plan, but they are not repository source of truth by themselves.

## Purpose

This plan records Hermes as the first runtime/orchestrator evaluation track while preserving Codex as the primary patch-producing coding worker candidate.

It preserves `codex-dev-factory` as the governance and control-plane repository responsible for source-of-truth discipline, task contracts, stop states, evidence, PR lifecycle policy, owner gates, allowed files, forbidden actions, and risk boundaries.

The purpose is to prevent premature runtime adoption or authority-plane delegation. Hermes may be evaluated for runtime and orchestration value, but this plan does not grant Hermes GitHub write authority, cleanup authority, branch deletion authority, auto-merge authority, credentials authority, production worker authority, or control-plane replacement authority.

## Baseline Preserved From The Codex-First Direction

The Codex-first baseline remains preserved:

- Codex remains the primary patch-producing and coding worker candidate.
- `codex-dev-factory` remains the governance/control-plane for task contracts, stop states, source-of-truth discipline, evidence classification, PR lifecycle, owner gates, and policy surfaces.
- Deterministic guards, allowed files, forbidden files, forbidden actions, risk tiering, validation plans, and evidence classification remain control-plane responsibilities.
- GitHub write authority remains outside Hermes until separately approved and validated.
- Cleanup, merge, branch deletion, auto-merge, GitHub settings, rulesets, required checks, credentials, and secrets remain outside Hermes until separately approved and validated.
- Sandbox validation remains required before any runtime or worker execution path is treated as ready.
- Trading repository, live trading, risk cap, exchange credential, and model promotion boundaries remain forbidden unless a separate high-risk owner-approved task changes that scope.

This plan does not weaken [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md), [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md), [Risk Policy](RISK_POLICY.md), or [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md).

## Hermes Responsibility Candidates For Evaluation Only

Hermes is a candidate for evaluating these runtime/orchestrator responsibilities:

- Scheduler or cron.
- Kanban, goal, or task board.
- Subagent orchestration.
- Worktree and session management.
- Profiles.
- Memory and skills.
- Terminal backend.
- API or gateway surface.
- Runtime wrapping.
- Status aggregation.

These are evaluation candidates, not delegated production responsibilities. A future evaluation may test whether Hermes can help with these surfaces, but this document does not approve Hermes to operate them in production or to own their authority boundaries.

## Responsibilities Not Delegated To Hermes

The following responsibilities remain under the control-plane and are not delegated to Hermes by this plan:

- Task contracts.
- Allowed files and forbidden files.
- Forbidden actions.
- Owner gates.
- Stop-state registry.
- Risk tiering.
- Evidence classification.
- Source-of-truth discipline.
- PR lifecycle policy.
- Review-fix loop policy.
- Merge authority separation.
- Auto-merge eligibility.
- Cleanup policy.
- Stale branch reporting.
- Credentials and secrets boundary.
- Sandbox validation.
- Trading boundary.
- GitHub settings, rulesets, required checks, branch protection, and checks authority.

Hermes may report useful runtime state in a future evaluation, but control-plane docs and validated evidence remain the project source-of-truth surfaces.

## Sandbox-Only Validation Questions

Future Hermes evaluation must answer these questions in sandbox-only, owner-approved tasks before any adoption decision:

- Does Hermes worktree/session behavior satisfy repo, path, and remote identity requirements?
- Can Hermes and Codex instruction layers be made deterministic enough for this control-plane's task contract and safety-field requirements?
- Can `CODEX_HOME` or an equivalent runtime state root be isolated per profile, task, or evaluation run?
- Can Hermes status outputs map cleanly to [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md), [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), and evidence classification surfaces?
- Can Codex remain the patch-producing worker while Hermes remains only the orchestrator/runtime wrapper?
- Does Hermes introduce hidden authority, memory, profile, credential, terminal, or approval risks?
- Can all GitHub write authority stay outside Hermes?
- Can cleanup, branch deletion, worktree deletion, and worktree pruning remain outside Hermes?
- Can Hermes be evaluated without modifying the sandbox until the owner explicitly approves a sandbox task?
- Can Hermes be evaluated without GitHub settings, rulesets, required checks, secrets, workflows, Docker/VPS setup, or publisher authority changes?

Any answer that requires installation, execution, sandbox mutation, credentials, GitHub settings changes, workflow changes, publisher behavior, cleanup, branch deletion, or worktree mutation is a separate owner-gated task.

## Owner Gates

Explicit owner approval is required before:

- Hermes evaluation execution.
- Hermes installation.
- Hermes configuration or profile creation.
- Codex runtime path selection.
- Codex runtime connection.
- Codex worker execution.
- Sandbox validation.
- Sandbox repository modification.
- Publisher authority.
- Cleanup authority.
- Branch deletion authority.
- Worktree creation, deletion, pruning, cleaning, or mutation.
- GitHub settings, branch protection, rulesets, required checks, Actions, or secrets changes.
- Credentials, secrets, tokens, API keys, or account configuration.
- Auto-merge eligibility.
- Docker, VPS, Continue, MCP, or other runtime/tooling setup.
- Trading boundary changes.

The owner may approve a later sandbox-only evaluation task, but this plan does not provide that approval by itself.

## Stop Conditions

Stop and report if a task using this plan requires:

- Hermes installation.
- Hermes execution.
- Hermes configuration outside a later approved docs-only planning scope.
- Codex runtime connection.
- Codex worker execution.
- Sandbox repository changes.
- Workflow, GitHub Actions, settings, rulesets, required checks, secrets, permissions, or branch protection changes.
- Publisher implementation or GitHub write automation.
- Cleanup implementation or cleanup automation.
- Branch deletion, branch cleanup, branch rename, force update, or branch deletion automation.
- Worktree creation, deletion, pruning, cleaning, or mutation.
- Auto-merge enablement.
- Docker, VPS, Continue, MCP, or other runtime setup.
- Credentials, secrets, tokens, API keys, environment files, or secret-like placeholders.
- Trading repository design, trading implementation, live trading, risk cap logic, exchange credential handling, or model promotion logic.
- Treating Deep Research, handoff notes, PR body claims, public-only UI state, or conversation memory as repository source of truth.
- Treating Hermes as production-adopted before sandbox validation.
- Treating Hermes as replacing `codex-dev-factory` governance/control-plane authority.

Use existing registry-backed stop states when they fit, including `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`, `STOPPED_OWNER_DECISION_REQUIRED`, `STOPPED_IMPLEMENTATION_INCLUDED`, `STOPPED_WORKFLOW_INCLUDED`, `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`, `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`, `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`, `STOPPED_TRADING_CODE_INCLUDED`, `STOPPED_LIVE_TRADING_RELATED_CONTENT`, `STOPPED_SAFETY_FIELD_DROPPED`, and `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

This plan introduces no new `STOPPED_*` code.

## Evidence And Source Classification

Future Hermes evaluation evidence must separate claims by source:

| Evidence class | Use |
| --- | --- |
| `local-verified` | Current local repo, branch, worktree, file, command, or sandbox state verified in the run. |
| `authenticated/tool-reported` | GitHub or approved tool state reported by authenticated tooling. |
| `public/web-verified` | Public web state that was checked but is not enough for owner-gated authority decisions by itself. |
| `Deep Research input` | Research-derived recommendation or comparison input. This is source input, not repo source of truth by itself. |
| `user-reported` | Owner or prompt statement not independently revalidated in the current run. |
| `확인 필요` | Unknown, unavailable, stale, blocked, ambiguous, or requiring later owner/tool verification. |

Deep Research reports may inform evaluation questions and candidate decisions. Only repo-native docs and validated evidence can become project source of truth after merge.

Future Hermes evaluation must not over-promote public-only evidence, user-reported evidence, PR body claims, or research statements into local-verified or authenticated/tool-reported facts.

## Revised Roadmap And Next Decision Points

The runtime/orchestrator path should proceed through gated docs-first steps:

1. Hermes runtime evaluation plan.
2. Hermes sandbox validation criteria or acceptance criteria PR.
3. Owner-approved sandbox-only evaluation task.
4. Runtime adoption decision gate.
5. Publisher authority gate.
6. Cleanup and branch deletion authority gate.
7. Auto-merge eligibility gate.
8. Implementation-gated phases for any approved runtime, worker, publisher, cleanup, or GitHub settings work.

The plan keeps `Option 2 — Conditional Hermes-first` as an evaluation direction. It does not rename the PR to adoption, does not declare production adoption, and does not claim that Hermes replaces the control-plane.

## Recommended Next Action

Recommended next action after this PR:

- Create a control-plane acceptance criteria PR for Hermes evaluation.

Alternative safe next action:

- Create a sandbox-only Hermes evaluation planning PR.

Neither follow-up should install, run, configure, or connect Hermes until the owner separately approves an execution task.

## Cross-Document References

- [Roadmap](ROADMAP.md) records the docs-first and phase-gated path.
- [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) records Deep Research as source input only.
- [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) classifies existing runtime, worker, harness, publisher, cleanup, and authority decisions.
- [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md) preserves Codex as a future worker boundary and keeps worker execution owner-gated.
- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) preserves worktree and branch safety before implementation.
- [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md) defines future status summary reporting.
- [Risk Policy](RISK_POLICY.md) defines low-risk docs-only and high-risk implementation boundaries.
- [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) defines GitHub authority, settings, branch protection, PR lifecycle, and cleanup boundaries.
- [Stop-State Registry](STOP_STATE_REGISTRY.md) owns `STOPPED_*` codes.

## Source Input Handling For This PR

### Local-Verified

- Repository root, remote URL, current branch, clean worktree, latest `main`, local HEAD, local branch list, and worktree list were revalidated before branch creation.
- Required repo docs and solution lessons were inspected before editing.
- External research input file existence was checked from the current machine.

### Authenticated/Tool-Reported

- PR #41 and PR #42 were reported by GitHub CLI as `MERGED`.
- PR #41 and PR #42 reviews were reported as empty by GitHub CLI.
- The open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.
- Remote branches for PR #41, PR #42, and this task branch were not returned by remote head lookup during preflight.

### Public/Web-Verified

- No public web browsing was used for this PR. Local repo docs, read-only source inputs, and authenticated GitHub tooling were sufficient for the requested plan.

### Deep Research Input

- The Hermes runtime research file existed and was read as source input/context only.
- The baseline Codex-first research file existed and was read as source input/context only.
- Raw research text, report body, and ChatGPT citation tokens were not copied into this repository.

### User-Reported

- The owner reported PR #41 and PR #42 local cleanup was completed.
- The owner supplied the expected external input paths and task framing.

### 확인 필요

- GitHub settings, branch protection, rulesets, required checks, auto-merge state, repository secrets, and permissions.
- Whether Hermes should be installed or executed in any future task.
- Which Hermes version, profile, runtime state root, or isolation mode would be evaluated.
- Whether Codex app-server, Codex CLI, Codex SDK, or another runtime path should be tested in a future sandbox-only task.
- Whether future Hermes evaluation requires a separate sandbox repository task.
- Whether future publisher, cleanup, auto-merge, Docker/VPS/Continue/MCP, credentials, or trading boundary decisions change.

## Solution Lookup Result

Applicable solution lessons were found and applied:

- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using registry-backed stop states and introducing no new `STOPPED_*` code.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping validation, self-review, and confirmations distinct for this PR's metadata.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by keeping forbidden file/action boundary violations as stop/report conditions.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by keeping evidence classes, stopped semantics, owner gates, and recommended next actions aligned.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by treating local paths and external inputs as run-local evidence or source input, not durable source of truth by themselves.
- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by keeping required status/result concepts, examples, stop states, owner gates, and recommended next actions aligned.

No applicable solution lesson conflicted with this docs-only Hermes evaluation plan scope.

## Safety Field Preservation

This plan preserves:

- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

Future Hermes evaluation tasks, acceptance criteria, status summaries, PR metadata, or sandbox evidence must preserve these fields without weakening them.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Edited Markdown files contain no hidden or bidirectional Unicode control characters.
- Changed files are limited to allowed files.
- No sandbox files changed.
- No external input files changed.
- No workflow, settings, secrets, source-code, script, executable schema, dependency, trading, publisher, cleanup, auto-merge, branch deletion automation, Docker/VPS, Continue, MCP, or runtime files changed.
- The new document says `Option 2 — Conditional Hermes-first`, not unconditional adoption.
- Hermes is an evaluation track only.
- Codex remains the primary coding worker candidate.
- `codex-dev-factory` remains the governance/control-plane.
- GitHub write authority, cleanup authority, branch deletion authority, auto-merge authority, credentials/secrets, and trading remain owner-gated and outside Hermes.
- Raw Deep Research text and ChatGPT citation tokens were not pasted into repo docs.
- Source-of-truth classifications remain separated.
- No implementation or execution occurred.
