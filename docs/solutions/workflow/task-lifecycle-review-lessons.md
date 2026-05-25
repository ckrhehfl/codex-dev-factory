# Task Lifecycle Review Lessons

## Title

PR #12 lifecycle review lessons: pre-planning solution lookup and interrupted-state recovery.

## Source PR

- PR #12: [Docs: define task lifecycle state model](https://github.com/ckrhehfl/codex-dev-factory/pull/12)
- Review-fix commit: `41e2468` (`Docs: address review comments`)
- Changed file: [Task Lifecycle State Model](../../TASK_LIFECYCLE.md)

## Problem Observed

PR #12 introduced the canonical task lifecycle state model, then review found two lifecycle consistency gaps:

- Required solution lookup was first placed in `BRANCH_ACTIVE`, which made it appear later than the pre-planning timing required by the [Solution Lookup Protocol](../../SOLUTION_LOOKUP_PROTOCOL.md).
- `STOPPED` could only transition to early restart states, which prevented later lifecycle states from resuming after a stop reason was resolved.

Both comments were in-scope for the lifecycle PR because they affected the canonical task flow rather than a new implementation surface.

## Root Cause

The initial lifecycle table treated branch work as the natural place to inspect related docs and run solution lookup, but solution lookup is also a planning input. That created a timing mismatch between lifecycle state sequencing and the existing solution lookup policy.

The initial `STOPPED` row modeled stops as task restarts instead of interruptions. That lost the interrupted lifecycle context needed to safely resume review-fix, merge-ready, cleanup, or lesson-review states after the stop reason is resolved.

## Correct Rule Going Forward

Required solution lookup must happen during task intake or before planning when a task touches a lookup-triggering surface. Branch-stage lookup can refresh or extend the result if branch inspection reveals newly relevant lessons, but it must not be the first required lookup after planning has already started.

`STOPPED` is a lifecycle interruption, not always a full restart. When known, record the interrupted lifecycle state. After the stop reason is resolved, the task may return to that interrupted state only if the state remains valid and its required checks still pass. If not, return to the earliest lifecycle state needed to revalidate changed assumptions.

## Required Self-Review Check

For lifecycle, task contract, validation result, plan output, solution lookup, or PR metadata changes, self-review should check:

- Does required solution lookup happen before planning whenever the task touches a lookup-triggering surface?
- Is any later solution lookup described as a refresh or extension rather than the first required lookup?
- If a state can enter `STOPPED`, does the model explain whether the task resumes, restarts, or revalidates?
- Is the interrupted lifecycle state preserved when known?
- Does resumption require the interrupted state to remain valid and its required checks to pass?

## Affected Policy Surfaces

- [Task Lifecycle State Model](../../TASK_LIFECYCLE.md)
- [Solution Lookup Protocol](../../SOLUTION_LOOKUP_PROTOCOL.md)
- [Stop-State Registry](../../STOP_STATE_REGISTRY.md)
- [Risk Policy](../../RISK_POLICY.md)
- [Task Contract](../../TASK_CONTRACT.md)
- [Plan Output Contract](../../PLAN_OUTPUT_CONTRACT.md)
- [Task Validation Result Contract](../../TASK_VALIDATION_RESULT.md)

## Example Application in Future Tasks

If a future docs task updates lifecycle states, task fields, validation result fields, plan output fields, PR metadata, review-fix rules, or stop handling:

1. Run solution lookup before planning the change.
2. Treat branch-stage lookup as a refresh if new files or terms reveal additional relevant lessons.
3. When a stop condition is added to a later lifecycle state, document how work resumes after the stop reason is resolved.
4. If resumption is unsafe, document the earliest state that must be revalidated.

## Non-Goals

This lesson does not implement:

- CLI lifecycle state handling.
- Solution lookup automation.
- Stop-state automation.
- GitHub write automation.
- PR publisher behavior.
- Branch cleanup automation.
- Discord integration.
- Trading functionality or trading repository connection.

## Stop Conditions if the Lesson Cannot Be Applied Safely

Stop with the relevant existing stop state when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- A solution lesson conflicts with the current task scope: `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE`.
- A solution lesson requires owner decision: `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.
- A stop-state surface mismatch is introduced: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- Lifecycle, validation, planning, or metadata changes drop required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.

## Prevention

Before committing lifecycle or workflow-policy docs, compare lifecycle ordering against the protocols that feed it. A lifecycle model should not move a required pre-planning check into a later operational state unless the text clearly says the later step is only a refresh.

Before committing stop-handling docs, check whether `STOPPED` is acting as a restart or an interruption. If interruption is allowed, the interrupted state and its required checks must remain visible.

## Related PRs

- PR #12: [Docs: define task lifecycle state model](https://github.com/ckrhehfl/codex-dev-factory/pull/12)

## Follow-Up Status

Captured by the review-fix commit in PR #12.

Added to the Compound knowledge base in this PR.
