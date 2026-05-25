# Sandbox Repository Initial Fixture Contract

## Purpose

This document defines the docs-only minimal initial fixture for the future sandbox repository `ckrhehfl/codex-dev-factory-sandbox`.

The fixture gives a later owner-authorized sandbox repository creation task a bounded initial content manifest. It makes the first sandbox repository self-describing without adding source code, workflows, automation, credentials, trading content, or validation evidence.

This is a documentation contract only. This PR does not create, configure, clone, or modify the sandbox repository; run actual sandbox validation; create evidence from a real sandbox run; implement CLI behavior; implement automation; perform GitHub writes; implement PR publisher behavior; implement branch cleanup automation; create workflows; add Discord integration; touch trading code; add credentials; add risk cap logic; or add model promotion logic.

## Fixture Status

Status: `fixture_contract_ready`.

The fixture contract is ready for a future creation task to reference, but it does not authorize sandbox repository creation by itself.

Sandbox repository creation remains separately owner-authorized. Actual sandbox validation remains separately owner-approved and must not be performed as part of this fixture contract.

Sandbox repository existence, GitHub settings, branch protection, required checks, permissions, and authenticated-only facts remain `확인 필요` until a future task verifies them with the required local or authenticated source.

## Owner-Approved Context

The owner-approved sandbox repository decisions are recorded in [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md).

Relevant approved values for this fixture contract:

- Sandbox repo owner/org: `ckrhehfl`.
- Sandbox repo name: `codex-dev-factory-sandbox`.
- Full repo identity: `ckrhehfl/codex-dev-factory-sandbox`.
- Visibility: public.
- Initialize with README: yes.
- License: no license for now.
- Default branch: `main`.
- Merge method: squash merge only.
- Auto-merge: disabled for now.
- Automatically delete head branches: enabled.
- Branch protection: desired, but `확인 필요` until authenticated settings check.
- Required checks: none at creation time, `확인 필요` later.
- Workflows: absent; do not add workflows yet.
- Initial content: docs-only minimal fixture.
- Actual sandbox validation during creation: excluded unless separately approved.
- Credentials, secrets, trading, automation, and workflows: forbidden.

These values are owner-approved decisions, not proof that the sandbox repository exists or that settings have been configured.

## Future Sandbox File Manifest

The following paths are future sandbox repository paths. They are not files to create in this control-plane repository.

| Future sandbox path | Required? | Content intent |
| --- | --- | --- |
| `README.md` | Yes | Identify the repository as a non-production Codex factory sandbox and point to the sandbox scope document. |
| `docs/SANDBOX_SCOPE.md` | Yes | State allowed and forbidden sandbox activities, source-of-truth handling, owner gates, and safety boundaries. |
| `docs/VALIDATION_FIXTURE.md` | Yes | Provide a safe docs-only target that later sandbox PRs may edit to validate branch, PR, review, merge, cleanup, guard, and evidence behavior. |

No other initial fixture files are approved by this contract.

## Required Content Intent

### `README.md`

The future sandbox `README.md` should:

- Identify the repository as a non-production Codex development factory sandbox.
- State that the sandbox is not a product repository and not a trading repository.
- State that initial work is docs-only.
- Link to `docs/SANDBOX_SCOPE.md`.
- Link to `docs/VALIDATION_FIXTURE.md`.
- State that workflows, automation, credentials, trading code, and implementation are absent unless separately approved later.

### `docs/SANDBOX_SCOPE.md`

The future sandbox scope document should:

- Define allowed activities for early sandbox work:
  - docs-only PR validation.
  - branch and PR lifecycle validation.
  - PR metadata completeness checks.
  - allowed-files and forbidden-actions checks.
  - merge verification and cleanup evidence.
  - post-merge lesson decision validation.
- Define forbidden activities:
  - source code.
  - GitHub Actions workflows.
  - credentials, secrets, tokens, or API keys.
  - trading code, live trading logic, risk cap logic, or model promotion logic.
  - Discord bot code.
  - GitHub write automation implementation.
  - PR publisher implementation.
  - branch cleanup automation.
  - dependency manifests unless separately approved.
- Preserve owner gates and `확인 필요` handling for repository settings, branch protection, required checks, and authenticated-only facts.

### `docs/VALIDATION_FIXTURE.md`

The future validation fixture document should:

- Be safe for later docs-only sandbox PR edits.
- Contain intentionally low-risk placeholder sections that can be edited during validation.
- Avoid pretending that validation already ran.
- Avoid recording real sandbox evidence until a later approved sandbox validation task captures it.
- Preserve source-of-truth discipline by distinguishing local-verified, authenticated-GitHub-verified, public-view-only, user-reported, and `확인 필요` facts when examples are needed.

## Strict Fixture Prohibitions

The future sandbox fixture must not include:

- Source code.
- GitHub Actions or workflow files.
- Credentials, secrets, tokens, API keys, or account configuration.
- Trading code.
- Live trading logic.
- Risk cap logic.
- Model promotion logic.
- Discord bot code.
- GitHub write automation.
- PR publisher implementation.
- Branch cleanup automation.
- Dependency manifests unless separately approved.

If any prohibited file or content is requested or appears in the future fixture task, the task must stop before commit or external write.

## Future Creation Task Behavior

A future sandbox repository creation task may use this fixture contract only when that later task explicitly authorizes sandbox repository creation or reuse.

That future task:

1. Revalidates the control-plane repository source of truth.
2. Confirms the owner-approved decisions in [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md).
3. Follows the [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md).
4. Verifies whether `ckrhehfl/codex-dev-factory-sandbox` already exists.
5. Stops if the target repository exists and reuse is unclear.
6. Creates or reuses the sandbox repository only after explicit owner authorization.
7. Adds this fixture only as docs-only initial content.
8. Does not run actual sandbox validation unless separately approved.
9. Does not add workflows, source code, credentials, trading content, automation, PR publisher behavior, branch cleanup automation, Discord integration, dependency manifests, risk cap logic, or model promotion logic unless a later approved task explicitly changes scope.

If the future task summarizes or transforms creation, fixture, evidence, validation, or status information, it must preserve `scope`, `allowed_files`, `forbidden_files`, `forbidden_actions`, `validation_plan`, stop states, risk tier, and owner gates.

## Fixture Evidence Expectations

A future creation task that applies this fixture should report:

- Repository URL.
- Initial commit hash.
- Default branch.
- Fixture files created.
- Whether README initialization was used.
- Settings verified.
- Settings left as `확인 필요`.
- Source used for sandbox repository existence or non-existence.
- Confirmation that no forbidden files were created.
- Confirmation that actual sandbox validation was not run unless separately approved.
- Confirmation that future sandbox file paths were created in the sandbox repository, not in this control-plane repository.

Evidence must use portable verification commands and source categories where possible. Exact local clone paths may be recorded only when necessary, freshly verified, and marked environment-specific.

## Relationship to Sandbox Validation

This fixture exists to support later docs-only PR validation in the sandbox repository.

Actual sandbox validation must use [Sandbox Validation](SANDBOX_VALIDATION.md) and [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md). Evidence from actual validation must not be fabricated during fixture planning or repository creation.

The fixture may provide safe documents for later validation edits, but the existence of those documents is not evidence that the validation loop passed.

## Relationship to Creation Planning and Runbook

The [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md) defines the planning and owner decision context.

The [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md) records owner-approved creation values.

The [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md) defines the future procedure, evidence, result contract, and stop conditions for creation or reuse.

This fixture contract defines only the docs-only initial content manifest that the future creation task may apply after creation or reuse is explicitly authorized.

## Stop Conditions

Use existing stop-state guidance. This fixture contract introduces no new `STOPPED_*` codes.

Stop when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- Source-of-truth state is unclear: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- Required source-of-truth context has not been verified: `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`.
- Owner authorization for creation or reuse is missing: `STOPPED_OWNER_DECISION_REQUIRED`.
- Target repository exists and reuse is unclear: `STOPPED_OWNER_DECISION_REQUIRED`.
- Sandbox remote or identity cannot be verified when needed: `STOPPED_SANDBOX_REMOTE_UNVERIFIED`.
- GitHub settings are needed but cannot be verified: `STOPPED_GITHUB_SETTINGS_UNVERIFIED`.
- Branch protection is needed but cannot be verified: `STOPPED_BRANCH_PROTECTION_UNVERIFIED`.
- Required checks are requested before real checks exist: `STOPPED_REQUIRED_CHECKS_NOT_READY`.
- Fixture scope expands into implementation: `STOPPED_IMPLEMENTATION_INCLUDED`.
- Fixture scope expands into source code: `STOPPED_CODE_INCLUDED`.
- Fixture scope expands into workflows: `STOPPED_WORKFLOW_INCLUDED`.
- Fixture scope expands into GitHub write automation: `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`.
- Fixture scope expands into branch cleanup automation: `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`.
- Fixture scope expands into credentials or secrets: `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.
- Fixture scope expands into trading code: `STOPPED_TRADING_CODE_INCLUDED`.
- Fixture scope selects a trading repository too early: `STOPPED_TRADING_REPO_SELECTED_TOO_EARLY`.
- Changed files exceed the approved fixture or task file boundaries: `STOPPED_FORBIDDEN_FILE_CHANGE`.
- A documented transformation drops required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.
- A stop-state surface mismatch remains: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

If a future fixture or creation task stops, preserve the interrupted lifecycle state when known and report the recommended next action.

## Safety Field Preservation

Future creation, fixture handoff, evidence, result status, validation handoff, and stopped handoff must preserve:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

Dropping safety fields is a stop condition.

## Non-Goals Confirmed

This fixture contract does not:

- Create the sandbox repository.
- Configure GitHub settings.
- Clone the sandbox repository.
- Run actual sandbox validation.
- Create evidence from a real sandbox run.
- Implement CLI behavior.
- Implement automation.
- Perform GitHub writes beyond documenting future owner-approved repo creation.
- Implement PR publisher behavior.
- Implement branch cleanup automation.
- Create or edit GitHub Actions workflows.
- Implement Discord integration.
- Implement or modify trading code.
- Add credentials, secrets, tokens, API keys, risk cap logic, or model promotion logic.
- Touch any trading repository.
