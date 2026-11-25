$ErrorActionPreference = "Stop"

Write-Host "Building Orange Client launcher..." -ForegroundColor Cyan
Write-Host "Optional compile-time variables: ORANGE_CLIENT_MICROSOFT_CLIENT_ID, ORANGE_CLIENT_CURSEFORGE_API_KEY, ORANGE_CLIENT_DISCORD_CLIENT_ID" -ForegroundColor Yellow
cargo build --locked --release -p oneclient_app --bin orange-client

if (-not (Get-Command cargo-packager -ErrorAction SilentlyContinue)) {
    cargo install cargo-packager --locked
}

Write-Host "Creating Orange Client Windows installer..." -ForegroundColor Cyan
cargo packager --release -p oneclient_app --formats nsis

Write-Host "Done. Portable EXE: target\release\orange-client.exe" -ForegroundColor Green
Write-Host "Installer: target\release\bundle\nsis\" -ForegroundColor Green
