@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini System Health Restore (The "Doctor")
echo ============================================================
echo.
echo This tool scans your Windows installation for corrupted files 
echo and repairs them using the official Microsoft Image stores.
echo.
echo STEPS:
echo 1. DISM CheckHealth (Quick scan)
echo 2. DISM ScanHealth (Deep scan)
echo 3. DISM RestoreHealth (Downloads fresh files to fix corruption)
echo 4. SFC ScanNow (Installs the fresh files)
echo.
echo [!] This process can take 15-45 minutes. Do not close this window.
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

echo.
echo [Step 1/4] Checking System Image Health (Quick)...
DISM /Online /Cleanup-Image /CheckHealth
if %errorLevel% neq 0 (
    echo [WARN] DISM reported issues. Proceeding to deep scan...
)

echo.
echo [Step 2/4] Scanning System Image (Deep)...
DISM /Online /Cleanup-Image /ScanHealth

echo.
echo [Step 3/4] Restoring System Health (Downloading repairs)...
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo [Step 4/4] Running System File Checker (Installing repairs)...
sfc /scannow

echo.
echo ============================================================
echo System Repair Complete.
echo.
echo 1. Look for "Windows Resource Protection did not find any integrity violations".
echo 2. If it says "found corrupt files and successfully repaired them", YOU ARE FIXED.
echo 3. Restart your computer to finalize changes.
echo ============================================================
pause
