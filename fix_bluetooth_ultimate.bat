@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Bluetooth Ultimate Fixer
echo ============================================================
echo.
echo This tool resets the Bluetooth radio, drivers, and support services.
echo.
echo [!] It usually fixes:
echo     - "Bluetooth is missing from settings"
echo     - "Device Connected but not working"
echo     - Pairing failures
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

echo [Step 1/3] Stopping Bluetooth Services...
net stop bthserv >nul 2>&1
net stop bthHFSrv >nul 2>&1
net stop bthksEnum >nul 2>&1
net stop BluetoothUserService >nul 2>&1

echo.
echo [Step 2/3] Resetting Bluetooth Radio (Hardware)...
:: Find the Bluetooth Radio and restart it via PnPUtil
set "FOUND=0"
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice -Class Bluetooth | Where-Object { $_.FriendlyName -like '*Radio*' -or $_.FriendlyName -like '*Adapter*' -or $_.FriendlyName -like '*Intel(R) Wireless Bluetooth*' -or $_.FriendlyName -like '*Realtek Bluetooth*' } | Select-Object -ExpandProperty InstanceId"') do (
    set "DEV_ID=%%i"
    set "FOUND=1"
    echo Found Radio: !DEV_ID!
    echo Restarting Driver...
    pnputil /restart-device "!DEV_ID!"
)

if "!FOUND!"=="0" (
    echo [WARN] No specific 'Radio' or 'Adapter' found.
    echo Attempting broader restart of all Bluetooth devices...
    for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice -Class Bluetooth -Status OK | Select-Object -ExpandProperty InstanceId"') do (
        pnputil /restart-device "%%i" >nul 2>&1
    )
)

echo.
echo [Step 3/3] Restarting Support Services...
:: Set service to Automatic start just in case it was disabled
sc config bthserv start= auto >nul 2>&1
net start bthserv
:: Attempt to start user support service (name varies per session, so we use wildcard logic via Powershell if needed, but net start usually handles the main one)

echo.
echo ============================================================
echo Bluetooth Reset Complete.
echo.
echo 1. Toggle Bluetooth OFF and ON in Windows Settings.
echo 2. If your device is still acting up, Remove it and Re-pair it.
echo ============================================================
pause
