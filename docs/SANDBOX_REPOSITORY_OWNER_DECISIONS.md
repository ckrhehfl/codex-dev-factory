# Sandbox Repository Owner Decisions

## Purpose

This document is the owner decision record and approval template for future sandbox repository creation or reuse.

It records the decisions required before any later task may create, configure, reuse, or locally clone the sandbox repository candidate.

This is a documentation record only. This PR does not create or configure the sandbox repository, run actual sandbox validation, create evidence from a real sandbox run, implement CLI behavior, implement automation, perform GitHub writes, implement PR publisher behavior, implement branch cleanup automation, create workflows, add Discord integration, touch trading code, add credentials, add risk cap logic, or add model promotion logic.

## Current Decision Status

Overall status: `owner_approved_pending_creation_authorization`.

The owner-approved values below were supplied in the owner task prompt for this docs-only PR. They are owner decisions, not evidence that the sandbox repository exists, that GitHub settings are configured, or that a future creation task is authorized to proceed automatically.

This record must not be treated as `ready_to_create` until a later task explicitly authorizes sandbox repository creation or reuse, and any required source-of-truth facts are verified by that future creation task.

This record distinguishes:

- Proposed values: defaults or candidates suggested by the current docs.
- Owner-approved values: decisions explicitly approved by the owner.
- Verified evidence: local or authenticated checks performed by a future task.
- Remaining `확인 필요`: facts not yet checked or not yet approved.

## Candidate Repository Identity

| Field | Proposed value | Owner-approved value | Verified evidence | Remaining `확인 필요` |
| --- | --- | --- | --- | --- |
| Repository owner or organization | `ckrhehfl` | `ckrhehfl` | Owner-approved by this task prompt; not verified as GitHub permissions evidence | Confirm owner/org and permissions in future creation task |
| Repository name | `codex-dev-factory-sandbox` | `codex-dev-factory-sandbox` | Owner-approved by this task prompt; not verified as repository existence evidence | Confirm final name before creation |
| Full repository identity | `ckrhehfl/codex-dev-factory-sandbox` | `ckrhehfl/codex-dev-factory-sandbox` | Owner-approved by this task prompt; not verified as repository existence evidence | Verify existence or non-existence with authenticated tooling |
| Repository existence | `확인 필요` | Stop and ask owner if target already exists | Not verified by this document | Verify during future creation task |

Do not infer repository existence, ownership, permissions, settings, branch protection, required checks, default branch, or workflow state from the candidate identity.

## Required Owner Decisions

This table records the owner-approved values that a future creation task may use after that later task explicitly authorizes sandbox repository creation or reuse.

| Decision | Proposed safe value | Owner-approved value | Verified evidence | Remaining `확인 필요` |
| --- | --- | --- | --- | --- |
| Final repository owner or organization | `ckrhehfl` candidate | `ckrhehfl` | Owner-approved by this task prompt; permissions not verified | Confirm owner/org and permissions |
| Final repository name | `codex-dev-factory-sandbox` candidate | `codex-dev-factory-sandbox` | Owner-approved by this task prompt; existence not verified | Confirm target repository existence or non-existence |
| Full repository identity | `ckrhehfl/codex-dev-factory-sandbox` candidate | `ckrhehfl/codex-dev-factory-sandbox` | Owner-approved by this task prompt; existence not verified | Verify with authenticated tooling in future creation task |
| Visibility | Owner choice | `public` | Owner-approved by this task prompt; setting not configured by this PR | Verify after creation or reuse |
| Initialize with README or empty | Owner choice | Initialize with README | Owner-approved by this task prompt; repository not created by this PR | Verify initial files after creation |
| License choice | Owner choice | No license for now | Owner-approved by this task prompt; repository not created by this PR | Verify license state after creation |
| Default branch name | `main` candidate | `main` | Owner-approved by this task prompt; branch not created by this PR | Verify default branch after creation |
| Allowed merge methods | Owner choice | Squash merge only | Owner-approved by this task prompt; setting not configured by this PR | Verify setting with authenticated tooling |
| Auto-merge setting | Disabled or deferred until sandbox-proven | Disabled for now | Owner-approved by this task prompt; setting not configured by this PR | Verify setting with authenticated tooling |
| Automatically delete head branches | Enable if owner approves and setting is verified | Enabled | Owner-approved by this task prompt; setting not configured by this PR | Verify setting with authenticated tooling |
| Branch protection expectation | Absent or minimal until real checks exist | Desired, but `확인 필요` until authenticated settings check | Owner-approved expectation; not configured or verified by this PR | Verify branch protection after creation or configuration task |
| Required checks expectation | No required checks until real checks exist | None at creation time; `확인 필요` later | Owner-approved by this task prompt; not configured or verified by this PR | Verify required checks after creation if needed |
| GitHub Actions or workflow stance | Absent or disabled at first | Absent; do not add workflows yet | Owner-approved by this task prompt; no workflows created by this PR | Verify no workflows if future task needs that evidence |
| Initial content policy | Empty or docs-only | Docs-only minimal fixture | Owner-approved by this task prompt; fixture not created by this PR | Verify initial files after creation |
| Who may create/configure repo | Owner or explicitly authorized actor | Owner-approved future Codex/GitHub-authenticated task | Owner-approved by this task prompt; authentication not verified by this PR | Verify auth and permissions before creation |
| Reuse if target already exists | Stop unless reuse is explicitly approved | Stop and ask owner if the target repo already exists | Owner-approved by this task prompt; existence not verified | Verify target existence before creation |
| Local clone after creation | Allowed only if explicitly approved | Allowed only if necessary and freshly verified | Owner-approved by this task prompt; no clone performed by this PR | Verify local clone path only if needed in future task |
| Initial docs-only fixture content | Excluded unless explicitly approved | Allowed as docs-only minimal fixture | Owner-approved by this task prompt; no fixture created by this PR | Verify fixture scope before adding content |
| Actual sandbox validation in creation task | Excluded by default | Excluded unless separately approved | Owner-approved by this task prompt; no validation run by this PR | Require separate approval before validation |
| Credentials, secrets, trading, automation, and workflows | Forbidden | Forbidden | Owner-approved by this task prompt; no such content added by this PR | Re-check in future creation and validation tasks |

## Recommended Safe Defaults

Recommended defaults after this approval:

- Keep actual sandbox validation out of the creation task unless separately approved.
- Keep GitHub Actions workflows absent or disabled unless separately approved.
- Keep initial content docs-only and minimal.
- Keep credentials, secrets, tokens, API keys, trading code, trading repository connections, automation implementation, PR publisher behavior, branch cleanup automation, risk cap logic, and model promotion logic out of scope.
- Keep GitHub settings that require authenticated verification marked `확인 필요` until checked.
- Keep required checks absent until real checks or workflows exist.
- Stop if the target repository already exists and reuse is not explicitly approved.

## Current Approval Record

The owner-approved values for this decision record are:

```text
Owner-approved sandbox repository decisions:
- owner/org: ckrhehfl
- repo name: codex-dev-factory-sandbox
- full repo identity: ckrhehfl/codex-dev-factory-sandbox
- visibility: public
- initialize with README or empty: initialize with README
- license: no license for now
- default branch: main
- allowed merge methods: squash merge only
- auto-merge: disabled for now
- automatically delete head branches: enabled
- branch protection: desired, but 확인 필요 until authenticated settings check
- required checks: none at creation time, 확인 필요 later
- GitHub Actions/workflows: absent; do not add workflows yet
- initial content policy: docs-only minimal fixture
- creator/configurer: owner-approved future Codex/GitHub-authenticated task
- existing repo reuse: stop and ask owner if the target repo already exists
- local clone allowed: allowed only if necessary and freshly verified
- initial docs-only fixture allowed: allowed as docs-only minimal fixture
- actual sandbox validation excluded from creation task: excluded unless separately approved
- credentials/secrets/trading/automation/workflows: forbidden
```

The future task should then capture verification evidence separately. Prefer portable verification commands and source categories over machine-specific paths. If an exact local path is required, the future task must freshly verify it and mark it as environment-specific.

## Relationship to Creation Runbook

The [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md) may be executed only after this decision record is completed and owner-approved, or after the owner supplies the equivalent decisions directly in the future creation task.

This record now captures owner-approved creation decision values, but it still does not authorize creation by itself. A future sandbox repository creation task must explicitly authorize creation or reuse and must verify the required source-of-truth facts before acting.

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

- Explicitly authorize a sandbox repository creation task using the owner-approved values recorded here.
- Request a later docs-only update if any owner-approved value changes before creation.

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
