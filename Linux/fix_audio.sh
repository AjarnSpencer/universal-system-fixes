#!/bin/bash
# Gemini Linux Audio Reset
# Fixes: No sound, crackling (PulseAudio/Pipewire)

echo "=========================================="
echo "      Gemini Linux Audio Resurrector"
echo "=========================================="

# Detect Sound Server
if pgrep -x "pipewire" > /dev/null; then
    echo "Detected: Pipewire"
    systemctl --user restart pipewire pipewire-pulse
    echo "Pipewire restarted."
elif pgrep -x "pulseaudio" > /dev/null; then
    echo "Detected: PulseAudio"
    pulseaudio -k
    pulseaudio --start
    echo "PulseAudio restarted."
else
    echo "Trying Force Reload of ALSA..."
    sudo alsa force-reload
fi

echo "=========================================="
echo "Done."
read -p "Press Enter..."
