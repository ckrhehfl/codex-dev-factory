# Worktree Harness Branch Ownership Result Examples

## Status

| Field | Value |
| --- | --- |
| Status | `draft_examples` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only illustrative result examples |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Follows [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), and [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) |
| Risk tier | Low-risk docs-only examples PR |

This document provides non-executable examples of future branch and worktree ownership result reporting. It does not implement a schema, command, script, harness, cleanup routine, retention enforcement, branch automation, or other automation.

## Purpose

Future worktree harness reports need enough structure for owners and future tools to verify branch ownership, worktree ownership, ambiguity handling, stop/report behavior, and owner-gated cleanup behavior before any implementation exists.

These examples make those boundaries reviewable without authorizing branch creation, branch deletion, worktree creation, worktree deletion, worktree pruning, cleanup, Codex worker execution, publisher behavior, or automation.

## Relationship To Existing Docs

[Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) defines the required result fields, source-of-truth reporting, evidence classification, stop/report fields, owner gates, cleanup fields, and safety-field preservation requirements.

[Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) defines branch naming, branch ownership evidence, worktree ownership evidence, ambiguity handling, conflict handling, cross-repo boundaries, protected branch boundaries, and cleanup boundaries.

[Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) defines report-first handling for active, completed, stale, dirty, ambiguous, foreign-repo, protected/shared, and owner-gated worktrees.

This examples document illustrates those contracts. It does not replace them, weaken them, or approve implementation.

## Scope

This examples document covers:

- Branch ownership evidence.
- Worktree ownership evidence.
- Correct target repository, local path, and remote URL reporting.
- Evidence classification.
- A valid docs-only branch ownership report.
- Stopped wrong repo/path/remote reporting.
- Stopped existing local branch conflict reporting.
- Stopped existing remote branch conflict reporting.
- Stopped ambiguous ownership reporting.
- Stopped dirty worktree reporting.
- Stopped foreign-repo worktree reporting.
- Protected or reserved branch target reporting.
- Owner-decision-required cleanup or deletion reporting.
- Controlled squash-merged cleanup classification as report-only.

Allowed files for this PR:

- `docs/WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing note.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` for a narrow cross-link.
- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` for a narrow cross-link and follow-up status update.
- `docs/WORKTREE_RETENTION_POLICY.md` for a narrow cross-link and follow-up status update.

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

## Example Format Rules

These examples follow these rules:

- Examples are illustrative result reports, not executable schemas.
- Examples must preserve safety fields.
- Examples must distinguish local-verified, authenticated/tool-reported, public/web-verified, user-reported, and `확인 필요` evidence.
- Examples must include target repository and do-not-modify repository boundaries.
- Examples must not imply branch deletion, worktree deletion, pruning, cleanup automation, retention enforcement, or controlled squash-merged cleanup is authorized.
- Examples must not include real secrets, secret-like placeholders, credentials, tokens, API keys, trading connection material, or production automation instructions.
- If a registry-backed stop condition applies, the example uses `status: stopped` and an existing `STOPPED_*` code.
- If an owner gate applies before a stop condition is triggered, the example may use `status: owner_decision_required` without inventing a new stop code.

## Required Safety Fields In Every Example

Every future example must include or explicitly preserve:

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
- Remaining `확인 필요`.
- Recommended next action.

## Shared Example Boundaries

Unless an individual example says otherwise, these shared boundaries apply:

| Field | Example value |
| --- | --- |
| Target repository | `ckrhehfl/codex-dev-factory` |
| Target local path | `C:\Dev\codex-dev-factory` |
| Target remote URL | `https://github.com/ckrhehfl/codex-dev-factory.git` |
| Do-not-modify repository | `ckrhehfl/codex-dev-factory-sandbox` |
| Do-not-modify local path | `C:\Dev\codex-dev-factory-sandbox` |
| Scope | Docs-only branch/worktree ownership result reporting |
| Non-goals | No harness implementation; no worktree mutation; no branch deletion; no cleanup; no automation |
| Allowed files | Task-declared docs-only files |
| Forbidden files | `.github/workflows/**`, source code, scripts, executable schemas, dependency manifests, credentials, trading files |
| Forbidden actions | Worktree creation/deletion/pruning/cleaning, branch deletion, force push, force delete, cleanup automation, sandbox modification, trading repo interaction |
| Validation plan | Verify repo/path/remote, branch state, clean worktree, allowed files, forbidden files/actions, hidden Unicode, relative links, stop-state registry |
| Stop conditions | Wrong repo/path/remote, dirty worktree, ambiguous ownership, existing branch conflict, protected branch target, forbidden file/action, missing owner decision |
| Risk tier | Low-risk docs-only unless a future task explicitly reclassifies it |
| Owner gates | Merge, cleanup, branch deletion, worktree mutation, retention enforcement, publisher behavior, worker execution, and automation remain owner-gated |

## Example 1: Valid Docs-Only Branch Ownership Report

| Field | Example result |
| --- | --- |
| Status | `planned` or `prepared` |
| Lifecycle state | `READY_TO_BRANCH` or `BRANCH_ACTIVE` depending on whether branch creation was separately approved |
| Target repo/path/remote | Local-verified as the control-plane repository |
| Base branch and HEAD | `main` and locally verified base HEAD |
| Task branch | `docs/example-policy` |
| Branch ownership evidence | Task title, target repo, branch name, base HEAD, branch HEAD if created, and PR URL if later created |
| Worktree path | `not_run` or local-verified path if a future approved harness creates one |
| Worktree ownership evidence | `not_run`; no worktree mutation in this example |
| Mutation performed | `false` for report-only planning; `docs-only branch creation only` only when branch creation is explicitly in scope |
| Cleanup performed | `false` |
| Evidence classification | Local-verified repo/path/remote and branch; authenticated/tool-reported PR evidence only if a PR exists |
| Remaining `확인 필요` | Future worktree root, task id, branch ownership persistence, GitHub settings, branch protection |
| Recommended next action | Continue docs-only PR preparation or review after validation; do not infer cleanup authority |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 2: Stopped Wrong Repo/Path/Remote

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` |
| Trigger | Current local path or remote URL belongs to the sandbox repository while the task targets the control-plane repository, or vice versa |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Stop reason | Target repo/path/remote could not be verified as the requested repository |
| Other repo boundary | The non-target repository was not modified |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified mismatch; user-reported target remains context only |
| Remaining `확인 필요` | Correct target checkout and remote URL until revalidated |
| Recommended next action | Stop and report verified repo identity before any branch, file, or worktree mutation |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 3: Stopped Existing Local Branch Conflict

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `READY_TO_BRANCH` |
| Intended branch | `docs/example-policy` |
| Conflict | Local branch already exists and same-task ownership is not verified |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Forbidden action | Do not overwrite, reset, force push, force delete, or reuse the branch by name alone |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified branch existence; ownership remains `확인 필요` |
| Remaining `확인 필요` | Branch owner, branch HEAD meaning, PR linkage, whether branch belongs to current task |
| Recommended next action | Inspect ownership with local and authenticated tooling or ask owner for a new branch name |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 4: Stopped Existing Remote Branch Conflict

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `READY_TO_BRANCH` |
| Intended branch | `docs/example-policy` |
| Conflict | Remote branch already exists and same-task or same-PR ownership is not verified |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Forbidden action | Do not push over the branch, force push, reset, or assume remote branch ownership from the branch name |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Authenticated/tool-reported or remote-query branch existence; ownership remains `확인 필요` |
| Remaining `확인 필요` | Remote branch owner, open PR linkage, branch HEAD, whether branch belongs to current task |
| Recommended next action | Revalidate remote branch and PR ownership with authenticated tooling, then ask owner if ambiguity remains |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 5: Stopped Ambiguous Ownership

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` or `READY_TO_BRANCH` |
| Trigger | Multiple candidate branches or worktrees match the same task topic, or branch/worktree evidence conflicts |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Forbidden action | Do not guess, reuse, delete, prune, force push, or force delete |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified candidates; authenticated/tool-reported PR linkage if available; unresolved ownership stays `확인 필요` |
| Remaining `확인 필요` | Single owner, current task linkage, PR linkage, branch HEAD, worktree cleanliness |
| Recommended next action | Report the candidates and require owner decision or stronger ownership evidence |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 6: Stopped Dirty Worktree

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION`, `READY_TO_BRANCH`, or `LOCAL_CLEANUP_PENDING` |
| Trigger | Worktree has modified, staged, or untracked state when clean state is required |
| Stop state | `STOPPED_LOCAL_WORKTREE_DIRTY` |
| Forbidden action | Do not checkout, reset, stash, clean, delete, prune, or continue mutation automatically |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified dirty state from safe git status summary |
| Remaining `확인 필요` | Whether dirty changes belong to owner, previous task, current task, or generated output |
| Recommended next action | Report safe dirty-state summary and wait for owner instruction before any state-changing action |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 7: Stopped Foreign-Repo Worktree

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `LOCAL_REVALIDATION` |
| Trigger | A control-plane task encounters a sandbox worktree, or a sandbox task encounters a control-plane worktree |
| Stop state | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| Other repo boundary | The foreign repository was not modified |
| Forbidden action | Do not inspect destructively, clean, prune, delete, checkout, reset, or edit the foreign repo |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified repo/path/remote mismatch |
| Remaining `확인 필요` | Correct target repo checkout, ownership of the foreign worktree, whether a separate task is needed |
| Recommended next action | Stop and report repo/path/remote identity; request a separate task for the other repository if needed |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 8: Stopped Protected/Reserved Branch Target

| Field | Example result |
| --- | --- |
| Status | `stopped` |
| Lifecycle state | `STOPPED` |
| Interrupted lifecycle state | `READY_TO_BRANCH` or `LOCAL_CLEANUP_PENDING` |
| Target | `main`, `master`, `develop`, `release/*`, or a protected/shared/open-PR-linked branch |
| Stop state | `STOPPED_BRANCH_PROTECTED` |
| Forbidden action | Do not delete, force delete, reset, force push, or use the protected branch as a task branch |
| Cleanup performed | `false` |
| Mutation performed | `false` |
| Evidence classification | Local-verified branch name and authenticated/tool-reported branch protection if needed |
| Remaining `확인 필요` | Branch protection/ruleset state if the task depends on settings beyond reserved name patterns |
| Recommended next action | Choose a non-protected task branch or request an owner decision if branch policy is unclear |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 9: Owner-Decision-Required Cleanup/Deletion Request

| Field | Example result |
| --- | --- |
| Status | `owner_decision_required` |
| Lifecycle state | Current lifecycle state, or `STOPPED` only if a cleanup request is attempted without required approval |
| Trigger | Branch deletion, worktree deletion, pruning, cleaning, or controlled cleanup is requested outside the approved task scope |
| Stop state | None when only reporting an owner gate; use `STOPPED_OWNER_DECISION_REQUIRED` if execution would otherwise continue past the gate |
| Cleanup allowed | `false` |
| Cleanup performed | `false` |
| Deletion/pruning allowed | `false` |
| Deletion/pruning performed | `false` |
| Forbidden action | Do not delete branches, prune worktrees, force delete, or automate cleanup |
| Evidence classification | Owner-gated by task contract and current policy docs |
| Remaining `확인 필요` | Cleanup policy, merge verification, branch/worktree ownership, protected-branch state, dirty-worktree state |
| Recommended next action | Run a separate owner-approved cleanup task or define controlled cleanup policy before any deletion or pruning |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 10: Controlled Squash-Merged Cleanup Classification As Report-Only

| Field | Example result |
| --- | --- |
| Status | `owner_decision_required` |
| Lifecycle state | `LOCAL_CLEANUP_PENDING` candidate only; no cleanup performed |
| Candidate branch | `docs/example-squash-merged-task` |
| PR merged state evidence | Authenticated/tool-reported PR state `MERGED`, if checked |
| Remote branch status | Authenticated/tool-reported or remote-query status, such as remote head absent or present |
| Local branch HEAD | Local-verified branch tip |
| Merge or squash commit | Authenticated/tool-reported merge commit or squash commit on `main` |
| Tree/diff equivalence | Local-verified, authenticated/tool-reported, or `확인 필요`; absence of equivalence does not authorize deletion |
| Normal ancestry check | May be false after squash merge because the original branch tip is not necessarily an ancestor of `main` |
| Cleanup allowed | `false` in this examples document |
| Cleanup performed | `false` |
| Force delete authorization | Not authorized; this example does not authorize `git branch -D` |
| Owner gate | Controlled squash-merged cleanup requires separate owner-approved cleanup policy or explicit cleanup task |
| Evidence classification | Separate local-verified branch state, authenticated/tool-reported PR state, user-reported cleanup context, and `확인 필요` items |
| Remaining `확인 필요` | Exact cleanup policy boundary, local branch ownership, tree equivalence if not checked, dirty worktree state, protected/shared branch state |
| Recommended next action | Report cleanup candidate and wait for owner-approved cleanup scope; do not delete from this examples result |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Cross-Document Consistency

These examples align with:

- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md), which keeps future harness design docs-only and excludes worktree mutation, branch deletion, cleanup, publisher behavior, and worker execution.
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), which requires branch/worktree result fields, evidence classification, stopped semantics, owner gates, cleanup as report-only, and safety-field preservation.
- [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), which requires ownership evidence before branch or worktree mutation and stops on ambiguity.
- [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md), which keeps active, stale, dirty, ambiguous, foreign-repo, completed, and cleanup-pending worktrees report-first.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md), which separates branch work, review, merge, cleanup, stopped-state recovery, and lesson capture.
- [Stop-State Registry](STOP_STATE_REGISTRY.md), which owns `STOPPED_*` codes.
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md), [Factory Status Result Contract](FACTORY_STATUS_RESULT.md), [PR Metadata Guard Contract](PR_METADATA_GUARD.md), and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md), which require source-of-truth reporting and safety-field preservation.

If future policy adds cleanup permissions, branch/worktree mutation authority, lifecycle behavior, owner gates, result statuses, or new stop codes, it must update every relevant policy surface in the same approved PR.

## Acceptance Criteria

This examples document is acceptable when:

- It remains docs-only.
- Examples are non-executable.
- No implementation is implied.
- No branch or worktree mutation is authorized.
- Evidence classes are separated.
- Ambiguity stops instead of being guessed around.
- Cleanup remains separate and owner-gated.
- Safety fields are preserved in every example.
- The sandbox repository remains untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define Codex worker boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.
- `Docs: define worktree harness result validation checklist`.

## Validation And Evidence Classification For This PR

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` exists after pulling latest `main`.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` exists after pulling latest `main`.
- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` exists after pulling latest `main`.
- `docs/WORKTREE_RETENTION_POLICY.md` exists after pulling latest `main`.
- `docs/TECH_STACK_DECISION_RECORD.md` exists after pulling latest `main`.
- Required solution lookup was completed before planning/editing.
- Current repository docs listed in the task were inspected before writing this examples document.

### Authenticated/Tool-Reported

- PR #38 was checked with GitHub CLI as `MERGED`.
- PR #38 merge commit was reported by GitHub CLI.
- PR #38 reviews list was reported empty by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.
- The PR #38 remote branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- No public web browsing was needed for this examples PR. Local repository docs and authenticated/tool-reported GitHub state were sufficient for the required checks.

### User-Reported

- The owner reported PR #38 was merged, had no formal review, and local branch/worktree cleanup was completed.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Future worktree root location.
- Future task id format.
- Future branch ownership persistence format.
- Future worktree ownership persistence format.
- Whether branch creation, worktree creation, cleanup, deletion, pruning, retention enforcement, publisher behavior, worker execution, or automation is ever approved.
- Controlled squash-merged cleanup policy boundary.
- Tool/plugin versions beyond the commands used in this run.

## Solution Lookup Result

Applicable solution entries were found and applied:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by keeping source-of-truth revalidation before branch work and preserving stopped lifecycle context in examples.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by making forbidden file/action cases stop instead of becoming ordinary validation failures.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping self-review and confirmations distinct in PR metadata for this task.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by preserving evidence classification and interrupted state in stopped examples.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by treating exact local paths as run-local evidence, not universal source of truth.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using only registry-backed `STOPPED_*` codes.
- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by checking that examples preserve safety fields and align status, stop state, cleanup state, owner gates, and recommended next action.

No applicable solution conflicted with this docs-only examples scope.

## Safety Field Preservation

This examples document preserves:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

Dropping these fields remains a stop condition for future validation, status, metadata, allowed-files, branch/worktree ownership, retention, cleanup, or handoff work.
