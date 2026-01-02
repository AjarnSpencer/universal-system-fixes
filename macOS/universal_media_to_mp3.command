#!/bin/bash
# Gemini Universal Media -> MP3 (macOS Version)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

echo "=========================================="
echo "   Gemini Media -> MP3 Converter (macOS)"
echo "=========================================="
echo "Drag files or folders onto this terminal window"
echo "and press ENTER."
echo ""
read -p "Path: " INPUT_PATH

# Remove quotes if dragged
INPUT_PATH="${INPUT_PATH%"}"
INPUT_PATH="${INPUT_PATH#"}"

if [ -d "$INPUT_PATH" ]; then
    # It is a directory
    cd "$INPUT_PATH"
    mkdir -p converted
    
    # Loop over common media extensions (case insensitive)
    find . -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.wav" -o -iname "*.flac" -o -iname "*.m4a" \) | while read FILE; do
        FILENAME=$(basename "$FILE")
        NAME="${FILENAME%.*}"
        echo "Processing: $FILENAME"
        
        # Simple FFmpeg conversion (Map audio track 0)
        ffmpeg -y -v error -stats -i "$FILE" -map 0:a:0 -c:a libmp3lame -b:a 320k "converted/$NAME.mp3"
    done
else
    # Single file
    DIRNAME=$(dirname "$INPUT_PATH")
    FILENAME=$(basename "$INPUT_PATH")
    NAME="${FILENAME%.*}"
    
    cd "$DIRNAME"
    mkdir -p converted
    echo "Processing: $FILENAME"
    ffmpeg -y -v error -stats -i "$FILENAME" -map 0:a:0 -c:a libmp3lame -b:a 320k "converted/$NAME.mp3"
fi

echo ""
echo "Done. Check the 'converted' folder."
read -p "Press Enter..."
