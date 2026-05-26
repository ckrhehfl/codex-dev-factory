# Roadmap

## Phase 0: Direction Confirmation

Confirm that this repository is the local control-plane candidate for the Codex-first development factory. Revalidate any assumed source of truth before using it.

## Phase 1: Docs-First Foundation

Create the initial documentation set: vision, operating model, risk policy, acceptance tests, and roadmap. Prove that the project can stay inside explicit allowed-file boundaries.

Define the task contract and PR metadata standard so low-risk docs-only tasks can proceed after self-review without a second commit approval when explicitly allowed.

Document the GitHub operating policy before adding implementation: repository settings, branch protection, merge preferences, required-check timing, and post-merge cleanup rules.

Define the sandbox validation plan before adding automation. The candidate sandbox repository is `codex-dev-factory-sandbox`, with a candidate local clone path of `C:\Dev\codex-dev-factory-sandbox`.

Define the sandbox validation evidence contract before creating a sandbox repo or running validation, so future attempts record source-of-truth, PR, review, merge, cleanup, guard, lesson, owner-decision, and unknown state consistently.

Add a docs-only Compound knowledge base for durable post-merge lessons. Lesson capture remains advisory and reviewed through normal docs-only PRs before it becomes repository guidance.

Define a solution lookup protocol so future policy and documentation tasks consult `docs/solutions/**` before planning and before commit.

Define the task lifecycle state model so owner intent, task contract, branch work, PR creation, review-fix loop, merge, cleanup, and lesson handling share one canonical docs-only lifecycle.

Define the Phase 1/2 readiness audit so sandbox validation and later Phase 2 CLI skeleton work proceed only after core docs, contracts, policy surfaces, owner gates, and safety-field preservation are evidence-checked.

Maintain a documentation inventory and policy surface consistency audit before readiness, sandbox planning, or implementation work so the documentation set stays discoverable, non-duplicative, and aligned with active solution lessons.

Record Phase 1/2 readiness audit results as docs-only evidence before requesting owner approval for sandbox repository creation planning or any later implementation step.

Plan sandbox repository creation through the [Sandbox Repository Creation Plan](SANDBOX_REPOSITORY_CREATION_PLAN.md) as a separate docs-only owner-decision checklist before creating `codex-dev-factory-sandbox` or any sandbox repository.

Define the [Sandbox Repository Creation Runbook](SANDBOX_REPOSITORY_CREATION_RUNBOOK.md) before any creation task so the future task has a bounded procedure, evidence requirements, result contract, and stop conditions.

Record sandbox repository owner decisions in [Sandbox Repository Owner Decisions](SANDBOX_REPOSITORY_OWNER_DECISIONS.md) before any future task creates or reuses the sandbox repository.

Define the [Sandbox Repository Initial Fixture Contract](SANDBOX_REPOSITORY_INITIAL_FIXTURE.md) before any future creation task adds initial sandbox content, so the fixture remains docs-only, minimal, and separate from actual sandbox validation.

Record sandbox repository creation evidence in [Sandbox Repository Creation Evidence](SANDBOX_REPOSITORY_CREATION_EVIDENCE.md) after an owner-authorized setup task completes, so future tasks can rely on reviewed evidence instead of chat history.

Record the first sandbox docs-only PR validation evidence in [Sandbox Validation Run 001 Evidence](SANDBOX_VALIDATION_RUN_001.md) after sandbox PR #1 is merged and verified, so future tasks can inspect the sandbox PR, merge, cleanup, and remaining unknowns without relying on chat history.

## Phase 2: Local CLI Skeleton

After owner approval and a passed [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md), design a local CLI skeleton. This phase should still avoid external writes and should begin with a plan before implementation.

Any future CLI task format should be derived from the task contract rather than invented separately.

The Phase 2 CLI skeleton contract defines future command surfaces for `factory task validate`, `factory task plan`, and `factory status`. The contract is docs-only until implementation is separately approved.

The local task format contract defines the future serialized representation of task contract fields. It remains docs-only until schemas, parsers, and CLI commands are separately approved.

The task validation result contract defines the future result of `factory task validate`. It must report task completeness, risk tier, owner gates, stop conditions, allowed files, forbidden files, and forbidden actions before any implementation is approved.

The plan output contract defines the future result of `factory task plan`. It must preserve allowed files, forbidden files, forbidden actions, validation plan, stop conditions, risk tier, and owner gates before any implementation is approved.

The factory status result contract defines the future result of `factory status`. It must report local repo, task, lifecycle, PR, validation, unknown, stop, risk, safety-field, and owner-action state before any implementation is approved.

The PR metadata guard contract defines future checks for PR title/body completeness, required metadata sections, source-of-truth reporting, solution lookup reporting, validation reporting, risk tier, stop conditions, safety fields, and owner-controlled merge notes before any implementation is approved.

The allowed-files guard contract defines future checks for changed files against allowed files, forbidden files, forbidden actions, task scope, validation plan, risk tier, stop conditions, and owner gates before any implementation is approved.

## Phase 3: Worktree Harness

Design isolated worktree handling for future task execution. This phase must preserve branch safety and avoid branch deletion automation until separately approved.

Define the [Worktree Harness MVP Boundary](WORKTREE_HARNESS_MVP_BOUNDARY.md) before implementation so repo/path verification, branch ownership, safety-field preservation, evidence capture, stop/report behavior, and owner decisions are clear.

Define the [Worktree Harness Result Contract](WORKTREE_HARNESS_RESULT_CONTRACT.md) before implementation so future harness outcomes report required fields, evidence classification, stop/report behavior, safety-field preservation, validation results, owner gates, cleanup state, and remaining unknowns consistently.

Define the [Harness Branch Naming and Ownership Policy](HARNESS_BRANCH_NAMING_AND_OWNERSHIP_POLICY.md) before implementation so future task branches, branch ownership evidence, worktree ownership evidence, ambiguity handling, conflict handling, and cleanup boundaries are explicit.

Define the [Worktree Retention Policy](WORKTREE_RETENTION_POLICY.md) before implementation so active, completed, stale, dirty, ambiguous, foreign-repo, and owner-gated worktrees are handled report-first without authorizing deletion, pruning, cleanup automation, or retention enforcement.

Define the [Worktree Harness Branch Ownership Result Examples](WORKTREE_HARNESS_BRANCH_OWNERSHIP_RESULT_EXAMPLES.md) before implementation so successful, stopped, ambiguous, dirty, foreign-repo, protected-branch, conflict, and owner-gated cleanup reports preserve ownership evidence, evidence classes, safety fields, and cleanup boundaries.

Define the [Worktree Harness Result Validation Checklist](WORKTREE_HARNESS_RESULT_VALIDATION_CHECKLIST.md) before implementation so future result reports and examples can be reviewed for safety-field preservation, evidence classification, stop-state alignment, owner gates, cleanup boundaries, and cross-document consistency without adding executable validation.

Define the [Worktree Harness Status Summary Format](WORKTREE_HARNESS_STATUS_SUMMARY_FORMAT.md) before implementation so future harness runs can report repo identity, branch/worktree ownership, lifecycle/status, validation checklist outcome, cleanup boundaries, owner gates, and remaining `확인 필요` without adding executable status tooling.

## Phase 4: Codex Worker Connection

Connect Codex execution only after the docs-first and local harness phases are accepted. The worker should inherit the risk policy, allowed-file checks, and owner gates.

Worker connection must wait until the sandbox validation loop has proven docs-only PR creation, merge verification, remote branch cleanup, local cleanup, and lesson-check decisions.

## Phase 5: Publisher MVP

Design a minimal publisher path for owner-approved PR creation. Publishing must remain explicit and auditable.

## Phase 6: Check Monitor

Add read-oriented monitoring for proposal status after publisher behavior is approved. Monitoring should not merge or mutate branches by default.

## Phase 7: Auto-Merge Eligibility

Define narrow eligibility rules for any future merge automation. This phase requires owner approval and strong safeguards before implementation.

Required checks should be enabled only after real checks or workflows exist and have been sandbox-proven.

## Phase 8: Branch Cleanup

Design cleanup policy for stale local and remote branches. No cleanup implementation should be added before the owner approves the policy and timing.

Local cleanup should remain a human-approved post-merge prompt until branch cleanup automation is separately designed, sandbox-proven, and approved.

## Phase 9: Bounded Fix Loop

Explore a limited fix loop for failed checks. The loop must have iteration caps, stop conditions, and owner-visible evidence.

## Phase 10: Discord Read-Only Projection

Consider a read-only Discord projection for status visibility. It must not accept commands or perform writes in its first form.

## Phase 11: Trading Base Deep Research

Research lessons from trading-related repositories and workflows without treating any existing repository as source of truth. This phase is research only until the owner explicitly approves a separate scope.

Map external Deep Research recommendations through [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) before treating any recommendation as adopted repository policy, technical stack direction, or implementation authorization.

Classify Codex automation technical-stack components through [Technical Stack Decision Record](TECH_STACK_DECISION_RECORD.md) before implementation planning treats any component as adopted, deferred, reference-only, rejected, or requiring owner decision.

Trading repository integration must not begin until sandbox validation has completed and the owner approves a separate high-risk scope.
