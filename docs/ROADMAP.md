# Roadmap

## Phase 0: Direction Confirmation

Confirm that this repository is the local control-plane candidate for the Codex-first development factory. Revalidate any assumed source of truth before using it.

## Phase 1: Docs-First Foundation

Create the initial documentation set: vision, operating model, risk policy, acceptance tests, and roadmap. Prove that the project can stay inside explicit allowed-file boundaries.

Define the task contract and PR metadata standard so low-risk docs-only tasks can proceed after self-review without a second commit approval when explicitly allowed.

Document the GitHub operating policy before adding implementation: repository settings, branch protection, merge preferences, required-check timing, and post-merge cleanup rules.

Define the sandbox validation plan before adding automation. The candidate sandbox repository is `codex-dev-factory-sandbox`, with a candidate local clone path of `C:\Dev\codex-dev-factory-sandbox`.

Add a docs-only Compound knowledge base for durable post-merge lessons. Lesson capture remains advisory and reviewed through normal docs-only PRs before it becomes repository guidance.

Define a solution lookup protocol so future policy and documentation tasks consult `docs/solutions/**` before planning and before commit.

Define the task lifecycle state model so owner intent, task contract, branch work, PR creation, review-fix loop, merge, cleanup, and lesson handling share one canonical docs-only lifecycle.

## Phase 2: Local CLI Skeleton

After owner approval, design a local CLI skeleton. This phase should still avoid external writes and should begin with a plan before implementation.

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

Trading repository integration must not begin until sandbox validation has completed and the owner approves a separate high-risk scope.
