# Orange Launcher

An independently branded community launcher fork for Minecraft, based on the open-source OneLauncher 2.12.1 source.

## Repository layout

- `source/` — complete assembled Orange Client Rust source. The first Windows build workflow populates this folder automatically; afterwards it is committed here so the code is browsable and editable.
- `orange-client.patch.gz.b64` — compressed source changes applied to the upstream source tag.
- `orange-client-assets.json` — Orange Client banner and Windows icon assets used during assembly.
- `.github/workflows/orange-client-build.yml` — reproducible Windows build and installer workflow.
- `rebuild-source.ps1` — local helper to reconstruct `source/` from the pinned upstream source and Orange Client patch.

## Build

Open **Actions → Orange Client Windows Build → Run workflow**. On the first run, the workflow reconstructs and commits the full source tree under `source/`, then builds:

- `orange-client.exe` (portable)
- Orange Client NSIS setup installer

Both are uploaded as workflow artifacts. The complete source is retained in this repository under `source/`.

## First-run service configuration

Microsoft sign-in and CurseForge access require project-owned credentials. Add repository Actions secrets named `ORANGE_CLIENT_MICROSOFT_CLIENT_ID` and `ORANGE_CLIENT_CURSEFORGE_API_KEY`. An optional `ORANGE_CLIENT_DISCORD_CLIENT_ID` enables Discord Rich Presence. Without these optional secrets, the launcher can still compile, but the corresponding integrations may be unavailable.

## Upstream and license

This repository reconstructs the Orange Client fork from the public `Polyfrost/OneLauncher` repository, tag `oneclient-2.12.1` (commit `1605bf11248f8cc94eacf8ff1f86981abcab8dc8`). The inherited code is GPL-3.0-only. The upstream license and attribution notices are preserved in `source/`. Orange Client is an independent community fork and is not endorsed by or affiliated with Polyfrost.
