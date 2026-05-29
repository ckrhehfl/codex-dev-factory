# OMX Loop Packet Schema

## Purpose

The OMX loop packet is the stable status packet that PM/Codex should consume when interpreting adapter-backed local loop state.

The packet is status and reporting only. It is not an execution instruction, approval, or automation trigger. Consumers must not treat it as permission to merge, enable auto-merge, clean branches, change GitHub settings, run mutating OMX commands, or continue past an active stop condition.

## Packet Source And Normalization

The current status source is the read-only OMX status adapter, with checklist context from the local loop helper:

- `scripts/checks/omx-status-adapter.sh`
- `scripts/checks/omx-loop-mvp.sh`

Those scripts do not yet emit this normalized packet shape directly. The adapter currently emits raw status fields such as `adapter_name`, `adapter_version`, `repo_path`, `remote_url`, `branch`, `working_tree_status`, `omx_version`, `detected_omx_mode_scope`, `status_source`, `evidence_class`, `warnings`, `stop_condition`, and `no_mutations_performed`. The helper prints a checklist gate around that status instead of filling packet fields.

PM/Codex should treat this schema as the stable normalized consumption contract over the adapter-backed loop, not as a byte-for-byte copy of current script output. Until the scripts are separately approved to emit this packet directly, the consuming layer maps:

- `adapter_name` and `adapter_version` into `status_source` evidence.
- `remote_url` into `remote_url_sanitized` after preserving redaction.
- `detected_omx_mode_scope` into `status_source` evidence when safely available.
- helper pass/stop output into `checklist_gate_result`.
- adapter warnings and stop state into `warnings`, `stop_condition`, and `next_safe_action`.
- helper gate failure or unknown gate state into `checklist_gate_result`, `warnings`, and a non-empty `stop_condition` when the helper failure means normal loop progression is unsafe.

The only approved OMX command remains:

```bash
omx --version
```

Any future OMX command beyond `omx --version` requires a separate reviewed contract and owner gate before implementation or use. Unknown values must be reported as unknown, unavailable, or `확인 필요`; they must not be inferred through unsafe commands.

## Required Normalized Fields

Every normalized OMX loop packet consumed by PM/Codex must include these fields:

- `packet_type`
- `packet_version`
- `repo_path`
- `remote_url_sanitized`
- `branch`
- `working_tree_status`
- `omx_version`
- `status_source`
- `evidence_class`
- `warnings`
- `stop_condition`
- `no_mutations_performed`
- `checklist_gate_result`
- `next_safe_action`

## Field Semantics

`packet_type` identifies this packet shape. Use `omx_loop_status_packet`.

`packet_version` identifies the schema version consumed by PM/Codex. Start with `1.0.0`; incompatible field changes require a new version.

`repo_path` is the resolved local repository path used for the status check.

`remote_url_sanitized` is the origin URL after credential-like material is removed or redacted. PM/Codex must not request or display raw credential-bearing remotes.

`branch` is the current local branch at the time of the status check.

`working_tree_status` is `clean`, `dirty`, or `unknown`. A dirty or unknown value may be accompanied by a stop condition when clean state is required.

`omx_version` is the first safely available line from `omx --version`, or `unavailable` when the approved read-only command cannot provide it.

`status_source` names the local commands, files, or observations used to populate the packet. It must not include secrets, tokens, auth file contents, or unapproved command output.

`evidence_class` classifies the evidence backing the packet. Use the smallest truthful class.

`warnings` is a list of non-fatal concerns, boundary notes, or compatibility warnings. Use an empty list when there are no warnings.

`stop_condition` is the active stop code when normal progression must stop. Use an empty string when no stop condition exists. For compatibility with older adapter output, PM/Codex may treat legacy `none` as empty only when all other fields are safe.

`no_mutations_performed` must be `true` for this packet. A packet that required mutation is invalid for this schema.

`checklist_gate_result` reports whether the loop checklist gate is safe to present or continue from. Use concise values such as `passed`, `stopped`, or `확인 필요`. Any value other than `passed` is a halt signal unless a separately reviewed contract defines a narrower non-blocking meaning.

`next_safe_action` is the conservative next action PM/Codex may report. It must not authorize mutating OMX commands, merge, auto-merge, branch cleanup automation, GitHub settings changes, or scope expansion. When `checklist_gate_result` is not `passed`, this field should tell PM/Codex to report the gate failure and stop until the failing precondition is resolved.

## Stop-Condition Handling

Any non-empty `stop_condition` stops normal progression. A `checklist_gate_result` other than `passed` also stops normal progression, even when the adapter did not emit a stop condition. PM/Codex must report the stop condition or checklist gate failure and only ask the owner when owner input is actually needed to resolve it.

When `stop_condition` is non-empty or `checklist_gate_result` is not `passed`, PM/Codex must not continue into:

- branch creation
- document edits
- commits
- push
- PR creation
- merge
- auto-merge
- branch cleanup
- GitHub settings changes
- mutating OMX commands

The packet is an interruption signal, not a retry instruction. Normal progression can resume only after the stop reason is resolved and the relevant status checks are revalidated.

## Evidence Classes

Use these evidence classes when they apply:

- `local-verified`: directly observed by local commands run in the current session.
- `GitHub connector metadata`: reported by the GitHub connector, not independently verified by local commands.
- `user-reported`: provided by the owner or user without fresh local verification.
- `확인 필요`: not safely verified yet, or requires a separate owner-approved check.

## Safety Boundaries

This schema preserves owner gates for:

- high or xhigh Codex Intelligence
- API keys
- GitHub secrets
- GitHub settings, rulesets, or permissions
- auto-merge
- branch cleanup automation
- Full Access or `danger-full-access` changes
- `--yolo`
- Zeroshot
- Hermes
- docs folderization
- mutating OMX commands

This schema does not approve scripts, workflows, config changes, GitHub settings changes, new automation behavior, API-based merge automation, auto-merge, branch cleanup automation, Zeroshot, Hermes, or docs folderization.

## Example Packet

```text
packet_type: omx_loop_status_packet
packet_version: 1.0.0
repo_path: /mnt/c/Dev/codex-dev-factory
remote_url_sanitized: git@github.com:ckrhehfl/codex-dev-factory.git
branch: main
working_tree_status: clean
omx_version: omx 0.18.6
status_source:
  - git rev-parse --show-toplevel
  - git remote get-url origin
  - git branch --show-current
  - git --no-optional-locks status --short --branch --untracked-files=all
  - omx --version
evidence_class: local-verified
warnings: []
stop_condition: ""
no_mutations_performed: true
checklist_gate_result: passed
next_safe_action: create the approved bounded task branch from clean current main
```
