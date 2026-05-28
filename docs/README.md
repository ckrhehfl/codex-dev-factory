# Documentation Map

This file is an evergreen map for `docs/`.

It does not move files or change policy. Point-in-time evidence and audit docs are not primary policy unless they explicitly say so and are supported by current canonical docs.

## How to Use This Map

- Start with strategy and direction docs for why the control-plane exists and where it is going.
- Use policy, lifecycle, and contract docs for rules, owner gates, source-of-truth handling, and stop behavior.
- Use architecture and evaluation docs for design intent, role boundaries, and runtime/tooling questions.
- Use runbooks and evidence templates for how future validation should be planned or reported.
- Use [Compound Knowledge Base](solutions/README.md) for durable lessons from review-fix loops and post-merge learning.

## Strategy and Direction

- [Vision](VISION.md)
- [Roadmap](ROADMAP.md)
- [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md)
- [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md)

## Operating Policies

- [Operating Model](OPERATING_MODEL.md)
- [Risk Policy](RISK_POLICY.md)
- [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md)
- [Stop-State Registry](STOP_STATE_REGISTRY.md)
- [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md)

## Task Contracts and Result Schemas

- [Task Contract](TASK_CONTRACT.md)
- [Task Lifecycle](TASK_LIFECYCLE.md)
- [Local Task Format](LOCAL_TASK_FORMAT.md)
- [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md)
- [Task Validation Result](TASK_VALIDATION_RESULT.md)
- [Factory Status Result](FACTORY_STATUS_RESULT.md)
- [PR Metadata Guard](PR_METADATA_GUARD.md)
- [Allowed-Files Guard](ALLOWED_FILES_GUARD.md)
- [Acceptance Tests](ACCEPTANCE_TESTS.md)
- [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md)

## Architecture and Boundaries

- [Codex Multi-Agent Architecture](CODEX_MULTI_AGENT_ARCHITECTURE.md)
- [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md)
- [Hermes-Codex Compatibility Matrix](HERMES_CODEX_COMPATIBILITY_MATRIX.md)
- [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md)
- [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md)
- [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md)
- [Sandbox Repository Initial Fixture](SANDBOX_REPOSITORY_INITIAL_FIXTURE.md)

## Hermes Evaluation

- [Hermes Runtime Evaluation Plan](HERMES_RUNTIME_EVALUATION_PLAN.md)
- [Hermes Evaluation Acceptance Criteria](HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md)
- [Hermes Evaluation Evidence Template](HERMES_EVALUATION_EVIDENCE_TEMPLATE.md)
- [Hermes Sandbox Validation Runbook](HERMES_SANDBOX_VALIDATION_RUNBOOK.md)

## Sandbox, Worktree, and Validation

- [Sandbox Validation](SANDBOX_VALIDATION.md)
- [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md)
- [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md)
- [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md)
- [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md)
- [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md)
- [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md)
- [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md)
- [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md)

## Evidence, Audits, and Point-in-Time Records

These docs record evidence, audit findings, owner decisions, or historical state. They may become stale and should not be treated as primary policy without revalidation against current canonical docs.

- [Documentation Inventory Audit](DOCUMENTATION_INVENTORY_AUDIT.md)
- [Phase Readiness Audit Result](PHASE_READINESS_AUDIT_RESULT.md)
- [Sandbox Repository Creation Evidence](SANDBOX_REPOSITORY_CREATION_EVIDENCE.md)
- [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md)
- [Sandbox Validation Run 001](SANDBOX_VALIDATION_RUN_001.md)
- [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md)

## Durable Lessons

- [Compound Knowledge Base](solutions/README.md)

`docs/solutions/**` is the durable lesson knowledge base. It stores reviewed lessons from completed work, review-fix loops, and post-merge lesson capture. Compound output remains advisory until represented in reviewed repository docs.

## Intentional Duplication

Repeated owner-gate, credential, source-of-truth, merge/cleanup, sandbox/input, trading/risk, Hermes-not-adopted, and Ollama-retirement language is intentional defense-in-depth. Do not mechanically deduplicate those rules without a specific policy review that preserves every affected safety surface.

## Folderization Guidance

Do not move root-level docs yet.

Future folderization requires link-impact planning before files move. Candidate future folders may include:

- `strategy/`
- `architecture/`
- `policies/`
- `contracts/`
- `runbooks/`
- `evidence/`
- `audits/`
- `solutions/`

`docs/solutions/**` remains as-is.

## Current Placement Rule

New docs may still be added at root when they are active policy, architecture, contract, runbook, or evidence-map surfaces and no folderization plan has been approved.

Do not move [Hermes-Codex Compatibility Matrix](HERMES_CODEX_COMPATIBILITY_MATRIX.md) yet.

Do not move root-level docs until a separate migration plan is approved.
