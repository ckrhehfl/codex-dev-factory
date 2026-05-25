# Sandbox Repository Owner Decisions

## Purpose

This document is the owner decision record and approval template for future sandbox repository creation or reuse.

It records the decisions required before any later task may create, configure, reuse, or locally clone the sandbox repository candidate.

This is a documentation template only. This PR does not create or configure the sandbox repository, run actual sandbox validation, create evidence from a real sandbox run, implement CLI behavior, implement automation, perform GitHub writes, implement PR publisher behavior, implement branch cleanup automation, create workflows, add Discord integration, touch trading code, add credentials, add risk cap logic, or add model promotion logic.

## Current Decision Status

Overall status: `owner_decision_required`.

This record must not be treated as `ready_to_create` until the owner supplies and approves all required decisions, and any required source-of-truth facts are verified by the future creation task.

This record distinguishes:

- Proposed values: defaults or candidates suggested by the current docs.
- Owner-approved values: decisions explicitly approved by the owner.
- Verified evidence: local or authenticated checks performed by a future task.
- Remaining `확인 필요`: facts not yet checked or not yet approved.

## Candidate Repository Identity

| Field | Proposed value | Owner-approved value | Verified evidence | Remaining `확인 필요` |
| --- | --- | --- | --- | --- |
| Repository owner or organization | `ckrhehfl` | Owner decision required | Not verified by this document | Confirm owner/org in future creation task |
| Repository name | `codex-dev-factory-sandbox` | Owner decision required | Not verified by this document | Confirm final name before creation |
| Full repository identity | `ckrhehfl/codex-dev-factory-sandbox` | Owner decision required | Not verified by this document | Verify existence or non-existence with authenticated tooling |
| Repository existence | `확인 필요` | Owner decision required if existing | Not verified by this document | Verify during future creation task |

Do not infer repository existence, ownership, permissions, settings, branch protection, required checks, default branch, or workflow state from the candidate identity.

## Required Owner Decisions

The owner should complete this table before any future creation task creates or reuses a sandbox repository.

| Decision | Proposed safe value | Owner-approved value | Verified evidence | Remaining `확인 필요` |
| --- | --- | --- | --- | --- |
| Final repository owner or organization | `ckrhehfl` candidate | Owner decision required | Not verified by this document | Confirm owner/org and permissions |
| Final repository name | `codex-dev-factory-sandbox` candidate | Owner decision required | Not verified by this document | Confirm final repo name |
| Visibility | Owner choice | Owner decision required | Not verified by this document | Choose public or private |
| Initialize with README or empty | Owner choice | Owner decision required | Not verified by this document | Choose README or empty initialization |
| License choice | Owner choice | Owner decision required | Not verified by this document | Choose license or explicitly choose no license |
| Default branch name | `main` candidate | Owner decision required | Not verified by this document | Confirm default branch |
| Allowed merge methods | Owner choice | Owner decision required | Not verified by this document | Decide squash, merge commit, rebase, or subset |
| Auto-merge setting | Disabled or deferred until sandbox-proven | Owner decision required | Not verified by this document | Confirm whether enabled, disabled, or deferred |
| Automatically delete head branches | Enable if owner approves and setting is verified | Owner decision required | Not verified by this document | Confirm setting with authenticated tooling |
| Branch protection expectation | Absent or minimal until real checks exist | Owner decision required | Not verified by this document | Confirm protection stance |
| Required checks expectation | No required checks until real checks exist | Owner decision required | Not verified by this document | Confirm required-check stance |
| GitHub Actions or workflow stance | Absent or disabled at first | Owner decision required | Not verified by this document | Confirm workflow boundary |
| Initial content policy | Empty or docs-only | Owner decision required | Not verified by this document | Choose empty, docs-only, or minimal fixture |
| Who may create/configure repo | Owner or explicitly authorized actor | Owner decision required | Not verified by this document | Confirm actor and permissions |
| Reuse if target already exists | Stop unless reuse is explicitly approved | Owner decision required | Not verified by this document | Decide reuse or alternate identity |
| Local clone after creation | Allowed only if explicitly approved | Owner decision required | Not verified by this document | Decide whether future creation task may clone locally |
| Initial docs-only fixture content | Excluded unless explicitly approved | Owner decision required | Not verified by this document | Decide whether creation task may add fixture content |
| Actual sandbox validation in creation task | Excluded by default | Owner decision required | Not verified by this document | Confirm validation is excluded or separately scoped |

## Recommended Safe Defaults

Recommended defaults until the owner decides otherwise:

- Keep actual sandbox validation out of the creation task unless separately approved.
- Keep GitHub Actions workflows absent or disabled unless separately approved.
- Keep initial content empty or docs-only.
- Keep credentials, secrets, tokens, API keys, trading code, trading repository connections, automation implementation, PR publisher behavior, branch cleanup automation, risk cap logic, and model promotion logic out of scope.
- Keep GitHub settings that require authenticated verification marked `확인 필요` until checked.
- Keep required checks absent until real checks or workflows exist.
- Stop if the target repository already exists and reuse is not explicitly approved.

## Future Approval Format

When the owner approves sandbox repository creation or reuse, use a short record like:

```text
Owner-approved sandbox repository decisions:
- owner/org:
- repo name:
- visibility:
- initialize with README or empty:
- license:
- default branch:
- allowed merge methods:
- auto-merge:
- automatically delete head branches:
- branch protection:
- required checks:
- GitHub Actions/workflows:
- initial content policy:
- creator/configurer:
- existing repo reuse:
- local clone allowed:
- initial docs-only fixture allowed:
- actual sandbox validation excluded from creation task:
```

The future task should then capture verification evidence separately. Prefer portable verification commands and source categories over machine-specific paths. If an exact local path is required, the future task must freshly verify it and mark it as environment-specific.

## Relationship to Creation Runbook

The [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md) may be executed only after this decision record is completed and owner-approved, or after the owner supplies the equivalent decisions directly in the future creation task.

The future creation task must capture creation or reuse evidence. This decision record is not evidence that the sandbox repository exists, that settings are configured, or that validation has run.

## Relationship to Sandbox Validation

The [Sandbox Validation](SANDBOX_VALIDATION.md) plan begins after repository creation is separately approved and completed.

The [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md) defines evidence for actual sandbox validation runs. This decision record does not create validation evidence.

## Source-of-Truth Handling

Future creation tasks must distinguish:

- Local-verified facts.
- Authenticated GitHub-verified facts.
- Public GitHub-visible facts.
- User-reported facts.
- Proposed values.
- Owner-approved values.
- `확인 필요` facts.

Do not rely on memory, prior conversation, public-only views, candidate names, or this template as proof of repository existence, settings, permissions, branch protection, required checks, default branch, merge methods, auto-merge, automatically delete head branches, workflow state, or local clone paths.

## Stop Conditions

Use existing stop-state guidance. This document introduces no new `STOPPED_*` codes.

Stop when:

- Required owner decisions are missing: `STOPPED_OWNER_DECISION_REQUIRED`.
- Required task fields are missing: `STOPPED_TASK_CONTRACT_INCOMPLETE`.
- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- Source-of-truth state is unclear: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- Required source-of-truth context has not been verified: `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`.
- Target repository exists and reuse is not approved: `STOPPED_OWNER_DECISION_REQUIRED`.
- GitHub settings cannot be verified when required: `STOPPED_GITHUB_SETTINGS_UNVERIFIED`.
- Branch protection cannot be verified when required: `STOPPED_BRANCH_PROTECTION_UNVERIFIED`.
- Required checks are requested before real checks exist: `STOPPED_REQUIRED_CHECKS_NOT_READY`.
- Sandbox remote or identity cannot be verified when needed: `STOPPED_SANDBOX_REMOTE_UNVERIFIED`.
- Owner-approved values conflict with safety boundaries: `STOPPED_OWNER_DECISION_REQUIRED`.
- Requested creation would require implementation: `STOPPED_IMPLEMENTATION_INCLUDED`.
- Requested creation would require source code: `STOPPED_CODE_INCLUDED`.
- Requested creation would require workflows: `STOPPED_WORKFLOW_INCLUDED`.
- Requested creation would require GitHub write automation beyond the explicitly approved repository creation action: `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`.
- Requested creation would require PR publisher behavior: `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`.
- Requested creation would require branch cleanup automation: `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`.
- Requested creation would require credentials or secrets: `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.
- Requested creation would require trading code: `STOPPED_TRADING_CODE_INCLUDED`.
- Requested creation would select a trading repository too early: `STOPPED_TRADING_REPO_SELECTED_TOO_EARLY`.
- A documented transformation drops required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.
- A stop-state surface mismatch remains: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

If a future creation task stops, preserve the interrupted lifecycle state when known and report the recommended next action.

## Safety Field Preservation

Future creation, evidence, result status, validation handoff, and stopped handoff must preserve:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

Dropping safety fields is a stop condition.

## Next Recommended Action

After this PR, the owner may either:

- Fill and approve this decision record in a later docs-only PR.
- Explicitly authorize a sandbox repository creation task with all required decisions supplied in the task.

This document does not authorize creation by itself.

## This PR's Non-Goals Confirmed

This PR does not:

- Create the sandbox repository.
- Configure GitHub settings.
- Run actual sandbox validation.
- Create evidence from a real sandbox run.
- Implement CLI behavior.
- Implement automation.
- Perform GitHub writes beyond creating this documentation PR.
- Implement PR publisher behavior.
- Implement branch cleanup automation.
- Create or edit GitHub Actions workflows.
- Implement Discord integration.
- Implement or modify trading code.
- Add credentials, secrets, tokens, API keys, risk cap logic, or model promotion logic.
- Touch any trading repository.
