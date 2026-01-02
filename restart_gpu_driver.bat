@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini GPU Driver Restarter (No-Reboot Fix)
echo ============================================================
echo.
echo This tool will forcefully restart your Graphics Driver(s).
echo.
echo [!] WARNING: 
echo     - Your screen WILL flicker or go black for a few seconds.
echo     - Any running games or GPU-heavy apps might crash.
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

set "FOUND=0"
echo [1/2] Searching for Display Adapters...
:: Use PowerShell to find Instance IDs for all devices in the 'Display' class
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice -Class Display -Status OK | Select-Object -ExpandProperty InstanceId"') do (
    set "DEV_ID=%%i"
    set "FOUND=1"
    echo Found Device: !DEV_ID!
    
    echo [2/2] Restarting Device...
    :: pnputil /restart-device is the modern way to re-initialize the driver
    pnputil /restart-device "!DEV_ID!"
    
    if !errorlevel! equ 0 (
        echo [SUCCESS] Driver restarted successfully.
    ) else (
        echo [WARN] Standard restart failed. Trying Disable/Enable fallback...
        pnputil /disable-device "!DEV_ID!"
        timeout /t 2 >nul
        pnputil /enable-device "!DEV_ID!"
    )
)

if "!FOUND!"=="0" (
    echo [ERROR] No active Display Adapters found.
    echo If your screen is black, try the Windows shortcut: Win+Ctrl+Shift+B
)

echo.
echo ============================================================
echo Process Complete. 
echo ============================================================
pause
