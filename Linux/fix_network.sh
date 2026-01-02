#!/bin/bash
# Gemini Linux Network Flush

echo "=========================================="
echo "      Gemini Linux Network Flush"
echo "=========================================="

# Flush Systemd Resolve (Common on Ubuntu/Fedora)
if command -v resolvectl &> /dev/null; then
    sudo resolvectl flush-caches
    echo "resolvectl cache flushed."
fi

# Restart Network Manager (if present)
if systemctl list-unit-files | grep -q NetworkManager; then
    echo "Restarting NetworkManager..."
    sudo systemctl restart NetworkManager
fi

echo "=========================================="
echo "Done."
read -p "Press Enter..."
