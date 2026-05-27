# Hermes Evaluation Evidence Template

## Status

| Field | Value |
| --- | --- |
| Purpose | Evidence template for future Hermes runtime/orchestrator evaluation |
| Phase | Evidence template planning |
| Implementation status | `not_started` |
| Risk tier | Low-risk docs-only while this PR remains documentation-only |
| Adoption status | Hermes is not adopted as production authority |
| Scope status | No Hermes install/run/configuration, no Codex runtime connection, no sandbox mutation |
| Source of truth after merge | This repository's merged documentation |

This document is a non-executable template. It does not install, run, or configure Hermes; connect a Codex runtime; execute a Codex worker; mutate the sandbox repository; create workflows; change GitHub settings; add credentials; implement publisher behavior; implement cleanup automation; delete branches; mutate worktrees; enable auto-merge; set up Docker/VPS/Continue/MCP; or touch trading systems.

## Purpose

Future owner-approved Hermes evaluation runs must record enough evidence for reviewers to understand what happened without relying on PR body claims, conversation memory, raw Deep Research, handoff notes, or unclassified local state.

This template defines the evidence packet shape those future evaluations should use. It preserves source-of-truth classification, owner gates, stop conditions, acceptance criteria outcomes, sandbox boundaries, GitHub authority boundaries, cleanup and branch deletion boundaries, and the distinction between unapproved actions and actions explicitly approved inside a future evaluation scope.

## Evidence Packet Identity

A future evidence packet must record:

| Field | Required content |
| --- | --- |
| `evidence_packet_id` | Stable packet id or `TBD`. |
| `evaluation_task_title` | Owner-approved task title. |
| `target_repo` | Target repo label, such as `control-plane` or `sandbox`. |
| `target_github_repo` | GitHub repo full name. |
| `target_local_path` | Local path verified in the run, or `확인 필요`. |
| `evaluation_repo_scope` | `control-plane`, `sandbox`, or `확인 필요`. |
| `related_docs` | Relevant merged repo docs. |
| `related_prs` | Relevant PR numbers/URLs. |
| `run_started_at` | Timestamp or `확인 필요`. |
| `run_completed_at` | Timestamp or `확인 필요`. |
| `actor_tooling_summary` | Human, Codex, Hermes, shell, GitHub tooling, and any approved runtime/tooling used. |
| `evaluation_status` | `pass`, `fail`, `stopped`, or `inconclusive`. |

## Source-Of-Truth Classification

Every evidence item must be classified as one of:

- `local-verified`.
- `authenticated/tool-reported`.
- `public/web-verified`.
- `Deep Research input`.
- `user-reported`.
- `확인 필요`.

PR body claims are evidence from a run, not future source of truth unless revalidated. Deep Research and external input files may inform evaluation questions, but they do not become repository source of truth by themselves.

## Preflight Evidence

Future Hermes evaluation evidence must record:

- Repo path verification command and result.
- Remote URL verification command and result.
- Current branch before evaluation.
- Local HEAD before evaluation.
- Worktree list before evaluation.
- Branch list relevant to the task.
- Clean or dirty worktree state.
- Open PR state, if checked.
- Whether target repo and sandbox/control-plane boundaries were confirmed.
- Any preflight facts that remain `확인 필요`.

## Scope And Approvals

Future evidence packets must explicitly record:

- Approved task scope.
- Allowed files.
- Forbidden files.
- Forbidden actions.
- Risk tier.
- Owner gates satisfied.
- Owner gates not satisfied.
- Actions explicitly approved for this evaluation.
- Actions explicitly not approved.
- Approval source and evidence class.

Apply the PR #44/#45 lesson: when recording stop conditions or forbidden actions, distinguish unapproved or out-of-scope runtime actions from actions that are explicitly owner-approved within a future evaluation task. Do not make future approved evaluation impossible by forcing every Hermes execution, configuration, Codex runtime connection, sandbox mutation, or runtime action to report `stopped` regardless of approved scope.

Approval boundaries must remain precise:

- If an action is unapproved, stop/report.
- If an action exceeds the approved scope, stop/report.
- If the approval boundary is ambiguous, stop/report.
- If an action is explicitly approved and remains inside scope, record it as approved evidence instead of treating it as automatically stopped.

## Hermes Evaluation Evidence Fields

Future evidence packets should record the following without implying this PR ran Hermes:

| Field | Expected value shape |
| --- | --- |
| `hermes_version` | Version, commit, release, or `확인 필요`. |
| `hermes_source_install_method` | Source/install method, `not_approved`, or `확인 필요`. |
| `profile_runtime_state_root` | Isolated profile/state root, `not_approved`, or `확인 필요`. |
| `task_session_identifier` | Session/task id or `확인 필요`. |
| `terminal_backend_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `worktree_session_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `status_output_produced` | Output location/summary, `not_run`, or `확인 필요`. |
| `scheduler_board_subagent_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `memory_skills_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `api_gateway_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `runtime_wrapping_behavior_observed` | Observation, `not_run`, or `확인 필요`. |
| `codex_worker_interaction` | `not_approved` unless separately approved and evidenced. |
| `hidden_authority_or_credential_risk_observed` | Observation, `none_observed`, or `확인 필요`. |

## Codex Worker Boundary Evidence

Future evidence must record:

- Whether Codex remained the patch-producing worker candidate.
- Whether Hermes only orchestrated or wrapped.
- Whether Codex runtime was connected.
- Whether Codex worker execution was approved.
- Whether any generated patch was produced.
- Whether allowed files and forbidden actions were preserved.
- Whether the [Codex Worker Boundary](CODEX_WORKER_BOUNDARY.md) remained intact.

## GitHub Authority Evidence

Future evidence must record whether Hermes or any runtime touched:

- PR creation or update.
- Merge.
- Auto-merge.
- Branch deletion.
- Cleanup.
- Settings, rulesets, required checks, or branch protection.
- Actions or workflows.
- Secrets or credentials.
- Publisher authority.

The default expected value for this docs-only PR is `not_touched` and `not_approved`.

## Sandbox Boundary Evidence

Future evidence must record:

- Whether the sandbox repository was touched.
- Whether the sandbox repository path was verified.
- Whether sandbox mutation was approved.
- Whether the control-plane was modified.
- Whether the correct repo boundary was preserved.
- Before and after repo state if sandbox evaluation is later approved.
- Any sandbox facts that remain `확인 필요`.

## Worktree And Branch Evidence

Future evidence must record:

- Whether worktree creation, deletion, pruning, cleaning, or mutation was attempted.
- Whether branch creation, deletion, cleanup, rename, or force update was attempted.
- Whether any cleanup was report-only or owner-approved.
- Branch state before and after evaluation.
- Worktree state before and after evaluation.
- Whether force delete was used or forbidden.
- Whether branch/worktree ownership was verified or `확인 필요`.

## Credential And Security Evidence

Future evidence must record:

- No secrets, tokens, API keys, or credentials in repo docs.
- No credential store changes unless explicitly approved.
- No environment variable dumps.
- No secret-like placeholders.
- No hidden credential authority granted to Hermes.
- Credential status classified as `확인 필요` unless directly verified within an approved task.

## Outcome Template

| Outcome | Meaning |
| --- | --- |
| `pass` | Criteria were tested and satisfied with sufficient evidence. |
| `fail` | Criteria were tested and not satisfied. |
| `stopped` | Evaluation could not proceed because a stop condition or owner gate was reached. |
| `inconclusive` | Evidence was incomplete, stale, unavailable, or environment-dependent. |

For `stopped`, evidence must include:

- Registry-backed stop code if applicable.
- Plain-language reason.
- Interrupted lifecycle context if known.
- Owner action required.
- Recommended next action.

## Acceptance Criteria Mapping

Future evidence packets must map observations to [Hermes Evaluation Acceptance Criteria](HERMES_EVALUATION_ACCEPTANCE_CRITERIA.md), including:

- Repo identity and path safety.
- Instruction determinism.
- Runtime state isolation.
- Worktree/session behavior.
- GitHub authority boundary.
- Evidence compatibility.
- Stop-state compatibility.
- Sandbox-only evaluation readiness.
- Security and credential boundary.
- Production adoption gate.

Each mapped criterion should record:

- `criterion`.
- `result`: `pass`, `fail`, `stopped`, `inconclusive`, `not_run`, or `not_applicable`.
- `evidence_class`.
- `evidence_summary`.
- `remaining_confirm_needed`.
- `recommended_next_action`.

## Template Skeleton

Future evaluation evidence packets may copy this non-executable Markdown skeleton:

```markdown
# Hermes Evaluation Evidence Packet

## Packet Identity

| Field | Value |
| --- | --- |
| evidence_packet_id | TBD |
| evaluation_task_title | TBD |
| target_repo | TBD |
| target_github_repo | TBD |
| target_local_path | 확인 필요 |
| evaluation_repo_scope | 확인 필요 |
| related_docs | TBD |
| related_prs | TBD |
| run_started_at | 확인 필요 |
| run_completed_at | 확인 필요 |
| actor_tooling_summary | TBD |
| evaluation_status | inconclusive |

## Source-Of-Truth Classification

### local-verified

- TBD

### authenticated/tool-reported

- TBD

### public/web-verified

- TBD

### Deep Research input

- TBD

### user-reported

- TBD

### 확인 필요

- TBD

## Preflight Evidence

| Check | Result | Evidence class | Source |
| --- | --- | --- | --- |
| repo path verification | 확인 필요 | 확인 필요 | TBD |
| remote URL verification | 확인 필요 | 확인 필요 | TBD |
| current branch | 확인 필요 | 확인 필요 | TBD |
| local HEAD | 확인 필요 | 확인 필요 | TBD |
| worktree list | 확인 필요 | 확인 필요 | TBD |
| relevant branch list | 확인 필요 | 확인 필요 | TBD |
| clean/dirty worktree state | 확인 필요 | 확인 필요 | TBD |
| open PR state | 확인 필요 | 확인 필요 | TBD |
| sandbox/control-plane boundary | 확인 필요 | 확인 필요 | TBD |

## Scope And Approvals

| Field | Value |
| --- | --- |
| approved_task_scope | TBD |
| allowed_files | TBD |
| forbidden_files | TBD |
| forbidden_actions | TBD |
| risk_tier | TBD |
| owner_gates_satisfied | TBD |
| owner_gates_not_satisfied | TBD |
| actions_explicitly_approved | TBD |
| actions_explicitly_not_approved | TBD |
| approval_boundary_status | 확인 필요 |

## Hermes Evaluation Evidence

| Field | Value |
| --- | --- |
| hermes_version | 확인 필요 |
| hermes_source_install_method | not_approved |
| profile_runtime_state_root | 확인 필요 |
| task_session_identifier | TBD |
| terminal_backend_behavior_observed | not_run |
| worktree_session_behavior_observed | not_run |
| status_output_produced | not_run |
| scheduler_board_subagent_behavior_observed | not_run |
| memory_skills_behavior_observed | not_run |
| api_gateway_behavior_observed | not_run |
| runtime_wrapping_behavior_observed | not_run |
| codex_worker_interaction | not_approved |
| hidden_authority_or_credential_risk_observed | 확인 필요 |

## Codex Worker Boundary Evidence

| Check | Result | Evidence class |
| --- | --- | --- |
| Codex remained patch-producing worker candidate | 확인 필요 | 확인 필요 |
| Hermes only orchestrated or wrapped | 확인 필요 | 확인 필요 |
| Codex runtime connected | not_approved | 확인 필요 |
| Codex worker execution approved | not_approved | 확인 필요 |
| generated patch produced | not_run | 확인 필요 |
| allowed files and forbidden actions preserved | 확인 필요 | 확인 필요 |

## GitHub Authority Evidence

| Authority surface | Touched state | Approval state | Evidence class |
| --- | --- | --- | --- |
| PR creation/update | not_touched | not_approved | 확인 필요 |
| merge | not_touched | not_approved | 확인 필요 |
| auto-merge | not_touched | not_approved | 확인 필요 |
| branch deletion | not_touched | not_approved | 확인 필요 |
| cleanup | not_touched | not_approved | 확인 필요 |
| settings/rulesets/checks | not_touched | not_approved | 확인 필요 |
| Actions/workflows | not_touched | not_approved | 확인 필요 |
| secrets/credentials | not_touched | not_approved | 확인 필요 |
| publisher authority | not_touched | not_approved | 확인 필요 |

## Sandbox Boundary Evidence

| Check | Result | Evidence class |
| --- | --- | --- |
| sandbox repo touched | not_approved | 확인 필요 |
| sandbox repo path verified | 확인 필요 | 확인 필요 |
| sandbox mutation approved | not_approved | 확인 필요 |
| control-plane modified | 확인 필요 | 확인 필요 |
| correct repo boundary preserved | 확인 필요 | 확인 필요 |
| before/after repo state | not_run | 확인 필요 |

## Worktree And Branch Evidence

| Check | Result | Evidence class |
| --- | --- | --- |
| worktree mutation attempted | not_approved | 확인 필요 |
| branch cleanup/deletion attempted | not_approved | 확인 필요 |
| cleanup report-only or approved | not_approved | 확인 필요 |
| branch state before/after | 확인 필요 | 확인 필요 |
| worktree state before/after | 확인 필요 | 확인 필요 |
| force delete used | not_approved | 확인 필요 |
| ownership verified | 확인 필요 | 확인 필요 |

## Credential And Security Evidence

| Check | Result | Evidence class |
| --- | --- | --- |
| secrets/tokens/API keys in repo docs | 확인 필요 | 확인 필요 |
| credential store changes | not_approved | 확인 필요 |
| environment variable dumps | not_approved | 확인 필요 |
| secret-like placeholders | 확인 필요 | 확인 필요 |
| hidden credential authority | 확인 필요 | 확인 필요 |

## Outcome

| Field | Value |
| --- | --- |
| evaluation_status | inconclusive |
| stop_code | not_applicable |
| stop_reason | not_applicable |
| interrupted_lifecycle_context | not_applicable |
| owner_action_required | TBD |
| recommended_next_action | TBD |

## Acceptance Criteria Mapping

| Criterion | Result | Evidence class | Evidence summary | Remaining 확인 필요 | Recommended next action |
| --- | --- | --- | --- | --- | --- |
| repo identity/path safety | not_run | 확인 필요 | TBD | TBD | TBD |
| instruction determinism | not_run | 확인 필요 | TBD | TBD | TBD |
| runtime state isolation | not_run | 확인 필요 | TBD | TBD | TBD |
| worktree/session behavior | not_run | 확인 필요 | TBD | TBD | TBD |
| GitHub authority boundary | not_run | 확인 필요 | TBD | TBD | TBD |
| evidence compatibility | not_run | 확인 필요 | TBD | TBD | TBD |
| stop-state compatibility | not_run | 확인 필요 | TBD | TBD | TBD |
| sandbox-only evaluation readiness | not_run | 확인 필요 | TBD | TBD | TBD |
| security/credential boundary | not_run | 확인 필요 | TBD | TBD | TBD |
| production adoption gate | not_run | 확인 필요 | TBD | TBD | TBD |
```

## Non-Goals

This PR does not:

- Install, run, or configure Hermes.
- Connect a Codex runtime.
- Execute a Codex worker.
- Mutate the sandbox repository.
- Create workflows or GitHub Actions changes.
- Change GitHub settings, secrets, rulesets, required checks, branch protection, or permissions.
- Implement publisher behavior or GitHub write automation.
- Implement cleanup automation.
- Delete branches or implement branch deletion automation.
- Create, delete, prune, clean, or mutate worktrees.
- Enable auto-merge.
- Set up Docker, VPS, Continue, MCP, or runtime infrastructure.
- Touch trading systems, trading repository design, trading implementation, live trading, risk cap logic, exchange credentials, or model promotion.

## Recommended Next Action

Recommended follow-up:

- `Docs: define Hermes sandbox validation runbook`.

The runbook should remain docs-only unless the owner explicitly approves an actual sandbox evaluation task.

## Solution Lookup Result

Applicable solution lessons were found and applied:

- [PR 44 Hermes Acceptance Review Lessons](solutions/policy/pr44-hermes-acceptance-review-lessons.md): applied by distinguishing unapproved or out-of-scope runtime actions from actions explicitly owner-approved inside a future evaluation scope.
- [Stop-State Consistency](solutions/workflow/stop-state-consistency.md): applied by introducing no new `STOPPED_*` code.
- [Sandbox Evidence Review Lessons](solutions/workflow/sandbox-evidence-review-lessons.md): applied by preserving evidence classification, stopped semantics, owner action, and recommended next action.
- [PR 35 Worktree Harness Result Review Lessons](solutions/PR35_WORKTREE_HARNESS_RESULT_REVIEW_LESSONS.md): applied by keeping template fields, status, owner gates, cleanup boundaries, and recommended next action aligned.

No applicable solution lesson conflicted with this docs-only scope.

## Validation Plan For This PR

Before commit and PR creation, verify:

- `git status --short`.
- `git diff --check`.
- `git diff --cached --check`.
- Changed files are limited to allowed files.
- No sandbox files changed.
- No external input files changed.
- No workflow, settings, secrets, source code, executable scripts, executable schemas, dependency manifests, trading files, publisher files, cleanup automation, branch deletion automation, auto-merge implementation, Docker/VPS, Continue, MCP, Hermes runtime, or Codex runtime files changed.
- Hermes remains evaluation-only.
- No Hermes install, run, or configuration occurred.
- No Codex runtime connection or worker execution occurred.
- No sandbox mutation occurred.
- The template distinguishes unapproved or out-of-scope actions from explicitly owner-approved future evaluation actions.
- Evidence classification is explicit.
- Pass, fail, stopped, and inconclusive outcomes are defined.
- Stop conditions and owner gates are explicit.
- No new `STOPPED_*` code was invented.
- Raw Deep Research text and ChatGPT citation tokens were not pasted into repo docs.
- Cross-document links resolve locally where practical.
- Edited Markdown files contain no hidden or bidirectional Unicode control characters.
- No implementation or execution occurred.
