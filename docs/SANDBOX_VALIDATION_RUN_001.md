# Sandbox Validation Run 001 Evidence

## Summary

This document records the first sandbox docs-only PR validation evidence for sandbox PR #1, [Docs: validate sandbox docs-only PR flow](https://github.com/ckrhehfl/codex-dev-factory-sandbox/pull/1).

Result: `passed_with_recorded_unknowns`.

Sandbox PR #1 validated that the sandbox repository can support an owner-approved docs-only branch, a single allowed documentation change, PR metadata/evidence capture, merge verification, and safe boundary reporting without workflows, source code, credentials, trading content, or automation scope creep.

This is a control-plane evidence record. This PR does not modify the sandbox repository, create another sandbox PR, run additional sandbox validation, merge any PR, clean up branches, or implement automation.

## Scope

Target repository for this evidence PR:

- Control-plane repository: `ckrhehfl/codex-dev-factory`.
- Allowed control-plane files for this task:
  - `docs/SANDBOX_VALIDATION_RUN_001.md`.
  - `README.md` for a narrow discoverability link.
  - `docs/ROADMAP.md` for a narrow sequencing/status note.
- Sandbox repository observed read-only: `ckrhehfl/codex-dev-factory-sandbox`.

Explicit non-goals:

- Do not modify `ckrhehfl/codex-dev-factory-sandbox`.
- Do not create another sandbox PR.
- Do not run additional sandbox validation.
- Do not merge any PR.
- Do not clean up branches.
- Do not create or edit workflows.
- Do not add source code, dependency manifests, credentials, secrets, tokens, API keys, trading code, automation, PR publisher behavior, branch cleanup automation, Discord integration, risk cap logic, or model promotion logic.
- Do not treat Deep Research or prior chat history as repository source of truth.

## Evidence Classification

### Public/Web-Verified

- Sandbox PR URL: `https://github.com/ckrhehfl/codex-dev-factory-sandbox/pull/1`.
- Sandbox repository URL: `https://github.com/ckrhehfl/codex-dev-factory-sandbox`.

Public views are useful for human inspection, but this evidence record relies on authenticated GitHub CLI output for PR merge state and changed files where available.

### Authenticated/Tool-Reported

Authenticated GitHub CLI checks during this evidence task reported:

- Control-plane open PR list: empty.
- Sandbox open PR list: empty.
- Sandbox PR #1:
  - Number: `1`.
  - Title: `Docs: validate sandbox docs-only PR flow`.
  - URL: `https://github.com/ckrhehfl/codex-dev-factory-sandbox/pull/1`.
  - State: `MERGED`.
  - Base branch: `main`.
  - Head branch: `docs/validation-fixture-smoke-test`.
  - Head commit: `c4a90b52465957358d621214b9f29980f670bd86`.
  - Merge commit: `5c5bc7ef2945ca0a8024e98d5dd75422b25b5e70`.
  - Merged at: `2026-05-25T14:41:18Z`.
  - Changed file: `docs/VALIDATION_FIXTURE.md`.
- Remote branch check for `docs/validation-fixture-smoke-test`: no remote head was returned by `git ls-remote --heads`, consistent with remote branch deletion.

### Local-Verified

Control-plane local verification during this evidence task:

- Repository root was verified with `git rev-parse --show-toplevel`.
- Remote was verified with `git remote -v` as `https://github.com/ckrhehfl/codex-dev-factory.git`.
- Current branch before edits was `main`.
- Working tree was clean before edits.
- `git fetch --prune origin` completed.
- `git pull --ff-only origin main` reported `Already up to date`.
- Baseline control-plane HEAD before this evidence branch was `359e074b256927674de8481b023d3dcc6cc64510`.
- Evidence branch created: `docs/sandbox-validation-run-evidence`.

Sandbox local verification was read-only:

- Sandbox repository root was verified with `git rev-parse --show-toplevel`.
- Sandbox remote was verified with `git remote -v` as `https://github.com/ckrhehfl/codex-dev-factory-sandbox.git`.
- Sandbox current branch: `main`.
- Sandbox working tree: clean.
- Sandbox local HEAD: `5c5bc7ef2945ca0a8024e98d5dd75422b25b5e70`.
- Sandbox local branch `docs/validation-fixture-smoke-test`: absent.
- Sandbox worktree list contained the main worktree on `main`.

Local paths are environment-specific run evidence. Future tasks should revalidate paths rather than treating them as durable source of truth.

### User-Reported

The task prompt reported:

- Sandbox PR #1 local cleanup was completed.
- The sandbox PR #1 changed file was `docs/VALIDATION_FIXTURE.md`.
- A public PR-list inconsistency had been observed earlier.

The changed file, merged state, remote branch deletion, and local sandbox cleanup state were revalidated in this run where safely possible. Prior public PR-list inconsistency was not reproduced through authenticated open PR checks; if a public UI inconsistency appears again, direct PR view or authenticated PR/API output should be treated as stronger evidence.

### 확인 필요

- Whether any public-only PR-list inconsistency still reproduces in a browser UI was not separately rechecked because authenticated `gh` output showed no open sandbox PRs and direct PR #1 metadata showed `MERGED`.
- Sandbox repository settings not needed for this evidence record, including branch protection and required checks, should be revalidated before future automation or policy relies on them.
- Tool and plugin versions were not recorded for this run.
- Deep Research intake and traceability remain separate follow-up work if the owner requests them.

## Sandbox PR #1 Validation Evidence

| Field | Evidence category | Value |
| --- | --- | --- |
| Sandbox repository | Authenticated/tool-reported | `ckrhehfl/codex-dev-factory-sandbox` |
| PR number | Authenticated/tool-reported | `#1` |
| PR title | Authenticated/tool-reported | `Docs: validate sandbox docs-only PR flow` |
| PR URL | Authenticated/tool-reported and public/web-verifiable | `https://github.com/ckrhehfl/codex-dev-factory-sandbox/pull/1` |
| Base branch | Authenticated/tool-reported | `main` |
| PR branch | Authenticated/tool-reported | `docs/validation-fixture-smoke-test` |
| Head commit | Authenticated/tool-reported | `c4a90b52465957358d621214b9f29980f670bd86` |
| Merge commit | Authenticated/tool-reported and local-verified in sandbox clone | `5c5bc7ef2945ca0a8024e98d5dd75422b25b5e70` |
| Merge state | Authenticated/tool-reported | `MERGED` |
| Merged at | Authenticated/tool-reported | `2026-05-25T14:41:18Z` |
| Changed files | Authenticated/tool-reported | `docs/VALIDATION_FIXTURE.md` |
| Sandbox local cleanup | Local-verified | local PR branch absent; sandbox worktree clean on `main` |
| Remote branch cleanup | Authenticated/tool-reported/read-only remote query | remote head not returned by `git ls-remote --heads` |

Sandbox PR #1 body reported these validation checks:

- `git status --short --branch` confirmed branch `docs/validation-fixture-smoke-test` with one modified file before commit.
- `git diff --name-only` showed only `docs/VALIDATION_FIXTURE.md`.
- `git diff --check` passed.
- Hidden/bidirectional Unicode scan on `docs/VALIDATION_FIXTURE.md` passed.
- Workflow/source/dependency-file check passed.
- Forbidden content scan found only existing boundary text in the fixture document, not the new bullet.
- Staged diff check showed only `docs/VALIDATION_FIXTURE.md`.
- Commit created: `c4a90b5`.
- Branch pushed to `origin/docs/validation-fixture-smoke-test`.

Those checks are PR-body evidence from sandbox PR #1. The current evidence task independently revalidated the PR state, changed file list, merge state, sandbox local branch absence, and sandbox worktree cleanliness.

## Boundary Confirmations

Evidence supports these confirmations:

- Sandbox PR #1 was docs-only: authenticated PR file list showed only `docs/VALIDATION_FIXTURE.md`.
- Sandbox PR #1 did not edit the control-plane repo: authenticated PR metadata belongs to `ckrhehfl/codex-dev-factory-sandbox`, and control-plane edits for this task are limited to this evidence PR.
- No workflows were added by sandbox PR #1: authenticated changed-file list contained no `.github/workflows/**` path, and the PR body confirmed no workflows were created or edited.
- No source code was added by sandbox PR #1: authenticated changed-file list contained only a Markdown fixture file.
- No dependency manifest was added by sandbox PR #1: authenticated changed-file list contained only a Markdown fixture file.
- No credentials, secrets, tokens, or API keys were added by sandbox PR #1: authenticated changed-file list contained only a Markdown fixture file, and the PR body confirmed this boundary.
- No trading code or trading repo connection was added by sandbox PR #1: authenticated changed-file list contained only a Markdown fixture file, and the PR body confirmed this boundary.
- No automation, PR publisher behavior, branch cleanup automation, Discord integration, risk cap logic, or model promotion logic was added by sandbox PR #1: authenticated changed-file list contained only a Markdown fixture file, and the PR body confirmed these boundaries.
- No additional sandbox validation was run by this control-plane evidence PR.
- The sandbox repository was not modified by this control-plane evidence PR.

## Squash-Merge Cleanup Note

Sandbox PR #1 was merged with a merge commit reported as `5c5bc7ef2945ca0a8024e98d5dd75422b25b5e70`. Because the sandbox repository is configured for squash merge, local cleanup checks can encounter a normal ancestry mismatch:

- The original PR branch commit, such as `c4a90b52465957358d621214b9f29980f670bd86`, may not be an ancestor of updated `main` after squash merge.
- `git merge-base --is-ancestor <branch> main` may fail even when GitHub reports the PR as merged.
- `git branch -d <branch>` may refuse deletion because local Git does not see the original branch tip as merged into `main`.

This should not be misclassified as repository corruption by default. It is expected cleanup friction after squash merge.

Force deletion remains forbidden by default under the current cleanup policy. Controlled `git branch -D` should be considered only if repository policy is updated or the owner explicitly authorizes a verified squash-merged cleanup exception after all safety checks pass.

This evidence PR does not perform cleanup. It records that sandbox local cleanup state was revalidated read-only: the local PR branch was absent and the sandbox worktree was clean on `main`.

## Conflicting Or Ambiguous Evidence

- A prior public PR-list inconsistency was user-reported. This run did not reproduce an open-PR conflict through authenticated GitHub CLI: sandbox open PR list was empty, and direct authenticated PR #1 view reported `MERGED`.
- Direct PR view or authenticated API/CLI output should be treated as stronger evidence than a stale or inconsistent public PR list UI.
- Hidden/bidirectional Unicode warnings from assistant or web rendering are not evidence by themselves. This task treats hidden Unicode as an issue only if a local scan of edited Markdown files finds suspicious control characters.

## Remaining 확인 필요

- Browser-level public PR-list inconsistency reproduction: not checked in this run.
- Sandbox branch protection and required checks: not needed for this evidence record; revalidate before future automation or policy decisions.
- Tool/plugin versions used for the original sandbox PR #1 run: not recorded in this evidence task.
- Deep Research intake and traceability: not part of this evidence PR.
- Future sandbox validation beyond PR #1: requires separate owner approval.

## Validation Performed For This Evidence PR

This evidence task used portable verification commands and authenticated GitHub CLI checks:

- `git rev-parse --show-toplevel` to verify the control-plane repository root.
- `git remote -v` to verify the control-plane remote.
- `git status --short --branch` to verify the control-plane branch and clean worktree before edits.
- `git fetch --prune origin` to update remote tracking state.
- `git pull --ff-only origin main` to verify latest `main`.
- `git rev-parse HEAD` to record the control-plane baseline HEAD.
- `gh pr list --repo ckrhehfl/codex-dev-factory --state open --json number,title,headRefName,url` to verify no open control-plane PRs.
- `gh pr view 1 --repo ckrhehfl/codex-dev-factory-sandbox --json state,title,number,headRefName,headRefOid,baseRefName,mergeCommit,mergedAt,files,url,body` to verify sandbox PR #1 metadata.
- `gh pr list --repo ckrhehfl/codex-dev-factory-sandbox --state open --json number,title,headRefName,url` to verify no open sandbox PRs.
- `git ls-remote --heads origin docs/validation-fixture-smoke-test` in the sandbox clone to check remote branch presence without modifying the sandbox repository.
- `git rev-parse --show-toplevel`, `git remote -v`, `git branch --show-current`, `git status --short --branch`, `git branch --list docs/validation-fixture-smoke-test`, `git worktree list`, and `git rev-parse HEAD` in the sandbox clone for read-only local cleanup evidence.

Self-review for this control-plane evidence PR checks:

- `git diff --check`.
- Hidden/bidirectional Unicode scan on edited Markdown files.
- Allowed-files check for this control-plane evidence PR.
- Stop-state registry check for referenced `STOPPED_*` codes, if any.
- Self-review against docs-only, no-sandbox-modification, no-workflow, no-code, no-secrets, no-trading, no-automation, and no-cleanup boundaries.

## Solution Lookup Result

Applicable solution entries were found and applied:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): solution lookup happened before planning/editing; cleanup and evidence states are kept separate.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): this PR body must preserve distinct Self-review result and Confirmations sections.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): changed files are checked against the task's allowed files and no out-of-scope control-plane files are edited.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): evidence uses the sandbox validation evidence contract shape and separates lifecycle, PR, merge, cleanup, guard, and unknown state.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): this evidence record avoids treating exact local paths as durable reusable source of truth and separates local-verified, authenticated/tool-reported, public/web-verified, user-reported, and `확인 필요` facts.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): no new stop code is introduced; any referenced `STOPPED_*` code must remain registry-backed.

No applicable solution conflicted with this docs-only evidence-recording scope.

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

Dropping these fields remains a stop condition for future validation, evidence, status, metadata, or handoff work.

## Recommended Next Action

After this evidence PR is reviewed and merged, the next narrow action should be either:

- Continue with Deep Research intake and traceability as a separate docs-only task, if the owner wants to evaluate research recommendations; or
- Run another owner-approved sandbox validation loop, if the owner wants more sandbox evidence.

Do not infer implementation readiness from this evidence record alone.
