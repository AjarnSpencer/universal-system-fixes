#!/bin/bash
# Gemini macOS Audio Reset
# Fixes: No sound, stuck volume, bluetooth audio glitching

echo "=========================================="
echo "      Gemini macOS Audio Resurrector"
echo "=========================================="
echo "This script will restart the CoreAudio daemon."
echo "Your audio will stop for a second."
echo ""

# Sudo is required to kill system processes
sudo killall coreaudiod

echo "------------------------------------------"
echo "CoreAudio restarted."
echo "If issues persist, try restarting the Mac."
echo "=========================================="
read -p "Press [Enter] to exit..."
