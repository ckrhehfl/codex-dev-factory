# Sandbox Repository Creation Evidence

## Purpose

This document records the owner-authorized sandbox repository creation and initial docs-only fixture setup result for `ckrhehfl/codex-dev-factory-sandbox`.

It preserves creation evidence for future tasks so they do not rely on chat history, handoff notes, or prior assistant output.

This evidence record is a control-plane documentation PR only. It does not modify the sandbox repository, run actual sandbox validation, create a sandbox validation PR, create validation evidence from a real run, implement CLI behavior, implement automation, implement GitHub write automation, implement PR publisher behavior, implement branch cleanup automation, create workflows, add Discord integration, touch trading code, add credentials, add risk cap logic, or add model promotion logic.

## Result

Result: `created`.

The sandbox repository was created in a separately owner-authorized setup task. This document records and revalidates the resulting evidence where safely possible.

## Owner-Approved Context

The owner-approved sandbox repository values are recorded in [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md).

Those owner-approved values include:

- Repository identity: `ckrhehfl/codex-dev-factory-sandbox`.
- Visibility: public.
- Default branch: `main`.
- Initialize with README.
- License: no license for now.
- Merge method: squash merge only.
- Auto-merge: disabled.
- Automatically delete head branches: enabled.
- Initial content: docs-only minimal fixture.
- Workflows, credentials, secrets, trading content, automation, PR publisher behavior, branch cleanup automation, risk cap logic, and model promotion logic: forbidden.
- Actual sandbox validation during creation: excluded unless separately approved.

Owner-approved values are task authority, not verification evidence by themselves. Verification evidence is recorded separately below by source category.

## Sandbox Repository Identity

| Field | Evidence category | Value | Notes |
| --- | --- | --- | --- |
| Owner or organization | Authenticated GitHub-verified | `ckrhehfl` | Verified through authenticated GitHub CLI repository metadata. |
| Repository name | Authenticated GitHub-verified | `codex-dev-factory-sandbox` | Verified through authenticated GitHub CLI repository metadata. |
| Full repository | Authenticated GitHub-verified | `ckrhehfl/codex-dev-factory-sandbox` | Verified through authenticated GitHub CLI repository metadata. |
| URL | Public/web-verifiable and authenticated GitHub-verified | `https://github.com/ckrhehfl/codex-dev-factory-sandbox` | Public repository URL. |
| Visibility | Public/web-verifiable and authenticated GitHub-verified | public | Authenticated metadata reported `visibility: public` and `isPrivate: false`. |
| Default branch | Public/web-verifiable and authenticated GitHub-verified | `main` | Authenticated metadata reported `default_branch: main`. |

## Creation and Fixture Evidence

| Item | Evidence category | Value | Notes |
| --- | --- | --- | --- |
| Created at | Authenticated GitHub-verified | `2026-05-25T13:47:03Z` | Repository metadata from authenticated GitHub CLI. |
| Initial commit | Authenticated GitHub-verified | `99c2086e59cc571440e0bec25678d66d19ad5fad` | Initial README commit. |
| Final `main` HEAD after fixture | Authenticated GitHub-verified | `fe828e847a7fe29d3463a92096f5b94f4b52b901` | Verified with `gh api repos/ckrhehfl/codex-dev-factory-sandbox/git/ref/heads/main`. |
| Fixture file tree | Authenticated GitHub-verified | `README.md`, `docs/SANDBOX_SCOPE.md`, `docs/VALIDATION_FIXTURE.md` | Verified with the Git tree API. |
| Local clone path | Local-verified | Not created | No local clone was created for this evidence PR. |

## Fixture Files

The sandbox repository currently contains these fixture paths:

- `README.md`
- `docs/SANDBOX_SCOPE.md`
- `docs/VALIDATION_FIXTURE.md`

These are sandbox repository paths, not files created by this evidence PR in the control-plane repository.

## Settings and State Evidence

### Public/Web-Verifiable Evidence

- The repository URL is public: `https://github.com/ckrhehfl/codex-dev-factory-sandbox`.
- The visible repository identity is `ckrhehfl/codex-dev-factory-sandbox`.
- Visible fixture files are expected to be inspectable through the public repository view.

Public view is not enough to prove authenticated-only settings, secrets, or permissions.

### Authenticated/Tool-Reported Evidence

Authenticated GitHub CLI checks in this evidence task reported:

| Setting or state | Revalidated value |
| --- | --- |
| Visibility | public |
| Default branch | `main` |
| Squash merge | enabled |
| Merge commits | disabled |
| Rebase merge | disabled |
| Auto-merge | disabled |
| Automatically delete head branches | enabled |
| Branch protection on `main` | not configured; branch protection API returned `Branch not protected` |
| Required checks | not configured because branch protection is not configured |
| `.github/workflows` directory | absent; contents API returned `Not Found` |
| Repository secrets list | empty output from `gh secret list --repo ckrhehfl/codex-dev-factory-sandbox` |
| License endpoint | `Not Found`, consistent with no license detected |
| Sandbox PR list | empty list |
| Final file tree | `README.md`, `docs/SANDBOX_SCOPE.md`, `docs/VALIDATION_FIXTURE.md` |

### Local-Verified Evidence

For this control-plane evidence PR:

- Repository root was verified with `git rev-parse --show-toplevel`.
- Remote was verified with `git remote -v`.
- Branch and worktree state were verified with `git status --short --branch`.
- Local `main` was fetched, pruned, and fast-forward pulled before creating this branch.
- Control-plane open PR state was checked with authenticated GitHub CLI and returned an empty list.
- PR #29 was revalidated as merged with merge commit `35b3bcd3bf52d6a0ab67ec65f28ae46d864f32d2`.

This document avoids treating exact local paths as durable source-of-truth evidence. Local paths are environment-specific and should be revalidated in future runs when needed.

### User-Reported Evidence

The task prompt reported that:

- PR #29 was merged.
- Local cleanup after PR #29 was completed.
- The owner-authorized sandbox setup task completed with result `created`.
- The setup task created the fixture files and reported the settings listed above.

These claims were revalidated where safely possible with local git and authenticated GitHub CLI during this evidence task.

## Validation Summary

Validation result: pass for this docs-only evidence PR.

Revalidated evidence supports:

- The sandbox repository exists.
- The sandbox repository is public.
- The default branch is `main`.
- The expected fixture files exist.
- No `.github/workflows` directory exists.
- No sandbox pull requests exist.
- No local clone was created for this evidence PR.
- No actual sandbox validation was run by this evidence PR.
- The control-plane repository changes in this PR are docs-only.

This evidence record does not prove future branch protection, required checks, secrets, or settings state. Future tasks must revalidate authenticated-only state before relying on it.

## Confirmations

- No actual sandbox validation was run.
- No sandbox validation PR was created.
- No sandbox repository modification was performed by this evidence PR.
- No workflows were created.
- No secrets, credentials, tokens, or API keys were added.
- No trading code was added.
- No source code implementation was added.
- No CLI behavior was implemented.
- No automation was implemented.
- No PR publisher behavior was implemented.
- No branch cleanup automation was implemented.
- No Discord integration was implemented.
- No risk cap logic was added.
- No model promotion logic was added.
- No trading repository was touched.

## Remaining 확인 필요

- Branch protection remains not configured; future owner decision is required if protection should be added.
- Required checks remain not configured because no branch protection or real checks exist yet.
- Future required checks remain `확인 필요` if branch protection is added later.
- Authenticated-only settings should be revalidated before any future automation or policy relies on them.
- Actual sandbox validation has not happened.
- Future sandbox validation evidence remains `확인 필요` until a separate owner-approved sandbox validation task runs.

## Recommended Next Step

Run a separate owner-approved sandbox docs-only PR validation task using:

- [Sandbox Validation](SANDBOX_VALIDATION.md).
- [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md).

Do not run validation automatically from this evidence PR.

## Relationship to Existing Contracts

This evidence record follows the owner decisions in [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md), the procedure and evidence expectations in [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md), and the fixture manifest in [Sandbox Repository Initial Fixture Contract](SANDBOX_REPOSITORY_INITIAL_FIXTURE.md).

Actual sandbox validation remains governed by [Sandbox Validation](SANDBOX_VALIDATION.md) and [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md).

Stop-state and source-of-truth handling remain governed by [Stop-State Registry](STOP_STATE_REGISTRY.md), [Task Lifecycle State Model](operations/TASK_LIFECYCLE.md), [Risk Policy](operations/RISK_POLICY.md), and [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md).

## Safety Field Preservation

This evidence record preserves:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

Dropping these fields remains a stop condition in future evidence, validation, status, or handoff work.

## Non-Goals Confirmed

This evidence record does not:

- Modify the sandbox repository.
- Clone the sandbox repository.
- Create a sandbox validation PR.
- Run actual sandbox validation.
- Create sandbox validation evidence from a real validation run.
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
