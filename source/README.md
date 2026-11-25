<div align="center">

<img src=".github/media/OrangeClientBanner.png" alt="Orange Client banner" width="100%" />

# Orange Client

**An orange-themed Minecraft launcher for Windows.**

</div>

Orange Client is a community fork of the open-source OneLauncher codebase. It has its own application identity, installer name, icon set, storage directory, theme palette and build workflow. It is not the original OneClient installer or an unchanged OneClient binary.

## Current launcher foundation

- Minecraft account sign-in and local account storage
- Separate game instances / clusters and launcher settings
- Minecraft version and mod-loader installation
- Mod and modpack browsing through Modrinth and CurseForge
- Java runtime detection and installation helpers
- Logs, crash diagnosis, screenshots and instance management
- Orange Dark, Orange Light and pixel-style orange themes

## Build on Windows

You need the Rust stable toolchain and the Microsoft C++ Build Tools. For Microsoft account sign-in, set your own public-client Microsoft application ID first; enable the public client/device-code flow for that app. For CurseForge browsing, provide your own CurseForge API key. In PowerShell, set the values before building:

```powershell
$env:ORANGE_CLIENT_MICROSOFT_CLIENT_ID = "YOUR_MICROSOFT_APPLICATION_ID"
$env:ORANGE_CLIENT_CURSEFORGE_API_KEY = "YOUR_CURSEFORGE_API_KEY"
# Optional: set this only if you created your own Discord application
$env:ORANGE_CLIENT_DISCORD_CLIENT_ID = "YOUR_DISCORD_APPLICATION_ID"
.\build-windows.ps1
```

The portable executable is written to `target/release/orange-client.exe`. The NSIS installer is written to `target/release/bundle/nsis/`.

You can also push this repository to your own GitHub repository and run **Actions → Orange Client Windows Build**. Add the same values under **Settings → Secrets and variables → Actions** in your own GitHub repository (`ORANGE_CLIENT_MICROSOFT_CLIENT_ID`, `ORANGE_CLIENT_CURSEFORGE_API_KEY`, and optionally `ORANGE_CLIENT_DISCORD_CLIENT_ID`). Then run the workflow. It uploads the portable EXE and installer as downloadable build artifacts.

## Important inherited-service notes

This first fork keeps parts of the upstream launcher backend so some inherited Minecraft and content workflows remain usable. In particular, the default loader metadata mirror, curated bundle metadata/CDN, Poly+ integration, and a few upstream service URLs still point to Polyfrost-operated services. Those are not Orange Client services and may change or restrict access. Before a public independent release, replace them with services you operate or remove the dependent features. The original automatic updater is disabled so Orange Client cannot update itself to a OneLauncher/OneClient release. Remote OneClient translations, upstream changelog loading and Sentry crash reporting are disabled by default.

Microsoft OAuth, CurseForge and Discord credentials are **not bundled**. For a public build, register your own Microsoft application and obtain your own CurseForge API key. Set these compile-time environment variables before building: `ORANGE_CLIENT_MICROSOFT_CLIENT_ID`, `ORANGE_CLIENT_CURSEFORGE_API_KEY`, and (optionally) `ORANGE_CLIENT_DISCORD_CLIENT_ID`. Until a Microsoft client ID is configured, Microsoft sign-in will not work; without a CurseForge key, CurseForge browsing may be unavailable. Discord Rich Presence remains disabled unless you supply your own Discord application ID.

## License and attribution

This project is derived from **OneLauncher / OneClient 2.12.1** by Polyfrost and contributors. The inherited source is licensed under **GNU GPL-3.0-only**. The original `LICENSE` and `ATTRIBUTION.md` are retained. The Orange Client modifications are also distributed under GPL-3.0-only. If you distribute binaries, provide the corresponding modified source and keep the required notices.

Orange Client is an independent community fork and is not endorsed by or affiliated with Polyfrost.
