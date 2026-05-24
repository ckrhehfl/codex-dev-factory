# Task Contract

## Purpose

The task contract is the source format for safe Codex execution. It turns a request into a bounded unit of work with explicit assumptions, file limits, validation steps, risk tier, and owner decision gates.

This document is policy and documentation only. It does not implement a task parser, task YAML format, CLI command, worker, publisher, automation, or cleanup routine.

The future local representation of this contract is described in [Local Task Format Contract](LOCAL_TASK_FORMAT.md). The task contract remains the policy source; the local format is only a future representation.

## Required Task Fields

Each task should define these fields before Codex begins work:

- Task title: the short human-readable name for the work.
- Objective: the outcome the task should produce.
- Source-of-truth assumptions: what context is trusted, what still needs revalidation, and what must not be treated as authoritative by default.
- Scope: what Codex is allowed to change or prepare.
- Non-goals: what Codex must not attempt.
- Allowed files: exact files or path patterns that may change.
- Forbidden files/actions: files, directories, commands, or external actions that are out of bounds.
- Validation plan: the local checks, diffs, review steps, or external state checks required before completion.
- Stop conditions: named states that require Codex to stop and report instead of continuing.
- Risk tier: low, medium, high, or prohibited for the current task.
- Owner decision requirements: actions that require explicit owner approval before Codex proceeds.

If any required field is missing for a non-trivial task, Codex should stop with `STOPPED_TASK_CONTRACT_INCOMPLETE`.

Future local task files may serialize these fields, but no task YAML files, schemas, or parsers exist yet.

## Risk Tier Mapping

Low-risk docs-only tasks:

- Change only documentation files allowed by the task.
- Do not create workflows, source code, scripts, credentials, bots, workers, publishers, branch cleanup automation, or trading logic.
- May proceed through commit, push, and PR creation after successful self-review when the task explicitly permits it.
- Still keep merge separate unless explicitly requested.

Medium-risk tooling or planning tasks:

- May design local CLI, worktree, or harness behavior.
- May prepare plans or documentation for future implementation.
- Require an approved plan before implementation.
- Must not write to external services unless separately approved.

The Phase 2 local CLI skeleton is a planning example of this tier. Its contract is defined in [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md).

High-risk automation or write-action tasks:

- Include GitHub write automation, PR publishing, worker execution, branch cleanup automation, auto-merge behavior, repository settings changes, or external service writes.
- Must stop for owner decision before execution.

Prohibited areas unless separately approved:

- Trading code.
- Live trading behavior.
- Credentials, secrets, tokens, or account configuration.
- Risk cap logic.
- Model promotion logic.
- Any trading repository integration before sandbox validation and owner approval.

## PR Metadata Standard

Every PR body should include:

- Scope.
- Non-goals.
- Allowed files.
- Validation plan.
- Stop conditions.
- Risk tier.
- Self-review result.
- Confirmations.

The metadata should be specific enough for the owner to verify that the PR stayed inside its contract without reconstructing the entire task from the diff.

## Self-Review / Preflight Checklist

Before commit, push, and PR creation, Codex should verify:

- Changed files are inside the allowed-file list.
- No forbidden file paths changed.
- No workflows were added unless explicitly allowed.
- No source code was added for docs-only PRs.
- No credentials or secrets were introduced.
- No GitHub write automation implementation was added.
- No branch cleanup automation implementation was added.
- No Discord bot was added.
- No trading code was added.
- No live trading, credential, risk cap, or model promotion logic changed.

After commit and before reporting completion, Codex should verify:

- The working tree is clean.
- The branch pushed successfully.
- A PR URL was produced when PR creation was in scope.

If self-review fails, Codex must stop with `STOPPED_SELF_REVIEW_FAILED` or the more specific matching stop state.

## Approval Model

Low-risk docs-only tasks may commit, push, and create a PR after successful self-review when the task contract explicitly allows that flow.

Merge remains separate unless explicitly requested.

High-risk tasks must stop for owner decision before execution. Codex may still gather context, draft a plan, or summarize options, but it must not perform the high-risk action without approval.

## Stop States

Codex must stop and report the matching state when one applies:

- `STOPPED_TASK_CONTRACT_INCOMPLETE`
- `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`
- `STOPPED_FORBIDDEN_FILE_CHANGE`
- `STOPPED_IMPLEMENTATION_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_PR_METADATA_INCOMPLETE`
- `STOPPED_SELF_REVIEW_FAILED`
- `STOPPED_OWNER_DECISION_REQUIRED`
