# Compound Knowledge Base

## Purpose

`docs/solutions/**` stores durable solved-problem lessons from completed work, review-fix loops, and post-merge lesson capture.

These notes help future Codex runs find reusable workflow, policy, safety, and developer-experience patterns without treating prior sessions as automatic source of truth.

Compound output is advisory. The repository source of truth remains the reviewed documentation that is merged through a docs-only PR.

The [Solution Lookup Protocol](../SOLUTION_LOOKUP_PROTOCOL.md) defines when future tasks must search this knowledge base and how applicable lessons are reported.

## When to Add a Solution

Add a solution when a review-fix or post-merge lesson reveals a reusable pattern, including:

- Workflow patterns that should change future prompts or self-review.
- Policy consistency issues that should be checked again.
- Safety lessons around stop states, allowed files, forbidden actions, or owner gates.
- Developer-experience lessons that make future work easier to execute safely.

## When Not to Add a Solution

Do not add a solution for:

- Reviewer preference only.
- One-off wording changes.
- Lessons already fully captured by the merged PR.
- Notes that require owner decision before they can become guidance.

## Required Solution Sections

Each solution should include:

- Problem.
- Cause.
- Solution.
- Prevention.
- Related PRs.
- Follow-up status.

## Categories

- [workflow](workflow/): repeatable process, review, cleanup, and lesson-capture patterns.
- [policy](policy/): repository policy, risk, source-of-truth, and governance patterns.
- [developer-experience](developer-experience/): local ergonomics, clarity, and operational usability lessons.
