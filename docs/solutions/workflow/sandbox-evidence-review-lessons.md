# Sandbox Evidence Review Lessons

## Title

PR #20 sandbox evidence review lesson: stopped evidence examples must preserve `lifecycle_trace`.

## Source PR

- PR #20: [Docs: define sandbox validation evidence contract](https://github.com/ckrhehfl/codex-dev-factory/pull/20)
- Original commit: `e3b5cce` (`Docs: define sandbox validation evidence contract`)
- Review-fix commit: `14430ce` (`Docs: address review comments`)
- Changed file: [Sandbox Validation Evidence Contract](../../SANDBOX_VALIDATION_EVIDENCE.md)

## Problem Observed

PR #20 defined the canonical sandbox validation evidence packet shape with a `lifecycle_trace` field.

The original stopped evidence examples used a generic `lifecycle` key while the contract's packet shape declared `lifecycle_trace`. Review identified that consumers copying those examples would produce evidence packets that did not match the documented schema shape.

The review-fix updated stopped examples for `STOPPED_FORBIDDEN_FILE_CHANGE` and `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` so the interrupted lifecycle state is represented under `lifecycle_trace.interrupted_state`.

## Root Cause

The first version checked that stopped examples aligned values such as `status`, `stop_state`, reason, and `recommended_next_action`, but it did not check that the surrounding example structure matched the canonical evidence packet shape.

That left the interrupted lifecycle context in the right conceptual place but under the wrong field name.

## Correct Rule Going Forward

Evidence packet examples for stopped runs must use the canonical field shape from the contract they illustrate.

Do not collapse interrupted lifecycle context into a generic `lifecycle` field when the contract defines `lifecycle_trace`.

Stopped examples must preserve `lifecycle_trace.interrupted_state` when the interrupted state is known.

Examples involving registry-backed stop states, including `STOPPED_FORBIDDEN_FILE_CHANGE` and `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`, must align:

- `status`.
- `stop_state.code`.
- `stop_state.reason`.
- `lifecycle_trace.interrupted_state`.
- `recommended_next_action`.

## Required Self-Review Check

For sandbox validation evidence, factory status, task validation result, PR metadata guard, allowed-files guard, lifecycle, or stop-state docs, self-review should check:

- Does each example use the same top-level field names as the declared result or evidence packet shape?
- If the example is stopped, does it use `status: stopped` and a registry-backed `STOPPED_*` code?
- Does the stopped example preserve the interrupted lifecycle state under the canonical lifecycle trace field?
- Are `status`, `stop_state.code`, `stop_state.reason`, `lifecycle_trace.interrupted_state`, and `recommended_next_action` structurally aligned?
- If a review-fix changes packet shape or example structure, were cross-document consistency, stop-state consistency, safety field preservation, PR metadata completeness, and relevant example checks rerun before merge readiness?

## Affected Policy Surfaces

- [Sandbox Validation Evidence Contract](../../SANDBOX_VALIDATION_EVIDENCE.md)
- [Task Lifecycle State Model](../../TASK_LIFECYCLE.md)
- [Stop-State Registry](../../STOP_STATE_REGISTRY.md)
- [Factory Status Result Contract](../../FACTORY_STATUS_RESULT.md)
- [Task Validation Result Contract](../../TASK_VALIDATION_RESULT.md)
- [PR Metadata Guard Contract](../../PR_METADATA_GUARD.md)
- [Allowed-Files Guard Result Contract](../../ALLOWED_FILES_GUARD.md)
- [Solution Lookup Protocol](../../SOLUTION_LOOKUP_PROTOCOL.md)

## Example Application in Future Tasks

If a future docs task adds or changes an evidence packet, status result, validation result, PR metadata guard result, allowed-files guard result, or stopped example:

1. Compare every example key against the declared result shape.
2. For stopped examples, preserve the interrupted lifecycle state under the contract's canonical lifecycle trace field.
3. Verify that any referenced `STOPPED_*` code exists in the [Stop-State Registry](../../STOP_STATE_REGISTRY.md).
4. Align `status`, `stop_state`, reason, lifecycle trace, and recommended next action before commit.
5. Rerun the relevant example checks after review-fix commits.

## Non-Goals

This lesson does not implement:

- Sandbox validation evidence tooling.
- CLI behavior.
- GitHub write automation.
- PR publisher behavior.
- Workflow automation.
- Branch cleanup automation.
- Discord integration.
- Sandbox repository creation.
- Actual sandbox validation runs.
- Trading functionality or trading repository connection.
- Credential, live trading, risk cap, or model promotion logic.

## Stop Conditions if the Lesson Cannot Be Applied Safely

Stop with the relevant existing stop state when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- A solution lesson conflicts with the current task scope: `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE`.
- A solution lesson requires owner decision: `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.
- A stop-state surface mismatch is introduced: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- Evidence, validation, planning, status, metadata, or task-contract changes drop required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.
- A file-boundary violation is introduced or left unresolved: `STOPPED_FORBIDDEN_FILE_CHANGE`.

## Prevention

Before committing evidence or result contract examples, compare example structure against the canonical field list, not just the values inside the example.

Treat field names in examples as part of the contract surface. A stopped example with correct stop-state values can still be wrong if it stores interrupted lifecycle context under a non-canonical key.

## Related PRs

- PR #20: [Docs: define sandbox validation evidence contract](https://github.com/ckrhehfl/codex-dev-factory/pull/20)
- Related prior lesson: [Allowed-Files Review Lessons](allowed-files-review-lessons.md)
- Related prior lesson: [Task Lifecycle Review Lessons](task-lifecycle-review-lessons.md)
- Related prior lesson: [Stop-State Consistency](stop-state-consistency.md)

## Follow-Up Status

Captured by the review-fix commit in PR #20.

Added to the Compound knowledge base in this PR.
