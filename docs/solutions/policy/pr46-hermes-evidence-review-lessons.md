# PR 46 Hermes Evidence Review Lessons

## Problem

PR #46 introduced [Hermes Evaluation Evidence Template](../../HERMES_EVALUATION_EVIDENCE_TEMPLATE.md), then review found that several copyable evidence packet fields were overloaded or inconsistent with existing repo vocabulary.

The review-fix loop corrected examples that would otherwise let future evidence packets appear complete while losing audit-critical distinctions, especially:

- Packet outcome used `not_run` where the packet-level status only allowed `pass`, `fail`, `stopped`, or `inconclusive`.
- Deep Research evidence used an ad-hoc `Deep Research/input-derived` label instead of the existing `Deep Research input` evidence class.
- GitHub authority, sandbox boundary, and worktree/branch sections used a single generic `Result` field where future packets needed separate observed state and approval state.
- Stopped outcomes used `stop_code`, `stop_reason`, and generic interrupted lifecycle wording instead of `stop_state.code`, `stop_state.reason`, and `lifecycle_trace`.
- The copyable packet skeleton omitted `base_branch`, `approval_source`, and `approval_evidence_class`, even though related acceptance criteria and approval gates need those fields for audit.

## Cause

The first template draft treated several evidence-table cells as human-readable placeholders rather than contract-like fields future packets would copy.

That made the template easy to read but too easy to misuse:

- A value like `not_approved` could mean "not touched", "not attempted", or "not approved".
- A generic `Result` column could hide whether an unsafe action occurred without approval.
- Locally sensible labels could drift from canonical repo terms used by acceptance criteria, status summaries, and evidence contracts.
- Required audit fields could be present in prose but absent from the copyable skeleton.

## Solution

When creating evaluation evidence templates, separate the axes future reviewers need to audit.

Use distinct fields for:

- Observed, touched, attempted, or runtime state.
- Approval state.
- Evidence class.

Use canonical repo vocabulary rather than local variants:

- Use `Deep Research input` for Deep Research-derived source input.
- Use packet-level outcomes such as `pass`, `fail`, `stopped`, and `inconclusive` consistently.
- Use `stop_state.code`, `stop_state.reason`, and `lifecycle_trace` for stopped evidence.

Preserve audit fields in the copyable skeleton, not only in surrounding prose. For Hermes evaluation evidence, PR #46 showed that `base_branch`, `approval_source`, and `approval_evidence_class` need to be present where future evaluators will copy the packet shape.

## Prevention

Before committing a docs-only evidence template, self-review should check:

- Does each table distinguish observed state from approval state when both are relevant?
- Does every approval gate include approval source and evidence class when future audit depends on it?
- Does the copyable skeleton include every field required by acceptance criteria, result contracts, or surrounding prose?
- Do evidence classes match existing repo vocabulary exactly?
- Do outcome fields use valid packet-level status values?
- Do stopped examples use canonical stop-state and lifecycle fields?
- Could a future unapproved touch, attempted mutation, cleanup, branch deletion, sandbox mutation, credential action, or GitHub authority action be hidden by a generic `Result` value?

If any answer is unclear, revise the template before commit or stop/report if the fix would require broader policy changes.

## Related PRs

- PR #46: [Docs: define Hermes evaluation evidence template](https://github.com/ckrhehfl/codex-dev-factory/pull/46).
- Initial commit: `d8e7191d4a345fe2928b5ae623610734d9a3a088` (`Docs: define Hermes evaluation evidence template`).
- Review-fix commits:
  - `3f15a9c4621acd15c4a482c799f98e25ca003423` (`Docs: address review comments`).
  - `15ca874115404e54f0dbfda7be36777c81593871` (`Docs: address review comments`).
  - `f4685660f3f1ea2c19caf73ba863c8c4562990b3` (`Docs: address review comments`).
  - `8febc3aae58a63232ee5d509e805ec028295db9c` (`Docs: address review comments`).
  - `9b65c8227f5f1208830a4775ab8f8beaf9562e14` (`Docs: address review comments`).
  - `5c4af77f1540c5504558eb6a9c25264b977ffa0d` (`Docs: address review comments`).
  - `a84edbbd4c9c3d24d788b94c77e902c21a175e88` (`Docs: address review comments`).
- Merge commit: `cf29b7a2fbb4fd703f2e166d40e5724dabe7696c`.

## Follow-Up Status

Captured after PR #46 merged.

No implementation follow-up is approved by this lesson. Future Hermes installation, execution, configuration, Codex runtime connection, sandbox mutation, publisher authority, cleanup authority, branch deletion authority, auto-merge eligibility, Docker/VPS/Continue/MCP setup, credentials, and trading boundary changes remain owner-gated.

## Evidence Classification

### Authenticated/Tool-Reported

- PR #46 was reported by GitHub CLI as `MERGED`.
- PR #46 review threads were fetched with GitHub GraphQL and showed eight resolved review threads.
- PR #46 commits were reported by GitHub CLI, including the initial commit, seven review-fix commits, and merge commit.
- The open PR list for `ckrhehfl/codex-dev-factory` was empty before this branch was created.

### Local-Verified

- Repository root and remote URL were verified before editing.
- Local `main` was fast-forward current before branch creation.
- Working tree was clean before editing.
- The PR #46 review-fix diffs were inspected locally with `git diff d8e7191 a84edbb -- docs/HERMES_EVALUATION_EVIDENCE_TEMPLATE.md`.
- Existing `docs/solutions/**` lessons were inspected to avoid duplicating an existing lesson.

### Public/Web-Verified

- No public web browsing was needed for this lesson. Authenticated GitHub and local repository checks were sufficient.

### User-Reported

- The owner reported PR #46 was review-fixed, merged, and local branch/worktree cleanup was completed.

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
