# 🛠️ Universal System Fixes

A collection of automated utility scripts for Windows system administration, designed to resolve common hardware and software issues with a single click.

> **Note:** This repository is a work-in-progress. New scripts will be added as they are developed.

---

## 🔊 Windows Audio Repair Suite

This section contains tools specifically designed to fix "No Audio," "Driver Error," or "Red X on Volume Icon" issues on Windows 10/11.

### 🚀 Recommended Script

#### 1. `fix_audio_ultimate.bat` (The "Nuclear" Option)
**Best for:** Most users. Works on Realtek, Intel, NVIDIA, AMD, and Generic High Definition Audio.
*   **What it does:**
    *   Stops all Windows Audio services (`Audiosrv`, `AudioEndpointBuilder`).
    *   Scans for audio devices from *all* major vendors (Realtek, Intel, NVIDIA, AMD).
    *   Intelligently filters out non-audio hardware (like Ethernet cards) to prevent accidents.
    *   Removes the glitchy driver instances.
    *   Forces Windows to reinstall the correct drivers.
    *   Restarts the audio subsystem.
*   **Use this if:** You don't know exactly what sound card you have, or if other fixes haven't worked.

---

### 📂 Other Variants

#### 2. `fix_audio_universal.bat` (Realtek Portable)
**Best for:** Systems specifically known to use Realtek Audio.
*   **What it does:** 
    *   Dynamically searches for "Realtek" audio devices (does not use hardcoded IDs).
    *   Removes and reinstalls them.
    *   Restarts audio services.
*   **Use this if:** You have a Realtek card and want a slightly faster, more targeted fix than the "Ultimate" version.

#### 3. `fix_audio.bat` (Legacy / Specific)
**Best for:** Debugging or Reference.
*   **What it does:** Targets a *specific* Hardware Instance ID found on Acer Nitro laptops.
*   **Use this if:** You are the original author of this repository or have the exact same hardware configuration. **Likely won't work on other machines.**

---

## 📖 How to Use

1.  **Download** the script you need (or the whole repository).
2.  **Right-Click** the `.bat` file.
3.  Select **"Run as Administrator"**.
    *   *Why?* resetting drivers requires system-level permissions. The script will fail if you just double-click it.
4.  Follow the on-screen prompts.
5.  **Restart your computer** if the sound doesn't return immediately.

---

## 🎵 Audio & Media Tools

### 🌟 `universal_media_to_mp3.bat` (The "One-Stop" Converter)
**Best for:** Everyone.
*   **What it does:** 
    *   Takes **ANYTHING** (Video or Audio) and turns it into a high-quality MP3.
    *   **Supported Inputs:** MKV, MP4, AVI, WAV, FLAC, M4A, OGG, WMA, and more.
    *   **Smart Art Embedding:** Automatically finds cover art (checking for `SongName.jpg`, then `cover.jpg`, then *any* image) and stitches it into the MP3.
    *   **Safety First:** Creates a `converted\` folder so it never overwrites your original files.
*   **How to use:**
    *   Drag a **File** or a **Folder** onto the script. Done.

### `embed_cover_mp3.bat` (Legacy)
*   *Note: This script has been superseded by the Universal version above, but is kept for reference.*

---

## ⚠️ Disclaimer

These scripts modify system drivers. While they are designed to be safe by forcing Windows to "redetect" hardware (a standard troubleshooting step), you use them at your own risk.

*   Always ensure your work is saved before running system tools.
*   These scripts are designed for **Windows 10 and Windows 11**.

---
*Maintained by The AI and The User.*
