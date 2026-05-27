# Technical Stack Decision Record

## Status

| Field | Value |
| --- | --- |
| Status | `draft_decision_record` |
| Scope | Docs-only control-plane technical stack classification |
| Implementation status | `not_started` |
| Source of truth after merge | This repository's merged documentation |
| Source input | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) and current repository docs |
| Risk tier | Low-risk docs-only decision record |

This record classifies future Codex automation technical-stack components. It does not implement, enable, configure, install, authenticate, authorize, or grant permissions to any component.

## Purpose

This document prevents technical-stack decisions from living only in chat, handoff notes, or external research. It narrows the decision state for Codex automation components and keeps decision records separate from implementation authorization.

The classifications below are decision-level policy labels. They are not proof that a component exists, is installed, is configured, or is safe to execute.

## Relationship To Deep Research

Deep Research is source input only. It is not repository source of truth by itself.

[Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) is the prior repo-ingested intake surface for this task. This document uses that intake plus current repository docs to classify technical-stack decisions for future planning.

This document does not approve implementation of Architecture A, a Codex worker, a custom harness, a publisher, branch lifecycle automation, checks, workflows, runtime infrastructure, or integrations.

## Scope

This record covers:

- Codex automation technical-stack classification.
- Current repository alignment.
- Future owner decisions.
- Recommended follow-up PRs.
- Evidence/source classification and remaining unknowns.

Allowed files for this PR:

- `docs/TECH_STACK_DECISION_RECORD.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow sequencing note.
- `docs/DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md` only if a narrow consistency link is needed.

## Non-Goals

This PR does not:

- Implement CLI behavior.
- Implement a Codex worker, custom harness, custom orchestrator, publisher, branch lifecycle manager, check monitor, auto-merge engine, cleanup automation, or projection layer.
- Create a GitHub App, token, permission grant, repository setting change, branch protection rule, or ruleset.
- Create or edit GitHub Actions workflows.
- Install, configure, or enable Continue, MCP, Docker, VPS scheduling, scanners, managed agents, or any external tool.
- Modify the sandbox repository or run sandbox validation.
- Merge, enable auto-merge, perform cleanup, delete branches, or force push.
- Add source code, scripts, dependency manifests, schemas, credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify or connect a trading repository.
- Add trading code, live trading behavior, exchange integration, risk cap logic, model promotion logic, Discord/Slack integration, GitHub write automation, PR publisher behavior, branch cleanup automation, or production automation.

## Classification Model

| Classification | Meaning |
| --- | --- |
| `adopted` | A decision-level principle is already supported by current repo docs and safety boundaries. This does not imply implementation unless the repo explicitly implements it. |
| `primary_strategic_direction` | The owner-selected primary planning direction. This does not imply implementation, runtime execution, automation authority, credentials, billing, cleanup, or external writes. |
| `partially_adopted` | The direction or principle is represented, but implementation details, verification, or owner approval remain incomplete. |
| `deferred` | A valuable future component that requires separate design, owner decision, environment setup, permissions, or implementation. |
| `retired_unless_reopened` | A previous planning path is no longer active and must not proceed unless the owner explicitly reopens it with a new approved scope. |
| `reference_only` | Useful as a pattern, example, comparison, or fallback candidate, but not adopted as the primary stack. |
| `rejected` | Conflicts with current safety policy, current scope, or explicit prohibitions. |
| `확인 필요` | Cannot be classified beyond an unknown without fresh verification, owner decision, or missing source-of-truth docs. |

## Current Decision Summary

| Area | Current decision state |
| --- | --- |
| Source of truth, docs-first control plane, owner gates, and deterministic guard principles | `adopted` |
| Codex-primary multi-agent completion as the strategic completion path | `primary_strategic_direction` |
| Architecture A, Codex CLI worker direction, `gh`/REST evidence and publishing path, isolated workspace policy, controlled cleanup policy, bounded fix-loop discipline, and secret-handling boundaries | `partially_adopted` |
| Custom harness, orchestrator, VPS/Docker runtime, GitHub App publisher, checks/rulesets, auto-merge, Continue checks, scanner stack, branch lifecycle manager, cost accounting, and redacted projection | `deferred` |
| Hermes runtime/orchestrator evaluation track and Ollama/local-model smoke-test path | `retired_unless_reopened` |
| OpenHands, Codex Action, `peter-evans/create-pull-request`, mini-SWE-agent, SWE-ReX, Aider, Cline, Goose, PR-Agent, managed cloud agents, GitHub MCP Server, and Roo Code | `reference_only` |
| Live trading, credentials/secrets in repo docs or automation, risk cap logic, model promotion logic, broad PAT as primary publisher credential, direct push to `main`, branch protection bypass, and closed-but-unmerged cleanup automation | `rejected` |

## Decision Table

| Component | Proposed role | Classification | Rationale | Current repo surfaces | Owner decision required | Implementation allowed now? | Follow-up PR |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GitHub as source of truth | Canonical PR, branch, merge, and review state for GitHub work, when authenticated or explicitly classified | `adopted` | Repo policy consistently requires revalidation and distinguishes local, authenticated, public, user-reported, and unknown state. | [Operating Model](OPERATING_MODEL.md), [Factory Status Result](FACTORY_STATUS_RESULT.md), [PR Metadata Guard](PR_METADATA_GUARD.md), [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md) | No for principle; yes for settings or automation reliance | No implementation in this PR | None |
| Docs-first control-plane | Start with reviewed documentation contracts before automation | `adopted` | Current repository identity and roadmap are docs-first and control-plane oriented. | [README](../README.md), [Roadmap](ROADMAP.md), [Risk Policy](RISK_POLICY.md) | No for principle | No implementation in this PR | None |
| Deterministic guards outside the model | Preserve explicit guards for metadata, allowed files, stop states, and safety fields | `adopted` | Guard contracts exist as docs-only future surfaces, and safety-field preservation is required. | [PR Metadata Guard](PR_METADATA_GUARD.md), [Allowed-Files Guard](ALLOWED_FILES_GUARD.md), [Stop-State Registry](STOP_STATE_REGISTRY.md), [Task Validation Result](TASK_VALIDATION_RESULT.md) | Owner decision before implementation | No | `Docs: define check and guard strategy` |
| Deep Research as source input only | Research informs traceability, not source-of-truth authority | `adopted` | The intake document explicitly classifies Deep Research as input only. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Roadmap](ROADMAP.md) | No for source-status rule | No | None |
| Architecture A | Preferred target direction for future automation architecture | `partially_adopted` | It is represented through traceability as a candidate direction, but not formally adopted as implementation. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Roadmap](ROADMAP.md), [Risk Policy](RISK_POLICY.md) | Yes, formal adoption and boundaries | No | `Docs: define Codex worker and harness MVP boundary` |
| Codex-primary multi-agent completion architecture | Primary strategic completion path for future planning | `primary_strategic_direction` | The owner decided Codex multi-agent completion is the primary path and that Codex credit usage is acceptable within the current plan/credit boundary. This is a strategic direction, not worker execution or runtime implementation authority. | [Roadmap](ROADMAP.md), [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md), [Risk Policy](RISK_POLICY.md) | Yes, before implementation, worker execution, automation, publisher behavior, or runtime setup | No | `Docs: define Codex multi-agent completion architecture` |
| Codex CLI primary worker | Future worker runtime candidate | `partially_adopted` | Repo is Codex-first and Phase 2 describes future CLI surfaces, but no worker implementation is approved. | [README](../README.md), [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md), [Roadmap](ROADMAP.md), [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md) | Yes, runtime and execution boundary | No | `Docs: define worker runtime strategy` |
| Custom harness | Own clone/fetch/worktree/validation/metadata boundary | `deferred` | Harness behavior is anticipated but not designed or approved for implementation. | [Roadmap](ROADMAP.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Factory Status Result](FACTORY_STATUS_RESULT.md) | Yes | No | `Docs: define Codex worker and harness MVP boundary` |
| Hermes runtime/orchestrator evaluation track | Historical/superseded runtime evaluation planning artifact | `retired_unless_reopened` | The owner pivoted away from Hermes-first evaluation to Codex-primary multi-agent completion. Hermes is not invalidated globally, but it is no longer the active control-plane runtime/orchestrator path unless the owner explicitly reopens it. | [Hermes Runtime Evaluation Plan](HERMES_RUNTIME_EVALUATION_PLAN.md), [Hermes Evaluation Acceptance Criteria](HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md), [Hermes Evaluation Evidence Template](HERMES_EVALUATION_EVIDENCE_TEMPLATE.md), [Hermes Sandbox Validation Runbook](HERMES_SANDBOX_VALIDATION_RUNBOOK.md), [Roadmap](ROADMAP.md) | Yes, before any reopen, install, execution, sandbox validation, runtime connection, authority delegation, or adoption | No | Optional Hermes reopen gate only if owner explicitly reopens it |
| Ollama/local-model smoke-test path | Historical smoke-test path and legacy cleanup context only | `retired_unless_reopened` | The owner decided no local model download will be performed and no Hermes provider/model/config work for Ollama will be performed. Installed Ollama facts are user-reported cleanup context only unless revalidated in a separate cleanup inventory gate. | [Roadmap](ROADMAP.md), [Risk Policy](RISK_POLICY.md) | Yes, before any reopen, model download, provider/auth setup, cleanup inventory, or cleanup execution | No | `Ollama cleanup inventory only` |
| Custom orchestrator | Queue, retry, owner decision, and fix-loop coordinator | `deferred` | Orchestration is future implementation and high-impact automation; Codex-primary multi-agent architecture planning should define whether a custom orchestrator is needed while authority remains with the control-plane. | [Operating Model](OPERATING_MODEL.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Risk Policy](RISK_POLICY.md), [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md) | Yes | No | `Docs: define Codex multi-agent completion architecture` |
| Linux VPS scheduler | Persistent scheduler host option | `deferred` | No hosting model is approved. Runtime infrastructure requires owner decision. | [Roadmap](ROADMAP.md), [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md), [Risk Policy](RISK_POLICY.md) | Yes | No | `Docs: define worker runtime strategy` |
| Dockerized worker | Isolated worker runtime candidate | `deferred` | Plausible boundary mechanism, but no Docker setup or policy is approved. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Sandbox Validation](SANDBOX_VALIDATION.md), [Risk Policy](RISK_POLICY.md) | Yes | No | `Docs: define worker runtime strategy` |
| Git worktree / isolated workspace | Isolation pattern for future task execution | `partially_adopted` | Isolation and worktree cleanup are policy concepts, but no automated worktree harness exists. | [Roadmap](ROADMAP.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Sandbox Validation](SANDBOX_VALIDATION.md), [Factory Status Result](FACTORY_STATUS_RESULT.md) | Yes for automation | No | `Docs: define branch lifecycle manager policy` |
| GitHub App installation token publisher | Preferred candidate for narrow publisher authority | `deferred` | Current docs flag publisher authority as future and high-risk. | [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md), [Risk Policy](RISK_POLICY.md), [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes, permissions and timing | No | `Docs: define publisher authority and permission model` |
| `gh` / REST publisher | Manual/authenticated evidence source and possible future publisher path | `partially_adopted` | `gh` is used for current authenticated checks and PR creation in approved tasks, but publisher automation is not implemented. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md), [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md) | Yes for automation | No | `Docs: define publisher authority and permission model` |
| GitHub-native checks/rulesets/required checks | Future merge-safety authority | `deferred` | Required checks should wait until real checks exist and are sandbox-proven. | [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md), [Roadmap](ROADMAP.md), [Risk Policy](RISK_POLICY.md) | Yes | No | `Docs: define check and guard strategy` |
| GitHub auto-merge | Future gated merge mechanism | `deferred` | Auto-merge setting alone is not eligibility; policy and checks are still missing. | [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md), [Roadmap](ROADMAP.md), [PR Metadata Guard](PR_METADATA_GUARD.md) | Yes | No | `Docs: define auto-merge eligibility policy` |
| Continue checks | Candidate AI/policy review check | `deferred` | No check implementation, workflow, or tool decision exists. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Risk Policy](RISK_POLICY.md) | Yes | No | `Docs: define check and guard strategy` |
| Secret scanning / Gitleaks / TruffleHog | Candidate scanner stack | `deferred` | Secret content is already forbidden, but scanner selection is not approved. | [Risk Policy](RISK_POLICY.md), [Acceptance Tests](ACCEPTANCE_TESTS.md), [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes | No | `Docs: define secret scanning strategy` |
| GitHub MCP Server optional context adapter | Optional context adapter, not authority plane | `reference_only` | Current docs require authenticated/local evidence and do not select MCP as policy. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Factory Status Result](FACTORY_STATUS_RESULT.md) | Yes if elevated beyond context | No | `Docs: define MCP context boundary` if needed |
| Branch lifecycle manager | Future branch/PR/merge/cleanup state manager | `deferred` | Lifecycle policy exists; automation remains prohibited until separately approved. | [Task Lifecycle](TASK_LIFECYCLE.md), [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md), [Roadmap](ROADMAP.md) | Yes | No | `Docs: define branch lifecycle manager policy` |
| Controlled branch cleanup | Manual cleanup policy and future automation candidate | `partially_adopted` | Manual cleanup is policy; cleanup automation and force-delete exceptions are not adopted. | [GitHub Operating Policy](GITHUB_OPERATING_POLICY.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Sandbox Validation Run 001 Evidence](SANDBOX_VALIDATION_RUN_001.md) | Yes for automation or exceptions | No | `Docs: define branch lifecycle manager policy` |
| Bounded fix loop | Limited in-scope repair loop for failed checks/review | `partially_adopted` | Review-fix classification exists; automated bounded fix loops are later phase work. | [Task Lifecycle](TASK_LIFECYCLE.md), [Roadmap](ROADMAP.md), [Risk Policy](RISK_POLICY.md) | Yes for automation | No | `Docs: define bounded fix-loop policy` |
| Owner decision routing | Explicit route for high-risk, unclear, or owner-gated work | `adopted` | Owner gates are first-class repository policy. | [Task Contract](TASK_CONTRACT.md), [Operating Model](OPERATING_MODEL.md), [Risk Policy](RISK_POLICY.md), [Task Lifecycle](TASK_LIFECYCLE.md) | No for principle | No implementation in this PR | None |
| Cost accounting | Future accounting and caps for automation work | `deferred` | Cost fields are not yet formalized in status/result contracts. | [Roadmap](ROADMAP.md), [Factory Status Result](FACTORY_STATUS_RESULT.md), [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes | No | `Docs: define cost accounting policy` |
| Post-merge lesson proposal loop | Durable lesson review and capture through separate PRs | `adopted` | Lesson capture and solution lookup are already repository policy. | [AGENTS](../AGENTS.md), [Task Lifecycle](TASK_LIFECYCLE.md), [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md), [Compound Knowledge Base](solutions/README.md) | No for docs-only principle | No automation in this PR | None |
| Discord/Slack redacted projection | Future read-only status projection | `deferred` | Roadmap keeps projection later and read-only; no integration exists. | [Roadmap](ROADMAP.md), [Operating Model](OPERATING_MODEL.md), [Risk Policy](RISK_POLICY.md) | Yes | No | `Docs: define redacted projection policy` |
| OpenHands | Reference implementation/comparison | `reference_only` | No repo policy selects it as the primary stack. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes if elevated | No | None |
| `openai/codex-action` | Prototype or Actions fallback candidate | `reference_only` | Workflows are forbidden in current scope; Actions fallback requires separate approval. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Risk Policy](RISK_POLICY.md) | Yes | No | Possible Actions fallback policy PR |
| `peter-evans/create-pull-request` | Possible Actions fallback for PR creation | `reference_only` | It requires workflows and GitHub write behavior, both outside current scope. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Risk Policy](RISK_POLICY.md) | Yes | No | Possible Actions fallback policy PR |
| mini-SWE-agent / SWE-ReX | Harness and runtime references | `reference_only` | Useful comparison inputs, not selected stack. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes if elevated | No | None |
| Aider | Coder/repair reference | `reference_only` | Useful comparison input, not selected stack. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes if elevated | No | None |
| Cline / Goose | Research or alternative references | `reference_only` | Useful comparison inputs, not selected stack. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Yes if elevated | No | None |
| PR-Agent | Review-assist reference/caution | `reference_only` | Possible review-assist comparison; not selected as guard authority. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [PR Metadata Guard](PR_METADATA_GUARD.md) | Yes if elevated | No | None |
| Managed cloud agents such as Copilot cloud agent, Cursor, Devin, Jules | Fallback or comparison group | `reference_only` | Current availability, permission, and trust boundaries were not verified here. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md), [Risk Policy](RISK_POLICY.md) | Yes if elevated | No | None |
| Roo Code | Archived/reference caution if future tasks mention it | `reference_only` | Intake says report marked it as archived; current repo has no dependency on it. | [Deep Research Intake and Traceability](DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md) | Verify before future candidate use | No | None |
| Live trading / credentials / risk cap / model promotion | Explicitly forbidden or out of scope | `rejected` | These paths conflict with current docs-first, sandbox-first, no-credentials boundaries. | [README](../README.md), [Risk Policy](RISK_POLICY.md), [Sandbox Validation](SANDBOX_VALIDATION.md), [Task Contract](TASK_CONTRACT.md) | Separate high-risk owner approval would be required to revisit | No | None |

## Architecture A Boundary

Architecture A may be treated as a preferred target direction for discussion and follow-up planning only.

This PR does not:

- Formally adopt Architecture A as an implementation architecture.
- Enable, configure, install, or execute any Architecture A component.
- Approve a worker runtime, publisher, check strategy, branch lifecycle manager, auto-merge policy, projection layer, scanner stack, or runtime host.
- Grant credentials, permissions, GitHub settings changes, or runner authority.

Any Architecture A component that requires credentials, GitHub settings, runner setup, automation, external writes, or implementation requires a separate owner-approved PR or task.

## Codex-Primary Pivot Boundary

Codex-primary multi-agent completion is the primary strategic completion path.

This decision does not:

- Select Codex CLI, Codex app-server, Codex SDK, or any other specific runtime implementation.
- Implement or execute a Codex worker.
- Approve automation, publisher behavior, GitHub writes, workflow changes, or settings changes.
- Approve additional provider subscriptions, new API keys, OAuth setup, third-party model billing, credential inspection, or credential handling.
- Approve Ollama cleanup, uninstall, service stop, WSL mutation, configuration deletion, model deletion, local model download, or Hermes provider/model/config work.

Codex credit usage is acceptable within the current owner plan/credit boundary. Any additional provider, credential, billing, or runtime authority remains owner-gated.

The Hermes/Ollama path is retired unless explicitly reopened by the owner. Any installed Ollama state is user-reported legacy cleanup context unless a separate owner-approved cleanup inventory task revalidates it.

## MVP Direction

A conservative future MVP should remain narrower than the full Architecture A research direction:

- Docs-only low-risk real PR loop first.
- Source-of-truth revalidation before work.
- Allowed-files guard and forbidden-action boundary checks.
- PR metadata guard with distinct self-review and confirmations.
- Draft or reviewable PR URL verification.
- Explicit owner-controlled merge boundary.
- No auto-merge until required checks, rulesets, owner decisions, and sandbox-proven behavior exist.
- No trading repository connection, credentials, live trading, risk cap logic, or model promotion logic.

## Deferred Implementation Tracks

Recommended future tracks are docs-only unless separately approved for implementation:

- Codex worker boundary and worker runtime strategy.
- Codex multi-agent completion architecture.
- Publisher authority and permission model.
- Check and guard strategy.
- Branch lifecycle manager policy.
- Auto-merge eligibility policy.
- Redacted projection policy.
- Secret scanning strategy.
- VPS/Docker runtime strategy.
- Cost accounting policy.
- Ollama cleanup inventory, if the owner opens a separate cleanup inventory gate.

## Explicit Rejections And Forbidden Paths

The following are rejected or forbidden under current repository policy:

- Live trading behavior.
- Credentials, secrets, tokens, API keys, or secret-like placeholders in repository docs or implementation.
- Risk cap logic and model promotion logic.
- Broad or classic PAT as the primary publisher credential.
- Write-all `GITHUB_TOKEN` as the default automation credential.
- Direct push to `main`.
- Branch protection bypass.
- Raw logs, raw diffs, or sensitive task content projected to chat systems without a redaction policy.
- Closed-but-unmerged branch deletion automation.
- Treating untrusted issue, PR, comment, or prompt body content as trusted instructions without task-contract and source-of-truth revalidation.
- Treating public-only GitHub UI state, chat history, handoff notes, or external research as repository source of truth.

## Owner Decisions Required

Codex must not make these decisions in this PR:

- Whether Architecture A is formally adopted.
- Whether Codex CLI is the primary worker implementation and what execution boundary it gets.
- Runtime location: local/WSL, VPS, Docker, Actions fallback, or another host.
- GitHub App publisher timing and permissions.
- Whether `gh`, REST, GitHub MCP Server, or another context/publisher mix is approved.
- GitHub rulesets, branch protection, required checks, and auto-merge timing.
- Continue/check strategy and which checks can be merge-blocking.
- Secret scanning stack.
- MCP role and boundaries.
- Auto-merge eligibility scope.
- Branch lifecycle automation timing.
- Discord/Slack projection scope.
- Raw research archival policy.
- Cost accounting fields and caps.

## Recommended Follow-Up PRs

Recommended follow-ups:

- `Docs: define Codex worker and harness MVP boundary`.
- `Docs: define publisher authority and permission model`.
- `Docs: define check and guard strategy`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define auto-merge eligibility policy`.
- `Docs: define redacted projection policy`.
- `Docs: define secret scanning strategy`.
- `Docs: define worker runtime strategy`.

These follow-ups should remain docs-only unless the owner explicitly approves implementation.

## Evidence And Source Classification

### Local-Verified

- Control-plane repository root, remote URL, current branch, clean worktree, and latest `main` were revalidated before branch creation.
- `docs/DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md` exists in the repository after pulling latest `main`.
- Required solution lookup was completed before editing.
- Current repository docs listed in the task were inspected before writing this record.

### Authenticated/Tool-Reported

- PR #32 was checked with GitHub CLI as `MERGED`.
- PR #32 merge commit was reported by GitHub CLI.
- PR #32 formal reviews list was reported empty by GitHub CLI.
- Current open PR list for `ckrhehfl/codex-dev-factory` was reported empty by GitHub CLI before this branch was created.

### Public/Web-Verified

- No public web browsing was needed for this decision record. Repository docs and authenticated/local tooling were sufficient for the required source-of-truth checks.

### User-Reported

- The owner reported PR #32 was merged, had no formal review, and local cleanup was completed.

### 확인 필요

- Current GitHub settings, branch protection, rulesets, required checks, auto-merge state, and repository secrets unless revalidated by a future task that needs them.
- Whether the owner formally adopts Architecture A.
- Whether any external Deep Research recommendation has changed since the repo-ingested intake.
- External tool versions, availability, pricing, and current product status.
- Whether future implementation should run on local/WSL, VPS, Docker, Actions, or another environment.
- Whether raw Deep Research should ever be stored in the repository.

## Solution Lookup Result

Solution lookup was completed before planning and editing.

Applicable lessons:

- [Task Lifecycle Review Lessons](solutions/workflow/task-lifecycle-review-lessons.md): applied by completing solution lookup before planning/editing and preserving owner-gated lifecycle boundaries.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by requiring this PR body to include separate self-review and confirmations sections.
- [Allowed-Files Review Lessons](solutions/workflow/allowed-files-review-lessons.md): applied by keeping changed files inside allowed docs-only paths and preserving forbidden-file semantics.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by keeping evidence categories and unknowns structurally explicit.
- [Readiness Audit Review Lessons](solutions/workflow/readiness-audit-review-lessons.md): applied by preferring portable verification methods and avoiding machine-specific source-of-truth claims.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by avoiding new stop codes and preserving registry-backed stop-state references.

No applicable solution conflicts with this docs-only decision-record scope.

## Safety Field Preservation

This decision record preserves:

- `scope`.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Validation plan.
- Stop conditions.
- Risk tier.
- Owner gates.

If a future task transforms this record into task contracts, plans, validation results, status output, PR metadata, guard output, or implementation work, those safety fields must remain visible and must not be weakened.

## Stop Conditions

Stop and report if a future task tries to use this record to:

- Implement or enable a technical component without owner approval.
- Treat Deep Research as repository source of truth by itself.
- Drop forbidden files, forbidden actions, stop conditions, risk tier, or owner gates.
- Introduce workflow, source code, dependency manifest, credential, secret, trading, automation, publisher, branch cleanup, Discord/Slack, risk cap, or model promotion changes outside an explicitly approved scope.
- Rely on GitHub settings, branch protection, rulesets, required checks, repository secrets, or external tool availability without revalidation.
- Treat Architecture A as fully adopted implementation without a separate owner decision.

Existing registry-backed stop states should be used when applicable. This record introduces no new `STOPPED_*` code.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Changed files are limited to allowed files.
- No workflow, source, dependency, secret, trading, sandbox, automation, publisher, cleanup, Discord/Slack, risk cap, or model promotion files changed.
- Relative links added by this PR resolve.
- No new `STOPPED_*` code is introduced without registry alignment.
