# Codex Fixed Loop Contracts

## Purpose

These are the fixed PM/Codex loop contracts for:

- Review-fix work on an existing pull request.
- Owner-authorized branch cleanup after a merged pull request.
- Compound post-merge triage after review-fix or nontrivial review activity.

The contracts reduce chat and handoff dependence by making discovery, gates, allowed actions, stop conditions, and output packets explicit. They do not remove repo or task revalidation, and they do not override owner gates, current task scope, repository policy, or GitHub state.

## Shared gates for every loop

Use this gate before normal progression in any loop:

```text
launch_alias:
  read_only_status_checks: cdfcheck
  normal_bounded_work_after_readiness: cdfcodex
codex_intelligence: medium/default
preflight: bash scripts/checks/codex-task-preflight.sh
stop_condition: none
```

Required shared rules:

- Use `cdfcheck` for read-only/status checks.
- Use `cdfcodex` for normal bounded work after readiness passes.
- Codex Intelligence must be `medium/default`.
- If high/xhigh appears needed, stop and request owner approval before continuing.
- Run `bash scripts/checks/codex-task-preflight.sh` before normal bounded work when available.
- When a loop intentionally starts from the current PR branch, treat a clean `branch_not_main` preflight halt as an expected feature-branch readiness signal, not as a review-fix or PR-validation failure.
- Treat any `stop_condition` other than `none` or a documented expected exception as blocking normal progression.
- PR merge remains owner-gated/manual.
- Branch cleanup remains owner-gated/manual unless separately authorized for a specific branch cleanup task.
- Do not use API keys, GitHub secrets, GitHub settings changes, auto-merge, Full Access or `danger-full-access` changes, `--yolo`, Zeroshot install/run/adoption, Hermes, sandbox/runtime changes, docs folderization, or mutating OMX commands without a separate owner gate.
- Do not inspect credential contents.

## Review-fix loop contract

Purpose: fix actionable PR review comments only.

Input discovery:

- Identify the current PR from the current branch.
- The user should not need to paste a PR number or URL when local and GitHub state can identify the PR unambiguously.

Required inspection:

- PR metadata.
- Unresolved review threads/comments.
- Existing commits since branch point.
- Local status.

Classification labels:

- `IN_SCOPE_FIX`: actionable, safe, and inside the current PR/task scope.
- `OUT_OF_SCOPE`: valid concern but outside the approved scope.
- `OWNER_DECISION_REQUIRED`: requires owner judgment, policy choice, merge/cleanup authority, or new approval.
- `ALREADY_RESOLVED`: comment is already addressed by existing code/docs or prior commits.
- `UNSAFE_OR_AMBIGUOUS`: unclear, potentially unsafe, credential-related, settings-related, or not verifiable enough to change.

Allowed actions:

- Make scoped file edits only for `IN_SCOPE_FIX`.
- Run local validation relevant to the scoped fix.
- Commit and push scoped fixes.
- Reply to review threads only when the fix is directly verified.
- Resolve threads only when safe and supported by the available tooling.

Forbidden actions:

- Merge the PR.
- Force push.
- Delete branches.
- Broad refactor.
- Unrelated edits.
- Inspect credentials.
- Change GitHub settings or secrets.

Stop conditions:

- Review request is unclear.
- Review item is out of scope.
- Review item requires owner decision.
- Fix requires high/xhigh intelligence.
- Fix requires secret, API key, or GitHub settings access.
- Validation failure is not caused by the scoped fix.

Output packet:

```text
review_fix_result:
  pr_identified:
  comments_inspected:
  classifications:
  files_changed:
  validation_results:
  commits_pushed:
  unresolved_owner_decisions:
  stop_condition:
```

## Branch-cleanup loop contract

Purpose: clean exactly one already-merged PR branch after owner authorization.

Input discovery:

- Identify the current just-merged PR branch when possible.
- The user should not need to paste a PR number or URL when local and GitHub state can identify the branch and merged PR unambiguously.

Required inspection:

- Clean worktree.
- Current branch.
- Default branch.
- PR merged state.
- Local branch list.
- Remote branch list.
- Whether the branch is protected, open, unmerged, or ambiguous.

Allowed actions:

- `fetch --prune`.
- Switch to `main`.
- `pull --ff-only`.
- Delete exactly one safe local merged branch with non-force delete.
- Report remote branch already gone if GitHub or the owner already cleaned it.

Forbidden actions:

- Force delete; stop and report when cleanup would require force deletion.
- Delete `main`, the default branch, or protected branches.
- Delete open or unmerged branches.
- Delete multiple branches.
- Merge, rebase, or edit files.
- Treat branch cleanup as standing automation.

Stop conditions:

- Dirty worktree.
- Ambiguous branch.
- Branch is not merged.
- Branch is protected or default.
- Remote/local mismatch.
- Owner authorization is missing.

Output packet:

```text
branch_cleanup_result:
  pr_or_branch_identified:
  merge_verification:
  branches_deleted_or_skipped:
  final_branch:
  final_status:
  stop_condition:
```

## Compound post-merge triage loop contract

Purpose: after a merged PR, inspect review-fix drift and decide whether a narrow follow-up PR is needed.

Input discovery:

- Identify the latest merged PR from the current repo/main state.
- The user should not need to paste a PR number or URL when local and GitHub state can identify the latest merged PR unambiguously.

Required inspection:

- Latest merged PR metadata.
- Changed files.
- Review comments/threads.
- Review-fix commits.
- Final validation evidence.
- Current `main` state.

Decision outcomes:

- `NO_FOLLOWUP_NEEDED`: no concrete narrow issue needs a follow-up PR.
- `PREPARE_FOLLOWUP_PR`: a concrete narrow issue exists and can be fixed inside current gates.
- `OWNER_DECISION_REQUIRED`: a decision, authority, or new scope approval is required.
- `STOPPED_VALIDATION_FAILED`: required validation failed and the failure blocks a safe decision.

Follow-up PR is allowed only when:

- A concrete narrow issue exists.
- The issue is caused by the latest merged PR or its review-fix drift.
- The fix is safe, scoped, and does not require new owner gates.

Forbidden inside Compound:

- Fixing broad repo policy, configuration, GitHub settings, workflow permission, or EOL normalization unless that exact small follow-up was separately authorized.
- Merge.
- Branch cleanup.
- Unrelated refactors.
- Docs folderization unless separately authorized.
- Secrets, API keys, or settings work.

Stop for owner decision if follow-up requires:

- New repo policy.
- Configuration file changes.
- GitHub setting, ruleset, or permission changes.
- Workflow permission changes.
- Broad EOL normalization.
- Broad environmental change.
- High/xhigh intelligence.
- Zeroshot, Hermes, sandbox, or runtime adoption.

Output packet:

```text
compound_triage_result:
  latest_merged_pr:
  files_reviews_commits_inspected:
  decision_outcome:
  follow_up_branch_or_pr:
  validation_results:
  owner_decisions:
  stop_condition:
```

## Evidence classes

Use these labels when reporting loop evidence:

- `local-verified`: the active worker reran the local command or inspected the local artifact in the current task.
- `authenticated/tool-reported`: authenticated tooling or an integrated connector reported the state.
- `public/web-verified`: public web state was checked without authenticated authority.
- `user-reported`: the owner or another user supplied the evidence.
- `확인 필요`: evidence is missing, stale, ambiguous, or not rerun by the active worker.

Owner-pasted terminal output is `user-reported` unless the active worker reruns it in the current task.

## Current default recommendation

- Use review-fix only when actual review comments exist.
- Use Compound after review-fix or nontrivial review comments.
- Skip Compound when there were no actionable review comments and no review-fix commits.
- Branch cleanup remains owner-gated/manual after merge.
- Use `codex-task-preflight` as the default first local gate.
