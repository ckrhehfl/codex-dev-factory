# Worktree Retention Policy

## Status

| Field | Value |
| --- | --- |
| Status | `draft_policy` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only worktree retention policy |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Follows [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md), [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), and [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) |
| Risk tier | Low-risk docs-only policy PR |

This document defines future worktree retention policy before any worktree deletion, pruning, cleanup automation, retention enforcement, harness implementation, or Codex worker execution exists.

## Purpose

Future worktrees must be classified, retained, reported, and owner-gated before any deletion, pruning, cleanup, or enforcement action is considered.

This policy keeps worktree retention report-first. It prevents future harness work from treating stale, completed, dirty, ambiguous, or foreign-repo worktrees as delete-first cleanup targets. It also keeps sandbox, control-plane, cleanup, and branch lifecycle boundaries separate until the owner approves a later implementation or cleanup policy.

## Relationship To Existing Docs

[Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) defines what the future harness may and may not do.

[Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) defines how future harness outcomes must report worktree state, cleanup state, evidence classification, owner gates, and remaining unknowns.

[Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) defines future branch and worktree ownership evidence, ambiguity handling, conflict handling, cross-repo boundaries, and cleanup boundaries.

This policy narrows retention classification and report-first behavior. This PR does not implement retention enforcement, worktree deletion, worktree pruning, cleanup, branch deletion, branch cleanup automation, or harness automation.

## Scope

This policy covers:

- Active task worktrees.
- Completed task worktrees.
- Review-pending and merge-pending worktrees.
- Cleanup-pending worktrees.
- Stale worktrees.
- Dirty worktrees.
- Ambiguous worktrees.
- Cross-repo or foreign-repo worktrees.
- Protected or shared worktrees.
- Owner-gated retention decisions.
- Report-first stale worktree handling.
- Evidence and unknown reporting.
- No deletion or pruning authorization.

Allowed files for this PR:

- `docs/WORKTREE_RETENTION_POLICY.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing note.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` for a narrow cross-link.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` for a narrow cross-link.
- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` for a narrow cross-link and follow-up cleanup.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Execute a Codex worker.
- Create, delete, prune, clean, or modify worktrees.
- Enforce worktree retention.
- Clean up stale worktrees.
- Create branches except this PR task branch.
- Delete, rename, clean, or automate branch lifecycle.
- Implement branch creation automation, branch deletion automation, or cleanup automation.
- Create a GitHub App, token, permission grant, repository setting change, branch protection rule, or ruleset.
- Create or edit GitHub Actions workflows.
- Set up Docker, VPS scheduling, Continue, MCP, scanners, or any external tool.
- Implement PR publisher behavior.
- Enable auto-merge.
- Modify the sandbox repository.
- Run sandbox validation.
- Merge any PR.
- Force push.
- Add source code, scripts, dependency manifests, executable schemas, task files, validation result files, plan files, credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify or connect a trading repository.
- Add trading code, live trading behavior, exchange integration, risk cap logic, model promotion logic, Discord/Slack integration, GitHub write automation, PR publisher behavior, branch cleanup automation, or production automation.

## Worktree State Classes

Future retention reports may use these documentation-level classifications. They are not executable schema values in this PR.

| State class | Meaning | Default retention posture |
| --- | --- | --- |
| `active_task_worktree` | Worktree belongs to an in-progress owner-approved task. | Retain and report. |
| `completed_task_worktree` | Task is complete or merged, and worktree may be a later cleanup candidate. | Retain and report until cleanup is separately approved. |
| `review_pending_worktree` | PR or owner review is pending. | Retain and report. |
| `merge_pending_worktree` | PR is ready for owner-controlled merge or waiting on merge verification. | Retain and report. |
| `cleanup_pending_worktree` | Worktree may be eligible for cleanup after merge and ownership checks. | Report candidate only; do not delete or prune. |
| `stale_worktree` | Worktree appears inactive or old, but ownership and safety still need verification. | Report candidate only. |
| `dirty_worktree` | Worktree has modified, staged, or untracked state. | Stop/report before mutation. |
| `ambiguous_worktree` | Ownership, repository identity, branch linkage, or PR linkage is unclear or conflicting. | Stop/report before mutation. |
| `foreign_repo_worktree` | Worktree belongs to a different repository than the current task target. | Stop/report; do not touch. |
| `protected_or_shared_worktree` | Worktree is associated with protected, shared, open-PR, unmerged, or owner-gated state. | Stop/report or retain as owner-gated. |
| `unknown_status_worktree` | Worktree state cannot be classified with current evidence. | Stop/report or mark 확인 필요. |

These classes should align with [Task Lifecycle State Model](TASK_LIFECYCLE.md), [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), and [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md). If future lifecycle or result docs introduce stronger canonical terms, future retention docs should reconcile with them before implementation.

## Retention Principles

Future retention behavior must follow these principles:

- Report-first before delete-first.
- Dirty worktrees stop/report before mutation.
- Ambiguous worktrees stop/report before mutation.
- Owner-gated cleanup remains required.
- Branch and worktree ownership evidence is required before any future retention decision.
- Retention classification does not imply cleanup authorization.
- Remote branch deletion is not proof that local worktree cleanup is complete.
- Cross-repo boundaries must be preserved.
- Control-plane tasks must never modify sandbox worktrees.
- Sandbox tasks must never modify control-plane worktrees.
- Worktree deletion, pruning, cleaning, stashing, reset, and retention enforcement remain forbidden until a separate owner-approved policy allows them.

## Evidence Required Before Any Future Retention Decision

Before any future retention decision is made, the report should include or explicitly mark 확인 필요:

- Repository full name.
- Local repository path.
- Remote URL.
- Worktree path.
- Associated branch.
- Branch HEAD.
- Base branch and base HEAD, if known.
- PR number and URL, if any.
- Lifecycle state.
- Worktree cleanliness.
- Ownership evidence.
- Open PR linkage.
- Merge state, if relevant.
- Cleanup eligibility, if relevant.
- Evidence classification.
- Remaining 확인 필요.

Evidence must be classified as local-verified, authenticated/tool-reported, public/web-verified, user-reported, or 확인 필요. A branch name, worktree path, public-only page, or user report is not enough by itself to authorize deletion or pruning.

## Report-First Stale Worktree Handling

Stale or unknown worktrees are reported, not deleted.

A future stale-worktree report should include:

- Worktree path.
- Repository identity and remote URL.
- Associated branch.
- Branch HEAD.
- Age or last-observed activity, if known.
- PR linkage and merge state, if known.
- Worktree cleanliness.
- Ownership evidence.
- Retention recommendation.
- Cleanup eligibility classification.
- Remaining 확인 필요.
- Recommended next action.

Deletion or pruning requires a later owner-approved cleanup or retention enforcement policy. This PR and the MVP boundary do not authorize automatic pruning.

## Dirty Worktree Handling

Dirty worktrees stop/report before mutation.

Future retention handling must not automatically:

- Checkout another branch from a dirty worktree.
- Reset changes.
- Stash changes.
- Clean untracked files.
- Delete the worktree.
- Prune worktrees.
- Treat dirty state as safe because a PR appears merged.

Reports may summarize dirty state at a safe level, such as whether tracked, staged, or untracked files exist. Destructive or state-changing actions require an explicit owner decision and a separately approved cleanup or retention scope.

## Ambiguous Worktree Handling

Ambiguous worktrees stop/report.

Ambiguity includes:

- Missing ownership evidence.
- Stale ownership evidence.
- Public-only or user-reported-only ownership evidence for a mutation that needs stronger proof.
- Conflicting branch, PR, path, or remote evidence.
- Multiple worktrees that could belong to the same task.
- A worktree path that belongs to a different repository.
- A branch name that looks related but is not tied to current task or PR evidence.

Future harness or cleanup behavior must not guess based on branch name alone.

## Completed Worktree Handling

Completed or merged task worktrees may become cleanup candidates only under a separate cleanup policy.

Retention reports may classify a completed worktree as a `cleanup_pending_worktree`, but that classification is not deletion authorization.

Normal cleanup and any future controlled squash-merged cleanup exception remain separate policy surfaces. Completed worktree handling must preserve merge verification, ownership verification, protected-branch checks, dirty-worktree checks, stop-state checks, risk tier, and owner gates.

## Cross-Repo Boundaries

Every future worktree operation must verify target repo, local path, and remote URL before mutation is considered.

Control-plane tasks must not modify sandbox worktrees. Sandbox tasks must not modify control-plane worktrees. Neither repository may be cleaned, pruned, or mutated from a task targeting the other repository.

Wrong repo, wrong path, wrong remote, or unclear repository identity stops before mutation.

## Retention Result Reporting Requirements

Future retention reports should include:

- Worktree state class.
- Retention recommendation.
- `cleanup_allowed`: `true` or `false`.
- `cleanup_performed`: `true` or `false`.
- `deletion_pruning_allowed`: `true` or `false`.
- `deletion_pruning_performed`: `false` by default unless a future owner-approved policy exists and the task explicitly permits it.
- Owner gate status.
- Stop state, if any.
- Evidence classification.
- Remaining 확인 필요.
- Recommended next action.

Retention result reporting must preserve scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Stop And Report Conditions

Use existing registry-backed stop states when they apply, including:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` for wrong, ambiguous, or unverifiable repo/path/remote state.
- `STOPPED_LOCAL_WORKTREE_DIRTY` when a relevant worktree is dirty and the task requires clean state.
- `STOPPED_BRANCH_PROTECTED` when an associated branch is protected, reserved, or shared and a mutation is requested.
- `STOPPED_BRANCH_NOT_MERGED` when cleanup is requested but merge state is not confirmed.
- `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED` when cleanup would require force deletion.
- `STOPPED_OWNER_DECISION_REQUIRED` when a future action crosses an owner gate.
- `STOPPED_FORBIDDEN_FILE_CHANGE` when requested or actual changed files exceed allowed files.
- `STOPPED_IMPLEMENTATION_INCLUDED` when implementation appears in a docs-only policy task.
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED` when CLI implementation appears too early.
- `STOPPED_CODE_INCLUDED` when source code appears in docs-only scope.
- `STOPPED_WORKFLOW_INCLUDED` when workflow files or workflow implementation appear.
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED` when GitHub write automation appears before approval.
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY` when cleanup automation appears before approval.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH` when stop-state references drift from the registry.
- `STOPPED_SAFETY_FIELD_DROPPED` when required safety fields disappear.

Plain-language stop/report conditions also apply when:

- Worktree ownership is ambiguous.
- Worktree ownership evidence is missing.
- A foreign-repo worktree is encountered.
- A protected or shared worktree is targeted.
- An associated branch is protected, reserved, open, or unmerged.
- Cleanup is requested before owner approval.
- Deletion or pruning is requested before owner approval.
- Force delete, reset, stash, clean, or prune is requested.
- Implementation is requested inside a docs-only retention task.
- The task asks to touch the other repository.

This PR introduces no new `STOPPED_*` code.

## Owner Decisions Required

Codex must not decide these in this PR:

- Default worktree root location.
- Maximum concurrent task worktrees.
- Retention duration.
- Stale worktree reporting cadence.
- Whether deletion or pruning can ever be automated.
- Who approves cleanup candidates.
- Whether dirty worktrees can ever be auto-stashed or auto-cleaned.
- How ownership metadata is persisted.
- Whether sandbox and control-plane retention policies differ.
- Controlled squash-merge cleanup boundary.
- Future cleanup automation timing.
- Whether a future harness may create, reuse, delete, prune, or modify worktrees.

## Examples

These examples are illustrative only. They are not executable schemas and do not imply that retention enforcement or harness implementation exists.

### Active Clean Task Worktree Report

| Field | Example |
| --- | --- |
| Status | `planned` |
| Worktree state class | `active_task_worktree` |
| Scope | Docs-only policy work |
| Non-goals | No harness implementation; no worktree mutation; no cleanup |
| Allowed files | Task-declared docs-only files |
| Forbidden files | `.github/workflows/**`, source code, scripts, executable schemas, dependency manifests, credentials, trading files |
| Forbidden actions | Worktree deletion, worktree pruning, branch deletion, cleanup automation, sandbox modification |
| Validation plan | Verify repo/path/remote, branch, cleanliness, allowed files, hidden Unicode, stop-state registry |
| Stop conditions | Wrong repo/path/remote, dirty worktree, ambiguous ownership, forbidden file/action, missing owner decision |
| Risk tier | Low-risk docs-only |
| Owner gates | Merge, cleanup, branch deletion, worktree mutation, retention enforcement, and automation remain owner-gated |
| Cleanup | `cleanup_allowed: false`; `cleanup_performed: false` |
| Deletion/pruning | `deletion_pruning_allowed: false`; `deletion_pruning_performed: false` |
| Recommended next action | Continue task or report current state; do not prune |

### Completed Task Worktree Report-Only Candidate

| Field | Example |
| --- | --- |
| Status | `owner_decision_required` |
| Worktree state class | `cleanup_pending_worktree` |
| Trigger | PR appears merged and local worktree is clean, but cleanup policy approval is separate |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Cleanup | `cleanup_allowed: false`; `cleanup_performed: false` |
| Deletion/pruning | `deletion_pruning_allowed: false`; `deletion_pruning_performed: false` |
| Owner gate | Cleanup requires the owner's standard cleanup instruction or a later approved cleanup policy |
| Recommended next action | Report cleanup candidate and wait for owner-approved cleanup task |

### Stale Worktree Report-Only Candidate

| Field | Example |
| --- | --- |
| Status | `owner_decision_required` |
| Worktree state class | `stale_worktree` |
| Trigger | Worktree appears inactive, but age, ownership, PR linkage, or merge state is not enough to authorize deletion |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Evidence classification | Local-verified path and branch; PR linkage or age may remain 확인 필요 |
| Cleanup | `cleanup_allowed: false`; `cleanup_performed: false` |
| Deletion/pruning | `deletion_pruning_allowed: false`; `deletion_pruning_performed: false` |
| Recommended next action | Report stale candidate with remaining 확인 필요; do not prune |

### Dirty Worktree Stopped Result

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` or `LOCAL_CLEANUP_PENDING` |
| Worktree state class | `dirty_worktree` |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_LOCAL_WORKTREE_DIRTY` |
| Forbidden action | Do not checkout, reset, stash, clean, delete, or prune automatically |
| Cleanup | `cleanup_performed: false` |
| Deletion/pruning | `deletion_pruning_performed: false` |
| Recommended next action | Report dirty state and request owner instruction |

### Ambiguous Worktree Stopped Result

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` |
| Worktree state class | `ambiguous_worktree` |
| Trigger | Multiple candidate worktrees or conflicting branch/PR ownership evidence |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` when ownership or repo state cannot be verified |
| Forbidden action | Do not guess, delete, prune, or reuse the worktree |
| Recommended next action | Report ambiguity and revalidate ownership or request owner decision |

### Foreign Repo Worktree Stopped Result

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` |
| Worktree state class | `foreign_repo_worktree` |
| Trigger | Worktree path or remote belongs to a repo outside the task target |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Forbidden action | Do not modify the other repository |
| Recommended next action | Stop and report verified repo/path/remote identity |

### Owner-Decision-Required Deletion Or Pruning Request

| Field | Example |
| --- | --- |
| Status | `owner_decision_required` |
| Interrupted lifecycle state | `LOCAL_CLEANUP_PENDING` when cleanup was requested, otherwise current task state |
| Worktree state class | `cleanup_pending_worktree` or `unknown_status_worktree` |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_OWNER_DECISION_REQUIRED` when the request crosses an owner gate |
| Cleanup | `cleanup_allowed: false`; `cleanup_performed: false` |
| Deletion/pruning | `deletion_pruning_allowed: false`; `deletion_pruning_performed: false` |
| Recommended next action | Define or invoke a separate owner-approved cleanup policy before any deletion or pruning |

## Cross-Document Consistency

This policy aligns with:

- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md), which keeps worktree harness design docs-only and excludes worktree mutation, branch deletion, and cleanup automation.
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), which requires branch/worktree state, cleanup as report-only, evidence classification, stop/report details, owner gates, and safety-field preservation.
- [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), which requires ownership evidence before branch or worktree mutation and keeps cleanup separate.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md), which separates branch work, review, merge, cleanup, stopped-state recovery, and lesson capture.
- [Stop-State Registry](STOP_STATE_REGISTRY.md), which owns `STOPPED_*` codes.
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md), [Factory Status Result Contract](FACTORY_STATUS_RESULT.md), [PR Metadata Guard Contract](PR_METADATA_GUARD.md), and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md), which require source-of-truth reporting and safety-field preservation.

If future policy adds cleanup permissions, worktree deletion authority, branch lifecycle automation, new lifecycle behavior, owner gates, or new stop codes, it must update every relevant policy surface in the same approved PR.

## Acceptance Criteria

This policy is acceptable when:

- It remains docs-only.
- No implementation is implied.
- No worktree creation, deletion, pruning, cleaning, or modification is authorized.
- Retention remains report-first.
- Owner gates are preserved.
- Ambiguity stops instead of being guessed around.
- Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates are preserved.
- The sandbox repository remains untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define Codex worker boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.
- `Docs: define worktree harness branch ownership result examples`.

## Evidence And Source Classification

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` exists after pulling latest `main`.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` exists after pulling latest `main`.
- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` exists after pulling latest `main`.
- `docs/TECH_STACK_DECISION_RECORD.md` exists after pulling latest `main`.
- Required solution lookup was completed before planning/editing.
- Current repository docs listed in the task were inspected before writing this policy.

### Authenticated/Tool-Reported

- PR #37 was checked with GitHub CLI as `MERGED`.
- PR #37 merge commit was reported by GitHub CLI.
- PR #37 reviews list was reported empty by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.
- The PR #37 remote branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- No public web browsing was needed for this policy PR. Local repository docs and authenticated/tool-reported GitHub state were sufficient for the required checks.

### User-Reported

- The owner reported PR #37 was merged, had no formal review, and local branch/worktree cleanup was completed.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Default worktree root location.
- Maximum concurrent task worktrees.
- Retention duration and stale worktree reporting cadence.
- Whether future deletion or pruning can ever be automated.
- Who approves cleanup candidates.
- Whether dirty worktrees can ever be auto-stashed or auto-cleaned.
- How branch and worktree ownership metadata is persisted.
- Whether sandbox and control-plane retention policies differ.
- Controlled squash-merge cleanup policy boundary.
- Future cleanup automation timing.
- External tool versions and runtime availability.

## Solution Lookup Result

Solution lookup was completed before planning and editing.

Applicable lessons:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by completing solution lookup before planning/editing and preserving interrupted lifecycle context in stopped examples.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by requiring this PR body to include distinct self-review and confirmations sections.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by keeping forbidden file/action examples as stopped or owner-gated when a stop condition applies.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by matching example fields to the policy surface and preserving interrupted state and recommended next action.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by preferring portable verification evidence and keeping environment-specific facts run-local.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using existing registry-backed stop codes and adding no new stop code.
- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by checking that examples include required safety fields and align status, stop state, cleanup state, owner gates, and recommended next action.

No applicable solution conflicts with this docs-only policy scope.

## Safety Field Preservation

This policy preserves:

- `scope`.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

Future task, plan, validation, status, PR metadata, allowed-files guard, evidence, harness result, branch lifecycle, cleanup, retention enforcement, or implementation work must preserve these fields without weakening them.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Changed files are limited to allowed files.
- No workflow, source, script, executable schema, dependency, secret, trading, sandbox, automation, publisher, cleanup, Discord/Slack, risk cap, or model promotion files changed.
- Relative links added by this PR resolve.
- Any referenced `STOPPED_*` code exists in [Stop-State Registry](STOP_STATE_REGISTRY.md).
