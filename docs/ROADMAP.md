# Roadmap

## Phase 0: Direction Confirmation

Confirm that this repository is the local control-plane candidate for the Codex-first development factory. Revalidate any assumed source of truth before using it.

## Phase 1: Docs-First Foundation

Create the initial documentation set: vision, operating model, risk policy, acceptance tests, and roadmap. Prove that the project can stay inside explicit allowed-file boundaries.

## Phase 2: Local CLI Skeleton

After owner approval, design a local CLI skeleton. This phase should still avoid external writes and should begin with a plan before implementation.

## Phase 3: Worktree Harness

Design isolated worktree handling for future task execution. This phase must preserve branch safety and avoid branch deletion automation until separately approved.

## Phase 4: Codex Worker Connection

Connect Codex execution only after the docs-first and local harness phases are accepted. The worker should inherit the risk policy, allowed-file checks, and owner gates.

## Phase 5: Publisher MVP

Design a minimal publisher path for owner-approved PR creation. Publishing must remain explicit and auditable.

## Phase 6: Check Monitor

Add read-oriented monitoring for proposal status after publisher behavior is approved. Monitoring should not merge or mutate branches by default.

## Phase 7: Auto-Merge Eligibility

Define narrow eligibility rules for any future merge automation. This phase requires owner approval and strong safeguards before implementation.

## Phase 8: Branch Cleanup

Design cleanup policy for stale local and remote branches. No cleanup implementation should be added before the owner approves the policy and timing.

## Phase 9: Bounded Fix Loop

Explore a limited fix loop for failed checks. The loop must have iteration caps, stop conditions, and owner-visible evidence.

## Phase 10: Discord Read-Only Projection

Consider a read-only Discord projection for status visibility. It must not accept commands or perform writes in its first form.

## Phase 11: Trading Base Deep Research

Research lessons from trading-related repositories and workflows without treating any existing repository as source of truth. This phase is research only until the owner explicitly approves a separate scope.
