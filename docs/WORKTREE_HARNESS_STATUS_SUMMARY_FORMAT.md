# Worktree Harness Status Summary Format

## Status

| Field | Value |
| --- | --- |
| Status | `draft_format` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only future status summary format |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Summarizes future worktree harness status using [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md), [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md), and [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) |
| Risk tier | Low-risk docs-only format PR |

This document defines a non-executable future status summary format. It does not implement a harness, script, executable schema, validation automation, worktree or branch mutation, cleanup routine, publisher behavior, workflow, or Codex worker execution.

## Purpose

The worktree harness status summary is a future reporting surface for a worktree harness run or planning pass.

It summarizes what was checked, what is known, what remains `확인 필요`, which actions are report-only, and which actions remain owner-gated. It helps owners and future tooling inspect repo identity, branch and worktree ownership, lifecycle/status state, evidence classes, validation checklist outcome, cleanup/report-only boundaries, owner gates, and safe next actions without relying on conversation memory or hidden local state.

The status summary is report-only. No field in the summary approves cleanup, branch deletion, worktree mutation, publisher behavior, GitHub settings changes, workflow setup, sandbox modification, or worker execution by itself.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Add an executable schema.
- Add a validation script.
- Create, delete, prune, clean, or modify worktrees.
- Create branches except this PR task branch.
- Delete, clean, or automate branches.
- Perform cleanup.
- Implement cleanup automation.
- Implement publisher behavior, a GitHub App, or GitHub write automation.
- Execute a Codex worker.
- Create or edit workflows.
- Change GitHub settings, branch protection, rulesets, required checks, secrets, permissions, or Actions.
- Set up Docker, VPS, Continue, or MCP behavior.
- Modify the sandbox repository.
- Change Git safe.directory or local/global Git config.
- Modify or connect a trading repository.
- Add source code, scripts, dependency manifests, credentials, secrets, tokens, API keys, trading code, live trading behavior, risk cap logic, model promotion logic, Discord/Slack integration, or production automation.
- Merge any PR.

## Status Summary Fields

Future status summaries should include these fields or explicitly mark them `확인 필요`:

| Field | Purpose |
| --- | --- |
| `summary_version` | Version of this future summary format. |
| `generated_at` | When the summary was produced, when relevant. |
| `target_repo` | Expected repository full name from the task contract. |
| `target_local_path` | Environment-specific local path checked for the current run. |
| `repo_identity` | Local repository root, default branch, HEAD, and verification method. |
| `remote_identity` | Remote URL, remote default branch when known, and verification method. |
| `current_branch` | Current branch before and after any approved operation. |
| `base_branch` | Base branch for the task, normally `main` unless a task says otherwise. |
| `task_branch` | Intended and actual task branch, plus branch conflict state. |
| `worktree_path` | Worktree path or `not_run` when no worktree was created or inspected. |
| `worktree_owner` | Ownership evidence, cleanliness, and retention posture for the worktree. |
| `branch_owner` | Ownership evidence, PR linkage, branch HEAD, and ambiguity state for the branch. |
| `lifecycle_status` | Current lifecycle state aligned with [Task Lifecycle State Model](TASK_LIFECYCLE.md). |
| `factory_status` | Higher-level status aligned with [Factory Status Result Contract](FACTORY_STATUS_RESULT.md). |
| `validation_result` | Summary of docs-safe validation, skipped checks, failures, and checklist outcome. |
| `evidence_classes` | Separate evidence buckets for verified, reported, and unknown claims. |
| `source_of_truth_classification` | Claim-by-claim source level for repo, PR, branch, worktree, cleanup, and settings state. |
| `remaining_confirm_needed` | Explicit `확인 필요` items, why they remain unknown, and how to verify them. |
| `owner_gates` | Owner decisions required before continuing or before any mutation. |
| `report_only_actions` | Actions the summary may recommend or classify but must not perform. |
| `forbidden_actions_observed` | Any requested or detected forbidden action, with stop/report posture. |
| `cleanup_boundary` | Cleanup allowed/performed fields and report-only cleanup classification. |
| `recommended_next_action` | Next safe action consistent with status, owner gates, and stop state. |
| `stop_state` | Registry-backed `STOPPED_*` code and reason when a stop condition applies. |

The field list must stay aligned with normative text and examples. If a future example relies on a field, the field should be listed here or clearly marked as illustrative and partial.

## Source-Of-Truth Classification

Status summaries must separate these evidence classes:

| Evidence class | Meaning |
| --- | --- |
| `public/web-verified` | Visible through public web surfaces. Useful for human inspection, but not sufficient for owner-gated GitHub state when stronger sources are available. |
| `authenticated/tool-reported` | Reported by authenticated GitHub tooling, a trusted connector, or another task-approved tool in the current run. |
| `local-verified` | Checked in the local repository or filesystem during the current run. |
| `user-reported` | Provided by the owner or prompt, but not independently verified in the current run. |
| `확인 필요` | Not checked, unavailable, blocked, ambiguous, or requiring future owner/tool verification. |

The summary must not infer GitHub settings, branch protection, rulesets, required checks, secrets, PR review state, local cleanup state, sandbox state, or plugin/tool versions unless they were actually verified in the current run.

## Lifecycle And Status Alignment

`lifecycle_status` should use states from [Task Lifecycle State Model](TASK_LIFECYCLE.md), including states such as `LOCAL_REVALIDATION`, `READY_TO_BRANCH`, `BRANCH_ACTIVE`, `DOCS_EDITING`, `SELF_REVIEW`, `PR_CREATED`, `REVIEW_PENDING`, `MERGE_READY`, `MERGED`, `LOCAL_CLEANUP_PENDING`, `LOCAL_CLEANUP_DONE`, `LESSON_REVIEW`, `DONE`, and `STOPPED`.

`factory_status` and `validation_result` should align with [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) and [Task Validation Result Contract](TASK_VALIDATION_RESULT.md). Useful report statuses include `passed`, `failed`, `not_checked`, `unknown`, `owner_decision_required`, and `stopped` when those meanings match the existing docs.

If `stop_state.code` contains a registry-backed `STOPPED_*` code, the top-level status should be `stopped` unless the summary explicitly describes a non-stop owner-decision state that does not emit a stop-state code.

Stopped summaries must align:

- `lifecycle_status`.
- `factory_status`.
- `stop_state.code`.
- `stop_state.reason`.
- Interrupted lifecycle state when known.
- `recommended_next_action`.

## Branch And Worktree Ownership Summary

Status summaries should reuse ownership concepts from [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md), and [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md).

Branch ownership should report:

- Intended branch.
- Actual branch.
- Branch HEAD when known.
- Base branch and base HEAD.
- PR number and URL when available.
- Local branch presence.
- Remote branch presence.
- Conflict status.
- Protected, shared, open, unmerged, or ambiguous branch status.
- Evidence class.
- Remaining `확인 필요`.

Worktree ownership should report:

- Worktree path or `not_run`.
- Worktree state class, such as `active_task_worktree`, `completed_task_worktree`, `cleanup_pending_worktree`, `stale_worktree`, `dirty_worktree`, `ambiguous_worktree`, `foreign_repo_worktree`, `protected_or_shared_worktree`, or `unknown_status_worktree`.
- Worktree cleanliness.
- Associated branch.
- Associated repo and remote.
- Ownership evidence.
- Retention posture.
- Evidence class.
- Remaining `확인 필요`.

The status summary reports ownership and retention posture only. It does not enforce cleanup, create worktrees, delete worktrees, prune worktrees, delete branches, or mutate repository state.

## Validation Checklist Outcome

Status summaries should reference [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md).

The summary should report:

- Checklist version or document reference.
- Overall checklist result: `pass`, `fail`, `not_checked`, `owner_decision_required`, `stopped`, or `확인 필요`, as appropriate.
- Failed checklist items.
- Skipped checklist items and skip reasons.
- Blocking items.
- Evidence class for each important checklist result.
- Recommended next action.

A failed safety-boundary checklist item should stop/report. A missing or unavailable evidence item should remain `확인 필요` instead of being guessed.

## Cleanup And Report-Only Boundary

The status summary may recommend cleanup, classify a cleanup candidate, or report cleanup state. It must not perform cleanup.

Cleanup fields should include:

- `cleanup_allowed`: `false` unless a separate current task and policy explicitly authorize cleanup.
- `cleanup_performed`: `false` unless the current task is a cleanup task and cleanup actually ran.
- `branch_deletion_allowed`: `false` by default.
- `branch_deletion_performed`: `false` by default.
- `worktree_pruning_allowed`: `false` by default.
- `worktree_pruning_performed`: `false` by default.
- Normal cleanup versus controlled squash-merged cleanup classification.
- Evidence class.
- Remaining `확인 필요`.

Cleanup, branch deletion, worktree deletion, worktree pruning, forced deletion, and controlled squash-merged cleanup remain out of scope for this document. A status summary cannot authorize `git branch -D`, branch deletion, or worktree removal.

## Owner Gates

Owner-gated items must be reported with:

- Gate name.
- Why the gate exists.
- Required owner decision.
- Forbidden action until approval.
- Allowed safe alternatives.
- Whether the current task stopped because of the gate.

Owner gates include:

- Implementation authority.
- Cleanup authority.
- Branch deletion or worktree deletion authority.
- Publisher authority.
- GitHub settings, rulesets, branch protection, required checks, secrets, and Actions authority.
- Workflow setup.
- Docker, VPS, Continue, or MCP setup.
- Codex worker execution.
- Sandbox modifications.
- Trading repository or live-boundary work.

The status summary may recommend that the owner decide a gate. It must not treat a recommendation as approval.

## Example 1: Clean Docs-Only Planning Run

| Field | Example value |
| --- | --- |
| `summary_version` | `1` |
| `generated_at` | `2026-05-27T00:00:00Z` |
| `target_repo` | `ckrhehfl/codex-dev-factory` |
| `target_local_path` | Local-verified current-run path |
| `repo_identity` | Local-verified repo root and HEAD |
| `remote_identity` | Local-verified remote URL |
| `current_branch` | `docs/example-summary-format` |
| `base_branch` | `main` |
| `task_branch` | Intended branch matches actual branch; no conflict |
| `worktree_path` | `not_run` |
| `worktree_owner` | `not_run`; no worktree mutation |
| `branch_owner` | Task title and branch name; PR URL `확인 필요` until PR creation |
| `lifecycle_status` | `DOCS_EDITING` or `SELF_REVIEW`, depending on current step |
| `factory_status` | `not_checked` until a future status command exists |
| `validation_result` | Docs-safe checks pending or passed |
| `evidence_classes` | Local-verified repo/branch; authenticated/tool-reported PR state if checked; user-reported task context separated |
| `source_of_truth_classification` | Conversation memory and PR body claims are context only |
| `remaining_confirm_needed` | GitHub settings, branch protection, secrets, plugin/tool versions |
| `owner_gates` | Merge, cleanup, branch deletion, worktree mutation, publisher, worker execution |
| `report_only_actions` | Recommend PR review or owner decision |
| `forbidden_actions_observed` | None |
| `cleanup_boundary` | `cleanup_allowed: false`; `cleanup_performed: false` |
| `recommended_next_action` | Complete self-review and create PR if task contract allows |
| `stop_state` | None |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 2: Stopped Run With 확인 필요 Items

| Field | Example value |
| --- | --- |
| `summary_version` | `1` |
| `target_repo` | `ckrhehfl/codex-dev-factory` |
| `repo_identity` | Local repo root verified, but remote URL mismatch found |
| `remote_identity` | Local-verified mismatch |
| `current_branch` | Local-verified current branch |
| `lifecycle_status` | `STOPPED` |
| `factory_status` | `stopped` |
| `validation_result` | `stopped` because source of truth is unclear |
| `evidence_classes` | Local-verified mismatch; user-reported target remains context |
| `remaining_confirm_needed` | Correct target checkout; whether any files changed before stop |
| `owner_gates` | Owner decision required before continuing in another checkout |
| `report_only_actions` | Report mismatch and safe resume conditions |
| `forbidden_actions_observed` | Continuing branch work from wrong repo would be forbidden |
| `cleanup_boundary` | `cleanup_allowed: false`; `cleanup_performed: false` |
| `recommended_next_action` | Stop and revalidate source of truth from the correct repo |
| `stop_state` | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |

Stopped summary alignment:

- `lifecycle_status: STOPPED`.
- `factory_status: stopped`.
- Registry-backed stop code: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- Cleanup remains false.
- `확인 필요` items remain explicit.

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Example 3: Sandbox Local Status Unavailable

| Field | Example value |
| --- | --- |
| `summary_version` | `1` |
| `target_repo` | `ckrhehfl/codex-dev-factory` |
| `target_local_path` | Local-verified control-plane path |
| `repo_identity` | Control-plane repo verified locally |
| `remote_identity` | Control-plane remote verified locally |
| `worktree_path` | Control-plane worktree local-verified; sandbox local status unavailable |
| `lifecycle_status` | `LOCAL_REVALIDATION` or later current state for the control-plane task |
| `factory_status` | `unknown` only for sandbox local status; control-plane state remains separately reported |
| `validation_result` | Sandbox local status check skipped/blocked, not failed by itself |
| `evidence_classes` | Control-plane facts local-verified; sandbox local status `확인 필요` |
| `remaining_confirm_needed` | Sandbox local branch, worktree cleanliness, local HEAD, and worktree list |
| `owner_gates` | No permission to change Git config or modify sandbox from this control-plane task |
| `report_only_actions` | Record unavailable sandbox local status and continue only if sandbox state is not required |
| `forbidden_actions_observed` | Changing Git safe.directory or modifying sandbox would be forbidden in this task |
| `cleanup_boundary` | `cleanup_allowed: false`; `cleanup_performed: false` |
| `recommended_next_action` | Mark sandbox local status `확인 필요`; do not run `git config --global --add safe.directory ...` |
| `stop_state` | None if sandbox status is not required; otherwise stop/report with plain-language source-of-truth uncertainty or an existing registry-backed code if applicable |

This example records local access constraints without changing Git config, modifying sandbox files, deleting branches, pruning worktrees, or treating sandbox state as verified.

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

## Cross-Document References

This format aligns with:

- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md).
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md).
- [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md).
- [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md).
- [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md).
- [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md).
- [Task Lifecycle State Model](TASK_LIFECYCLE.md).
- [Stop-State Registry](STOP_STATE_REGISTRY.md).
- [Factory Status Result Contract](FACTORY_STATUS_RESULT.md).
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).
- [Task Contract](TASK_CONTRACT.md).
- [PR Metadata Guard Contract](PR_METADATA_GUARD.md).
- [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md).

If future policy adds cleanup permissions, branch/worktree mutation authority, lifecycle states, result statuses, owner gates, or stop codes, it must update every relevant policy surface in the same approved PR.

## Evidence Classification For This PR

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- Open stale branch candidates requested by the task were checked locally and were absent at the time of preflight.
- The worktree list showed only the control-plane main worktree at preflight.
- Required worktree harness, lifecycle, status, validation, metadata, allowed-files, and stop-state docs existed and were inspected before editing.
- Required solution lookup was completed before planning/editing.

### Authenticated/Tool-Reported

- PR #40 was reported by GitHub CLI as `MERGED`.
- PR #40 merge commit was reported by GitHub CLI.
- PR #40 reviews list was reported empty by GitHub CLI.
- Open control-plane PR list was reported empty before this branch was created.
- Remote branches `docs/worktree-result-validation-checklist` and `docs/worktree-status-summary-format` were not returned by read-only remote head lookup during preflight.

### Public/Web-Verified

- Public web verification was not required for this PR because local and authenticated/tool-reported checks were available.

### User-Reported

- The owner reported PR #40 was merged, remote branch deleted, and had no formal reviews.
- The owner reported PR #40 local cleanup was completed.

### 확인 필요

- Sandbox local status, because read-only `git status` was blocked by Git `safe.directory` ownership protection and this task forbids changing Git config.
- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless a future task verifies them.
- Tool/plugin versions beyond `gh --version` checked during preflight.
- Future executable status implementation, if any.
- Future worktree root location, task id format, branch/worktree ownership persistence, retention duration, stale reporting cadence, controlled cleanup policy boundary, publisher authority, and Codex worker execution authority.

## Solution Lookup Result

Applicable solution entries were found and applied:

- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): field list, normative rules, and examples are kept aligned; stopped examples align status, stop state, cleanup state, owner gates, and recommended next action.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): referenced stop codes are registry-backed and no new stop code is introduced.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): forbidden file/action cases use stopped semantics when an existing stop condition applies.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): stopped examples preserve lifecycle context and use the documented field shape.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): local paths are treated as current-run evidence, and unknowns remain explicit.

No directly relevant solution conflicted with this docs-only status summary format scope.

## Safety Field Preservation

This format preserves:

- `scope`.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

Future status summaries, validation results, PR metadata, branch/worktree ownership reports, retention reports, or handoffs must preserve these fields without weakening them.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Changed files are limited to allowed files.
- No sandbox files changed.
- No forbidden workflow, source, script, executable schema, dependency, secret, trading, automation, publisher, cleanup, Discord/Slack, risk cap, or model promotion files changed.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Relative links added by this PR resolve.
- Referenced `STOPPED_*` codes exist in [Stop-State Registry](STOP_STATE_REGISTRY.md).
