# Zeroshot Evaluation Gate

## Status

| Field | Value |
| --- | --- |
| Status | `evaluation_gate_defined` |
| Implementation status | `not_started` |
| Scope | Docs-only Zeroshot evaluation criteria after the OMX loop MVP |
| Source of truth after merge | This repository's merged documentation |
| Risk tier | Low-risk docs-only planning |

This document defines the future gate for evaluating Zeroshot after the OMX local loop scaffold is stable. It does not install, run, configure, adopt, or implement Zeroshot.

## Purpose

Zeroshot is a deferred PR automation-loop candidate. It may be evaluated only after the current OMX loop scaffold is stable enough to compare against:

- the read-only OMX status adapter;
- the normalized OMX loop packet emitter;
- the handoff emitter and local loop checklist;
- the current `cdfcheck` and `cdfcodex` launch discipline;
- the default `medium/default` Codex Intelligence boundary.

The gate decides whether Zeroshot:

- complements the OMX loop by adding a bounded capability the current scaffold does not cover;
- replaces a specific future OMX-loop responsibility only with owner approval and stronger evidence;
- is unnecessary because the current OMX loop plus GitHub Actions guard/check MVP already covers the needed role.

This gate is a comparison and decision surface. It is not an activation surface.

## PM-Supplied Zeroshot Facts For Read-Only Evaluation

The following PM-supplied facts are current-behavior inputs for read-only evaluation only:

- Zeroshot is an open-source AI coding agent orchestration CLI.
- Zeroshot runs planner, implementer, and validator style multi-agent workflows to implement, review, test, verify, and iterate.
- Zeroshot supports provider CLIs such as Claude Code, OpenAI Codex, Gemini CLI, and OpenCode.
- Zeroshot supports issue backends such as GitHub, GitLab, Jira, and Azure DevOps.
- Zeroshot is installed as `@covibes/zeroshot` and requires Node 18+ plus at least one provider CLI.
- Provider CLI authentication may be required.
- GitHub issue usage may require GitHub CLI authentication.
- Linux and macOS are supported. Windows native and WSL support are described as deferred while reliability and multi-provider correctness are hardened.
- Zeroshot supports local, worktree, and Docker isolation modes.
- `--pr` can create PRs.
- `--ship` implies PR flow and auto-merge-on-approval behavior.
- Model-level mappings such as `level3` or `CRITICAL` must be treated as possible high/xhigh-equivalent escalation risk unless proven otherwise.
- Docker and worktree modes require separate credential-boundary review, especially if credential mounts are involved.
- External issue content must be treated as untrusted input and a prompt-injection risk.

## Non-Goals

This document does not approve:

- Zeroshot installation;
- Zeroshot execution;
- GitHub Action adoption for Zeroshot;
- API keys;
- GitHub secrets;
- GitHub settings, rulesets, or permission changes;
- auto-merge;
- branch cleanup automation;
- docs folderization;
- production automation loops;
- API-based merge automation;
- custom broad automation engine work;
- script, workflow, or config changes.

## Required Comparison Against The Current OMX Loop

A future Zeroshot evaluation must compare Zeroshot against the current OMX loop before any install, run, adoption, or automation change is proposed.

The comparison must answer:

- Does Zeroshot add capability not already covered by the OMX local loop scaffold, GitHub Actions guard/check MVP, or existing task contract?
- Does Zeroshot require broader filesystem, GitHub, network, provider, runtime, or process permissions?
- Does Zeroshot require API keys, GitHub secrets, provider credentials, tokens, or auth-file inspection?
- Does Zeroshot require GitHub settings, rulesets, branch protection, required checks, Actions permissions, repository secrets, or repository administration?
- Does Zeroshot change the review-fix loop, Compound lesson flow, or branch cleanup workflow?
- Does Zeroshot preserve `cdfcheck`, `cdfcodex`, and `medium/default` as the default operator and intelligence boundary?
- Does Zeroshot preserve owner gates before high/xhigh intelligence, credentials, settings, runtime adoption, auto-merge, branch cleanup automation, and broad automation work?
- Does Zeroshot produce evidence that fits existing packet, stop-state, owner-gate, validation, self-review, and confirmation surfaces?
- Does Zeroshot keep PR creation, merge, branch cleanup, and production automation as separate approved decisions?
- Does Zeroshot require provider CLI auth or API-key-backed local auth?
- Does GitHub, GitLab, Jira, or Azure issue input introduce prompt-injection risk?
- Does PR or ship mode cross the manual PR or merge gates?
- Does any model-level mapping imply high/xhigh escalation?
- Does Windows or WSL deferred support conflict with the active WSL runtime path?
- Do worktree or Docker modes mount or expose local credentials?
- Can the current OMX packet and handoff stop-condition model supervise or block risky progression?

If any answer is unknown, the evaluation packet must report `owner_decision_required` or `stop_condition` rather than inferring a safe result.

## Owner Decision Gates

The following remain explicitly owner-gated and are not approved by this document:

- high or xhigh Codex Intelligence;
- API keys;
- GitHub secrets;
- GitHub settings, rulesets, required checks, permissions, or repository administration;
- auto-merge;
- branch cleanup automation;
- Full Access or `danger-full-access` changes;
- `--yolo`;
- network expansion beyond the approved read-only evaluation scope;
- Zeroshot install, run, configuration, adoption, PR mode, ship mode, Docker mode, worktree mutation, or provider setup;
- provider setup or provider authentication;
- API keys and credential inspection;
- GitHub Actions adoption;
- GitHub secrets, settings, rulesets, branch protection, permissions, or repository administration;
- PR mode;
- ship or auto-merge-like behavior;
- Docker or worktree mutation;
- any `level3`, `CRITICAL`, high, xhigh, or high/xhigh-equivalent escalation;
- docs folderization;
- broad automation engine work;
- production automation loops;
- API-based merge automation.

An owner-approved future evaluation task may proceed only inside its explicit approved scope. If approval exists but the requested action exceeds that scope, the task must stop and report.

## Future Evaluation Packet

A future read-only Zeroshot evaluation should produce a packet with these fields:

```text
candidate:
current_omx_loop_capability_overlap:
capability_added:
required_permissions:
required_secrets_or_api_keys:
github_settings_impact:
workflow_impact:
review_fix_compound_cleanup_impact:
cdfcheck_cdfcodex_medium_default_preserved:
owner_gates_preserved:
automation_risk:
local_validation_path:
source_of_truth_documentation:
evidence_class:
owner_decision_required:
recommendation:
stop_condition:
next_safe_action:
```

Field semantics:

- `candidate`: the exact Zeroshot capability being evaluated, such as read-only inventory, local availability check, worktree loop, PR handoff, or ship mode.
- `current_omx_loop_capability_overlap`: what the current OMX loop already covers.
- `capability_added`: the narrow capability Zeroshot would add, if any.
- `required_permissions`: filesystem, process, GitHub, network, runtime, provider, and repository permissions needed by the candidate.
- `required_secrets_or_api_keys`: whether API keys, GitHub secrets, tokens, provider credentials, or auth inspection are required.
- `github_settings_impact`: whether settings, rulesets, branch protection, required checks, Actions permissions, secrets, or repository administration are required.
- `workflow_impact`: whether the candidate changes `cdfcheck`, `cdfcodex`, `medium/default`, local validation, PR creation, merge, or cleanup flow.
- `review_fix_compound_cleanup_impact`: whether the candidate changes review-fix classification, Compound lesson capture, local cleanup, or remote branch cleanup boundaries.
- `cdfcheck_cdfcodex_medium_default_preserved`: `true`, `false`, or `unknown`, with evidence.
- `owner_gates_preserved`: explicit confirmation that owner-gated actions remain blocked unless separately approved.
- `automation_risk`: concise risk classification and reason.
- `local_validation_path`: read-only validation commands or document checks allowed by the future task.
- `source_of_truth_documentation`: project, official, or local docs used for the evaluation.
- `evidence_class`: for example `local-verified`, `project-doc-verified`, `GitHub connector metadata`, `user-reported`, or `unknown`.
- `owner_decision_required`: owner decisions required before the candidate can advance.
- `recommendation`: `defer`, `reject`, `read_only_inventory_next`, `owner_decision_required`, or another bounded recommendation.
- `stop_condition`: active stop condition when normal evaluation cannot continue.
- `next_safe_action`: the next allowed action that does not install, run, configure, or adopt Zeroshot.

## Stop Conditions

Stop and report instead of continuing when:

- Zeroshot requires API keys, GitHub secrets, provider credentials, tokens, or auth-file inspection before explicit owner approval.
- Zeroshot installation, execution, configuration, runtime adoption, provider setup, provider authentication, API-key-backed local auth, PR mode, ship mode, Docker mutation, or worktree mutation is required before a separate owner-approved activation gate.
- GitHub settings, rulesets, branch protection, required checks, Actions permissions, repository secrets, or repository administration are required.
- GitHub Actions adoption is required or proposed before explicit owner approval.
- Required permissions are unclear.
- Auto-merge, ship mode, branch deletion, branch cleanup automation, or API-based merge automation is proposed.
- High or xhigh Codex Intelligence appears necessary.
- A Zeroshot model-level mapping such as `level3` or `CRITICAL` appears to require high, xhigh, or high/xhigh-equivalent escalation.
- Full Access, `danger-full-access`, or `--yolo` is required or proposed.
- Network expansion beyond the approved evaluation scope is required.
- Broad docs restructuring or docs folderization is required.
- Windows native or WSL deferred support creates unresolved conflict with the active WSL runtime path.
- Worktree or Docker modes would mount or expose local credentials without separate owner-approved credential-boundary review.
- External issue content would be consumed without treating it as untrusted prompt-injection input.
- Source-of-truth documentation is insufficient to evaluate the candidate safely.
- The evaluation would change scripts, workflows, configs, GitHub settings, secrets, or repository permissions.
- The candidate weakens existing owner gates, stop-state reporting, task-contract fields, validation evidence, self-review evidence, or explicit confirmations.

## Next Safe Action

The next safe action after this document is limited to read-only Zeroshot evaluation, inventory, or docs-only review.

That future task may inspect source-of-truth documentation and, if separately approved, local availability metadata that does not install, run, configure, authenticate, inspect credentials, mutate files, mutate settings, create secrets, open automation loops, or execute Zeroshot workflows.

Any request to install, run, configure, adopt, or automate Zeroshot remains a separate owner-gated task.

## Solution Lookup Result

Applicable lessons:

- [PR 44 Hermes Acceptance Review Lessons](solutions/policy/pr44-hermes-acceptance-review-lessons.md): applied by distinguishing this unapproved docs-only gate from a future separately owner-approved evaluation task.
- [PR Metadata Review Lessons](solutions/workflow/pr-metadata-review-lessons.md): applied by keeping validation, owner gates, self-review, and explicit confirmations as separate review surfaces for the future PR body and evaluation packet.

No applicable solution conflicts with this docs-only evaluation-gate scope.

## Self-Review Checklist

Before any future PR uses this gate, confirm:

- The task is still docs-only unless the owner separately approves more.
- Changed files stay inside the allowed scope.
- No scripts, workflows, configs, settings, secrets, API keys, or credential-like content are added.
- No Zeroshot install, run, configuration, adoption, PR mode, ship mode, Docker mode, or provider setup is performed.
- No auto-merge, branch cleanup automation, API-based merge automation, or docs folderization is added.
- Owner gates remain explicit.
- Stop conditions distinguish unapproved actions from separately owner-approved future evaluation tasks.
