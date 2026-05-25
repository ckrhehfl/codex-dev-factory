# Allowed-Files Guard Result Contract

## Purpose

This document defines the canonical result contract for a future allowed-files guard.

The guard should check changed files against task-declared file boundaries so scope creep, forbidden file edits, and implementation leaks are visible before commit, PR creation, review-fix completion, or merge readiness.

If the guard summarizes or transforms task, plan, validation, status, or PR metadata, it must preserve safety-critical task fields, including allowed files, `forbidden_files`, `forbidden_actions`, validation plan, stop states, risk tier, and owner gates.

This is a documentation contract only. It does not implement CLI behavior, GitHub writes, PR publisher behavior, automation, workflows, auto-merge, branch cleanup, Discord integration, trading functionality, or runtime enforcement.

## Non-Goals

This document does not add:

- CLI implementation.
- GitHub write automation.
- PR publisher implementation.
- Auto-merge or merge automation.
- Branch cleanup automation.
- GitHub Actions workflows.
- Discord bot integration.
- Trading functionality or trading repository connection.
- Credentials, live trading, risk cap, or model promotion logic.

## Guard Timing

Future guard timing should be explicit:

- Before editing, check the task's intended allowed and forbidden file boundaries.
- Before commit, compare actual changed files against allowed files and forbidden files.
- Before PR creation, report the result in PR metadata.
- After review-fix commits, re-check changed files if new commits are added.
- Before merge readiness, confirm no out-of-scope files were introduced.
- During `factory status`, report allowed-files guard state if the guard was checked.
- Do not infer unchecked local or GitHub state from prior conversation, branch name, public-only views, or stale local state.

Required solution lookup must happen before planning when a task touches allowed files, forbidden files, forbidden actions, PR metadata, validation result, plan output, status output, lifecycle, or stop-state surfaces. Branch-stage lookup may refresh or extend the result, but it must not be the first required lookup after planning has already started.

## Required Inputs

Future allowed-files guard input should include:

- Task scope.
- Non-goals.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- Validation plan.
- Risk tier.
- Owner gates.
- Stop conditions.
- Changed files.
- Generated, edited, deleted, and renamed file classification.
- Source of changed-file data.

Missing allow-list or deny-list fields should be reported instead of inferred.

## Result Shape

Future allowed-files guard output should include:

- `schema_version`.
- `checked_at`.
- `source_of_truth`.
- `task`.
- `changed_files`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `scope_check`.
- `non_goals_check`.
- `allowed_files_check`.
- `forbidden_files_check`.
- `forbidden_actions_check`.
- `docs_only_check`.
- `generated_files_check`.
- `deleted_files_check`.
- `renamed_files_check`.
- `risk_check`.
- `owner_gate_check`.
- `stop_state`.
- `unknowns`.
- `warnings`.
- `status`.
- `recommended_next_action`.

The result is reporting only. It does not edit files, stage changes, commit, push, create PRs, update PR metadata, merge, or clean branches.

## Status Values

Conceptual status values are:

- `passed`: changed files are within the declared boundaries.
- `failed`: changed files violate allowed files, forbidden files, forbidden actions, scope, non-goals, risk tier, or owner gates.
- `not_checked`: the guard did not run.
- `unknown`: the required source could not be verified.
- `owner_decision_required`: the guard found a boundary that only the owner can change or approve.
- `stopped`: an existing stop state applies.

These values are not new `STOPPED_*` codes. If a specific stop reason is needed, use the [Stop-State Registry](STOP_STATE_REGISTRY.md).

## Source-of-Truth Reporting

The guard must distinguish changed-file sources:

- `local_git_changed_files`: unstaged and staged local diff state.
- `staged_files`: files currently staged for commit.
- `authenticated_github_pr_diff_files`: PR diff files read through authenticated GitHub tooling.
- `public_github_visible_pr_diff_files`: public PR diff only.
- `user_reported_changed_files`: owner-reported but not independently verified.
- `unknown`: not checked or not available.

When local diff and PR diff disagree, the guard should report both sources and mark the result as failed or unknown until the task decides which source is authoritative.

The guard must not rely on public-only or user-reported changed files for owner-gated merge decisions without marking the state as requiring authenticated or local verification.

## Matching Semantics

Future matching should be deterministic and auditable:

- Exact file paths match only the normalized repository-relative path.
- Directory prefixes match descendants inside that directory.
- Glob-like patterns may be used only when the task contract or future format explicitly documents them.
- Generated files are still changed files and must be allowed or separately owner-approved.
- Deleted files are changed files and must be allowed or separately owner-approved.
- Renamed files should check both the old path and the new path when available.
- Repository path matching should be case-sensitive unless a future implementation explicitly records a different normalization rule. Windows filesystem behavior must not silently broaden repository path matching.
- Path normalization should remove current-directory prefixes and reject traversal outside the repository root.
- Files not covered by allowed files fail the allowed-files check.
- Files explicitly covered by forbidden files fail even if they also match allowed files.
- Ambiguous files should be reported as unknown or failed until the owner clarifies the task boundary.

Forbidden-file matches take precedence over allowed-file matches.

## Failure Handling

The guard should report failures without mutating local or GitHub state.

Common failures include:

- Changed file outside allowed files.
- Changed file inside forbidden files.
- Missing `allowed_files`.
- Missing `forbidden_files`.
- Missing `forbidden_actions`.
- Changed file violates non-goals.
- Changed file implies implementation when the scope is docs-only.
- Changed file requires owner decision.
- Changed-file source is unavailable.
- PR diff and local diff disagree.

When a changed file is outside the allowed files or inside forbidden files, the result should stop with `STOPPED_FORBIDDEN_FILE_CHANGE`.

When a transformation preserves allowed files but drops `forbidden_files` or `forbidden_actions`, the result should stop with `STOPPED_SAFETY_FIELD_DROPPED`.

When the failure is metadata-only and the changed files are otherwise in scope, the recommended action may be to update PR metadata before review or merge readiness.

## Safety Field Preservation

If the allowed-files guard summarizes or transforms task, plan, status, validation, or PR metadata, it must preserve:

- `forbidden_files`.
- `forbidden_actions`.
- Scope.
- Allowed files.
- Validation plan.
- Stop states.
- Risk tier.
- Owner gates.

The guard must not report only allow-lists while dropping deny-lists. Dropping safety fields triggers `STOPPED_SAFETY_FIELD_DROPPED`.

## STOPPED Handling

The canonical stop-state surface is [Stop-State Registry](STOP_STATE_REGISTRY.md).

The guard should use existing stop states when a blocking condition applies, including:

- `STOPPED_FORBIDDEN_FILE_CHANGE`.
- `STOPPED_SAFETY_FIELD_DROPPED`.
- `STOPPED_OWNER_DECISION_REQUIRED`.
- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.

If a forbidden or out-of-scope file edit is found, the result should stop and preserve the interrupted lifecycle state when known.

Do not create new `STOPPED_*` codes unless necessary. If a future PR adds or changes a stop code, it must update the registry and every relevant local Stop States section in the same PR.

## Owner Action Model

Future owner action categories may include:

- `no_action_required`.
- `remove_out_of_scope_file_change`.
- `split_into_separate_pr`.
- `update_task_allowed_files_after_owner_approval`.
- `stop_and_escalate`.
- `rerun_guard_after_review_fix`.
- `revalidate_local_or_pr_diff_source`.

Owner actions are recommendations, not automation.

## Relationship to Existing Contracts

The [Task Contract](TASK_CONTRACT.md) defines the source task fields that the guard checks.

The [Local Task Format Contract](LOCAL_TASK_FORMAT.md) may later serialize `allowed_files`, `forbidden_files`, and `forbidden_actions`.

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) defines future execution plans that must preserve file boundaries before work begins.

The [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) defines validation output that may report whether file-boundary fields are complete enough for planning.

The [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) may later report allowed-files guard state and changed-file unknowns.

The [PR Metadata Guard Contract](PR_METADATA_GUARD.md) may later consume allowed-files guard results for PR body completeness checks.

The [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines when self-review, review-fix, merge-readiness, and stopped-state recovery happen.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns `STOPPED_*` codes used when the guard finds a blocking condition.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) defines lookup timing and reporting for tasks that touch guard, metadata, validation, planning, status, lifecycle, or stop-state surfaces.

## Example Results

### Docs-Only PR Changes Only Allowed Docs And Passes

```yaml
schema_version: 1
status: passed
source_of_truth:
  changed_files: local_git_changed_files
changed_files:
  - path: docs/ALLOWED_FILES_GUARD.md
    change_type: added
allowed_files_check:
  status: passed
forbidden_files_check:
  status: passed
forbidden_actions_check:
  status: passed
docs_only_check:
  status: passed
recommended_next_action: create_pr
```

### PR Changes A Forbidden Workflow File And Stops

```yaml
schema_version: 1
status: stopped
changed_files:
  - path: .github/workflows/checks.yml
    change_type: added
forbidden_files_check:
  status: failed
  reason: workflow_file_forbidden
stop_state:
  code: STOPPED_FORBIDDEN_FILE_CHANGE
recommended_next_action: remove_out_of_scope_file_change
```

### Review-Fix Adds Out-Of-Scope File And Requires Re-Check

```yaml
schema_version: 1
status: failed
source_of_truth:
  changed_files: authenticated_github_pr_diff_files
changed_files:
  - path: docs/ALLOWED_FILES_GUARD.md
    change_type: modified
  - path: scripts/guard-check.ps1
    change_type: added
scope_check:
  status: failed
  reason: review_fix_added_implementation_file
recommended_next_action: split_into_separate_pr
```

### Changed-File Source Is Unavailable

```yaml
schema_version: 1
status: unknown
source_of_truth:
  changed_files: unknown
unknowns:
  - field: changed_files
    reason: local_check_required
recommended_next_action: revalidate_local_or_pr_diff_source
```

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No allowed-files guard implementation is added.
- No source code is added.
- No workflows are added.
- No GitHub write automation or PR publisher behavior is added.
- No branch cleanup automation is added.
- No Discord or trading functionality is added.
- Changed-file reporting preserves allowed files, forbidden files, forbidden actions, scope, validation plan, stop states, risk tier, and owner gates.
