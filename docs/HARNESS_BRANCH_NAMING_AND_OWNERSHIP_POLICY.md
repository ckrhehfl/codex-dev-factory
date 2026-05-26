# Harness Branch Naming and Ownership Policy

## Status

| Field | Value |
| --- | --- |
| Status | `draft_policy` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only branch naming and ownership policy |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Follows [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) and [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) |
| Risk tier | Low-risk docs-only policy PR |

This document defines future branch naming and ownership policy before any worktree harness implementation exists. It does not create branches except this PR task branch, create or delete worktrees, delete branches, perform cleanup, run Codex workers, implement automation, grant GitHub authority, or modify the sandbox repository.

## Purpose

Future harness-created task branches and worktrees must be named, identified, reported, and stopped safely before any mutation occurs.

This policy prevents future harness work from guessing branch ownership, overwriting existing branches, crossing repository boundaries, or treating cleanup as implied by branch names or remote branch deletion.

## Relationship To Existing Docs

[Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) defines what the future harness may and may not do.

[Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) defines how future harness outcomes must report branch, worktree, ownership, cleanup, evidence, and unknown state.

This policy narrows future branch naming, ownership evidence, ambiguity handling, conflict handling, cross-repo boundaries, and cleanup boundaries. This PR does not implement branch creation, worktree creation, cleanup, deletion, or automation.

## Scope

This policy covers:

- Future task branch naming.
- Future branch and worktree ownership evidence.
- Branch conflict handling.
- Worktree ownership handling.
- Ambiguous branch or worktree stop/report behavior.
- Protected, reserved, shared, open-PR, and cross-repo branch boundaries.
- Result reporting requirements.
- Owner gates.
- Cleanup as a separate policy surface that is not authorized here.

Allowed files for this PR:

- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing note.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` for a narrow cross-link.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` for a narrow cross-link.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Execute a Codex worker.
- Create, delete, prune, or modify worktrees.
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

## Naming Principles

Future task branch names must be:

- Scoped to the work type or policy area.
- Descriptive enough for review without encoding private data.
- Tied to a task title, task id, or PR id once those identifiers are formally defined.
- Repo-specific; a control-plane branch name must not authorize sandbox branch mutation, and a sandbox branch name must not authorize control-plane mutation.
- Audit-friendly, while still stopping rather than overwriting when a branch already exists.

Future task branch names must not:

- Imply merge authority, owner approval, production readiness, cleanup completion, or validation pass state.
- Encode credentials, secrets, tokens, private account data, customer data, or sensitive prompts.
- Reuse protected or reserved branch names.
- Use a branch name as the only evidence of ownership.
- Cross repository boundaries by name alone.

## Reserved Branch Protections

The following names and patterns are protected or reserved for future harness policy:

- `main`.
- `master`.
- `develop`.
- `release/*`.
- `hotfix/*` unless separately approved.
- Any branch configured as protected or shared.
- Any branch linked to an open PR not owned by the current task.
- Any branch linked to an unmerged or ambiguous PR.
- Any branch checked out by another worktree unless ownership is explicitly verified.
- Any branch whose ownership is ambiguous.

Protected or reserved branches must not be overwritten, reset, force-pushed, force-deleted, or selected as cleanup targets by a future harness.

## Recommended Future Task Branch Pattern

The current docs-first convention supports scoped branch names such as:

- `docs/<short-topic>` for documentation-only work.

Future policy may also approve patterns such as:

- `policy/<short-topic>` for policy-only work, if the owner adopts that prefix.
- `harness/<short-topic>` for future harness-design work, only after owner approval.
- `<task-id>/<short-topic>` or `<type>/<task-id>-<short-topic>` if the repository later defines stable task ids.

This PR does not rename existing branches, require retroactive branch renaming, or approve branch automation. Existing branch conventions and task-specific branch names remain source of truth until a later implementation policy is approved.

## Ownership Evidence

Future branch or worktree ownership evidence must include:

- Task title or task id, when available.
- Target repository full name.
- Local repository path.
- Remote URL.
- Intended branch name.
- Actual branch name.
- Branch HEAD.
- Base branch and base HEAD.
- PR number and URL, if a PR exists.
- Worktree path, if a worktree exists.
- Worktree cleanliness status.
- Creation method or reuse method.
- Evidence classification.
- Owner gate status.
- Whether any mutation occurred.
- Whether cleanup was requested, allowed, performed, or not run.

Ownership evidence must be local-verified, authenticated/tool-reported, public/web-verified, user-reported, or `확인 필요`. A branch name alone is never enough ownership evidence.

## Branch Conflict Handling

Future harness behavior should stop/report when:

- The intended branch already exists locally and ownership is not verified.
- The intended branch already exists remotely and same-task or same-PR ownership is not verified.
- Multiple local or remote branches could match the task.
- The current branch is not expected for the planned operation.
- The branch is protected, reserved, shared, open-PR-linked, unmerged, or ambiguous.
- Ownership evidence is stale, public-only, user-reported only, or unavailable for a mutation that needs stronger evidence.

Future harness behavior must never resolve a branch conflict by:

- Overwriting a branch.
- Resetting a branch.
- Force pushing.
- Force deleting.
- Reusing another task's branch without owner approval.
- Treating remote branch deletion as proof that local cleanup is complete.

## Worktree Ownership Handling

Future worktree policy should use one active task worktree per task unless the owner separately approves a wider concurrency model.

Worktree ownership must be explicit. Required evidence includes:

- Worktree path.
- Associated repository and remote URL.
- Associated branch.
- Worktree cleanliness.
- Task or PR ownership evidence.
- Whether the worktree was created by the future harness, reused after verification, or only observed.

Unknown or stale worktrees are report-first, not delete-first. Dirty worktrees stop/report before mutation. Worktree deletion, pruning, or retention enforcement remains outside this policy until a later owner-approved cleanup or retention policy allows it.

## Cross-Repo Boundary Handling

Every future task prompt must identify the target repository and local path before branch or worktree mutation is considered.

Control-plane branch and worktree operations must not affect the sandbox repository. Sandbox branch and worktree operations must not affect the control-plane repository.

Wrong repo, wrong path, wrong remote, or unclear repository identity must stop before mutation. Public GitHub UI, conversation memory, branch names, or handoff notes are not enough source-of-truth evidence.

## Cleanup Boundary

This policy does not authorize branch cleanup.

This policy does not authorize worktree pruning, deletion, retention enforcement, force deletion, or cleanup automation.

Normal cleanup and any future controlled squash-merged cleanup exception remain separate owner-gated policy surfaces. Branch deletion requires merge verification, ownership verification, protected-branch checks, clean worktree checks, and the cleanup policy in effect for that task.

## Result Reporting Requirements

Future harness result reports should include:

- Intended branch.
- Actual branch.
- Branch ownership evidence.
- Branch conflict status.
- Remote branch status.
- Base branch and base HEAD.
- Branch HEAD.
- Worktree path.
- Worktree ownership evidence.
- Worktree cleanliness.
- Mutation performed or not.
- Cleanup performed or not.
- Stop state, if any.
- Owner gate status.
- Evidence classification.
- Remaining `확인 필요`.

Reports must preserve scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Stop And Report Conditions

Use existing registry-backed stop states when they apply, including:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` for wrong, ambiguous, or unverifiable repo/path/remote state.
- `STOPPED_LOCAL_WORKTREE_DIRTY` when a relevant worktree is dirty and the task requires clean state.
- `STOPPED_BRANCH_PROTECTED` when a protected or reserved branch is targeted for deletion or unsafe mutation.
- `STOPPED_BRANCH_NOT_MERGED` when cleanup is requested but merge state is not confirmed.
- `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED` when cleanup would require force deletion.
- `STOPPED_OWNER_DECISION_REQUIRED` when a future action crosses an owner gate.
- `STOPPED_FORBIDDEN_FILE_CHANGE` when requested or actual changed files exceed allowed files.
- `STOPPED_IMPLEMENTATION_INCLUDED` when implementation appears in a docs-only policy task.
- `STOPPED_WORKFLOW_INCLUDED` when workflow files or workflow implementation appear.
- `STOPPED_CODE_INCLUDED` when source code appears in docs-only scope.
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED` when GitHub write automation appears before approval.
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY` when cleanup automation appears before approval.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH` when stop-state references drift from the registry.
- `STOPPED_SAFETY_FIELD_DROPPED` when required safety fields disappear.

Plain-language stop/report conditions also apply when:

- Ownership evidence is missing.
- An existing branch conflict is found.
- An existing remote branch conflict is found.
- Multiple candidate branches match the task.
- A branch is linked to an open PR not owned by the task.
- A request asks for force push, reset, or force delete.
- A request asks for cleanup before owner approval.
- A request asks to touch the other repository.
- A request asks to include implementation.

This PR introduces no new `STOPPED_*` code.

## Owner Decisions Required

Codex must not decide these in this PR:

- Exact branch naming prefix set.
- Whether task ids become mandatory.
- Task id format.
- Default worktree root location.
- Maximum concurrent task worktrees.
- Stale branch reporting cadence.
- Whether branch creation can be automated later.
- Whether branch deletion can ever be automated later.
- Controlled squash-merge cleanup policy boundary.
- Branch ownership persistence format.
- Worktree ownership persistence format.
- Whether future harness can create, reuse, delete, or prune worktrees.
- Whether future harness can interact with a publisher.

## Examples

These examples are illustrative only. They are not executable schemas and do not imply that harness implementation exists.

### Valid Docs-Only Branch Naming Example

| Field | Example |
| --- | --- |
| Status | `planned` |
| Intended branch | `docs/harness-branch-naming-ownership-policy` |
| Scope | Docs-only branch naming and ownership policy |
| Non-goals | No harness implementation; no worktree mutation; no cleanup |
| Allowed files | `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` and narrow discoverability links |
| Forbidden files | `.github/workflows/**`, source code, scripts, executable schemas, dependency manifests, credentials, trading files |
| Forbidden actions | Branch deletion, worktree deletion, force push, automation implementation, sandbox modification |
| Validation plan | `git status --short`, `git diff --check`, hidden Unicode scan, allowed-files check, stop-state registry check |
| Stop conditions | Stop on wrong repo/path/remote, dirty worktree, branch conflict, forbidden file/action, missing owner decision |
| Risk tier | Low-risk docs-only |
| Owner gates | Merge, cleanup, branch deletion, worktree mutation, automation, and publisher behavior remain owner-gated |
| Cleanup | `cleanup_performed: false` |
| Recommended next action | Create or review docs-only PR after validation |

### Stopped Existing Local Branch Conflict

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `READY_TO_BRANCH` |
| Intended branch | `docs/example-policy` |
| Conflict | Local branch exists and ownership evidence is not verified |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | Plain-language stop/report, or `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` if ownership/source-of-truth cannot be verified |
| Forbidden action | Do not overwrite, reset, force push, force delete, or reuse the branch |
| Recommended next action | Report conflict and request owner decision or choose a new branch after revalidation |

### Stopped Remote Branch Conflict

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `READY_TO_BRANCH` |
| Intended branch | `docs/example-policy` |
| Conflict | Remote branch exists and is not proven to belong to the current task or PR |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` when remote ownership cannot be verified |
| Forbidden action | Do not push over the remote branch or force push |
| Recommended next action | Inspect branch/PR ownership with authenticated tooling or ask owner |

### Stopped Wrong Repo Or Path

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` |
| Trigger | Local path or remote URL does not match the task target repository |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Forbidden action | Do not create a branch, edit files, or mutate worktrees |
| Recommended next action | Stop and report verified repo identity before continuing |

### Stopped Protected Branch Target

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `READY_TO_BRANCH` or `LOCAL_CLEANUP_PENDING` |
| Target | `main`, `master`, `develop`, `release/*`, or another protected/shared branch |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_BRANCH_PROTECTED` |
| Forbidden action | Do not delete, reset, force push, or reuse protected branch as a task branch |
| Recommended next action | Select a non-protected task branch or ask owner if policy is unclear |

### Owner-Decision-Required Cleanup

| Field | Example |
| --- | --- |
| Status | `stopped` |
| Interrupted lifecycle state | `LOCAL_CLEANUP_PENDING` |
| Cleanup request | Branch deletion or worktree pruning requested outside approved cleanup policy |
| Safety fields | Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates preserved |
| Stop state | `STOPPED_OWNER_DECISION_REQUIRED` |
| Cleanup | `cleanup_performed: false` |
| Forbidden action | Do not delete branches or prune worktrees without owner-approved cleanup scope |
| Recommended next action | Run the owner's standard cleanup prompt or define a separate cleanup policy |

## Cross-Document Consistency

This policy aligns with:

- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md), which keeps worktree harness design docs-only and excludes cleanup automation.
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), which requires branch/worktree ownership evidence, cleanup as report-only, evidence classification, and safety-field preservation.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md), which separates branch work, review, merge, cleanup, and lesson capture.
- [Stop-State Registry](STOP_STATE_REGISTRY.md), which owns `STOPPED_*` codes.
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md), [Factory Status Result Contract](FACTORY_STATUS_RESULT.md), [PR Metadata Guard Contract](PR_METADATA_GUARD.md), and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md), which require source-of-truth reporting and safety-field preservation.

If future policy adds new stop codes, cleanup permissions, lifecycle behavior, or owner gates, it must update every relevant policy surface in the same approved PR.

## Acceptance Criteria

This policy is acceptable when:

- It remains docs-only.
- No implementation is implied.
- No branch or worktree mutation is authorized.
- Ownership evidence is required before mutation.
- Ambiguity stops instead of being guessed around.
- Cleanup remains separate and owner-gated.
- Scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates are preserved.
- The sandbox repository remains untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define Codex worker boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.
- `Docs: define worktree retention policy`.
- `Docs: define worktree harness branch ownership result examples`.

## Evidence And Source Classification

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` exists after pulling latest `main`.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` exists after pulling latest `main`.
- `docs/solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md` exists after pulling latest `main`.
- Required solution lookup was completed before planning/editing.
- Current repository docs listed in the task were inspected before writing this policy.

### Authenticated/Tool-Reported

- PR #36 was checked with GitHub CLI as `MERGED`.
- PR #36 merge commit was reported by GitHub CLI.
- PR #36 commits included an initial lesson commit and `Docs: address review comments`.
- PR #36 review state was reported by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.
- The PR #36 remote branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- No public web browsing was needed for this policy PR. Local repository docs and authenticated/tool-reported GitHub state were sufficient for the required checks.

### User-Reported

- The owner reported PR #36 was merged, had a review-fix loop, and local branch/worktree cleanup was completed.
- The owner reported the PR #36 review fix aligned the solution lesson with the required `docs/solutions/README.md` structure.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Exact branch naming prefix set.
- Whether task ids become mandatory.
- Branch and worktree ownership persistence format.
- Default worktree root location.
- Maximum concurrent task worktrees.
- Stale branch reporting cadence.
- Whether future branch creation can be automated.
- Whether future branch deletion can ever be automated.
- Controlled squash-merge cleanup policy boundary.
- Whether future harness automation may create, reuse, delete, prune, or modify worktrees.
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

Future task, plan, validation, status, PR metadata, allowed-files guard, evidence, harness result, branch lifecycle, cleanup, or implementation work must preserve these fields without weakening them.

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
