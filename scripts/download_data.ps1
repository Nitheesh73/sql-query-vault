# Downloads the Chinook sample SQLite database into data/
# Run from the repo root: ./scripts/download_data.ps1

$ErrorActionPreference = "Stop"

$dataDir = Join-Path $PSScriptRoot "..\data"
if (-not (Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

$url = "https://github.com/lerocha/chinook-database/raw/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite"
$out = Join-Path $dataDir "Chinook_Sqlite.sqlite"

Write-Host "Downloading Chinook database to $out ..."
Invoke-WebRequest -Uri $url -OutFile $out

Write-Host "Done. Database saved at $out"
