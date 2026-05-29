# OMX Status Adapter Contract

## Purpose

The OMX status adapter is a future bridge between the local OMX layer and the PM/Codex task loop.

The adapter must report status only. It must not mutate the repository, OMX state, Codex configuration, GitHub, branches, pull requests, tasks, teams, plans, logs, or runtime behavior.

This contract defines the command boundary for a future implementation. It does not implement the adapter and does not approve any new OMX command execution beyond the current safe discovery command.

## Allowed Command Class

The only currently approved OMX command is:

```bash
omx --version
```

Any future command beyond `omx --version` must be explicitly documented as read-only before implementation.

This contract does not approve:

- `omx setup`
- `omx doctor`
- `omx explore`
- `omx sparkshell`
- OMX task, team, runtime, setup, state, plan, log, or mode-mutating commands
- Any command that writes repository files, OMX state, Codex config, GitHub state, branches, pull requests, tasks, teams, plans, logs, or runtime behavior

If command behavior is unclear, the adapter must stop instead of running it.

## Required Adapter Packet

A future adapter should return a stable status packet with these fields:

- `repo_path`: resolved repository path.
- `remote_url`: sanitized repository origin URL, with credentials redacted before reporting.
- `branch`: current branch name.
- `working_tree_status`: clean, dirty, or unknown with evidence.
- `omx_version`: output from `omx --version` when safely available.
- `detected_omx_mode_scope`: detected OMX mode or scope only when safely available without mutation.
- `status_source`: command, file, or local observation used for each status value.
- `evidence_class`: evidence class, such as `local-verified`, `local-observed`, or `unavailable`.
- `warnings`: non-fatal boundary, availability, or ambiguity warnings.
- `stop_condition`: matching stop condition when the adapter refuses to continue.
- `no_mutations_performed`: explicit confirmation that no mutation was performed.

Unknown or unavailable values must be reported as unknown or unavailable rather than inferred from unsafe commands. If the origin URL appears to contain credentials, tokens, or other secret material, the adapter must not report the raw URL; it must report `remote_url` as unavailable or redacted and stop with `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.

## Stop Conditions

The adapter must stop and report with registered stop-state codes when any of these conditions apply:

- `STOPPED_SOURCE_OF_TRUTH_UNCLEAR`: repository path or remote does not match the approved task context.
- `STOPPED_LOCAL_WORKTREE_DIRTY`: the working tree is dirty when a clean tree is required for the status request.
- `STOPPED_OWNER_DECISION_REQUIRED`: the requested status requires an OMX command beyond `omx --version`.
- `STOPPED_OWNER_DECISION_REQUIRED`: an OMX command would mutate repository files, OMX state, Codex config, GitHub state, tasks, teams, plans, logs, or runtime behavior.
- `STOPPED_FORBIDDEN_OR_AMBIGUOUS_FIELD`: command behavior, status source, or read-only boundary is unclear.
- `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`: credentials, secrets, API keys, tokens, auth files, env files, or secret-looking content would be involved.
- `STOPPED_GITHUB_SETTINGS_UNVERIFIED`: GitHub settings, secrets, rulesets, permissions, or repository administration would be required.
- `STOPPED_OWNER_DECISION_REQUIRED`: high or xhigh Codex Intelligence appears necessary.
- `STOPPED_OWNER_DECISION_REQUIRED`: network access is required without an owner gate.

## Owner Gates

The following remain owner-gated and are not approved by this contract:

- High or xhigh Codex Intelligence.
- API keys.
- GitHub secrets.
- GitHub settings, rulesets, or permissions.
- Auto-merge.
- Branch cleanup automation.
- Full Access or `danger-full-access` changes.
- `--yolo`.
- Zeroshot.
- Hermes.
- Docs folderization.
- Mutating OMX commands.

## Next Implementation Gate

Adapter implementation is a separate future PR.

That PR must be reviewed before any OMX command beyond `omx --version` is used. Until then, the local loop remains limited to the existing dry-run/checklist behavior and safe OMX version discovery only.
