# Operating Model

## Task Intake

Every task starts with a short intake record:

- Requested outcome.
- Current source of truth and what still needs revalidation.
- Scope.
- Non-goals.
- Allowed files.
- Validation plan.
- Stop conditions.

If any intake item is missing or ambiguous for a risky task, Codex stops for an owner decision.

## Source-of-Truth Revalidation

No existing repository, branch, PR, issue, local file, or prior conversation is automatically trusted as source of truth.

Before using outside context, Codex must identify what was checked, when it was checked, and whether the owner has approved it as authoritative for the current task.

The `ckrhehfl/institutional-futures-trader` repository is a reference and lessons candidate only until explicitly revalidated.

## Scope, Non-Goals, Allowed Files, Validation Plan

Each task should define:

- Scope: what Codex is allowed to change.
- Non-goals: what Codex must not attempt.
- Allowed files: exact paths or path patterns.
- Validation plan: commands, checks, or review steps that prove the change stayed inside scope.

For docs-first work, allowed files should be narrow and explicit.

Sandbox validation expectations are defined in [Sandbox Validation](SANDBOX_VALIDATION.md). Sandbox tasks must prove the factory can run low-risk docs-only loops before any trading repository integration.

## Risk Tiering

Tasks are grouped by risk:

- Low risk: local documentation changes with explicit allowed files and no external side effects.
- Medium risk: local implementation scaffolding or non-production automation proposals that do not write to external services.
- High risk: external writes, publishing, merges, branch deletion, credential handling, trading-related systems, or production-impacting behavior.

Low-risk tasks can proceed locally when scope is clear. Medium-risk tasks need an approved plan. High-risk tasks require explicit owner decisions before execution.

## Branch Lifecycle

Work should happen on a purpose-named branch. The branch name should describe the proposal and avoid implying merge readiness.

Branch creation is allowed during local setup when requested. Branch deletion is never automatic and requires explicit owner approval.

## PR Lifecycle

PR creation is out of scope for the docs-first initialization.

GitHub repository settings and PR policy are defined in [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md). That policy governs auto-merge settings, automatic remote head branch deletion, squash-only merge preference, branch protection, and required-check timing.

The intended later lifecycle is:

1. Prepare scoped branch.
2. Generate bounded diff.
3. Run acceptance checks.
4. Ask owner for approval.
5. Only after approval, publish a PR with clear scope and validation evidence.

## Post-Merge Lesson Check

After a future merge, the factory should check whether the task produced reusable lessons:

- Was a stop condition useful?
- Did an allowed-file check catch anything?
- Did the scope need tightening?
- Should a policy or checklist be updated?

Lesson capture should remain documentation-only until the owner approves stronger automation.

## Post-Merge Cleanup

After a PR is merged, local branch and worktree cleanup should be performed only through the approved cleanup prompt. GitHub remote head branch deletion is handled by the repository setting for Automatically delete head branches.

Cleanup must never delete `main`, `master`, `develop`, or `release/*`, must never use force delete, and must stop when the worktree is dirty or the target branch is not confirmed merged.

In the sandbox, cleanup verification is part of the first validation loop and must be confirmed before the loop is considered accepted.
