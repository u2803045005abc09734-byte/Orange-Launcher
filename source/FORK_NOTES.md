# Orange Client fork notes

Base source: Polyfrost OneLauncher / OneClient, version 2.12.1.

Initial Orange Client fork changes (0.1.0):

- Added independent product name, Windows binary name and NSIS package identity.
- Added separate `OrangeClient` application data/configuration directory and IPC pipe.
- Replaced Polyfrost/OneClient application logos and icon files with original Orange Client pixel-orange artwork.
- Added Orange Client orange-accent themes.
- Removed upstream release, nightly, signing and distribution workflows.
- Disabled the upstream OneLauncher auto-update feed, remote OneClient translation feed, upstream changelog feed and default Sentry reporting.
- Added a separate `orangeclient://` protocol and Windows-only GitHub Actions / PowerShell build helpers.
- Removed inherited Microsoft and CurseForge credentials from source defaults; Discord RPC is disabled unless configured with a project-owned app ID.

The fork retains the upstream GPL-3.0-only license and attribution. The crate names and some internal identifiers remain unchanged to keep the inherited code stable. The original upstream product's managed-cluster format remains recognized for compatibility.
