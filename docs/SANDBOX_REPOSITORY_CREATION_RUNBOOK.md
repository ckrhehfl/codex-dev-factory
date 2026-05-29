# Sandbox Repository Creation Runbook

## Purpose

This runbook defines the task contract and procedure for a future owner-approved sandbox repository creation task.

This is a documentation contract only. This PR does not create the sandbox repository, run actual sandbox validation, create evidence from a real sandbox run, implement CLI behavior, implement automation, perform GitHub writes, implement PR publisher behavior, implement branch cleanup automation, create workflows, add Discord integration, touch trading code, add credentials, add risk cap logic, or add model promotion logic.

The future task may create or verify a sandbox repository only after the owner explicitly approves that action and records the required decisions from the [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md) record and [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md).

## Preconditions

A future sandbox repository creation task must not begin creation until these preconditions are satisfied or explicitly stopped:

- Owner decisions from [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md) and [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md) are recorded.
- Target repository identity is confirmed, including owner or organization and final repository name.
- GitHub authentication and permissions for repository creation or verification are available and approved.
- Current control-plane repository state is revalidated locally.
- Local `main` is fetched, pruned, and fast-forward pulled.
- Working tree is clean before the creation task starts.
- Current open PR state is checked with available authenticated tooling.
- No blocking open PRs exist, or the owner explicitly approves proceeding despite them.
- Target sandbox repository existence or non-existence is checked with authenticated tooling.
- GitHub settings and branch protection state required by the task are verified or marked `확인 필요` when they are not needed for the current action.

## Future Task Inputs

The future creation task contract must include:

- `scope`: create or verify the owner-approved sandbox repository only.
- `allowed_files`: any docs files that may be updated with creation evidence, if the task includes documentation updates.
- `forbidden_files`: source code, workflow files, credentials, trading repository files, and any files outside the approved creation task.
- `forbidden_actions`: actual sandbox validation, CLI implementation, automation implementation, PR publisher implementation, branch cleanup automation, workflow creation unless separately approved, Discord integration, trading code, credentials, risk cap logic, and model promotion logic.
- `validation_plan`: source-of-truth checks, GitHub repo existence checks, settings checks, evidence capture, and final status reporting.
- Stop states.
- Risk tier.
- Owner gates.

The task must also record:

- Final repository name.
- Owner or organization.
- Visibility.
- Default branch.
- README initialization choice.
- License or no-license choice.
- Allowed merge methods.
- Auto-merge setting.
- Automatically delete head branches setting.
- Branch protection expectations.
- Required checks expectations.
- GitHub Actions or workflow stance.
- Initial content policy: empty, docs-only, or minimal fixture.
- Who is allowed to create and configure the repository.

If the owner-approved initial content policy is a docs-only minimal fixture, the future task should use the [Sandbox Repository Initial Fixture Contract](SANDBOX_REPOSITORY_INITIAL_FIXTURE.md) as the bounded file manifest.

## Creation Procedure

The future task should follow this procedure:

1. Revalidate the control-plane repository source of truth:
   - Run `git rev-parse --show-toplevel`.
   - Run `git remote get-url origin`.
   - Run `git status --short --branch`.
   - Run `git rev-parse HEAD`.
   - Fetch, prune, and fast-forward local `main`.
2. Verify no blocking open PRs exist, or record the owner decision that permits proceeding.
3. Confirm the owner decisions from this runbook and the creation plan.
4. Verify GitHub authentication and permission to create or inspect repositories.
5. Verify whether the target sandbox repository already exists.
6. If the target repository exists, stop unless the owner explicitly approved reuse.
7. If the target repository does not exist and creation is explicitly approved, create the repository with only owner-approved settings.
8. Configure only owner-approved settings.
9. Do not create GitHub Actions workflows unless the task separately approves workflows.
10. Do not run actual sandbox validation unless the task separately approves validation.
11. Do not add credentials, secrets, trading code, automation implementation, CLI behavior, PR publisher behavior, branch cleanup automation, Discord integration, risk cap logic, or model promotion logic.
12. Capture the evidence listed below.
13. Report the final result contract.

## Existing Repository Handling

If the target sandbox repository already exists, the task must distinguish:

- Existing repository verified and owner-approved for reuse.
- Existing repository verified but reuse unclear.
- Repository existence could not be verified.
- Public-only evidence exists but authenticated verification is still needed.

If reuse is unclear, stop with `STOPPED_OWNER_DECISION_REQUIRED` or a more specific matching stop state before using the repository.

Do not silently substitute another repository. In particular, do not select a trading repository as the sandbox target.

## Evidence to Capture

The future creation task must capture:

- Repository URL.
- Creation or verification timestamp/date.
- Verified owner or organization.
- Final repository name.
- Default branch.
- Visibility.
- Initial files.
- License state.
- README initialization state.
- Allowed merge methods checked.
- Auto-merge setting checked.
- Automatically delete head branches setting checked.
- Branch protection state checked.
- Required checks state checked.
- GitHub Actions or workflow stance checked.
- Settings left as `확인 필요`.
- Commands or UI steps used.
- GitHub authentication source used, without recording tokens or secrets.
- Local clone path only if freshly verified, necessary, and explicitly marked environment-specific.
- Final status result.
- Recommended next action.

Evidence should use portable verification commands and result categories where possible. Exact local paths should not be treated as durable source-of-truth evidence.

## Result Contract

The future creation task should report one of these conceptual statuses:

| Status | Meaning | Required next action |
| --- | --- | --- |
| `created` | The sandbox repository was created with owner-approved settings and evidence was captured. | Hand off to owner-approved sandbox validation planning or initial fixture work. |
| `already_exists_owner_decision_required` | The target repository exists, but reuse was not explicitly approved. | Stop and request owner decision. |
| `stopped` | A stop condition applies. | Report the registry-backed stop code, reason, interrupted lifecycle state when known, and recommended next action. |
| `확인 필요` | A required fact was not checked, unavailable, or only public/user-reported. | Verify with the correct local or authenticated source before relying on it. |

The result should preserve:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

## Stop Conditions

Use existing stop-state guidance. This runbook introduces no new `STOPPED_*` codes.

Stop when:

- Required task fields are missing: `STOPPED_TASK_CONTRACT_INCOMPLETE`.
- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- Source-of-truth state is unclear: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- Required source-of-truth context has not been verified: `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`.
- Owner decisions are missing or reuse is unclear: `STOPPED_OWNER_DECISION_REQUIRED`.
- GitHub authentication or settings cannot be verified when required: `STOPPED_GITHUB_SETTINGS_UNVERIFIED`.
- Branch protection cannot be verified when required: `STOPPED_BRANCH_PROTECTION_UNVERIFIED`.
- Required checks are requested before real checks exist: `STOPPED_REQUIRED_CHECKS_NOT_READY`.
- Sandbox remote or identity cannot be verified when needed: `STOPPED_SANDBOX_REMOTE_UNVERIFIED`.
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

If the future task stops, it should preserve the interrupted lifecycle state when known and recommend the earliest state that must be revalidated before resuming.

## Non-Goals for the Future Creation Task

Unless separately scoped and explicitly approved, the future creation task must not:

- Run actual sandbox validation.
- Create sandbox validation evidence from a real run.
- Implement CLI behavior.
- Implement automation.
- Implement GitHub writes beyond the explicitly approved repository creation action.
- Implement PR publisher behavior.
- Implement branch cleanup automation.
- Create or edit GitHub Actions workflows.
- Implement Discord integration.
- Implement or modify trading code.
- Add credentials, secrets, tokens, API keys, risk cap logic, or model promotion logic.
- Touch any trading repository.

## Handoff After Creation

If repository creation succeeds, the next task should be one of:

- Sandbox validation planning.
- A docs-only initial fixture PR in the sandbox repository.
- Sandbox validation evidence capture setup for a later approved run.

The owner must approve which handoff happens next.

If creation is stopped:

- Preserve the stopped state.
- Report the registry-backed stop code.
- Record the interrupted lifecycle state when known.
- Record the recommended next action.
- Do not continue into validation, fixture creation, automation, workflows, or implementation.

## Relationship to Existing Contracts

The [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md) defines owner decisions and prerequisites. This runbook defines the future task procedure and result contract.

The [Sandbox Repository Initial Fixture Contract](SANDBOX_REPOSITORY_INITIAL_FIXTURE.md) defines the docs-only minimal initial content manifest a future creation task may apply after creation or reuse is explicitly authorized.

The [Sandbox Validation](SANDBOX_VALIDATION.md) plan defines validation after the sandbox repository exists and validation is separately approved.

The [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md) defines evidence for future sandbox validation runs. This runbook captures creation evidence only.

The [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md) defines repository settings, branch protection, merge-method expectations, required-check timing, and cleanup boundaries.

The [Task Contract](operations/TASK_CONTRACT.md), [Local Task Format Contract](LOCAL_TASK_FORMAT.md), [Task Lifecycle State Model](operations/TASK_LIFECYCLE.md), [Factory Status Result Contract](FACTORY_STATUS_RESULT.md), and [Stop-State Registry](STOP_STATE_REGISTRY.md) define task fields, lifecycle state, status reporting, and stop-state behavior that future creation tasks must preserve.

## Source-of-Truth Handling

Future creation tasks must distinguish:

- Local-verified facts.
- Authenticated GitHub-verified facts.
- Public GitHub-visible facts.
- User-reported facts.
- `확인 필요` facts.

Do not infer sandbox repository existence, settings, permissions, branch protection, required checks, default branch, merge methods, auto-merge, automatically delete head branches, or workflow state from memory, prior conversation, public-only views, or candidate names.

## This PR's Non-Goals Confirmed

This PR does not:

- Create the sandbox repository.
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
