# Task Lifecycle State Model

## Purpose

This document defines the standard Codex task lifecycle for normal PM/Codex work.

It connects `scripts/checks/codex-task-preflight.sh`, the fixed loop contracts, `repo-guard`, and owner gates so task, branch, PR, review, merge, cleanup, and post-merge lesson handling do not drift into incompatible lifecycle assumptions.

The runbook reduces prompt and handoff dependence by making normal progression explicit. It does not remove owner gates, GitHub settings boundaries, review requirements, merge authority, cleanup authority, or task-specific forbidden actions.

This model is a documentation contract only. It does not implement CLI enums, workflow automation, GitHub writes, branch cleanup automation, Discord integration, trading functionality, or runtime enforcement.

## Launch Aliases

Use these aliases for normal task execution:

- `cdfcheck`: read-only readiness, status, and inspection checks.
- `cdfcodex`: normal bounded Codex work after readiness passes.

Default Codex Intelligence is `medium/default`.

If high or xhigh intelligence appears necessary, stop and request owner approval before continuing.

Do not use Full Access, `danger-full-access`, `--yolo`, API keys, GitHub secrets, GitHub settings changes, auto-merge, branch cleanup automation, Zeroshot, Hermes, sandbox/runtime changes, docs folderization, or mutating OMX commands without a separate owner gate.

## Preflight-First Start

Normal tasks start from `main`.

Run:

```bash
bash scripts/checks/codex-task-preflight.sh
```

A pass means local readiness is satisfied for normal bounded progression against the current local refs. It does not prove that cached remote refs are current with GitHub.

`stop_condition: none` is non-blocking.

A non-`none` stop condition blocks normal branch, edit, commit, push, and PR progression unless a documented loop-specific exception applies.

`branch_not_main` can be expected only during feature-branch PR validation or loops intentionally operating on a current PR branch. It is not a normal starting state for new tasks from `main`.

The helper is read-only. It does not fetch or prune remote refs, and it does not verify GitHub branch protection, rulesets, permissions, or other GitHub settings. GitHub settings remain owner-gated and manual.

## Normal Bounded Task Lifecycle

The normal PM/Codex sequence is:

1. PM defines a bounded task, allowed files, forbidden files/actions, validation expectations, owner gates, and stop conditions.
2. Codex revalidates local readiness with `bash scripts/checks/codex-task-preflight.sh`.
3. Codex refreshes remote refs when the task gate requires latest `main`, then verifies `main` is current enough for the task.
4. Codex creates a scoped branch only after readiness and required remote-refresh gates pass.
5. Codex edits only allowed files.
6. Codex runs local validation.
7. Codex commits scoped changes.
8. Codex pushes the branch.
9. Codex opens a PR when appropriate and authorized by the task contract.
10. PR merge remains owner-gated and manual.
11. Branch cleanup remains owner-gated and manual.
12. Compound is run only when appropriate under the fixed loop contract.

## PR Phase

PR body should include at minimum:

- Summary of the lifecycle or runbook update.
- Scope confirmation.
- Non-goals.
- Allowed files.
- Validation results.
- Stop conditions.
- Risk tier.
- Self-review result.
- Confirmations.
- Solution lookup result, including applicable lessons or `No applicable solution found.`.
- Owner gates.
- Forbidden-action confirmation.

Use the [Task Contract](TASK_CONTRACT.md) and [PR Metadata Guard](PR_METADATA_GUARD.md) as the canonical PR metadata contracts. This lifecycle checklist is a runbook reminder, not a replacement for the complete metadata contract.

The required status check `Repo guard` is expected to protect `main`, but exact GitHub settings are owner-reported or manual unless authenticated settings are directly queried.

Conversation resolution may block merge.

Do not auto-merge. Do not mark branch cleanup as automatic.

## Review-Fix Phase

Use the fixed review-fix loop contract in [Codex Fixed Loop Contracts](CODEX_FIXED_LOOP_CONTRACTS.md).

Review-fix is used when actionable review comments exist.

Mixed review batches should fix safe in-scope comments and leave out-of-scope or owner-decision comments unresolved for owner decision.

Review-fix must not merge, force push, delete branches, inspect secrets, or change GitHub settings.

After review-fix, rerun appropriate validation and push scoped commits.

## Owner Merge and Branch Cleanup Phase

The owner manually reviews and merges the PR.

Branch cleanup is owner-gated and manual.

The cleanup loop must never force-delete branches.

When authorized, the cleanup loop should clean exactly one safe already-merged branch.

There is no standing branch cleanup automation.

## Compound Phase

Use the fixed Compound contract in [Codex Fixed Loop Contracts](CODEX_FIXED_LOOP_CONTRACTS.md).

Run Compound after review-fix or nontrivial review comments.

Skip Compound when there were no actionable review comments and no review-fix commits.

Compound may create a follow-up PR only for a concrete narrow issue caused by the latest merged PR or its review-fix drift.

Stop for owner decision if a follow-up requires GitHub settings, workflow permissions, repo policy, broad EOL/config/environment changes, high/xhigh intelligence, Zeroshot/Hermes/sandbox/runtime adoption, or docs folderization.

## Evidence and Reporting

Use these evidence classes:

- `local-verified`: output from local commands run by the active worker.
- `authenticated/tool-reported`: GitHub connector, GitHub API, or other authenticated tool output.
- `public/web-verified`: public web or unauthenticated public UI evidence checked by the active worker.
- `user-reported`: owner-pasted terminal output or UI observations that the active worker did not rerun.
- `확인 필요`: not directly checked by the active worker or authenticated tooling.

Owner-pasted terminal output is `user-reported` unless the active worker reruns it.

GitHub connector/API output is `authenticated/tool-reported`.

Local command output from the active worker is `local-verified`.

GitHub settings are `확인 필요` unless directly queried or owner-reported from the UI.

## Stop Conditions

Hard stops include:

- Failed preflight from `main`.
- Dirty worktree.
- Ambiguous branch or PR.
- Required high/xhigh intelligence.
- Secret, API key, or GitHub settings need.
- GitHub auth setup need.
- Forbidden action needed.
- Validation failure outside the scoped fix.
- Owner decision needed.
- Broad docs folderization needed.

## Next Planned Docs Folderization

Docs folderization is intentionally deferred until this lifecycle/runbook and fixed contracts are stable.

Folderization requires a separate owner-authorized task.

Do not include a folderization plan or perform file moves in a lifecycle/runbook PR.

## Lifecycle Principles

Source-of-truth revalidation happens before task execution. Conversation memory, previous assistant answers, and handoff notes are not source of truth.

Low-risk docs-only PRs may commit, push, and create a PR after self-review without separate commit approval when the task contract explicitly allows that flow.

Merge remains separate unless explicitly requested.

The review-fix loop is used only when review comments exist.

Compound or post-merge lesson capture is skipped when there was no review and no durable lesson from another source.

Durable lessons are captured through a separate docs-only PR. Compound output is advisory until reviewed and merged into repository documentation.

Local cleanup is separate local state and must be verified locally.

Codex multi-agent architecture work follows the same lifecycle. Read-only agents may run in parallel only when the task contract allows independent analysis and evidence collection. Mutation workers remain sequential by default and require owner-approved branch/worktree ownership, allowed-file boundaries, validation, review, and reconciliation before commit, push, or PR creation. Parallel mutation requires a later owner-approved dispatcher and reconciliation boundary; this lifecycle does not authorize it by default.

## State Model

Each lifecycle state is defined by:

- State: the lifecycle name.
- Owner/source of authority: who or what authorizes the state.
- Entry condition: what must be true before the state is active.
- Allowed next states: where the task may move next.
- Required checks: checks that must happen in or before the state.
- Allowed actions: actions permitted in the state.
- Forbidden actions: actions that remain out of scope.
- Exit condition: what must be true to leave the state.
- Related docs: policy surfaces that govern the state.

| State | Owner/source of authority | Entry condition | Allowed next states | Required checks | Allowed actions | Forbidden actions | Exit condition | Related docs |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `INTENT_CAPTURED` | Owner request | Owner states intended work. | `TASK_DEFINED`, `STOPPED` | Identify source-of-truth assumptions and risk signals. | Ask clarifying questions only when required; summarize intent. | Treat prior conversation or external repos as source of truth. | Task can be bounded or must stop. | Task Contract, Operating Model |
| `TASK_DEFINED` | Task contract | Objective, scope, non-goals, allowed files, forbidden files/actions, validation plan, stop conditions, risk tier, and owner gates are known enough to proceed. | `LOCAL_REVALIDATION`, `STOPPED` | Verify required task fields and owner gates; run required solution lookup before planning. | Prepare bounded plan for docs-only work after applicable solution lessons are considered. | Start edits before revalidation when source-of-truth is unclear; defer required solution lookup until branch work. | Task is complete enough for local checks. | Task Contract, Local Task Format, Solution Lookup Protocol |
| `LOCAL_REVALIDATION` | Local repo and authenticated tooling when needed | Task is defined and local repo must be verified. | `READY_TO_BRANCH`, `STOPPED` | Verify path, remote, branch, working tree, recent log, fetch/prune, latest `main`, and clean state. | Run read-only local checks and required fetch/pull. | Branch from unclear or dirty state. | Local `main` is verified current enough for the task. | Operating Model, Risk Policy |
| `READY_TO_BRANCH` | Verified local repo state | Local source of truth is clear and clean. | `BRANCH_ACTIVE`, `STOPPED` | Confirm branch name and protected-branch boundary. | Create the task branch. | Delete branches or force push. | Task branch exists. | Operating Model, GitHub Operating Policy |
| `BRANCH_ACTIVE` | Task branch | Task branch is checked out. | `DOCS_EDITING`, `STOPPED` | Confirm branch is not protected; confirm required solution lookup was already run or refresh it if branch inspection reveals newly relevant lessons. | Inspect docs and narrow allowed files. | Merge, cleanup, implementation, or first-time required solution lookup after planning has already started. | Editing scope is known. | Solution Lookup Protocol, Task Contract |
| `DOCS_EDITING` | Task contract | Allowed docs are identified. | `SELF_REVIEW`, `STOPPED` | Keep changes inside allowed files and docs-only scope. | Add or update documentation. | Add code, workflows, scripts, automation, credentials, trading behavior, or out-of-scope files. | Diff is ready for review. | Acceptance Tests, Risk Policy |
| `SELF_REVIEW` | Task contract and local checks | Docs diff exists. | `PR_CREATED`, `STOPPED` | Check allowed files, forbidden actions, cross-document consistency, stop-state consistency, safety field preservation, hidden Unicode, and docs-safe validation. | Stage, commit, push, and create PR when explicitly allowed. | Commit if self-review fails; merge the PR. | Commit, push, and PR creation succeed, or stop condition is reported. | Task Contract, Acceptance Tests, Stop-State Registry |
| `PR_CREATED` | GitHub PR metadata | PR exists for the task branch. | `REVIEW_PENDING`, `MERGE_READY`, `STOPPED` | Verify PR URL and required metadata. | Report PR details. | Enable auto-merge, merge, or delete branches unless explicitly requested. | Review is pending or owner marks ready. | Task Contract, GitHub Operating Policy |
| `REVIEW_PENDING` | Owner/reviewer | PR awaits review or owner decision. | `REVIEW_FIX_REQUIRED`, `MERGE_READY`, `STOPPED` | Monitor only when requested; read comments if asked. | Summarize review state. | Apply unclassified review fixes or merge. | Review comments exist, or PR is approved/ready. | Operating Model |
| `REVIEW_FIX_REQUIRED` | Review comments and task contract | Unresolved review comments exist. | `REVIEW_PENDING`, `MERGE_READY`, `STOPPED` | Collect unresolved comments, classify them, fix only in-scope items, self-review, commit, push, and resolve threads only after verifying fixes. | Edit allowed files for in-scope fixes; reply to clarification-only comments. | Expand scope, fix forbidden requests, resolve threads before verification, force push, or merge. | In-scope fixes are pushed and threads handled, or owner decision is required. | Task Contract, Solution Lookup Protocol |
| `MERGE_READY` | Owner approval/review policy | PR is reviewed enough for the owner-approved merge path. | `MERGED`, `REVIEW_FIX_REQUIRED`, `STOPPED` | Confirm merge is explicitly requested or otherwise allowed by approved policy. | Wait for merge instruction or owner action. | Merge automatically from this docs-only task unless explicitly requested. | PR is merged or review changes require another loop. | GitHub Operating Policy |
| `MERGED` | GitHub merge state | GitHub confirms PR merge. | `LOCAL_CLEANUP_PENDING`, `LESSON_REVIEW`, `DONE`, `STOPPED` | Verify merged state before cleanup or lesson decisions. | Summarize merge state when asked. | Clean up before merge is confirmed. | Cleanup or lesson handling path is selected. | GitHub Operating Policy, Operating Model |
| `LOCAL_CLEANUP_PENDING` | Owner cleanup instruction and local git state | PR is merged and local cleanup is requested. | `LOCAL_CLEANUP_DONE`, `STOPPED` | Switch to `main`, fetch/prune, pull fast-forward, verify branch is merged, verify clean worktree. | Delete local merged task branch with non-force delete; prune stale worktrees. | Force delete, delete protected branches, delete unmerged branches, or delete remote branches manually. | Local cleanup completes or stops. | GitHub Operating Policy, Operating Model |
| `LOCAL_CLEANUP_DONE` | Local git state | Cleanup target is removed safely and worktree is clean. | `LESSON_REVIEW`, `DONE`, `STOPPED` | Verify branch list, worktree list, and status. | Report cleanup result. | Continue editing on cleaned branch. | Lesson decision is made or no lesson path is needed. | Operating Model |
| `LESSON_REVIEW` | Post-merge review context | PR is merged and lesson review is requested or review-fix history suggests it. | `LESSON_CAPTURE_PR_REQUIRED`, `DONE`, `STOPPED` | Inspect PR metadata, review comments, fix commits, and final state if available. | Summarize whether there is a durable lesson. | Modify files directly in the completed PR. | No durable lesson, or a follow-up lesson PR is needed. | Compound Knowledge Base, Solution Lookup Protocol |
| `LESSON_CAPTURE_PR_REQUIRED` | Durable lesson decision | A reusable policy, workflow, safety, or developer-experience lesson exists. | `INTENT_CAPTURED`, `DONE`, `STOPPED` | Define a separate docs-only task for the lesson. | Propose or create a separate docs-only PR when requested. | Write lesson directly into the merged PR or bypass review. | Follow-up task is created or deferred. | Compound Knowledge Base, Operating Model |
| `DONE` | Completed lifecycle | Work, cleanup, and lesson handling are complete or intentionally skipped. | `INTENT_CAPTURED` | Confirm no outstanding requested action remains. | Report final status. | Continue mutating without a new task. | A new owner intent starts another lifecycle. | Operating Model |
| `STOPPED` | Stop-state registry and owner gates | A stop condition applies. | The interrupted lifecycle state after the stop reason is resolved, or `INTENT_CAPTURED`, `TASK_DEFINED`, `LOCAL_REVALIDATION` when the task must be restarted or revalidated. | Report the specific stop reason from the stop-state registry when applicable and record the interrupted state when it is known. | Stop and ask for owner decision or corrected task input. | Continue past a stop state without resolving the stop reason. | Owner resolves the stop reason, provides corrected task input, or provides a new task. | Stop-State Registry, Risk Policy |

## Transition Rules

Allowed transitions follow the table above. A task may always enter `STOPPED` when a stop condition applies.

When a stop reason is resolved, the task may return to the interrupted lifecycle state if that state is still valid and the required checks for that state still pass. If the interrupted state is no longer valid, the task returns to the earliest state needed to revalidate the changed assumption.

Blocked transitions include:

- No branch work before source-of-truth revalidation when local repo state is unclear.
- No merge before PR creation.
- No cleanup before GitHub merge state is confirmed.
- No lesson capture write directly into the current PR after merge.
- No implementation phase before readiness audit or explicit owner approval.
- No trading repository connection before sandbox validation and separate trading-base Deep Research approval.
- No branch deletion unless the owner explicitly requests cleanup and the local branch is confirmed merged.

Lifecycle state names are documentation contracts only. They are not implemented CLI enums in this PR.

## Review-Fix Loop Integration

When review comments exist, Codex should:

1. Collect unresolved comments and review threads.
2. Classify each comment as in-scope fix, clarification only, owner decision required, out of scope, or unsafe/forbidden.
3. Fix only in-scope items inside the PR's allowed files and risk tier.
4. Run self-review before commit.
5. Commit and push fixes.
6. Resolve review threads only after the relevant fix or response is verified.

When no review comments exist, skip the review-fix loop.

When no review comments exist and no durable lesson exists from another source, skip Compound/post-merge lesson capture.

## Post-Merge Lesson Handling

No review means Compound can be skipped unless another durable lesson source exists.

Review exists but no durable lesson means the result should be summarized without creating a new lesson PR.

Durable lesson exists means a separate docs-only PR should capture it under `docs/solutions/**` or the related guidance docs.

Compound output is advisory, not source of truth. New or changed lessons must go through normal PR review before becoming repository guidance.

### Compound Triage Triggers

Formal review comments plus review-fix commits require Compound/post-merge lesson triage.

Formal review evidence should come from authenticated/tool-reported PR review state when available. Public GitHub UI observations, public bot comments, chat reports, or handoff reports alone do not force Compound triage unless authenticated review evidence or another durable lesson source supports it.

If triage finds a necessary additional docs-only lesson or fix and the current gate explicitly allows it, Codex may create one narrow docs-only branch, commit, and PR within the approved scope.

If triage finds no additional lesson or fix, skip PR creation and return evidence only. If there was no formal review and no review-fix loop, skip Compound/lesson triage by default.

Lesson triage does not authorize merge, branch cleanup, worktree deletion, GitHub settings changes, or any other owner-gated action.

## Cleanup Handling

Cleanup is local-only state and must be verified locally.

Cleanup must never force-delete branches, delete protected branches, delete unmerged branches, or rely only on remote branch deletion.

Protected branches include `main`, `master`, `develop`, and `release/*`.

This PR does not implement cleanup automation.

## Relationship to Contracts

The [Task Contract](TASK_CONTRACT.md) defines the fields that make `TASK_DEFINED` safe enough to execute.

The [Local Task Format Contract](LOCAL_TASK_FORMAT.md) may later serialize task fields, but it does not replace lifecycle gates.

The [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) may later report whether a task can proceed from `TASK_DEFINED` toward planning and branch work.

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) may later describe execution steps, but it must preserve lifecycle gates, owner decisions, stop conditions, and safety fields.

PR metadata should make the current lifecycle assumptions reviewable, especially scope, non-goals, allowed files, forbidden files/actions, validation plan, stop conditions, risk tier, self-review, solution lookup, and merge boundary.

When a future PR used multiple Codex workers, PR metadata should also make role assignment, worker count, evidence packets, credit/cost class, sequential versus parallel assumptions, and dispatcher reconciliation reviewable. This is metadata guidance only and does not authorize worker execution or PR creation.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns specific `STOPPED_*` reasons.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) helps prevent repeat lifecycle, review-fix, and stop-state mistakes.

## PR-Producing Final Response Contract

For any task that creates or updates a PR, the final response must begin with:

```text
PR: <url>
PR number: <number>
Branch: <branch>
```

The same final response must also include:

- Commit hash.
- Files changed.
- Validation commands and outcomes.
- Forbidden actions not performed.
- Source-of-truth classification.
- Recommended next action.

This contract applies to docs-only PRs, Compound/post-merge lesson PRs, sandbox/control-plane PR-producing tasks, review-fix PR updates when a new commit is pushed, and any future Codex task that creates or updates a PR.

This reporting contract does not authorize merge, branch deletion or cleanup, GitHub settings changes, workflow changes, ruleset/secret/permission changes, extra PR writes beyond the approved task scope, or Hermes GitHub/control-plane authority.

Final response formatting does not replace PR body metadata, validation evidence, source-of-truth checks, or owner gates. PR body text, chat, handoff text, and prior assistant output are not repository source of truth by themselves.

## Stop Handling

`STOPPED` is a lifecycle state.

Specific stop reasons must use the central [Stop-State Registry](STOP_STATE_REGISTRY.md).

If a future PR introduces or changes any `STOPPED_*` code, it must update the registry and every relevant local Stop States section in the same PR.

If shared policy is affected, update [Risk Policy](RISK_POLICY.md).

## Non-Goals

This document does not add:

- CLI implementation.
- Workflow implementation.
- GitHub write automation.
- PR publisher implementation.
- Branch cleanup automation.
- Discord bot integration.
- Trading functionality.
- Real trading repository connection.
