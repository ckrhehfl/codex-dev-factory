# PR 35 Worktree Harness Result Review Lessons

## Source

- PR #35: [Docs: define worktree harness result contract](https://github.com/ckrhehfl/codex-dev-factory/pull/35)
- Review source: authenticated/tool-reported GitHub review threads.
- Initial commit: `96076730381f68aef546f98d9e28d771bc7be4fd` (`Docs: define worktree harness result contract`).
- Review-fix commit: `a4961214b77c2698ced5d2390768449d50a2e7d4` (`Docs: address review comments`).
- Merge commit: `628f651657571d491afea17c98cadafdda99b62e`.
- Changed file in fix commit: [Worktree Harness Result Contract](../WORKTREE_HARNESS_RESULT_CONTRACT.md).

## Scope

This lesson captures reusable review-fix guidance from PR #35.

It is docs-only post-merge lesson capture. It does not implement a harness, create or delete worktrees, mutate branches, perform cleanup, run Codex workers, modify the sandbox repository, or change any GitHub settings.

## Problem

PR #35 review found two result-contract consistency issues:

- A stopped example used `status: owner_decision_required` while also reporting `stop_state.code: STOPPED_OWNER_DECISION_REQUIRED`. The fix changed the example to `status: stopped`.
- The required top-level field list omitted `status` even though the status model, stop/report rules, and examples all depended on it. The fix added `status` to the required top-level fields.

The first finding overlaps existing stop-state and stopped-example lessons. The second finding adds a durable check for result contracts: required field lists must include every field that normative text and examples rely on.

## Cause

The first draft checked the conceptual content of the result contract but did not fully compare three contract surfaces against each other:

- The required top-level field list.
- The normative status and stop/report rules.
- The example result shapes.

That allowed the examples and rules to rely on `status` while the required field list omitted it, and allowed one stopped example to use a non-stopped top-level status while emitting a registry-backed stop code.

## Solution

When a docs-only result, evidence, guard, validation, status, or harness contract defines a required result shape, the declared required fields, normative rules, and examples must agree.

Future contract authors should check both directions:

- Every example should use field names and statuses that are declared by the contract.
- Every field that normative text or examples require, such as `status`, should appear in the required field list or result shape.

For stopped or owner-gated examples, an active `STOPPED_*` code means the top-level result status should be `stopped` unless the document explicitly describes a non-stop owner-decision status that does not emit a stop-state code.

## Prevention

Before committing result-contract or evidence-contract docs, self-review should check:

- Does the required top-level field list include every field used by normative text and examples?
- Does every example use only declared fields, unless clearly marked as illustrative and intentionally partial?
- If an example includes a registry-backed `STOPPED_*` code, does top-level `status` equal `stopped`?
- Are `status`, `stop_state.code`, `stop_state.reason`, interrupted lifecycle state, owner gate, cleanup state, and `recommended_next_action` aligned?
- Are owner-gated non-stop statuses kept distinct from stopped statuses?
- Are safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates?
- Were relevant existing lessons consulted before planning and before commit?

## When Future PRs Must Apply This

Apply this lesson when adding or changing:

- Result contracts.
- Evidence packet contracts.
- Validation result contracts.
- Factory status contracts.
- PR metadata guard result shapes.
- Allowed-files guard result shapes.
- Worktree harness result examples.
- Any examples that include `status`, `stop_state`, lifecycle/interrupted state, cleanup, owner gates, or `recommended_next_action`.

## Related Docs And Policy Surfaces

- [Worktree Harness Result Contract](../WORKTREE_HARNESS_RESULT_CONTRACT.md).
- [Worktree Harness MVP Boundary](../WORKTREE_HARNESS_MVP_BOUNDARY.md).
- [Task Lifecycle State Model](../TASK_LIFECYCLE.md).
- [Stop-State Registry](../STOP_STATE_REGISTRY.md).
- [Task Validation Result Contract](../TASK_VALIDATION_RESULT.md).
- [Factory Status Result Contract](../FACTORY_STATUS_RESULT.md).
- [PR Metadata Guard Contract](../PR_METADATA_GUARD.md).
- [Allowed-Files Guard Result Contract](../ALLOWED_FILES_GUARD.md).
- [Allowed-Files Review Lessons](workflow/allowed-files-review-lessons.md).
- [Sandbox Evidence Review Lessons](workflow/sandbox-evidence-review-lessons.md).
- [Stop-State Consistency](workflow/stop-state-consistency.md).

## Non-Goals

This lesson does not implement:

- Worktree harness behavior.
- CLI behavior.
- Codex worker execution.
- Worktree creation, deletion, pruning, or modification.
- Branch deletion or cleanup automation.
- GitHub write automation or PR publisher behavior.
- GitHub Actions workflows.
- Sandbox repository changes.
- Source code, scripts, executable schemas, or dependency manifests.
- Credentials, secrets, tokens, API keys, trading code, live trading logic, risk cap logic, model promotion logic, or Discord/Slack integration.

## Evidence Classification

### Authenticated/Tool-Reported

- PR #35 was reported by GitHub CLI as `MERGED`.
- PR #35 review threads were fetched with GitHub GraphQL and showed two resolved review threads.
- PR #35 commits were reported by GitHub CLI, including the initial commit and review-fix commit.
- PR #35 merge commit was reported by GitHub CLI.
- The PR #35 remote branch was not returned by read-only remote head lookup.
- The open PR list for `ckrhehfl/codex-dev-factory` was empty before this branch was created.

### Local-Verified

- Repository root and remote URL were verified before editing.
- Local `main` was fast-forward current before branch creation.
- Working tree was clean before editing.
- [Worktree Harness Result Contract](../WORKTREE_HARNESS_RESULT_CONTRACT.md) exists on latest `main`.
- The PR #35 review-fix commit diff was inspected locally with `git show`.
- Existing `docs/solutions/**` lessons and relevant policy docs were inspected before this lesson was written.

### Public/Web-Verified

- No public web browsing was needed for this lesson PR. Authenticated GitHub and local repository checks were sufficient.

### User-Reported

- The owner reported PR #35 was reviewed, review-fixed, merged, and cleaned up locally.

### 확인 필요

- GitHub settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets were not needed for this lesson and remain unchecked.
- Local cleanup details are not recorded as durable source-of-truth here beyond the current run's clean `main` state.
- Whether future result contracts will use executable schemas remains an owner decision for a separate task.

## Validation Performed

This lesson PR should run docs-safe validation before commit:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Hidden or bidirectional Unicode scan on edited Markdown.
- Allowed-files check.
- Forbidden-files/actions check.
- Relative link check.
- `STOPPED_*` registry check for referenced codes.

## Related PRs

- PR #35: [Docs: define worktree harness result contract](https://github.com/ckrhehfl/codex-dev-factory/pull/35).
- PR #36: [Docs: capture PR 35 worktree result review lessons](https://github.com/ckrhehfl/codex-dev-factory/pull/36).

## Follow-Up Status

Captured in this docs-only lesson PR after PR #35 merged.
