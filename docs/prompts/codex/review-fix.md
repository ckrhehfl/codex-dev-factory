# Codex Prompt: review-fix

Task ID: `review-fix`
Codex Intelligence: medium/default
Loop contract: fixed review-fix loop contract.

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
- `docs/operations/GITHUB_OPERATING_POLICY.md`
- `docs/SOLUTION_LOOKUP_PROTOCOL.md`

## Stop Rule

If this task appears to require high/xhigh intelligence, stop immediately and return:

```text
owner_action_required:
Codex Intelligence escalation approval required before continuing.
```

## Owner Gates and Forbidden Actions

Fix only in-scope, actionable review feedback. Leave out-of-scope, unsafe, ambiguous, or owner-decision comments unresolved and report them.

Owner approval is still required for merge, branch cleanup, GitHub settings/rulesets/branch protection changes, secrets, API keys, credentials, workflow changes outside the approved scope, Zeroshot adoption, Hermes setup, mutating OMX commands, auto-merge, force push, and branch deletion.

Do not inspect tokens, auth files, cookies, credentials, or secrets. Do not run `gh auth login`. Do not run `omx setup`, `omx doctor`, `omx explore`, `omx sparkshell`, or OMX task/team/runtime/state/config/log commands.

## Task Contract

Classify each review item as in-scope, out-of-scope, unsafe, duplicate, resolved by existing text, or owner-decision required. Apply only in-scope fixes and preserve references under `docs/operations/...` where operational docs are cited.

Before planning and before PR metadata, inspect `docs/solutions/**` for applicable lessons about lifecycle, prompt contracts, PR metadata, review-fix, Compound, branch cleanup, stop-state consistency, owner gates, automation safety, and docs folderization path updates.

## Output Packet Requirements

Final or PR metadata must include:

- preflight result
- review item classification
- solution lookup result
- changed files
- validation results
- self-review result
- confirmations that no forbidden actions were performed
- unresolved owner-gated items, if any
- stop condition
- explicit owner-gated/manual merge and branch cleanup note
