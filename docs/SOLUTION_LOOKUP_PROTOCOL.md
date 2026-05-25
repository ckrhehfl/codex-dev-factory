# Solution Lookup Protocol

## Purpose

`docs/solutions/**` reduces repeated mistakes only when future Codex tasks actively consult it before planning, before commit, and during review-fix loops.

Solution entries are advisory until reflected in reviewed project docs or task-specific instructions. They help find known lessons, but they do not override the current task contract, owner decisions, or merged repository policy.

## When Solution Lookup Is Required

Solution lookup is required:

- During task intake for policy or documentation tasks.
- Before planning when the task touches lifecycle states, approval gates, stop states, task contract fields, validation result fields, plan output fields, PR metadata, review-fix process, post-merge lesson capture, risk tiers, allowed files, forbidden files, or forbidden actions.
- Before commit as part of self-review.
- During review-fix classification when review feedback matches a known lesson.

## Lookup Method

Codex should:

1. Search `docs/solutions/**` for keywords related to the task.
2. Check [AGENTS.md](../AGENTS.md) and [Compound Knowledge Base](solutions/README.md).
3. Summarize applicable solution entries.
4. If none apply, record `No applicable solution found.`

Search terms should include task nouns, policy surfaces, stop states, owner gates, PR metadata fields, review-fix topics, and any touched protocol names.

## Applying Lessons

Applicable lessons must be translated into concrete self-review checks.

A lesson must not expand task scope automatically. If a lesson suggests work outside the current task contract, Codex must stop for owner decision instead of broadening the PR.

If a lesson conflicts with current task scope, stop with `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE` or `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`.

## PR Metadata

PR bodies should include:

- Solution lookup result.
- Applicable solution entries.
- How each applicable lesson was applied.
- Or `No applicable solution found.`

For docs-only tasks, the solution lookup result should sit alongside self-review, cross-document consistency, stop-state consistency, and hidden Unicode check results when those checks apply.

## Hidden Unicode Check

Docs-only self-review should check edited files for hidden or bidirectional Unicode control characters.

If suspicious hidden Unicode is found and not intentional, stop with `STOPPED_HIDDEN_UNICODE_FOUND`.

Do not add hidden or bidirectional Unicode control characters to docs unless the task explicitly requires documenting such characters.

## Stop States

The canonical stop-state surface is [Stop-State Registry](STOP_STATE_REGISTRY.md). Codex must stop and report the matching state when one applies:

- `STOPPED_SOLUTION_LOOKUP_SKIPPED`
- `STOPPED_SOLUTION_CONFLICTS_WITH_SCOPE`
- `STOPPED_SOLUTION_REQUIRES_OWNER_DECISION`
- `STOPPED_STOP_STATE_SURFACE_MISMATCH`
- `STOPPED_HIDDEN_UNICODE_FOUND`
- `STOPPED_OWNER_DECISION_REQUIRED`
