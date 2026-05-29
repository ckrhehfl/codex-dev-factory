# Deep Research Intake and Traceability

## Purpose

This document ingests `deep-research-report2.md` as external research input and maps its recommendations to the current repository policy surfaces.

The Deep Research report is not repository source of truth. It is an input for traceability only. Current merged repository documentation remains the source of truth for this control-plane repository until the owner approves a later technical decision or implementation task.

This document records classifications and follow-up questions. It does not implement any recommendation.

## Source Material

| Field | Value |
| --- | --- |
| Source filename | `deep-research-report2.md` |
| Source location for this run | External read-only input at `C:\Dev\codex-dev-factory-inputs\deep-research-report2.md` |
| Source status | External research input |
| Ingestion status | Traceability classification only |
| Repository source-of-truth status | Not source of truth by itself |
| Implementation authorization | None |

The source path is environment-specific evidence for this run. Future tasks should revalidate the external input path or use a separately approved stored source.

## Scope

This PR is limited to:

- Docs-only control-plane traceability.
- Comparing Deep Research recommendations with current repository docs.
- Classifying recommendations as `adopted`, `partially_adopted`, `deferred`, `reference_only`, `rejected`, or `확인 필요`.
- Recording gaps and owner decisions for later tasks.

Allowed files for this PR:

- `docs/DEEP_RESEARCH_INTAKE_AND_TRACEABILITY.md`.
- `README.md` for a narrow discoverability link.
- `docs/ROADMAP.md` for a narrow sequencing note.

## Non-Goals

This PR does not:

- Treat Deep Research as repository source of truth.
- Adopt Architecture A as implementation.
- Implement CLI behavior.
- Implement a Codex worker, custom harness, custom orchestrator, publisher, branch lifecycle manager, check monitor, auto-merge engine, cleanup automation, or projection layer.
- Create or edit workflows.
- Add source code, scripts, dependency manifests, schemas, task files, validation result files, or plan files.
- Add credentials, secrets, tokens, API keys, or secret-like placeholders.
- Modify the sandbox repository.
- Run sandbox validation.
- Modify or connect any trading repository.
- Add trading code, live trading logic, exchange integration, risk cap logic, model promotion logic, Discord bot behavior, GitHub write automation, PR publisher behavior, or production automation.

## Evidence and Source Classification

### Local-Verified

- Control-plane repository root was verified with `git rev-parse --show-toplevel`.
- Control-plane remote was verified with `git remote -v`.
- Current branch and clean worktree were verified with `git status --short --branch`.
- Latest `main` was fetched, pruned, and fast-forward pulled before this branch was created.
- External research source existence was verified with a local file check.

### Authenticated/Tool-Reported

- PR #31 was verified with GitHub CLI as `MERGED`, with no formal reviews reported.
- Control-plane open PR list was verified with GitHub CLI as empty before this branch was created.
- The PR #31 remote branch was not returned by a read-only remote head lookup.

### User-Reported

- The owner reported PR #31 was merged and local cleanup completed.
- The owner supplied the external research source path for this task.

### 확인 필요

- GitHub settings, branch protection, rulesets, required checks, repository secrets, and future automation permissions unless separately revalidated for a task that needs them.
- Whether the owner wants Architecture A formally adopted.
- Whether a raw research report should ever be stored in the repository.
- Whether a separate technical stack decision record should be created.

## Classification Model

| Classification | Meaning |
| --- | --- |
| `adopted` | Already represented in merged repo policy as an approved docs-level rule or boundary. This does not imply implementation unless the current repo explicitly implements it. |
| `partially_adopted` | Some supporting policy or planning surface exists, but the full recommendation is not approved or implemented. |
| `deferred` | Valid candidate for a later owner-approved plan or implementation phase, but not adopted now. |
| `reference_only` | Useful as background, comparison, or pattern input, but not selected as current direction. |
| `rejected` | Conflicts with current repo boundaries or is intentionally not selected. |
| `확인 필요` | Not enough verified repo or owner-decision evidence exists to classify beyond an explicit unknown. |

## Recommendation Traceability

| Research topic | Research recommendation | Current repo surface(s) | Classification | Rationale | Follow-up / 확인 필요 |
| --- | --- | --- | --- | --- | --- |
| Codex CLI primary worker | Use Codex CLI / `codex exec` as the primary worker runtime. | [README](../README.md), [Roadmap](ROADMAP.md), [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md), [Risk Policy](operations/RISK_POLICY.md) | `partially_adopted` | The repo is Codex-first and defines future local CLI planning surfaces, but it has not formally selected Codex CLI as the implemented worker runtime. | Owner decision and future technical stack decision record. |
| Custom harness | Build a repo-specific harness for clone/fetch, isolated workspaces, branch setup, validation, metadata, and cleanup evidence. | [Roadmap](ROADMAP.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Factory Status Result](FACTORY_STATUS_RESULT.md), [Sandbox Validation](SANDBOX_VALIDATION.md) | `deferred` | Harness behavior is anticipated across future phases, but no harness is implemented or formally approved. | Define harness scope after more sandbox evidence. |
| Custom orchestrator | Use a policy-aware queue/retry/fix-loop owner-decision orchestrator. | [Roadmap](ROADMAP.md), [Operating Model](operations/OPERATING_MODEL.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Risk Policy](operations/RISK_POLICY.md) | `deferred` | Orchestration is a later implementation concern and remains owner-gated. | Future architecture/technical stack PR. |
| Linux VPS scheduler | Run persistent queue consumption on Linux VPS. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md), [Phase 2 CLI Skeleton](PHASE2_CLI_SKELETON.md) | `deferred` | No hosting pattern is approved. External scheduling would be implementation/operations scope. | Owner decision on hosting model. |
| Dockerized worker | Use Dockerized ephemeral workers for boundary control. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md), [Sandbox Validation](SANDBOX_VALIDATION.md) | `deferred` | Containerized execution is plausible but not represented as current repo policy. | Future technical stack decision. |
| Git worktree / isolated workspace | Prefer worktrees or isolated workspaces for safe parallel task execution. | [Roadmap](ROADMAP.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Sandbox Validation](SANDBOX_VALIDATION.md), [Factory Status Result](FACTORY_STATUS_RESULT.md) | `partially_adopted` | Isolation and worktree cleanup are represented conceptually; no automated worktree harness exists. | Define worktree harness after owner approval. |
| GitHub App installation token publisher | Use GitHub App installation token as preferred publisher credential. | [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Risk Policy](operations/RISK_POLICY.md), [Roadmap](ROADMAP.md) | `deferred` | Publisher implementation and permission model are explicitly future/high-risk. | Owner decision on GitHub App timing and permissions. |
| `gh` / REST publisher | Use `gh` and REST for deterministic PR creation and merge-state reads. | [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md) | `partially_adopted` | Current manual tasks use `gh` for authenticated evidence and PR creation, but publisher behavior is not implemented as automation. | Define publisher authority and permission model. |
| GitHub-native checks/rulesets/auto-merge | Use GitHub checks, rulesets, required checks, and auto-merge as merge authority. | [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md) | `partially_adopted` | The repo has settings policy and future auto-merge phase, but required checks and auto-merge eligibility are not implemented or sandbox-proven. | Future check/guard strategy and owner approval. |
| Continue checks | Use Continue checks as AI/policy review status checks. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md) | `deferred` | Current repo has no check implementation or workflow. | Evaluate in future check/guard strategy. |
| Secret scanning / Gitleaks / TruffleHog | Add GitHub secret scanning plus local/CI scanners. | [Risk Policy](operations/RISK_POLICY.md), [Acceptance Tests](ACCEPTANCE_TESTS.md), [Sandbox Validation](SANDBOX_VALIDATION.md) | `partially_adopted` | Secret and credential content is already forbidden; tool stack selection is not made. | Decide scanner stack later; no workflow added now. |
| GitHub MCP Server optional context adapter | Use MCP as optional context plane, not final authority plane. | [Operating Model](operations/OPERATING_MODEL.md), [Factory Status Result](FACTORY_STATUS_RESULT.md), [Sandbox Validation Evidence](SANDBOX_VALIDATION_EVIDENCE.md) | `reference_only` | Current repo stresses authenticated/local source-of-truth evidence but has not selected MCP. | Revisit only if a future task needs GitHub context tooling. |
| Branch lifecycle manager | Build branch create/push/PR/merge/cleanup state manager. | [Task Lifecycle](operations/TASK_LIFECYCLE.md), [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Roadmap](ROADMAP.md), [Sandbox Validation](SANDBOX_VALIDATION.md) | `deferred` | Lifecycle policy exists; automation is explicitly not implemented. | Future branch lifecycle manager policy PR. |
| Controlled branch cleanup | Perform cleanup only after merged-state verification and safety checks. | [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Sandbox Validation Run 001 Evidence](SANDBOX_VALIDATION_RUN_001.md) | `partially_adopted` | Manual cleanup policy is adopted; cleanup automation and force-delete exceptions are not adopted. | Keep manual cleanup until separate owner-approved policy. |
| Discord/Slack redacted projection | Use chat only as read-only redacted projection, not source of truth. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md), [Operating Model](operations/OPERATING_MODEL.md) | `deferred` | Discord is a later read-only projection phase; no integration exists. | Future projection policy if owner wants it. |
| Bounded fix loop | Allow only bounded, in-scope repair loops for validation failures. | [Roadmap](ROADMAP.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md), [Risk Policy](operations/RISK_POLICY.md) | `partially_adopted` | Review-fix classification and bounded lifecycle exist for human-reviewed PRs; automated fix loop remains future work. | Define failure taxonomy before implementation. |
| Owner decision routing | Route high-risk and owner-gated states to explicit owner decisions. | [Task Contract](operations/TASK_CONTRACT.md), [Operating Model](operations/OPERATING_MODEL.md), [Risk Policy](operations/RISK_POLICY.md), [Task Lifecycle](operations/TASK_LIFECYCLE.md) | `adopted` | Owner gates are first-class repo policy. | Continue preserving owner gates in all future transformations. |
| Cost accounting | Track cost consumed and enforce cost caps. | [Roadmap](ROADMAP.md), [Factory Status Result](FACTORY_STATUS_RESULT.md), [Risk Policy](operations/RISK_POLICY.md) | `deferred` | Cost reporting is not yet a formal contract field. | Consider future status/result extension with owner approval. |
| Post-merge lesson proposal loop | Propose durable lessons after review/merge, then capture via separate docs PR. | [Task Lifecycle](operations/TASK_LIFECYCLE.md), [AGENTS](../AGENTS.md), [Compound Knowledge Base](solutions/README.md), [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) | `adopted` | Repository policy already requires durable lessons to go through separate docs-only PRs. | Continue skipping lesson capture when no review/durable lesson exists. |
| OpenHands as reference implementation | Treat OpenHands resolver/platform as closest reference, not full replacement. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md) | `reference_only` | No current repo policy selects OpenHands. The report frames it as a reference rather than complete match. | Revisit only in future technical comparison. |
| `openai/codex-action` prototype or Actions fallback | Use as possible Actions-based prototype/fallback, not primary target. | [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md), [Risk Policy](operations/RISK_POLICY.md), [Roadmap](ROADMAP.md) | `reference_only` | Workflows are currently forbidden; Actions can only be considered in a future approved scope. | Do not create workflows in this PR. |
| `peter-evans/create-pull-request` Actions fallback | Possible Actions PR creation fallback. | [Risk Policy](operations/RISK_POLICY.md), [GitHub Operating Policy](operations/GITHUB_OPERATING_POLICY.md) | `reference_only` | It would require workflows and GitHub write behavior, both out of scope now. | Consider only in approved Actions fallback PR. |
| mini-SWE-agent / SWE-ReX / Cline / Goose / Aider / PR-Agent reference roles | Use as reference patterns for harness, runtime abstraction, UX, fix loops, or review checks. | [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md) | `reference_only` | These tools are not selected as repo policy; they can inform future design. | Evaluate in technical stack decision record. |
| Managed cloud agents | Treat Copilot cloud agent, Cursor, Devin, Jules, and similar tools as fallback/comparison only unless verified. | [Operating Model](operations/OPERATING_MODEL.md), [Risk Policy](operations/RISK_POLICY.md) | `reference_only` | Availability, policy, plan, and trust boundaries are not verified here. | Keep as comparison group until owner asks for evaluation. |
| Roo Code | Avoid or treat as reference-only if the report says it is archived. | [Risk Policy](operations/RISK_POLICY.md) | `reference_only` | The report marks it as archived; current repo has no dependence on it. | Verify before any future mention as candidate. |
| Live trading / credentials / risk cap / model promotion | Keep outside scope and forbidden until separately approved. | [README](../README.md), [Roadmap](ROADMAP.md), [Risk Policy](operations/RISK_POLICY.md), [Sandbox Validation](SANDBOX_VALIDATION.md), [Task Contract](operations/TASK_CONTRACT.md) | `adopted` | The repo already forbids these paths in docs-first and sandbox-first phases. | Continue requiring separate high-risk owner approval. |

## Current Repo Alignment Summary

### Already Represented In Repo Policy

- Source-of-truth revalidation before work.
- Owner decision routing for high-risk or unclear states.
- Docs-only boundaries for current phase.
- Forbidden workflows, source code, credentials, trading integration, risk cap, and model promotion logic.
- PR metadata requirements, including self-review and confirmations.
- Allowed-files guard and safety-field preservation.
- Sandbox-first validation before implementation or trading integration.
- Post-merge lesson proposal/capture through separate docs-only PRs.

### Partially Represented

- Codex-first worker direction, without a formal Codex CLI worker implementation decision.
- Git worktree / isolated workspace policy, without an automated harness.
- GitHub-native checks and auto-merge as future phases, without real required checks or eligibility engine.
- Secret scanning as a policy boundary, without selected scanner stack.
- Bounded fix loop as a future phase and review-fix discipline, without automation.
- Controlled cleanup as manual policy, without branch lifecycle automation.

### Not Yet Represented

- Formal Architecture A adoption.
- Technical stack decision record.
- GitHub App publisher permission model.
- VPS or Docker hosting decision.
- Continue/check strategy.
- Cost accounting contract.
- Redacted projection schema.

### Intentionally Deferred

- CLI implementation.
- Codex worker or harness implementation.
- Publisher implementation.
- Branch cleanup automation.
- GitHub Actions workflows.
- Auto-merge eligibility implementation.
- Discord/Slack projection.
- Trading integration or live boundary work.

### Requires Owner Decision

- Whether Architecture A is formally adopted.
- Whether `docs/TECH_STACK_DECISION_RECORD.md` should be created next.
- GitHub App publisher timing and permission model.
- VPS/Docker adoption timing.
- Continue/checks adoption timing.
- Branch lifecycle automation timing.
- Discord/redacted projection timing.
- Auto-merge eligibility scope.
- Secret scanning stack.

## Owner Decisions Required

Codex must not decide these in this PR:

- Whether Architecture A is formally adopted as the target architecture.
- Whether Codex CLI is formally selected as the primary worker implementation.
- Whether to use Linux VPS, Docker, local PC/WSL, or another worker host pattern.
- Whether to create a GitHub App publisher and what permissions it should have.
- Whether to use `gh`, REST, GitHub MCP Server, or another publisher/context mix.
- Whether to enable or require specific GitHub checks, rulesets, branch protection, or auto-merge policies.
- Whether Continue, PR-Agent, Gitleaks, TruffleHog, or any other tool is approved.
- Whether branch cleanup automation is ever allowed and under what squash-merge exception policy.
- Whether Discord/Slack projection should be created.
- Whether cost accounting becomes a first-class result contract.
- Whether to create `docs/TECH_STACK_DECISION_RECORD.md` as a follow-up PR.

## Recommended Follow-Up PRs

Recommended follow-ups are docs-only unless the owner explicitly approves implementation:

- `Docs: classify Codex automation technical stack decisions`.
- `Docs: define publisher authority and permission model`.
- `Docs: define branch lifecycle manager policy`.
- `Docs: define check and guard strategy`.
- `Docs: define secret scanning and prompt-injection guard policy`.
- `Docs: define redacted projection policy`.

## Remaining 확인 필요

- Exact current GitHub settings, branch protection, rulesets, required checks, auto-merge, and repository secrets unless revalidated by authenticated tooling in a task that needs them.
- Whether report recommendations have current repo equivalents beyond the docs inspected in this task.
- Whether the owner wants Architecture A formally adopted.
- Whether a technical stack decision record should be created next.
- Whether the external Deep Research report should remain outside the repo or be stored later through a separate owner-approved archival decision.
- Tool/plugin versions and operational availability for any recommended external tool.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check` after staging.
- Edited Markdown files contain no suspicious hidden or bidirectional Unicode controls.
- Changed files are limited to the allowed files.
- No workflow, source, dependency, secret, trading, sandbox, automation, publisher, cleanup, Discord, risk cap, or model promotion files changed.
- Relative links added by this PR resolve.
- No new `STOPPED_*` code is introduced without registry alignment.

## Safety Field Preservation

This traceability intake preserves:

- `scope`.
- `allowed_files`.
- `forbidden_files`.
- `forbidden_actions`.
- `validation_plan`.
- Stop conditions.
- Risk tier.
- Owner gates.

If a future task transforms this document into technical decisions, those safety fields must remain visible and must not be weakened by implementation planning.
