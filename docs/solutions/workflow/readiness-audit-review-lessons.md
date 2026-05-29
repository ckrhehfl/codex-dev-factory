# Readiness Audit Review Lessons

## Title

PR #23 readiness audit review lesson: use portable verification evidence instead of machine-specific local paths.

## Source PR

- PR #23: [Docs: run Phase 1/2 readiness audit](https://github.com/ckrhehfl/codex-dev-factory/pull/23)
- Original commit: `82c7d9a` (`Docs: run Phase 1/2 readiness audit`)
- Review-fix commit: `e96cd17` (`Docs: address review comments`)
- Merge commit: `a501f89`
- Changed file: [Phase 1/2 Readiness Audit Result](../../PHASE_READINESS_AUDIT_RESULT.md)

## Problem Observed

PR #23 recorded a Phase 1/2 readiness audit result after the documentation inventory audit. Review found that the result described a concrete local path as verified evidence.

That path was true for one user machine, but it was not durable, portable evidence for future runs or other environments. Because readiness and audit result documents are later used as source-of-truth evidence, a machine-specific path can be mistaken for a reusable fact.

The review-fix changed the wording to state that the repository root was verified with `git rev-parse --show-toplevel` during the audit.

## Root Cause

The audit result mixed two different kinds of evidence:

- Local-run verification that should be scoped to the current environment.
- Durable audit evidence that future readers and assistants can safely reuse.

The task prompt included a local path candidate, and the audit correctly revalidated the repository locally. The mistake was turning that environment-specific path into a durable source-of-truth claim instead of recording the portable verification method and result category.

## Correct Rule Going Forward

Readiness, inventory, evidence, and audit result documents should prefer portable verification commands and result categories over machine-specific local paths.

Use evidence such as:

- `git rev-parse --show-toplevel` for repository-root verification.
- `git remote get-url origin` for remote verification.
- `git status --short --branch` for branch and worktree state.
- `git rev-parse HEAD` for the checked baseline commit.
- `git log --oneline --decorate -n <count>` for recent local history.
- Authenticated GitHub CLI or connector output for PR, review, merge, or settings state when those facts are required.

Record an exact local path only when the path itself is required by the task, freshly revalidated for the current run, and clearly scoped as environment-specific. Otherwise, record the command used and the verified state category.

Authenticated-only, environment-specific, settings, sandbox-repository, or external-repository facts remain `확인 필요` unless they were actually verified by the required local or authenticated source.

## Required Self-Review Check

For readiness, inventory, evidence, source-of-truth, or audit result docs, self-review should check:

- Does the document record any exact local path such as a Windows drive path, `/home/...`, or `/Users/...`?
- If an exact path appears, is the path required, freshly revalidated, and clearly scoped to the current run?
- Could the document use a portable command and result category instead?
- Does the result distinguish local-verified, authenticated-GitHub-verified, public/web-visible, user-reported, and `확인 필요` state?
- Are environment-specific facts prevented from becoming durable reusable source-of-truth?
- If source-of-truth cannot be verified, does the task stop or mark the fact as `확인 필요` instead of guessing?

## Affected Policy Surfaces

- [Phase 1/2 Readiness Audit Result](../../PHASE_READINESS_AUDIT_RESULT.md)
- [Phase 1/2 Readiness Audit](../../PHASE_READINESS_AUDIT.md)
- [Documentation Inventory Audit](../../DOCUMENTATION_INVENTORY_AUDIT.md)
- [Factory Status Result Contract](../../FACTORY_STATUS_RESULT.md)
- [Sandbox Validation Evidence Contract](../../SANDBOX_VALIDATION_EVIDENCE.md)
- [Task Lifecycle State Model](../../operations/TASK_LIFECYCLE.md)
- [Solution Lookup Protocol](../../SOLUTION_LOOKUP_PROTOCOL.md)
- [Stop-State Registry](../../STOP_STATE_REGISTRY.md)
- [Risk Policy](../../operations/RISK_POLICY.md)

## Example Application in Future Tasks

Avoid:

```text
Local repository path verified by git: C:\Dev\codex-dev-factory.
```

Prefer:

```text
Repository root was verified with `git rev-parse --show-toplevel` during this audit.
Remote was verified with `git remote get-url origin`.
GitHub settings and sandbox repository existence remain `확인 필요` unless authenticated tooling verifies them.
```

If an exact path is necessary, scope it to the current run:

```text
Local path checked for this run: C:\Dev\codex-dev-factory.
This path is environment-specific and is not reusable source-of-truth for later runs.
```

## Non-Goals

This lesson does not:

- Rerun the Phase 1/2 readiness audit.
- Change PR #23's audit result beyond the already-merged review-fix.
- Create a sandbox repository.
- Run actual sandbox validation.
- Implement CLI behavior.
- Implement automation.
- Implement GitHub write automation.
- Implement PR publisher behavior.
- Implement branch cleanup automation.
- Create or edit workflows.
- Implement Discord integration.
- Implement trading functionality or trading repository connection.
- Add credentials, live trading, risk cap, or model promotion logic.

## Stop Conditions if the Lesson Cannot Be Applied Safely

Stop with the relevant existing stop state when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- Source-of-truth state is unclear and cannot be safely marked as `확인 필요`: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- A solution lesson conflicts with the current task scope: `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE`.
- A solution lesson requires owner decision: `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.
- A stop-state surface mismatch is introduced: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- Audit, evidence, validation, status, metadata, planning, or task-contract changes drop required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.

When a future audit cannot distinguish portable verification evidence from environment-specific facts, either stop with the appropriate existing stop state or mark the fact as `확인 필요` until it is verified.

## Safety Field Preservation

If this lesson is applied to audit, evidence, status, validation, PR metadata, or task-transformation language, preserve:

- `scope`
- `allowed_files`
- `forbidden_files`
- `forbidden_actions`
- `validation_plan`
- stop states
- risk tier
- owner gates

## Prevention

Before committing readiness, inventory, evidence, or source-of-truth docs, search the edited files for absolute local-path patterns and decide whether each one is necessary.

Prefer command-backed evidence over machine-specific path evidence. Keep source-of-truth claims scoped to the run that actually verified them, and keep unchecked facts as `확인 필요`.

## Related PRs

- PR #23: [Docs: run Phase 1/2 readiness audit](https://github.com/ckrhehfl/codex-dev-factory/pull/23)
- Related prior lesson: [Task Lifecycle Review Lessons](task-lifecycle-review-lessons.md)
- Related prior lesson: [PR Metadata Review Lessons](pr-metadata-review-lessons.md)
- Related prior lesson: [Sandbox Evidence Review Lessons](sandbox-evidence-review-lessons.md)

## Follow-Up Status

Captured by the review-fix commit in PR #23.

Added to the Compound knowledge base in this PR.
