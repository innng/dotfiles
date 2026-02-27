# Arch Linux + Hyprland Dotfiles Setup

A unified, customizable dotfiles project combining the best of HyDE and Omarchy projects. Uses Catppuccin Mocha theme with a template-based system for theming.

## Directory Structure

```
~/.dots/
├── .config/                    # User configuration files
│   ├── hypr/                  # Hyprland WM configuration
│   ├── waybar/                # Status bar configuration
│   ├── mako/                  # Notification daemon config
│   ├── rofi/                  # Application launcher config
│   ├── walker/                # Application runner config
│   ├── kitty/                 # Terminal emulator config
│   ├── zsh/                   # Shell configuration
│   ├── starship.toml          # Prompt configuration
│   ├── tmux/                  # Terminal multiplexer config
│   ├── dolphin/               # File manager config
│   ├── gtk-3.0/               # GTK theme settings
│   ├── qt5ct/                 # Qt5 theme settings
│   ├── qt6ct/                 # Qt6 theme settings
│   ├── Kvantum/               # Qt styling config
│   ├── wlogout/               # Logout menu config
│   ├── lazygit/               # Git TUI config
│   ├── theme/                 # Generated themed configs (symlink here)
│   └── omarchy/               # Omarchy-specific configs
│
├── extra/
│   ├── source/                # Source files and dependencies
│   │   ├── hypr/              # Default Hyprland configs (omarchy base)
│   │   ├── rofi/              # Rofi themes and assets (HyDE)
│   │   ├── omarchy-hooks/     # Omarchy theme hooks
│   │   └── omarchy-bin/       # Omarchy executable scripts
│   │
│   ├── themed/                # Template files for theme processing
│   │   └── *.tpl              # Template files with {{ color }} placeholders
│   │
│   └── themes/
│       └── catppuccin-mocha/  # Catppuccin Mocha theme
│           ├── colors.toml    # Color definitions
│           ├── backgrounds/   # Wallpaper files
│           ├── icons.theme    # Icon theme
│           ├── btop.theme     # System monitor theme
│           ├── neovim.lua     # Neovim theme
│           ├── vscode.json    # VS Code theme
│           └── waybar.css     # Waybar theme
│
└── SETUP.md                   # This file
```

## Quick Start

### 1. Install Base System

Ensure you have a fresh Arch Linux installation with internet access.

### 2. Clone Dotfiles

```bash
git clone <your-repo-url> ~/.dots
cd ~/.dots
```

### 3. Install Packages

```bash
# Install all required packages
pacman -S --needed - < extra/packages.lst

# Or for AUR packages, use your preferred AUR helper (yay, paru, etc.)
yay -S --needed - < extra/packages.lst
```

### 4. Create Symbolic Links

Link configuration files to their proper locations:

```bash
# Create necessary directories
mkdir -p ~/.config/hypr ~/.config/waybar ~/.config/mako ~/.local/share/wayland-sessions

# Link main configs (examples - adjust based on your setup)
ln -s ~/.dots/.config/hypr/* ~/.config/hypr/
ln -s ~/.dots/.config/waybar/* ~/.config/waybar/
ln -s ~/.dots/.config/mako/* ~/.config/mako/
ln -s ~/.dots/.config/zsh/* ~/.config/zsh/
ln -s ~/.dots/.config/kitty/* ~/.config/kitty/
ln -s ~/.dots/.config/rofi/* ~/.config/rofi/
ln -s ~/.dots/.config/wlogout/* ~/.config/wlogout/
ln -s ~/.dots/.config/tmux/tmux.conf ~/.config/tmux.conf
ln -s ~/.dots/.config/starship.toml ~/.config/starship.toml

# Link themed configs (once generated)
ln -s ~/.dots/.config/theme/* ~/.config/
```

### 5. Theme Generation and Setup

The dotfiles use a simplified template system inherited from Omarchy:

#### Process Overview:
1. Templates in `~/.dots/extra/themed/*.tpl` contain `{{ color }}` placeholders
2. Colors are defined in `~/.dots/extra/themes/catppuccin-mocha/colors.toml`
3. Running the theme processor generates final configs in `~/.dots/.config/theme/`
4. Other configs source colors from `~/.dots/.config/theme/`

#### Using Omarchy Theme Scripts:

The Omarchy binaries in `~/.dots/extra/source/omarchy-bin/` handle theme processing:

```bash
# Make scripts executable
chmod +x ~/.dots/extra/source/omarchy-bin/*

# Set theme (processes templates and generates configs)
~/.dots/extra/source/omarchy-bin/omarchy-theme-set-templates

# Apply theme hooks (if needed)
~/.dots/extra/source/omarchy-bin/omarchy-refresh-theme
```

#### Manual Theme Processing:

If you prefer to process templates manually:

```bash
# For each template file:
# 1. Read colors.toml
# 2. Replace {{ color_name }} placeholders with actual colors
# 3. Output to ~/.dots/.config/theme/

# Example using a simple shell script
for tpl in ~/.dots/extra/themed/*.tpl; do
    # Generate config from template
    envsubst < "$tpl" > ~/.dots/.config/theme/$(basename "${tpl%.tpl}")
done
```

### 6. Shell Configuration

Set zsh as default shell:

```bash
chsh -s /usr/bin/zsh
```

Log out and back in for changes to take effect.

### 7. Enable Services

Enable necessary systemd user services:

```bash
# Audio
systemctl --user enable pipewire pipewire-pulse wireplumber

# Hyprland session (if using UWSM)
systemctl --user enable uwsm

# Optional: notification daemon
systemctl --user enable mako
```

### 8. Hyprland Session Configuration

For UWSM (recommended):

```bash
# Create session file
mkdir -p ~/.local/share/wayland-sessions
# Use the UWSM-compatible Hyprland session
```

For traditional login manager:

```bash
# Session should be auto-detected after installing hyprland
```

## Configuration Notes

### Hyprland
- **Base config**: `~/.dots/.config/hypr/hyprland.conf`
- **Bindings**: `~/.dots/.config/hypr/bindings.conf`
- **Monitor setup**: `~/.dots/.config/hypr/monitors.conf`
- **Input config**: `~/.dots/.config/hypr/input.conf`
- **Idle & lock**: `hypridle.conf`, `hyprlock.conf`
- **Sources default from omarchy**: `~/.dots/extra/source/hypr/default/`

### Theme System
- **Color source**: `~/.dots/extra/themes/catppuccin-mocha/colors.toml`
- **Templates**: `~/.dots/extra/themed/*.tpl`
- **Generated configs**: `~/.dots/.config/theme/` (created by theme processor)
- **Referenced by**: Other configs source from `~/.config/theme/colors.conf` or similar

### Status Bar (Waybar)
- **Config**: `~/.dots/.config/waybar/config.jsonc`
- **Styles**: `~/.dots/.config/waybar/style.css`
- **Theme colors**: Sourced from `~/.config/theme/` or embedded

### Terminal (Kitty)
- **Main config**: `~/.dots/.config/kitty/kitty.conf`
- **Theme files**: `~/.dots/.config/kitty/theme.conf`
- **Additional**: `~/.dots/.config/kitty/hyde.conf`

### Application Launcher (Rofi)
- **Main theme**: `~/.dots/.config/rofi/theme.rasi`
- **Menu themes**: `~/.dots/extra/source/rofi/themes/` (23 variations)
- **Assets**: `~/.dots/extra/source/rofi/assets/`

### Shell (Zsh)
- **Main config**: `~/.dots/.config/zsh/.zshrc`
- **Prompt**: Uses Starship (`~/.dots/.config/starship.toml`)
- **Plugins**: Copy/symlink zsh plugin managers as needed

### File Manager (Dolphin)
- **Config**: `~/.dots/.config/dolphin/dolphinrc`
- **Built-in file manager for Hyprland**

### Audio (PipeWire + WireМanger + Audio TUI Tools)
- **PipeWire config**: System-level (in `/etc/pipewire/`)
- **Audio control**: 
  - `wiremix` - Wire configuration (TUI)
  - `impala` - Volume control (TUI alternative to pavucontrol)
  - `pamixer` - Command-line volume control

### Notifications (Mako)
- **Config**: `~/.dots/.config/mako/config`
- **Daemon**: Enable with `systemctl --user enable mako`

### Prompt (Starship)
- **Config**: `~/.dots/.config/starship.toml`
- **Features**: Cross-shell, Git integration, language indicators

## Customization

### Changing the Theme

To use a different Catppuccin variant or custom colors:

1. Create new theme directory: `~/.dots/extra/themes/your-theme/`
2. Add `colors.toml` with color definitions
3. Update theme processor to use new colors.toml
4. Regenerate configs in `~/.dots/.config/theme/`

### Adding New Packages

Edit `~/.dots/extra/packages.lst` and install:

```bash
pacman -S your-new-package
```

### Modifying Keybindings

Edit `~/.dots/.config/hypr/bindings.conf` and reload Hyprland with `Super+Shift+R`.

### Updating Rofi Menus

Copy additional menu themes from `~/.dots/extra/source/rofi/themes/` to `~/.config/rofi/` and configure in rofi config.

## Omarchy Integration Notes

This dotfiles setup uses several Omarchy components:

1. **Base Hyprland config**: `~/.dots/extra/source/hypr/` (sourced by main config)
2. **Theme system**: Omarchy's template-based theming with colors.toml
3. **Hooks**: Sample hooks in `~/.dots/extra/source/omarchy-hooks/`
4. **Binaries**: Utility scripts in `~/.dots/extra/source/omarchy-bin/`

For full Omarchy documentation, visit: https://github.com/owozsh/omarchy

## HyDE Integration Notes

This dotfiles setup incorporates HyDE components:

1. **Rofi themes and assets**: `~/.dots/extra/source/rofi/`
2. **Configuration bases**: Various configs adapted from HyDE
3. **Styling approach**: GTK/Qt theming methodology from HyDE

For full HyDE documentation, visit: https://github.com/Jithu-kayan/HyDE

## Troubleshooting

### Hyprland won't start
- Check `~/.config/hypr/hyprland.conf` for syntax errors
- Verify all sourced files exist and are readable
- Check journal: `journalctl --user -xe`

### Theme not applying
- Ensure `~/.dots/.config/theme/` exists and contains generated configs
- Re-run theme processor: `~/.dots/extra/source/omarchy-bin/omarchy-theme-set-templates`
- Verify colors.toml has correct color definitions

### Rofi/Walker not launching
- Check that rofi/walker packages are installed
- Verify config files are readable
- Test with: `rofi -show drun` or `walker`

### Audio issues
- Check PipeWire status: `systemctl --user status pipewire`
- Verify WireManager: `systemctl --user status wireplumber`
- List devices: `pactl list sinks`

### Broken symlinks
- Check if source files were properly copied to `~/.dots/`
- Verify all symlink targets exist before creating links

## Additional Resources

- **Hyprland**: https://hyprland.org/
- **Arch Linux**: https://archlinux.org/
- **PipeWire**: https://pipewire.org/
- **Catppuccin**: https://catppuccin.com/
- **Nerd Fonts**: https://www.nerdfonts.com/
