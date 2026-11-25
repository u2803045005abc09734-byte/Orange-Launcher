$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $root "source"
$patchDir = Join-Path $root "patch"
$brandingDir = Join-Path $root "branding"
$patchOutput = Join-Path $env:TEMP "orange-client.patch"

$parts = @(Get-ChildItem -LiteralPath $patchDir -Filter "part-*.b64" -File | Sort-Object Name)
if ($parts.Count -ne 12) {
    throw "Expected exactly 12 patch parts, found $($parts.Count)."
}

$encodedPatch = ($parts | ForEach-Object { (Get-Content -LiteralPath $_.FullName -Raw).Trim() }) -join ""
$compressedPatch = [Convert]::FromBase64String($encodedPatch)
$compressedStream = [System.IO.MemoryStream]::new($compressedPatch)
$gzipStream = [System.IO.Compression.GZipStream]::new(
    $compressedStream,
    [System.IO.Compression.CompressionMode]::Decompress
)
$patchStream = [System.IO.MemoryStream]::new()
$gzipStream.CopyTo($patchStream)
$gzipStream.Dispose()
$compressedStream.Dispose()
[System.IO.File]::WriteAllBytes($patchOutput, $patchStream.ToArray())
$patchStream.Dispose()

if (Test-Path -LiteralPath $source) {
    Remove-Item -LiteralPath $source -Recurse -Force
}

git clone --depth 1 --branch "oneclient-2.12.1" "https://github.com/Polyfrost/OneLauncher.git" $source
if ($LASTEXITCODE -ne 0) { throw "Could not clone the pinned upstream source." }

$upstreamCommit = (git -C $source rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0 -or $upstreamCommit -ne "1605bf11248f8cc94eacf8ff1f86981abcab8dc8") {
    throw "Unexpected upstream source revision: $upstreamCommit"
}

git -C $source apply --binary --whitespace=nowarn $patchOutput
if ($LASTEXITCODE -ne 0) { throw "Orange Client patch did not apply cleanly." }

$iconFile = Join-Path $brandingDir "orange-icon.png.b64"
if (-not (Test-Path -LiteralPath $iconFile)) {
    throw "Missing Orange Client icon asset."
}
$iconBytes = [Convert]::FromBase64String((Get-Content -LiteralPath $iconFile -Raw).Trim())
$iconPath = Join-Path $source "packages/oneclient_app/icons/icon.png"
[System.IO.File]::WriteAllBytes($iconPath, $iconBytes)

$gitDir = Join-Path $source ".git"
if (Test-Path -LiteralPath $gitDir) {
    Remove-Item -LiteralPath $gitDir -Recurse -Force
}

Write-Host "Orange Client source assembled successfully."
Write-Host "Upstream revision: $upstreamCommit"
Write-Host "Patched source: $source"
