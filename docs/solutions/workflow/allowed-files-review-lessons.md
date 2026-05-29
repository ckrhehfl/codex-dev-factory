# Allowed-Files Review Lessons

## Title

PR #17 allowed-files review lesson: file-boundary violations that trigger stop conditions must report `stopped`.

## Source PR

- PR #17: [Docs: define allowed-files guard result contract](https://github.com/ckrhehfl/codex-dev-factory/pull/17)
- Original commit: `24e93cf` (`Docs: define allowed-files guard result contract`)
- Review-fix commit: `aad9304` (`Docs: address review comments`)
- Changed file: [Allowed-Files Guard Result Contract](../../ALLOWED_FILES_GUARD.md)

## Problem Observed

PR #17 introduced the allowed-files guard result contract, then review found one example that softened a stop condition.

The normative text said out-of-scope or forbidden file edits should stop with `STOPPED_FORBIDDEN_FILE_CHANGE`, but the review-fix example originally reported an out-of-scope file addition as `status: failed` with a generic re-check or split action.

That mismatch could lead future implementers or contract authors to report file-boundary violations without halting the lifecycle when an existing stop condition applies.

## Root Cause

The first example treated a review-fix file-boundary violation as a recoverable validation failure rather than as a stop-state event.

That made the example inconsistent with:

- The allowed-files guard failure-handling rule.
- The allowed-files guard STOPPED handling rule.
- The [Stop-State Registry](../../STOP_STATE_REGISTRY.md) entry for `STOPPED_FORBIDDEN_FILE_CHANGE`.
- The broader stop-state consistency rule that status, stop-state code, reason, and recommended next action must align.

## Correct Rule Going Forward

When an allowed-files guard result finds an out-of-scope or forbidden file change and an existing stop condition applies, the result must report `status: stopped`.

The result must preserve or report the matching `STOPPED_*` code, such as `STOPPED_FORBIDDEN_FILE_CHANGE`, when that code exists in the stop-state registry.

The recommended next action should be corrective and safety-preserving, such as removing the out-of-scope file change or stopping for owner decision. It should not imply that work may continue through a generic re-check when a stop condition is active.

Examples in guard contracts must align:

- `status`.
- `stop_state`.
- Failure reason.
- `recommended_next_action`.
- Registry-backed `STOPPED_*` code.

## Required Self-Review Check

For allowed-files guard, validation result, factory status, PR metadata, plan output, lifecycle, or stop-state docs, self-review should check:

- If an example shows an out-of-scope or forbidden file change, does it report `status: stopped` when an existing stop condition applies?
- Does the example include the matching `STOPPED_*` code when one exists in the registry?
- Does the recommended next action remove the unsafe file change, stop for owner decision, or otherwise preserve safety?
- Do examples avoid softer `failed` semantics when the normative rule says to stop?
- Are `status`, `stop_state`, failure reason, and recommended next action aligned?
- If any `STOPPED_*` code is referenced, is it present in the stop-state registry and relevant local Stop States sections?

## Affected Policy Surfaces

- [Allowed-Files Guard Result Contract](../../ALLOWED_FILES_GUARD.md)
- [Stop-State Registry](../../STOP_STATE_REGISTRY.md)
- [Risk Policy](../../operations/RISK_POLICY.md)
- [Acceptance Tests](../../ACCEPTANCE_TESTS.md)
- [Task Contract](../../operations/TASK_CONTRACT.md)
- [Task Validation Result Contract](../../TASK_VALIDATION_RESULT.md)
- [Factory Status Result Contract](../../FACTORY_STATUS_RESULT.md)
- [PR Metadata Guard Contract](../../operations/PR_METADATA_GUARD.md)
- [Task Lifecycle State Model](../../operations/TASK_LIFECYCLE.md)

## Example Application in Future Tasks

If a future docs task adds or changes guard result examples:

1. Identify whether the example describes a normal failure, owner-gated condition, unknown state, or stop condition.
2. If the example describes a stop condition, use `status: stopped`.
3. Include the matching `STOPPED_*` code when the registry already defines one.
4. Use a recommended next action that removes the unsafe change or stops for owner decision.
5. Run cross-document and stop-state consistency checks before commit.

## Non-Goals

This lesson does not implement:

- Allowed-files guard code.
- CLI behavior.
- GitHub write automation.
- PR publisher behavior.
- Workflow automation.
- Branch cleanup automation.
- Discord integration.
- Trading functionality or trading repository connection.
- Credential, live trading, risk cap, or model promotion logic.

## Stop Conditions if the Lesson Cannot Be Applied Safely

Stop with the relevant existing stop state when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- A solution lesson conflicts with the current task scope: `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE`.
- A solution lesson requires owner decision: `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.
- A file-boundary violation is introduced or left unresolved: `STOPPED_FORBIDDEN_FILE_CHANGE`.
- A stop-state surface mismatch is introduced: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- Metadata, validation, planning, status, or task-contract changes drop required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.

## Prevention

Before committing allowed-files guard or related reporting docs, compare every example against the normative failure-handling and STOPPED handling text.

Treat `failed` and `stopped` as meaningfully different states. Use `failed` for recoverable validation/reporting failures, and use `stopped` when a repository stop condition applies.

## Related PRs

- PR #17: [Docs: define allowed-files guard result contract](https://github.com/ckrhehfl/codex-dev-factory/pull/17)
- Related prior lesson: [Stop-State Consistency](stop-state-consistency.md)

## Follow-Up Status

Captured by the review-fix commit in PR #17.

Added to the Compound knowledge base in this PR.
