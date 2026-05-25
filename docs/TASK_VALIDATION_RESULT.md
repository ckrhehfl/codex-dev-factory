# Task Validation Result Contract

## Purpose

The task validation result is the future output of `factory task validate`. It describes how future local tooling may report whether a task contract is complete enough for planning.

This PR is docs-only. It does not create validation result files, task YAML files, schemas, parsers, CLI commands, source code, scripts, workflows, workers, publishers, or automation.

## Relationship to Task Contract

Validation checks whether a [Task Contract](TASK_CONTRACT.md) is complete enough for planning. It must not weaken the task contract, infer missing safety fields, or drop fields that were present in the task.

Validation may report whether a task is ready to move through the lifecycle described in [Task Lifecycle State Model](TASK_LIFECYCLE.md), but it must not skip source-of-truth revalidation, owner gates, merge boundaries, cleanup checks, or lesson-capture boundaries.

Validation must preserve:

- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner decision requirements.

A task that fails validation is not valid for planning. If required task fields are missing, ambiguous, or unsafe, the validation result should recommend a stop state instead of allowing planning to continue.

## Required Validation Result Sections

Future validation result output should include these sections:

- Task identity: the task id, title, expected branch name, and expected PR title when available.
- Validation status: whether the task is valid for planning, incomplete, blocked, or unsafe.
- Required field completeness: whether the required task fields are present.
- Missing required fields: a list of required fields that are absent.
- Invalid or ambiguous fields: fields whose values are unclear, contradictory, unsafe, or too broad.
- Source-of-truth assumptions result: whether trusted context and revalidation needs are stated.
- Scope result: whether the allowed scope is clear.
- Non-goals result: whether excluded work is clear.
- `allowed_files` result: whether the allow-list is present and bounded.
- `forbidden_files` result: whether the deny-list for files or paths is present, preserved, and visible.
- `forbidden_actions` result: whether the deny-list for commands, external writes, or operational actions is present, preserved, and visible.
- `validation_plan` result: whether required checks and review steps are stated.
- `stop_conditions` result: whether named stop states are present and usable.
- `risk_tier` result: whether risk is classified as low, medium, high, or prohibited.
- `owner_decision_required` result: whether owner gates are explicit.
- `safety_field_preservation` result: whether safety fields are preserved across validation, planning, status reporting, and PR metadata drafting.
- Recommended next action: the next safe state for the task.

## Recommended Next Actions

Future validation result output may use these conceptual next actions:

- `VALID_FOR_PLANNING`: the task is complete enough for `factory task plan`.
- `STOPPED_TASK_CONTRACT_INCOMPLETE`: required task fields are missing.
- `STOPPED_OWNER_DECISION_REQUIRED`: the task needs explicit owner approval before planning or execution can continue.
- `STOPPED_SAFETY_FIELD_DROPPED`: safety fields were dropped or not preserved.
- `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD`: a field is unsafe, contradictory, forbidden, or too ambiguous for planning.

These next actions are reporting states only. They do not execute Codex, create branches, create commits, push, create PRs, merge, or modify repository state.

## Safety Field Validation

`forbidden_files` and `forbidden_actions` are first-class safety fields. They must be checked, preserved, and reported.

Validation must not treat allow-lists as a replacement for deny-lists. A result that reports `allowed_files` but omits `forbidden_files` or `forbidden_actions` is incomplete.

Dropping or ignoring deny-list fields triggers `STOPPED_SAFETY_FIELD_DROPPED`.

Future PR metadata guard checks may summarize validation results, but they must preserve failed, skipped, and owner-gated validation outcomes rather than turning them into generic pass/fail text.

Future allowed-files guard checks may summarize validation results about file-boundary completeness, but they must preserve missing or ambiguous `allowed_files`, `forbidden_files`, and `forbidden_actions` outcomes rather than inferring safe defaults.

## Relationship to Phase 2 CLI Skeleton

The [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md) defines future command surfaces that may use this contract conceptually:

- `factory task validate` may later produce this validation result.
- `factory task plan` may later consume only successful validation results.
- `factory status` may later report the latest validation state using the [Factory Status Result Contract](FACTORY_STATUS_RESULT.md).

None of these commands are implemented here.

## Relationship to Plan Output

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) depends on successful validation. Future planning must preserve the same safety fields that validation checked, including `forbidden_files` and `forbidden_actions`.

If validation result output marks a task as incomplete, blocked, unsafe, or owner-gated, `factory task plan` must be expected to stop rather than produce a weaker plan.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No validation result files are added.
- No task YAML files are added.
- No schema files are added.
- No parser is implemented.
- No CLI implementation is added.
- No source code is added.
- No workflow is added.
- No automation is implemented.

## Stop States

The canonical stop-state surface is [Stop-State Registry](STOP_STATE_REGISTRY.md). Codex must stop and report the matching state when one applies:

- `STOPPED_VALIDATION_RESULT_SCOPE_EXPANDED`
- `STOPPED_SAFETY_FIELD_DROPPED`
- `STOPPED_VALIDATION_FILE_CREATED_TOO_EARLY`
- `STOPPED_TASK_YAML_CREATED_TOO_EARLY`
- `STOPPED_SCHEMA_CREATED_TOO_EARLY`
- `STOPPED_PARSER_IMPLEMENTED_TOO_EARLY`
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`
- `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD`
- `STOPPED_CODE_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`
- `STOPPED_OWNER_DECISION_REQUIRED`
