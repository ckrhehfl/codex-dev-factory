# Codex Dev Factory

This repository is the control-plane candidate for a Codex-first, autonomous-by-default development factory.

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

## Documents

- [Vision](docs/VISION.md)
- [Task Contract](docs/TASK_CONTRACT.md)
- [Local Task Format](docs/LOCAL_TASK_FORMAT.md)
- [Task Validation Result](docs/TASK_VALIDATION_RESULT.md)
- [Plan Output Contract](docs/PLAN_OUTPUT_CONTRACT.md)
- [Phase 2 CLI Skeleton](docs/PHASE2_CLI_SKELETON.md)
- [Operating Model](docs/OPERATING_MODEL.md)
- [Risk Policy](docs/RISK_POLICY.md)
- [Acceptance Tests](docs/ACCEPTANCE_TESTS.md)
- [Sandbox Validation](docs/SANDBOX_VALIDATION.md)
- [Compound Knowledge Base](docs/solutions/README.md)
- [Roadmap](docs/ROADMAP.md)
