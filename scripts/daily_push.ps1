# Runs one queued commit from commit_queue.txt and pushes it.
# Designed to be run once a day by Windows Task Scheduler.
# Each line in commit_queue.txt is: <space-separated files>|<commit message>
# .queue_position remembers which line to run next; the script does nothing
# once every line has been used, so it's safe to leave the scheduled task
# running indefinitely.

$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot
$repoRoot = Split-Path -Parent $scriptDir
$queueFile = Join-Path $scriptDir "commit_queue.txt"
$stateFile = Join-Path $scriptDir ".queue_position"
$logFile = Join-Path $scriptDir "daily_push.log"

function Log($msg) {
    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  $msg"
    Write-Host $line
    Add-Content -Path $logFile -Value $line
}

Set-Location $repoRoot

if (-not (Test-Path $queueFile)) {
    Log "No commit_queue.txt found in scripts/ - nothing to do."
    exit 0
}

$lines = Get-Content $queueFile | Where-Object { $_.Trim() -ne "" }

$position = 0
if (Test-Path $stateFile) {
    $raw = (Get-Content $stateFile -Raw).Trim()
    if ($raw -match '^\d+$') { $position = [int]$raw }
}

if ($position -ge $lines.Count) {
    Log "Queue is empty - all planned commits already pushed. Nothing to do today."
    exit 0
}

$line = $lines[$position]
$parts = $line -split '\|', 2
if ($parts.Count -ne 2) {
    Log "Skipping malformed queue line: $line"
    exit 1
}

$files = $parts[0].Trim() -split '\s+'
$message = $parts[1].Trim()

Log "Running: git add $($files -join ' ')"
git add @files

Log "Running: git commit -m `"$message`""
git commit -m $message

Log "Running: git push"
git push

$position += 1
Set-Content -Path $stateFile -Value $position

Log "Done. Committed and pushed: $message (queue position now $position of $($lines.Count))"
