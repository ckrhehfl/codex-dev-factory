# Operating Model

## Task Intake

Every task starts with the [Task Contract](TASK_CONTRACT.md), a short intake record:

- Task title and objective.
- Source-of-truth assumptions and what still needs revalidation.
- Scope.
- Non-goals.
- Allowed files.
- Forbidden files/actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner decision requirements.

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

Solution lookup expectations are defined in [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md). Policy and documentation tasks should consult `docs/solutions/**` during intake, before planning, before commit, and during matching review-fix classification.

Sandbox validation expectations are defined in [Sandbox Validation](SANDBOX_VALIDATION.md). Sandbox tasks must prove the factory can run low-risk docs-only loops before any trading repository integration.

Phase 2 local CLI planning is defined in [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md). The planned CLI may validate and report task state conceptually, but it must not mutate repository or GitHub state until implementation is separately approved.

Future local task representation is defined in [Local Task Format Contract](LOCAL_TASK_FORMAT.md). It serializes the task contract conceptually, but does not replace the task contract as the policy source.

Future validation result output is defined in [Task Validation Result Contract](TASK_VALIDATION_RESULT.md). It may report task completeness conceptually, but it must preserve safety-critical task fields, including forbidden files and forbidden actions.

Future plan output is defined in [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md). It may organize execution steps conceptually, but it must preserve safety-critical task fields, including forbidden files and forbidden actions.

Future factory status output is defined in [Factory Status Result Contract](FACTORY_STATUS_RESULT.md). It may summarize local repo, task, lifecycle, PR, validation, risk, stop, unknown, and owner-action state conceptually, but it must not mutate repository or GitHub state.

The canonical docs-only task lifecycle is defined in [Task Lifecycle State Model](TASK_LIFECYCLE.md). It describes how a task moves from owner intent through task contract, branch work, PR creation, review-fix loop, merge, cleanup, and post-merge lesson handling.

## Risk Tiering

Tasks are grouped by risk:

- Low risk: local documentation changes with explicit allowed files and no external side effects.
- Medium risk: local implementation scaffolding or non-production automation proposals that do not write to external services.
- High risk: external writes, publishing, merges, branch deletion, credential handling, trading-related systems, or production-impacting behavior.

Low-risk tasks can proceed locally when scope is clear. Medium-risk tasks need an approved plan. High-risk tasks require explicit owner decisions before execution.

Low-risk docs-only tasks may proceed through commit, push, and PR creation after successful self-review when the task contract explicitly allows that flow. Merge remains separate unless explicitly requested.

## Branch Lifecycle

Work should happen on a purpose-named branch. The branch name should describe the proposal and avoid implying merge readiness.

Branch creation is allowed during local setup when requested. Branch deletion is never automatic and requires explicit owner approval.

## PR Lifecycle

PR creation follows the task contract. Low-risk docs-only tasks may publish a PR after successful self-review when the task contract explicitly allows commit, push, and PR creation. Tasks without that explicit permission must stop for owner approval before PR creation.

GitHub repository settings and PR policy are defined in [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md). That policy governs auto-merge settings, automatic remote head branch deletion, squash-only merge preference, branch protection, and required-check timing.

PR metadata should follow the [Task Contract](TASK_CONTRACT.md): Scope, Non-goals, Allowed files, Forbidden files/actions when present, Validation plan, Stop conditions, Risk tier, Self-review result, and Confirmations.

When solution lookup is required, PR metadata should also include Solution lookup result, applicable solution entries, and how each lesson was applied.

The short-form docs-only lifecycle is:

1. Prepare scoped branch.
2. Run solution lookup when required by the task.
3. Generate bounded diff.
4. Run acceptance checks.
5. Run self-review, including a hidden Unicode check for edited docs.
6. Commit, push, and publish a PR only if the task contract permits that flow.
7. Keep merge separate unless explicitly requested.

## Post-Merge Lesson Check

After a future merge, the factory should check whether the task produced reusable lessons:

- Was a stop condition useful?
- Did an allowed-file check catch anything?
- Did the scope need tightening?
- Should a policy or checklist be updated?

Lesson capture should remain documentation-only until the owner approves stronger automation.

Durable post-merge lessons may be captured in the [Compound Knowledge Base](solutions/README.md) through a separate docs-only PR. Compound output is advisory until reviewed and merged.

Review-fix lessons should identify whether the issue was missing task detail, incomplete metadata, unclear stop conditions, cross-document consistency, wording, reviewer preference, or no durable lesson.

New lesson files must stay inside the task's allowed docs-only paths and must not let Compound write outside the approved scope.

## Post-Merge Cleanup

After a PR is merged, local branch and worktree cleanup should be performed only through the approved cleanup prompt. GitHub remote head branch deletion is handled by the repository setting for Automatically delete head branches.

Cleanup must never delete `main`, `master`, `develop`, or `release/*`, must never use force delete, and must stop when the worktree is dirty or the target branch is not confirmed merged.

In the sandbox, cleanup verification is part of the first validation loop and must be confirmed before the loop is considered accepted.
