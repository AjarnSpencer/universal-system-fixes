# 🛠️ Universal System Fixes

**A library of automated, "one-click" utility scripts for Windows 10 & 11 system administration.**  
*Maintained by The AI and The User.*

> **Status:** Active / Work-in-Progress  
> **Goal:** Simplify complex command-line repairs into drag-and-drop or single-click actions.

---

## 📖 Table of Contents

*   [🔊 Audio Repair](#-audio-repair) (Fix "No Sound" / Driver glitches)
*   [🌐 Network & Internet](#-network--internet) (Fix Wi-Fi / DNS issues)
*   [🛠️ Critical System Maintenance](#-critical-system-maintenance) (Fix BSOD / Updates / GPU freezes)
*   [📂 File Management](#-file-management) (Organize / Analyze)
*   [🎵 Media Conversion](#-media-conversion) (MP3 / Video Tools)
*   [⚙️ General Usage Guide](#-general-usage-guide)

---

## 🔊 Audio Repair

**Target:** Realtek, Intel, NVIDIA, AMD, and Generic High Definition Audio drivers.

### 1. `fix_audio_ultimate.bat` (Recommended)
**The "Nuclear" Option.** Use this if your sound stops working randomly.
*   **Action:** Force-stops audio services, nukes the driver instance for *all* major audio vendors, and forces Windows to reinstall them from scratch.
*   **Fixes:** Red X on volume icon, "No Audio Device Installed", Static/Crackling.

### 2. `fix_audio_universal.bat`
**The "Portable" Realtek Fix.**
*   **Action:** Specifically targets Realtek devices using dynamic detection. Less aggressive than the Ultimate version.

---

## 🌐 Network & Internet

**Target:** Wi-Fi Adapters, Ethernet, DNS Settings.

### 1. `fix_network_ultimate.bat`
**The "Internet Button".** Use this if you are connected to Wi-Fi but have "No Internet".
*   **Action:**
    *   Flushes DNS Cache (`ipconfig /flushdns`)
    *   Resets Winsock Catalog (`netsh winsock reset`)
    *   Resets TCP/IP Stack (`netsh int ip reset`)
    *   Clears ARP Cache
*   **Result:** A completely fresh network connection state.

### 2. `wifi_password_revealer.bat`
**The "Memory Jogger".** Use this if you forgot a Wi-Fi password.
*   **Action:** Scans system registry for saved profiles, decrypts the keys, and exports a text file (`My_WiFi_Passwords.txt`) with all your saved passwords.
*   **Note:** Does NOT require Admin privileges.

---

## 🛠️ Critical System Maintenance

**Target:** Windows Update, System Files, GPU Drivers.

### 1. `system_health_restore.bat`
**The "Doctor".** Use this for BSODs, random crashes, or missing system files.
*   **Action:** Runs the "Holy Trinity" of repairs in the correct order:
    1.  `DISM /CheckHealth` (Diagnostics)
    2.  `DISM /RestoreHealth` (Downloads fresh system files from Microsoft)
    3.  `SFC /ScanNow` (Installs the repairs)
*   **Time:** ~15-45 minutes.

### 2. `nuke_windows_update_cache.bat`
**The "Stuck Update" Fix.** Use this if Windows Update hangs at 0%.
*   **Action:** Stops update services, renames the corrupted `SoftwareDistribution` and `catroot2` folders (forcing a fresh download), and restarts services.

### 3. `restart_gpu_driver.bat`
**The "Black Screen" Fix.** Use this if your screen freezes or flickers.
*   **Action:** Uses `pnputil` to find and restart your Graphics Driver (NVIDIA/AMD/Intel) *without* rebooting the entire computer.

### 4. `fix_bluetooth_ultimate.bat`
**The "Bluetooth Resurrector".** Use this if Bluetooth disappears or won't connect.
*   **Action:**
    *   Stops all Bluetooth support services (`bthserv`).
    *   Identifies your Bluetooth Radio (Intel/Realtek/Broadcom) and forces a driver restart.
    *   Restarts the services and sets them to "Automatic" startup.

---

## 📂 File Management

**Target:** Messy folders (Downloads, Desktop, etc.)

### 1. `auto_organize_folder.bat`
**The "Declutterer".**
*   **Action:** Sorts files into `Images`, `Videos`, `Documents`, `Installers`, `Archives`, and `Audio` based on their extension.
*   **How to use:**
    *   **Drag & Drop** a messy folder onto the script.
    *   OR place the script *inside* the messy folder and double-click it.

---

## 🎵 Media Conversion

**Target:** Audio/Video Files (FFmpeg required).

### 🌟 `universal_media_to_mp3.bat`
**The "One-Stop" Converter.**
*   **Input:** Drag & Drop **ANY** file (MKV, MP4, WAV, FLAC, MOV, etc.) or **Folder**.
*   **Output:** High-Quality MP3 (320kbps).
*   **Smart Feature:** Automatically finds cover art (`cover.jpg`, `folder.jpg`, or matching filenames) and embeds it into the MP3.
*   **Safety:** Saves to a `converted\` subfolder.

---

## ⚙️ General Usage Guide

Most scripts in this library perform system-level operations.

1.  **Download** the script or the repository.
2.  **Right-Click** the script.
3.  Select **Run as Administrator**. (Crucial for Audio, Network, and System fixes).
4.  Follow the on-screen prompts.

> **Disclaimer:** These tools use standard Windows troubleshooting commands (`netsh`, `pnputil`, `dism`). They are safe for 99% of systems, but always use them at your own risk.
