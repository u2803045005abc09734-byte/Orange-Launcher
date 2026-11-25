# Orange Launcher

An independently branded community launcher fork for Minecraft, based on the open-source OneLauncher 2.12.1 source.

## Repository layout

- `source/` — complete assembled Orange Client Rust source.
- `patch/` and `branding/` — source changes and Orange Client assets used during assembly.
- `.github/workflows/orange-client-build.yml` — Windows build, Microsoft Defender scan and SHA-256 checksums.
- `.github/workflows/orange-client-secure-release.yml` — optional Authenticode-signed release workflow.
- `.github/workflows/rust-security-audit.yml` — scheduled Rust dependency advisory checks.
- `.github/dependabot.yml` — weekly Cargo and GitHub Actions dependency update checks.

## Build

Open **Actions → Orange Client Windows Build → Run workflow**. The workflow reconstructs the source from the pinned upstream commit and Orange Client patch, then builds:

- `orange-client.exe` (portable)
- Orange Client NSIS setup installer

Both files are scanned with Microsoft Defender on the build runner. SHA-256 checksums are uploaded as a separate artifact.

## Service configuration

Microsoft sign-in, Discord Rich Presence, Sentry reporting and changelog integrations can use their respective project configuration values. A Microsoft OAuth client ID and a Discord application client ID are public identifiers, not passwords.

**Do not place a private CurseForge API key in a distributed desktop application or pass it into the build.** A key shipped inside a launcher can be extracted by users. CurseForge API access that requires a private key should be provided by a protected backend service rather than embedding the key in Orange Client.

## Signed releases

The optional signed-release workflow requires a trusted code-signing certificate stored as GitHub Actions secrets:

- `ORANGE_SIGNING_CERT_PFX_BASE64`
- `ORANGE_SIGNING_CERT_PASSWORD`

Never commit the certificate or password, or send them in a chat. Without these secrets, use the regular unsigned build workflow.

## Upstream and license

This repository reconstructs the Orange Client fork from the public `Polyfrost/OneLauncher` repository, tag `oneclient-2.12.1` (commit `1605bf11248f8cc94eacf8ff1f86981abcab8dc8`). The inherited code is GPL-3.0-only. The upstream license and attribution notices are preserved in `source/`. Orange Client is an independent community fork and is not endorsed by or affiliated with Polyfrost.
