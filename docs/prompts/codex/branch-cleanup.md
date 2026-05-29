# Codex Prompt: branch-cleanup

Task ID: `branch-cleanup`
Codex Intelligence: medium/default
Loop contract: owner-gated branch cleanup loop.

## Required First Gate

Run:

```bash
bash scripts/checks/codex-task-preflight.sh
```

If the helper is missing or fails unexpectedly, stop and report the failure before any cleanup planning or local action.

## Canonical References

- `docs/operations/TASK_LIFECYCLE.md`
- `docs/operations/CODEX_TASK_PREFLIGHT.md`
- `docs/operations/CODEX_FIXED_LOOP_CONTRACTS.md`
- `docs/operations/TASK_CONTRACT.md`
- `docs/operations/GITHUB_OPERATING_POLICY.md`
- `docs/operations/RISK_POLICY.md`
- `docs/SOLUTION_LOOKUP_PROTOCOL.md`

## Stop Rule

If this task appears to require high/xhigh intelligence, stop immediately and return:

```text
owner_action_required:
Codex Intelligence escalation approval required before continuing.
```

## Owner Gates and Forbidden Actions

Branch cleanup is owner-gated and manual unless the owner explicitly authorizes the exact local cleanup command in the current task.

Do not delete branches, force push, enable auto-merge, merge PRs, change GitHub settings/rulesets/branch protection, add secrets, inspect credentials, run `gh auth login`, run mutating OMX commands, or perform cleanup automation. Do not run `git branch -d`, `git branch -D`, `git push --delete`, `git reset --hard`, or `git clean` without exact owner authorization for this cleanup task.

Do not run `omx setup`, `omx doctor`, `omx explore`, `omx sparkshell`, or OMX task/team/runtime/state/config/log commands.

## Task Contract

Report current branch and worktree state using safe read-only commands. Confirm merge state only through approved local or authenticated tooling already available. If authentication or authority is missing, stop and report the exact manual cleanup recommendation without performing deletion.

Before planning and before final output, inspect `docs/solutions/**` for applicable lessons about lifecycle, branch cleanup, stop-state consistency, owner gates, automation safety, and docs folderization path updates. Preserve references to operational docs under `docs/operations/...`.

## Output Packet Requirements

Final output must include:

- preflight result
- solution lookup result
- current branch and worktree state
- merge/readiness evidence or verification gap
- proposed manual cleanup command, if safe to recommend
- confirmations that no forbidden actions were performed
- stop condition
- explicit owner-gated/manual merge and branch cleanup note
