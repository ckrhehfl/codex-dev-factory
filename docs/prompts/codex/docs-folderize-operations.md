# Codex Prompt: docs-folderize-operations

Task ID: `docs-folderize-operations`
Codex Intelligence: medium/default
Loop contract: preflight-first docs folderization planning loop.

## Required First Gate

Run:

```bash
bash scripts/checks/codex-task-preflight.sh
```

If the helper is missing or fails unexpectedly, stop and report the failure before branch, edit, commit, push, or PR work.

## Canonical References

- `docs/operations/TASK_LIFECYCLE.md`
- `docs/operations/CODEX_TASK_PREFLIGHT.md`
- `docs/operations/CODEX_FIXED_LOOP_CONTRACTS.md`
- `docs/operations/TASK_CONTRACT.md`
- `docs/operations/PR_METADATA_GUARD.md`
- `docs/SOLUTION_LOOKUP_PROTOCOL.md`
- `docs/README.md`

## Stop Rule

If this task appears to require high/xhigh intelligence, stop immediately and return:

```text
owner_action_required:
Codex Intelligence escalation approval required before continuing.
```

## Owner Gates and Forbidden Actions

Owner approval is still required for merge, branch cleanup, GitHub settings/rulesets/branch protection changes, secrets, API keys, credentials, workflow changes, source-code changes outside the approved docs task, Zeroshot adoption, Hermes setup, mutating OMX commands, auto-merge, force push, and branch deletion.

Do not inspect tokens, auth files, cookies, credentials, or secrets. Do not run `gh auth login`. Do not run `omx setup`, `omx doctor`, `omx explore`, `omx sparkshell`, or OMX task/team/runtime/state/config/log commands.

## Task Contract

Plan and execute only the specifically approved docs folderization scope. Do not move files unless the owner explicitly authorizes that exact move set in this task. Preserve updated references to `docs/operations/...`.

Before planning and before PR metadata, inspect `docs/solutions/**` for applicable lessons about lifecycle, prompt contracts, PR metadata, review-fix, Compound, branch cleanup, stop-state consistency, owner gates, automation safety, and docs folderization path updates.

## Output Packet Requirements

Final or PR metadata must include:

- preflight result
- solution lookup result
- changed files
- validation results
- self-review result
- confirmations that no forbidden actions were performed
- stop condition
- explicit owner-gated/manual merge and branch cleanup note
