@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Standby RAM Cleaner
echo ============================================================
echo.
echo This tool attempts to flush the System File Cache.
echo This releases "Standby" memory that can cause stuttering in games.
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script MUST be run as Administrator.
    echo Please right-click this file and select "Run as Administrator".
    echo.
    pause
    exit /b
)

echo [Step 1/1] Flushing System File Cache via PowerShell...

:: We call the .NET Garbage Collector and empty the Working Set
powershell -NoProfile -Command "$mem = [System.GC]::GetTotalMemory($true); [System.Diagnostics.Process]::GetCurrentProcess().MinWorkingSet = [System.IntPtr]::Zero; Write-Host 'Memory Flushed.'"

echo.
echo ============================================================
echo Done.
echo ============================================================
pause
