@echo off
REM Minimal cp shim for Windows to support common flags used by Bazel repo rules
REM Usage examples: cp -R source dest  OR cp -RH source dest
setlocal enabledelayedexpansion
set "src="
set "dst="
:parse
if "%~1"=="" goto afterparse
if "%~1"=="-R" (shift & goto parse)
if "%~1"=="-r" (shift & goto parse)
if "%~1"=="-H" (shift & goto parse)
if "%~1"=="-RH" (shift & goto parse)
if not defined src (set "src=%~1") else if not defined dst (set "dst=%~1")
shift & goto parse
:afterparse
if not defined src (echo Missing source & exit /b 1)
if not defined dst (echo Missing destination & exit /b 1)
powershell -NoProfile -Command "Copy-Item -LiteralPath (Resolve-Path -LiteralPath \"%src%\").ProviderPath -Destination \"%dst%\" -Recurse -Force -ErrorAction Stop"
exit /b %ERRORLEVEL%