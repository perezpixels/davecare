# Serve the Flutter DavidCare app (landing + pharmacy web + patient mobile) on :8094

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$env:Path = "C:\dev\flutter\bin;C:\Program Files\Git\bin;" + $env:Path
Set-Location "$root\apps\davecare"

Get-NetTCPConnection -LocalPort 8094 -ErrorAction SilentlyContinue | ForEach-Object {
  Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue
}

Write-Host "Serving DavidCare at http://localhost:8094/" -ForegroundColor Green
flutter run -d chrome --release --web-port 8094
