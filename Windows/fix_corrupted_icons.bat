@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Icon Cache Rebuilder
echo ============================================================
echo.
echo This tool fixes:
echo - Blank white icons
echo - Wrong icons showing for applications
echo - Icons not updating
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

echo [Step 1/3] Closing Windows Explorer...
echo (Your taskbar will disappear momentarily)
taskkill /f /im explorer.exe

echo.
echo [Step 2/3] Deleting Icon Cache...
cd /d %userprofile%\AppData\Local
del IconCache.db /a

echo Deleting Thumbnail Cache...
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
del iconcache* /a /q
del thumbcache* /a /q

echo.
echo [Step 3/3] Restarting Explorer...
start explorer.exe

echo.
echo ============================================================
echo Done. Your icons should be refreshed.
echo ============================================================
pause
