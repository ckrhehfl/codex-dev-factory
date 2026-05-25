# Plan Output Contract

## Purpose

The plan output is the future result of `factory task plan`. It describes how a valid local task may later be transformed into an execution plan that Codex and the owner can inspect before work begins.

This PR is docs-only. It does not create plan files, task YAML files, schemas, parsers, CLI commands, source code, scripts, workflows, workers, publishers, or automation.

## Relationship to Task Contract

A plan is derived from a valid [Task Contract](TASK_CONTRACT.md). The plan must not weaken the task contract or silently narrow the safety checks that were present in the task.

Future planning should consume only successful validation results described in [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).

Future planning should also preserve the lifecycle gates described in [Task Lifecycle State Model](TASK_LIFECYCLE.md), including separate merge, cleanup, and lesson-capture boundaries.

The plan must preserve:

- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner decision requirements.

If a task field is ambiguous, missing, or unsafe, `factory task plan` must be expected to stop rather than produce a weaker plan.

## Required Plan Sections

Future plan output should include these sections:

- Task identity: the task id, title, expected branch name, and expected PR title when available.
- Objective: the outcome the task should produce.
- Source-of-truth assumptions: what context is trusted, what must be revalidated, and what must not be treated as authoritative by default.
- Scope: what Codex is allowed to change or prepare.
- Non-goals: what Codex must not attempt.
- `allowed_files`: exact files or path patterns that may change.
- `forbidden_files`: files or path patterns that must not change.
- `forbidden_actions`: commands, external writes, or operational actions that are out of bounds.
- `validation_plan`: checks, diffs, review steps, or external state checks required before completion.
- `stop_conditions`: named states that require Codex to stop and report instead of continuing.
- `risk_tier`: low, medium, high, or prohibited for the task.
- `owner_decision_required`: actions or conditions that require explicit owner approval.
- `execution_steps`: the intended work sequence, bounded by scope and non-goals.
- `preflight_checks`: checks required before edits, commits, pushes, or PR creation.
- `self_review_checks`: checks required before completion is reported.
- PR metadata draft: Scope, Non-goals, Allowed files, Forbidden files, Forbidden actions, Validation plan, Stop conditions, Risk tier, Self-review result, and Confirmations.
- Merge boundary: a clear statement that merge remains separate unless explicitly requested.

## Safety Field Preservation

`forbidden_files` and `forbidden_actions` are first-class safety fields. They must be preserved whenever a task is validated, planned, reported, or converted into PR metadata.

Task-to-plan transformation must never drop deny-list fields. A plan that preserves `allowed_files` but drops `forbidden_files` or `forbidden_actions` is incomplete and unsafe.

Dropping safety fields triggers `STOPPED_SAFETY_FIELD_DROPPED`.

## Relationship to Phase 2 CLI Skeleton

The [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md) defines future command surfaces that may use this contract conceptually:

- `factory task validate` may later check task completeness and produce a validation result before planning.
- `factory task plan` may later produce plan output that follows this contract.
- `factory status` may later report task, validation, lifecycle, and plan state using the [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) without mutating repository or GitHub state.

None of these commands are implemented here.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No plan files are added.
- No task YAML files are added.
- No schema files are added.
- No parser is implemented.
- No CLI implementation is added.
- No source code is added.
- No workflow is added.
- No automation is implemented.

## Stop States

The canonical stop-state surface is [Stop-State Registry](STOP_STATE_REGISTRY.md). Codex must stop and report the matching state when one applies:

- `STOPPED_PLAN_OUTPUT_SCOPE_EXPANDED`
- `STOPPED_SAFETY_FIELD_DROPPED`
- `STOPPED_PLAN_FILE_CREATED_TOO_EARLY`
- `STOPPED_TASK_YAML_CREATED_TOO_EARLY`
- `STOPPED_SCHEMA_CREATED_TOO_EARLY`
- `STOPPED_PARSER_IMPLEMENTED_TOO_EARLY`
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`
- `STOPPED_CODE_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`
- `STOPPED_OWNER_DECISION_REQUIRED`
