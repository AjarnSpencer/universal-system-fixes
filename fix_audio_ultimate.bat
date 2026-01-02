@echo off
setlocal EnableDelayedExpansion

echo ========================================================================
echo        Gemini Ultimate Audio Reset Tool (Multi-Vendor Edition)
echo ========================================================================
echo.
echo Targets: Realtek, Intel, NVIDIA, AMD, and Generic High Definition Audio.
echo.

:: 1. Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script MUST be run as Administrator.
    echo Please right-click this file and select "Run as Administrator".
    echo.
    pause
    exit /b
)

echo [Step 1/4] Stopping Windows Audio Services...
net stop Audiosrv /y
net stop AudioEndpointBuilder /y

echo.
echo [Step 2/4] Searching for and Resetting Audio Controllers...

:: List of common audio device keywords to target
:: We use PowerShell to find devices matching these names to ensure we get the right Instance IDs
set "TARGETS=Realtek Intel NVIDIA AMD 'High Definition Audio'"

for %%k in (%TARGETS%) do (
    echo.
    echo   Scanning for audio devices matching: %%k ...
    
    :: Logic: Find devices where FriendlyName matches the target AND Status is 'OK' or 'Error'
    :: We use a broad search but filter carefully to avoid removing non-audio hardware (like LAN cards)
    :: Note: We don't strictly filter by Class because the Class name varies (Media, System, Unknown), 
    :: but the name + context usually identifies the audio controller.
    
    for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice | Where-Object { ($_.FriendlyName -like '*%%~k*') -and ($_.FriendlyName -notlike '*Ethernet*') -and ($_.FriendlyName -notlike '*Controller*') -and ($_.Class -eq 'MEDIA' -or $_.Class -eq 'System' -or $_.Class -eq 'AudioEndpoint') } | Select-Object -ExpandProperty InstanceId"') do (
        set "DEV_ID=%%i"
        echo     Found Candidate: !DEV_ID!
        echo     Removing...
        pnputil /remove-device "!DEV_ID!" /subtree /force
    )
    
    :: Also specifically target the "Audio" class which often contains the endpoints
    for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-PnpDevice | Where-Object { ($_.FriendlyName -like '*%%~k*') -and ($_.Class -eq 'AudioEndpoint') } | Select-Object -ExpandProperty InstanceId"') do (
         set "DEV_ID=%%i"
         echo     Found Endpoint: !DEV_ID!
         echo     Removing...
         pnputil /remove-device "!DEV_ID!" /subtree /force
    )
)

echo.
echo [Step 3/4] Triggering Hardware Scan (Reinstalling Drivers)...
pnputil /scan-devices

echo.
echo [Step 4/4] Restarting Audio Services...
net start AudioEndpointBuilder
net start Audiosrv

echo.
echo ========================================================================
echo Repair Sequence Complete.
echo.
echo 1. Check your volume icon.
echo 2. If it has a red 'X', wait 60 seconds.
echo 3. If still no sound, RESTART YOUR COMPUTER.
echo ========================================================================
pause
