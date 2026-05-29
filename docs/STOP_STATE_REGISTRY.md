# Stop-State Registry

## Purpose

This registry is the canonical surface for `STOPPED_*` codes used by this repository.

It prevents stop-state drift across task contracts, validation results, plan output, risk policy, solution lessons, acceptance checks, and future reporting surfaces.

This document is a documentation contract only. It does not implement CLI behavior, automation, workflows, GitHub writes, branch cleanup, Discord integration, trading functionality, or any runtime enforcement.

## Naming Convention

Stop states use the `STOPPED_<REASON>` format.

Names should be stable, explicit, and machine-readable enough for future CLI and reporting work. Prefer adding a clear new code over overloading an existing one.

Avoid renaming existing stop states unless necessary. If a stop state is replaced, document the replacement and affected surfaces in this registry.

## Registry Fields

Each registry entry defines:

- Code: the `STOPPED_*` value.
- Category: the policy area that owns the stop state.
- Trigger: the condition that stops work.
- Owner action required: whether explicit owner decision is normally required.
- Recommended next action: what Codex should report or do next.
- Surfaces that must reference it: documents that should mention the code when the stop state applies there.
- Notes: relationship to existing contracts or future implementation.

## Categories

- Source-of-truth / environment.
- Scope / forbidden action.
- Safety field preservation.
- Stop-state consistency.
- Solution lookup.
- Hidden Unicode.
- Owner decision / approval gate.
- Validation / contract mismatch.
- GitHub / branch lifecycle.
- Sandbox validation.
- Compound knowledge base.

## Surface Update Rule

When a new `STOPPED_*` code is added, update this registry first or in the same PR.

Then update every relevant local Stop States section.

If shared policy is affected, update [Risk Policy](operations/RISK_POLICY.md).

Recommended next actions and enum-like statuses must match declared stop states.

## Drift Check Rule

Before commit, search for all `STOPPED_*` references and confirm each appears in this registry or is intentionally documented as deprecated or legacy.

If a mismatch remains, stop with `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

## Deprecation Rule

Do not silently delete or rename stop states.

If a stop state is replaced, add a registry note that identifies the replacement, affected surfaces, and migration expectation.

## Relationship to Solution Lookup

If a solution lesson introduces or depends on a stop state, this registry must be checked or updated.

The [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md) and [Stop-State Consistency](solutions/workflow/stop-state-consistency.md) lesson both require recommended next actions and stop-state lists to stay aligned.

## Relationship to Future Implementation

Future CLI, validation, planning, status, or reporting implementation may consume this registry conceptually, but no implementation is added here.

## Initial Registry Entries

| Code | Category | Trigger | Owner action required | Recommended next action | Surfaces that must reference it | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY` | Scope / forbidden action | Branch cleanup automation is implemented before approval. | Yes | Remove implementation from scope or request owner decision. | Risk Policy, Phase 2 CLI, cleanup policy docs | Automation boundary. |
| `STOPPED_BRANCH_NOT_MERGED` | GitHub / branch lifecycle | Cleanup target is not confirmed merged. | Yes | Stop cleanup and report target branch state. | Risk Policy, GitHub Operating Policy | Never force delete to bypass this state. |
| `STOPPED_BRANCH_PROTECTED` | GitHub / branch lifecycle | Cleanup target is protected. | Yes | Stop cleanup and request owner decision. | Risk Policy, GitHub Operating Policy | Applies to `main`, `master`, `develop`, and `release/*`. |
| `STOPPED_BRANCH_PROTECTION_UNVERIFIED` | GitHub / branch lifecycle | Branch protection state is needed but unverified. | Yes | Verify settings or stop for owner decision. | Risk Policy, GitHub Operating Policy | Settings are not assumed. |
| `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED` | GitHub / branch lifecycle | Cleanup would require force deletion. | Yes | Stop cleanup. | Risk Policy, GitHub Operating Policy, Sandbox Validation | `git branch -D` is not allowed by default. |
| `STOPPED_CLI_IMPLEMENTATION_INCLUDED` | Scope / forbidden action | CLI implementation appears in docs-only or planning-only scope. | Yes | Remove implementation or request owner decision. | Risk Policy, CLI, task/plan/validation docs | Planning docs may describe future CLI only. |
| `STOPPED_CODE_INCLUDED` | Scope / forbidden action | Source code appears where docs-only work is required. | Yes | Remove code from PR. | Risk Policy, local task, plan, validation docs | Broader code stop state. |
| `STOPPED_COMPOUND_ATTEMPTED_UNAPPROVED_WRITE` | Compound knowledge base | Compound or lesson capture attempts an unapproved write. | Yes | Stop and report attempted path. | Risk Policy, Compound docs | Compound output is advisory. |
| `STOPPED_COMPOUND_SCOPE_UNVERIFIED` | Compound knowledge base | Compound scope or write target is unclear. | Yes | Verify allowed docs-only paths before continuing. | Risk Policy, Compound docs | Use before allowing generated lesson writes. |
| `STOPPED_CREDENTIAL_OR_SECRET_CONTENT` | Scope / forbidden action | Credential, secret, token, or sensitive account content appears. | Yes | Remove sensitive content and report. | Risk Policy, Acceptance Tests | No secret material in docs-first work. |
| `STOPPED_EXISTING_REPO_ASSUMED_AS_SOURCE_OF_TRUTH` | Source-of-truth / environment | Existing repo is treated as authoritative without revalidation. | Yes | Revalidate source of truth or ask owner. | Risk Policy, Task Contract, Operating Model | `institutional-futures-trader` is reference only unless approved. |
| `STOPPED_FORBIDDEN_FILE_CHANGE` | Scope / forbidden action | Changed files exceed allowed files. | Yes | Stop before commit and report diff. | Risk Policy, Acceptance Tests, Task Contract | Primary allowed-files guard. |
| `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD` | Validation / contract mismatch | A field is unsafe, contradictory, forbidden, or too ambiguous for planning. | Sometimes | Clarify field or request owner decision. | Risk Policy, Task Validation Result | Added after PR #8 review. |
| `STOPPED_GITHUB_SETTINGS_UNVERIFIED` | GitHub / branch lifecycle | GitHub repository settings are needed but unverified. | Yes | Verify settings before relying on them. | Risk Policy, GitHub Operating Policy | Applies to auto-merge and branch deletion settings. |
| `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED` | Scope / forbidden action | GitHub write automation appears before approval. | Yes | Remove implementation or request owner decision. | Risk Policy, task/plan/validation docs | PR creation by Codex is not the same as implementing automation. |
| `STOPPED_HIDDEN_UNICODE_FOUND` | Hidden Unicode | Hidden or bidirectional Unicode control characters are found and not intentional. | Yes | Remove or justify characters before commit. | Risk Policy, Solution Lookup Protocol, Acceptance Tests | Local scan is source of truth. |
| `STOPPED_IMPLEMENTATION_INCLUDED` | Scope / forbidden action | Implementation appears in docs-only scope. | Yes | Remove implementation from PR. | Risk Policy, Acceptance Tests, Task Contract | General implementation guard. |
| `STOPPED_LIVE_TRADING_RELATED_CONTENT` | Scope / forbidden action | Live trading boundary content appears. | Yes | Stop and request owner decision. | Risk Policy | Trading integration is out of scope. |
| `STOPPED_LOCAL_TASK_FORMAT_SCOPE_EXPANDED` | Validation / contract mismatch | Local task format scope expands beyond documentation contract. | Yes | Narrow scope or request owner decision. | Risk Policy, Local Task Format | Docs-only format contract guard. |
| `STOPPED_LOCAL_WORKTREE_DIRTY` | Source-of-truth / environment | Worktree is dirty when cleanup or validation requires clean state. | Sometimes | Stop and report status. | Risk Policy, GitHub Operating Policy, Sandbox Validation | Do not cleanup with dirty worktree. |
| `STOPPED_MERGE_STATE_UNVERIFIED` | GitHub / branch lifecycle | Merge state cannot be confirmed. | Yes | Verify PR merge state before cleanup. | Sandbox Validation | Cleanup guard. |
| `STOPPED_OWNER_DECISION_REQUIRED` | Owner decision / approval gate | Task crosses an owner gate. | Yes | Stop and ask owner. | Risk Policy and all task contracts | Default owner gate. |
| `STOPPED_PARSER_IMPLEMENTED_TOO_EARLY` | Scope / forbidden action | Parser implementation appears before approval. | Yes | Remove parser implementation. | Risk Policy, local task, plan, validation docs | Parser planning is docs-only until approved. |
| `STOPPED_PHASE2_SCOPE_EXPANDED` | Validation / contract mismatch | Phase 2 scope expands beyond CLI skeleton planning. | Yes | Narrow scope or request owner decision. | Risk Policy, Phase 2 CLI | Phase 2 remains planning-first. |
| `STOPPED_PLAN_FILE_CREATED_TOO_EARLY` | Scope / forbidden action | Actual plan files appear before implementation phase. | Yes | Remove plan files. | Risk Policy, Plan Output Contract | Plan output is conceptual. |
| `STOPPED_PLAN_OUTPUT_SCOPE_EXPANDED` | Validation / contract mismatch | Plan output contract expands beyond approved docs scope. | Yes | Narrow scope or request owner decision. | Risk Policy, Plan Output Contract | Docs-only contract guard. |
| `STOPPED_PR_METADATA_INCOMPLETE` | Validation / contract mismatch | PR metadata lacks required sections. | Sometimes | Complete metadata before PR publication. | Risk Policy, Task Contract, Acceptance Tests | Includes solution lookup result when required. |
| `STOPPED_REMOTE_BRANCH_NOT_PRUNED` | GitHub / branch lifecycle | Remote branch cleanup expectation is not met. | Sometimes | Verify GitHub head branch deletion or report. | Sandbox Validation | Remote cleanup is via GitHub setting. |
| `STOPPED_REMOTE_URL_SANITIZATION_UNCLEAR` | Source-of-truth / environment | Remote URL sanitization cannot be safely verified. | Yes | Report the redacted remote URL and stop until the source remote can be verified. | OMX Loop Packet Schema, packet emitter | Added for normalized OMX loop packet emission. |
| `STOPPED_REQUIRED_CHECKS_NOT_READY` | GitHub / branch lifecycle | Required checks are requested before real checks exist. | Yes | Do not enable required checks yet. | Risk Policy, GitHub Operating Policy | Avoid fake or missing checks. |
| `STOPPED_SAFETY_FIELD_DROPPED` | Safety field preservation | A required safety field disappears from validation, planning, status, or metadata. | Yes | Restore safety fields before commit. | Risk Policy, Plan Output, Task Validation, Acceptance Tests | Includes `forbidden_files` and `forbidden_actions`. |
| `STOPPED_SANDBOX_REMOTE_UNVERIFIED` | Sandbox validation | Sandbox remote cannot be verified. | Yes | Verify sandbox repo before using it. | Sandbox Validation | Sandbox must be a separate GitHub repo. |
| `STOPPED_SANDBOX_REPO_NOT_CREATED` | Sandbox validation | Required sandbox repo does not exist. | Yes | Create or approve sandbox setup separately. | Sandbox Validation | Do not silently substitute trading repo. |
| `STOPPED_SCHEMA_CREATED_TOO_EARLY` | Scope / forbidden action | Schema files appear before approval. | Yes | Remove schema files. | Risk Policy, local task, plan, validation docs | Schema planning is docs-only until approved. |
| `STOPPED_SELF_REVIEW_FAILED` | Validation / contract mismatch | Self-review checks fail. | Sometimes | Report failed check and do not commit. | Risk Policy, Task Contract | Broad pre-commit guard. |
| `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE` | Solution lookup | Applicable solution suggests work outside current scope. | Yes | Stop for owner decision. | Risk Policy, Solution Lookup Protocol, Acceptance Tests | Lessons do not expand scope automatically. |
| `STOPPED_SOLUTION_LOOKUP_SKIPPED` | Solution lookup | Required solution lookup was not completed. | Sometimes | Run lookup before planning or commit. | Risk Policy, Solution Lookup Protocol, Acceptance Tests | Prevents repeated mistakes. |
| `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION` | Solution lookup | Applicable solution requires owner decision. | Yes | Ask owner before applying lesson. | Risk Policy, Solution Lookup Protocol, Acceptance Tests | Use when lesson is valid but gated. |
| `STOPPED_SOURCE_OF_TRUTH_UNCLEAR` | Source-of-truth / environment | Repo, path, remote, branch, or main state cannot be safely verified. | Yes | Stop and report unclear source of truth. | Risk Policy, this registry, task prompts | Use when local revalidation fails before branch creation. |
| `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED` | Source-of-truth / environment | Required source-of-truth context has not been verified. | Yes | Revalidate context or ask owner. | Risk Policy, Task Contract | More general than unclear local repo state. |
| `STOPPED_STOP_STATE_SURFACE_MISMATCH` | Stop-state consistency | Stop-state references do not match declared stop-state surfaces. | Sometimes | Update registry and relevant lists before commit. | Risk Policy, Solution Lookup Protocol, Acceptance Tests, solution lessons | Created from PR #8 lesson. |
| `STOPPED_TASK_CONTRACT_INCOMPLETE` | Validation / contract mismatch | Required task contract fields are missing. | Sometimes | Complete task contract before work continues. | Risk Policy, Task Contract, Acceptance Tests, Task Validation Result | Intake guard. |
| `STOPPED_TASK_YAML_CREATED_TOO_EARLY` | Scope / forbidden action | Task YAML files appear before approved implementation phase. | Yes | Remove task YAML files. | Risk Policy, local task, plan, validation docs | Local task format is conceptual. |
| `STOPPED_TRADING_CODE_INCLUDED` | Scope / forbidden action | Trading code appears in docs-first scope. | Yes | Remove trading code and stop for owner decision. | Risk Policy | Trading work is high risk. |
| `STOPPED_TRADING_REPO_SELECTED_TOO_EARLY` | Sandbox validation | A trading repo is selected before sandbox validation allows it. | Yes | Use sandbox or stop for owner decision. | Sandbox Validation | Prevents premature trading integration. |
| `STOPPED_VALIDATION_FILE_CREATED_TOO_EARLY` | Scope / forbidden action | Actual validation result files appear before implementation phase. | Yes | Remove validation result files. | Risk Policy, Task Validation Result | Validation output is conceptual. |
| `STOPPED_VALIDATION_FAILED` | Validation / contract mismatch | Required local validation fails or an adapter failure cannot provide a more specific stop state. | Sometimes | Report the failed validation and do not proceed until it passes. | OMX Loop Packet Schema, packet emitter, task contracts | General validation halt for normalized packet emission. |
| `STOPPED_VALIDATION_RESULT_SCOPE_EXPANDED` | Validation / contract mismatch | Validation result contract expands beyond approved docs scope. | Yes | Narrow scope or request owner decision. | Risk Policy, Task Validation Result | Docs-only contract guard. |
| `STOPPED_WORKFLOW_INCLUDED` | Scope / forbidden action | Workflow files or workflow implementation are introduced. | Yes | Remove workflow changes. | Risk Policy, Acceptance Tests, task/plan/validation docs | Includes GitHub Actions workflows. |
