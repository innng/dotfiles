# Setup Guide - Arch Linux Hyprland Dotfiles

## Overview

This guide walks you through setting up the Arch Linux Hyprland dotfiles with Catppuccin Mocha theme. The dotfiles are self-contained at `~/.dots` and require minimal configuration after installation.

**Estimated setup time**: 30-45 minutes

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Shell Environment](#shell-environment)
5. [Theme Customization](#theme-customization)
6. [Post-Install Verification](#post-install-verification)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### System Requirements

- **OS**: Arch Linux (fresh install or existing system)
- **Window Manager**: Hyprland (will be installed)
- **Display Server**: Wayland
- **Shell**: Bash (to run setup scripts; will switch to Zsh)

### Required User Access

- Sudo privileges for package installation
- AUR access (uses `yay` for AUR packages)
- Write access to home directory

### Before You Start

1. Ensure your system is updated:
   ```bash
   sudo pacman -Syu
   ```

2. Have `yay` (AUR helper) installed:
   ```bash
   sudo pacman -S yay
   ```

3. Backup any existing dotfiles (if applicable):
   ```bash
   # If you have existing ~/.config files:
   mkdir -p ~/dotfiles-backup
   cp -r ~/.config ~/dotfiles-backup/
   ```

---

## Installation

### Step 1: Verify Dotfiles Location

The dotfiles should be at `~/.dots` with the following structure:

```bash
ls -la ~/.dots
```

Expected output:
```
.config/          # Application configurations
extra/            # Reference files and packages
etc/              # System-level configs
.git/             # Repository metadata
SETUP.md          # This file
README.md         # Quick start guide
STATUS.md         # Project status
INSTALL.sh        # Installation script (optional)
```

### Step 2: Install Packages

Install all required packages using the provided package list:

```bash
# Using the automated install script (if available):
bash ~/.dots/INSTALL.sh

# OR manually:
pacman -S $(grep -v '^#' ~/.dots/extra/PACKAGES.lst | tr '\n' ' ')
```

**Package installation may take 10-15 minutes depending on system and AUR builds.**

**Note**: Some packages may require interactive AUR compilation. Follow prompts if requested.

#### What Gets Installed

- **Window Manager**: Hyprland + utilities (hyprlock, hypridle)
- **Terminal**: Kitty with Catppuccin Mocha colors
- **Shell**: Zsh with Starship prompt
- **Launcher**: Rofi + Walker
- **System Tools**: Btop, ripgrep, eza, fzf, and more
- **Audio Stack**: PipeWire with full plugin support
- **Theming**: Qt5, Qt6, GTK, Kvantum
- **Fonts**: FiraCode, Mononoki, JetBrains Mono Nerd fonts

### Step 3: Link Configuration Directory

Most applications auto-discover configs at `~/.config`, which is already symlinked:

```bash
# Verify symlink exists:
ls -la ~/.config

# If needed, create symlink:
ln -s ~/.dots/.config ~/.config
```

---

## Configuration

### Critical Shell Configuration

The shell environment must be configured for Zsh to use the dotfiles:

#### Option A: Using `.zshenv` (Recommended)

Create or edit `~/.zshenv` with the following:

```bash
# Use dotfiles directory for Zsh configuration
export ZDOTDIR="$HOME/.dots/.config/zsh"
```

This tells Zsh to look for its configuration in `~/.dots/.config/zsh` instead of `~/.config/zsh`.

#### Option B: Using `.zprofile` Alternative

If you prefer a different approach, create `~/.zprofile`:

```bash
export ZDOTDIR="$HOME/.dots/.config/zsh"
```

#### Verify Configuration

Test that Zsh finds the configuration:

```bash
# Start a new Zsh session
zsh

# Check if ZDOTDIR is set correctly
echo $ZDOTDIR

# Should output: /home/YOUR_USERNAME/.dots/.config/zsh
```

### Setting Zsh as Default Shell

Make Zsh your default shell:

```bash
# Check if Zsh is installed
which zsh

# Change default shell
chsh -s /usr/bin/zsh

# Log out and back in, or restart terminal
```

**Important**: After changing the default shell, log out completely and log back in for the change to take effect.

### Hyprland Launch

When you launch Hyprland for the first time, it will:

1. Source `~/.dots/.config/hypr/hyprland.conf`
2. Load default Hyprland configs from `~/.dots/extra/source/hypr/`
3. Apply Catppuccin Mocha theming
4. Initialize bindings and window rules

**First launch typically takes 10-30 seconds** to compile Hyprland configurations.

### Additional Configuration Files

The following applications require configuration activation:

#### Starship (Shell Prompt)

Add to `~/.zshrc` or shell initialization (already in dotfiles):

```bash
eval "$(starship init zsh)"
```

Status: ✅ **Already configured in `~/.dots/.config/zsh/.zshrc`**

#### Rofi (Launcher)

Rofi will automatically use themes from `~/.dots/.config/rofi/`:

```bash
# Test Rofi theme
rofi -show run
```

Status: ✅ **Theme ready to use**

#### Tmux (Terminal Multiplexer)

Tmux reads from `~/.config/tmux/tmux.conf`:

```bash
# Start Tmux
tmux

# Verify configuration loaded
tmux show-options -g | grep theme
```

Status: ✅ **Configuration ready**

---

## Shell Environment

### Environment Variables

The dotfiles use standard XDG environment variables:

```bash
# User data directory
export XDG_DATA_HOME="$HOME/.local/share"

# User configuration directory
export XDG_CONFIG_HOME="$HOME/.config"

# User cache directory
export XDG_CACHE_HOME="$HOME/.cache"

# User state directory
export XDG_STATE_HOME="$HOME/.local/state"
```

**Status**: ✅ **Already configured in `~/.dots/.config/zsh/.zshenv`**

### PATH Configuration

The Zsh configuration adds the following to PATH:

```bash
$HOME/.local/bin       # User scripts and binaries
$HOME/.dots/bin        # Dotfiles scripts (if any)
/usr/local/bin         # System binaries
/usr/bin               # Standard binaries
```

**Status**: ✅ **Already configured**

### Recommended Exports

For Wayland compatibility and Hyprland optimization:

```bash
# Already configured in dotfiles, but verify:
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
```

**Status**: ✅ **Already in `~/.dots/.config/environment.d/`**

---

## Theme Customization

### Current Theme: Catppuccin Mocha

All applications are configured with **Catppuccin Mocha** theme:

- **Primary Color**: Blue (`#89b4fa`)
- **Accent Color**: Purple (`#cba6f7`)
- **Background**: Dark (`#1e1e2e`)
- **Text**: Light (`#cdd6f4`)

### Theme Reference

The color palette is defined in:

```
~/.dots/extra/colors/catppuccin-mocha.toml
```

Contains all 16 ANSI colors and system colors.

### Customizing Colors Per Application

Each application hardcodes Catppuccin Mocha colors in its own configuration file:

#### Terminal (Kitty)
```
~/.dots/.config/kitty/theme.conf
```

#### Launcher (Rofi)
```
~/.dots/.config/rofi/theme.rasi
```

#### Window Manager (Hyprland)
```
~/.dots/.config/hypr/hyprland.conf       (decoration colors)
~/.dots/.config/hypr/looknfeel.conf      (look and feel)
```

#### Shell Prompt (Starship)
```
~/.dots/.config/starship/starship.toml
```

#### Desktop Environment (GTK/Qt)
```
~/.dots/.config/gtk-3.0/settings.ini
~/.dots/.config/qt5ct/qt5ct.conf
~/.dots/.config/qt6ct/qt6ct.conf
```

### To Change Theme Globally

To use a different theme, you will need to:

1. **Update each application config file** individually
2. Modify color values in each of the files listed above
3. Restart applications for changes to take effect

**This is by design**: Static theming provides precise control per-application without complex template systems.

### GTK/Qt Theme Selection

For desktop applications, the theme is set in:

```bash
# GTK 3
~/.dots/.config/gtk-3.0/settings.ini
gtk-theme-name=Catppuccin-Mocha-Standard-Blue

# Qt 5
~/.dots/.config/qt5ct/qt5ct.conf
style=kvantum

# Qt 6
~/.dots/.config/qt6ct/qt6ct.conf
style=kvantum

# Kvantum (Qt theme engine)
~/.dots/.config/Kvantum/kvantum.conf
theme=Catppuccin-Mocha
```

To select different themes:

```bash
# Using GUI tool
nwg-look &    # GTK theme selector
qt5ct &       # Qt5 configuration
```

---

## Post-Install Verification

### Verify Installation Complete

Run this checklist to confirm everything is set up:

```bash
# 1. Check Zsh configuration
echo $ZDOTDIR
# Should output: /home/YOUR_USERNAME/.dots/.config/zsh

# 2. Check if Hyprland is installed
hyprland --version

# 3. Verify package count
pacman -Q | wc -l
# Should be at least 77 packages

# 4. Check font installation
fc-list | grep -i "mononoki\|firacode\|jetbrains"
# Should show installed fonts
```

### Test Application Launches

```bash
# Terminal
kitty --version

# Launcher
rofi -show run

# System monitor
btop

# File manager
dolphin

# Starship prompt
starship --version
```

All commands should execute without errors.

### Verify Theme Application

```bash
# Check Kitty theme
grep "background\|foreground" ~/.dots/.config/kitty/theme.conf

# Check Rofi theme colors
grep "#89b4fa\|#1e1e2e" ~/.dots/.config/rofi/theme.rasi
```

### Test Hyprland Launch

To test Hyprland configuration:

1. Log out of current desktop
2. At login screen, select Hyprland
3. Hyprland should start with no errors
4. Verify window decorations use Catppuccin Mocha colors

---

## Troubleshooting

### Issue: "ZDOTDIR not found" or Zsh starts with default config

**Solution**: Verify `.zshenv` exists and is readable:

```bash
cat ~/.zshenv

# Should contain:
export ZDOTDIR="$HOME/.dots/.config/zsh"

# If not, create it:
echo 'export ZDOTDIR="$HOME/.dots/.config/zsh"' > ~/.zshenv
```

### Issue: Font rendering issues in Kitty or other apps

**Cause**: Required Nerd fonts not installed

**Solution**:
```bash
# Reinstall fonts
sudo pacman -S ttf-mononoki-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd

# Rebuild font cache
fc-cache -fvf ~/.local/share/fonts
```

### Issue: Rofi theme not applying

**Cause**: Theme file path not found

**Solution**:
```bash
# Verify theme file exists
ls -la ~/.dots/.config/rofi/theme.rasi

# Test Rofi with specific theme
rofi -theme ~/.dots/.config/rofi/theme.rasi -show run
```

### Issue: Hyprland fails to start with configuration error

**Cause**: Hyprland syntax error in config files

**Solution**:
```bash
# Check for syntax errors
hyprctl config

# Look at Hyprland logs
journalctl -xe

# Verify default configs exist
ls -la ~/.dots/extra/source/hypr/
```

### Issue: Qt/GTK applications don't use Catppuccin theme

**Cause**: Theme not installed or qt5ct/qt6ct not configured

**Solution**:
```bash
# Verify theme installation
sudo pacman -S catppuccin-gtk-theme catppuccin-cursors-mocha

# Reconfigure Qt
qt5ct &
qt6ct &

# Restart applications
```

### Issue: Audio not working

**Cause**: PipeWire not configured or not default

**Solution**:
```bash
# Check PipeWire status
systemctl --user status pipewire

# Set PipeWire as default
systemctl --user restart pipewire

# Test audio
paplay /usr/share/sounds/freedesktop/stereo/bell.oga
```

### Issue: Cannot install package (AUR compilation fails)

**Cause**: Missing development tools or gcc issues

**Solution**:
```bash
# Ensure base-devel is installed
sudo pacman -S base-devel

# Try installing just the failing package
yay -S PACKAGE_NAME
```

---

## Next Steps After Setup

### 1. Customize Key Bindings

Edit `~/.dots/.config/hypr/bindings/` files to change Hyprland keybinds.

### 2. Add Custom Aliases

Edit `~/.dots/.config/zsh/.zshrc` to add shell aliases.

### 3. Configure Terminal Preferences

Edit `~/.dots/.config/kitty/kitty.conf` for Kitty preferences.

### 4. Set Wallpaper

```bash
# Use awww (included)
awww &

# Or manually
swww init && swww img /path/to/wallpaper.png
```

### 5. Configure Applications

Edit individual config files in `~/.dots/.config/` as needed.

---

## Configuration Files Reference

| Application | Config Path | Purpose |
|-------------|-------------|---------|
| Hyprland | `~/.config/hypr/` | Window manager configuration |
| Kitty | `~/.config/kitty/` | Terminal emulator |
| Zsh | `~/.config/zsh/` | Shell configuration |
| Starship | `~/.config/starship/` | Shell prompt |
| Rofi | `~/.config/rofi/` | Application launcher |
| Tmux | `~/.config/tmux/` | Terminal multiplexer |
| Dunst | `~/.config/dunst/` | Notifications |
| GTK | `~/.config/gtk-3.0/` | GTK application theme |
| Qt5 | `~/.config/qt5ct/` | Qt5 configuration |
| Qt6 | `~/.config/qt6ct/` | Qt6 configuration |

---

## Getting Help

- **Configuration issues**: Check `~/.dots/STATUS.md` for configuration status
- **Dotfiles documentation**: See `~/.dots/README.md`
- **Hyprland docs**: https://wiki.hyprland.org
- **Catppuccin theme**: https://catppuccin.com

---

## Summary

Your Arch Linux Hyprland dotfiles are now fully configured! Here's what you have:

✅ **Window Manager**: Hyprland with Catppuccin Mocha theme  
✅ **Terminal**: Kitty with proper color scheme  
✅ **Shell**: Zsh with Starship prompt  
✅ **Launcher**: Rofi + Walker  
✅ **System Monitor**: Btop  
✅ **Audio Stack**: PipeWire with wiremix  
✅ **Font Stack**: Nerd fonts for proper glyph support  
✅ **Theming**: GTK/Qt with Catppuccin consistency  

**You're ready to use your Hyprland desktop!**
