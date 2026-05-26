# Worktree Harness MVP Boundary

## Status

| Field | Value |
| --- | --- |
| Status | `draft_boundary` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only boundary definition |
| Source of truth after merge | This repository's merged documentation |
| Risk tier | Low-risk docs-only boundary PR |

This document defines the future worktree harness MVP boundary before any implementation. It does not create worktrees, delete branches, run Codex, implement CLI commands, configure automation, grant GitHub authority, or modify any sandbox or trading repository.

## Purpose

The worktree harness MVP boundary defines what a future harness may be responsible for and what it must not do until later owner-approved tasks.

It prevents future Codex, harness, worker, publisher, and cleanup work from being mixed too early. The MVP boundary is intentionally narrower than the full automation direction: it describes source-of-truth checks, task field preservation, workspace isolation expectations, evidence capture, and stop/report behavior without implementing them.

## Relationship To Roadmap And Technical Stack Decision

[Roadmap](ROADMAP.md) places worktree harness design in Phase 3. Codex worker connection is a later Phase 4 concern, and publisher behavior is a later Phase 5 concern.

[Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) classifies git worktree / isolated workspace policy as `partially_adopted`, while custom harness and branch lifecycle manager implementation remain `deferred`.

This boundary PR does not change those classifications into implementation approval.

## Scope

The future harness boundary may cover, at the contract level only:

- Target repository and path verification.
- Remote URL verification.
- Clean working tree preflight.
- Fetch/prune and fast-forward `main` update planning.
- Isolated worktree planning.
- Task branch naming rules.
- Allowed-files and forbidden-files preservation.
- Forbidden-actions preservation.
- Lifecycle state reporting.
- Validation and evidence capture.
- Stop/report behavior.
- No branch deletion automation in the MVP boundary.

Allowed files for this PR:

- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing note.
- `docs/TECH_STACK_DECISION_RECORD.md` only if a narrow consistency link is needed.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Execute a Codex worker.
- Create, delete, prune, or modify worktrees.
- Create, delete, rename, or clean branches.
- Implement branch deletion automation or cleanup automation.
- Create a GitHub App, token, permission grant, repository setting change, branch protection rule, or ruleset.
- Create or edit GitHub Actions workflows.
- Set up Docker, VPS scheduling, Continue, MCP, scanners, or any external tool.
- Implement PR publisher behavior.
- Enable auto-merge.
- Modify the sandbox repository.
- Run sandbox validation.
- Merge any PR.
- Force push.
- Add source code, scripts, dependency manifests, schemas, task files, validation result files, plan files, credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify or connect a trading repository.
- Add trading code, live trading behavior, exchange integration, risk cap logic, model promotion logic, Discord/Slack integration, GitHub write automation, or production automation.

## Harness Responsibilities

A future harness may be responsible for these contract-level activities after separate owner approval:

- Identify the target repository.
- Verify source-of-truth state for repo path, remote URL, current branch, default branch, base HEAD, and working tree cleanliness.
- Verify that the task contract is present and complete enough for planning.
- Prepare an isolated workspace plan for one task.
- Preserve task contract fields, including scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.
- Preserve task branch naming expectations without overwriting existing branches.
- Report lifecycle state using the canonical task lifecycle model.
- Run validation commands only when a later implementation is approved and the task contract allows them.
- Collect status and evidence using local, authenticated/tool-reported, public/web-verified, user-reported, and unknown categories.
- Return a structured result that is reviewable by the owner.
- Stop safely on ambiguity instead of guessing.

These are responsibilities for a future design. They are not implemented here.

## Explicit Non-Responsibilities For MVP

The MVP harness boundary excludes:

- GitHub write authority.
- PR creation.
- Merge or auto-merge.
- Branch deletion.
- Local cleanup automation.
- Remote branch cleanup automation.
- Codex worker execution.
- Docker or VPS setup.
- Credential, secret, token, or permission handling.
- Trading repository interaction.
- Sandbox repository modification.
- GitHub settings changes.
- Workflow creation.

## Worktree Safety Model

Future worktree harness design should follow these safety rules:

- Use one task per isolated worktree.
- Never operate if repo, path, or remote identity is ambiguous.
- Never operate with a dirty worktree unless the approved task allows read-only inspection only.
- Never delete protected branches, including `main`, `master`, `develop`, and `release/*`.
- Never delete open, unmerged, shared, or ambiguously owned branches.
- Never overwrite an existing branch.
- Distinguish normal cleanup from controlled squash-merged cleanup, but do not automate either in the MVP boundary.
- Keep branch deletion and worktree deletion outside MVP automation until a separate owner-approved cleanup policy allows them.
- Treat cleanup state as local-verified evidence, not as a conclusion inferred from remote branch deletion alone.

## Branch Naming And Ownership

Future task branches should be scoped, descriptive, and tied to a task id or PR id once those identifiers are formally defined.

Expected future ownership rules:

- Branch ownership must be explicit before the harness mutates a branch.
- Existing branches must not be overwritten.
- A branch shared by an open PR, another task, or another worktree must stop/report instead of being reused.
- Ambiguous branch ownership must stop/report.
- Branch names must not imply merge readiness, production execution, cleanup completion, or owner approval unless those facts are verified.

## Result Contract Expectations

A future worktree harness result should report:

- Repository path.
- Remote URL.
- Base branch.
- Base HEAD.
- Task branch.
- Worktree path.
- Lifecycle state.
- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.
- Evidence classification.
- Cleanup status, if applicable.
- Remaining `확인 필요` items.

The result should not approve owner-gated actions by itself.

The detailed future result-reporting surface is defined in [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md). That contract remains docs-only and does not authorize harness implementation, worktree mutation, branch deletion, or cleanup automation.

Future branch naming, branch ownership, worktree ownership, conflict handling, and cross-repo branch boundaries are defined in [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md). That policy remains docs-only and does not authorize branch or worktree mutation.

Future worktree retention classification, stale/dirty/ambiguous worktree reporting, and owner-gated retention boundaries are defined in [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md). That policy remains docs-only and does not authorize worktree deletion, pruning, cleanup automation, or retention enforcement.

## Stop Conditions

Use existing registry-backed stop states when they apply, including:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` for wrong, ambiguous, or unverifiable repo/path/remote state.
- `STOPPED_LOCAL_WORKTREE_DIRTY` when the relevant worktree is dirty and the task requires a clean state.
- `STOPPED_FORBIDDEN_FILE_CHANGE` when requested or actual changed files exceed allowed files.
- `STOPPED_OWNER_DECISION_REQUIRED` when a future action crosses an owner gate.
- `STOPPED_IMPLEMENTATION_INCLUDED` when implementation appears in a docs-only boundary task.
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED` when CLI implementation appears too early.
- `STOPPED_CODE_INCLUDED` when source code appears in docs-only scope.
- `STOPPED_WORKFLOW_INCLUDED` when workflow files or workflow implementation appear.
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED` when GitHub write automation appears before approval.
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY` when cleanup automation appears before approval.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH` when stop-state references drift from the registry.
- `STOPPED_SAFETY_FIELD_DROPPED` when required safety fields disappear.

Plain-language stop/report conditions also apply when:

- Required source-of-truth docs are missing.
- Branch or worktree ownership is ambiguous.
- An existing branch would need to be overwritten.
- The task asks for sandbox modification without approval.
- The task asks for worker execution, publisher integration, branch deletion, worktree deletion, or environment setup before owner approval.

This PR introduces no new `STOPPED_*` code.

## Owner Decisions Required

Codex must not decide these in this PR:

- Default worktree root location.
- Branch naming convention.
- Task id format.
- Maximum concurrent worktrees.
- Worktree retention duration and reporting cadence.
- Local cleanup policy timing.
- Controlled squash-merge cleanup policy boundary.
- Whether a future harness can create worktrees automatically.
- Whether a future harness can delete worktrees automatically.
- Whether a future harness can invoke a Codex worker.
- Whether a future harness can interact with a publisher.
- Whether a future harness can run validation commands automatically.
- How branch ownership should be persisted or reported.

## MVP Acceptance Criteria

This boundary is acceptable when:

- It remains docs-only.
- It preserves repo/path/remote discipline.
- It preserves scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.
- It separates harness planning from worker execution, publisher behavior, GitHub settings, and cleanup automation.
- It requires owner decisions before automation.
- It adds no implementation, workflow, source code, scripts, schemas, dependency manifests, credentials, secrets, tokens, API keys, trading content, sandbox changes, or external write behavior.
- It keeps the sandbox repository untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define worktree harness result contract`.
- `Docs: define worker runtime strategy`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.

## Evidence And Source Classification

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- `docs/TECH_STACK_DECISION_RECORD.md` exists after pulling latest `main`.
- `docs/DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md` exists after pulling latest `main`.
- Required solution lookup was completed before planning/editing.
- Current repository docs listed in the task were inspected before writing this record.

### Authenticated/Tool-Reported

- PR #33 was checked with GitHub CLI as `MERGED`.
- PR #33 merge commit was reported by GitHub CLI.
- PR #33 reviews list was reported empty by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty by GitHub CLI before this branch was created.
- The PR #33 remote branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- No public web browsing was needed for this boundary PR. Local repository docs and authenticated/tool-reported GitHub state were sufficient for the required checks.

### User-Reported

- The owner reported PR #33 was merged, had no formal review, and local branch/worktree cleanup was completed.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Default worktree root location.
- Task id format and branch ownership persistence model.
- Maximum concurrent worktrees and retention policy.
- Whether future harness automation may create or delete worktrees.
- Whether any controlled squash-merge cleanup exception should ever exist.
- Whether the future harness may invoke a Codex worker or publisher.
- External tool versions and runtime availability.

## Solution Lookup Result

Solution lookup was completed before planning and editing.

Applicable lessons:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by completing solution lookup before planning/editing and preserving lifecycle/STOPPED interruption boundaries.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by requiring this PR body to include distinct self-review and confirmations sections.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by keeping changed files inside allowed docs-only paths and aligning file-boundary violations with stopped semantics.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by keeping evidence categories and stopped-state fields structurally explicit.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by preferring portable verification evidence and avoiding machine-specific durable claims.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using existing registry-backed stop codes and adding no new stop code.

No applicable solution conflicts with this docs-only boundary scope.

## Safety Field Preservation

This boundary preserves:

- `scope`.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

Future task, plan, validation, status, PR metadata, allowed-files guard, evidence, harness result, or implementation work must preserve these fields without weakening them.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Changed files are limited to allowed files.
- No workflow, source, dependency, secret, trading, sandbox, automation, publisher, cleanup, Discord/Slack, risk cap, or model promotion files changed.
- Relative links added by this PR resolve.
- Any referenced `STOPPED_*` code exists in [Stop-State Registry](STOP_STATE_REGISTRY.md).
