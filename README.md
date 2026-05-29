# Codex Dev Factory

This repository is the control-plane candidate for a Codex-first, autonomous-by-default development factory.

Current strategic direction: Codex-primary multi-agent completion is the primary completion path. The Ollama/local-model provider path is retired unless explicitly reopened by the owner. Hermes remains an active conditional runtime/tooling/orchestration evaluation candidate for Codex-primary workflows, but Hermes setup, configuration, authentication, execution, and sandbox validation still require future owner-approved gates. Ollama cleanup state, if referenced, remains user-reported unless revalidated in a separate approved task.

The [Codex Multi-Agent Architecture](docs/CODEX_MULTI_AGENT_ARCHITECTURE.md) records the planning/control-plane guidance for future multi-agent coordination. It does not approve worker execution, implementation, merge, cleanup, rollback, credentials, providers, workflow changes, or sandbox mutation.

The initial phase is docs-first only. The goal is to validate local, docs-only operating discipline before connecting the factory to any implementation repository, automation system, or publishing path.

Early validation will focus on low-risk documentation changes: clear scope, allowed files, validation checks, owner decision points, and stop states. No workflow, worker, publisher, bot, branch cleanup automation, or product implementation belongs in this phase.

The existing `ckrhehfl/institutional-futures-trader` repository is only a reference and lessons candidate. It is not the source of truth for this repository, its roadmap, or its operating model unless explicitly revalidated and approved by the owner.

## Current Scope

- Docs-first local initialization.
- Branch-based proposal workflow.
- Task-contract approval gates for commit, push, and PR creation.
- Explicit owner approval before merge or branch deletion.
- Sandbox-first validation before any connection to external repositories or higher-risk systems.
- Durable post-merge lessons captured as docs-only knowledge base entries.

## Codex CLI Launch Rule

- Use `cdfcheck` for read-only readiness or status checks.
- Use `cdfcodex` for normal bounded Codex work after readiness passes.
- Default Codex Intelligence is `medium/default`.
- PM/ChatGPT must explicitly tell the owner which command to run.
- High or xhigh intelligence, API keys, GitHub secrets, Full Access, `danger-full-access`, `--yolo`, auto-merge, and branch cleanup automation require separate explicit owner approval.

## Documents

- [Vision](docs/VISION.md)
- [Task Contract](docs/TASK_CONTRACT.md)
- [Task Lifecycle](docs/TASK_LIFECYCLE.md)
- [Stop-State Registry](docs/STOP_STATE_REGISTRY.md)
- [Local Task Format](docs/LOCAL_TASK_FORMAT.md)
- [Task Validation Result](docs/TASK_VALIDATION_RESULT.md)
- [Plan Output Contract](docs/PLAN_OUTPUT_CONTRACT.md)
- [Factory Status Result](docs/FACTORY_STATUS_RESULT.md)
- [PR Metadata Guard](docs/PR_METADATA_GUARD.md)
- [Allowed-Files Guard](docs/ALLOWED_FILES_GUARD.md)
- [Documentation Inventory Audit](docs/DOCUMENTATION_INVENTORY_AUDIT.md)
- [Phase 1/2 Readiness Audit](docs/PHASE_READINESS_AUDIT.md)
- [Phase 1/2 Readiness Audit Result](docs/PHASE_READINESS_AUDIT_RESULT.md)
- [Phase 2 CLI Skeleton](docs/PHASE2_CLI_SKELETON.md)
- [Operating Model](docs/OPERATING_MODEL.md)
- [Risk Policy](docs/RISK_POLICY.md)
- [Acceptance Tests](docs/ACCEPTANCE_TESTS.md)
- [GitHub Operating Policy](docs/GITHUB_OPERATING_POLICY.md)
- [Sandbox Repository Owner Decisions](docs/SANDBOX_REPOSITORY_OWNER_DECISIONS.md)
- [Sandbox Repository Initial Fixture](docs/SANDBOX_REPOSITORY_INITIAL_FIXTURE.md)
- [Sandbox Repository Creation Plan](docs/SANDBOX_REPOSITORY_CREATION_PLAN.md)
- [Sandbox Repository Creation Runbook](docs/SANDBOX_REPOSITORY_CREATION_RUNBOOK.md)
- [Sandbox Repository Creation Evidence](docs/SANDBOX_REPOSITORY_CREATION_EVIDENCE.md)
- [Sandbox Validation](docs/SANDBOX_VALIDATION.md)
- [Sandbox Validation Evidence](docs/SANDBOX_VALIDATION_EVIDENCE.md)
- [Sandbox Validation Run 001 Evidence](docs/SANDBOX_VALIDATION_RUN_001.md)
- [Deep Research Intake and Traceability](docs/DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md)
- [Technical Stack Decision Record](docs/TECH_STACK_DECISION_RECORD.md)
- [Codex Multi-Agent Architecture](docs/CODEX_MULTI_AGENT_ARCHITECTURE.md)
- [Worktree Harness MVP Boundary](docs/WORKTREE_HARNESS_MVP_BOUNDARY.md)
- [Worktree Harness Result Contract](docs/WORKTREE_HARNESS_RESULT_CONTRACT.md)
- [Harness Branch Naming and Ownership Policy](docs/HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md)
- [Worktree Retention Policy](docs/WORKTREE_RETENTION_POLICY.md)
- [Worktree Harness Branch Ownership Result Examples](docs/WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md)
- [Worktree Harness Result Validation Checklist](docs/WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md)
- [Worktree Harness Status Summary Format](docs/WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md)
- [Codex Worker Boundary](docs/CODEX_WORKER_BOUNDARY.md)
- [OMX Local Loop MVP](docs/OMX_LOCAL_LOOP_MVP.md)
- [OMX Status Adapter Contract](docs/OMX_STATUS_ADAPTER_CONTRACT.md)
- [Hermes Runtime Evaluation Plan](docs/HERMES_RUNTIME_EVALUATION_PLAN.md)
- [Hermes Evaluation Acceptance Criteria](docs/HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md)
- [Hermes Evaluation Evidence Template](docs/HERMES_EVALUATION_EVIDENCE_TEMPLATE.md)
- [Hermes Sandbox Validation Runbook](docs/HERMES_SANDBOX_VALIDATION_RUNBOOK.md)
- [Compound Knowledge Base](docs/solutions/README.md)
- [Solution Lookup Protocol](docs/SOLUTION_LOOKUP_PROTOCOL.md)
- [Roadmap](docs/ROADMAP.md)
