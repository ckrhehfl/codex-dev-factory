# Acceptance Tests

## Docs-Only First PR Acceptance Checks

The first proposal must pass these local checks before any commit is considered:

- The branch name is `docs/codex-local-factory-vision`.
- The diff is limited to the approved docs scaffold and `.gitignore`.
- No implementation files are present.
- No workflow files are present.
- No credential or secret material is present.
- The existing `institutional-futures-trader` repository is described only as a reference and lessons candidate.
- Commit, push, PR creation, merge, and branch deletion are not performed without explicit owner approval for the first proposal.

## Allowed-Files Check

Allowed files for the first docs-only proposal:

- `README.md`
- `docs/VISION.md`
- `docs/operations/OPERATING_MODEL.md`
- `docs/operations/RISK_POLICY.md`
- `docs/ACCEPTANCE_TESTS.md`
- `docs/ROADMAP.md`
- `.gitignore`

Any other changed file triggers `STOPPED_FORBIDDEN_FILE_CHANGE`.

## Task Contract Check

Every future task should include the required fields from [Task Contract](operations/TASK_CONTRACT.md):

- Task title and objective.
- Source-of-truth assumptions.
- Scope and Non-goals.
- Allowed files and Forbidden files/actions.
- Validation plan and Stop conditions.
- Risk tier and Owner decision requirements.

If required task metadata is missing, stop with `STOPPED_TASK_CONTRACT_INCOMPLETE`.

Low-risk docs-only tasks may commit, push, and create a PR after self-review only when the task contract explicitly allows that flow. Merge and branch deletion remain separate owner-approved actions.

## No Workflow Check

The proposal must not create or modify workflow files, including GitHub Actions configuration.

If workflow content is introduced, stop with `STOPPED_WORKFLOW_INCLUDED`.

## No Implementation Check

The proposal must not include source code, scripts, worker code, publisher code, bot code, branch cleanup automation, or trading code.

If implementation content is introduced, stop with the most specific matching stop state.

## No Credentials Check

The proposal must not include credentials, secrets, tokens, account identifiers, environment examples containing real values, or instructions to store sensitive values.

If credential or secret content is introduced, stop with `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.

## Local Cleanup Checklist Placeholder

Before future publication or merge work, define a local cleanup checklist that covers:

- Branch status.
- Untracked files.
- Allowed files.
- Validation commands.
- Diff review.
- Owner approval record.

## Sandbox Validation Checks

Sandbox validation is defined in [Sandbox Validation](SANDBOX_VALIDATION.md). The first sandbox loop must stay docs-only and verify:

- PR metadata includes Scope, Non-goals, Allowed files, Validation plan, and Stop conditions.
- Changed files stay inside the allowed-file list.
- No workflow, implementation, credential, secret, trading logic, or live trading boundary change is introduced.
- GitHub merge state is confirmed before cleanup.
- Remote head branch cleanup is verified through GitHub settings or a stop state is reported.
- Local branch/worktree cleanup completes without force delete.

Sandbox validation evidence is defined in [Sandbox Validation Evidence Contract](SANDBOX_VALIDATION_EVIDENCE.md). Future sandbox runs should record source-of-truth, lifecycle, PR, review, merge, cleanup, guard, lesson-review, owner-decision, unknown, and stop-state evidence before declaring a pass/fail/blocking result.

## PR Metadata Check

PR bodies should include Scope, Non-goals, Allowed files, Forbidden files/actions when present, Validation plan, Stop conditions, Risk tier, Self-review result, and Confirmations. Missing metadata triggers `STOPPED_PR_METADATA_INCOMPLETE`.

When solution lookup is required, PR bodies should include Solution lookup result, applicable solution entries, and how each applicable lesson was applied, or `No applicable solution found.`

## Phase 2 CLI Skeleton Checks

Phase 2 CLI skeleton work is defined in [Phase 2 CLI Skeleton Contract](PHASE2_CLI_SKELETON.md). Phase 2 docs may describe future command surfaces, but must not add CLI implementation, task YAML files, schemas, workflows, source code, or automation.

Phase transition readiness is defined in [Phase 1/2 Readiness Audit](PHASE_READINESS_AUDIT.md). Before sandbox repository planning, sandbox validation, or Phase 2 implementation, readiness evidence should show that core docs are discoverable, operational policy surfaces do not contradict each other, active `STOPPED_*` codes are registry-backed, safety fields are preserved, PR metadata includes Self-review result and Confirmations, and owner gates remain explicit.

## Local Task Format Checks

Local task format work is defined in [Local Task Format Contract](LOCAL_TASK_FORMAT.md). Format docs may describe future fields, but must not add actual task YAML files, schema files, parser code, CLI implementation, source code, workflows, or automation.

## Task Validation Result Checks

Task validation result work is defined in [Task Validation Result Contract](TASK_VALIDATION_RESULT.md). Validation result docs may describe future output sections, but must not add actual validation result files, task YAML files, schema files, parser code, CLI implementation, source code, workflows, or automation.

Validation result output must preserve safety-critical task fields. If `forbidden_files` or `forbidden_actions` disappear during task validation, planning, status reporting, or PR metadata drafting, stop with `STOPPED_SAFETY_FIELD_DROPPED`.

## Plan Output Contract Checks

Plan output work is defined in [Plan Output Contract](PLAN_OUTPUT_CONTRACT.md). Plan docs may describe future output sections, but must not add actual plan files, task YAML files, schema files, parser code, CLI implementation, source code, workflows, or automation.

Plan output must preserve safety-critical task fields. If `forbidden_files` or `forbidden_actions` disappear during task validation, planning, status reporting, or PR metadata drafting, stop with `STOPPED_SAFETY_FIELD_DROPPED`.

## Compound Knowledge Base Checks

Compound knowledge base work is defined in [Compound Knowledge Base](solutions/README.md). It may add docs-only lesson files under `docs/solutions/**`, but must not add source code, scripts, workflows, automation, or files outside the task's allowed paths.

Compound output is advisory. New or changed lessons become repository guidance only through reviewed docs-only PRs.

If a lesson introduces or references a `STOPPED_*` code, compare it against the relevant local Stop States section and [Risk Policy](operations/RISK_POLICY.md). Missing stop-state surface coverage triggers `STOPPED_STOP_STATE_SURFACE_MISMATCH`.

## Solution Lookup Checks

Solution lookup is defined in [Solution Lookup Protocol](SOLUTION_LOOKUP_PROTOCOL.md). Required lookup must search `docs/solutions/**`, check AGENTS.md and [Compound Knowledge Base](solutions/README.md), and translate applicable lessons into self-review checks.

If solution lookup is skipped when required, stop with `STOPPED_SOLUTION_LOOKUP_SKIPPED`.

If an applicable lesson conflicts with current task scope or requires owner decision, stop with `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE` or `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.

## Hidden Unicode Check

Docs-only self-review should check edited files for hidden or bidirectional Unicode control characters.

If suspicious hidden Unicode is found and not intentional, stop with `STOPPED_HIDDEN_UNICODE_FOUND`.
