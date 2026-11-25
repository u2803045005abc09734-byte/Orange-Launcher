# Building Orange Client for Windows

## Local build

Install the Rust stable toolchain and Microsoft C++ Build Tools. Open PowerShell in the repository folder and set your own service credentials before compiling:

```powershell
$env:ORANGE_CLIENT_MICROSOFT_CLIENT_ID = "YOUR_MICROSOFT_APPLICATION_ID"
$env:ORANGE_CLIENT_CURSEFORGE_API_KEY = "YOUR_CURSEFORGE_API_KEY"
$env:ORANGE_CLIENT_DISCORD_CLIENT_ID = "YOUR_DISCORD_APPLICATION_ID" # optional
.\build-windows.ps1
```

The executable is `target\release\orange-client.exe`; the NSIS setup program is created below `target\release\bundle\nsis\`.

## GitHub Actions build

Push the source folder to a repository you own. Add these repository Actions secrets if you want the corresponding integrations enabled:

- `ORANGE_CLIENT_MICROSOFT_CLIENT_ID` — your own Microsoft public-client application ID, configured for the device-code flow
- `ORANGE_CLIENT_CURSEFORGE_API_KEY` — your own CurseForge API key
- `ORANGE_CLIENT_DISCORD_CLIENT_ID` — optional; only needed for Discord Rich Presence
- `ORANGE_CLIENT_SENTRY_DSN` — optional; only needed for your own crash-reporting project
- `ORANGE_CLIENT_CHANGELOG_URL` — optional URL for your own JSON changelog feed

Run **Actions → Orange Client Windows Build**. Download the `Orange-Client-Windows-x64-Portable` and `Orange-Client-Windows-x64-Setup` artifacts from the completed run. Builds without the Microsoft ID cannot complete Microsoft sign-in; builds without the CurseForge key may not be able to browse CurseForge.

Never put private keys or account passwords in source files. The values above are application/API identifiers or service keys and should be kept in repository secrets for CI builds.
