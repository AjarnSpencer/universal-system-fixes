@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Telemetry & Bloat Disabler
echo ============================================================
echo.
echo This tool reduces background activity by disabling:
echo - Connected User Experiences and Telemetry (DiagTrack)
echo - Windows Error Reporting Service (WerSvc) - Optional
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

echo [Step 1/2] Disabling DiagTrack (Connected User Experiences)...
net stop DiagTrack /y
sc config DiagTrack start= disabled

echo.
echo [Step 2/2] Disabling dmwappushservice (Data Collection)...
net stop dmwappushservice /y
sc config dmwappushservice start= disabled

:: Registry tweaks for Telemetry
echo.
echo [Step 3/3] Applying Registry Tweaks...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

echo.
echo ============================================================
echo Done. Background telemetry reduced.
echo ============================================================
pause
