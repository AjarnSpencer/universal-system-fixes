@echo off
setlocal EnableDelayedExpansion

echo ============================================================
echo      Gemini Universal Realtek Audio Fixer (Portable)
echo ============================================================
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

echo [1/4] Searching for Realtek Audio devices...
:: Use PowerShell to find the Instance ID of any Realtek Audio device
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice | Where-Object { $_.FriendlyName -like '*Realtek*Audio*' } | Select-Object -ExpandProperty InstanceId"') do (
    set "DEV_ID=%%i"
    echo Found Device: !DEV_ID!
    
    echo [2/4] Removing device instance: !DEV_ID!...
    pnputil /remove-device "!DEV_ID!" /subtree /force
)

if not defined DEV_ID (
    echo [!] No specific 'Realtek Audio' device found via standard name.
    echo Trying broader search for Realtek Media devices...
    for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice -Class MEDIA | Where-Object { $_.FriendlyName -like '*Realtek*' } | Select-Object -ExpandProperty InstanceId"') do (
        set "DEV_ID=%%i"
        echo Found Device: !DEV_ID!
        echo [2/4] Removing device instance: !DEV_ID!...
        pnputil /remove-device "!DEV_ID!" /subtree /force
    )
)

if not defined DEV_ID (
    echo [ERROR] Could not locate a Realtek Audio device on this system.
    pause
    exit /b
)

echo.
echo [3/4] Scanning for hardware changes to trigger reinstallation...
pnputil /scan-devices

echo.
echo [4/4] Restarting Windows Audio Services...
net stop Audiosrv /y
net start Audiosrv
net start AudioEndpointBuilder

echo.
echo ============================================================
echo Process Complete.
echo.
echo If sound is still missing:
echo 1. Wait 30 seconds for Windows to finish background installation.
echo 2. RESTART your computer.
echo ============================================================
pause
