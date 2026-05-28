# Codex Worker Boundary

## Status

| Field | Value |
| --- | --- |
| Phase | Phase 4 planning / Codex Worker Connection boundary |
| Implementation status | `not_started` |
| Scope | Docs-only worker boundary |
| Source of truth after merge | This repository's merged documentation |
| Risk tier | Low-risk docs-only if limited to this document and narrow discoverability links |

This boundary defines the future Codex worker concept before any worker implementation or execution exists. It does not implement a worker, run Codex, implement a harness, create workflows, create scripts, create schemas, add publisher behavior, mutate worktrees, delete branches, perform cleanup, configure GitHub settings, set up runtime infrastructure, modify the sandbox repository, or touch trading systems.

## Purpose

The Codex worker boundary defines what a future worker may be allowed to do conceptually after separate owner approval.

It also defines what remains forbidden until separate owner-approved implementation tasks exist. Worker execution, publisher behavior, cleanup, GitHub settings, and runtime setup must not be bundled into one unsafe step.

This document is a planning and reporting boundary only. It does not grant execution authority.

## Worker Definition

The Codex worker is a future execution component that may operate only inside a verified task boundary after separate owner approval.

A future worker may consume:

- A task contract.
- Repository identity evidence.
- Allowed-file and forbidden-file boundaries.
- Forbidden-action boundaries.
- Owner gates.
- Worktree harness result surfaces.
- Worktree harness status summary surfaces.
- Source-of-truth classification.

The worker does not become source of truth by itself. It must not override local-verified, authenticated/tool-reported, public/web-verified, user-reported, or `확인 필요` classifications.

The [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) now records Codex-primary multi-agent completion as the primary strategic completion path. The [Codex Multi-Agent Architecture](CODEX_MULTI_AGENT_ARCHITECTURE.md) covers future multi-agent coordination, while this document remains the per-worker boundary. Hermes remains an active conditional wrapper/orchestration candidate for Codex-primary workflows only after official-docs feasibility and later sandbox validation. This does not authorize worker execution, Hermes setup/config/auth/execution, or GitHub/control-plane authority delegation.

## Relationship To The Worktree Harness

The worktree harness verifies repo, path, remote, branch, worktree, lifecycle, status, cleanup, and report-only boundaries before worker execution can be considered.

The worker must not assume a worktree is safe because a branch name looks familiar or a prior handoff says cleanup completed. The worker may rely on worktree state only when the current task's harness result or status summary reports the relevant facts as verified, or explicitly marks them `확인 필요`.

This boundary does not allow the worker to:

- Create worktrees.
- Delete worktrees.
- Prune worktrees.
- Clean worktrees.
- Delete branches.
- Clean branches.
- Rename branches.
- Infer cleanup completion from remote branch deletion alone.

The worker must preserve fields from [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) and [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md), including lifecycle status, branch ownership, worktree ownership, cleanup boundary, evidence classes, owner gates, and remaining `확인 필요`.

## Relationship To Publisher And GitHub Writes

The worker is not a publisher.

PR creation, PR updates, GitHub API writes, GitHub App behavior, auto-merge, branch deletion, branch protection changes, rulesets, required checks, repository settings, Actions setup, and secrets management remain separate owner-gated surfaces.

A future publisher boundary must be separately approved before any automated GitHub write authority exists. A worker result may propose PR metadata only when a separate owner-approved publisher or human owner is responsible for publication.

## Inputs

A future worker input boundary should include:

- Target repository.
- Local path for the current run.
- Current task contract.
- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.
- Repository identity evidence.
- Branch and worktree ownership evidence.
- Latest base branch evidence.
- Solution lookup result.
- Worktree harness result or status summary.
- Source-of-truth classification.

Missing, contradictory, stale, or user-reported-only required inputs must remain visible as `확인 필요` or stop/report, depending on the active policy.

## Outputs

A future worker output boundary may include:

- Proposed file changes or patch summary.
- Validation commands attempted and results.
- Validation commands skipped and reasons.
- Changed-files summary.
- Allowed-files and forbidden-files confirmation.
- Forbidden-actions confirmation.
- Source-of-truth classification.
- Remaining `확인 필요`.
- Owner gates encountered.
- Stop state, if any.
- Recommended next action.
- Proposed PR metadata only if publisher or PR creation behavior is separately allowed.

A worker output must not merge, auto-merge, perform cleanup, delete branches, remove worktrees, change GitHub settings, change secrets, or mutate repository settings.

## Allowed Conceptual Responsibilities

A future worker may eventually, after separate owner approval:

- Read approved task contracts.
- Inspect approved repository files.
- Propose edits within allowed files.
- Preserve scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.
- Run approved validation commands only when the task contract explicitly allows them.
- Report status and evidence.
- Stop on ambiguity.
- Hand results to a separate publisher or human owner only after owner-approved boundaries exist.

These responsibilities are conceptual. They are not implemented by this document.

## Explicit Non-Responsibilities

The worker must not:

- Decide owner gates.
- Grant itself implementation authority.
- Grant itself execution authority.
- Change GitHub settings, branch protection, rulesets, required checks, Actions, secrets, or repository permissions.
- Create workflows.
- Handle credentials, secrets, tokens, API keys, or secret-like placeholders.
- Touch the sandbox repository unless the task explicitly targets the sandbox and the current repo/path/remote are verified for that task.
- Modify trading repositories or trading code.
- Add live trading behavior, exchange integration, risk cap logic, or model promotion logic.
- Merge PRs.
- Enable auto-merge.
- Delete branches.
- Clean branches.
- Cleanup, delete, prune, or clean worktrees.
- Bypass branch protection.
- Assume PR body claims, handoff notes, prior conversation, or public-only UI state are source of truth.
- Treat Deep Research as repository source of truth by itself.

## Source-Of-Truth Handling

Future worker reports must preserve claim-by-claim source classification:

| Class | Meaning |
| --- | --- |
| `local-verified` | Verified from the current local repository or filesystem during the run. |
| `authenticated/tool-reported` | Reported by authenticated tooling, such as GitHub CLI or an approved connector. |
| `public/web-verified` | Observed through public web surfaces only. |
| `user-reported` | Stated by the owner or task prompt but not independently revalidated in the current run. |
| `확인 필요` | Unknown, unavailable, stale, blocked, ambiguous, or requiring future verification. |

The worker must never collapse these into a single unqualified "verified" claim. GitHub settings, branch protection, rulesets, required checks, secrets, local cleanup, plugin/tool versions, sandbox local state, and external repository state remain `확인 필요` unless the current run verifies them with the required source.

## Owner Gates

These decisions remain owner-gated:

- Worker implementation authority.
- Worker execution authority.
- Worktree harness implementation authority.
- Publisher authority.
- PR creation or PR update automation.
- Cleanup, branch deletion, worktree deletion, and worktree pruning authority.
- GitHub settings, branch protection, rulesets, required checks, Actions, secrets, and repository permissions.
- Docker, VPS, Continue, MCP, or other runtime setup.
- Sandbox repository modification.
- Credential, secret, token, API key, or permission handling.
- Trading repository work, live-boundary work, risk cap logic, and model promotion logic.

The worker may report that a gate exists. It must not resolve or approve the gate.

## Stop Conditions

Use existing registry-backed stop states when they apply, including:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` when repo, path, remote, branch, main state, or required source classification cannot be safely verified.
- `STOPPED_TASK_CONTRACT_INCOMPLETE` when a required task contract field is missing.
- `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD` when allowed files, forbidden files, forbidden actions, or owner gates are unsafe, contradictory, or too ambiguous.
- `STOPPED_FORBIDDEN_FILE_CHANGE` when changed files exceed the allowed file boundary.
- `STOPPED_IMPLEMENTATION_INCLUDED` when implementation appears in a docs-only task.
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED` when CLI implementation appears before approval.
- `STOPPED_CODE_INCLUDED` when source code appears in docs-only scope.
- `STOPPED_SCHEMA_CREATED_TOO_EARLY` when executable schema work appears before approval.
- `STOPPED_WORKFLOW_INCLUDED` when workflow files or workflow implementation appear before approval.
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED` when GitHub write automation appears before approval.
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY` when cleanup automation appears before approval.
- `STOPPED_CREDENTIAL_OR_SECRET_CONTENT` when credential, secret, token, API key, or sensitive account content appears.
- `STOPPED_TRADING_CODE_INCLUDED` when trading code appears in docs-first scope.
- `STOPPED_LIVE_TRADING_RELATED_CONTENT` when live trading boundary content appears.
- `STOPPED_OWNER_DECISION_REQUIRED` when a requested action crosses an owner gate.
- `STOPPED_SAFETY_FIELD_DROPPED` when scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, or owner gates disappear.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH` when stop-state references drift from the registry.

Plain-language stop/report also applies when no more specific registered code fits.

Stop/report when:

- Repo, path, remote, branch, or source-of-truth class is unclear.
- The task contract is incomplete.
- Allowed files, forbidden files, or forbidden actions are ambiguous.
- Implementation appears in this docs-only task.
- Worker execution is requested before approval.
- GitHub write automation is requested before approval.
- Cleanup, branch deletion, branch cleaning, worktree deletion, or worktree pruning is requested before approval.
- Credentials, secrets, tokens, API keys, trading content, live-boundary content, risk cap logic, or model promotion content appears.
- Any owner gate is required.

This document introduces no new `STOPPED_*` code.

## Worker Readiness Prerequisites

Actual worker connection remains blocked until separate owner-approved work verifies or defines:

- Local harness implementation boundary.
- Sandbox validation evidence required for worker behavior.
- Runtime strategy.
- Publisher boundary, if PR creation or PR update is automated.
- Cleanup policy, if cleanup is ever automated.
- GitHub settings, rulesets, required checks, and branch protection policy, if relied upon.
- Credential and secret handling boundary, if any.
- Owner approval for worker execution.

None of these prerequisites are satisfied by this document alone.

## Examples

These examples are illustrative only. They are not executable schemas and do not imply worker implementation exists.

### Docs-Only Worker Boundary Planning Run

| Field | Example |
| --- | --- |
| `lifecycle_status` | `DOCS_EDITING` or `SELF_REVIEW` |
| `factory_status` | `not_checked` until a future status command exists |
| `worker_execution` | `not_run` |
| `source_of_truth` | Repo identity local-verified; PR state authenticated/tool-reported if checked; handoff claims user-reported |
| `allowed_files` | Current task's allowed docs-only files |
| `forbidden_actions` | Worker execution, implementation, cleanup, GitHub settings changes, publisher behavior |
| `owner_gates` | Merge, worker execution, publisher authority, cleanup, runtime setup |
| `remaining_confirm_needed` | GitHub settings, branch protection, rulesets, required checks, secrets, and future runtime decisions |
| `recommended_next_action` | Complete docs-only validation, commit, push, and create a reviewable PR if the task contract allows |
| `stop_state` | None |

Safety fields preserved: scope, non-goals, allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates.

### Stopped Run: Repo Identity Unclear

| Field | Example |
| --- | --- |
| `lifecycle_status` | `STOPPED` |
| `factory_status` | `stopped` |
| `worker_execution` | `not_run` |
| `stop_state.code` | `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` |
| `stop_state.reason` | Target repo, path, or remote could not be verified before worker planning |
| `source_of_truth` | Conflicting or unavailable local evidence; user-reported target preserved separately |
| `recommended_next_action` | Stop and revalidate repo root, remote URL, branch, main state, and task target before continuing |

The top-level status, stop state, reason, and recommended next action align with the stop-state registry.

### Stopped Run: Worker Execution Requested Before Approval

| Field | Example |
| --- | --- |
| `lifecycle_status` | `STOPPED` |
| `factory_status` | `stopped` |
| `worker_execution` | `requested_but_not_allowed` |
| `owner_gate` | Worker execution authority |
| `stop_state.code` | `STOPPED_OWNER_DECISION_REQUIRED` |
| `stop_state.reason` | The task requested worker execution before owner-approved worker implementation and execution authority exist |
| `recommended_next_action` | Stop and request a separate owner-approved worker implementation or execution task |

This example uses a stopped status because a registry-backed stop code is active.

### Owner-Gated Publisher, Cleanup, Or Settings Request

| Field | Example |
| --- | --- |
| `lifecycle_status` | `STOPPED` |
| `factory_status` | `stopped` |
| `requested_authority` | Publisher behavior, cleanup, branch deletion, rulesets, required checks, or settings changes |
| `owner_gate` | Publisher, cleanup, or GitHub settings authority |
| `stop_state.code` | `STOPPED_OWNER_DECISION_REQUIRED` |
| `cleanup_boundary` | `cleanup_allowed: false`; `cleanup_performed: false` |
| `publisher_boundary` | `publisher_allowed: false`; `github_write_automation_added: false` |
| `recommended_next_action` | Stop and create a separate docs-only authority boundary or owner-decision task |

This example does not authorize PR publisher behavior, cleanup, branch deletion, worktree pruning, settings changes, or automation.

## Cross-Document References

- [Roadmap](ROADMAP.md) defines Phase 4 ordering for Codex worker connection.
- [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) classifies Codex-primary multi-agent completion as the primary strategic direction, while keeping worker implementation and execution unapproved.
- [Risk Policy](RISK_POLICY.md) defines docs-only and high-risk boundaries.
- [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) defines GitHub settings, branch protection, PR lifecycle, and cleanup boundaries.
- [Task Contract](TASK_CONTRACT.md) defines required task fields and owner gates.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines lifecycle states, stopped-state recovery, merge, cleanup, and lesson boundaries.
- [Stop-State Registry](STOP_STATE_REGISTRY.md) owns `STOPPED_*` codes.
- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) defines future harness responsibilities before implementation.
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) defines future harness result reporting.
- [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md) defines non-executable validation checks for future results and examples.
- [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md) defines future status summary reporting.
- [PR Metadata Guard](PR_METADATA_GUARD.md) defines PR metadata completeness and safety-field checks.
- [Allowed-Files Guard](ALLOWED_FILES_GUARD.md) defines changed-file boundary reporting.

## Evidence Classification For This PR

### Local-Verified

- Repository root, remote URL, current branch, clean worktree, local HEAD, latest `main`, and worktree list were revalidated before this branch was created.
- Stale local branch candidates requested by the task were checked and were not present at preflight.
- Required worktree harness, lifecycle, stop-state, validation, status, PR metadata, allowed-files, risk, operating, roadmap, and technical stack docs existed and were inspected before editing.
- Required solution lookup was completed before editing.

### Authenticated/Tool-Reported

- PR #41 was reported by GitHub CLI as `MERGED`.
- PR #41 merge commit and empty formal review list were reported by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty before this branch was created.
- Remote branches `docs/worktree-status-summary-format` and `docs/codex-worker-boundary` were not returned by read-only remote head lookup during preflight.

### Public/Web-Verified

- No public web browsing was needed for this boundary PR because local and authenticated/tool-reported evidence were sufficient for the required checks.

### User-Reported

- The owner reported PR #41 was merged and local cleanup completed.
- The owner reported PR #41 had no formal review and the remote branch was deleted.

### 확인 필요

- Sandbox local status, because read-only `git status` was blocked by Git `safe.directory` ownership protection and this task forbids changing Git config.
- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, repository secrets, and permissions unless a future task verifies them.
- Future worker implementation, worker execution authority, runtime strategy, publisher boundary, cleanup policy, GitHub settings policy, credential boundary, and sandbox modification authority.
- Plugin/tool versions beyond the GitHub CLI version checked during preflight.

## Solution Lookup Result

Applicable solution entries were found and applied:

- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by keeping inputs, outputs, normative rules, and examples aligned, and by using `status: stopped` semantics whenever a registry-backed `STOPPED_*` code appears.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using existing `STOPPED_*` codes from [Stop-State Registry](STOP_STATE_REGISTRY.md) and introducing no new stop code.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by treating forbidden file/action boundary violations as stop/report conditions, not soft validation failures.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping validation, self-review, and confirmations distinct for the PR body.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by keeping stopped examples aligned across status, stop state, reason, and recommended next action.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by marking run-local and blocked sandbox facts as `확인 필요` instead of durable source of truth.

No directly relevant solution conflicted with this docs-only worker boundary scope.

## Safety Field Preservation

Future worker inputs, outputs, status summaries, validation reports, PR metadata, and handoffs must preserve:

- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

If a future worker transformation drops or weakens any of these fields, it must stop with `STOPPED_SAFETY_FIELD_DROPPED`.

## Validation Plan For This PR

This docs-only PR should be validated with:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Hidden or bidirectional Unicode control-character scan on edited Markdown.
- Changed-files check against the allowed file list.
- Forbidden-files/actions check.
- Relative link check for links added by this PR.
- `STOPPED_*` registry check for referenced stop codes.
- Self-review against the task contract and current repo policies.
