# Local Task Format Contract

## Purpose

The local task format is a future input contract for Phase 2 local CLI work. It describes how a task contract may later be represented for local validation, planning, and status reporting.

This PR is docs-only. It does not create task YAML files, schemas, parsers, CLI commands, source code, scripts, workflows, workers, publishers, or automation.

## Conceptual Fields

Future local task files may contain these conceptual fields:

- `id`: a stable local identifier for the task.
- `title`: the short human-readable task title.
- `objective`: the outcome the task should produce.
- `source_of_truth`: context that is trusted, context that still needs revalidation, and repositories or prior work that must not be treated as authoritative by default.
- `scope`: what Codex is allowed to change or prepare.
- `non_goals`: what Codex must not attempt.
- `allowed_files`: exact files or path patterns that may change.
- `forbidden_files`: files or path patterns that must not change.
- `forbidden_actions`: commands, external writes, or operational actions that are out of bounds.
- `validation_plan`: checks, diffs, review steps, or external state checks required before completion.
- `stop_conditions`: named states that require Codex to stop and report instead of continuing.
- `risk_tier`: low, medium, high, or prohibited for the task.
- `owner_decision_required`: actions or conditions that require explicit owner approval.
- `expected_pr_title`: the intended PR title when PR creation is in scope.
- `expected_branch_name`: the intended branch name when branch creation is in scope.
- `notes`: extra context that helps interpretation but does not override the required fields.

These fields are descriptive only. This document intentionally avoids a real `.yaml` file, schema, or parser contract.

## Relationship to Task Contract

The local task format is a serialized form of the [Task Contract](TASK_CONTRACT.md).

The task contract remains the policy source. The local task format is only a future representation that may help local tooling read, validate, and plan from the same policy fields.

If the format and task contract ever conflict, the task contract governs until the owner approves an update.

## Relationship to Phase 2 CLI Skeleton

The [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md) defines future command surfaces that may use this format conceptually:

- `factory task validate` may later validate whether the conceptual fields are present and complete, then report the result using the [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).
- `factory task plan` may later turn a valid task into an execution plan that follows the [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) while preserving scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner decision requirements.
- `factory status` may later report current task state when a local task representation exists.

None of these commands are implemented here.

## Risk and Approval Boundaries

Low-risk docs-only tasks may proceed to commit, push, and PR creation after self-review when the task contract explicitly allows that flow.

Merge remains separate unless explicitly requested.

High-risk tasks, owner-decision tasks, automation tasks, GitHub write tasks, trading tasks, live trading changes, credential handling, risk cap changes, and model promotion changes must stop for owner decision.

The local task format must not be used to bypass owner decisions. A serialized task can describe a gate, but it cannot approve the gated action by itself.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- No task YAML files are added.
- No schema files are added.
- No parser is implemented.
- No CLI implementation is added.
- No source code is added.
- No workflow is added.
- No automation is implemented.

## Stop States

Codex must stop and report the matching state when one applies:

- `STOPPED_LOCAL_TASK_FORMAT_SCOPE_EXPANDED`
- `STOPPED_TASK_YAML_CREATED_TOO_EARLY`
- `STOPPED_SCHEMA_CREATED_TOO_EARLY`
- `STOPPED_PARSER_IMPLEMENTED_TOO_EARLY`
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`
- `STOPPED_CODE_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`
- `STOPPED_OWNER_DECISION_REQUIRED`
