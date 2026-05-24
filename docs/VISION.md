# Vision

## Definition

A Codex-first autonomous-by-default development factory is a development control plane where Codex is the default executor for low-risk engineering tasks, while the owner remains the decision maker for high-risk changes.

The factory should make routine work easier to delegate without lowering quality gates. It should produce clear scopes, isolated branches, bounded changes, visible diffs, validation evidence, and explicit escalation points.

## Low-Risk Work Automation Goal

The first useful target is low-risk work automation: documentation updates, local scaffolding, cleanup proposals, acceptance checklists, and other changes that are easy to inspect and reverse.

Low-risk work should still be deliberate. Every task needs a stated scope, non-goals, allowed files, validation plan, and stop conditions before it is treated as eligible for autonomous execution.

## High-Risk Owner Decision Model

High-risk work requires owner decisions before execution. Codex may gather context, summarize options, draft plans, or prepare review material, but it must stop before making irreversible, externally visible, or safety-sensitive changes.

Owner decisions are required for GitHub writes, repository connection, automation activation, changes to trading-related systems, credential handling, production-impacting behavior, merges, and branch deletion.

## Sandbox-First Validation

The factory should prove itself in a sandbox before it touches important repositories or external systems. The sandbox phase validates local behavior first: branch creation, docs-only changes, allowed-file checks, diff review, and owner approval gates.

Only after the docs-first workflow is boring, repeatable, and inspectable should the project consider adding local CLI structure, worktree handling, Codex worker connection, publishing, monitoring, or bounded fix loops.
