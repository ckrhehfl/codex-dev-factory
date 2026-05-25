# Documentation Inventory and Policy Surface Consistency Audit

## Purpose

This document audits the current documentation inventory and operational policy surfaces for discoverability, duplication, consistency, and active lesson alignment.

It is an audit document only. It does not run the [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md), create a sandbox repository, run sandbox validation, implement CLI behavior, create workflows, perform GitHub writes, implement branch cleanup automation, add Discord integration, or touch trading functionality.

## Source-of-Truth Status

This audit was prepared from local repository state after source-of-truth revalidation:

- Local path checked: `C:\Dev\codex-dev-factory`.
- Remote checked: `https://github.com/ckrhehfl/codex-dev-factory.git`.
- Branch baseline checked: `main`.
- Latest verified baseline: `05c82cf` (`Merge pull request #21 from ckrhehfl/docs/pr20-sandbox-evidence-review-lessons`).
- Local `main` was fetched, pruned, and fast-forward checked before the audit branch was created.
- Open PR state was checked through available GitHub CLI tooling and no open PRs were reported.

GitHub settings, branch protection, authenticated-only review state, sandbox repository existence, and any external repository state remain `확인 필요` unless explicitly verified by a later authenticated audit.

## Solution Lookup Result

Solution lookup was performed before planning or editing by reading [AGENTS.md](../AGENTS.md), [Compound Knowledge Base](solutions/README.md), and relevant `docs/solutions/**` entries.

Applicable solution entries:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by checking that solution lookup is treated as pre-planning input and that stopped lifecycle context remains interruptible/resumable only after checks pass.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by checking active `STOPPED_*` references against the central registry and local Stop States sections.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by checking that `Self-review result` and `Confirmations` remain distinct PR metadata surfaces.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by checking that forbidden or out-of-scope file-change examples use stop-state semantics when a stop condition applies.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by checking that stopped sandbox evidence examples preserve `lifecycle_trace.interrupted_state`.

No applicable lesson conflicts with this audit's docs-only scope.

## Inventory Method

The audit inspected the repository documentation set and searched for policy language related to:

- Approval and owner gates.
- Task lifecycle, review-fix, merge, cleanup, and post-merge lesson handling.
- Stop states and `STOPPED_*` references.
- Allowed files, forbidden files, and forbidden actions.
- Task, plan, validation, status, PR metadata, allowed-files, readiness, and evidence contracts.
- Solution lookup and Compound knowledge-base behavior.
- Sandbox validation, sandbox evidence, and Phase 1/2 readiness sequencing.
- Prohibited implementation, workflow, GitHub write, branch cleanup automation, Discord, trading, credential, risk cap, and model-promotion implications.

This audit records consistency findings. It does not certify implementation readiness.

## Core Documentation Inventory

| Document | Role | Operational policy surface |
| --- | --- | --- |
| [README](../README.md) | Repository overview and top-level document index | Yes |
| [AGENTS](../AGENTS.md) | Agent operating instructions and source-of-truth reminders | Yes |
| [Vision](VISION.md) | Product direction and intent | Partial |
| [Roadmap](ROADMAP.md) | Phase sequencing and implementation boundaries | Yes |
| [Operating Model](OPERATING_MODEL.md) | Task intake, source-of-truth checks, owner gates, PR flow, cleanup, lessons | Yes |
| [Risk Policy](RISK_POLICY.md) | Risk tiers, prohibited actions, stop-state policy | Yes |
| [Acceptance Tests](ACCEPTANCE_TESTS.md) | Docs-first acceptance and guard expectations | Yes |
| [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) | Repository settings and GitHub operation boundaries | Yes |
| [Task Contract](TASK_CONTRACT.md) | Canonical task fields, PR metadata expectations, stop conditions | Yes |
| [Local Task Format](LOCAL_TASK_FORMAT.md) | Future serialized task representation | Yes |
| [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md) | Future plan-result fields and safety preservation | Yes |
| [Task Validation Result](TASK_VALIDATION_RESULT.md) | Future task validation result contract | Yes |
| [Factory Status Result](FACTORY_STATUS_RESULT.md) | Future status output contract | Yes |
| [PR Metadata Guard](PR_METADATA_GUARD.md) | Future PR title/body metadata completeness contract | Yes |
| [Allowed-Files Guard](ALLOWED_FILES_GUARD.md) | Future changed-file boundary result contract | Yes |
| [Task Lifecycle](TASK_LIFECYCLE.md) | Canonical lifecycle states and transitions | Yes |
| [Stop-State Registry](STOP_STATE_REGISTRY.md) | Canonical `STOPPED_*` registry | Yes |
| [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) | Required `docs/solutions/**` lookup timing and reporting | Yes |
| [Compound Knowledge Base](solutions/README.md) | Durable post-merge lessons index | Yes |
| [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md) | Future readiness audit contract | Yes |
| [Sandbox Validation](SANDBOX_VALIDATION.md) | Future sandbox validation plan | Yes |
| [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md) | Future sandbox run evidence contract | Yes |
| [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md) | Future local CLI skeleton contract | Yes |
| `docs/solutions/workflow/**` | Durable workflow and policy lessons | Yes |
| `docs/solutions/policy/` | Reserved policy lesson category | Partial |
| `docs/solutions/developer-experience/` | Reserved developer-experience lesson category | Partial |

## Discoverability

Top-level discoverability is adequate when the new audit is linked:

- `README.md` lists the core documents that a new contributor or agent should inspect.
- `AGENTS.md` points agents to the solution lookup protocol and Compound knowledge base.
- `docs/ROADMAP.md` sequences docs-first foundation work before sandbox validation, Phase 2 CLI skeleton work, worker connection, publisher behavior, cleanup automation, Discord, and trading research.
- `docs/solutions/README.md` indexes durable lessons and categories.

Category-only surfaces:

- `docs/solutions/policy/README.md` and `docs/solutions/developer-experience/README.md` are category placeholders. They are discoverable from `docs/solutions/README.md` and do not currently need separate top-level links.

## Duplicate, Stale, or Contradictory Language

No blocking contradiction was found among the audited policy surfaces.

Repeated prohibitions against implementation, workflows, automation, GitHub writes, branch cleanup automation, Discord integration, sandbox repository creation, trading functionality, credentials, risk cap logic, and model promotion logic are intentional defense-in-depth language rather than conflicting duplication.

Historically closed gaps are not treated as open blockers in this audit:

- Required solution lookup before planning is captured in the solution lookup protocol and lifecycle lesson.
- `STOPPED` lifecycle recovery preserves interrupted context when known.
- PR metadata guard completeness includes distinct `Self-review result` and `Confirmations` surfaces.
- Allowed-files guard examples use `status: stopped` when an active stop condition applies.
- Sandbox validation evidence stopped examples preserve `lifecycle_trace.interrupted_state`.

Those items remain active self-review checks for future work, but this audit does not list them as unresolved gaps.

## Stop-State Registry Alignment

Active `STOPPED_*` references are governed by [Stop-State Registry](STOP_STATE_REGISTRY.md). This audit adds no new stop codes.

Consistency expectations found across the docs:

- New or changed `STOPPED_*` codes must be added to the registry first or in the same PR.
- Relevant local Stop States sections must match the registry when they list active stop codes.
- Shared risk or policy stop states must remain reflected in [Risk Policy](RISK_POLICY.md).
- Stop-state examples should align `status`, `stop_state`, reason, interrupted lifecycle context when present, and `recommended_next_action`.

No registry-backed stop-state drift was found in the repository-wide `STOPPED_*` comparison run for this audit. Repository-wide comparison should remain part of future readiness and validation tasks.

## Safety Field Preservation

The audited contracts consistently preserve the safety-critical fields that must survive task, plan, validation, status, PR metadata, allowed-files, readiness, and evidence transformations:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop states.
- Risk tier.
- Owner gates.

No audited policy surface intentionally drops `forbidden_files` or `forbidden_actions` while preserving only allowed-file information.

## PR Metadata Requirements

PR metadata requirements are aligned across the task contract, acceptance tests, operating model, plan output contract, validation/result contracts, factory status result, and PR metadata guard.

The following surfaces must remain distinct:

- `Self-review result`: evidence that Codex checked task scope, allowed files, validations, stop conditions, and safety fields before commit, push, and PR creation.
- `Confirmations`: explicit task-specific statements that the PR stayed docs-only and did not implement prohibited behavior.

These should not be collapsed into generic validation, risk, non-goals, or owner-gate sections.

## Allowed-Files Guard Semantics

The allowed-files guard contract and active lesson agree that forbidden or out-of-scope file changes are not merely ordinary validation failures when an existing stop condition applies.

Expected semantics:

- Use `status: stopped` for file-boundary violations that trigger a stop condition.
- Preserve a registry-backed code such as `STOPPED_FORBIDDEN_FILE_CHANGE` when applicable.
- Recommend removing the unsafe file change or stopping for owner decision.
- Align `status`, `stop_state`, reason, and `recommended_next_action`.

This audit does not introduce new allowed-files examples.

## Sandbox Evidence Structure

The sandbox validation evidence contract and active lesson agree that stopped evidence examples must preserve interrupted lifecycle context under the canonical evidence packet shape.

Expected stopped-run structure:

- Use `status: stopped` when a stop condition applies.
- Preserve the registry-backed `STOPPED_*` code.
- Preserve known interrupted lifecycle context under `lifecycle_trace.interrupted_state`.
- Align `stop_state.reason` and `recommended_next_action` with the stop code.

This audit does not create evidence from a real sandbox run and does not run sandbox validation.

## Solution Lessons Reflected in Operational Docs

The active solution lessons are reflected in operational policy surfaces:

- Pre-planning solution lookup is reflected in [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Acceptance Tests](ACCEPTANCE_TESTS.md), and [Operating Model](OPERATING_MODEL.md).
- Stop-state consistency is reflected in [Stop-State Registry](STOP_STATE_REGISTRY.md), [Risk Policy](RISK_POLICY.md), and local Stop States sections.
- PR metadata completeness is reflected in [Task Contract](TASK_CONTRACT.md), [Acceptance Tests](ACCEPTANCE_TESTS.md), and [PR Metadata Guard](PR_METADATA_GUARD.md).
- Allowed-files stopped semantics are reflected in [Allowed-Files Guard](ALLOWED_FILES_GUARD.md), [Stop-State Registry](STOP_STATE_REGISTRY.md), and [Acceptance Tests](ACCEPTANCE_TESTS.md).
- Sandbox evidence lifecycle trace structure is reflected in [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md) and related guard/result contracts.

No new durable solution entry is required for this audit.

## Prohibited Implication Check

The audited docs continue to frame the following as prohibited or owner-gated unless separately approved:

- CLI implementation.
- Automation implementation.
- GitHub write automation or PR publisher behavior.
- GitHub Actions or workflow creation.
- Branch cleanup automation.
- Discord integration.
- Sandbox repository creation or actual sandbox validation.
- Trading functionality, trading repository connection, live trading, credentials, risk cap logic, or model promotion logic.

This audit does not authorize any of those activities.

## Audit Result

Audit conclusion: the current documentation set is discoverable enough for docs-first work once this audit is linked, non-duplicative in the policy-critical areas reviewed, and aligned with active solution lessons.

This conclusion is limited to documentation inventory and policy surface consistency. It is not a Phase 1/2 readiness pass, not sandbox validation evidence, and not approval to begin implementation.

## Owner Review Notes / 확인 필요

The following remain `확인 필요` or future-task items:

- GitHub repository settings and branch protection, unless checked by authenticated tooling in a future task.
- Sandbox repository existence and identity, unless owner-approved and verified later.
- Actual readiness result; run [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md) separately before sandbox planning or Phase 2 implementation planning.
- Actual sandbox validation evidence; create it only in a separate owner-approved sandbox validation task.
- Any future implementation, workflow, publisher, cleanup automation, Discord, or trading integration scope.
