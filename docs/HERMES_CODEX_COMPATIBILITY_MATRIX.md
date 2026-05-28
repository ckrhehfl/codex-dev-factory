# Hermes-Codex Compatibility Matrix

## Status

This is a planning/control-plane compatibility matrix for future Hermes-Codex evaluation.

This document does not approve Hermes setup, Hermes configuration, Hermes authentication, provider/model setup, runtime execution, WSL repair or registration, GitHub authority delegation, production use, or trading use.

## Purpose

This matrix compares possible Hermes-Codex integration paths before any execution gate.

The goal is to preserve:

- Codex as the primary coding worker and primary cost/credit path.
- Hermes as an active conditional runtime/tooling/orchestration candidate.
- GitHub/control-plane authority outside Hermes by default.

## Non-Goals

- No Hermes execution.
- No Codex execution through Hermes.
- No setup, configuration, authentication, provider, or model commands.
- No credential or configuration inspection.
- No WSL repair or registration.
- No GitHub authority delegation.
- No production or trading automation.
- No Ollama/local-model reopening.

## Source-of-Truth Classification

| Evidence class | Meaning |
| --- | --- |
| `public/web-verified` | Official docs or repository findings when rechecked from public sources. |
| `local-verified` | Local command results from the approved repository and shell. |
| `authenticated/tool-reported` | GitHub CLI, API, or approved authenticated tooling output. |
| `user-reported` | Owner decisions or manual observations unless later recorded in repo docs or revalidated. |
| `Deep Research input` | Deep Research material used as input only, not repository source of truth. |
| `확인 필요` | Anything not directly checked in the current approved gate. |

## Current Strategy Boundaries

- Codex is the primary coding worker and primary cost/credit path.
- Hermes remains an active conditional runtime/tooling/orchestration candidate for Codex-primary workflows.
- The Ollama/local-model provider path is retired unless explicitly reopened by the owner.
- GitHub/control-plane authority remains outside Hermes by default.
- Hermes setup, configuration, authentication, provider/model work, and runtime execution are not approved.

## Integration Path Matrix

| Path | Intended role | Official support signal | Auth/config implications | Billing/credit implications | Runtime implications | Repo boundary risk | GitHub authority risk | Current status | Required next gate |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Hermes Codex app-server runtime | Evaluate whether Hermes can orchestrate a Codex runtime while Codex remains the patch-producing worker. | 확인 필요; must be rechecked from official Hermes and OpenAI docs before setup. | May involve Hermes config, Codex runtime state, existing Codex auth, or runtime connection details; all remain 확인 필요 until an approved feasibility gate. | Unknown until official-docs recheck confirms whether plan credits, API billing, or another path applies. | Could introduce runtime invocation, approval prompts, sandbox behavior, logs, and continuation semantics that must be mapped before use. | Must not mutate the control-plane repo, sandbox repo, input folder, or worktrees outside an approved task. | Hermes receives no PR, merge, cleanup, rollback, settings, workflow, ruleset, secret, or permission authority by default. | Plausible evaluation path only; not proven or approved. | Official-docs recheck, then owner decision for sandbox feasibility preflight. |
| Hermes OpenAI/Codex provider path | Evaluate whether a Hermes provider can call a Codex/OpenAI-backed path. | 확인 필요; official provider/auth docs must be rechecked before any action. | May require OAuth, device-code login, API keys, provider config, or auth files; no inspection or writes are approved. | May imply OpenAI API billing, additional provider billing, or another unknown billing path; stop until classified. | Could change model/provider selection, approval behavior, logs, and failure modes. | Provider behavior must not bypass allowed files, repo identity checks, or sandbox boundaries. | Provider success does not grant Hermes GitHub/control-plane authority. | Higher-risk candidate; blocked on official-docs and owner auth/config gates. | Official-docs recheck plus separate owner decision for auth/config preflight. |
| Hermes wrapping/dispatching Codex CLI | Evaluate Hermes as a wrapper or dispatcher around Codex CLI while Codex remains primary worker. | 확인 필요; official Hermes support for this pattern must be rechecked. | May depend on `.codex`, `CODEX_HOME`, existing Codex login state, shell shims, or Hermes profiles; no config/auth inspection is approved. | Should preserve Codex plan/credit path only if revalidated; any API or provider fallback is a stop condition. | Could invoke Codex tasks, command execution, file edits, approval prompts, and task continuation; not approved in this document. | Must isolate control-plane, sandbox, input folder, branch, worktree, and session state before any run. | Wrapping Codex does not delegate PR creation, update, merge, cleanup, rollback, settings, secrets, workflows, rulesets, or permissions to Hermes. | Candidate pattern only; Hermes local validation remains deferred. | Read-only availability checks, official-docs recheck, then sandbox smoke-test planning if approved. |
| Codex-only baseline with Hermes outside worker authority | Preserve current Codex-primary workflow while Hermes remains outside execution authority. | Supported by current repo strategy; external official support still matters before any Hermes path. | No new Hermes config/auth writes; no credential/config inspection. | Preserves current Codex cost/credit boundary unless a future task changes it. | No Hermes runtime behavior; current Codex workflow remains owner-gated by task contract. | Existing repo and worktree boundaries continue to apply. | GitHub/control-plane authority remains with approved owner-gated processes. | Safest current baseline. | Continue control-plane planning; use Hermes gates only when owner approves a specific feasibility task. |

## Auth and Config Compatibility Checklist

Before any Hermes-Codex setup, configuration, authentication, or run, an approved gate must answer:

- Whether `~/.hermes/config.yaml` would be read, written, created, or required.
- Whether `~/.hermes/auth.json` would be read, written, created, or required.
- Whether `.codex` state would be read, written, created, or required.
- Whether `CODEX_HOME` would be read, changed, isolated, or required.
- Whether any `auth.json` path would be read, written, created, or required.
- Whether any `.env` file would be read, written, created, or required.
- Whether OAuth, device-code login, browser login, or CLI login would be required.
- Whether API keys would be required.
- Whether provider fallback could occur.
- Whether profile isolation is available and sufficient.
- Whether credential/config writes can be avoided, isolated, or explicitly owner-approved.

If any credential, token, auth file, provider config, or secret-like value would be exposed or handled, stop for a separate owner decision.

## Billing and Credit Compatibility Checklist

Before any integration path is executed, an approved gate must classify:

- Whether ChatGPT/Codex plan credits are used.
- Whether OpenAI API billing is used.
- Whether third-party/provider fallback billing is possible.
- Whether extra provider subscriptions are required.
- Whether any billing path is unknown.

An unknown billing path is a stop condition or `확인 필요` until official docs and owner approval resolve it.

## Runtime Behavior Checklist

Before any run, an approved gate must define and verify:

- Sandbox mode.
- Approval prompts.
- Command execution behavior.
- File edit behavior.
- Model/provider selection.
- Task continuation behavior.
- Evidence packet mapping.
- Stop/fail behavior.
- Runtime logs without credential exposure.

Runtime behavior must be observable enough to preserve source-of-truth classification, stop states, owner gates, and forbidden-action reporting.

## Repo Boundary Checklist

Before any sandbox feasibility run, an approved gate must verify:

- Control-plane repo identity, path, remote, branch, and clean state.
- Sandbox repo identity, path, remote, branch, and clean state if the sandbox is in scope.
- Input folder exclusion.
- Worktree ownership and path boundaries.
- Session ownership and evidence boundaries.
- Branch naming and branch ownership.
- Dirty worktree handling.
- Cleanup boundaries.

Control-plane tasks must not mutate the sandbox repo or input folder unless a future task explicitly targets that path and revalidates its boundary.

## GitHub Authority Boundary

Hermes does not receive GitHub/control-plane authority unless separately approved.

The following remain separately owner-gated:

- PR creation and update.
- Merge.
- Branch cleanup.
- Rollback.
- Settings.
- Secrets.
- Workflows.
- Rulesets.
- Permissions.

Runtime feasibility, provider feasibility, or sandbox validation success does not automatically grant GitHub authority.

## Environment Readiness

Recent local availability findings are point-in-time evidence only and must be revalidated before action:

- Windows Codex availability was previously observed.
- Windows Hermes visibility was not confirmed.
- WSL distro state was not usable or confirmed.
- Hermes local validation remains deferred.

These findings are not durable proof of future availability, version compatibility, auth state, billing path, or runtime safety.

## Required Owner Gates Before Execution

Separate owner approval is required before:

- Official-docs recheck when version-sensitive.
- Read-only local availability checks.
- Config/auth preflight.
- Codex CLI, app-server, SDK, or provider path decision.
- Any Hermes command.
- Any Codex command through Hermes.
- Any setup, configuration, authentication, provider, or model command.
- Any sandbox mutation.
- Any GitHub write.
- Any merge or branch cleanup.
- Any WSL repair or registration.

## Pass / Stopped / Fail / Inconclusive Criteria

| Outcome | Criteria |
| --- | --- |
| `pass` | The approved compatibility, feasibility, or validation gate completes within scope, preserves source-of-truth classification, performs no forbidden action, and answers the gate's required questions. |
| `stopped` | The gate requires setup, config/auth access, credential handling, unknown billing, WSL repair/register, repo mutation outside scope, GitHub authority, or another owner decision before proceeding. |
| `fail` | A forbidden action is performed, such as unauthorized execution, credential handling, setup/config/auth writes, sandbox/input mutation, GitHub authority delegation, merge, cleanup, production/trading use, or Ollama/local-model reopening. |
| `inconclusive` | Official docs, local availability, auth/config behavior, billing path, runtime behavior, repo boundary, or authority boundary cannot be determined from approved evidence. |

## Recommended Next Gates

- Official-docs recheck when version-sensitive.
- Sandbox feasibility preflight planning.
- Owner decision before setup, configuration, authentication, or run.
- Owner decision before any GitHub authority delegation.
- No production or trading use without separate architecture and safety gates.
