# UEF Keycloak Ops Runbook

This runbook captures the repeatable tasks used during the `uef` maintenance cycle.

## 1) Automated upstream sync (Keycloak upstream -> uef)

### Option A: Run manually

```bash
bash misc/scripts/sync-upstream-main.sh uef
```

To auto-open PR after creating sync branch:

```bash
OPEN_PR=1 bash misc/scripts/sync-upstream-main.sh uef
```

### Option B: Run by workflow

Workflow file: `.github/workflows/upstream-sync.yml`

- Scheduled: weekly (Monday, 02:00 UTC)
- Also supports manual trigger with `base_branch` input.

Expected output:

- Branch `sync/upstream-main-<timestamp>`
- PR from sync branch into `uef`

## 2) Resolve sync conflicts safely

When merge conflicts happen:

1. Stay on sync branch created by the script.
2. Resolve only conflict files first (do not refactor unrelated files).
3. Validate targeted areas (themes/JS/workflows if touched).
4. Push sync branch and continue with PR checks.

## 3) WebAuthn quick smoke test on dev container

Script: `misc/scripts/smoke-webauthn.sh`

```bash
bash misc/scripts/smoke-webauthn.sh
```

What it validates:

- Boot dev container with `university` theme mounted.
- Create a test user with required action `webauthn-register`.
- Execute login + required-action redirect flow.
- Confirm rendered page marker `data-page-id="login-webauthn-register"`.
- Ensure no template 500 in logs (`NonStringOrTemplateOutputException` / `webauthn-register.ftl` failure).

Useful overrides:

```bash
HOST_PORT=19080 IMAGE=cr.uef.edu.vn/uef/keycloak:26.5.4-uef.1 bash misc/scripts/smoke-webauthn.sh
KEEP_CONTAINER=1 bash misc/scripts/smoke-webauthn.sh
```

## 4) Docker tag policy (upstream + UEF customization)

Recommended immutable release format:

- `<upstream-version>-uef.<revision>`
- Example: `26.5.4-uef.1`

Suggested mutable channel tags:

- `<upstream-version>-uef`
- `<major.minor>-uef`
- `latest-uef`

When upstream changes (`26.5.4 -> 26.5.5`), reset revision to `.1`.
When only UEF customization changes, increase revision (`.2`, `.3`, ...).

## 5) Suggested release checklist

1. Run sync script (manual or workflow).
2. Open/update PR into `uef`.
3. Fix CI root causes only (ignore cascading status checks).
4. Run `smoke-webauthn.sh`.
5. Merge PR when checks are green.
6. Optional cleanup of stale review/sync branches.

## 6) Notes and known pitfalls

- `account-console` may require PKCE and strict redirect URI handling; smoke script already handles PKCE against `security-admin-console`.
- In shell, avoid `!` in inline passwords unless escaped (history expansion).
- Prefer mounting theme in smoke test to validate current working tree before publishing image.
