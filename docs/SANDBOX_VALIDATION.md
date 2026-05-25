# Sandbox Validation

## Definition

The sandbox is a separate test GitHub repository for validating automation behavior before the factory touches any real product or trading repository.

The candidate sandbox repository name is `codex-dev-factory-sandbox`.

The candidate local clone path is `C:\Dev\codex-dev-factory-sandbox`.

The sandbox is not just a Windows folder. It is expected to be a separate GitHub repository with its own remote, branches, PRs, merge history, and cleanup behavior.

## Purpose

Sandbox validation proves that the Codex-first development factory can operate safely before any trading repo integration.

The first sandbox tests should stay low risk and docs-only. They should validate task intake, source-of-truth revalidation, scoped branches, allowed-file enforcement, PR metadata, merge verification, remote branch cleanup, local branch/worktree cleanup, and lesson capture decisions.

Before sandbox repository creation or actual sandbox validation begins, the project should use the [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md) to confirm that core docs, policy surfaces, owner gates, stop states, and safety-field preservation are ready enough for that phase target.

Future sandbox validation runs should record evidence according to the [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md). Evidence capture must make PR, review, merge, cleanup, guard, lesson-review, owner-decision, and unknown state visible before a run is accepted.

The existing `ckrhehfl/institutional-futures-trader` repository must not be used as source of truth for sandbox validation. It remains a reference and lessons candidate only after explicit revalidation.

## First Validation Loop

The first safe validation loop is:

1. Create a docs-only task.
2. Revalidate the source of truth.
3. Generate Scope, Non-goals, Allowed files, Validation plan, and Stop conditions.
4. Create an isolated branch or worktree.
5. Produce docs-only changes.
6. Validate that changed files are inside the allowed-file list.
7. Push the branch.
8. Create a PR.
9. Verify PR metadata includes Scope, Non-goals, Allowed files, Validation plan, and Stop conditions.
10. Merge only after allowed checks and owner approval.
11. Confirm GitHub reports the PR merged state.
12. Confirm remote head branch cleanup through the GitHub Automatically delete head branches setting.
13. Run local branch/worktree cleanup.
14. Decide whether post-merge lesson capture is needed.

Each loop should leave enough evidence for the owner to inspect what happened without relying on hidden automation state.

The evidence packet for each future loop should record the source of truth for every important claim rather than relying on branch names, public-only pages, memory, or handoff notes.

## Sandbox Acceptance Criteria

A sandbox validation loop is acceptable only when all of these are true:

- No forbidden file changes occurred.
- No workflow files were created unless explicitly allowed for that phase.
- No source code implementation was added.
- No credentials or secrets were introduced.
- No trading logic was introduced.
- No live trading boundary changed.
- PR metadata was complete.
- Merge state was verified on GitHub.
- Remote head branch cleanup was verified or a stop state was reported.
- Local branch/worktree cleanup was verified.

## Trading Repository Boundary

No automation should connect to any trading repository before sandbox validation is complete, reviewed, and accepted.

Trading repository integration must be treated as a later high-risk phase with a separate owner decision. Sandbox success can justify deeper design, but it does not automatically approve integration with trading code, credentials, live trading systems, risk caps, or model promotion paths.

## Stop States

Codex must stop and report the matching state when one applies:

- `STOPPED_SANDBOX_REPO_NOT_CREATED`
- `STOPPED_SANDBOX_REMOTE_UNVERIFIED`
- `STOPPED_FORBIDDEN_FILE_CHANGE`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_IMPLEMENTATION_INCLUDED`
- `STOPPED_PR_METADATA_INCOMPLETE`
- `STOPPED_MERGE_STATE_UNVERIFIED`
- `STOPPED_REMOTE_BRANCH_NOT_PRUNED`
- `STOPPED_LOCAL_WORKTREE_DIRTY`
- `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED`
- `STOPPED_TRADING_REPO_SELECTED_TOO_EARLY`
