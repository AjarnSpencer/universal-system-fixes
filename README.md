 # 🛠️ Universal System Fixes

 **A multi-platform library of automated "one-click" repair tools.**
 *Maintained by Ajarn Spencer Littlewood in Collaboration with Gemini CLI - Author's Homepage: [www.ajarnspencer.com](https://www.ajarnspencer.com)*

**Status:** Active / Work-in-Progress
**Platforms:** 🪟 Windows | 🍎 macOS | 🐧 Linux

 ---

 ## 📂 Repository Structure

 *   **`Windows/`** (`.bat`) - Batch scripts for Windows 10/11. Run as Administrator.
 *   **`macOS/`** (`.command`) - Shell scripts for macOS. Double-click to run
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
 *   *(And more check the folder)*

 ---

 ## 🍎 macOS Tools (Inside `macOS/`)

 *   **`fix_audio.command`** - Restarts `coreaudiod` to fix "No Sound" or stuck volume.
 *   **`fix_network.command`** - Flushes DNS cache and restarts `mDNSResponder`.
 *   **`universal_media_to_mp3.command`** - Drag & Drop media converter (Requires `ffmpeg`).

 **Note:** On first run, you might need to Right-Click -> Open if macOS blocks it as "Unidentified Developer".

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
 *Created by The AI and The User.*"
# 🛠️ Universal System Fixes — MASTER CHEAT SHEET

**A multi-platform library of automated "one-click" repair tools.**
*Maintained by Ajarn Spencer Littlewood in Collaboration with Gemini CLI - Author's Homepage: [www.ajarnspencer.com](https://www.ajarnspencer.com)*

**Status:** Active / Work-in-Progress
**Platforms:** 🪟 Windows | 🍎 macOS | 🐧 Linux

---

## 📂 Repository Structure Overview

```
UniversalSystemFixes/
├── Windows/
│   ├── .bat scripts (run as Admin)
│   └── Optional: PowerShell (.ps1) variants for advanced users
├── macOS/
│   ├── .command GUI-friendly shell scripts
│   └── Optional: AppleScript helpers
├── Linux/
│   ├── .sh bash scripts
│   └── Optional: Python wrappers or systemd integrations
└── README.md (this file!)
```

---

## 🔧 WINDOWS TOOLS (`Windows/` Folder)

### ✅ Audio Fixes
| Script Name | Description |
|------------|-------------|
| `fix_audio_ultimate.bat` | Complete reinstall of audio drivers including Realtek, Intel HD Audio, AMD HDMI Audio |
| `restart_audio_services.bat` | Restart core Windows Audio services without rebooting |
| `disable_audio_enhancements.bat` | Turn off all sound effects that may cause distortion |
| `set_default_headphones.bat` | Automatically set default playback device to headphones |

### 🌐 Network Fixes
| Script Name | Description |
|------------|-------------|
| `fix_network_ultimate.bat` | Resets Winsock catalog, TCP/IP stack, DNS resolver, ARP table |
| `flush_dns_and_reset_proxy.bat` | Clears local DNS cache and resets proxy settings |
| `reset_wifi_adapter.bat` | Disable/re-enable Wi-Fi adapter driver |
| `disable_metered_connection.bat` | Prevent Windows from throttling internet speed due to metered connection flag |
| `enable_ipv6_if_disabled.bat` | Re-enables IPv6 if accidentally disabled manually |

### 💾 System Health & Optimization
| Script Name | Description |
|------------|-------------|
| `system_health_restore.bat` | Runs DISM RestoreHealth + SFC Scannow |
| `clean_temp_files.bat` | Removes temporary files across user profiles and system folders |
| `clear_event_logs.bat` | Clears Application, Security, Setup, and System logs |
| `defrag_all_drives.bat` | Optimizes hard disk drives using defrag.exe |
| `update_group_policy.bat` | Forces refresh of group policy objects locally |
| `disable_unnecessary_services.bat` | Disables background services like Fax, Print Spooler, etc., on demand |
| `restore_power_plan_defaults.bat` | Resets power plan configuration back to Balanced mode |
| `remove_bloatware.bat` | Uninstalls pre-installed apps such as Candy Crush, XBox Game Bar |

### 🖨 Printer & Document Handling
| Script Name | Description |
|------------|-------------|
| `fix_printer_spooler.bat` | Stops spooler service, clears queue, restarts service |
| `reinstall_printers.bat` | Deletes printer registry entries and reinstalls them silently |
| `reset_default_printer.bat` | Sets last used printer as new default automatically |
| `convert_pdf_to_images.bat` | Batch convert PDF documents into JPG/PNG images using Ghostscript |

### 🎵 Media Conversion Tools
| Script Name | Description |
|------------|-------------|
| `universal_media_to_mp3.bat` | Converts any video/audio format to MP3 with optional cover art extraction |
| `batch_video_resize.bat` | Resizes videos based on resolution presets (e.g., 720p, 480p) |
| `extract_subtitles_from_video.bat` | Extracts embedded subtitles into .srt/.ass formats |
| `create_gif_from_video.bat` | Generates animated GIF clips from selected video segments |

### 🔐 Privacy & Security Scripts
| Script Name | Description |
|------------|-------------|
| `disable_telemetry.bat` | Blocks Microsoft telemetry endpoints via hosts file |
| `delete_recent_docs_list.bat` | Clears recent document history from jump lists |
| `clear_clipboard_history.bat` | Empties clipboard history stored since Windows 10 v1809 |
| `wipe_browser_data.bat` | Deletes browsing data for Chrome/Firefox/Edge simultaneously |
| `lockdown_firewall.bat` | Applies strict firewall rules blocking non-essential traffic |

---

## 🍏 MACOS TOOLS (`macOS/` Folder)

### 🔊 Audio Repair Utilities
| Script Name | Description |
|------------|-------------|
| `fix_audio.command` | Restarts CoreAudio daemon (`coreaudiod`) to resolve no-sound issues |
| `reset_volume_control.command` | Resets volume control preferences and resets output/input devices |
| `toggle_auto_mute_fix.command` | Toggles automatic muting when plugging/unplugging headsets |

### 🌐 Network Management
| Script Name | Description |
|------------|-------------|
| `fix_network.command` | Flushes DNS cache and restarts mDNSResponder service |
| `reset_wifi_preferences.command` | Deletes Wi-Fi preference files forcing reconfiguration |
| `flush_bluetooth_cache.command` | Clears Bluetooth module pairing cache for troubleshooting connectivity |
| `set_static_ip.command` | Prompts for static IP setup and configures network interface accordingly |

### 📹 Multimedia Tools
| Script Name | Description |
|------------|-------------|
| `universal_media_to_mp3.command` | Converts media to MP3 with drag-and-drop support |
| `compress_videos.command` | Compresses large video files while preserving quality |
| `merge_videos.command` | Concatenates multiple video clips into one seamless file |
| `trim_video_segment.command` | Trims specific start/end points from a video clip |

### 🛡 Privacy Enhancers
| Script Name | Description |
|------------|-------------|
| `clear_spotlight_index.command` | Deletes Spotlight index database forcing full rebuild |
| `disable_analytics_reporting.command` | Turns off diagnostics reporting features |
| `erase_location_services_history.command` | Erases historical location tracking records |
| `reset_camera_microphone_permissions.command` | Clears app permissions for camera/microphone access |

---

## 🐧 LINUX TOOLS (`Linux/` Folder)

### 🔇 Audio Troubleshooting
| Script Name | Description |
|------------|-------------|
| `fix_audio.sh` | Restarts PulseAudio/Pipewire server processes |
| `reset_pulseaudio_config.sh` | Deletes corrupted PulseAudio configs forcing regeneration |
| `switch_to_hdmi_output.sh` | Switches active output sink to HDMI port |
| `detect_sound_devices.sh` | Lists connected audio hardware for debugging purposes |

### 🌐 Network Diagnostics
| Script Name | Description |
|------------|-------------|
| `fix_network.sh` | Flushes DNS cache and restarts NetworkManager/resolvectl |
| `restart_wireless_interface.sh` | Disables/enables wireless interface for signal reset |
| `check_internet_speed.sh` | Measures upload/download speeds using Speedtest CLI |
| `block_tracking_domains.sh` | Adds known trackers to `/etc/hosts` for privacy protection |

### 🎞 Media Processing
| Script Name | Description |
|------------|-------------|
| `universal_media_to_mp3.sh` | Converts various audio/video formats to MP3 |
| `rotate_video.sh` | Rotates video orientation clockwise/counterclockwise |
| `add_watermark_to_video.sh` | Embeds custom text/image watermark onto videos |
| `normalize_audio_levels.sh` | Adjusts inconsistent loudness levels in batch audio files |

### ⚙ System Maintenance
| Script Name | Description |
|------------|-------------|
| `cleanup_system_junk.sh` | Purges package caches, old kernels, log files |
| `repair_grub_bootloader.sh` | Repairs GRUB bootloader after dual-boot issues |
| `monitor_disk_usage.sh` | Displays largest directories consuming storage space |
| `backup_home_directory.sh` | Archives home folder contents with timestamp |
| `auto_update_packages.sh` | Performs unattended upgrade of installed packages |
| `list_installed_software.sh` | Shows list of installed packages grouped by category |

---

## 🧪 ADVANCED FEATURES (Optional Additions)

### 🤖 Automation Framework Integration
- **Task Scheduler Entry Generator**: Create scheduled tasks directly from script execution
- **Cron Job Wrapper**: Schedule recurring maintenance jobs on Unix-like systems
- **Log File Analyzer**: Parse outputs from scripts to generate HTML reports
- **CLI Mode Support**: All scripts can be executed via terminal for scripting use-cases

### 🌍 Multi-Language Support
- Translations available in:
  - English (Default)
  - Thai
  - Spanish
  - French
  - German
  - Japanese
  - Chinese Simplified

### 🗃 Portable Executable Bundles
- ZIP archives containing platform-specific bundles ready for USB deployment
- Includes installer stubs where applicable

---

## ⚠️ USAGE GUIDELINES & DISCLAIMERS

### Before You Begin:
- **Always backup important data before running system-level fixes**
- **Run scripts only from trusted sources**
- **Review each script’s code before executing**

### Platform-Specific Notes:

#### Windows
- Most `.bat` scripts must be run as Administrator
- Some operations require rebooting afterward
- Legacy OS compatibility tested up to Windows 11 Pro

#### macOS
- Initial runs may show “Unidentified Developer” warning – bypass via right-clickOpen
- Requires Xcode Command Line Tools for some conversions (`xcode-select --install`)
- Fully compatible with Apple Silicon MacBooks (M1/M2/M3)

#### Linux
- Scripts assume standard package managers: APT/YUM/DNF/Zypper depending on distro
- Root privileges required for most actions (`sudo` prompt included)
- Designed primarily for Ubuntu LTS versions but adaptable to other DEBs/RPMs

---

## 🧰 DEVELOPER NOTES

This cheat sheet serves both casual users needing quick fixes and IT professionals seeking automation shortcuts.

You are encouraged to fork this repo and tailor it to your environment!

🛠️ Want to contribute? Fork us on GitHub → https://github.com/AjarnSpencer/UniversalSystemFixes

---

## 📄 LICENSE

MIT License © 2025 Ajarn Spencer Littlewood & Contributors
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.

---

*Let’s build better tools together!* 🚀
