# GitHub Operating Policy

This policy defines how the `codex-dev-factory` GitHub repository should be operated while the project remains docs-first and sandbox-first.

## Repository Settings

Allow auto-merge should be enabled when it is safe to do so. Enabling the setting does not make every PR eligible for auto-merge; eligibility still requires an approved policy, real checks, and sandbox-proven behavior.

Automatically delete head branches should be enabled so merged remote PR branches are removed by GitHub instead of by local cleanup routines.

Squash merge is preferred for this project because it keeps `main` readable and treats each approved PR as one reviewable unit. Merge commits and rebase merges are not preferred unless the owner decides otherwise for a specific case.

Repository settings must be verified before relying on them. If settings cannot be verified, Codex must stop with `STOPPED_GITHUB_SETTINGS_UNVERIFIED`.

## Branch Protection

`main` is the protected base branch.

Changes should flow through pull requests. Direct changes to protected base branches are outside the intended operating model.

Required checks should not be enabled until actual checks or workflows exist. Empty required-check policy creates false safety and can block the repository without proving behavior. Until checks exist, stop with `STOPPED_REQUIRED_CHECKS_NOT_READY` if a task asks to require them.

Protected branches must never be deleted by cleanup routines. This includes `main`, `master`, `develop`, and `release/*`.

If branch protection cannot be verified when a task depends on it, Codex must stop with `STOPPED_BRANCH_PROTECTION_UNVERIFIED`.

## PR Lifecycle

Docs-only PRs are the first validation target for the factory. They prove that Codex can scope a change, stay inside allowed files, produce a reviewable diff, and stop before owner-gated actions.

PR metadata must include:

- Scope.
- Non-goals.
- Allowed files.
- Validation plan.
- Stop conditions.

Merge is allowed only after owner approval until auto-merge eligibility is implemented and sandbox-proven.

Auto-merge eligibility is a future policy and implementation phase. It must not be assumed from the repository setting alone.

## GitHub UI Warning Handling

Public or GitHub UI hidden/bidirectional Unicode warnings are signals, not repository source of truth by themselves.

Before cleanup work is proposed or performed, affected files must be checked by a local scan or approved authenticated/tooling scan. At minimum, the scan should check:

- `U+202A`, `U+202B`, `U+202C`, `U+202D`, `U+202E`
- `U+2066`, `U+2067`, `U+2068`, `U+2069`
- `U+200E`, `U+200F`, `U+061C`
- `U+200B`, `U+200C`, `U+200D`, `U+2060`, `U+FEFF`

If target characters are found, evidence should report exact file, line, column, codepoint, Unicode name, and safe minimal context. Fixes should remove or justify only the specific character or characters in a narrow cleanup PR.

If no target characters are found, classify the warning as `not locally reproduced` and do not create cleanup work from the UI warning alone.

Do not normalize or rewrite whole files as part of warning handling. Do not broaden targeted warning handling into unrelated cleanup. Merge and branch cleanup remain owner-gated unless separately approved.

## Branch Cleanup

GitHub remote head branch deletion is handled by the Automatically delete head branches setting.

Local branch and worktree cleanup remains a required post-merge step. It should be performed after GitHub confirms the PR is merged and after the owner approves the standard cleanup prompt.

Force delete is forbidden. Cleanup must use safe deletion only and must stop if safe deletion cannot complete.

The following branches must never be deleted:

- `main`
- `master`
- `develop`
- `release/*`

A dirty worktree stops cleanup. An unmerged branch stops cleanup. A branch shared by an open PR stops cleanup.

Local branch cleanup should verify:

- The PR is merged on GitHub.
- The cleanup target matches the merged PR head branch.
- The target branch is merged into `main`.
- The current worktree is clean.
- No protected branch is targeted.

## Trading Repository Boundary

No automation should connect this repository to a real trading repository before sandbox validation is complete and the owner approves a separate scope.

Trading-related repositories may be used as references or lessons candidates only after source-of-truth revalidation. They must not be treated as operational sources of truth by default.

## Stop States

Codex must stop and report the matching state when one applies:

- `STOPPED_GITHUB_SETTINGS_UNVERIFIED`
- `STOPPED_BRANCH_PROTECTION_UNVERIFIED`
- `STOPPED_REQUIRED_CHECKS_NOT_READY`
- `STOPPED_BRANCH_NOT_MERGED`
- `STOPPED_BRANCH_PROTECTED`
- `STOPPED_LOCAL_WORKTREE_DIRTY`
- `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED`
