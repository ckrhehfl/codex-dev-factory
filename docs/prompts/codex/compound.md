# Codex Prompt: compound

Task ID: `compound`
Codex Intelligence: medium/default
Loop contract: post-merge Compound lesson capture loop.

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
- `docs/solutions/README.md`

## Stop Rule

If this task appears to require high/xhigh intelligence, stop immediately and return:

```text
owner_action_required:
Codex Intelligence escalation approval required before continuing.
```

## Owner Gates and Forbidden Actions

Compound output is advisory until represented in reviewed repository docs. Do not treat a prior session, PR comment, or generated lesson as source of truth unless revalidated against canonical docs and the approved task scope.

Owner approval is still required for merge, branch cleanup, GitHub settings/rulesets/branch protection changes, secrets, API keys, credentials, workflow changes, source-code changes outside the approved lesson task, Zeroshot adoption, Hermes setup, mutating OMX commands, auto-merge, force push, and branch deletion.

Do not inspect tokens, auth files, cookies, credentials, or secrets. Do not run `gh auth login`. Do not run `omx setup`, `omx doctor`, `omx explore`, `omx sparkshell`, or OMX task/team/runtime/state/config/log commands.

## Task Contract

Capture only durable, reusable post-merge or review-fix lessons under the approved `docs/solutions/**` path. Preserve required solution sections: Problem, Cause, Solution, Prevention, Related PRs, and Follow-up status.

Before planning and before PR metadata, inspect `docs/solutions/**` for applicable existing lessons so the new lesson does not duplicate or conflict with current guidance. Preserve references to operational docs under `docs/operations/...`.

## Output Packet Requirements

Final or PR metadata must include:

- preflight result
- source evidence used for the lesson
- solution lookup result
- changed files
- validation results
- self-review result
- confirmations that no forbidden actions were performed
- stop condition
- explicit owner-gated/manual merge and branch cleanup note
