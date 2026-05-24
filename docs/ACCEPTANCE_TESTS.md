# Acceptance Tests

## Docs-Only First PR Acceptance Checks

The first proposal must pass these local checks before any commit is considered:

- The branch name is `docs/codex-local-factory-vision`.
- The diff is limited to the approved docs scaffold and `.gitignore`.
- No implementation files are present.
- No workflow files are present.
- No credential or secret material is present.
- The existing `institutional-futures-trader` repository is described only as a reference and lessons candidate.
- Commit, push, PR creation, merge, and branch deletion are not performed without explicit owner approval.

## Allowed-Files Check

Allowed files for the first docs-only proposal:

- `README.md`
- `docs/VISION.md`
- `docs/OPERATING_MODEL.md`
- `docs/RISK_POLICY.md`
- `docs/ACCEPTANCE_TESTS.md`
- `docs/ROADMAP.md`
- `.gitignore`

Any other changed file triggers `STOPPED_FORBIDDEN_FILE_CHANGE`.

## No Workflow Check

The proposal must not create or modify workflow files, including GitHub Actions configuration.

If workflow content is introduced, stop with `STOPPED_WORKFLOW_INCLUDED`.

## No Implementation Check

The proposal must not include source code, scripts, worker code, publisher code, bot code, branch cleanup automation, or trading code.

If implementation content is introduced, stop with the most specific matching stop state.

## No Credentials Check

The proposal must not include credentials, secrets, tokens, account identifiers, environment examples containing real values, or instructions to store sensitive values.

If credential or secret content is introduced, stop with `STOPPED_CREDENTIAL_OR_SECRET_CONTENT`.

## Local Cleanup Checklist Placeholder

Before future publication or merge work, define a local cleanup checklist that covers:

- Branch status.
- Untracked files.
- Allowed files.
- Validation commands.
- Diff review.
- Owner approval record.
