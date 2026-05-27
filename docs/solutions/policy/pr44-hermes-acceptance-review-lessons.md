# PR 44 Hermes Acceptance Review Lessons

## Problem

PR #44 introduced [Hermes Evaluation Acceptance Criteria](../../HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md), then review found that the Stop Conditions section was too absolute.

The initial text said to stop whenever a task using the criteria required Hermes installation, Hermes execution, Hermes configuration, Codex runtime connection, sandbox changes, or related runtime actions. That wording conflicted with the same document's plan for a future separately owner-approved sandbox evaluation task, because a real evaluation would necessarily require some of those actions after approval.

## Cause

The first draft correctly protected owner-gated actions, but it did not distinguish:

- A forbidden or unapproved request in the current docs-only task.
- A future task that has explicit owner approval and a bounded approved scope.

Because the stop language was unconditional, it could force a legitimate future owner-approved Hermes evaluation to report `stopped` instead of producing `pass`, `fail`, or `inconclusive` evidence.

## Solution

When acceptance criteria or evaluation-policy docs list owner-gated runtime actions as stop conditions, qualify those stop conditions by approval and scope.

Use stop language such as:

- Stop when the action lacks explicit owner approval.
- Stop when the action is outside the approved scope.
- Stop when the approval boundary is ambiguous.

Do not weaken the owner gate. The fix is to make the gate precise: owner-approved evaluation tasks may proceed within their approved scope, while unapproved or out-of-scope runtime, sandbox, GitHub authority, cleanup, credential, or trading actions still stop.

In PR #44, the review-fix commit changed the Stop Conditions lead-in to apply when required actions are "without explicit owner approval or outside the approved scope" and added approval-boundary ambiguity to the stop list.

## Prevention

Before committing acceptance criteria, evaluation plans, runtime boundaries, worker boundaries, sandbox runbooks, or authority-gate docs, self-review should check:

- Does each stop condition distinguish unapproved requests from separately owner-approved future tasks?
- Does the document preserve existing owner gates without making the intended future evaluation impossible?
- Does the text say what happens when approval exists but the requested action exceeds the approved scope?
- Does ambiguity about the approval boundary stop/report?
- Are `pass`, `fail`, `stopped`, and `inconclusive` outcomes still usable for the future evaluation the document is meant to enable?
- Are stop-state, owner-gate, evidence-classification, source-of-truth, sandbox, GitHub authority, cleanup, credential, and trading boundaries preserved?
- Does the PR avoid introducing new stop codes, authority grants, adoption claims, or implementation scope unless every related policy surface is updated in the same approved task?

## Related PRs

- PR #44: [Docs: define Hermes evaluation acceptance criteria](https://github.com/ckrhehfl/codex-dev-factory/pull/44).
- Initial commit: `fcaf7adb43fd3acc1c3f01001d7027ac8fefcb24` (`Docs: define Hermes evaluation acceptance criteria`).
- Review-fix commit: `977d00c16e0212fe8b78fd1a0f7740d3d2a1da29` (`Docs: address review comments`).
- Merge commit: `af4a162ffee5d83a03b7f32e521d56178743f1b1`.

## Follow-Up Status

Captured after PR #44 merged.

No implementation follow-up is approved by this lesson. Future Hermes installation, execution, configuration, Codex runtime connection, sandbox mutation, publisher authority, cleanup authority, branch deletion authority, auto-merge eligibility, Docker/VPS/Continue/MCP setup, credentials, and trading boundary changes remain owner-gated.

## Evidence Classification

### Authenticated/Tool-Reported

- PR #44 was reported by GitHub CLI as `MERGED`.
- PR #44 review threads were fetched with GitHub GraphQL and showed one resolved review thread.
- PR #44 commits were reported by GitHub CLI, including the initial commit and review-fix commit.
- PR #44 merge commit was reported by GitHub CLI.
- The open PR list for `ckrhehfl/codex-dev-factory` was empty before this branch was created.

### Local-Verified

- Repository root and remote URL were verified before editing.
- Local `main` was fast-forward current before branch creation.
- Working tree was clean before editing.
- The PR #44 review-fix commit diff was inspected locally with `git diff fcaf7adb43fd3acc1c3f01001d7027ac8fefcb24 977d00c16e0212fe8b78fd1a0f7740d3d2a1da29 -- docs/HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md`.
- Existing `docs/solutions/**` lessons were inspected to avoid duplicating an existing lesson.

### Public/Web-Verified

- No public web browsing was needed for this lesson. Authenticated GitHub and local repository checks were sufficient.

### User-Reported

- The owner reported PR #44 was merged and local branch/worktree cleanup was completed.

### 확인 필요

- GitHub settings, branch protection, rulesets, required checks, auto-merge state, repository secrets, and permissions were not needed for this lesson and remain unchecked.
- Any future Hermes evaluation execution remains blocked until a separate owner-approved task defines and verifies that scope.

## Non-Goals

This lesson does not implement or approve:

- Hermes installation, execution, or configuration.
- Codex runtime connection or Codex worker execution.
- Sandbox repository modification.
- GitHub settings, rulesets, required checks, Actions, secrets, or permission changes.
- Publisher behavior or GitHub write automation.
- Cleanup automation, branch deletion automation, branch cleanup, or worktree mutation.
- Auto-merge enablement.
- Docker, VPS, Continue, MCP, or runtime setup.
- Credentials, secrets, tokens, API keys, or secret-like placeholders.
- Trading repository design, trading implementation, live trading, risk cap logic, exchange credential handling, or model promotion.
