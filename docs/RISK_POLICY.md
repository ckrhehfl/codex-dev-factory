# Risk Policy

## Low-Risk Docs-Only Criteria

A task is low-risk docs-only when all of these are true:

- It changes only approved documentation files.
- It does not create workflows, source code, scripts, bots, workers, publishers, or cleanup automation.
- It has no external write side effects.
- It does not handle credentials, secrets, tokens, or account configuration.
- It does not alter trading-related systems or decision logic.
- It ends with visible local status and diff for owner review.

## High-Risk Criteria

A task is high-risk if it includes any of the following:

- GitHub push, PR creation, merge, or branch deletion.
- Workflow, bot, publisher, worker, monitor, or automation implementation.
- Credential, secret, token, account, or deployment configuration handling.
- Trading code, trading system integration, model promotion, risk cap, or order execution behavior.
- Changes that depend on an existing repository being treated as source of truth without revalidation.
- Any irreversible or externally visible action.

## Owner Decision Required Cases

Codex must stop for owner approval before:

- Creating commits.
- Pushing to GitHub.
- Creating or updating PRs.
- Merging.
- Deleting branches.
- Connecting to external repositories.
- Adding automation or implementation files.
- Touching credentials or secret-related material.
- Treating a reference repository as source of truth.

## Forbidden Areas

The docs-first phase forbids:

- GitHub Actions workflows.
- Source code.
- Scripts.
- PR publisher implementation.
- GitHub API write automation.
- Branch cleanup automation.
- Codex worker or harness implementation.
- Discord bot implementation.
- Trading code or trading system integration.
- Credential or secret content.

## Stop States

Codex must stop and report the matching state if one is triggered:

- `STOPPED_FORBIDDEN_FILE_CHANGE`
- `STOPPED_IMPLEMENTATION_INCLUDED`
- `STOPPED_WORKFLOW_INCLUDED`
- `STOPPED_GITHUB_WRITE_AUTOMATION_INCLUDED`
- `STOPPED_BRANCH_CLEANUP_IMPLEMENTED_TOO_EARLY`
- `STOPPED_TRADING_CODE_INCLUDED`
- `STOPPED_LIVE_TRADING_RELATED_CONTENT`
- `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`
- `STOPPED_EXISTING_REPO_ASSUMED_AS_SOURCE_OF_TRUTH`
- `STOPPED_OWNER_DECISION_REQUIRED`
