# Worktree Harness Result Validation Checklist

## Status

| Field | Value |
| --- | --- |
| Status | `draft_checklist` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only validation checklist |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Validates future results and examples against [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md), [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md), [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md), and [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md) |
| Risk tier | Low-risk docs-only checklist PR |

This document is a non-executable checklist. It does not implement a script, schema, command, harness, validation automation, cleanup routine, retention enforcement, branch automation, or publisher behavior.

## Purpose

This checklist helps future reviewers validate worktree harness result reports and result examples before any worktree harness implementation exists.

It makes safety fields, evidence classification, lifecycle status, stop states, owner gates, cleanup boundaries, branch and worktree ownership evidence, retention behavior, and cross-document consistency visible before a future task relies on those result shapes.

The checklist is guidance for review and self-review. It does not authorize branch creation, branch deletion, worktree creation, worktree deletion, worktree pruning, cleanup, Codex worker execution, publisher behavior, or automation.

## Relationship To Existing Docs

[Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) defines the required future result fields, lifecycle reporting, validation reporting, evidence classification, stop/report fields, owner gates, cleanup fields, unknown handling, and safety-field preservation expectations.

[Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) defines branch naming, branch ownership evidence, worktree ownership evidence, ambiguity handling, conflict handling, protected branch boundaries, cross-repo boundaries, and cleanup boundaries.

[Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) defines active, completed, stale, dirty, ambiguous, foreign-repo, protected/shared, and unknown worktree handling as report-first retention policy.

[Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md) provides non-executable examples for successful, stopped, ambiguous, dirty, foreign-repo, protected-branch, conflict, owner-gated cleanup, and controlled squash-merged cleanup report-only cases.

This checklist validates consistency across those docs. It does not implement a validator or define an executable schema.

## Scope

This checklist covers future review of:

- Repository identity validation.
- Target repository and do-not-modify repository boundaries.
- Safety-field preservation.
- Evidence classification.
- Lifecycle and status alignment.
- Stop-state registry alignment.
- Owner-gate validation.
- Cleanup and report-only boundary validation.
- Branch and worktree ownership evidence validation.
- Retention and report-first behavior.
- Cross-document consistency.
- Validation metadata requirements.

Allowed files for this PR:

- `docs/WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing link.
- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md` for a narrow relationship link.
- `docs/WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md` for a narrow relationship and follow-up update.
- `docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md` for a narrow follow-up update.
- `docs/WORKTREE_RETENTION_POLICY.md` for a narrow follow-up update.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Execute a Codex worker.
- Create, delete, prune, clean, or modify worktrees.
- Enforce worktree retention.
- Clean stale worktrees.
- Create branches except the PR task branch.
- Clean up branches.
- Implement branch deletion automation.
- Create a GitHub App.
- Change tokens, permissions, settings, branch protection, or rulesets.
- Create or edit GitHub workflows.
- Set up Docker, VPS, Continue, or MCP behavior.
- Implement PR publisher behavior.
- Enable auto-merge.
- Add executable validation scripts.
- Add executable schemas.
- Modify the sandbox repository.
- Run sandbox validation.
- Merge any PR.
- Force push.
- Touch trading repositories or trading code.
- Add live trading, exchange credential, risk cap, or model promotion logic.
- Add credentials, secrets, tokens, API keys, sample keys, or secret-like placeholders.
- Add source code, scripts, dependency manifests, automation, Discord or Slack integration, branch cleanup automation, or production automation.

## Checklist Format Rules

- Checklist items are documentation guidance, not executable tests.
- Future use should record each item as `pass`, `fail`, or `확인 필요`.
- A failed safety-boundary item should stop/report instead of continuing.
- Missing evidence should be recorded as `확인 필요`.
- Public-only, user-reported, or PR-body claims must not be promoted to local-verified or authenticated/tool-reported evidence.
- Run-local facts must not be treated as universal repository facts.
- This checklist must not be used to authorize cleanup, deletion, pruning, worktree mutation, branch mutation, GitHub writes, or automation.

## Required Checklist Sections

### A. Target Repo Identity

| Checklist item | Expected result |
| --- | --- |
| Target repository is declared. | The result names the intended repository. |
| Local path is declared. | The result records the local path and evidence class. |
| Remote URL is declared. | The result records the remote URL and verification method. |
| Do-not-modify repository boundary is declared. | The result names repositories and paths that must remain untouched. |
| Wrong repo, path, or remote stops before mutation. | The result reports stopped or owner-decision-required behavior before any branch, worktree, cleanup, or file mutation. |

### B. Safety-Field Preservation

| Checklist item | Expected result |
| --- | --- |
| Scope is preserved. | The result keeps the task scope visible. |
| Non-goals are preserved. | The result keeps excluded work visible. |
| Allowed files are preserved. | The result reports the allow-list or records it as missing. |
| Forbidden files are preserved. | The result does not collapse deny-list paths into generic notes. |
| Forbidden actions are preserved. | The result keeps external writes, deletion, cleanup, automation, and implementation bans visible. |
| Validation plan is preserved. | The result records intended, run, skipped, and failed validation checks. |
| Stop conditions are preserved. | The result records relevant stop/report conditions and registry-backed codes when applicable. |
| Risk tier is preserved. | The result records low, medium, high, prohibited, or owner-gated risk framing. |
| Owner gates are preserved. | The result records required owner decisions and forbidden actions until approval. |

### C. Evidence Classification

| Checklist item | Expected result |
| --- | --- |
| Local-verified evidence is separate. | Local filesystem and git facts checked in the current run stay in their own section. |
| Authenticated/tool-reported evidence is separate. | Authenticated GitHub or tool output stays distinct from local evidence. |
| Public/web-verified evidence is separate. | Public-only evidence is labeled as weaker than authenticated state for owner-gated decisions. |
| User-reported evidence is separate. | Owner or prompt claims stay user-reported until revalidated. |
| `확인 필요` evidence is separate. | Unknown or unavailable facts remain explicit. |
| PR body claims are not over-promoted. | PR body statements are evidence about what the PR body said, not automatic current verification. |
| Run-local facts are not treated as universal facts. | Local path, HEAD, worktree, and tool availability facts are scoped to the run that verified them. |

### D. Lifecycle And Status Alignment

| Checklist item | Expected result |
| --- | --- |
| Status matches lifecycle state. | A stopped case uses stopped semantics; a planning-only case does not imply validation or implementation. |
| Stopped examples use stopped semantics. | Active stop conditions use `status: stopped` and preserve the reason. |
| Owner-decision-required examples do not imply mutation authority. | Owner gates recommend a decision instead of approving the action by appearing in the result. |
| Interrupted lifecycle state is preserved when known. | A stopped result records the interrupted state or marks it `확인 필요`. |
| Recommended next action aligns with status. | Stopped cases recommend stop/report, revalidation, owner decision, or safe resume conditions. |

### E. Stop-State Registry Alignment

| Checklist item | Expected result |
| --- | --- |
| Every referenced `STOPPED_*` code exists in [Stop-State Registry](STOP_STATE_REGISTRY.md). | Registry-backed code is verified before commit or before result publication. |
| New stop codes are not invented casually. | Plain-language stop/report is used when no registry code is needed. |
| Stop-state mismatch is fixed before commit or publication. | Drift is corrected or the task stops/reports. |
| Forbidden file/action examples align with allowed-files guard semantics. | File-boundary violations use stopped semantics and `STOPPED_FORBIDDEN_FILE_CHANGE` when applicable. |

### F. Branch And Worktree Ownership

| Checklist item | Expected result |
| --- | --- |
| Intended branch is reported. | The result records the target branch or marks it `확인 필요`. |
| Actual branch is reported when different. | The result does not hide branch drift. |
| Branch HEAD is reported when known. | The result records local or remote HEAD evidence class. |
| Base branch and base HEAD are reported. | The result records the base branch and known HEAD before or after update. |
| PR linkage is reported if available. | PR number, URL, merge state, and review state are recorded with evidence class. |
| Worktree path is reported if available. | The result records path and evidence class without implying ownership from path alone. |
| Ownership evidence is present. | Task id, task title, PR id, branch, worktree path, creation method, or owner decision evidence is recorded. |
| Ambiguity stops instead of guessing. | Multiple candidate branches/worktrees, missing ownership, or conflicting evidence stop/report. |
| Protected, shared, open, or unmerged branch handling stops/reports. | The result does not overwrite, reset, force push, force delete, or cleanup ambiguous branches. |

### G. Retention And Report-First Behavior

| Checklist item | Expected result |
| --- | --- |
| Active worktrees are classified. | Active task worktrees remain retained and reported. |
| Completed worktrees are classified. | Completed worktrees are report-only cleanup candidates, not automatic deletion targets. |
| Stale worktrees are classified. | Stale worktrees are reported with ownership, cleanliness, age if known, and next action. |
| Dirty worktrees stop/report. | Dirty worktrees are not checked out, reset, stashed, cleaned, deleted, or pruned automatically. |
| Ambiguous worktrees stop/report. | Missing, conflicting, or multiple ownership signals do not permit mutation. |
| Foreign-repo worktrees stop/report. | A control-plane task does not modify sandbox worktrees, and a sandbox task does not modify control-plane worktrees. |
| No deletion or pruning authorization is implied. | Retention results remain report-first unless a later owner-approved policy authorizes enforcement. |

### H. Cleanup Boundary

| Checklist item | Expected result |
| --- | --- |
| `cleanup_allowed` is explicitly false unless future policy authorizes it. | Checklist or example docs do not authorize cleanup by default. |
| `cleanup_performed` is explicitly false unless the current task is a cleanup task. | Report-only tasks do not claim cleanup execution. |
| Normal cleanup and controlled squash-merged cleanup are distinguished. | The result separates ordinary safe cleanup from owner-gated squash-merge cleanup classification. |
| No `git branch -D` authority is implied. | Controlled squash-merged cleanup examples remain report-only unless a later owner-approved task says otherwise. |
| Owner gate is required for cleanup, deletion, or pruning. | The result records the gate and safe alternatives. |
| Cleanup examples are report-only unless a separate owner-approved cleanup task exists. | Examples do not become cleanup policy by themselves. |

### I. Cross-Repo Boundary

| Checklist item | Expected result |
| --- | --- |
| Control-plane tasks cannot modify sandbox. | The result confirms sandbox untouched or records why it cannot be verified. |
| Sandbox tasks cannot modify control-plane. | The result confirms control-plane untouched for sandbox tasks where applicable. |
| Repo, path, or remote mismatch stops before mutation. | The result does not proceed from ambiguous identity. |
| Other repo untouched confirmation is included. | The result records whether the do-not-modify repo was untouched, with evidence class. |

### J. Forbidden Implementation Content

| Checklist item | Expected result |
| --- | --- |
| No source code is added. | Docs-only tasks remain documentation-only. |
| No scripts are added. | Checklist work does not become validation tooling. |
| No executable schemas are added. | Result examples remain illustrative, not machine-enforced schemas. |
| No workflows are added. | GitHub Actions and workflow files remain out of scope. |
| No dependency manifests are added. | No runtime or package setup is introduced. |
| No credentials, secrets, tokens, or API keys are added. | No secret-like placeholders are introduced. |
| No trading code is added. | Trading repositories, trading logic, live trading, risk cap, and model promotion remain forbidden. |
| No automation, publisher, cleanup, or retention enforcement is implemented. | The result or example remains report-only. |

### K. Cross-Document Consistency

| Checklist item | Expected result |
| --- | --- |
| Aligns with [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md). | The result does not authorize harness implementation or worktree mutation. |
| Aligns with [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md). | Required result fields, status model, evidence, stop/report fields, owner gates, cleanup, and unknowns remain consistent. |
| Aligns with [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md). | Branch naming, ownership evidence, conflicts, and ambiguity handling remain consistent. |
| Aligns with [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md). | Retention stays report-first and owner-gated. |
| Aligns with [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md). | Examples preserve safety fields, evidence classes, stop semantics, and cleanup boundaries. |
| Aligns with [Task Lifecycle State Model](TASK_LIFECYCLE.md). | Lifecycle states, stopped recovery, merge boundary, cleanup boundary, and lesson handling remain consistent. |
| Aligns with [Stop-State Registry](STOP_STATE_REGISTRY.md). | Stop codes are registry-backed. |
| Aligns with [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) and [Factory Status Result Contract](FACTORY_STATUS_RESULT.md). | Validation/status summaries preserve unknowns, safety fields, owner gates, and stop state. |
| Aligns with [PR Metadata Guard Contract](PR_METADATA_GUARD.md) and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md). | PR metadata and changed-file checks preserve forbidden files/actions and evidence class separation. |

## Checklist Result Template

Future docs or review tasks may copy this non-executable template:

| Checklist item | Result | Evidence class | Source | Blocking | Recommended next action |
| --- | --- | --- | --- | --- | --- |
| Target repo declared | `pass` / `fail` / `확인 필요` | `local-verified` / `authenticated/tool-reported` / `public/web-verified` / `user-reported` / `확인 필요` | Command, doc, PR, or owner report | `yes` / `no` | Continue, fix before commit, stop/report, or owner decision |
| Safety fields preserved | `pass` / `fail` / `확인 필요` | Evidence class | Task contract or result report | `yes` / `no` | Restore missing fields or stop/report |
| Cleanup boundary preserved | `pass` / `fail` / `확인 필요` | Evidence class | Result report or example | `yes` / `no` | Keep report-only, request owner decision, or stop/report |

Template rules:

- Use `fail` for verified violations.
- Use `확인 필요` for missing or unavailable evidence.
- Mark safety-boundary failures as blocking unless the owner explicitly approves a changed task scope.
- Do not turn this template into a schema, script, parser, or automated check without a separate owner-approved task.

## Failure Handling

| Failure | Required handling |
| --- | --- |
| Safety field missing | Stop/report, restore the missing field, or request owner decision. |
| Forbidden implementation content appears | Stop/report with the relevant existing stop state when applicable. |
| Stop-state mismatch appears | Fix before commit or stop/report with registry comparison evidence. |
| Evidence classes collapse together | Fix before commit or stop/report; do not over-promote weak evidence. |
| Cleanup or mutation authorization is ambiguous | Use `owner_decision_required` or stopped semantics; do not proceed. |
| Cross-repo ambiguity appears | Stop/report before any mutation and confirm the other repo remains untouched. |
| Changed files exceed allowed files | Stop/report and remove out-of-scope changes unless owner approves a new task. |

## Acceptance Criteria

This checklist is acceptable when:

- The PR is docs-only.
- The checklist is non-executable.
- No implementation is implied.
- No branch or worktree mutation is authorized.
- No cleanup is authorized.
- Evidence classes remain separate.
- Safety fields are preserved.
- Stop-state references are checked against the registry.
- The sandbox repository remains untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define Codex worker boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.
- `Docs: define worktree harness status summary format`.

## Validation And Evidence Classification For This PR

### Local-Verified

- Control-plane repository root was verified before editing.
- Control-plane remote URL was verified before editing.
- Current branch and clean working tree were verified before editing.
- Latest `main` was fetched, pruned, and fast-forward pulled before this branch was created.
- Required Phase 3 worktree harness docs exist on latest `main`.
- Solution lookup and required policy doc review were completed before editing.
- This PR is limited to documentation files allowed by the task contract.

### Authenticated/Tool-Reported

- PR #39 was reported as `MERGED` by authenticated GitHub CLI.
- PR #39 merge commit was reported by authenticated GitHub CLI.
- PR #39 reviews were reported as an empty list by authenticated GitHub CLI.
- Open control-plane PR list was reported as empty by authenticated GitHub CLI before this branch was created.
- The PR #39 remote head branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- Public web verification was not required for this task because authenticated GitHub CLI and local repository checks were available.

### User-Reported

- The owner reported PR #39 was merged.
- The owner reported PR #39 had no formal review.
- The owner reported PR #39 local branch/worktree cleanup was completed.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, and repository secrets unless separately revalidated by a task that needs them.
- Future executable validation approach, if any.
- Future worktree root location.
- Future task id format.
- Future branch ownership persistence format.
- Future controlled cleanup policy boundary.
- Future branch lifecycle automation timing.
- Tool/plugin versions unless a later task records them.

## Solution Lookup Result

Applicable solution entries were found and applied:

- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): examples and checklist requirements must preserve safety fields, align status, stop state, lifecycle/interrupted state, cleanup, and recommended next action.
- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): required lookup happened before planning/editing; stopped and review-fix states remain consistent with lifecycle policy.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): PR metadata must keep Self-review result and Confirmations distinct.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): changed-file and forbidden-file failures should use stopped semantics when a stop condition applies.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): stopped evidence must preserve interrupted lifecycle context when known.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): run-local facts remain local evidence and unknowns remain explicit.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): referenced `STOPPED_*` codes must be registry-backed.

No applicable solution conflicted with this docs-only checklist scope.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Local suspicious hidden or bidirectional Unicode scan on edited Markdown files.
- Changed files are limited to the allowed files for this task.
- No forbidden files or paths changed.
- No workflows, source, scripts, executable schemas, dependency manifests, secrets, trading files, automation, publisher behavior, cleanup automation, Discord or Slack integration, risk cap logic, or model promotion logic were added.
- Relative links added by this PR resolve.
- Referenced `STOPPED_*` codes exist in [Stop-State Registry](STOP_STATE_REGISTRY.md).
- Self-review against this task contract and current repository policy surfaces.

## Safety Field Preservation

This checklist preserves:

- `scope`.
- `non_goals`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop conditions.
- Risk tier.
- Owner gates.

Dropping these fields in future validation, result examples, status reports, PR metadata, or handoffs remains a stop/report condition.
