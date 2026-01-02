@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Video Compressor (WhatsApp/Discord Fit)
echo ============================================================
echo.
echo This tool compresses video files to fit a specific file size.
echo It calculates the exact bitrate needed for the target size.
echo.
echo [!] Requires: FFmpeg in your PATH.
echo.

:: Check for FFmpeg
ffmpeg -version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] FFmpeg is NOT found.
    echo Please install it to use this tool.
    pause
    exit /b
)

:: 1. Handle Drag and Drop
if "%~1"=="" (
    echo Usage: Drag and drop a VIDEO file onto this script.
    pause
    exit /b
)

set "INPUT_FILE=%~1"
set "FILE_DIR=%~dp1"
set "FILE_NAME=%~n1"
set "EXT=%~x1"

:: 2. Choose Target Size
echo Target Size?
echo [1] WhatsApp (24MB limit to be safe)
echo [2] Discord Free (24MB limit)
echo [3] Discord Nitro (95MB limit to be safe)
echo [4] Email/Custom (10MB limit)
set /p "CHOICE=Select (1-4): "

if "%CHOICE%"=="1" set "TARGET_MB=24"
if "%CHOICE%"=="2" set "TARGET_MB=24"
if "%CHOICE%"=="3" set "TARGET_MB=95"
if "%CHOICE%"=="4" set "TARGET_MB=10"
if not defined TARGET_MB set "TARGET_MB=24"

echo.
echo Analyzing video duration...

:: 3. Get Duration (seconds) using FFprobe
for /f "tokens=*" %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%INPUT_FILE%"') do set "DURATION=%%i"

echo Duration: %DURATION% seconds
echo Target:   %TARGET_MB% MB

:: 4. Calculate Bitrate using PowerShell (Batch math is too weak)
:: Formula: (TargetMB * 8192 kilobits) / Duration = TotalBitrate (kbits/s)
:: We subtract 128k for audio to be safe.
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "[math]::Floor((%TARGET_MB% * 8192) / %DURATION%) - 128"') do set "CALC_BITRATE=%%i"

:: Safety minimum bitrate (don't go below 100k or it looks like potato)
if %CALC_BITRATE% LSS 100 set "CALC_BITRATE=100"

echo Calculated Video Bitrate: %CALC_BITRATE%k
echo.

:: 5. Compress
set "OUT_FILE=%FILE_DIR%%FILE_NAME%_compressed_%TARGET_MB%MB.mp4"

echo Converting...
echo (This may take a while depending on video length)
echo.

:: -b:v = calculated bitrate
:: -maxrate & -bufsize = strictly constrain the bitrate spikes
:: -vf scale = Downscale to 720p (width 1280) if larger, to maintain quality at lower bitrates. 
::             "scale='min(1280,iw)':-2" means: If width > 1280, resize to 1280. Else keep original.
ffmpeg -y -v error -stats -i "%INPUT_FILE%" -c:v libx264 -b:v %CALC_BITRATE%k -maxrate %CALC_BITRATE%k -bufsize 2000k -vf "scale='min(1280,iw)':-2" -c:a aac -b:a 128k "%OUT_FILE%"

echo.
echo ============================================================
echo Done!
echo Output: "%OUT_FILE%"
echo ============================================================
pause
