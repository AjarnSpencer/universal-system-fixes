# 🛠️ Universal System Fixes

**A multi-platform library of automated "one-click" repair tools.**  
*Maintained by Ajarn Spencer Littlewood in Collaboration with Gemini CLI - Author's Homepage: [www.ajarnspencer.com](https://www.ajarnspencer.com)*

> **Status:** Active / Work-in-Progress  
> **Platforms:** 🪟 Windows | 🍎 macOS | 🐧 Linux

---

## 📂 Repository Structure

*   **`Windows/`** (`.bat`) - Batch scripts for Windows 10/11. Run as Administrator.
*   **`macOS/`** (`.command`) - Shell scripts for macOS. Double-click to run.
*   **`Linux/`** (`.sh`) - Bash scripts for Debian/Ubuntu/Mint. Run via terminal.

---

## 🪟 Windows Tools (Inside `Windows/`)

*   **`fix_audio_ultimate.bat`** - Nuke & Reinstall Realtek/Intel/AMD Audio drivers.
*   **`fix_network_ultimate.bat`** - Reset Winsock, DNS, IP, and ARP.
*   **`fix_printer_spooler.bat`** - Clear stuck print jobs.
*   **`system_health_restore.bat`** - Run DISM & SFC to fix corruption.
*   **`nuke_windows_update_cache.bat`** - Fix updates stuck at 0%.
*   **`wifi_password_revealer.bat`** - Show saved Wi-Fi passwords.
*   **`auto_organize_folder.bat`** - Sort files into Images/Videos/Docs.
*   **`universal_media_to_mp3.bat`** - Convert Video/Audio to MP3 + Cover Art.
*   *(And more... check the folder)*

---

## 🍎 macOS Tools (Inside `macOS/`)

*   **`fix_audio.command`** - Restarts `coreaudiod` to fix "No Sound" or stuck volume.
*   **`fix_network.command`** - Flushes DNS cache and restarts `mDNSResponder`.
*   **`universal_media_to_mp3.command`** - Drag & Drop media converter (Requires `ffmpeg`).

> **Note:** On first run, you might need to Right-Click -> Open if macOS blocks it as "Unidentified Developer".

---

## 🐧 Linux Tools (Inside `Linux/`)

*   **`fix_audio.sh`** - Restarts PulseAudio or Pipewire servers.
*   **`fix_network.sh`** - Flushes `resolvectl` DNS cache and restarts NetworkManager.
*   **`universal_media_to_mp3.sh`** - Terminal-based media converter (Requires `ffmpeg`).

---

## ⚠️ Disclaimer

These scripts modify system settings (drivers, services, caches).  
*   **Windows:** Always Run as Administrator.
*   **macOS/Linux:** May require `sudo` password.
*   Use at your own risk.

---
*Created by The AI and The User.*