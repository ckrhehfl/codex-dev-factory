# Risk Policy

## Low-Risk Docs-Only Criteria

A task is low-risk docs-only when all of these are true:

- It changes only approved documentation files.
- It does not create workflows, source code, scripts, bots, workers, publishers, or cleanup automation.
- It has no external write side effects.
- It does not handle credentials, secrets, tokens, or account configuration.
- It does not alter trading-related systems or decision logic.
- It ends with visible local status and diff for owner review.
- Its task contract explicitly permits commit, push, and PR creation after self-review if those actions are requested.

## High-Risk Criteria

A task is high-risk if it includes any of the following:

- GitHub push or PR creation that is not explicitly permitted by a low-risk docs-only task contract.
- Merge or branch deletion.
- GitHub repository settings or branch protection changes that have not been verified and approved.
- Workflow, bot, publisher, worker, monitor, or automation implementation.
- CLI implementation, task YAML files, or schemas created before the owner approves implementation.
- Credential, secret, token, account, or deployment configuration handling.
- Trading code, trading system integration, model promotion, risk cap, or order execution behavior.
- Changes that depend on an existing repository being treated as source of truth without revalidation.
- Any irreversible or externally visible action.

## Owner Decision Required Cases

Codex must stop for owner approval before:

- Creating commits, unless a low-risk docs-only task contract explicitly permits commit after self-review.
- Pushing to GitHub, unless a low-risk docs-only task contract explicitly permits push after self-review.
- Creating or updating PRs, unless a low-risk docs-only task contract explicitly permits PR creation after self-review.
- Merging.
- Deleting branches.
- Changing or relying on GitHub repository settings, branch protection, required checks, or auto-merge eligibility.
- Connecting to external repositories.
- Adding automation or implementation files.
- Touching credentials or secret-related material.
- Treating a reference repository as source of truth.

Low-risk docs-only commit, push, and PR creation may proceed without a second approval only when the task contract explicitly allows it and self-review passes. Merge remains separately gated.

## Forbidden Areas

The docs-first phase forbids:

- GitHub Actions workflows.
- Source code.
- Scripts.
- CLI implementation.
- Task YAML files or schemas before the approved implementation phase.
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
- `STOPPED_TASK_CONTRACT_INCOMPLETE`
- `STOPPED_SOURCE_OF_TRUTH_UNVERIFIED`
- `STOPPED_PR_METADATA_INCOMPLETE`
- `STOPPED_SELF_REVIEW_FAILED`
- `STOPPED_PHASE2_SCOPE_EXPANDED`
- `STOPPED_CLI_IMPLEMENTATION_INCLUDED`
- `STOPPED_TASK_YAML_CREATED_TOO_EARLY`
- `STOPPED_SCHEMA_CREATED_TOO_EARLY`
- `STOPPED_CODE_INCLUDED`
- `STOPPED_GITHUB_SETTINGS_UNVERIFIED`
- `STOPPED_BRANCH_PROTECTION_UNVERIFIED`
- `STOPPED_REQUIRED_CHECKS_NOT_READY`
- `STOPPED_BRANCH_NOT_MERGED`
- `STOPPED_BRANCH_PROTECTED`
- `STOPPED_LOCAL_WORKTREE_DIRTY`
- `STOPPED_CLEANUP_UNSAFE_FORCE_REQUIRED`
