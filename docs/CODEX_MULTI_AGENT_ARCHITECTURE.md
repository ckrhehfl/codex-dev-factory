# Codex Multi-Agent Architecture

## Status

| Field | Value |
| --- | --- |
| Status | `planning_control_plane_contract` |
| Implementation status | `not_started` |
| Scope | Docs-only Codex multi-agent architecture planning |
| Source of truth after merge | This repository's merged documentation |
| Runtime posture | Runtime-agnostic; Codex app, Codex CLI, Codex SDK, or future Codex-native runtime remain candidates only |
| Risk tier | Low-risk docs-only planning |

This document records the Codex multi-agent architecture as a planning and control-plane contract. It does not authorize worker execution, implementation, automation, PR publishing beyond a separately approved task, merge, cleanup, rollback, sandbox mutation, credential handling, external-provider use, workflow changes, settings changes, or production/trading-related action.

## Purpose

The Codex multi-agent architecture defines how future Codex workers should be coordinated once the owner separately approves worker execution and implementation. It keeps task contracts, owner gates, repository boundaries, evidence packets, review loops, cost controls, and stop behavior explicit before any runtime is selected.

Codex multi-agent architecture is the primary strategic direction for future completion work. That status is not implementation authority.

## Non-Goals

This document does not:

- Implement a worker, dispatcher, harness, CLI, SDK integration, app integration, workflow, schema, or automation.
- Select Codex app, Codex CLI, Codex SDK, or any other runtime as final implementation.
- Run Codex workers or authorize worker execution.
- Create branches, PRs, commits, merges, cleanup, rollback, or GitHub write automation.
- Mutate the sandbox repository or input folder.
- Handle credentials, secrets, API keys, OAuth, tokens, provider setup, or billing setup.
- Reopen Hermes, Ollama, local-model downloads, provider/model configuration, or local runtime evaluation.
- Authorize production, trading, live-boundary, risk cap, or model-promotion work.

## Architecture Overview

The control-plane coordinates owner intent, task contracts, role assignment, repo verification, allowed-file boundaries, evidence packets, stop conditions, and publication boundaries.

Future Codex agents are bounded workers. They may perform only the role, repository, path, file, command, and evidence work approved by the active task contract. A worker result is evidence for review; it is not source of truth by itself.

The minimum architecture is:

- One owner-approved task contract before any worker execution.
- One verified target repository, GitHub repository, local path, and do-not-modify path set before any task.
- One branch and worktree ownership boundary for each mutation worker.
- Parallel read-only analysis only when tasks are independent.
- Sequential mutation, validation, review, PR publication, merge, cleanup, and rollback unless a later owner-approved dispatcher design permits narrower parallelism.
- Evidence packets from every worker or coordinator handoff.

## Agent Roles

| Role | Primary responsibility | Default authority |
| --- | --- | --- |
| GPT/PM coordinator | Owns task framing, owner-decision routing, sequencing, and final evidence synthesis. | Read-only planning unless a task explicitly approves mutation or GitHub writes. |
| Intake agent | Extracts target repo, scope, non-goals, allowed files, forbidden actions, validation, risk tier, and owner gates. | Read-only. |
| Repo scout | Revalidates repo identity, branch, status, relevant files, and source-of-truth inputs. | Read-only. |
| Policy/evidence auditor | Checks task contract, solution lookup, evidence classes, stop states, and safety-field preservation. | Read-only. |
| Planner | Produces bounded implementation or documentation plans and sequencing recommendations. | Read-only. |
| Mutation worker | Edits only approved files on an owned branch/worktree after explicit owner approval. | Mutation within the approved contract only. |
| Validation worker | Runs approved validation commands and summarizes pass/fail evidence. | Read-only commands unless the validation task explicitly allows generated artifacts. |
| Review agent | Reviews diffs, PR metadata, and evidence for bugs, policy drift, missing tests, and scope violations. | Read-only. |
| Review-fix agent | Classifies review comments and fixes only in-scope items inside approved files. | Mutation only after review-fix approval. |
| PR publisher | Creates or updates PR metadata only when GitHub write approval exists. | Owner-gated GitHub write. |
| Cleanup coordinator | Plans or performs cleanup only after merge and explicit cleanup approval. | Owner-gated cleanup. |
| Rollback planner | Plans rollback options and evidence requirements. | Read-only planning unless rollback execution is separately approved. |

## Read-Only Vs Mutation Roles

Read-only roles may inspect approved local files and approved GitHub state when the task allows the required tooling. They must preserve evidence class boundaries and stop when required sources are unavailable.

Mutation roles require explicit owner approval before they edit files, create branches, commit, push, create PRs, resolve review threads, cleanup, rollback, or write to GitHub. Mutation workers also require isolated branch/worktree ownership and changed-file limits.

Same-file or same-branch parallel mutation is unsafe unless a later owner-approved dispatcher and reconciliation contract explicitly proves otherwise.

## Sequential Vs Parallel Workflow

Default workflow:

1. GPT/PM coordinator captures owner intent.
2. Intake agent verifies the task contract.
3. Repo scout verifies target repo, remote, branch, and clean status.
4. Policy/evidence auditor checks applicable lessons, owner gates, and stop states.
5. Planner defines the bounded work.
6. Mutation worker edits approved files only, if mutation is approved.
7. Validation worker runs approved validation.
8. Review agent inspects the diff and evidence.
9. Review-fix agent handles in-scope review comments only, if requested.
10. PR publisher creates or updates PR metadata only when GitHub write approval exists.
11. Merge, cleanup, rollback, and lesson handling proceed only through separate owner-gated lifecycle steps.

Multiple read-only analysis workers may run in parallel when their inputs and outputs do not conflict. Parallel mutation is allowed only after later approval, separate branch/worktree ownership, non-overlapping files, and dispatcher reconciliation. The dispatcher must reconcile results before any commit, push, or PR publication.

## Owner Decision Points

Owner approval is required for:

- Worker execution.
- Repo mutation.
- Branch creation.
- Worktree creation or mutation.
- Commit, push, PR creation, PR update, review-thread resolution, or any GitHub write.
- Merge or auto-merge.
- Cleanup, branch deletion, worktree deletion, pruning, uninstall, service stop, or rollback.
- Workflow, settings, ruleset, secret, permission, or required-check changes.
- Credential inspection, credential handling, provider setup, OAuth, API keys, subscriptions, billing, local model downloads, Hermes, or Ollama.
- Sandbox mutation.
- Production, trading, live-boundary, risk cap, or model-promotion work.

The coordinator may identify these gates. It must not approve them.

## Repo Boundary Model

Every future Codex prompt should start with:

- Target repo.
- GitHub repository.
- Local path.
- Do-not-modify repositories and paths.
- Owner approval scope.
- Evidence class requirements.

Control-plane work belongs in this repository. Sandbox validation work belongs only in the sandbox repository after the task explicitly targets and verifies that repository. The sandbox repository, input folder, and any reference repositories remain out of scope unless separately approved and revalidated.

## Evidence Packet Model

Each worker or coordinator handoff should report:

- Packet identity.
- Role and task scope.
- Repo identity evidence.
- Branch/worktree evidence when relevant.
- Inputs inspected.
- Actions attempted.
- Files changed, if any.
- Validation commands and outcomes.
- Evidence class classification.
- Forbidden action confirmation.
- Remaining confirm-needed items.
- Stop state, if any.
- Owner action required.
- Recommended next action.

Evidence classes remain claim-specific:

| Class | Meaning |
| --- | --- |
| `local-verified` | Verified from the current local repository or filesystem during the run. |
| `authenticated/tool-reported` | Reported by authenticated tooling, such as GitHub CLI or an approved connector. |
| `public/web-verified` | Observed through public web surfaces only. |
| `user-reported` | Stated by the owner or prompt but not independently revalidated in the current run. |
| `confirm_needed` | Unknown, unavailable, stale, blocked, ambiguous, or requiring future verification. |

## Credit/Cost Control

Codex credit usage is acceptable within the current owner plan/credit boundary. It should be controlled by:

- Small, bounded task contracts.
- Clear role assignment before dispatch.
- Batching related read-only analysis.
- Avoiding repeated full-repo reads when targeted inspection is enough.
- Stopping early on owner gates, dirty worktrees, duplicate PRs, or ambiguous scope.
- Recording `credit_cost_class` in future task contracts when useful.

This document does not approve additional provider subscriptions, new API keys, OAuth setup, third-party model billing, local model downloads, Hermes, Ollama, or external runtime spend.

## PR/Review/Merge Model

PR creation is an owner-gated GitHub write. A PR may be created only when the task contract explicitly allows it.

PR metadata for work that used multiple workers should identify the roles used, evidence packets produced, validation performed, and any worker outputs excluded from the final diff. This expectation does not apply to PRs that did not use multiple workers.

Review-fix loops must classify comments before editing. In-scope fixes may be applied only inside the approved file and risk boundaries. Out-of-scope, unsafe, or owner-decision comments remain unresolved until the owner decides.

Merge remains owner-gated. This architecture does not approve autonomous merge.

## Cleanup/Rollback Model

Cleanup and rollback are separate owner-gated actions.

Cleanup inventory, cleanup execution, branch deletion, worktree pruning, uninstall, service stop, WSL mutation, config deletion, model deletion, and local environment mutation require explicit future approval.

Rollback planning may describe options, risks, evidence, and required approvals. Rollback execution requires a separate owner-approved task and must preserve repo identity, branch/worktree ownership, validation, source-of-truth classification, and stop-state reporting.

## Failure And Stop-State Model

Use registry-backed stop states when they apply. Stop and report when:

- Repo identity, path, remote, branch, or source-of-truth status is unclear.
- The worktree is dirty before mutation.
- An open duplicate PR or branch exists.
- Allowed files, forbidden files, forbidden actions, owner gates, or validation are ambiguous.
- A role is asked to exceed its approved authority.
- Same-file or same-branch parallel mutation is requested without a later approved dispatcher design.
- Worker execution, GitHub write, cleanup, rollback, credentials, providers, workflows, settings, sandbox mutation, production, or trading authority is requested without approval.
- Validation fails or cannot be completed.

This document introduces no new `STOPPED_*` code.

## Minimum Viable Implementation Path

Before implementation begins, the repository needs:

1. A reviewed Codex multi-agent architecture doc.
2. Worker role contracts that define inputs, outputs, authority, evidence, and stop behavior.
3. A worker evidence packet template.
4. Sandbox parallel-worker dry-run planning.
5. Owner approval for any worker execution.
6. Runtime strategy selection or runtime-agnostic dry-run mechanics.
7. Publisher, review-fix, cleanup, and rollback boundaries kept separate.

Each item should remain docs-only unless the owner explicitly approves implementation.

## Sandbox Dry-Run Follow-Up

Sandbox dry-run planning should be a separate gate. It should define:

- Target sandbox repo and local path.
- Read-only versus mutation dry-run roles.
- Branch/worktree ownership.
- Non-overlapping file rules.
- Dispatcher reconciliation.
- Evidence packet expectations.
- Credit/cost class.
- Stop states.
- Review, PR, merge, cleanup, and rollback exclusions.

No sandbox mutation is authorized by this architecture doc.

## Forbidden Actions

This architecture does not authorize:

- Worker execution.
- Implementation, scripts, schemas, workflows, or dependency changes.
- Source code changes.
- Sandbox mutation.
- GitHub settings, rulesets, required checks, secrets, permissions, or workflow changes.
- Credentials, secrets, tokens, API keys, OAuth, external provider setup, subscriptions, or third-party billing.
- Local model download, Hermes, Ollama, provider/model setup, or local runtime evaluation.
- PR creation, PR update, review-thread resolution, merge, cleanup, or rollback unless separately approved.
- Production, trading, live-boundary, risk cap, or model-promotion work.

## Source-Of-Truth Classification

### Local-Verified

- Repository docs that are merged into this repository after review.
- Local repo identity, branch, status, and diffs only when revalidated in the current task.

### User-Reported

- Prior architecture planning packet content from the owner prompt until represented in merged repository docs.
- Prior cleanup or installed-state facts unless revalidated in a separately approved task.

### Confirm Needed

- Final Codex runtime choice: Codex app, Codex CLI, Codex SDK, or future Codex-native runtime.
- Worker implementation design.
- Worker execution authority.
- Dispatcher implementation and reconciliation behavior.
- Cost accounting caps beyond the current owner plan/credit boundary.
- GitHub settings, rulesets, required checks, secrets, permissions, and workflow status.
- Sandbox dry-run scope and timing.
- Cleanup and rollback authority.
