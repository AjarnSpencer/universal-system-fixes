@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Video Concatenator (The "Joiner")
echo ============================================================
echo.
echo This tool joins ALL video files in a folder into ONE file.
echo.
echo [!] Handling Mixed Formats:
echo     To safely join videos of different resolutions (e.g., 720p + 4K),
echo     this script first normalizes everything to 1080p (MPEG-TS).
echo     This prevents "glitchy" output but takes longer.
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
    echo Usage: Drag and drop a FOLDER of videos onto this script.
    pause
    exit /b
)

set "TARGET_DIR=%~1"
if not exist "%TARGET_DIR%\" (
    echo [ERROR] Please drag a FOLDER, not a single file.
    pause
    exit /b
)

echo Processing Folder: "%TARGET_DIR%"
pushd "%TARGET_DIR%"

:: Create temp directory
if exist "temp_join" rd /s /q "temp_join"
mkdir "temp_join"
set "TEMP_DIR=%CD%\temp_join"

echo.

echo [Step 1/3] Normalizing clips to 1080p...
echo (This creates temporary parts so they fit together perfectly)
echo.

set "COUNT=1000"
(
    for %%A in (*.mp4 *.mkv *.mov *.avi *.flv *.wmv *.webm) do (
        set /a COUNT+=1
        set "IN_FILE=%%A"
        set "TEMP_FILE=!TEMP_DIR!\part_!COUNT!.ts"
        
        echo Processing: "%%A"
        
        :: 1. Resize to 1920x1080 (fitting within box, black bars if needed to preserve aspect ratio)
        :: 2. Convert to MPEG-TS (easy to join)
        :: 3. Re-encode audio to AAC
        
        ffmpeg -v error -stats -i "%%A" -c:v libx264 -preset fast -crf 23 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -c:a aac -ar 44100 -b:a 128k -f mpegts "!TEMP_FILE!"
        
        :: Add to list.txt
        echo file '!TEMP_FILE!'
    )
) > "!TEMP_DIR!\list.txt"

echo.

echo [Step 2/3] Stitching parts together...
echo.

set "OUTPUT_NAME=Joined_Video_%RANDOM%.mp4"

:: Concat using the demuxer on the normalized TS files
ffmpeg -v error -stats -f concat -safe 0 -i "!TEMP_DIR!\list.txt" -c copy -bsf:a aac_adtstoasc "%OUTPUT_NAME%"

if %errorlevel% equ 0 (
    echo.
    echo [Step 3/3] Cleanup...
    rd /s /q "!TEMP_DIR!"
    
    echo.
    echo ============================================================
    echo SUCCESS!
    echo Created: "%OUTPUT_NAME%"
    echo ============================================================
) else (
    echo.
    echo [ERROR] Something went wrong during joining.
    echo Temp files are preserved in "temp_join" for debugging.
)

popd
pause
