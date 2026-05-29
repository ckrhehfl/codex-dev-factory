# Sandbox Validation Evidence Contract

## Purpose

This document defines the canonical evidence contract for future sandbox validation runs.

Sandbox validation should be evidence-based, repeatable, and auditable. A run should leave enough source, lifecycle, PR, review, merge, cleanup, guard, and owner-decision evidence for the owner to decide whether the sandbox loop passed, failed, blocked, or stopped.

Unknowns must be explicit instead of inferred from memory, handoff notes, public-only views, or previous assistant output.

This is a documentation contract only. It does not create a sandbox repository, run sandbox validation, implement CLI behavior, add automation, write to GitHub, implement PR publisher behavior, create workflows, implement branch cleanup automation, add Discord integration, add trading functionality, connect to a trading repository, add live trading, add credentials, add risk cap logic, or add model promotion logic.

## Non-Goals

This contract does not add:

- CLI implementation.
- GitHub write automation.
- PR publisher implementation.
- Branch cleanup automation.
- GitHub Actions workflows.
- Discord bot or Discord integration.
- Sandbox repository creation.
- Actual sandbox validation runs.
- Trading functionality or trading repository connection.
- Live trading, credentials, risk cap logic, or model promotion logic.

## Evidence Timing

Evidence should be captured conceptually:

- Before sandbox repository creation planning.
- Before a sandbox validation run.
- During docs-only sandbox task execution.
- After PR creation.
- After review-fix, if review feedback exists.
- After merge.
- After local cleanup.
- After post-merge lesson review, if review occurred.
- Before declaring the sandbox validation pass, fail, blocked, unknown, owner-decision, or stopped result.

Evidence capture does not perform the underlying action. It records what was checked, by which source, and what remains unknown.

## Required Evidence Inputs

A sandbox validation evidence packet should include or explicitly mark unavailable:

- Source-of-truth revalidation result.
- Local repository path and remote.
- Sandbox repository identity, if created in a later approved task.
- Task contract.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Lifecycle state transitions.
- PR metadata.
- Review status.
- Merge status.
- Cleanup status.
- Lesson review status.
- Stop-state registry comparison.
- Hidden Unicode local scan result.
- Owner decisions.
- Unknowns / 확인 필요 items.

## Evidence Packet Shape

A future evidence packet should be structured enough for humans and later tooling to inspect. A conceptual packet should include:

- `schema_version`: version of this evidence contract.
- `run_id`: stable identifier for the validation attempt.
- `created_at`: when the evidence packet was created.
- `phase_target`: target such as sandbox validation planning or sandbox validation run.
- `source_of_truth`: local, authenticated GitHub, public GitHub, user-reported, and unknown source status.
- `environment`: local path, OS-relevant assumptions, and tool availability that were checked.
- `repos`: control-plane repo and sandbox repo identity, if available.
- `task`: task contract fields and source.
- `lifecycle_trace`: lifecycle states entered and transition evidence.
- `branch`: branch name, remote tracking state, and cleanup-relevant branch state.
- `pr`: PR number, URL, title, body, changed files, and metadata evidence.
- `review`: review presence, unresolved comments, review-fix commits, and thread outcome evidence.
- `merge`: merge state, merge commit, merge source, and owner approval evidence.
- `cleanup`: remote branch deletion and local branch/worktree cleanup evidence.
- `validation`: commands, checks, skipped checks, and results.
- `guards`: PR metadata, allowed-files, stop-state, safety-field, hidden Unicode, and source-of-truth guard evidence.
- `lessons`: post-merge lesson review decision and related PRs, if any.
- `risk`: risk tier, owner gates, and forbidden action status.
- `safety_fields`: preserved safety-critical task fields.
- `owner_actions`: required or completed owner actions.
- `unknowns`: facts not checked or not available.
- `warnings`: non-blocking cautions.
- `stop_state`: active `STOPPED_*` code when the run is stopped.
- `status`: run result status.
- `recommended_next_action`: next owner or Codex action.

## Lifecycle Trace

The evidence packet should integrate with the [Task Lifecycle State Model](operations/TASK_LIFECYCLE.md).

The trace should record:

- Lifecycle states entered.
- Timestamps or ordering where practical.
- Source of each transition.
- Interrupted state if stopped.
- Owner-controlled transitions.
- Merge and cleanup separation.
- Whether Compound/post-merge lesson review was required, performed, or skipped.

If a task stops and later resumes, the trace must preserve the interrupted lifecycle state when known. Resumption is allowed only when that state remains valid and required checks still pass.

## PR and Review Evidence

PR and review evidence should include:

- PR number.
- PR URL.
- PR title.
- Branch name.
- Changed files.
- PR metadata guard result.
- Review presence.
- Unresolved review comments.
- Review-fix commit IDs.
- Whether review threads were resolved or became outdated.
- Whether review-fix triggered guard re-checks.
- Merge commit.
- Branch deletion status.

If review occurred, post-merge lesson review should be recorded as performed, skipped with reason, or blocked with explicit unknowns.

## Guard Evidence

Evidence should integrate with:

- [PR Metadata Guard Contract](operations/PR_METADATA_GUARD.md).
- [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md).
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).
- [Factory Status Result Contract](FACTORY_STATUS_RESULT.md).

Guard evidence should capture:

- PR metadata completeness.
- Self-review result.
- Confirmations.
- Allowed-files guard.
- Forbidden-files check.
- Forbidden-actions check.
- Stop-state consistency.
- Safety field preservation.
- Hidden Unicode local scan.
- Source-of-truth reporting.

Guard results are evidence only. They do not edit files, update PR metadata, push commits, merge PRs, clean branches, create workflows, or perform automation.

## STOPPED Handling

Evidence packets must integrate with the [Stop-State Registry](STOP_STATE_REGISTRY.md).

When a stop condition applies, the packet must:

- Report `status: stopped`.
- Preserve the specific `STOPPED_*` code.
- Preserve interrupted lifecycle state when known.
- Align `status`, `stop_state`, reason, and `recommended_next_action`.
- Avoid creating new stop codes unless necessary.
- Require registry updates if new stop codes are unavoidable.

## Safety Field Preservation

If the evidence packet summarizes or transforms task, plan, status, validation, PR metadata, or allowed-files data, it must preserve:

- `forbidden_files`.
- `forbidden_actions`.
- Scope.
- Allowed files.
- Validation plan.
- Stop states.
- Risk tier.
- Owner gates.

Dropping these fields is a stop condition.

## Unknown Handling

Use explicit unknown markers such as:

- `unknown`.
- `not_checked`.
- `unavailable`.
- `user_reported_only`.
- `public_view_only`.
- `authenticated_check_required`.
- `local_check_required`.
- `owner_decision_required`.

The evidence contract must not infer unchecked local state, GitHub state, repository settings, PR state, review state, merge state, cleanup state, or owner approval.

## Status Values

Conceptual status values are:

- `passed`: required evidence exists, no blocking gaps remain, and no active stop condition exists.
- `failed`: evidence proves an acceptance criterion failed, but no stop condition is active.
- `blocked`: a prerequisite, owner gate, or external verification blocks the run.
- `stopped`: an active stop condition applies.
- `unknown`: required evidence is unavailable or not checked.
- `owner_decision_required`: the next step requires explicit owner decision.
- `not_run`: validation has not started.

These values are reporting states, not implementation enums in this PR.

## Pass Criteria

A sandbox validation run may pass only when:

- Source of truth was revalidated.
- The sandbox task stayed docs-only.
- Allowed-files and PR metadata guard evidence was captured.
- Validation results were captured.
- PR creation evidence was captured.
- Review, merge, and cleanup outcomes were captured.
- Compound/post-merge lesson review was skipped or performed according to review presence and durable lesson status.
- No unresolved stop conditions remain.
- Unknowns are resolved or explicitly accepted by owner decision.

## Blocking Gaps

Examples of blocking gaps include:

- Sandbox repository identity is not verified when needed.
- Changed files cannot be verified.
- PR metadata is missing `Self-review result` or `Confirmations`.
- Allowed-files violation triggers a stop condition.
- Local cleanup state cannot be verified.
- Review comments cannot be inspected when review-fix evidence is required.
- Source-of-truth state is unclear.
- Owner decision is required before proceeding.

## Owner Decision Model

Owner action categories include:

- Approve sandbox repository creation planning.
- Approve an actual sandbox validation run.
- Review sandbox PR.
- Merge sandbox PR.
- Run local cleanup.
- Perform post-merge lesson review.
- Rerun validation.
- Resolve unknowns.
- Stop and revalidate source of truth.

Owner actions are recommendations or recorded decisions. They do not perform merges, cleanup, GitHub writes, repository creation, or automation.

## Example Evidence Packets

### Docs-Only Sandbox Run Passes With No Review

```yaml
status: passed
phase_target: sandbox_validation_run
task:
  scope: docs_only
guards:
  pr_metadata:
    status: passed
    self_review_result: present
    confirmations: present
  allowed_files:
    status: passed
review:
  presence: none
lessons:
  post_merge_review: skipped_no_review
unknowns: []
recommended_next_action: owner_accept_sandbox_result_or_request_next_validation
```

### Review-Fix Requires Post-Merge Lesson Review

```yaml
status: owner_decision_required
phase_target: sandbox_validation_run
review:
  presence: review_comments_received
  review_fix_commits:
    - abc1234
  threads: resolved_or_outdated
lessons:
  post_merge_review: required
owner_actions:
  - perform_post_merge_lesson_review
recommended_next_action: run_post_merge_lesson_review_before_accepting_sandbox_result
```

### Allowed-Files Violation Stops The Run

```yaml
status: stopped
phase_target: sandbox_validation_run
guards:
  allowed_files:
    status: stopped
    reason: changed_file_outside_allowed_files
stop_state:
  code: STOPPED_FORBIDDEN_FILE_CHANGE
  reason: changed_file_outside_allowed_files
lifecycle_trace:
  interrupted_state: SELF_REVIEW
recommended_next_action: remove_out_of_scope_file_change_or_request_owner_decision
```

### Source Of Truth Cannot Be Verified

```yaml
status: stopped
phase_target: sandbox_validation_run
source_of_truth:
  local_repo: unknown
  remote: unknown
stop_state:
  code: STOPPED_SOURCE_OF_TRUTH_UNCLEAR
  reason: repo_or_remote_state_not_verified
lifecycle_trace:
  interrupted_state: LOCAL_REVALIDATION
recommended_next_action: stop_and_revalidate_source_of_truth_before_continuing
```

## Relationship to Existing Contracts

The [Sandbox Validation](SANDBOX_VALIDATION.md) plan defines the validation loop this evidence packet records.

The [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md) decides whether the project is ready to proceed toward sandbox validation; this evidence contract defines what future sandbox runs should record.

The [Acceptance Tests](ACCEPTANCE_TESTS.md) define docs-only, sandbox, metadata, solution lookup, hidden Unicode, and no-implementation checks that evidence packets may report.

The [Roadmap](ROADMAP.md) defines phase ordering and implementation boundaries.

The [Operating Model](operations/OPERATING_MODEL.md) defines task intake, source-of-truth revalidation, owner gates, PR lifecycle, cleanup, and lesson handling.

The [Task Lifecycle State Model](operations/TASK_LIFECYCLE.md) defines lifecycle states, stopped-state recovery, merge boundaries, cleanup boundaries, and lesson-capture boundaries.

The [Task Contract](operations/TASK_CONTRACT.md), [Local Task Format Contract](LOCAL_TASK_FORMAT.md), and [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) define task and planning fields that evidence packets may summarize.

The [Task Validation Result Contract](TASK_VALIDATION_RESULT.md), [Factory Status Result Contract](FACTORY_STATUS_RESULT.md), [PR Metadata Guard Contract](operations/PR_METADATA_GUARD.md), and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md) define validation, status, PR metadata, and changed-file guard surfaces that evidence packets may report.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns active `STOPPED_*` codes.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) and [Compound Knowledge Base](solutions/README.md) define how durable lessons are found, applied, and reported before planning, before commit, and during review-fix loops.
