#!/bin/bash
# Gemini macOS Network Reset
# Fixes: Slow browsing, "Connected but no internet"

echo "=========================================="
echo "      Gemini macOS Network Flush"
echo "=========================================="
echo "This script will flush the DNS cache and"
echo "restart the mDNSResponder."
echo ""

# Flush Cache (works on macOS 10.11 -> Sonoma)
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo "------------------------------------------"
echo "DNS Cache Flushed."
echo "=========================================="
read -p "Press [Enter] to exit..."
