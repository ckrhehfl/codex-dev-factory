# Phase 1/2 Readiness Audit

## Purpose

This document defines the canonical audit for deciding whether the docs-first factory is ready to proceed toward sandbox validation and later Phase 2 local CLI skeleton implementation.

The audit makes readiness explicit and evidence-based. It prevents the project from moving into sandbox setup, sandbox validation, or implementation work while documentation, contracts, policy surfaces, or owner gates remain incomplete or contradictory.

This is a documentation contract only. It does not implement CLI behavior, automation, GitHub writes, PR publisher behavior, workflows, branch cleanup automation, Discord integration, sandbox repository creation, trading functionality, trading repository connection, live trading, credentials, risk cap logic, or model promotion logic.

## Non-Goals

This contract does not add:

- CLI implementation.
- GitHub write automation.
- PR publisher implementation.
- Branch cleanup automation.
- GitHub Actions workflows.
- Discord bot or Discord integration.
- Sandbox repository creation.
- Trading functionality or trading repository connection.
- Live trading, credentials, risk cap logic, or model promotion logic.

## Audit Timing

Use the readiness audit conceptually:

- Before creating or connecting a sandbox repository.
- Before beginning actual sandbox validation.
- Before Phase 2 CLI skeleton implementation.
- After major policy or contract changes that affect phase gates.
- After review-fix loops that introduce durable lessons affecting readiness.

The audit must not infer unchecked local state, GitHub state, PR state, repository settings, branch cleanup state, or owner approval. Unknown state stays explicit until verified.

## Required Audit Inputs

A readiness audit should inspect or report unavailable status for these inputs:

- Current repository source-of-truth status.
- Latest verified `main` state.
- Open PR state.
- Core documentation inventory.
- Solution lookup status.
- Task lifecycle contract.
- Stop-state registry.
- Task contract.
- Local task format contract.
- Plan output contract.
- Task validation result contract.
- Factory status result contract.
- PR metadata guard contract.
- Allowed-files guard contract.
- Sandbox validation plan.
- Sandbox validation evidence contract.
- Phase 2 CLI skeleton contract.
- Acceptance tests.
- Risk policy.
- Roadmap.
- Owner gates and explicit non-goals.

## Readiness Dimensions

The audit should report each readiness dimension separately:

- Source-of-truth readiness.
- Documentation inventory readiness.
- Cross-document consistency readiness.
- Solution lookup readiness.
- Stop-state registry readiness.
- Lifecycle readiness.
- Task contract readiness.
- Validation contract readiness.
- Status/result contract readiness.
- PR metadata readiness.
- Allowed-files guard readiness.
- Sandbox validation readiness.
- Phase 2 CLI skeleton readiness.
- Safety field preservation readiness.
- Owner gate readiness.
- Implementation prohibition readiness.

## Result Shape

A future readiness audit result should be structured enough for humans and later tooling to inspect. A conceptual result should include:

- `schema_version`: version of this readiness audit result contract.
- `checked_at`: when the audit was performed.
- `source_of_truth`: which local, authenticated GitHub, public GitHub, user-reported, or unknown sources were used.
- `phase_target`: the target being audited.
- `audit_scope`: documents, repository state, and policy surfaces checked.
- `inputs_checked`: required inputs and their checked, skipped, unavailable, or unknown status.
- `readiness_dimensions`: per-dimension result, evidence, and gap list.
- `blocking_gaps`: gaps that prevent proceeding.
- `non_blocking_gaps`: gaps that should be tracked but do not block the target.
- `owner_decisions_required`: decisions needed before proceeding.
- `stop_state`: active `STOPPED_*` code when the audit is stopped.
- `risk`: risk tier and owner gates.
- `safety_fields`: safety-critical fields preserved from task, plan, validation, status, PR metadata, or allowed-files data.
- `unknowns`: facts that were not checked or could not be verified.
- `warnings`: non-blocking cautions.
- `status`: audit status.
- `recommended_next_action`: next owner or Codex action.

## Status Values

Conceptual status values are:

- `ready`: the target may proceed after required owner approval.
- `not_ready`: blocking gaps remain, but no stop condition is active.
- `blocked`: the target depends on an unresolved prerequisite or owner gate.
- `unknown`: required evidence was unavailable or not checked.
- `owner_decision_required`: the next step requires explicit owner decision.
- `stopped`: an active stop condition applies.

These status values are not new `STOPPED_*` codes. Specific stop reasons remain owned by the [Stop-State Registry](STOP_STATE_REGISTRY.md).

## Phase Target Semantics

The audit should distinguish these targets:

- `phase_1_sandbox_validation_ready`: policy and contracts are ready for owner-approved sandbox validation planning or execution.
- `phase_2_cli_skeleton_ready`: policy and contracts are ready for owner-approved local CLI skeleton planning or implementation.
- `not_ready_for_implementation`: docs-first policy requires more contract work before implementation starts.
- `owner_decision_required`: readiness depends on an owner gate that cannot be resolved by Codex alone.

Readiness for sandbox validation does not automatically approve sandbox repository creation. Readiness for Phase 2 planning does not automatically approve CLI implementation.

## Pass Criteria

The audit may pass only when:

- Core docs exist and are linked or discoverable.
- No unresolved contradictions remain across operational policy surfaces.
- The solution lookup protocol exists and is referenced where required.
- The stop-state registry covers active `STOPPED_*` references.
- Task, plan, validation, status, PR metadata, and allowed-files contracts preserve safety fields.
- Sandbox validation criteria are clear before sandbox repository creation.
- The Phase 2 CLI skeleton contract is clear before implementation.
- Owner gates are explicit.
- Prohibited implementation, workflow, automation, GitHub write, branch cleanup, sandbox creation, trading, credential, risk cap, and model promotion actions remain blocked until explicitly in scope.

## Blocking Gaps

Examples of blocking gaps include:

- Source-of-truth state cannot be verified.
- A required core doc is missing.
- Approval, merge, or owner-gate policy contradicts another operational surface.
- Stop-state registry references do not match active `STOPPED_*` usage.
- A safety field is dropped from a transformation contract.
- Required solution lookup is missing before planning.
- PR metadata requirements omit `Self-review result` or `Confirmations`.
- Allowed-files guard examples misalign `status`, `stop_state`, reason, and `recommended_next_action`.
- Sandbox validation criteria are unclear before sandbox repository creation.
- Phase 2 CLI skeleton work would require unapproved GitHub write automation or workflow changes.

## Owner Decision Model

Owner decision categories include:

- Approve proceeding to sandbox repository creation planning.
- Approve a sandbox validation task.
- Approve Phase 2 CLI skeleton planning only.
- Keep the docs-first hard stop.
- Resolve a policy contradiction.
- Defer implementation.
- Stop and revalidate source of truth.

Owner decisions must remain visible in the audit result. Codex must not convert owner gates into implied approval.

## STOPPED Handling

`STOPPED` is a lifecycle interruption. Specific stop reasons must use the [Stop-State Registry](STOP_STATE_REGISTRY.md).

Do not introduce new `STOPPED_*` codes unless necessary. If a new stop code is unavoidable, update the registry and every relevant local Stop States section in the same PR. If shared policy is affected, update [Risk Policy](RISK_POLICY.md).

If the readiness audit is stopped, preserve the interrupted lifecycle state when known. After the stop reason is resolved, return to the interrupted state only if that state remains valid and required checks still pass. If not, return to the earliest lifecycle state needed to revalidate changed assumptions.

## Safety Field Preservation

If the readiness audit summarizes or transforms task, plan, status, validation, PR metadata, or allowed-files data, it must preserve:

- `forbidden_files`.
- `forbidden_actions`.
- Scope.
- Allowed files.
- Validation plan.
- Stop states.
- Risk tier.
- Owner gates.

Dropping safety-critical fields is a stop condition.

## Example Audit Results

### Docs-First Repo Not Ready

```yaml
status: not_ready
phase_target: phase_1_sandbox_validation_ready
blocking_gaps:
  - owner_gate_policy_conflicts_with_merge_policy
  - sandbox_validation_criteria_unclear
recommended_next_action: resolve_policy_contradictions_before_sandbox_validation
```

### Phase 1 Planning Ready, Sandbox Creation Still Gated

```yaml
status: owner_decision_required
phase_target: phase_1_sandbox_validation_ready
readiness_dimensions:
  cross_document_consistency: ready
  sandbox_validation: ready_for_planning
owner_decisions_required:
  - approve_sandbox_repo_creation_planning
recommended_next_action: request_owner_decision_before_creating_or_connecting_sandbox_repo
```

### Phase 2 CLI Skeleton Blocked

```yaml
status: blocked
phase_target: phase_2_cli_skeleton_ready
blocking_gaps:
  - github_write_automation_boundary_not_approved
  - workflow_boundary_not_approved
recommended_next_action: keep_docs_first_hard_stop_until_owner_approves_phase_2_scope
```

### Audit Stopped: Source of Truth Unclear

```yaml
status: stopped
phase_target: phase_1_sandbox_validation_ready
stop_state:
  code: STOPPED_SOURCE_OF_TRUTH_UNCLEAR
  reason: repo_or_main_state_not_verified
lifecycle:
  interrupted_state: LOCAL_REVALIDATION
recommended_next_action: stop_and_revalidate_local_repo_remote_branch_and_main_state
```

## Relationship to Existing Contracts

The [Roadmap](ROADMAP.md) defines phase ordering and implementation boundaries.

The [Operating Model](OPERATING_MODEL.md) defines task intake, source-of-truth revalidation, owner gates, PR lifecycle, and cleanup rules.

The [Risk Policy](RISK_POLICY.md) defines risk tiers, owner gates, and forbidden actions.

The [Acceptance Tests](ACCEPTANCE_TESTS.md) define docs-only, sandbox, metadata, solution lookup, hidden Unicode, and no-implementation checks.

The [Sandbox Validation](SANDBOX_VALIDATION.md) plan defines the first low-risk validation loop that must remain owner-approved and separate from trading repository integration.

The [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md) defines what future sandbox validation runs must record before their pass, fail, blocked, unknown, owner-decision, or stopped result is accepted.

The [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md) defines future local command surfaces but does not approve implementation.

The [Task Contract](TASK_CONTRACT.md) and [Local Task Format Contract](LOCAL_TASK_FORMAT.md) define the task fields the audit may inspect.

The [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md), [Task Validation Result Contract](TASK_VALIDATION_RESULT.md), and [Factory Status Result Contract](FACTORY_STATUS_RESULT.md) define future planning, validation, and status result surfaces the audit may summarize.

The [PR Metadata Guard Contract](PR_METADATA_GUARD.md) and [Allowed-Files Guard Result Contract](ALLOWED_FILES_GUARD.md) define metadata and changed-file boundary checks that feed readiness.

The [Task Lifecycle State Model](TASK_LIFECYCLE.md) defines lifecycle states, stopped-state recovery, merge boundaries, cleanup boundaries, and lesson-capture boundaries.

The [Stop-State Registry](STOP_STATE_REGISTRY.md) owns active `STOPPED_*` codes.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) and [Compound Knowledge Base](solutions/README.md) define how durable lessons are found and applied before planning, before commit, and during review-fix loops.
