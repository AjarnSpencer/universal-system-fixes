@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Wi-Fi Password Revealer
echo ============================================================
echo.
echo This tool retrieves the saved Wi-Fi passwords for all networks
echo this computer has connected to in the past.
echo.

:: Output file
set "OUT_FILE=My_WiFi_Passwords.txt"

echo Generating report...
echo ============================================================ > "%OUT_FILE%"
echo      SAVED WI-FI PASSWORDS REPORT >> "%OUT_FILE%"
echo      Date: %DATE% %TIME% >> "%OUT_FILE%"
echo ============================================================ >> "%OUT_FILE%"
echo. >> "%OUT_FILE%"

:: 1. Get list of profiles
echo [1/2] Scanning stored profiles...

:: We parse 'netsh wlan show profiles'
:: Line format: "    All User Profile     : SSID_NAME"
for /f "tokens=2 delims=:" %%A in ('netsh wlan show profiles') do (
    set "SSID=%%A"
    :: Remove leading spaces
    for /f "tokens=* delims= " %%a in ("!SSID!") do set "SSID=%%a"
    
    if defined SSID (
        echo Processing: "!SSID!"
        
        echo ------------------------------------------------------------ >> "%OUT_FILE%"
        echo Network Name : "!SSID!" >> "%OUT_FILE%"
        
        :: 2. Get the password (key=clear)
        :: We look for line: "    Key Content            : PASSWORD"
        set "PASS="
        for /f "tokens=2 delims=:" %%B in ('netsh wlan show profile name^="!SSID!" key^=clear ^| findstr /C:"Key Content"') do (
            set "PASS=%%B"
            :: Remove leading spaces
            for /f "tokens=* delims= " %%b in ("!PASS!") do set "PASS=%%b"
        )
        
        if defined PASS (
            echo Password     : !PASS! >> "%OUT_FILE%"
        ) else (
            echo Password     : [NO PASSWORD / OPEN NETWORK] >> "%OUT_FILE%"
        )
    )
)

echo.
echo ============================================================
echo DONE!
echo.
echo Passwords have been saved to:
echo "%CD%\%OUT_FILE%"
echo.
echo Opening file now...
start "" "%OUT_FILE%"
echo ============================================================
pause
