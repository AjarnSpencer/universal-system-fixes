@echo off
setlocal EnableDelayedExpansion

echo ============================================================
echo      Gemini Universal Media -> MP3 Converter
echo ============================================================
echo.
echo This tool extracts audio from almost ANY media file (Video or Audio)
echo and converts it to MP3 (320kbps).
echo.
echo It also automatically embeds cover art found in the source folder.
echo.
echo Supported Inputs:
echo Audio: WAV, FLAC, M4A, OGG, AAC, WMA, AIFF, OPUS, APE, ALAC
echo Video: MP4, MKV, AVI, MOV, WEBM, FLV, WMV
echo.

:: Configuration
set "OUT_EXT=.mp3"
set "BITRATE=320k"

:: Check for FFmpeg
ffmpeg -version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] FFmpeg is not found. Please install it first.
    pause
    exit /b
)

:: 1. Handle Drag and Drop
if "%~1"=="" (
    echo Usage: Drag and drop a FILE or a FOLDER onto this script.
    echo.
    pause
    exit /b
)

:PROCESS_ARGS
if "%~1"=="" goto :EOF
set "TARGET=%~1"

if exist "%TARGET%\" (
    echo Processing Folder: "%TARGET%"
    pushd "%TARGET%"
    
    :: Create output directory to avoid overwriting originals
    if not exist "converted" mkdir "converted"
    
    :: Loop through all common media types
    for %%A in (*.wav *.flac *.m4a *.ogg *.aac *.wma *.aiff *.opus *.ape *.alac *.mp4 *.mkv *.avi *.mov *.webm *.flv *.wmv *.mp3) do (
        call :CONVERT_FILE "%%A"
    )
    popd
) else (
    :: Single File Processing
    call :CONVERT_FILE "%TARGET%"
)

shift
goto :PROCESS_ARGS

:CONVERT_FILE
set "INPUT_FILE=%~1"
set "FILE_DIR=%~dp1"
set "FILE_NAME=%~n1"
set "EXTENSION=%~x1"

:: Determine Output Path
:: If we are in a loop (pushd), use local 'converted' folder. 
:: If single file drag-drop, create 'converted' in that file's dir.
if not exist "%FILE_DIR%converted" mkdir "%FILE_DIR%converted"
set "OUTPUT_FILE=%FILE_DIR%converted\%FILE_NAME%%OUT_EXT%"

echo.
echo ------------------------------------------------------------
echo Processing: "%FILE_NAME%%EXTENSION%"
echo Searching for Art in: "%FILE_DIR%"

pushd "%FILE_DIR%"

:: Search for Cover Art
set "COVER_IMG="

:: 1. Exact Name Match (SongName.jpg)
if exist "%FILE_NAME%.jpg" set "COVER_IMG=%FILE_NAME%.jpg"
if exist "%FILE_NAME%.png" set "COVER_IMG=%FILE_NAME%.png"

:: 2. Standard Names
if not defined COVER_IMG (
    if exist "cover.jpg" set "COVER_IMG=cover.jpg"
    if exist "folder.jpg" set "COVER_IMG=folder.jpg"
    if exist "cover.png" set "COVER_IMG=cover.png"
    if exist "front.jpg" set "COVER_IMG=front.jpg"
)

:: 3. Fallback: First image found
if not defined COVER_IMG (
    for %%i in (*.jpg *.jpeg *.png) do (
        set "COVER_IMG=%%i"
        goto :FOUND_COVER
    )
)

:FOUND_COVER
if defined COVER_IMG (
    echo [INFO] Found Art: "!COVER_IMG!"
    echo [INFO] Converting to MP3...
    
    :: -map 0:a:0 selects the first audio track (ignores video tracks in MP4/MKV) 
    ffmpeg -y -v error -stats -i "%INPUT_FILE%" -i "!COVER_IMG!" -map 0:a:0 -map 1:0 -c:a libmp3lame -b:a %BITRATE% -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" "%OUTPUT_FILE%"
    
    if !errorlevel! equ 0 (
        echo [SUCCESS] Saved to "converted\%FILE_NAME%%OUT_EXT%"
    ) else (
        echo [ERROR] Conversion Failed.
    )

) else (
    echo [INFO] No art found. Audio Only.
    
    ffmpeg -y -v error -stats -i "%INPUT_FILE%" -map 0:a:0 -c:a libmp3lame -b:a %BITRATE% "%OUTPUT_FILE%"
    
    if !errorlevel! equ 0 (
        echo [SUCCESS] Saved to "converted\%FILE_NAME%%OUT_EXT%"
    )
)

popd
exit /b
