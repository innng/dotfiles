# Arch Linux Hyprland Dotfiles

Modern, self-contained dotfiles for Arch Linux with Hyprland window manager, featuring Catppuccin Mocha theme and a carefully curated selection of tools from the HyDE and Omarchy projects.

## Quick Start

### 1. Install Packages
```bash
pacman -S $(grep -v '^#' ~/.dots/extra/PACKAGES.lst | tr '\n' ' ')
```

### 2. Configure Shell
Add to `~/.zshenv`:
```bash
export ZDOTDIR="$HOME/.dots/.config/zsh"
```

Make Zsh your default shell:
```bash
chsh -s /usr/bin/zsh
```

### 3. Launch Hyprland
Log out and select Hyprland at login, or:
```bash
exec Hyprland
```

## What's Included

- **Window Manager**: Hyprland with modular configuration
- **Terminal**: Kitty with Catppuccin Mocha colors
- **Shell**: Zsh + Tmux + Starship
- **Launchers**: Rofi + Walker
- **System Tools**: Btop, ripgrep, eza, fzf, impala, bluetui
- **Audio**: PipeWire stack with wiremix mixer
- **Fonts**: FiraCode, Mononoki, JetBrains Mono Nerd fonts
- **Theming**: Consistent Catppuccin Mocha across all apps
- **77 curated packages** selected from HyDE and Omarchy

## Directory Structure

```
~/.dots/
├── .config/              # Application configurations
│   ├── hypr/             # Hyprland window manager
│   ├── kitty/            # Terminal emulator
│   ├── zsh/              # Shell configuration
│   ├── starship/         # Shell prompt
│   ├── rofi/             # Application launcher
│   ├── tmux/             # Terminal multiplexer
│   ├── gtk-3.0/          # GTK theming
│   ├── qt5ct/ & qt6ct/   # Qt configuration
│   └── ... (15+ more apps)
├── extra/                # Reference and utility files
│   ├── theme/            # Centralized theme system
│   │   ├── catppuccin-mocha.sh    # Theme definition
│   │   ├── generate-theme.sh      # Color generator
│   │   └── generated/             # Generated app configs
│   ├── source/hypr/      # Default Hyprland configs
│   └── PACKAGES.lst      # Package list for installation
├── etc/                  # System-level configurations
├── SETUP.md              # Detailed setup guide
├── INSTALL.sh            # Installation script
└── README.md             # This file
```

## Key Features

- **Portable**: All paths relative to `~/.dots` - works anywhere
- **Self-contained**: No external dependencies or references
- **Consistent theme**: Catppuccin Mocha applied to terminal, launcher, window manager, and desktop
- **Clean organization**: Separate configs for each application
- **Well documented**: Comprehensive guides and comments

## Documentation

- **[SETUP.md](SETUP.md)**: Complete installation and configuration guide
- **[THEME.md](THEME.md)**: Centralized theme system and color management
- **[STATUS.md](STATUS.md)**: Project status and completion details
- **[COPY_LOG.md](COPY_LOG.md)**: Details on files copied from HyDE and Omarchy
- **[DIFF_PROPOSALS.md](DIFF_PROPOSALS.md)**: Configuration decisions and modifications
- **[MODIFICATIONS_APPLIED.md](MODIFICATIONS_APPLIED.md)**: Summary of applied changes

## Theme

**Catppuccin Mocha** with centralized theme management:

| Color | Hex Value | Usage |
|-------|-----------|-------|
| Background | #1e1e2e | Base color |
| Primary | #89b4fa | Accent (blue) |
| Secondary | #cba6f7 | Accent (purple) |
| Text | #cdd6f4 | Foreground |

### Theme System

Colors are centrally defined and automatically generated for each application:

- **Source**: `~/.dots/extra/theme/catppuccin-mocha.sh`
- **Generator**: `~/.dots/extra/theme/generate-theme.sh`
- **Generated**: `~/.dots/extra/theme/generated/` (for each app)

**To change theme**: Edit `catppuccin-mocha.sh` and run `generate-theme.sh`

**To add a new theme**: Copy the theme file, modify colors, run generator

See **[THEME.md](THEME.md)** for complete theme documentation.

## First Time Setup

1. **Read**: Start with [SETUP.md](SETUP.md) for comprehensive instructions
2. **Install**: Run package installation (5-10 minutes)
3. **Configure**: Add `ZDOTDIR` to `~/.zshenv` (1 minute)
4. **Launch**: Select Hyprland at login or run `exec Hyprland`
5. **Customize**: Modify configs in `~/.dots/.config/` as needed

**Estimated total time**: 30-45 minutes

## Package Categories

The 77 packages cover:

- Window manager & display (Hyprland, Waybar)
- Terminal & shell (Kitty, Zsh, Tmux, Starship)
- Launchers (Rofi, Walker)
- System tools (Btop, ripgrep, eza, fzf)
- Audio stack (PipeWire, Wireplumber, Wiremix)
- Fonts (Noto, FiraCode, Mononoki, JetBrains Mono Nerd)
- Theming (Qt5, Qt6, GTK, Kvantum, Nwg-look)
- Utilities (Jq, imagemagick, dust, bluez, networkmanager)

Full list: `~/.dots/extra/PACKAGES.lst`

## Default Keybindings

Hyprland uses standard keybindings:

- **Super (Windows key)** + **Return**: Open terminal (Kitty)
- **Super** + **D**: Show launcher (Rofi)
- **Super** + **Q**: Close window
- **Super** + **M**: Exit Hyprland
- **Super** + **Arrow keys**: Navigate windows
- **Super** + **Shift** + **Arrow keys**: Move windows
- **Super** + **1-10**: Switch workspaces

See `~/.dots/.config/hypr/bindings/` for complete keybinding configuration.

## Wallpaper

The dotfiles include **awww** for wallpaper management:

```bash
awww &
```

Or set manually:
```bash
swww init && swww img /path/to/wallpaper.png
```

## Audio Control

Audio is managed through PipeWire with **wiremix** TUI mixer:

```bash
wiremix
```

Or use volume keys (configured in Hyprland).

## System Monitoring

View system stats with **Btop**:

```bash
btop
```

## File Manager

**Dolphin** file manager with KDE integration:

```bash
dolphin
```

## Customization

All configurations can be customized by editing files in `~/.dots/.config/`:

- **Keybindings**: `~/.dots/.config/hypr/bindings/`
- **Terminal**: `~/.dots/.config/kitty/kitty.conf`
- **Shell**: `~/.dots/.config/zsh/`
- **Prompt**: `~/.dots/.config/starship/starship.toml`
- **Launcher**: `~/.dots/.config/rofi/`
- **Colors**: Individual config files (see SETUP.md)

## Troubleshooting

**Issue**: Shell doesn't use dotfiles configuration
- **Fix**: Ensure `~/.zshenv` has `export ZDOTDIR="$HOME/.dots/.config/zsh"`

**Issue**: Fonts don't render correctly
- **Fix**: Reinstall nerd fonts: `pacman -S ttf-mononoki-nerd ttf-firacode-nerd`

**Issue**: Hyprland won't start
- **Fix**: Check logs with `journalctl -xe`, see SETUP.md troubleshooting section

**Issue**: Theme colors look wrong
- **Fix**: Verify Catppuccin packages installed, check `~/.dots/.config/` theme files

See [SETUP.md](SETUP.md) for more troubleshooting steps.

## Credits

Configuration sources:
- **HyDE**: https://github.com/HyDE-Project/HyDE - Modern Hyprland setup
- **Omarchy**: https://github.com/basecamp/omarchy - Clean, modular configs
- **Catppuccin**: https://catppuccin.com - Beautiful color palette

## License

These dotfiles are provided as-is. Individual application licenses apply to their respective configurations.

## Support

For issues or questions:
1. Check [SETUP.md](SETUP.md) troubleshooting section
2. Review [STATUS.md](STATUS.md) for configuration details
3. Check individual application documentation

---

**Ready to dive in?** Start with [SETUP.md](SETUP.md) for detailed installation instructions.
