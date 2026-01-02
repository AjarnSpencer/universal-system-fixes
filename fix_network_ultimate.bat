@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Ultimate Network Reset Tool
echo ============================================================
echo.
echo This script will reset all network adapters, protocols, and 
echo caches to their factory default state.
echo.
echo [!] This usually fixes:
echo     - "Connected, No Internet"
echo     - Slow DNS resolution
echo     - Failed IP configuration
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

echo [Step 1/6] Releasing current IP address...
ipconfig /release
echo.

echo [Step 2/6] Flushing DNS Cache...
ipconfig /flushdns
echo.

echo [Step 3/6] Resetting Winsock (Windows Sockets API)...
netsh winsock reset
echo.

echo [Step 4/6] Resetting TCP/IP Stack...
netsh int ip reset
echo.

echo [Step 5/6] Clearing ARP Cache (Address Resolution Protocol)...
arp -d *
echo.

echo [Step 6/6] Renewing IP address...
echo (This might take a moment if DHCP is slow)
ipconfig /renew
echo.

echo ============================================================
echo Network Reset Complete.
echo.
echo It is HIGHLY RECOMMENDED to restart your computer now.
echo ============================================================
pause
