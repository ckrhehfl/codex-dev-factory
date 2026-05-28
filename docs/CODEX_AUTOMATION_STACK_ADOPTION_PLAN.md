# Codex Automation Stack Adoption Plan

## Status

| Field | Value |
| --- | --- |
| Status | `adoption_preflight_plan` |
| Implementation status | `not_started` |
| Scope | Docs-only OMX, local Codex CLI, and GitHub Actions adoption planning |
| Source of truth after merge | This repository's merged documentation |
| Risk tier | Low-risk docs-only planning |

This plan records the first adoption path for an automation stack based on existing tools. It does not install, configure, authenticate, execute, or enable OMX, Codex CLI, GitHub Actions, auto-merge, automatic branch deletion, Codex GitHub Action, Hermes, WSL, sandbox tooling, or any credential-dependent system.

## Purpose

The near-term factory should adopt existing tools before implementing a large custom loop engine.

The intended stack is:

- OMX as the workflow, task, state, log, plan, and team coordination layer.
- Local Codex CLI as the primary coding worker.
- ChatGPT plan sign-in as the preferred local Codex CLI access path.
- GitHub Actions as the first checks, guard, and validation layer.
- GitHub native auto-merge as a later conditional merge layer.
- GitHub automatic delete head branches as a later conditional remote cleanup layer.
- Codex GitHub Action as a Phase 2 candidate only.
- Hermes as a Phase 3 or later runtime/orchestration candidate only.

## Source Review

### Local-Verified Repository Inventory

The current repository is a docs-first control plane. The preflight found:

- No tracked `.github/workflows/**` files.
- No tracked `scripts/**` files.
- Existing policy and contract docs for task intake, lifecycle, stop states, risk, PR metadata, allowed-files reporting, worker boundaries, GitHub operating policy, result packets, and solution lookup.
- Existing result-packet vocabulary including `stop_state`, `lifecycle_trace`, `recommended_next_action`, source-of-truth classes, owner gates, forbidden actions, and remaining `확인 필요`.
- Existing GitHub policy that prefers native auto-merge and automatic remote head branch deletion later, while requiring settings verification before relying on them.
- Existing worker policy that keeps Codex worker execution, publisher behavior, cleanup, GitHub settings, workflows, secrets, and runtime setup owner-gated.

### Public/Project-Verified Sources

- OMX project docs describe OMX as an orchestration layer for Codex CLI with durable state, hooks, CLI/MCP/docs assets, team execution, `omx setup`, `omx doctor`, and `.omx/` state/log/plan surfaces: <https://github.com/scalarian/oh-my-codex> and <https://oh-my-codex.dev/docs.html>.
- OpenAI Codex CLI docs describe Codex CLI as a local terminal coding agent that can inspect, edit, and run code in the selected directory, with ChatGPT plan access and first-run sign-in by ChatGPT account or API key: <https://developers.openai.com/codex/cli>.
- The OpenAI Codex CLI repository recommends signing in with ChatGPT to use Codex as part of a ChatGPT plan and treats API key use as an alternative requiring additional setup: <https://github.com/openai/codex>.
- GitHub Actions docs define workflows as YAML files under `.github/workflows` that run jobs on events: <https://docs.github.com/en/actions/concepts/workflows-and-actions/workflows>.
- GitHub protected branch docs define required status checks and their merge effect: <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches>.
- GitHub auto-merge docs say enabled repositories can let individual PRs merge automatically when merge requirements are met: <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-auto-merge-for-pull-requests-in-your-repository>.
- GitHub automatic branch deletion docs say repository admins can configure automatic head branch deletion after PR merge, subject to branch protection and repository rules: <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-the-automatic-deletion-of-branches>.

## Findings

### Adoption Feasibility

The repository has enough control-plane policy to support a docs-only adoption plan for OMX, local Codex CLI, and GitHub Actions.

It does not yet have executable checks, workflows, scripts, local task files, schemas, runners, or a custom loop engine. That is acceptable for this gate because the recommended MVP is to adopt external tools and add thin guard/config surfaces only after the plan is reviewed.

### OMX Role

OMX should be treated as the first-priority workflow and coordination layer, not as the source of repository truth.

OMX may later provide:

- Task/workflow modes.
- Durable `.omx/` state and logs.
- Plan and memory surfaces.
- Team/worktree coordination.
- Hooks and safety presets.
- Operator status surfaces such as `omx doctor`, `omx hud`, and team logs.

OMX must preserve the repository task contract, allowed files, forbidden files, forbidden actions, validation plan, stop states, risk tier, owner gates, source classification, and result-packet vocabulary.

### Local Codex CLI Role

Local Codex CLI should be the primary coding worker candidate.

Codex CLI may later inspect, edit, and run commands inside an approved repository boundary only after an owner-approved task contract authorizes that work. It should not become the publisher, merge bot, cleanup bot, settings manager, secret handler, or sandbox mutator.

### ChatGPT Plan Versus API Key Path

The preferred local path is ChatGPT plan sign-in for Codex CLI. The default control-plane path should not require manually adding OpenAI API keys or GitHub secrets.

Because current Codex CLI access, credit, billing, and generated-key behavior can vary by account and plan, the billing and credential implications remain `확인 필요` until a separate auth-safe local availability gate verifies them without credential inspection.

The MVP can proceed without Codex GitHub Action and without OpenAI API key GitHub secrets.

### Windows, macOS, Linux, And WSL

OpenAI Codex CLI docs support macOS, Windows, and Linux, with Windows native PowerShell support and WSL2 as an option for Linux-native environments.

OMX project docs emphasize npm installation, setup, state/log surfaces, and team/tmux-oriented execution. Windows-native OMX support is not yet source-of-truth enough for this repository to rely on it. Treat Windows native OMX execution as `확인 필요` until a separate read-only local availability gate checks the current path without setup, auth, WSL repair, or credential inspection.

Recommended planning assumption: macOS/Linux or WSL-style environments may be the safer OMX path for team/runtime features, while Windows native may be acceptable only after project-doc and local availability evidence agree.

### GitHub Actions First Checks

GitHub Actions should initially provide checks, guards, and validation only. It should not execute Codex, merge PRs, delete branches, mutate settings, or handle secrets in the MVP.

First candidate checks:

- Allowed-files check.
- Forbidden-action check.
- Markdown/link check.
- Result-packet shape check.
- PR metadata check.
- Validation command check for repo-approved commands only.

Required status checks should not be configured until real workflow checks exist, are stable, and are owner-approved.

### Native Auto-Merge And Delete Branches

Later integration should use GitHub native auto-merge for eligible loop-created low-risk PRs instead of writing a custom merge bot.

Eligibility should require:

- Automation-created branch/PR with an approved prefix.
- Allowed files only.
- No forbidden actions.
- No credential, config, auth, provider, model, Hermes, WSL, sandbox, GitHub settings, workflow, ruleset, secret, or permission changes.
- Validation, link check, result-packet check, and PR metadata check pass.
- PR URL, PR number, branch, commit, and changed files recorded.
- Result packet includes outcome, evidence class, forbidden-action confirmation, `stop_state`, and `recommended_next_action`.
- No merge conflict.
- Required GitHub checks pass.

Later remote branch cleanup should use GitHub automatic delete head branches for merged PR head branches instead of a custom remote cleanup bot. Local branch and worktree cleanup remains owner-gated and must not force delete.

## Owner-Gated Later Configuration Candidates

The following may be checked or configured only in later owner-approved gates:

- Repository setting: Allow auto-merge.
- Repository setting: Automatically delete head branches.
- Branch protection or ruleset for `main`.
- Required GitHub Actions checks.
- Conversation resolution requirement.
- Linear history or squash-only merge preferences.
- Rules limiting who can push or bypass protections.
- Check-source restrictions for required checks.
- GitHub Actions permissions.
- Repository secrets, if Phase 2 ever considers Codex GitHub Action.

No setting is changed by this plan.

## What To Avoid

Do not implement these directly while existing tools can cover the role:

- Large custom loop engine.
- Custom merge bot.
- Custom remote branch cleanup bot.
- Codex GitHub Action as MVP core.
- GitHub Actions workflow that runs Codex with an OpenAI API key.
- Hermes execution or Hermes-Codex runtime validation.
- WSL repair, registration, setup, or mutation.
- Sandbox mutation.
- Docs folderization before automation can reliably handle PRs, link checks, merge/cleanup evidence, and result packets.

## Thin Control-Plane Needs

The next thin control-plane work should be limited to:

- A reviewed guard/check strategy for allowed files, forbidden actions, link checks, PR metadata, result packets, and validation command reporting.
- A small workflow/check MVP only after owner approval to add `.github/workflows/**`.
- A read-only OMX local availability/auth-path preflight gate if the OMX execution path remains unclear.
- A read-only Codex CLI availability/auth-path preflight gate that does not inspect credentials.
- A read-only GitHub settings capability check before any reliance on auto-merge or automatic head branch deletion.

## Guard/Check MVP

The first thin guard/check MVP may add repository-native validation infrastructure only:

- `scripts/guard_checks.py` for deterministic changed-file checks.
- One GitHub Actions workflow that runs the guard script on pull requests and `main` pushes touching docs, guard scripts, or workflow files.

The MVP guard surface should check:

- Automation branch changed files stay inside docs, guard script, workflow, README, or AGENTS paths.
- Warning-class hidden or bidirectional Unicode is absent from changed text files.
- Changed Markdown local relative links resolve inside the repository.
- Guard scripts and workflow files do not introduce executable surfaces for Codex, OMX, Hermes, WSL, API keys, GitHub secrets, force push, force branch deletion, or auto-merge commands.

This MVP does not change GitHub settings, required checks, rulesets, permissions, secrets, auto-merge, automatic branch deletion, Codex GitHub Action usage, runtime execution, sandbox validation, or branch cleanup behavior.

## Minimum First PR Scope

This adoption-plan PR should include only:

- This planning document.
- A narrow documentation map link.

It must not include workflows, scripts, runtime setup, auth/config/provider/model work, API keys, secrets, Codex GitHub Action execution, Hermes, WSL, sandbox changes, settings changes, folder moves, or loop-engine implementation.

## Stop Conditions

Stop and report if a future task requires:

- Repo, path, remote, or branch identity that cannot be verified.
- Dirty worktree outside the approved scope.
- Allowed-files violation.
- Validation, link-check, result-packet, or PR metadata failure.
- Missing PR metadata.
- Missing result packet.
- Credential, config, auth, provider, model, billing, API key, or GitHub secret access.
- Hermes execution or Codex-through-Hermes execution.
- WSL repair, registration, setup, or mutation.
- Sandbox mutation.
- GitHub settings, secrets, workflows, rulesets, permissions, publisher behavior, auto-merge, or automatic branch deletion changes before owner approval.
- Production, trading, or live-risk work.
- Confusion between ChatGPT plan access and API key billing.

Use existing registry-backed stop states where applicable. This plan introduces no new `STOPPED_*` code.

## Evidence Classification

### Local-Verified

- Repository identity, branch, remote, and clean status when revalidated during the current task.
- Existing repository docs and tracked files inspected during the current task.
- Absence or presence of tracked `.github/workflows/**` and `scripts/**` files during the current task.

### Public/Web-Verified

- OMX project documentation and project repository.
- Official OpenAI Codex CLI documentation and OpenAI Codex repository.
- Official GitHub documentation for Actions workflows, required status checks, auto-merge, and automatic branch deletion.

### User-Reported

- Owner approval for this adoption preflight and optional docs-only PR.
- Current retained strategy and direction changes stated in the task prompt.

### 확인 필요

- Current sandbox repo state.
- Current input folder state.
- Current WSL or Ubuntu state.
- Current Hermes local availability.
- Current local Codex CLI auth/runtime behavior.
- Current OMX local availability and Windows-native behavior.
- GitHub repo settings for auto-merge, automatic delete head branches, rulesets, branch protection, required checks, secrets, and permissions.
- Billing, credits, and account-specific Codex access path.

## Solution Lookup Result

Applicable lessons:

- [Codex Primary Pivot And Ollama Retirement Lessons](solutions/policy/codex-primary-pivot-ollama-retirement-lessons.md): applied by keeping Codex primary, API key and billing boundaries explicit, and Hermes deferred rather than removed.
- [PR 44 Hermes Acceptance Review Lessons](solutions/policy/pr44-hermes-acceptance-review-lessons.md): applied by preserving future owner-approved Hermes evaluation possibility while stopping unapproved Hermes execution.
- [PR 46 Hermes Evidence Review Lessons](solutions/policy/pr46-hermes-evidence-review-lessons.md): applied by using `stop_state`, `lifecycle_trace`, and separate approval/evidence fields in future packet expectations.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by treating forbidden file changes as stop/report conditions.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping self-review and confirmations separate from validation and risk sections.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by keeping unchecked settings, sandbox, WSL, local tool availability, and billing facts as `확인 필요`.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by introducing no new stop code.

No applicable solution conflicts with this docs-only adoption-plan scope.

## Recommended Next Action

After this plan is reviewed, the next owner gate should be a focused implementation-planning gate for a thin GitHub Actions guard/check MVP.

If OMX execution remains unclear, run a targeted OMX project-docs and read-only local availability preflight first. If Codex CLI auth remains unclear, run a read-only local Codex CLI availability/auth-path preflight without credential inspection. Keep Codex GitHub Action, API keys, GitHub secrets, Hermes, sandbox, WSL, and folderization deferred.
