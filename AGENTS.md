# Repository Guidance

## Project Identity

This repository is the docs-first control-plane candidate for a Codex-first, autonomous-by-default development factory.

The existing `ckrhehfl/institutional-futures-trader` repository is only a reference and lessons candidate. It is not source of truth for this repository unless the owner explicitly revalidates and approves it for a specific task.

## Operating Rules

Low-risk docs-only PRs may proceed through self-review, commit, push, and PR creation without another commit approval when the task contract explicitly allows that flow.

Merge remains separate unless explicitly requested.

After merge, local branch and worktree cleanup uses the owner's standard cleanup instruction. Cleanup must not force delete branches.

Review-fix loops must classify comments and fix only in-scope items. Out-of-scope, unsafe, or owner-decision comments remain unresolved until the owner decides.

## Compound Knowledge Base

Durable post-merge lessons belong under `docs/solutions/**`.

Compound output is advisory, not source of truth. A lesson becomes repository policy only when captured through a reviewed docs-only PR.

New or changed Compound lessons must stay inside the task's allowed docs-only paths. Do not let Compound write outside the approved scope.
