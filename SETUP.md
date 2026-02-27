# Hyprland Setup Guide

A Hyprland configuration combining [Omarchy](https://github.com/basecamp/omarchy) and [HyDE](https://github.com/HyDE-Project/HyDE).

## Prerequisites

- Arch Linux or Arch-based distribution
- Git installed

## Project Structure

```
~/.dots/
├── config/              # Configuration files
│   ├── hypr/          # Hyprland (Omarchy)
│   ├── waybar/        # Status bar (Omarchy)
│   ├── walker/        # App launcher (Omarchy)
│   ├── nvim/          # Neovim/LazyVim
│   ├── nautilus/      # GTK file manager (Omarchy)
│   ├── kitty/         # Terminal (HyDE)
│   ├── zsh/           # Shell (HyDE) - see note below
│   ├── dolphin/       # KDE file manager (HyDE)
│   ├── rofi/          # Launcher (HyDE)
│   ├── starship/      # Prompt (HyDE)
│   ├── wlogout/      # Logout screen (HyDE)
│   └── gtk-3.0/       # GTK3 theme
│
├── assets/             # Extra sourced files
│   ├── themes/        # Themes (Walker, Catppuccin)
│   ├── hypr/         # Hyprland sourced configs
│   └── wallpapers/   # Wallpapers
│
├── packages.txt        # Required packages
└── setup.sh           # Setup script
```

## Installation

### 1. Install Packages

```bash
sudo pacman -S --needed $(cat ~/.dots/packages.txt)
```

### 2. Run Setup

```bash
~/.dots/setup.sh
```

This will copy all configs from `~/.dots/config/` to `~/.config/`.

### 3. Start Hyprland

```bash
exec Hyprland
```

## Components

| Component | Source |
|-----------|--------|
| Hyprland | Omarchy |
| Waybar | Omarchy |
| Walker | Omarchy |
| Neovim | Omarchy |
| Nautilus | Omarchy |
| btop | Omarchy |
| Kitty | HyDE |
| Zsh | HyDE (requires oh-my-zsh) |
| Dolphin | HyDE |
| Rofi | HyDE |
| Starship | HyDE |
| Wlogout | HyDE |
| GTK Theme | Catppuccin Mocha |

## ZSH Configuration

The zsh config from HyDE is included but requires oh-my-zsh by default. A minimal config is available at:
```
~/.dots/config/zsh/.zshrc.minimal
```

To use the minimal config, copy it to `~/.config/zsh/.zshrc` after running setup:
```bash
cp ~/.dots/config/zsh/.zshrc.minimal ~/.config/zsh/.zshrc
```

## Notes

- Some keybindings in `hypr/bindings.conf` reference omarchy commands. Replace with your preferred applications.
- Waybar config includes omarchy-specific modules.
- NVIDIA support: Edit `~/.config/hypr/hyprland.conf` to add NVIDIA environment variables if needed.

## Credits

- [Omarchy](https://github.com/basecamp/omarchy)
- [HyDE](https://github.com/HyDE-Project/HyDE)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
