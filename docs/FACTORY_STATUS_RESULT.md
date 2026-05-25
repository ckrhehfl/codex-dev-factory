# Factory Status Result Contract

## Purpose

This document defines the canonical result contract for a future `factory status` command.

The status result should summarize the factory's current local repository, task, PR, validation, lifecycle, risk, and owner-action state without mutating anything.

Unknowns must be explicit. The result must not guess repo state, PR state, GitHub settings, branch cleanup state, or owner decisions from stale context, prior conversation, or public-only views.

This contract supports safe owner decisions before any CLI implementation exists. It is documentation only.

## Non-Goals

This document does not add:

- CLI implementation.
- GitHub write automation.
- PR publisher behavior.
- Branch cleanup automation.
- GitHub Actions workflows.
- Discord bot integration.
- Trading functionality or trading repository connection.
- Credentials, live trading, risk cap, or model promotion logic.

## Result Shape

Future `factory status` output should be structured enough for humans and later tooling to inspect. A conceptual result should include:

- `schema_version`: version of this status result contract.
- `generated_at`: when the status was produced.
- `repo`: repository identity and local path.
- `source_of_truth`: which facts were locally verified, authenticated, public-only, user-reported, or unknown.
- `local_git`: local repository and worktree state.
- `remote_git`: remote branch and fetch state.
- `task`: active task identity and contract summary when available.
- `lifecycle`: task lifecycle state from the [Task Lifecycle State Model](TASK_LIFECYCLE.md).
- `pr`: pull request state when available.
- `validation`: validation summary and command results.
- `risk`: risk tier and owner gates.
- `safety_fields`: safety-critical task fields preserved from task, validation, or plan data.
- `stop_state`: active stop state, if any.
- `owner_actions`: owner actions needed before proceeding.
- `unknowns`: facts that were not checked or could not be verified.
- `warnings`: non-blocking concerns.
- `next_recommended_action`: the next safe action or stop recommendation.

No field in the result approves an owner-gated action by itself.

## Source-of-Truth Reporting

The status result must distinguish these source levels:

- `local_verified`: checked in the local repository or filesystem during the current run.
- `authenticated_github_verified`: checked through authenticated GitHub tooling during the current run.
- `public_github_visible`: visible from a public GitHub view, but not authenticated or not current enough for owner-gated actions.
- `user_reported_only`: provided by the owner or prompt, but not independently verified yet.
- `unknown`: not known and not safe to infer.

When a field depends on GitHub settings, PR review state, branch deletion, merge state, or remote branch cleanup, the status result must say how that fact was verified.

## Local Git Status Reporting

The `local_git` section should include future fields for:

- `repo_path`.
- `remote_url`.
- `current_branch`.
- `default_branch`.
- `head_commit`.
- `working_tree_clean`.
- `untracked_files`.
- `ahead_behind`.
- `last_fetch_prune`.
- `main_fast_forward_pull`.
- `local_branch_cleanup_state` when cleanup is relevant.

Local cleanup state must remain local-verified. A deleted remote branch does not prove local branch cleanup is done.

## Task and Lifecycle Reporting

The `lifecycle` section should integrate with the [Task Lifecycle State Model](TASK_LIFECYCLE.md).

It should include:

- `current_state`.
- `previous_state`.
- `interrupted_state` when stopped and known.
- `allowed_next_states`.
- `blocked_transitions`.
- `required_checks_before_proceeding`.
- `owner_gate_status`.

Required solution lookup must happen before planning when the task touches a lookup-triggering surface. Status may report whether lookup was completed, but it must not treat a branch-stage lookup as the first required pre-planning lookup unless planning has not started.

## STOPPED Handling

The `stop_state` section should integrate with the [Stop-State Registry](STOP_STATE_REGISTRY.md).

When work is stopped, the status result must:

- Report the specific `STOPPED_*` code when known.
- Report the trigger and source surface for the stop state.
- Preserve the interrupted lifecycle state when known.
- Avoid assuming the task can resume until required checks pass.
- Recommend returning to the interrupted lifecycle state only when that state is still valid and its required checks still pass.
- Otherwise recommend revalidation from the earliest lifecycle state needed to validate changed assumptions.

`STOPPED` is a lifecycle state. Specific stop reasons remain `STOPPED_*` codes owned by the registry.

## PR Status Reporting

The `pr` section should include future fields for:

- `number`.
- `url`.
- `title`.
- `branch`.
- `merge_state`.
- `review_state`.
- `unresolved_review_comments`.
- `review_fix_required`.
- `merge_readiness`.
- `auto_merge_status` when verified.
- `branch_deletion_status` when verified.

Unknown PR state must remain explicit. A public page, stale local branch name, or previous assistant answer must not be treated as current PR source of truth.

## Validation Summary

The `validation` section should integrate with the [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).

It should include:

- `validation_status`.
- `commands_run`.
- `command_results`.
- `skipped_validations` with reasons.
- `failed_validations`.
- `hidden_unicode_scan`.
- `changed_files_check`.
- `allowed_files_check`.
- `stop_state_registry_comparison` when relevant.

Skipped checks are not failures by default, but they must remain visible so the owner can decide whether to proceed.

## Safety Field Preservation

If the status result summarizes or transforms task, plan, validation, or PR metadata, it must preserve:

- `forbidden_files`.
- `forbidden_actions`.
- Scope.
- Allowed files.
- Validation plan.
- Stop states.
- Risk tier.
- Owner gates.

Status output must not report only allow-lists while dropping deny-lists. Dropping safety fields triggers `STOPPED_SAFETY_FIELD_DROPPED`.

## Unknown Handling

The status result must not infer unknown repo, PR, branch, cleanup, GitHub settings, or validation state.

Use explicit markers such as:

- `unknown`.
- `not_checked`.
- `unavailable`.
- `user_reported_only`.
- `public_view_only`.
- `authenticated_check_required`.
- `local_check_required`.

Unknown fields should appear in `unknowns` with the check needed to resolve them.

## Owner Action Model

The `owner_actions` section should use clear categories:

- `no_action_required`.
- `review_pr`.
- `merge_pr`.
- `run_cleanup`.
- `resolve_owner_decision`.
- `rerun_validation`.
- `revalidate_source_of_truth`.
- `inspect_github_settings`.
- `stop_and_escalate`.

Owner actions are recommendations. They do not perform merges, cleanup, settings changes, or external writes.

## Example Outputs

### Clean Main, No Active PR

```yaml
schema_version: 1
repo:
  source: local_verified
  repo_path: C:\Dev\codex-dev-factory
local_git:
  current_branch: main
  working_tree_clean: true
  ahead_behind: "0 ahead, 0 behind"
lifecycle:
  current_state: DONE
pr:
  state: not_checked
validation:
  validation_status: not_checked
stop_state:
  code: null
owner_actions:
  - no_action_required
unknowns:
  - field: active_pr
    reason: not_checked
next_recommended_action: no_action_required
```

### Active Docs-Only PR Awaiting Review or Merge

```yaml
schema_version: 1
local_git:
  current_branch: docs/example-contract
  working_tree_clean: true
lifecycle:
  current_state: PR_CREATED
  allowed_next_states:
    - REVIEW_PENDING
    - MERGE_READY
pr:
  number: 42
  url: https://github.com/example/repo/pull/42
  review_state: authenticated_github_verified
  merge_readiness: owner_decision_required
validation:
  validation_status: passed
risk:
  tier: low-risk docs-only
owner_actions:
  - review_pr
  - merge_pr
next_recommended_action: review_pr
```

### Stopped Task With Interrupted Lifecycle State

```yaml
schema_version: 1
lifecycle:
  current_state: STOPPED
  interrupted_state: REVIEW_FIX_REQUIRED
  required_checks_before_proceeding:
    - verify owner decision
    - confirm changed files remain allowed
stop_state:
  code: STOPPED_OWNER_DECISION_REQUIRED
  source: stop_state_registry
  resume_rule: return_to_interrupted_state_only_if_still_valid
owner_actions:
  - resolve_owner_decision
unknowns:
  - field: whether_interrupted_state_still_valid
    reason: local_check_required
next_recommended_action: revalidate_source_of_truth
```

## Relationship to Existing Contracts

The [Task Contract](TASK_CONTRACT.md) defines task fields that status may summarize.

The [Local Task Format Contract](LOCAL_TASK_FORMAT.md) may later provide serialized task data, but status must still preserve owner gates and safety fields.

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) defines planned execution output that status may report, but status must not weaken the plan boundary.

The [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) defines validation result details that status may summarize.

The [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines lifecycle states, interrupted-state recovery, merge boundaries, cleanup boundaries, and lesson-capture boundaries.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns specific stop codes. Status reports those codes; it does not invent replacements.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) defines lookup timing and PR metadata expectations. Status may report lookup completion, but required lookup remains pre-planning for lookup-triggering tasks.

Future PR metadata guards and allowed-files guards may consume status output conceptually, but this PR does not implement those guards.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No status result files are added.
- No CLI implementation is added.
- No source code is added.
- No workflow is added.
- No GitHub write automation is implemented.
- No branch cleanup automation is implemented.
- No Discord or trading functionality is added.
- Unknowns, stop states, interrupted lifecycle state, owner gates, and safety fields are preserved.
