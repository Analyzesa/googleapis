@echo off
REM Simple cat shim for Windows: reads file path in %1 and outputs raw content via PowerShell
powershell -NoProfile -Command "Get-Content -Raw -LiteralPath '%~1'"