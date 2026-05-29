# Codex Task Preflight

The standard task lifecycle that uses this helper is defined in [Task Lifecycle](TASK_LIFECYCLE.md).

Run the repo-local Codex task preflight before normal `cdfcodex` work and during read-only checks with `cdfcheck`:

```bash
bash scripts/checks/codex-task-preflight.sh
```

The helper is read-only. It reports the repository path, branch, clean worktree state, sanitized origin URL, required local Git config, Node/npm/Codex/OMX versions, `.omx/state` ignore status, `repo-guard`, and OMX handoff readiness. It does not verify GitHub branch protection, rulesets, permissions, or other GitHub settings, and it does not change them. GitHub settings remain owner-gated and manual.

The default ready state is local `main`, clean worktree, and a synced-looking `main...origin/main` status. During PR validation on a feature branch, the helper is expected to halt with `stop_condition: branch_not_main`; treat that specific feature-branch halt as confirmation that the main-readiness gate is active, not as a PR-validation failure.

For normal preflight before starting branch, edit, commit, push, or PR progression from `main`, any `codex_task_preflight_status: halt` blocks progression until the reported `stop_condition` is resolved.
