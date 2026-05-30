# gh Review Loop Proof

## Purpose

This document records the first small proof that a docs-only pull request can use
`gh` as the control surface for a Codex review loop.

The proof is intentionally narrow. It demonstrates operator procedure and
evidence capture only; it does not implement a review-loop runner, workflow,
GitHub Action, PR publisher, merge automation, branch cleanup automation, or
runtime configuration.

## Proof Boundary

The proof PR may:

- create and update a docs-only branch;
- open a pull request with `gh`;
- post `@codex review` on the pull request;
- read PR comments, reviews, checks, and review-thread state with `gh`;
- fix only in-scope review comments in docs;
- resolve only review threads fixed by the PR; and
- stop before merge.

The proof PR must not:

- change production code, scripts, workflows, repository settings, branch
  protection, rulesets, permissions, secrets, or runtime configuration;
- inspect tokens, credentials, cookies, auth files, API keys, GitHub secrets, or
  secret-looking files;
- enable auto-merge, merge the PR, force push, force delete, or delete branches;
- adopt Zeroshot, Hermes, high intelligence, or very-high intelligence; or
- run mutating OMX commands.

## Review Loop Evidence

Each proof run should preserve these facts in the PR body or final report:

- `gh` readiness result;
- branch name and PR URL;
- changed files;
- review-loop actions performed;
- Codex acknowledgement or review result;
- unresolved review-thread count;
- validation results;
- commit SHA values; and
- explicit confirmation that merge, branch cleanup, secret inspection, GitHub
  settings changes, force push, force delete, and other forbidden actions were
  not performed.

## Stop Condition

The proof is complete when the latest PR head has no major Codex review issues,
unresolved in-scope or blocking review-thread count is zero, any owner-decision
or out-of-scope threads are reported without being resolved, lightweight
validation passes, and the operator stops before merge.
