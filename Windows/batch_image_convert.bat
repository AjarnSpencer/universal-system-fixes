@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Batch Image Converter
echo ============================================================
echo.
echo This tool converts folders of images to JPG or PNG.
echo It handles HEIC, WEBP, AVIF, TIFF, BMP, and more.
echo.
echo [!] Requires: ImageMagick (magick.exe) in your PATH.
echo.

:: Check for ImageMagick
magick -version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] ImageMagick is NOT found.
    echo Please install it from: https://imagemagick.org/script/download.php
    echo (Make sure to check "Add to System Path" during install)
    pause
    exit /b
)

:: 1. Ask for Output Format
echo Choose Output Format:
echo [1] JPG (Best for Photos)
echo [2] PNG (Best for Screenshots/Graphics)
set /p "CHOICE=Select (1 or 2): "

if "%CHOICE%"=="2" (
    set "EXT=.png"
    set "OPTS=-quality 100"
) else (
    set "EXT=.jpg"
    set "OPTS=-quality 90"
)

:: 2. Handle Drag and Drop
if "%~1"=="" (
    echo Usage: Drag and drop a FOLDER of images onto this script.
    pause
    exit /b
)

set "TARGET_DIR=%~1"
if not exist "%TARGET_DIR%\" (
    echo [ERROR] Please drag a FOLDER, not a single file.
    pause
    exit /b
)

echo.
echo Processing Folder: "%TARGET_DIR%"
pushd "%TARGET_DIR%"

if not exist "converted" mkdir "converted"

:: Loop through common image types
for %%A in (*.heic *.webp *.avif *.bmp *.tiff *.tif *.png *.jpg *.jpeg *.gif) do (
    set "IN_FILE=%%A"
    set "OUT_FILE=converted\%%~nA%EXT%"
    
    :: Skip if input is already the target format (unless we want to normalize/compress)
    :: But usually we convert X -> Y.
    
    echo Converting: "%%A" ...
    magick "%%A" %OPTS% "!OUT_FILE!"
)

popd
echo.
echo ============================================================
echo Done! Files saved in "%TARGET_DIR%\converted"
echo ============================================================
pause
