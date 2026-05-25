# PR Metadata Review Lessons

## Title

PR #15 metadata review lesson: self-review evidence and confirmations are required PR metadata.

## Source PR

- PR #15: [Docs: define PR metadata guard contract](https://github.com/ckrhehfl/codex-dev-factory/pull/15)
- Original commit: `a47d09d` (`Docs: define PR metadata guard contract`)
- Review-fix commit: `0cf5822` (`Docs: address review comments`)
- Changed file: [PR Metadata Guard Contract](../../PR_METADATA_GUARD.md)

## Problem Observed

PR #15 introduced the PR metadata guard contract, but the first version omitted `Self-review result` and `Confirmations` from the guard's required metadata sections.

Those fields were already required by the [Task Contract](../../TASK_CONTRACT.md) and [Acceptance Tests](../../ACCEPTANCE_TESTS.md). Because the new guard was positioned as the canonical completeness check, the omission could allow PR metadata to pass even when self-review evidence or task-specific safety confirmations were absent.

## Root Cause

The first draft treated validation, risk tier, stop conditions, and owner gates as sufficient evidence of PR completeness.

That merged related but distinct metadata responsibilities:

- Validation results show what checks were run.
- Self-review results show Codex checked the task contract before commit, push, and PR creation.
- Confirmations preserve explicit task-specific safety statements such as docs-only, no workflow, no source code, no automation, no PR publisher, no branch cleanup automation, no Discord, no trading functionality, no credentials, no risk cap, and no model promotion.

## Correct Rule Going Forward

A PR metadata guard must not treat validation, risk, or owner-gate sections as a substitute for self-review evidence and explicit confirmations.

When a task requires self-review before commit, push, or PR creation, PR metadata must preserve that self-review result as its own section or check.

When a task requires explicit safety confirmations, PR metadata must preserve those confirmations as their own section or check. They should not be buried under generic validation, non-goal, risk, or owner-gate language.

Future guard result shapes should represent these as distinct checks, such as `self_review_check` and `confirmations_check`.

Review-fix updates that add, remove, or rename required metadata surfaces should trigger a metadata re-check before merge readiness.

## Required Self-Review Check

For PR metadata, task contract, plan output, validation result, factory status, lifecycle, or solution lookup changes, self-review should check:

- Does the PR metadata requirement list include `Self-review result` when the task requires self-review before commit, push, or PR creation?
- Does the PR metadata requirement list include `Confirmations` when the task requires explicit safety confirmations?
- Are self-review and confirmations represented separately from validation, risk, stop conditions, and owner gates?
- Does any future result shape include distinct fields for self-review and confirmations when it claims to check PR metadata completeness?
- If review-fix changes metadata requirements, is the metadata guard state re-checked before merge readiness?

## Affected Policy Surfaces

- [PR Metadata Guard Contract](../../PR_METADATA_GUARD.md)
- [Task Contract](../../TASK_CONTRACT.md)
- [Acceptance Tests](../../ACCEPTANCE_TESTS.md)
- [Plan Output Contract](../../PLAN_OUTPUT_CONTRACT.md)
- [Task Validation Result Contract](../../TASK_VALIDATION_RESULT.md)
- [Factory Status Result Contract](../../FACTORY_STATUS_RESULT.md)
- [Task Lifecycle State Model](../../TASK_LIFECYCLE.md)
- [Solution Lookup Protocol](../../SOLUTION_LOOKUP_PROTOCOL.md)

## Example Application in Future Tasks

If a future docs task defines or changes a PR metadata guard, PR publisher contract, plan-to-PR metadata transformation, status reporting contract, or validation reporting contract:

1. Compare required PR metadata sections against the [Task Contract](../../TASK_CONTRACT.md) and [Acceptance Tests](../../ACCEPTANCE_TESTS.md).
2. Preserve `Self-review result` as separate evidence when self-review gates commit, push, or PR creation.
3. Preserve `Confirmations` as separate evidence when the task requires explicit safety statements.
4. Keep task-specific confirmations visible in PR metadata rather than relying only on broad non-goals.
5. Re-check metadata completeness after review-fix changes to required metadata surfaces.

## Non-Goals

This lesson does not implement:

- PR metadata guard code.
- PR publisher behavior.
- GitHub write automation.
- CLI behavior.
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
- PR metadata required fields remain incomplete: `STOPPED_PR_METADATA_INCOMPLETE`.
- Metadata, validation, planning, status, or task-contract changes drop required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.
- A stop-state surface mismatch is introduced: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

## Prevention

Before committing PR metadata guard or PR metadata transformation docs, compare the new completeness checklist against existing required PR metadata in the task contract and acceptance tests.

Treat self-review evidence and explicit confirmations as first-class metadata surfaces. They support different review questions than validation results, risk tiers, stop conditions, and owner gates.

## Related PRs

- PR #15: [Docs: define PR metadata guard contract](https://github.com/ckrhehfl/codex-dev-factory/pull/15)

## Follow-Up Status

Captured by the review-fix commit in PR #15.

Added to the Compound knowledge base in this PR.
