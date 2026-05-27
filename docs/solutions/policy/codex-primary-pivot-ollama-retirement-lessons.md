# Codex-Primary Pivot And Ollama Retirement Lessons

## Problem

The repository had active planning surfaces for `Option 2 - Conditional Hermes-first` and future Hermes sandbox evaluation, while the owner later decided that Codex-primary multi-agent completion is the primary completion path.

Without a narrow docs update, future agents could keep treating Hermes/Ollama local-model work as the active next path, or could promote user-reported installed Ollama state into repository source of truth without revalidation.

## Cause

The Hermes documents were correct for their original owner-approved planning scope, but they remained discoverable as active roadmap and runtime-evaluation guidance after the strategic pivot.

The pivot also introduced new boundaries that were not yet represented in repo docs:

- Avoid additional provider subscriptions, new API keys, OAuth setup, and third-party model billing.
- Treat Codex credit usage as acceptable within the current owner plan/credit boundary.
- Retire the Ollama/local-model path unless explicitly reopened.
- Keep installed Ollama state as user-reported cleanup context only unless revalidated.
- Keep cleanup inventory and cleanup execution as separate owner-gated tasks.

## Solution

When a strategic pivot supersedes an earlier runtime path, update active planning surfaces without erasing the historical documents.

Use `superseded` for affected historical documents, and use `retired unless explicitly reopened` for the path itself. This preserves the evidence and review lessons while preventing future agents from reading older runbooks as active approval.

Record the new direction in the main decision surface, then add small cross-links from affected docs. For this pivot, the main decision surface is [Technical Stack Decision Record](../../TECH_STACK_DECISION_RECORD.md), with supporting updates in [Roadmap](../../ROADMAP.md), [Codex Worker Boundary](../../CODEX_WORKER_BOUNDARY.md), and the Hermes planning documents.

## What Changed

The active strategic completion path is Codex-primary multi-agent completion.

The Hermes/Ollama local-model path is retired unless explicitly reopened by the owner.

The prior Hermes documents remain historical/superseded planning artifacts. They are not deleted, and they do not approve Hermes installation, Hermes execution, Ollama execution, provider/model setup, local-model download, sandbox validation, runtime connection, cleanup inventory, or cleanup execution.

## What Remains Owner-Gated

Separate owner approval remains required for:

- Codex worker implementation or execution.
- Codex multi-agent runtime implementation.
- Automation, publisher behavior, GitHub writes, workflows, settings, rulesets, secrets, or permission changes.
- Additional provider subscriptions, new API keys, OAuth setup, third-party model billing, credential inspection, or credential handling.
- Hermes reopen, install, run, configuration, provider/model setup, or runtime connection.
- Ollama reopen, model download, provider setup, local model use, cleanup inventory, or cleanup execution.
- Uninstall, service stop, WSL mutation, config deletion, or model deletion.
- Sandbox mutation.

## Evidence-Class Requirements

User-reported installed-state facts remain user-reported until revalidated in an approved task.

For this pivot, statements about installed Ollama state, service state, model inventory, zstd, missing local models, or absent Hermes setup are prior user-reported evidence unless a future owner-approved cleanup inventory task verifies them locally.

Future docs must not claim Ollama installed state is local-verified unless the task explicitly allows the required local verification. Future tasks must not run WSL, Ollama, Hermes, model downloads, cleanup, uninstall, or credential inspection unless separately approved.

## Prevention

Before committing a docs update that changes architecture direction, self-review should check:

- Are superseded documents clearly marked at the top?
- Does the active roadmap point to the new path?
- Does the main decision surface record the pivot without granting implementation authority?
- Are user-reported facts separated from local-verified facts?
- Are cleanup inventory and cleanup execution separate gates?
- Are cost, credential, provider, model-download, and billing boundaries explicit?
- Are historical lessons preserved instead of rewritten?

## Future Applicability

Apply this lesson when:

- A previously active runtime, provider, model, or orchestrator path is superseded.
- A local installed state becomes cleanup context rather than active architecture.
- A planning document should remain available for history but must not act as current authorization.
- A strategic direction is adopted without implementation authority.

## Related PRs

- This PR: Docs: record Codex-primary pivot and Ollama retirement.
- Prior Hermes planning docs: [Hermes Runtime Evaluation Plan](../../HERMES_RUNTIME_EVALUATION_PLAN.md), [Hermes Evaluation Acceptance Criteria](../../HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md), [Hermes Evaluation Evidence Template](../../HERMES_EVALUATION_EVIDENCE_TEMPLATE.md), and [Hermes Sandbox Validation Runbook](../../HERMES_SANDBOX_VALIDATION_RUNBOOK.md).
- Prior historical lessons: [PR 44 Hermes Acceptance Review Lessons](pr44-hermes-acceptance-review-lessons.md) and [PR 46 Hermes Evidence Review Lessons](pr46-hermes-evidence-review-lessons.md).

## Follow-Up Status

Captured in the docs-only PR that records the Codex-primary pivot and Ollama retirement.

No implementation follow-up is approved by this lesson. Future Codex multi-agent architecture planning, Ollama cleanup inventory, cleanup execution, Hermes reopen, provider/model setup, local-model download, credential handling, GitHub settings changes, sandbox mutation, and runtime implementation remain owner-gated.

## Non-Goals

This lesson does not implement or approve:

- Codex multi-agent runtime implementation.
- Codex worker execution.
- Hermes installation, execution, configuration, or provider/model setup.
- Ollama execution, model download, cleanup inventory, cleanup execution, uninstall, service stop, WSL mutation, config deletion, or model deletion.
- Additional provider subscriptions, new API keys, OAuth setup, third-party model billing, credential inspection, or credential handling.
- Sandbox repository modification.
- GitHub settings, rulesets, required checks, Actions, secrets, or permission changes.
- Publisher behavior, PR automation beyond separately approved PR creation, cleanup automation, branch deletion automation, or auto-merge.
