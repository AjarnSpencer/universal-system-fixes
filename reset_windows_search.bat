@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Windows Search Reset
echo ============================================================
echo.
echo This tool fixes:
echo - Start Menu search is blank
echo - Can't find files you know exist
echo - "Search indexing was turned off" errors
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

echo [Step 1/3] Stopping Search Service (wsearch)...
net stop wsearch /y

echo.
echo [Step 2/3] Resetting Search Database...
:: The database is typically in C:\ProgramData\Microsoft\Search\Data\Applications\Windows
:: Deleting the .edb file forces a rebuild.
if exist "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" (
    del /f /q "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb"
    echo Database deleted.
) else (
    echo Database not found (might already be clear).
)

:: Also reset the registry keys for the search indexer logic
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f

echo.
echo [Step 3/3] Restarting Search Service...
net start wsearch

echo.
echo ============================================================
echo Reset Complete.
echo.
echo Windows will now re-index your files in the background.
echo Search results might be incomplete for the next hour.
echo ============================================================
pause
