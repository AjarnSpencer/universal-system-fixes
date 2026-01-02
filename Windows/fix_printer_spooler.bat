@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Printer Spooler Fixer
echo ============================================================
echo.
echo This tool fixes:
echo - Printer status stuck on "Printing..."
echo - Cannot delete documents from print queue
echo - Printer not responding
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

echo [Step 1/4] Stopping Print Spooler Service...
net stop spooler /y

echo.
echo [Step 2/4] Clearing Stuck Print Jobs...
set "SPOOL_DIR=%systemroot%\System32\spool\PRINTERS"
if exist "%SPOOL_DIR%" (
    del /q /f /s "%SPOOL_DIR%\*.*"
    echo Cleared stuck files in %SPOOL_DIR%
) else (
    echo [WARN] Spool directory not found (Unusual).
)

echo.
echo [Step 3/4] Restarting Print Spooler Service...
net start spooler

echo.
echo [Step 4/4] Checking Status...
sc query spooler | find "STATE"

echo.
echo ============================================================
echo Done. Try printing again.
echo ============================================================
pause
