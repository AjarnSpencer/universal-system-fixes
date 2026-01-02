@echo off
echo ==========================================
echo      Gemini Realtek Audio Fixer
echo ==========================================
echo.
echo This script requires Administrator privileges.
echo If you did not Run as Administrator, close this and right-click -> Run as Administrator.
echo.
pause

echo.
echo 1. Removing potentially corrupted Realtek Driver instance...
pnputil /remove-device "HDAUDIO\FUNC_01&VEN_10EC&DEV_0245&SUBSYS_10251758&REV_1000\5&E06FEC0&0&0001" /subtree /force

echo.
echo 2. Scanning for hardware changes (Triggers Windows to reinstall the driver)...
pnputil /scan-devices

echo.
echo 3. Restarting Windows Audio Service...
net stop Audiosrv
net start Audiosrv

echo.
echo ==========================================
echo Fix attempt complete.
echo If sound is still not working, please RESTART YOUR COMPUTER.
echo ==========================================
pause
