# Stop-State Consistency

## Problem

PR #8 introduced or used `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD` as a recommended next action, but the stop state needed to be reflected consistently in the local Stop States section and the shared [Risk Policy](../../operations/RISK_POLICY.md) surface.

## Cause

The prompt checked docs-only boundaries and safety-field preservation, but did not explicitly require recommended next action to Stop States list matching.

That left an enum-like policy value visible in one section before it was declared in every relevant stop-state surface.

## Solution

When adding any `STOPPED_*` code, update every relevant local Stop States section.

If the stop state is a shared policy state, update [Risk Policy](../../operations/RISK_POLICY.md).

When a `STOPPED_*` code appears as a recommended next action, status, or enum-like output value, treat it as a stop state unless the document clearly frames it as non-stop status.

## Prevention

Self-review must compare named next actions, enum-like states, and stop codes against declared Stop States lists.

Cross-document consistency checks must include recommended next action to stop-state matching.

If a stop state appears in a task prompt but not in the relevant document's Stop States list or shared policy surface, stop with `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

## Related PRs

- PR #8: [Docs: define task validation result contract](https://github.com/ckrhehfl/codex-dev-factory/pull/8)

## Follow-Up Status

Captured by the review-fix commit in PR #8.

Added to the Compound knowledge base in this PR.
