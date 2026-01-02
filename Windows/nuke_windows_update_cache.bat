@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Windows Update Cache "Nuke"
echo ============================================================
echo.
echo [!] This tool fixes Windows Updates stuck at 0%% or failing errors.
echo.
echo PROCESS:
echo 1. Stop Update Services (wuauserv, cryptSvc, bits, msiserver)
echo 2. Rename 'SoftwareDistribution' and 'catroot2' folders.
echo    (This forces Windows to re-download fresh update files)
echo 3. Restart Update Services.
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

echo.
echo [Step 1/3] Stopping Windows Update Services...
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
echo Services stopped.

echo.
echo [Step 2/3] Renaming Cache Folders...
:: We rename instead of delete, just in case (Safety First)
if exist %systemroot%\SoftwareDistribution (
    ren %systemroot%\SoftwareDistribution SoftwareDistribution.old.%random%
    echo Renamed SoftwareDistribution.
) else (
    echo SoftwareDistribution folder not found (Clean).
)

if exist %systemroot%\System32\catroot2 (
    ren %systemroot%\System32\catroot2 catroot2.old.%random%
    echo Renamed catroot2.
) else (
    echo catroot2 folder not found (Clean).
)

echo.
echo [Step 3/3] Restarting Windows Update Services...
net start wuauserv
net start cryptSvc
net start bits
net start msiserver

echo.
echo ============================================================
echo Cache Cleared.
echo.
echo Please go to Settings -> Windows Update -> Check for updates.
echo It will take longer than usual (it's rebuilding the database).
echo ============================================================
pause
