# Sandbox Repository Creation Plan

## Purpose

This document prepares a future owner-approved task to create a sandbox repository for validating the Codex development factory.

This is a planning document only. It does not create the sandbox repository, run actual sandbox validation, create sandbox validation evidence from a real run, implement CLI behavior, implement automation, write to GitHub, implement PR publisher behavior, implement branch cleanup automation, create workflows, add Discord integration, touch trading code, add credentials, add risk cap logic, or add model promotion logic.

The plan separates planning completeness from creation approval. Planning can be complete while the result remains `owner_decision_required`.

## Proposed Sandbox Identity

Candidate identity:

- Candidate repository owner or organization: `ckrhehfl`.
- Candidate repository name: `codex-dev-factory-sandbox`.
- Candidate GitHub repository: `ckrhehfl/codex-dev-factory-sandbox`.

Sandbox repository existence, repository settings, branch protection, and authenticated-only state remain `확인 필요` until a future creation task verifies them with authenticated tooling.

Do not treat a candidate local path as durable source-of-truth evidence. If a future task needs a local clone path, it should verify the repository root with portable command-backed evidence, such as `git rev-parse --show-toplevel`, and clearly mark exact paths as environment-specific.

## Planning Result

Recommended result: `owner_decision_required`.

This planning document is ready for owner review when:

- The owner decisions below are visible.
- The creation prerequisites are explicit.
- The safety boundaries are preserved.
- The future creation task outline is clear.
- The document does not imply sandbox creation or actual validation already happened.

This plan does not mean the sandbox repository is ready to create automatically. Creation requires a separate explicit owner approval and a later task scoped to that action.

The future creation task procedure and result contract are defined in [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md). The runbook also does not create the sandbox repository.

## Owner Decisions Required Before Creation

The owner should decide and record:

| Decision | Current planning value | Notes |
| --- | --- | --- |
| Final repository name | `codex-dev-factory-sandbox` candidate | Keep as candidate until owner confirms. |
| Repository owner or organization | `ckrhehfl` candidate | Verify the account or organization before creation. |
| Visibility | Owner decision required | Choose public or private before creation. |
| Initialize with README | Owner decision required | A README can make the repo self-describing; an empty repo may better test initialization flow. |
| License | Owner decision required | Choose a license or explicitly choose no license. |
| Default branch name | Owner decision required | Usually `main`, but do not assume. |
| Allowed merge methods | Owner decision required | Decide squash, merge commit, rebase, or a subset. |
| Automatically delete head branches | Owner decision required | Recommended by [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) for this control-plane repo; sandbox setting still requires explicit decision and verification. |
| Auto-merge | Owner decision required | Do not rely on auto-merge until policy and checks are sandbox-proven. |
| Branch protection expectations | Owner decision required | Required checks should not be enabled until real checks exist. |
| Required checks | Owner decision required | If no real checks exist, keep required checks absent or stop with the existing required-check stop guidance. |
| GitHub Actions or workflows | Owner decision required | Recommended initial boundary: absent or disabled unless separately approved. |
| Who may create/configure the repo | Owner decision required | Record whether owner, Codex under instruction, or another maintainer performs creation. |
| Initial content model | Owner decision required | Choose empty, docs-only, or minimal fixture. |

## Safety Boundaries

The sandbox repository must remain bounded by these rules until a later owner-approved phase expands scope:

- It must not contain trading code.
- It must not contain credentials, secrets, tokens, API keys, or account configuration.
- It must not connect to a real trading repository.
- It must not implement GitHub write automation.
- It must not implement PR publisher behavior.
- It must not implement branch cleanup automation.
- It must not create or rely on GitHub Actions workflows unless separately approved.
- It must not implement CLI behavior.
- It must not implement Discord integration.
- It must be used only for docs-only validation until later phases explicitly expand scope.

The existing `ckrhehfl/institutional-futures-trader` repository remains a reference and lessons candidate only after explicit revalidation and owner approval. It must not be selected as the sandbox repository.

## Creation Prerequisites

A later creation task should not create or configure a sandbox repository until all required prerequisites are checked or explicitly marked as owner decisions:

- Control-plane repository source-of-truth state is revalidated with local git and authenticated GitHub tooling where needed.
- Local `main` is fetched, pruned, and fast-forward pulled before creating any task branch.
- No blocking open PRs exist in the control-plane repo, or the owner explicitly accepts proceeding despite them.
- Owner decisions in this plan are recorded.
- GitHub authentication method is available and approved for repository creation.
- Target sandbox repository non-existence or intended reuse is verified.
- If the repository already exists, intended reuse is approved by the owner before it is used.
- GitHub settings that require authentication are checked or left as `확인 필요` when they are not needed for the current step.
- Required safety fields are preserved in the future task contract: `scope`, `allowed_files`, `forbidden_files`, `forbidden_actions`, `validation_plan`, stop states, risk tier, and owner gates.

## Future Creation Task Outline

A later owner-approved creation task may create the sandbox repository only when the task explicitly authorizes repository creation.

That task should:

1. Revalidate the control-plane repo, branch, remote, working tree, latest `main`, and open PR state.
2. Run required solution lookup before planning or editing.
3. Confirm the owner decisions in this plan.
4. Verify whether `ckrhehfl/codex-dev-factory-sandbox` exists.
5. If the repository exists, stop for owner decision unless reuse was explicitly approved.
6. If the repository does not exist and creation is approved, create it with the owner-approved settings.
7. Report the created repository URL, default branch, initial files, settings checked, and remaining `확인 필요` items.
8. Avoid running actual sandbox validation unless the creation task explicitly includes validation.
9. Avoid creating workflows, automation, CLI behavior, PR publisher behavior, branch cleanup automation, Discord integration, trading functionality, credentials, risk cap logic, or model promotion logic.
10. Hand off to the sandbox validation contracts only after creation evidence is captured.

## Relationship to Sandbox Validation

This plan comes before actual sandbox validation.

The [Sandbox Validation](SANDBOX_VALIDATION.md) document defines the future low-risk validation loop once a sandbox repository exists and the owner approves a validation task.

The [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md) defines what a future sandbox run must record before a pass, fail, blocked, unknown, owner-decision, or stopped result is accepted.

Evidence packet capture happens only after a real sandbox run is explicitly approved and performed. This planning PR does not create evidence from a real sandbox run.

## Source-of-Truth and Unknown Handling

Future creation and validation tasks must distinguish:

- Local-verified state.
- Authenticated GitHub-verified state.
- Public GitHub-visible state.
- User-reported state.
- Unknown or `확인 필요` state.

Do not infer repository existence, repository settings, branch protection, required checks, auto-merge, automatically delete head branches, default branch, or permissions from memory, prior PRs, public-only views, or candidate names.

Prefer portable verification evidence for local facts, including:

- `git rev-parse --show-toplevel`.
- `git remote get-url origin`.
- `git status --short --branch`.
- `git rev-parse HEAD`.

Exact local paths may be recorded only when necessary, freshly revalidated, and clearly scoped to that run.

## Stop Conditions

Use existing stop-state guidance. This plan introduces no new `STOPPED_*` codes.

Stop when:

- Required solution lookup is skipped: `STOPPED_SOLUTION_LOOKUP_SKIPPED`.
- Source-of-truth state is unclear: `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- Owner decisions required for creation are missing: `STOPPED_OWNER_DECISION_REQUIRED`.
- GitHub settings are needed but cannot be verified: `STOPPED_GITHUB_SETTINGS_UNVERIFIED`.
- Branch protection is needed but cannot be verified: `STOPPED_BRANCH_PROTECTION_UNVERIFIED`.
- Required checks are requested before real checks exist: `STOPPED_REQUIRED_CHECKS_NOT_READY`.
- Sandbox remote or identity cannot be verified when needed: `STOPPED_SANDBOX_REMOTE_UNVERIFIED`.
- A requested action would introduce implementation: `STOPPED_IMPLEMENTATION_INCLUDED`.
- A requested action would introduce GitHub write automation: `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`.
- A requested action would introduce workflows: `STOPPED_WORKFLOW_INCLUDED`.
- A requested action would introduce credentials or secrets: `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.
- A requested action would introduce trading code: `STOPPED_TRADING_CODE_INCLUDED`.
- A requested action would select a trading repository too early: `STOPPED_TRADING_REPO_SELECTED_TOO_EARLY`.
- A documented transformation drops required safety fields: `STOPPED_SAFETY_FIELD_DROPPED`.
- A stop-state surface mismatch remains: `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

If the sandbox repository already exists and intended reuse is unclear, stop for owner decision before using it.

## Owner Decision Checklist

Before any creation task begins, the owner should answer:

- Is `ckrhehfl/codex-dev-factory-sandbox` the final repository identity?
- Should the repository be public or private?
- Should it be initialized with a README?
- Should it include a license? If yes, which one?
- What default branch name should be used?
- Which merge methods should be enabled?
- Should automatically delete head branches be enabled?
- Should auto-merge be enabled, disabled, or deferred?
- Should branch protection be absent, minimal, or configured after real checks exist?
- Should required checks be absent until real checks exist?
- Should GitHub Actions remain absent or disabled at first?
- Who is allowed to create and configure the repository?
- Should the initial repository content be empty, docs-only, or a minimal fixture?
- If the target repository already exists, should it be reused or replaced by a different sandbox identity?

## Handoff to Future Validation

After repository creation is separately approved and completed, a later sandbox validation task should use:

- [Sandbox Validation](SANDBOX_VALIDATION.md) for the validation loop.
- [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md) for the evidence packet.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md) for lifecycle state transitions.
- [Stop-State Registry](STOP_STATE_REGISTRY.md) for stop codes.
- [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) for settings and branch safety.

The future validation task should not treat this planning document as proof that the sandbox repository exists, that settings are configured, or that validation already passed.

## Non-Goals Confirmed

This plan does not:

- Create the sandbox repository.
- Run actual sandbox validation.
- Create evidence from a real sandbox run.
- Implement CLI behavior.
- Implement automation.
- Implement GitHub writes.
- Implement PR publisher behavior.
- Implement branch cleanup automation.
- Create or edit GitHub Actions workflows.
- Implement Discord integration.
- Implement or modify trading code.
- Add credentials, secrets, tokens, API keys, risk cap logic, or model promotion logic.
- Touch any trading repository.
