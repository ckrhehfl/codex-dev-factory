# Phase 2 CLI Skeleton Contract

## Purpose

Phase 2 is local CLI skeleton planning before implementation. It defines the intended command surfaces, validation boundaries, and forbidden behavior for a future local `factory` CLI.

This document is policy and design only. It does not implement CLI commands, create source code, create scripts, create task YAML files, create schemas, or add automation.

The future local task representation is described in [Local Task Format Contract](LOCAL_TASK_FORMAT.md). Phase 2 commands may use that representation conceptually, but no task files, schemas, parser, or CLI implementation exist yet.

## Planned Command Surfaces

The first planned command surfaces are:

- `factory task validate`
- `factory task plan`
- `factory status`

These names describe future local command behavior. They are not implemented in this PR.

## `factory task validate`

`factory task validate` is intended to validate future task contract completeness.

If a local task representation exists in a later phase, this command may validate it against the conceptual fields in the local task format contract.

Conceptually, it should check whether a task includes:

- Task title.
- Objective.
- Source-of-truth assumptions.
- Scope.
- Non-goals.
- Allowed files.
- Forbidden files/actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner decision requirements.

It should identify missing scope, non-goals, allowed files, validation plan, stop states, and risk tier.

It must not execute Codex, modify files, create branches, create commits, push to GitHub, create PRs, or change repository state.

## `factory task plan`

`factory task plan` is intended to produce an execution plan from a valid task contract.

If a local task representation exists in a later phase, this command may preserve the serialized task fields while producing the plan.

Conceptually, it should preserve:

- Scope.
- Non-goals.
- Allowed files.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner decision requirements.

It must stop if owner decision is required.

It must not create branches, commits, PRs, GitHub writes, workflows, task files, schemas, or implementation artifacts.

## `factory status`

`factory status` is intended to summarize local repo and task state.

If a local task representation exists in a later phase, this command may report whether a task is present, valid, incomplete, or blocked by a stop state.

Conceptually, it may report:

- Current branch.
- Working tree cleanliness.
- Remote presence.
- Current task state, if a task contract is available.
- Whether known stop states are active.

It must not clean branches, prune worktrees, modify files, create commits, push, create PRs, or otherwise mutate local or remote state.

## Phase 2 Boundaries

Phase 2 remains planning-only until the owner approves implementation.

Phase 2 must not include:

- CLI implementation.
- Codex execution.
- Codex worker or harness implementation.
- GitHub write automation.
- PR publisher implementation.
- Branch cleanup automation.
- Sandbox automation.
- GitHub Actions workflows.
- Discord integration.
- Trading implementation.
- Live trading, credentials, risk cap, or model promotion logic.

## Acceptance Criteria

The Phase 2 CLI skeleton contract is acceptable when:

- The PR is docs-only.
- Planned commands are described clearly.
- Planned inputs and outputs are conceptual.
- Forbidden behaviors are explicit.
- No task YAML files are created.
- No schemas are created.
- No source code is added.
- No workflows are added.
- No automation is implemented.

## Stop States

Codex must stop and report the matching state when one applies:

- `STOPPED_PHASE2_SCOPE_EXPANDED`
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`
- `STOPPED_TASK_YAML_CREATED_TOO_EARLY`
- `STOPPED_SCHEMA_CREATED_TOO_EARLY`
- `STOPPED_CODE_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`
- `STOPPED_OWNER_DECISION_REQUIRED`
