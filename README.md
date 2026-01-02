# 🛠️ Universal System Fixes

**A library of automated, "one-click" utility scripts for Windows 10 & 11 system administration.**  
*Maintained by Ajarn Spencer Littlewood in Collaboration with Gemini CLI - Author's Homepage: [www.ajarnspencer.com](https://www.ajarnspencer.com)*

> **Status:** Active / Work-in-Progress  
> **Goal:** Simplify complex command-line repairs into drag-and-drop or single-click actions.

---

## 📖 Table of Contents

*   [🔊 Audio Repair](#-audio-repair) (Fix "No Sound" / Driver glitches)
*   [🌐 Network & Internet](#-network--internet) (Fix Wi-Fi / DNS issues)
*   [🛠️ Critical System Maintenance](#-critical-system-maintenance) (Fix BSOD / Updates / GPU freezes)
*   [🧹 Clean & Optimize](#-clean--optimize) (Icons / Search / RAM / Bloat)
*   [📂 File Management](#-file-management) (Organize / Analyze)
*   [🎵 Media Conversion](#-media-conversion) (MP3 / Video Tools)
*   [⚙️ General Usage Guide](#-general-usage-guide)

---

## 🔊 Audio Repair
*(See above for Audio tools)*

---

## 🛠️ Critical System Maintenance
*(See above for GPU/Network tools)*

### 5. `fix_printer_spooler.bat`
**The "Stuck Printer" Fix.**
*   **Action:** Stops the Print Spooler, forcibly deletes stuck `.SPL` files from the system spool directory, and restarts the service.
*   **Fixes:** "Printing..." stuck forever, or cannot delete print jobs.

---

## 🧹 Clean & Optimize

**Target:** Performance, Visual Glitches, and Search.

### 1. `fix_corrupted_icons.bat`
**The "White Icon" Fix.**
*   **Action:** Kills Explorer, deletes the hidden `IconCache.db` and thumbnail caches, and restarts Explorer.
*   **Fixes:** Blank white page icons, wrong app icons.

### 2. `reset_windows_search.bat`
**The "Search Fix".**
*   **Action:** Stops the Windows Search service (`wsearch`) and deletes the search index database (`Windows.edb`), forcing a fresh rebuild.
*   **Fixes:** Blank Start Menu search results.

### 3. `clear_standby_memory.bat`
**The "RAM Cleaner".**
*   **Action:** Flushes the System File Cache via PowerShell to release "Standby" RAM back to the free pool.
*   **Fixes:** Stuttering in games caused by lack of free RAM.

### 4. `disable_telemetry_bloat.bat`
**The "Privacy" Tool.**
*   **Action:** Disables "Connected User Experiences and Telemetry" (`DiagTrack`) and "Data Collection" services.
*   **Fixes:** High CPU usage by background telemetry processes.

---

## 📂 File Management

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

### `batch_image_convert.bat`
**The "Webmaster" Tool.**
*   **Input:** Drag & Drop a **Folder** of images.
*   **Action:** Converts everything (HEIC, WEBP, AVIF, BMP, TIFF) into standard **JPG** or **PNG**.
*   **Requirement:** Needs [ImageMagick](https://imagemagick.org/script/download.php) installed.

### `video_compressor_whatsapp.bat`
**The "Shareable" Tool.**
*   **Best for:** Sending videos via WhatsApp, Discord, or Email without hitting size limits.
*   **Action:**
    1.  Calculates the exact bitrate needed to fit your video under 25MB (or 100MB).
    2.  Compresses the file using optimized settings (H.264).
    3.  Auto-scales 4K video down to 720p to preserve visual quality at low bitrates.
*   **Input:** Drag & Drop a **Video File**.

### `video_concatenator.bat`
**The "Joiner".**
*   **Input:** Drag & Drop a **Folder** of video clips.
*   **Action:**
    1.  Normalizes ALL clips (MP4, MKV, vertical, horizontal) to a standard 1080p format.
    2.  Adds black bars if aspect ratios differ (so nothing stretches).
    3.  Stitches them into one single `Joined_Video.mp4`.
*   **Note:** Re-encoding takes time, but ensures the output doesn't glitch.

---

## ⚙️ General Usage Guide

Most scripts in this library perform system-level operations.

1.  **Download** the script or the repository.
2.  **Right-Click** the script.
3.  Select **Run as Administrator**. (Crucial for Audio, Network, and System fixes).
4.  Follow the on-screen prompts.

> **Disclaimer:** These tools use standard Windows troubleshooting commands (`netsh`, `pnputil`, `dism`). They are safe for 99% of systems, but always use them at your own risk.
