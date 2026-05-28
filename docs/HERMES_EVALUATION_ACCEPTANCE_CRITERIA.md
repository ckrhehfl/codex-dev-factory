# Hermes Evaluation Acceptance Criteria

## Active Conditional Evaluation Status

These criteria remain relevant for active conditional Hermes runtime/tooling/orchestration evaluation for Codex-primary workflows. They are not active approval to install, run, configure, authenticate, connect, or evaluate Hermes in a live task.

Future use requires an owner-approved Hermes-Codex feasibility or sandbox validation gate. The Ollama/local-model provider path remains retired unless explicitly reopened.

## Status

| Field | Value |
| --- | --- |
| Decision context | Follows `Option 2 — Conditional Hermes-first` |
| Phase | Evaluation criteria planning |
| Implementation status | `not_started` |
| Risk tier | Low-risk docs-only while this PR remains documentation-only |
| Adoption status | Hermes is not adopted as production authority |
| Source of truth after merge | This repository's merged documentation |

This document defines acceptance criteria for evaluating Hermes as the first runtime/orchestrator track. It does not install Hermes, run Hermes, configure Hermes, connect a Codex runtime, execute a Codex worker, modify the sandbox repository, create workflows, change GitHub settings, add credentials, implement publisher behavior, implement cleanup automation, delete branches, mutate worktrees, enable auto-merge, set up Docker/VPS/Continue/MCP, or touch trading systems.

## Purpose

The purpose is to define what must be true before Hermes can move from evaluation track to any stronger runtime or orchestrator role.

This document converts the [Hermes Runtime Evaluation Plan](HERMES_RUNTIME_EVALUATION_PLAN.md) into concrete pass, fail, stopped, and inconclusive criteria while preserving Codex as the primary patch-producing coding worker candidate.

`codex-dev-factory` remains the governance/control-plane for task contracts, stop states, allowed files, forbidden actions, owner gates, evidence, PR lifecycle, source-of-truth discipline, and authority boundaries.

The criteria prevent implicit adoption, hidden authority transfer, premature sandbox execution, and premature runtime execution.

## Evaluation Scope

Hermes may be evaluated only for these subjects:

- Scheduling or cron-like orchestration.
- Task, goal, or kanban coordination.
- Subagent orchestration.
- Worktree and session management behavior.
- Profile or runtime isolation behavior.
- Memory and skills behavior.
- Terminal backend behavior.
- API or gateway behavior.
- Status aggregation and reporting.
- Runtime wrapping around Codex as the patch-producing worker.

These are evaluation subjects only. They are not delegated production responsibilities, and they do not grant Hermes control-plane, GitHub write, cleanup, branch deletion, auto-merge, credential, workflow, sandbox, publisher, or trading authority.

## Non-Goals

This document does not:

- Install Hermes.
- Run Hermes.
- Configure Hermes.
- Modify the sandbox repository.
- Connect a Codex runtime.
- Execute a Codex worker.
- Change GitHub settings, workflows, Actions, rulesets, required checks, branch protection, secrets, or permissions.
- Implement publisher behavior or GitHub write automation.
- Implement cleanup automation.
- Implement branch deletion automation.
- Enable auto-merge.
- Create, delete, prune, clean, or mutate worktrees.
- Delete, rename, clean, or force-update branches.
- Set up Docker, VPS, Continue, MCP, or other runtime infrastructure.
- Add source code, scripts, executable schemas, dependency manifests, credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify or design trading repository behavior, trading code, live trading, risk cap logic, exchange credentials, or model promotion.

## Acceptance Criteria Categories

### A. Repo Identity And Path Safety

Pass criteria:

- Hermes-facing evaluation evidence identifies the target repo, local path, remote URL, base branch, current branch, and relevant branch/worktree state before any runtime action.
- The evaluation distinguishes the control-plane repository from the sandbox repository.
- Any future runtime verifies repo path and remote before edit, execution, status reporting, or handoff.
- A repo, path, remote, branch, or worktree ambiguity stops instead of proceeding.

Fail criteria:

- Hermes behavior or evaluation evidence confuses control-plane and sandbox repositories.
- Runtime behavior proceeds on user-reported or public-only repo identity without local verification.
- Ambiguous repo/path/remote state is treated as safe.

### B. Instruction Determinism

Pass criteria:

- Hermes and Codex instruction layering preserves task contract, scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, owner gates, risk tier, and evidence rules.
- Runtime prompts are stable and reviewable enough to audit what task contract and safety fields were active.
- Evaluation records which instruction surfaces were repo source of truth, source input, user-reported, or `확인 필요`.

Fail criteria:

- Hermes changes, drops, or hides task safety fields.
- Runtime prompts are not reconstructable enough for review.
- Source-of-truth classes collapse into an unqualified "verified" claim.

### C. Runtime State Isolation

Pass criteria:

- `CODEX_HOME` or any equivalent runtime state root is isolated per profile, task, or evaluation run if used.
- Evaluation evidence shows that credentials, repo state, task memory, and hidden authority do not leak across tasks.
- Unknown isolation behavior is reported as `확인 필요` instead of assumed safe.

Fail criteria:

- Hermes shares mutable runtime state across unrelated tasks without evidence and owner approval.
- Runtime state grants hidden authority, hidden credentials, or unreviewable memory.
- Evaluation requires changing local/global Git config or credential storage.

### D. Worktree And Session Behavior

Pass criteria:

- Hermes does not create, delete, prune, clean, or mutate worktrees unless a future owner-approved task explicitly allows that scope.
- Any worktree/session behavior remains report-first until separately authorized.
- Branch and worktree cleanup remain outside Hermes unless a separate owner-approved cleanup policy allows them.
- Worktree evidence maps to existing worktree harness result and status summary surfaces.

Fail criteria:

- Hermes mutates worktrees, deletes branches, cleans worktrees, or performs cleanup without explicit owner approval.
- Worktree ownership is guessed from branch name alone.
- Dirty, ambiguous, foreign-repo, protected, or shared worktrees are treated as safe.

### E. GitHub Authority Boundary

Pass criteria:

- Hermes does not receive GitHub write authority by default.
- PR creation, PR updates, merge, auto-merge, branch deletion, settings changes, rulesets, required checks, Actions, secrets, and cleanup authority remain separately gated.
- Any future publisher authority is least-privilege, control-plane governed, and separately approved.

Fail criteria:

- Hermes obtains or assumes GitHub write authority as part of evaluation.
- Evaluation depends on changing GitHub settings, branch protection, rulesets, required checks, Actions, secrets, or permissions.
- Publisher, merge, auto-merge, cleanup, or branch deletion authority is implied by runtime evaluation success.

### F. Evidence Compatibility

Pass criteria:

- Hermes outputs map to existing evidence, validation, result, and status summary surfaces.
- Evidence separates `local-verified`, `authenticated/tool-reported`, `public/web-verified`, `user-reported`, `Deep Research input`, and `확인 필요`.
- PR body claims are treated as run evidence, not durable future source of truth by themselves.
- Unknowns remain explicit and include how to verify them.

Fail criteria:

- Evidence classes are collapsed.
- Public-only, user-reported, PR-body, handoff, or Deep Research claims are over-promoted.
- Evaluation evidence omits unknowns or treats missing information as passing.

### G. Stop-State Compatibility

Pass criteria:

- Hermes evaluation preserves stop-state registry semantics.
- Forbidden actions, missing owner approval, ambiguous repo identity, credential boundary issues, sandbox mutation requests, and production adoption implications stop with a clear reason.
- Referenced `STOPPED_*` codes exist in [Stop-State Registry](STOP_STATE_REGISTRY.md).

Fail criteria:

- A stop condition is softened into a non-blocking warning.
- A new stop code is invented without updating registry surfaces in an approved scope.
- Status, stop reason, owner gate, and recommended next action conflict.

### H. Sandbox-Only Evaluation Readiness

Pass criteria:

- Actual Hermes evaluation is deferred until a separate owner-approved sandbox evaluation task.
- Future sandbox evaluation has allowed files, forbidden actions, evidence plan, rollback or cleanup expectations, and stop conditions.
- This PR leaves the sandbox repository unmodified.

Fail criteria:

- Hermes evaluation begins in this PR.
- The sandbox repository is modified before owner approval.
- Sandbox validation lacks allowed-files, forbidden-actions, evidence, rollback/cleanup, or stop-condition boundaries.

### I. Security And Credential Boundary

Pass criteria:

- No secrets, tokens, API keys, account identifiers, credentials, or secret-like placeholders are added to repo docs or local config by default.
- Hermes does not gain hidden credential access.
- Any future credential use requires explicit owner gate and separate security review.

Fail criteria:

- Evaluation requires credentials before a separate security-approved task.
- Secrets or secret-like placeholders are committed.
- Hermes has unreviewed access to local credential stores, GitHub tokens, or account configuration.

### J. Production Adoption Gate

Pass criteria:

- Hermes is not considered adopted until acceptance criteria are satisfied by evidence.
- Adoption requires a separate owner decision and separate PR or task.
- Successful evaluation does not automatically grant publisher, cleanup, auto-merge, GitHub settings, branch deletion, worktree mutation, or credential authority.

Fail criteria:

- Evaluation success is described as production adoption.
- Hermes inherits authority automatically from a passing runtime test.
- `codex-dev-factory` control-plane governance is replaced or weakened.

## Evidence Requirements

A future Hermes evaluation must record evidence for:

- Repo, path, and remote verification.
- Branch and worktree state before and after evaluation.
- Exact allowed files touched, if any.
- Exact forbidden actions not performed.
- Runtime/status output mapping to existing status summary, result, validation, and evidence surfaces.
- Stop-state behavior, if applicable.
- Confirmation that sandbox and control-plane boundaries were preserved.
- Confirmation that GitHub authority was not expanded.
- Confirmation that no secrets, workflows, settings, rulesets, required checks, Actions, branch protection, dependency manifests, or executable implementation files were touched.
- Confirmation that no publisher, cleanup, branch deletion, worktree mutation, auto-merge, Docker/VPS/Continue/MCP, or trading scope was introduced.
- Classification of each evidence item as `local-verified`, `authenticated/tool-reported`, `public/web-verified`, `user-reported`, `Deep Research input`, or `확인 필요`.

Evidence must be portable enough for reviewers to understand the verification method. Machine-specific paths, local-only details, and tool outputs remain run-local evidence unless they are intentionally promoted through merged repo documentation.

## Pass / Fail / Stopped Outcomes

Future Hermes evaluation should report one of these outcomes:

| Outcome | Meaning |
| --- | --- |
| `pass` | Criteria were tested and satisfied with sufficient evidence. |
| `fail` | Criteria were tested and not satisfied. |
| `stopped` | Evaluation could not proceed because a stop condition or owner gate was reached. |
| `inconclusive` | Evidence was incomplete, unavailable, stale, or environment-dependent. |

`stopped` is preferred over guessing, unsafe continuation, or treating missing evidence as success.

When an active stop condition applies, report `stopped` with a registry-backed stop code when one exists, plain-language reason, interrupted lifecycle context when known, owner action required, and recommended next action.

## Owner Gates

Explicit owner approval is required before:

- Hermes installation.
- Hermes execution.
- Hermes configuration.
- Codex runtime connection.
- Codex worker execution.
- Sandbox validation or sandbox mutation.
- Publisher authority or GitHub write automation.
- Cleanup authority or cleanup automation.
- Branch deletion authority or branch deletion automation.
- Worktree creation, deletion, pruning, cleaning, or mutation.
- GitHub settings, branch protection, rulesets, required checks, Actions, secrets, permissions, or auto-merge eligibility changes.
- Credentials, secrets, tokens, API keys, account configuration, or credential store access.
- Docker, VPS, Continue, MCP, or other runtime/tooling setup.
- Trading boundary changes, trading repository design, trading implementation, live trading, risk cap logic, exchange credentials, or model promotion.
- Production adoption of Hermes.

## Stop Conditions

Stop and report if a task using these criteria requires any of the following without explicit owner approval or outside the approved scope:

- Hermes installation, execution, or configuration.
- Codex runtime connection or worker execution.
- Sandbox repository changes.
- Workflow, GitHub Actions, settings, rulesets, required checks, secrets, permissions, or branch protection changes.
- Credentials, tokens, API keys, account configuration, or secret-like placeholders.
- Publisher implementation, publisher authority, GitHub write automation, or PR automation beyond the approved docs-only task.
- Cleanup implementation, cleanup automation, branch deletion, branch cleanup, branch rename, force update, or branch deletion automation.
- Worktree creation, deletion, pruning, cleaning, or mutation.
- Auto-merge enablement.
- Docker, VPS, Continue, MCP, or other runtime setup.
- Trading repository design, trading implementation, live trading, risk cap logic, exchange credential handling, or model promotion logic.
- Treating Hermes as production-adopted before evidence satisfies acceptance criteria and an owner approves adoption.
- Expanding GitHub authority because Hermes evaluation exists.
- Proceeding when repo, path, remote, branch, worktree, approval boundary, or source-of-truth classification is ambiguous.

Use existing registry-backed stop states when they fit, including `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`, `STOPPED_OWNER_DECISION_REQUIRED`, `STOPPED_IMPLEMENTATION_INCLUDED`, `STOPPED_WORKFLOW_INCLUDED`, `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`, `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`, `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`, `STOPPED_TRADING_CODE_INCLUDED`, `STOPPED_LIVE_TRADING_RELATED_CONTENT`, `STOPPED_SAFETY_FIELD_DROPPED`, and `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

This document introduces no new `STOPPED_*` code.

## Relationship To Existing Docs

- [Hermes Runtime Evaluation Plan](HERMES_RUNTIME_EVALUATION_PLAN.md) records the evaluation direction and owner gates.
- [Roadmap](ROADMAP.md) keeps runtime/orchestrator work phase-gated and docs-first.
- [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) classifies Hermes as a deferred evaluation track, not adopted production authority.
- [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md) preserves Codex as the primary patch-producing worker candidate and keeps worker execution owner-gated.
- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) keeps worktree behavior bounded before implementation.
- [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md) defines status summary fields that future Hermes outputs should map to.
- [Risk Policy](RISK_POLICY.md) distinguishes low-risk docs-only work from high-risk implementation and authority changes.
- [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) keeps GitHub settings, merge, auto-merge, and authority changes gated.
- [Stop-State Registry](STOP_STATE_REGISTRY.md) owns registry-backed stop codes.
- [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) keeps Deep Research as source input, not repo source of truth by itself.

## Recommended Next Action

Recommended follow-up:

- `Docs: define Hermes sandbox validation runbook`.

Alternative follow-up:

- `Docs: define Hermes evaluation status summary example`.

Neither follow-up should install, run, configure, or connect Hermes unless the owner separately approves a sandbox evaluation task.

Future evaluation evidence should use [Hermes Evaluation Evidence Template](HERMES_EVALUATION_EVIDENCE_TEMPLATE.md) before any sandbox runtime evaluation records results.

## Solution Lookup Result

Applicable solution lessons were found and applied:

- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by referencing registry-backed stop states and introducing no new `STOPPED_*` code.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping validation, self-review, and confirmations distinct for PR metadata.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by treating forbidden file/action boundary violations as stop/report conditions.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by preserving evidence classification, stopped semantics, owner gates, and recommended next actions.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by keeping local paths and current-run facts as run-local evidence unless revalidated.
- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by aligning status, stop states, owner gates, cleanup boundaries, and recommended next actions.

No applicable solution lesson conflicted with this docs-only scope.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Changed files are limited to allowed files.
- No sandbox files changed.
- No external input files changed.
- No workflow, settings, secrets, source code, executable scripts, executable schemas, dependency manifests, trading files, publisher files, cleanup automation, branch deletion automation, auto-merge implementation, Docker/VPS, Continue, MCP, Hermes runtime, or Codex runtime files changed.
- Hermes remains evaluation-only and is not adopted as production authority.
- Codex remains the primary patch-producing coding worker candidate.
- `codex-dev-factory` remains governance/control-plane.
- GitHub write authority, cleanup authority, branch deletion authority, auto-merge authority, credentials/secrets, and trading remain owner-gated.
- Pass, fail, stopped, and inconclusive outcomes are defined.
- Evidence classification is explicit.
- Owner gates and stop conditions are explicit.
- Raw Deep Research text and ChatGPT citation tokens were not pasted into repo docs.
- Cross-document links resolve locally where practical.
- Edited Markdown files contain no hidden or bidirectional Unicode control characters.
- No implementation or execution occurred.
