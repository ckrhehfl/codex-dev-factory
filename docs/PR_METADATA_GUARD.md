# PR Metadata Guard Contract

## Purpose

This document defines the canonical contract for a future PR metadata guard.

The guard should check PR title and body completeness before PR creation, after PR creation, before merge readiness, and during status reporting when PR metadata has been checked.

The guard preserves task intent, source-of-truth reporting, solution lookup reporting, validation results, risk tier, stop conditions, safety fields, and owner gates so PRs remain reviewable without reconstructing the task from local context.

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

- Before PR creation, validate intended PR metadata generated from the task contract, plan output, validation result, and status result when those surfaces exist.
- After PR creation, verify the actual PR title and body match required metadata using authenticated GitHub state when available.
- Before merge readiness, verify required sections remain present after review-fix updates.
- During `factory status`, report PR metadata guard state if the guard was checked.
- Do not infer unchecked GitHub state from prior conversation, branch name, public-only views, or stale local state.

Required solution lookup must happen before planning when a task touches a lookup-triggering surface. A branch-stage lookup may refresh or extend the result, but it must not be the first required lookup after planning has already started.

## Required PR Metadata Sections

Docs-only PR bodies should include these sections when relevant to the task:

- Summary.
- Scope.
- Non-goals.
- Allowed files changed.
- Solution lookup result.
- Cross-document consistency check.
- Stop-state consistency check.
- Safety field preservation check.
- Hidden Unicode check.
- Validation plan/results.
- Stop conditions.
- Risk tier.
- Self-review result.
- Confirmations.
- Explicit no-implementation notes when relevant.
- Explicit no-auto-merge or owner-controlled merge note.

If a task or plan includes forbidden files/actions, the PR metadata must preserve them rather than reporting only allowed files.

## Required Title Checks

Future title checks should verify:

- The title is concise and reviewable.
- The title matches task intent.
- Docs-only PRs use the `Docs:` prefix unless policy changes later.
- Contract-only PRs do not imply implementation.
- The title does not imply automation, live behavior, trading integration, merge readiness, or cleanup execution when those are out of scope.

## Required Body Field Semantics

| Section | Purpose | Source field or document | Required status | Failure condition | Recommended owner/Codex action |
| --- | --- | --- | --- | --- | --- |
| Summary | Explain what changed. | Task objective and plan summary. | Required. | Missing or contradicts scope. | Complete metadata before review. |
| Scope | Bound the change. | Task Contract and Plan Output. | Required. | Missing, broad, or changed after review-fix without update. | Reconcile with task contract. |
| Non-goals | Preserve excluded work. | Task Contract. | Required. | Missing forbidden implementation or owner-gated actions. | Add explicit non-goals. |
| Allowed files changed | Make changed files reviewable. | Git diff and allowed files. | Required. | Missing, stale, or not matching changed files. | Re-run changed-files check. |
| Solution lookup result | Show applicable lessons. | Solution Lookup Protocol and `docs/solutions/**`. | Required when lookup is required. | Missing, stale, or run only after planning. | Run or refresh lookup and update metadata. |
| Cross-document consistency check | Show policy surfaces stayed aligned. | Relevant docs and task prompt. | Required for policy/docs contracts. | Missing when docs touched shared policy surfaces. | Run consistency check. |
| Stop-state consistency check | Prevent stop-state drift. | Stop-State Registry and local Stop States sections. | Required when stop states are touched or referenced. | Missing or mismatched `STOPPED_*` code. | Update registry/surfaces or stop. |
| Safety field preservation check | Preserve deny-lists and owner gates. | Task, plan, validation, status, and PR metadata. | Required when task fields are transformed or summarized. | Drops `forbidden_files` or `forbidden_actions`. | Restore safety fields before proceeding. |
| Hidden Unicode check | Confirm edited docs do not contain suspicious controls. | Local scan. | Required for docs-only edits. | Missing or suspicious characters found. | Scan, remove, or justify. |
| Validation plan/results | Show evidence. | Task validation and local commands. | Required. | Missing commands/results or unexplained skips. | Re-run validation or document skipped checks. |
| Stop conditions | Show when Codex must stop. | Task Contract and Stop-State Registry. | Required. | Missing applicable stop states. | Add existing stop conditions. |
| Risk tier | Classify risk. | Task Contract and Risk Policy. | Required. | Missing or inconsistent with actions. | Reclassify or stop for owner decision. |
| Self-review result | Show Codex checked the task contract before commit/push/PR. | Task Contract, Acceptance Tests, local self-review output. | Required. | Missing or does not cover changed files, forbidden implementation, validation, and owner gates. | Re-run self-review and update metadata. |
| Confirmations | Preserve explicit safety confirmations. | Task Contract, Acceptance Tests, and task-specific non-goals. | Required. | Missing docs-only, no-workflow, no-code, no-automation, no-trading, or similar required confirmations. | Add task-specific confirmations before review. |
| Explicit no-implementation notes | Prevent scope confusion. | Task non-goals and risk policy. | Required for docs-only planning contracts. | Missing when implementation could be inferred. | Add no-implementation confirmation. |
| Owner-controlled merge note | Preserve merge boundary. | Task Lifecycle and GitHub Operating Policy. | Required. | Missing or implies auto-merge. | Add owner-controlled merge note. |

## Result Shape

Future PR metadata guard output should include:

- `schema_version`.
- `checked_at`.
- `source_of_truth`.
- `pr`.
- `task`.
- `metadata_sections`.
- `title_check`.
- `body_check`.
- `solution_lookup_check`.
- `validation_check`.
- `risk_check`.
- `safety_field_check`.
- `stop_conditions_check`.
- `self_review_check`.
- `confirmations_check`.
- `owner_gate_check`.
- `unknowns`.
- `warnings`.
- `status`.
- `recommended_next_action`.

The result is reporting only. It does not create, update, merge, or close a PR.

## Status Values

Conceptual status values are:

- `passed`: required metadata is present and consistent.
- `failed`: required metadata is missing, contradictory, stale, or unsafe.
- `not_checked`: the guard did not run.
- `unknown`: the required source could not be verified.
- `owner_decision_required`: the guard found a gate that requires owner decision.
- `stopped`: an existing stop state applies.

These values are not new `STOPPED_*` codes. If a specific stop reason is needed, use the [Stop-State Registry](STOP_STATE_REGISTRY.md).

## Source-of-Truth Reporting

The guard must distinguish:

- `local_verified_generated_metadata`: metadata drafted from local task, plan, validation, or status output.
- `authenticated_github_verified_pr_metadata`: title/body read through authenticated GitHub tooling.
- `public_github_visible_pr_metadata`: public view only.
- `user_reported_pr_metadata`: owner-reported but not independently verified.
- `unknown`: not checked or not available.

The guard must not rely on public-only or user-reported metadata for owner-gated merge decisions without marking the state as requiring authenticated verification.

## Safety Field Preservation

If PR metadata summarizes or transforms task, plan, status, or validation data, it must preserve:

- `forbidden_files`.
- `forbidden_actions`.
- Scope.
- Allowed files.
- Validation plan.
- Stop states.
- Risk tier.
- Owner gates.

PR metadata that preserves allowed files while dropping forbidden files/actions is incomplete and unsafe. Dropping safety fields triggers `STOPPED_SAFETY_FIELD_DROPPED`.

## Failure Handling

The guard should report failures without mutating GitHub state.

Common failures include:

- Missing required section.
- Contradictory section.
- Stale solution lookup.
- Missing validation results.
- Missing risk tier.
- Missing stop conditions.
- Unsafe implication of implementation.
- Missing owner-controlled merge note.
- Mismatch between changed files and allowed files.
- Checked source unavailable.

When the failure is metadata-only, the recommended action is to update PR metadata before review or merge readiness.

When the failure indicates unsafe scope, owner gating, missing source-of-truth verification, dropped safety fields, or stop-state mismatch, report the matching existing stop state.

## Relationship to Existing Contracts

The [Task Contract](TASK_CONTRACT.md) defines task fields that PR metadata must preserve.

The [Local Task Format Contract](LOCAL_TASK_FORMAT.md) may later serialize task fields that feed metadata drafts.

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) defines PR metadata draft fields and merge boundary expectations.

The [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) provides validation status and safety-field checks that metadata should report.

The [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) may later report PR metadata guard status and unknowns.

The [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines PR-created, review-pending, review-fix, merge-ready, stopped, and owner-gated lifecycle behavior.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns `STOPPED_*` codes used when the guard finds a blocking condition.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) defines solution lookup timing and reporting.

The [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md) may provide changed-files evidence for PR metadata checks, but this PR does not implement that guard.

## Example Results

### Complete Low-Risk Docs-Only PR Metadata Passes

```yaml
schema_version: 1
status: passed
title_check:
  status: passed
  title: "Docs: define example contract"
body_check:
  required_sections: passed
solution_lookup_check:
  status: passed
  timing: pre_planning
safety_field_check:
  status: passed
  preserves:
    - forbidden_files
    - forbidden_actions
risk_check:
  tier: low-risk docs-only
owner_gate_check:
  merge_note: owner_controlled
recommended_next_action: review_pr
```

### PR Body Missing Solution Lookup Result Fails

```yaml
schema_version: 1
status: failed
solution_lookup_check:
  status: failed
  failure: missing_required_section
  required_timing: pre_planning
recommended_next_action: update_pr_metadata_before_review
```

### PR Metadata Cannot Be Authenticated

```yaml
schema_version: 1
status: unknown
source_of_truth:
  pr_metadata: public_github_visible_pr_metadata
unknowns:
  - field: authenticated_pr_body
    reason: authenticated_check_required
recommended_next_action: revalidate_source_of_truth
```

### Review-Fix Changed Scope and Requires Metadata Re-Check

```yaml
schema_version: 1
status: owner_decision_required
metadata_sections:
  scope:
    status: stale
body_check:
  failure: review_fix_scope_changed_without_metadata_update
owner_gate_check:
  status: owner_decision_required
recommended_next_action: reconcile_scope_or_stop
```

## Stop Conditions

The canonical stop-state surface is [Stop-State Registry](STOP_STATE_REGISTRY.md).

Use existing stop states when a blocking condition applies, including:

- `STOPPED_PR_METADATA_INCOMPLETE`.
- `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- `STOPPED_SAFETY_FIELD_DROPPED`.
- `STOPPED_OWNER_DECISION_REQUIRED`.

Do not create new `STOPPED_*` codes unless necessary. If a future PR adds or changes a stop code, it must update the registry and every relevant local Stop States section in the same PR.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No PR metadata guard implementation is added.
- No PR publisher behavior is added.
- No GitHub write automation is added.
- No source code is added.
- No workflows are added.
- No branch cleanup automation is added.
- No Discord or trading functionality is added.
- PR metadata reporting preserves task intent, source-of-truth reporting, solution lookup reporting, validation results, risk tier, stop conditions, safety fields, and owner gates.
