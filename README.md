# Dots - Hyprland Dotfiles

A simplified, self-contained dotfiles project for Arch Linux + Hyprland based on [HyDE](https://github.com/HyDE-Project/HyDE) and [Omarchy](https://github.com/basecamp/omarchy).

**Status**: Work in progress - Theme system fully integrated, main applications configured.

## Quick Start

For complete installation and configuration instructions, see **[SETUP.md](SETUP.md)**.

## Features

- **Unified Theme System**: Catppuccin Mocha with single-point color management
- **Modular Configuration**: Well-organized config structure for easy customization
- **No External Dependencies**: Self-contained without reliance on HyDE or Omarchy projects
- **Essential Applications**: Hyprland, Waybar, Kitty, Rofi, Walker, and more
- **Theme Generation**: Automatic config generation from templates

## Installation Overview

1. Clone repository: `git clone https://github.com/yourusername/dots ~/.dots`
2. Install packages: `yay -S $(cat ~/.dots/extra/packages.lst | grep -v '^#')`
3. Generate theme: `~/.dots/extra/bin/dots-theme-set catppuccin-mocha`
4. Symlink configs: `ln -s ~/.dots/.config ~/.config`
5. Set shell: `chsh -s /usr/bin/zsh`

See [SETUP.md](SETUP.md) for detailed instructions.

## Key Applications

- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Walker, Rofi
- **Shell**: Zsh with Starship prompt
- **System Monitor**: Btop
- **Notifications**: Mako
- **Session Menu**: Wlogout
- **Lock Screen**: Hyprlock

## Credits

- [HyDE Project](https://github.com/HyDE-Project/HyDE)
- [Omarchy](https://github.com/basecamp/omarchy)
- [Catppuccin](https://github.com/catppuccin/catppuccin)

