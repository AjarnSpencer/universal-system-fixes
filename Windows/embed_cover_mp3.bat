@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Audio + Cover Art "Stitcher"
echo ============================================================
echo.
echo This tool converts audio to MP3 and embeds any image found 
echo in the same folder as the album art.
echo.
echo Supported Inputs: WAV, FLAC, M4A, OGG
echo Output: High-Quality MP3 (320kbps)
echo.

:: 1. Handle Drag and Drop
if "%~1"=="" (
    echo Usage: Drag and drop an AUDIO file ^(or a folder^) onto this script.
    echo.
    pause
    exit /b
)

:: Check if ffmpeg is installed
ffmpeg -version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] FFmpeg is not found in your system PATH.
    echo Please install FFmpeg to use this tool.
    pause
    exit /b
)

:PROCESS_ARGS
if "%~1"=="" goto :EOF
set "TARGET=%~1"

:: Check if it's a directory
if exist "%TARGET%\" (
    echo Processing Folder: "%TARGET%"
    pushd "%TARGET%"
    for %%A in (*.wav *.flac *.m4a *.ogg) do (
        call :CONVERT_FILE "%%A"
    )
    popd
) else (
    :: It's a file
    call :CONVERT_FILE "%TARGET%"
)

shift
goto :PROCESS_ARGS

:CONVERT_FILE
set "AUDIO_FILE=%~1"
set "FILE_DIR=%~dp1"
set "FILE_NAME=%~n1"
set "EXTENSION=%~x1"

echo.
echo ------------------------------------------------------------
echo Processing: "%FILE_NAME%%EXTENSION%"
echo Location: "%FILE_DIR%"

pushd "%FILE_DIR%"

:: 1. Search for a cover image (JPG, PNG, JPEG)
set "COVER_IMG="

:: Priority 1: Check for exact match "cover.jpg" or "folder.jpg"
if exist "cover.jpg" set "COVER_IMG=cover.jpg"
if exist "folder.jpg" set "COVER_IMG=folder.jpg"
if exist "cover.png" set "COVER_IMG=cover.png"

:: Priority 2: If no standard name, take the FIRST image found in the folder
if not defined COVER_IMG (
    for %%i in (*.jpg *.jpeg *.png) do (
        set "COVER_IMG=%%i"
        goto :FOUND_COVER
    )
)

:FOUND_COVER
if defined COVER_IMG (
    echo [INFO] Found Cover Art: "!COVER_IMG!"
    echo [INFO] Converting and Embedding...
    
    ffmpeg -y -v error -stats -i "%AUDIO_FILE%" -i "!COVER_IMG!" -map 0:0 -map 1:0 -c:a libmp3lame -b:a 320k -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" "%FILE_NAME%.mp3"
    
    if !errorlevel! equ 0 (
        echo [SUCCESS] Created "%FILE_NAME%.mp3"
    ) else (
        echo [ERROR] FFmpeg failed.
    )

) else (
    echo [WARN] No image found in this folder.
    echo [INFO] Converting audio ONLY...
    
    ffmpeg -y -v error -stats -i "%AUDIO_FILE%" -c:a libmp3lame -b:a 320k "%FILE_NAME%.mp3"
    
    if !errorlevel! equ 0 (
        echo [SUCCESS] Created "%FILE_NAME%.mp3" (No Cover)
    )
)

popd
exit /b
