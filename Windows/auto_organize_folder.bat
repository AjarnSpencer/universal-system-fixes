@echo off
setlocal EnableDelayedExpansion
echo ============================================================
echo      Gemini Auto-Organizer
echo ============================================================
echo.
echo This tool organizes messy folders by sorting files into 
echo sub-directories based on their file type.
echo.
echo [!] It will move files. It will NOT move folders.
echo.

:: 1. Determine Target Directory
:: If user dragged a folder onto script, use that.
:: Otherwise, use the current directory.
if "%~1" neq "" (
    if exist "%~1\" (
        set "TARGET_DIR=%~1"
    ) else (
        echo [ERROR] Dragged item is not a folder.
        pause
        exit /b
    )
) else (
    set "TARGET_DIR=%CD%"
)

echo Organizing: "%TARGET_DIR%"
pushd "%TARGET_DIR%"

:: ---------------------------------------------------------
:: Category Definitions (Add extensions here to customize)
:: ---------------------------------------------------------

:: Images
if not exist "Images" mkdir "Images"
move /-y *.jpg "Images\" >nul 2>&1
move /-y *.jpeg "Images\" >nul 2>&1
move /-y *.png "Images\" >nul 2>&1
move /-y *.gif "Images\" >nul 2>&1
move /-y *.webp "Images\" >nul 2>&1
move /-y *.bmp "Images\" >nul 2>&1
move /-y *.svg "Images\" >nul 2>&1
move /-y *.heic "Images\" >nul 2>&1

:: Videos
if not exist "Videos" mkdir "Videos"
move /-y *.mp4 "Videos\" >nul 2>&1
move /-y *.mkv "Videos\" >nul 2>&1
move /-y *.avi "Videos\" >nul 2>&1
move /-y *.mov "Videos\" >nul 2>&1
move /-y *.wmv "Videos\" >nul 2>&1
move /-y *.flv "Videos\" >nul 2>&1
move /-y *.webm "Videos\" >nul 2>&1

:: Audio
if not exist "Audio" mkdir "Audio"
move /-y *.mp3 "Audio\" >nul 2>&1
move /-y *.wav "Audio\" >nul 2>&1
move /-y *.flac "Audio\" >nul 2>&1
move /-y *.m4a "Audio\" >nul 2>&1
move /-y *.ogg "Audio\" >nul 2>&1
move /-y *.aac "Audio\" >nul 2>&1

:: Documents
if not exist "Documents" mkdir "Documents"
move /-y *.pdf "Documents\" >nul 2>&1
move /-y *.doc "Documents\" >nul 2>&1
move /-y *.docx "Documents\" >nul 2>&1
move /-y *.txt "Documents\" >nul 2>&1
move /-y *.xlsx "Documents\" >nul 2>&1
move /-y *.xls "Documents\" >nul 2>&1
move /-y *.ppt "Documents\" >nul 2>&1
move /-y *.pptx "Documents\" >nul 2>&1
move /-y *.csv "Documents\" >nul 2>&1
move /-y *.md "Documents\" >nul 2>&1

:: Archives (Zips)
if not exist "Archives" mkdir "Archives"
move /-y *.zip "Archives\" >nul 2>&1
move /-y *.rar "Archives\" >nul 2>&1
move /-y *.7z "Archives\" >nul 2>&1
move /-y *.tar "Archives\" >nul 2>&1
move /-y *.gz "Archives\" >nul 2>&1

:: Installers / Executables
if not exist "Installers" mkdir "Installers"
move /-y *.exe "Installers\" >nul 2>&1
move /-y *.msi "Installers\" >nul 2>&1
move /-y *.iso "Installers\" >nul 2>&1

:: Scripts (Don't move THIS script if it's in the folder)
if not exist "Scripts" mkdir "Scripts"
move /-y *.bat "Scripts\" >nul 2>&1
move /-y *.ps1 "Scripts\" >nul 2>&1
move /-y *.sh "Scripts\" >nul 2>&1
move /-y *.py "Scripts\" >nul 2>&1
move /-y *.js "Scripts\" >nul 2>&1

:: Cleanup empty folders (Optional - commented out for safety)
:: for /f "delims=" %%d in ('dir /ad /b /s ^| sort /r') do rd "%%d"

popd
echo.

echo ============================================================
echo Done! Check the folder.
echo ============================================================
pause
