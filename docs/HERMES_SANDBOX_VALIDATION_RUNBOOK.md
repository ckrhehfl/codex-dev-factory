# Hermes Sandbox Validation Runbook

## Superseded Status

This runbook is historical/superseded unless the owner explicitly reopens Hermes sandbox validation. No Hermes sandbox validation is currently approved.

The install, configuration, run, provider/model setup, local-model download, sandbox validation, and runtime-connection phases described below are not active next steps. Future Hermes or Ollama work requires a new owner-approved reopen gate.

## Status

| Field | Value |
| --- | --- |
| Purpose | Runbook for future owner-approved Hermes sandbox validation |
| Phase | Sandbox validation planning |
| Implementation status | `not_started` |
| Risk tier | Low-risk docs-only while this PR remains documentation-only |
| Adoption status | Hermes is not adopted as production authority |
| Scope status | No Hermes install/run/configuration, no Codex runtime connection, no sandbox mutation |
| Source of truth after merge | This repository's merged documentation |

This runbook is documentation only. It does not install, run, or configure Hermes; connect a Codex runtime; execute a Codex worker; perform sandbox validation; mutate the sandbox repository; create workflows; change GitHub settings; add credentials; implement publisher behavior; implement cleanup automation; delete branches; mutate worktrees; enable auto-merge; set up Docker/VPS/Continue/MCP; or touch trading systems.

## Purpose

This runbook defines the ordered procedure, approval boundaries, evidence requirements, stop conditions, and handoff expectations for a future sandbox-only Hermes evaluation.

It exists so a later owner-approved task can evaluate Hermes as a runtime/orchestrator track without relying on chat history, PR body claims, raw Deep Research, public-only state, or unclassified local state.

After this runbook PR, the project must pause before actual Hermes sandbox validation. Any real evaluation requires a concrete owner-approved task with target repo/path, allowed files, forbidden files, forbidden actions, approval scope, and evidence requirements.

## Relationship To Existing Docs

This runbook follows:

- [Hermes Runtime Evaluation Plan](HERMES_RUNTIME_EVALUATION_PLAN.md), which records `Option 2 - Conditional Hermes-first` as an evaluation track, not production adoption.
- [Hermes Evaluation Acceptance Criteria](HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md), which defines pass, fail, stopped, and inconclusive criteria.
- [Hermes Evaluation Evidence Template](HERMES_EVALUATION_EVIDENCE_TEMPLATE.md), which defines the future evidence packet shape.
- [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md), which preserves Codex as the primary patch-producing worker candidate and keeps worker execution owner-gated.
- [Sandbox Validation](SANDBOX_VALIDATION.md) and [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md), which define existing sandbox validation and evidence expectations.
- [PR 44 Hermes Acceptance Review Lessons](solutions/policy/pr44-hermes-acceptance-review-lessons.md), which requires stop conditions to distinguish unapproved or out-of-scope runtime actions from separately owner-approved future evaluation actions.
- [PR 46 Hermes Evidence Review Lessons](solutions/policy/pr46-hermes-evidence-review-lessons.md), which requires future evidence templates to separate observed/touched/attempted state, approval state, and evidence class.

This runbook introduces no new `STOPPED_*` code, evidence class, owner gate, production adoption decision, or implementation authority.

## Validation Scope

A future owner-approved sandbox validation may evaluate whether Hermes can support:

- Repo, path, remote, and session identity reporting.
- Profile and runtime state isolation.
- Instruction layering with Codex while preserving task contracts and safety fields.
- Status output compatibility with existing status summary and evidence surfaces.
- Worktree and session reporting behavior.
- Hidden authority, memory, profile, terminal, credential, or approval risk detection.
- GitHub authority boundary preservation.
- Codex remaining the patch-producing worker candidate while Hermes acts only as runtime/orchestrator wrapper.
- Evidence packet compatibility with the Hermes evaluation evidence template.

These are validation subjects only. This runbook does not approve running the validation.

## Required Owner Approvals Before Actual Sandbox Validation

A future validation task must record explicit owner approval for:

- Actual sandbox validation.
- Target sandbox repo and local path.
- Hermes installation, if any.
- Hermes execution, if any.
- Hermes configuration, if any.
- Codex runtime connection, if any.
- Codex worker execution, if any.
- Allowed sandbox files.
- Forbidden sandbox files.
- Network or API access, if any.
- Credential and secrets boundary.
- GitHub write access boundary.
- Worktree and branch mutation boundary.
- Cleanup boundary.
- Rollback and handoff expectations.

Approval must include source and evidence class. If approval is missing, stale, ambiguous, or outside the requested action scope, the future validation must stop/report.

## Preflight Sequence For Future Validation

A future owner-approved validation must complete this preflight before any runtime action:

1. Confirm the target repo is the sandbox repo, not the control-plane repo.
2. Confirm local path and remote URL.
3. Confirm current branch and clean worktree.
4. Confirm open PR state, if the task could interact with PRs.
5. Confirm branch and worktree state before evaluation.
6. Confirm allowed files and forbidden actions.
7. Confirm owner approvals and approval evidence class.
8. Confirm no credentials, secrets, token dumps, environment variable dumps, or secret-like placeholders are exposed.
9. Confirm the evidence packet path/name or explicitly mark it `확인 필요`.
10. Stop if any identity, approval, source-of-truth, or scope boundary is ambiguous.

The preflight must keep observed state, approval state, and evidence class separate. For example, "sandbox repo touched: not_touched" is not the same as "sandbox mutation approval: not_approved".

## Evidence Packet Requirement

Every future Hermes sandbox validation must fill the [Hermes Evaluation Evidence Template](HERMES_EVALUATION_EVIDENCE_TEMPLATE.md) skeleton or a repo-native derived packet.

The packet must record:

- Packet identity.
- Source-of-truth classifications.
- Preflight evidence.
- Scope and approvals.
- Hermes evaluation fields.
- Codex worker boundary evidence.
- GitHub authority evidence.
- Sandbox boundary evidence.
- Worktree and branch evidence.
- Credential and security evidence.
- Outcome.
- Acceptance criteria mapping.
- Recommended next action.

Evidence classes must remain separate:

- `local-verified`.
- `authenticated/tool-reported`.
- `public/web-verified`.
- `Deep Research input`.
- `user-reported`.
- `확인 필요`.

PR body claims, handoff notes, conversation memory, and raw Deep Research remain source input or run evidence unless revalidated in the future task.

## Future Validation Phases

These phases are planning guidance only. Each phase may require a separate owner-approved task.

| Phase | Purpose | Execution authority |
| --- | --- | --- |
| Phase A: preflight-only dry run | Verify sandbox repo identity, branch/worktree state, approvals, evidence packet path, and stop conditions. | Not approved by this runbook. |
| Phase B: Hermes install/config discovery | Inspect or perform Hermes install/config only if the owner explicitly approves that task scope. | Owner-gated. |
| Phase C: sandbox-only Hermes status/session evaluation | Observe Hermes status, session, profile, and runtime behavior in the sandbox. | Owner-gated. |
| Phase D: Codex runtime wrapping evaluation | Evaluate whether Hermes can wrap Codex while Codex remains the patch-producing worker candidate. | Owner-gated. |
| Phase E: evidence review and adoption decision gate | Review packet evidence against acceptance criteria and decide whether any stronger role is justified. | Owner decision required. |

If a later task approves one phase, that approval does not automatically approve later phases.

## Stop Conditions

Future validation must stop/report if any of the following is true without explicit owner approval, outside the approved scope, or with an ambiguous approval boundary:

- Target repo, path, remote, branch, or worktree identity is ambiguous.
- Sandbox/control-plane boundary is unclear.
- Approval scope is missing, stale, contradictory, or ambiguous.
- Hermes install, run, or configuration is not explicitly approved.
- Codex runtime connection or worker execution is not explicitly approved.
- Sandbox mutation is not explicitly approved.
- GitHub authority boundary is unclear.
- Credentials, secrets, tokens, API keys, environment dumps, or credential store changes are requested or exposed.
- Workflows, GitHub Actions, settings, rulesets, required checks, branch protection, permissions, or secrets would be touched.
- Publisher behavior, cleanup automation, branch deletion automation, or auto-merge would be implemented.
- Worktree or branch mutation is required but not approved.
- Force delete is requested.
- Protected branch deletion is requested.
- Docker, VPS, Continue, MCP, or other runtime setup is required.
- Trading repository design, trading implementation, live trading, risk cap logic, exchange credential handling, or model promotion appears.
- Evidence cannot be classified.
- The task implies Hermes production adoption before evidence review and owner decision.

Use existing registry-backed stop states when they fit, including `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`, `STOPPED_OWNER_DECISION_REQUIRED`, `STOPPED_IMPLEMENTATION_INCLUDED`, `STOPPED_WORKFLOW_INCLUDED`, `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`, `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`, `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`, `STOPPED_TRADING_CODE_INCLUDED`, `STOPPED_LIVE_TRADING_RELATED_CONTENT`, `STOPPED_SAFETY_FIELD_DROPPED`, and `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

Plain-language stop/report remains acceptable when no more specific registry-backed code fits.

## Allowed Future Outcomes

| Outcome | Meaning |
| --- | --- |
| `pass` | Criteria were tested and satisfied with sufficient evidence. |
| `fail` | Criteria were tested and not satisfied. |
| `stopped` | Evaluation could not proceed because a stop condition or owner gate was reached. |
| `inconclusive` | Evidence was incomplete, stale, unavailable, environment-dependent, or not enough to decide. |

For `stopped`, the future packet must include:

- `stop_state.code`, if applicable.
- `stop_state.reason`.
- `lifecycle_trace`.
- Owner action required.
- Recommended next action.

## GitHub Authority Boundary

Future sandbox validation must not grant Hermes GitHub write authority by default.

PR creation/update, merge, auto-merge, branch deletion, cleanup, settings, rulesets, required checks, branch protection, Actions, secrets, permissions, and publisher authority remain separately owner-gated.

If a future evaluation checks GitHub authority, the evidence packet must separate:

| Authority surface | Observed/touched state | Approval state | Evidence class |
| --- | --- | --- | --- |
| PR creation/update | `not_touched`, observed value, or `확인 필요` | `not_approved`, approved scope, or `확인 필요` | Evidence class |
| Merge/auto-merge | `not_touched`, observed value, or `확인 필요` | `not_approved`, approved scope, or `확인 필요` | Evidence class |
| Branch deletion/cleanup | `not_touched`, observed value, or `확인 필요` | `not_approved`, approved scope, or `확인 필요` | Evidence class |
| Settings/rulesets/checks/secrets | `not_touched`, observed value, or `확인 필요` | `not_approved`, approved scope, or `확인 필요` | Evidence class |

## Cleanup And Branch/Worktree Boundary

Future validation must be report-first for cleanup and branch/worktree mutation unless the owner explicitly approves a bounded mutation task.

The default boundary is:

- No force delete.
- No protected branch deletion.
- No cleanup automation.
- No branch deletion automation.
- No worktree pruning unless separately approved.
- No branch/worktree ownership guessing from branch names alone.
- Dirty, ambiguous, foreign-repo, protected, shared, open, or unmerged branch/worktree states stop/report.

If mutation is explicitly approved in a future task, the evidence packet must record before/after branch state, before/after worktree state, exact approval source, approval evidence class, observed/attempted state, and remaining `확인 필요`.

## Credential And Secret Boundary

Future validation must preserve these credential boundaries:

- No secrets in repo docs.
- No token dumps.
- No environment variable dumps.
- No credential store changes unless explicitly approved.
- No secret-like placeholders.
- No hidden credential authority granted to Hermes.
- Credential status remains `확인 필요` unless directly verified within an approved task.

Any future credential use requires a separate owner-approved security boundary before execution.

## Sandbox/Control-Plane Handoff

Future validation must report back to the control-plane:

- Evidence packet location.
- Exact sandbox GitHub repo, local path, branch, and HEAD.
- Exact control-plane branch and HEAD if the control-plane is referenced.
- Exact files touched.
- Exact actions performed.
- Exact approvals used.
- Exact `pass`, `fail`, `stopped`, or `inconclusive` result.
- Observed/touched/attempted state for sandbox, GitHub authority, branch/worktree, and credential surfaces.
- Approval state for each owner-gated surface.
- Evidence class for each material claim.
- Remaining `확인 필요`.
- Recommended next action.

The handoff must not treat sandbox results as production adoption. Adoption remains a separate owner decision after evidence review.

## Non-Goals

This PR does not:

- Install, run, or configure Hermes.
- Connect a Codex runtime.
- Execute a Codex worker.
- Perform sandbox validation.
- Mutate the sandbox repository.
- Create workflows or GitHub Actions changes.
- Change GitHub settings, secrets, rulesets, required checks, branch protection, or permissions.
- Implement publisher behavior or GitHub write automation.
- Implement cleanup automation.
- Delete branches or implement branch deletion automation.
- Create, delete, prune, clean, or mutate worktrees.
- Enable auto-merge.
- Set up Docker, VPS, Continue, MCP, or runtime infrastructure.
- Touch trading systems, trading repository design, trading implementation, live trading, risk cap logic, exchange credentials, or model promotion.

## Recommended Next Action

After this runbook PR, pause for owner decision.

Do not proceed to actual sandbox validation until the owner explicitly approves a concrete sandbox validation task with:

- Target repo/path.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Approved Hermes/Codex/runtime actions, if any.
- Owner gates.
- Evidence packet requirements.
- Stop conditions.
- Rollback and handoff expectations.

## Solution Lookup Result

Applicable solution lessons were found and applied:

- [PR 44 Hermes Acceptance Review Lessons](solutions/policy/pr44-hermes-acceptance-review-lessons.md): applied by distinguishing unapproved or out-of-scope runtime actions from actions explicitly owner-approved inside a future validation task.
- [PR 46 Hermes Evidence Review Lessons](solutions/policy/pr46-hermes-evidence-review-lessons.md): applied by keeping observed/touched/attempted state, approval state, and evidence class separate, and by preserving canonical fields such as `stop_state.code`, `stop_state.reason`, and `lifecycle_trace`.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by aligning stopped semantics, owner action, lifecycle trace, and recommended next action.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by introducing no new `STOPPED_*` code.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by preserving forbidden file and forbidden action boundaries.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by keeping run-local and path-specific facts from becoming durable source of truth.

No applicable solution lesson conflicted with this docs-only runbook scope.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Changed files are limited to allowed files.
- No sandbox files changed.
- No external input files changed.
- No workflow, settings, secrets, source code, executable scripts, executable schemas, dependency manifests, runtime files, config files, trading files, publisher files, cleanup automation, branch deletion automation, auto-merge implementation, Docker/VPS, Continue, MCP, Hermes runtime, or Codex runtime files changed.
- Hermes remains evaluation-only.
- No Hermes install, run, or configuration occurred.
- No Codex runtime connection or worker execution occurred.
- No sandbox validation or sandbox mutation occurred.
- The runbook distinguishes unapproved/out-of-scope actions from explicitly owner-approved future validation actions.
- Observed/touched/attempted state, approval state, and evidence class are separated where applicable.
- Evidence classification is explicit.
- Pass, fail, stopped, and inconclusive outcomes are defined.
- Stop conditions and owner gates are explicit.
- No new `STOPPED_*` code was invented.
- Raw Deep Research text and ChatGPT citation tokens were not pasted into repo docs.
- Cross-document links resolve locally where practical.
- Edited Markdown files contain no hidden or bidirectional Unicode control characters.
- No implementation or execution occurred.
- The document tells the owner to pause before actual sandbox validation.

## Evidence Classification For This PR

### Local-Verified

- Repository root, remote URL, current branch, clean worktree, local HEAD, latest `main`, and worktree list were revalidated before branch creation.
- Required Hermes plan, acceptance criteria, evidence template, worker boundary, sandbox validation, sandbox evidence, roadmap, technical stack, stop-state, and solution docs were inspected before editing.
- The planned task branch did not exist locally or remotely before creation.

### Authenticated/Tool-Reported

- PR #47 was reported by GitHub CLI as `MERGED`.
- PR #47 merge commit was reported by GitHub CLI.
- PR #47 formal reviews were reported as empty by GitHub CLI.
- The open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.

### Public/Web-Verified

- No public web browsing was needed for this PR. Local repository checks and authenticated GitHub tooling were sufficient for the requested docs-only runbook.

### User-Reported

- The owner reported PR #47 was merged and local branch/worktree cleanup was completed.
- The owner reported PR #47 had no formal review and the remote branch was deleted.

### 확인 필요

- GitHub settings, branch protection, rulesets, required checks, auto-merge state, repository secrets, permissions, and future runtime credentials.
- Whether any future Hermes sandbox validation should install, run, or configure Hermes.
- Which sandbox repo/path, Hermes version, profile root, runtime state root, Codex runtime path, and network/API boundary a future evaluation should use.
- Whether future publisher, cleanup, auto-merge, Docker/VPS/Continue/MCP, credentials, or trading boundary decisions change.
