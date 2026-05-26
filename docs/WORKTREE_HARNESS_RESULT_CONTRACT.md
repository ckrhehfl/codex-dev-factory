# Worktree Harness Result Contract

## Status

| Field | Value |
| --- | --- |
| Status | `draft_contract` |
| Phase | Phase 3 Worktree Harness |
| Implementation status | `not_started` |
| Scope | Docs-only result contract |
| Source of truth after merge | This repository's merged documentation |
| Relationship | Follows [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) |
| Risk tier | Low-risk docs-only contract PR |

This document defines the future result object or report a worktree harness must produce. It is documentation only. It does not implement a harness, create or delete worktrees, run Codex, create executable schemas, add scripts, configure automation, grant GitHub authority, modify sandbox repositories, or perform cleanup.

## Purpose

The worktree harness result contract makes future harness behavior auditable before implementation exists.

It defines what a future harness result must report about repository identity, source-of-truth checks, branch and worktree state, lifecycle state, safety fields, validation, evidence classification, stop/report behavior, owner gates, cleanup state, and remaining unknowns.

The contract is intentionally report-only. No field in a future result may approve an owner-gated action by itself.

## Relationship To Existing Docs

[Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) defines what a future harness may and may not do. This document defines how future harness outcomes must be reported.

[Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) defines future task branch naming, branch ownership evidence, worktree ownership evidence, ambiguity handling, conflict handling, cross-repo boundaries, and cleanup boundaries.

[Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) defines future worktree retention classification, report-first stale/dirty/ambiguous worktree handling, owner-gated cleanup boundaries, and no-deletion/no-pruning defaults.

Related reporting and safety surfaces:

- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md) defines task validation result expectations.
- [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) defines broader status reporting expectations.
- [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines lifecycle states, stopped handling, cleanup boundaries, and lesson-review boundaries.
- [Stop-State Registry](STOP_STATE_REGISTRY.md) owns `STOPPED_*` codes.
- [PR Metadata Guard Contract](PR_METADATA_GUARD.md) defines required PR metadata surfaces.
- [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md) defines changed-file boundary reporting.
- [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) defines branch and worktree ownership policy that future results should report.
- [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) defines retention state classes and report-first retention result fields.

This PR does not implement the harness or any related command.

## Scope

This result contract covers:

- Repository identity.
- Source-of-truth state.
- Base branch and base HEAD.
- Task branch and worktree identity.
- Lifecycle state.
- Scope, non-goals, allowed files, forbidden files, and forbidden actions.
- Validation plan and validation outcome.
- Evidence classification.
- Stop/report details.
- Owner gates.
- Cleanup status as report-only.
- Remaining `확인 필요`.

Allowed files for this PR:

- `docs/WORKTREE_HARNESS_RESULT_CONTRACT.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow Phase 3 sequencing note.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` for a narrow cross-link.

## Non-Goals

This PR does not:

- Implement a harness.
- Implement CLI behavior.
- Execute a Codex worker.
- Create, delete, prune, or modify worktrees.
- Create branches except this PR task branch.
- Delete, rename, clean, or automate branch lifecycle.
- Create a GitHub App, token, permission grant, repository setting change, branch protection rule, or ruleset.
- Create or edit GitHub Actions workflows.
- Set up Docker, VPS scheduling, Continue, MCP, scanners, or any external tool.
- Implement PR publisher behavior.
- Enable auto-merge.
- Modify the sandbox repository.
- Run sandbox validation.
- Merge any PR.
- Force push.
- Add source code, scripts, dependency manifests, executable schemas, task files, validation result files, plan files, credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify or connect a trading repository.
- Add trading code, live trading behavior, exchange integration, risk cap logic, model promotion logic, Discord/Slack integration, GitHub write automation, PR publisher behavior, branch cleanup automation, or production automation.

## Result Status Model

Future worktree harness results may use these conceptual statuses when compatible with the lifecycle and result docs:

| Status | Meaning |
| --- | --- |
| `planned` | The harness evaluated the task and produced a bounded plan or workspace intent without mutating worktrees. |
| `prepared` | The harness prepared the approved local state, branch, or worktree boundary for later work. |
| `validated` | Required validation checks ran and passed for the approved scope. |
| `stopped` | A stop condition applied and work halted. Use a registry-backed `STOPPED_*` code when applicable. |
| `owner_decision_required` | A gate requires owner approval before continuing. |
| `failed` | A non-stop validation or execution failure occurred and the task cannot continue without correction. |
| `not_run` | The step was intentionally skipped or not reached. The skip reason must be visible. |

These are report statuses, not new stop-state codes. If a stop condition applies, the result must report `status: stopped` and the matching [Stop-State Registry](STOP_STATE_REGISTRY.md) code when one exists.

## Required Top-Level Fields

Future worktree harness results should report these top-level fields in documentation or later implementation output:

- `result_version`.
- `generated_at`.
- `status`.
- `target_repo`.
- `local_repo`.
- `source_of_truth`.
- `task`.
- `branch`.
- `worktree`.
- `lifecycle`.
- `safety_fields`.
- `validation`.
- `evidence`.
- `stop_state`.
- `owner_gates`.
- `cleanup`.
- `unknowns`.
- `recommended_next_action`.

This is a documentation shape, not an executable schema. This PR does not add schema files.

## Repo Identity Fields

The result must identify the repository before and after any approved operation:

- Repository full name.
- Local path.
- Remote URL.
- Default branch.
- Current branch before operation.
- Current branch after operation.
- Base HEAD before operation.
- Base HEAD after fetch or fast-forward update.
- Verification method.
- Evidence class.

Repository identity must not be inferred from chat history, branch names, public-only UI, stale local state, or previous assistant answers.

## Task Fields

The result must preserve task-contract fields:

- Task id, if available.
- Task title.
- Scope.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.
- Source inputs.
- Target repository.
- Do-not-modify repository boundaries.

If these fields are transformed into plan, validation, status, PR metadata, guard output, or harness result language, they must remain visible and must not be weakened.

## Branch And Worktree Fields

The result must report branch and worktree state, even when mutation is not allowed:

- Intended task branch.
- Branch ownership evidence.
- Branch conflict status.
- Worktree path.
- Worktree creation status.
- Worktree cleanliness status.
- Worktree ownership evidence.
- Whether an existing worktree was reused.
- Whether any branch or worktree mutation occurred.
- Whether mutation was allowed by the task contract.

The future MVP may report these fields as `not_run`, `not_allowed`, or `확인 필요` when branch or worktree mutation is outside scope.

## Validation Fields

The result must report:

- Validation plan.
- Commands intended.
- Commands run.
- Commands skipped.
- Skip reasons.
- Pass, fail, stop, or not-run outcome.
- Edited files, if any.
- Allowed-files check result.
- Forbidden-files check result.
- Forbidden-actions check result.
- Stop-state registry check result.
- Docs-safe validation result.
- Link check result, if applicable.

Skipped checks are not failures by default, but they must remain visible. A skipped check that hides a safety boundary must stop or require owner decision.

## Evidence Classification Fields

The result must keep evidence in separate sections:

- `local_verified`.
- `authenticated_tool_reported`.
- `public_web_verified`.
- `user_reported`.
- `확인 필요`.

Each evidence item should include:

- Claim.
- Verification method.
- Timestamp or run context when appropriate.
- Whether it is durable evidence or run-local evidence.

Use portable verification evidence when possible, such as `git rev-parse --show-toplevel`, `git remote get-url origin`, `git status --short --branch`, `git rev-parse HEAD`, and authenticated GitHub CLI or connector output when GitHub state matters.

## Stop And Report Fields

When a stop condition is hit, the result must report:

- `status: stopped`.
- Registry-backed `stop_state.code` when applicable.
- Plain-language stop reason.
- Interrupted lifecycle state when known.
- Files changed before stop, if any.
- Whether sandbox or other do-not-modify repositories were untouched.
- Owner action required.
- Recommended next action.
- Safe resume conditions.

Stopped results must align:

- `status`.
- `stop_state.code`.
- `stop_state.reason`.
- Interrupted lifecycle state.
- `recommended_next_action`.

If no registry-backed code fits, use plain-language stop/report wording and avoid inventing new `STOPPED_*` codes unless the owning docs are also updated within an approved scope.

## Owner Gate Fields

Owner gates must report:

- Gate name.
- Gate reason.
- Required owner decision.
- Forbidden action until approval.
- Allowed safe alternatives.
- Whether the current task stopped because of the gate.

Owner gates are not satisfied by a result field alone. The owner decision must be explicit and source-of-truth verified for the current task.

## Cleanup Fields

Cleanup is report-only for this contract.

Future results may report:

- `cleanup_performed`: `true` or `false`.
- `cleanup_allowed`: `true` or `false`.
- Cleanup scope.
- Branch deletion status.
- Worktree deletion or prune status.
- Normal cleanup vs controlled squash-merged cleanup classification.
- Evidence class.
- Remaining `확인 필요`.

This contract does not authorize cleanup automation, worktree deletion, branch deletion, force deletion, or controlled squash-merge cleanup. Cleanup remains owner-gated and must follow the repository cleanup policy in effect for that task.

## Unknowns And 확인 필요 Fields

Unknowns must be explicit:

- Unknown item.
- Why it is unknown.
- How to verify it.
- Whether it blocks progress.
- Whether owner decision is needed.

The result must not guess GitHub settings, branch protection, open PR state, branch ownership, local cleanup state, sandbox state, or external tool availability.

## Example Results

These examples are illustrative only. They are not executable schemas and do not imply implementation exists.

### Successful Docs-Only Planning Result

```yaml
result_version: 1
status: planned
target_repo:
  full_name: ckrhehfl/codex-dev-factory
  evidence_class: local_verified
task:
  scope: docs-only result contract
  non_goals:
    - no harness implementation
    - no worktree mutation
  allowed_files:
    - docs/WORKTREE_HARNESS_RESULT_CONTRACT.md
  forbidden_files:
    - .github/workflows/**
    - source code
  forbidden_actions:
    - worktree creation
    - branch deletion
    - automation implementation
  validation_plan:
    - git status --short
    - git diff --check
  risk_tier: low-risk docs-only
  owner_gates:
    - merge remains owner-controlled
validation:
  status: passed
stop_state:
  code: null
cleanup:
  cleanup_performed: false
recommended_next_action: create_pr
```

### Stopped Wrong-Repo Result

```yaml
result_version: 1
status: stopped
lifecycle:
  current_state: STOPPED
  interrupted_state: LOCAL_REVALIDATION
safety_fields:
  scope: preserved
  allowed_files: preserved
  forbidden_files: preserved
  forbidden_actions: preserved
  validation_plan: preserved
  stop_conditions: preserved
  risk_tier: preserved
  owner_gates: preserved
stop_state:
  code: STOPPED_SOURCE_OF_TRUTH_UNCLEAR
  reason: target repository remote URL did not match the task contract
recommended_next_action: stop_and_report_verified_repo_identity
cleanup:
  cleanup_performed: false
```

### Stopped Dirty-Worktree Result

```yaml
result_version: 1
status: stopped
lifecycle:
  current_state: STOPPED
  interrupted_state: LOCAL_REVALIDATION
validation:
  commands_run:
    - git status --short --branch
stop_state:
  code: STOPPED_LOCAL_WORKTREE_DIRTY
  reason: clean worktree was required before branch or worktree preparation
owner_gates:
  - gate: local_state_cleanup_or_owner_decision
    forbidden_action_until_approval: continue_with_mutation
recommended_next_action: report_dirty_state_and_wait_for_owner_instruction
```

### Stopped Forbidden-File Request Result

```yaml
result_version: 1
status: stopped
lifecycle:
  current_state: STOPPED
  interrupted_state: TASK_DEFINED
task:
  allowed_files:
    - docs/WORKTREE_HARNESS_RESULT_CONTRACT.md
  forbidden_files:
    - .github/workflows/**
    - source code
  forbidden_actions:
    - workflow creation
    - harness implementation
validation:
  allowed_files_check:
    status: stopped
stop_state:
  code: STOPPED_FORBIDDEN_FILE_CHANGE
  reason: requested change would add a workflow file outside the allowed docs-only scope
recommended_next_action: remove_forbidden_file_request_or_request_owner_decision
```

### Owner-Decision-Required Cleanup Result

```yaml
result_version: 1
status: stopped
lifecycle:
  current_state: STOPPED
  interrupted_state: LOCAL_CLEANUP_PENDING
cleanup:
  cleanup_performed: false
  cleanup_allowed: false
  cleanup_scope: worktree_deletion
owner_gates:
  - gate: worktree_deletion
    required_owner_decision: approve_or_reject_future_cleanup_policy
    forbidden_action_until_approval: delete_worktree_or_branch
stop_state:
  code: STOPPED_OWNER_DECISION_REQUIRED
  reason: worktree deletion is owner-gated and outside the result-contract PR scope
recommended_next_action: define_controlled_cleanup_policy_before_automation
```

## Cross-Document Consistency

Future worktree harness results must align with:

- [Task Lifecycle State Model](TASK_LIFECYCLE.md).
- [Stop-State Registry](STOP_STATE_REGISTRY.md).
- [Task Validation Result Contract](TASK_VALIDATION_RESULT.md).
- [Factory Status Result Contract](FACTORY_STATUS_RESULT.md).
- [PR Metadata Guard Contract](PR_METADATA_GUARD.md).
- [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md).
- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md).

If future examples or result fields mention `STOPPED_*` codes, those codes must exist in the registry. If a future change adds or renames a stop code, update the registry and every relevant local stop-state section in the same approved PR.

## Acceptance Criteria

This contract is acceptable when:

- The PR is docs-only.
- Safety fields are preserved.
- No implementation is implied.
- No executable schema is added.
- No scripts or source code are added.
- The result can distinguish verified, user-reported, public/web-visible, authenticated/tool-reported, local-verified, and unknown facts.
- Stopped states include code, reason, interrupted lifecycle state when known, and next action.
- Cleanup remains report-only.
- Sandbox and trading repositories remain untouched.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: define Codex worker boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define controlled cleanup policy`.

## Evidence And Source Classification

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, latest `main`, and local HEAD were revalidated before branch creation.
- `docs/WORKTREE_HARNESS_MVP_BOUNDARY.md` exists after pulling latest `main`.
- `docs/TECH_STACK_DECISION_RECORD.md` exists after pulling latest `main`.
- Required solution lookup was completed before planning/editing.
- Current repository docs listed in the task were inspected before writing this record.

### Authenticated/Tool-Reported

- PR #34 was checked with GitHub CLI as `MERGED`.
- PR #34 merge commit was reported by GitHub CLI.
- PR #34 reviews list was reported empty by GitHub CLI.
- Open PR list for `ckrhehfl/codex-dev-factory` was reported empty by GitHub CLI before this branch was created.
- The PR #34 remote branch was not returned by a read-only remote head lookup.

### Public/Web-Verified

- No public web browsing was needed for this result-contract PR. Local repository docs and authenticated/tool-reported GitHub state were sufficient for the required checks.

### User-Reported

- The owner reported PR #34 was merged, had no formal review, and local branch/worktree cleanup was completed.

### 확인 필요

- GitHub repository settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Default worktree root location.
- Task id format and branch ownership persistence model.
- Maximum concurrent worktrees and retention policy.
- Whether future harness automation may create, delete, prune, or modify worktrees.
- Whether future harness automation may delete or clean branches.
- Whether any controlled squash-merge cleanup exception should ever exist.
- Whether the future harness may invoke a Codex worker or publisher.
- External tool versions and runtime availability.

## Solution Lookup Result

Solution lookup was completed before planning and editing.

Applicable lessons:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by completing solution lookup before planning/editing and preserving lifecycle interruption and resume context in stopped examples.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by requiring this PR body to include distinct self-review and confirmations sections.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by keeping file-boundary violations as `status: stopped` when a stop condition applies.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by matching example field shapes to the declared result contract and preserving interrupted lifecycle context.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by preferring portable verification evidence and avoiding machine-specific durable claims.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by using existing registry-backed stop codes and adding no new stop code.

No applicable solution conflicts with this docs-only result-contract scope.

## Safety Field Preservation

This contract preserves:

- `scope`.
- Non-goals.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

Future task, plan, validation, status, PR metadata, allowed-files guard, evidence, harness result, or implementation work must preserve these fields without weakening them.

## Stop Conditions

Use existing registry-backed stop states when applicable, including:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`.
- `STOPPED_LOCAL_WORKTREE_DIRTY`.
- `STOPPED_FORBIDDEN_FILE_CHANGE`.
- `STOPPED_OWNER_DECISION_REQUIRED`.
- `STOPPED_IMPLEMENTATION_INCLUDED`.
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`.
- `STOPPED_CODE_INCLUDED`.
- `STOPPED_WORKFLOW_INCLUDED`.
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`.
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`.
- `STOPPED_STOP_STATE_SURFACE_MISMATCH`.
- `STOPPED_SAFETY_FIELD_DROPPED`.

Plain-language stop/report conditions also apply when:

- Required source-of-truth docs are missing.
- Branch or worktree ownership is ambiguous.
- A future result would hide forbidden files or forbidden actions.
- The task asks for sandbox modification without approval.
- The task asks for worker execution, publisher integration, branch deletion, worktree deletion, cleanup automation, or environment setup before owner approval.

This PR introduces no new `STOPPED_*` code.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Changed files are limited to allowed files.
- No workflow, source, script, executable schema, dependency, secret, trading, sandbox, automation, publisher, cleanup, Discord/Slack, risk cap, or model promotion files changed.
- Relative links added by this PR resolve.
- Any referenced `STOPPED_*` code exists in [Stop-State Registry](STOP_STATE_REGISTRY.md).
