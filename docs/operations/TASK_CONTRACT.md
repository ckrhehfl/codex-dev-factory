# Task Contract

## Purpose

The task contract is the source format for safe Codex execution. It turns a request into a bounded unit of work with explicit assumptions, file limits, validation steps, risk tier, and owner decision gates.

This document is policy and documentation only. It does not implement a task parser, task YAML format, CLI command, worker, publisher, automation, or cleanup routine.

The future local representation of this contract is described in [Local Task Format Contract](../LOCAL_TASK_FORMAT.md). Future validation result output is described in [Task Validation Result Contract](../TASK_VALIDATION_RESULT.md). Future execution plan output is described in [Plan Output Contract](../PLAN_OUTPUT_CONTRACT.md). The task lifecycle is described in [Task Lifecycle State Model](TASK_LIFECYCLE.md). Future PR metadata checks are described in [PR Metadata Guard Contract](PR_METADATA_GUARD.md). Future changed-file boundary checks are described in [Allowed-Files Guard Result Contract](../ALLOWED_FILES_GUARD.md). The task contract remains the policy source; local formats, validation results, plans, lifecycle states, metadata guard results, and allowed-files guard results are only future representations or policy surfaces.

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

Future validation, plan, status, PR metadata, and allowed-files guard output must preserve these fields without weakening safety boundaries. In particular, forbidden files and forbidden actions must remain visible whenever a task is validated, transformed into a plan, reported as status, checked against changed files, or converted into PR metadata.

## Optional Codex Multi-Agent Planning Fields

Future Codex multi-agent architecture tasks may include these optional planning fields:

- `worker_role`: the intended role, such as intake, repo scout, planner, mutation worker, validation worker, review agent, review-fix agent, PR publisher, cleanup coordinator, or rollback planner.
- `worker_count`: the number of Codex workers expected for the task, including whether they are sequential or parallel.
- `credit_cost_class`: the expected Codex credit/cost class, such as small, medium, high, or owner-decision-required.
- `evidence_packet_required`: whether each worker must produce a structured evidence packet before the task can proceed.

These fields are planning contract fields only. They are not an executable schema, automation trigger, dispatcher configuration, or approval to run workers. Worker execution, mutation, PR creation, merge, cleanup, rollback, credentials, providers, workflows, settings, and sandbox mutation remain owner-gated.

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

The Phase 2 local CLI skeleton is a planning example of this tier. Its contract is defined in [Phase 2 CLI Skeleton Contract](../PHASE2_CLI_SKELETON.md).

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
- Forbidden files/actions when present in the task or plan.
- Validation plan.
- Stop conditions.
- Risk tier.
- Self-review result.
- Confirmations.

The metadata should be specific enough for the owner to verify that the PR stayed inside its contract without reconstructing the entire task from the diff.

Future PR metadata guard checks may validate this metadata, but they must preserve forbidden files/actions and owner gates rather than replacing the task contract.

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

## Manual PR Merge Gate

PM/ChatGPT must continue to give the owner the exact WSL launch command for the intended Codex session, usually `cdfcodex` for bounded work after readiness has passed.

For PRs, `Repo guard` must pass before owner merge. Unresolved review comments or conversations must be resolved before owner merge. Codex Review or review comments should be checked manually before owner merge.

Passing checks do not mean automatic merge. Auto-merge remains disabled or not the default unless the owner separately approves it for a later task.

API-based merge readiness checks and automated merge loops are future work. For now, the owner remains the final merge gate.

## Strong Bounded Codex Operating Policy

PM/ChatGPT must always give the owner the exact WSL launch command for the intended Codex session.

Use `cdfcheck` for read-only readiness or status checks. Use `cdfcodex` for normal bounded Codex work after readiness has passed. Default Codex Intelligence remains `medium/default`.

When the task contract explicitly authorizes a low-risk docs-only bounded task, `cdfcodex` may run the full safe task loop in one run:

- Create the task branch.
- Edit only scoped files.
- Run local validation, status, and diff checks.
- Commit the in-scope result.
- Push the branch.
- Open a PR when appropriate.

Codex should not stop after local edits by default when the owner has authorized the full bounded task loop.

Strong or no-prompt mode is not a blank check. High or xhigh intelligence, API keys, GitHub secrets, GitHub settings changes, auto-merge, branch cleanup automation, Full Access, `danger-full-access`, `--yolo`, and broad unmanaged changes require separate explicit owner approval.

Ordinary project progress belongs in handoff notes, not durable memory. Durable memory should store policy, reviewed lessons, or owner-approved long-lived facts rather than temporary session progress, local sync status, or handoff-style flow state.

## Stop States

The canonical stop-state surface is [Stop-State Registry](../STOP_STATE_REGISTRY.md). Codex must stop and report the matching state when one applies:

- `STOPPED_TASK_CONTRACT_INCOMPLETE`
- `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`
- `STOPPED_FORBIDDEN_FILE_CHANGE`
- `STOPPED_IMPLEMENTATION_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_PR_METADATA_INCOMPLETE`
- `STOPPED_SELF_REVIEW_FAILED`
- `STOPPED_OWNER_DECISION_REQUIRED`
