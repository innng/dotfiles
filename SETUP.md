# Dots Setup Guide

A simplified dotfiles project for Arch Linux + Hyprland based on merging [HyDE](https://github.com/HyDE-Project/HyDE) and [Omarchy](https://github.com/basecamp/omarchy) projects.

**Status**: Work in progress - Theme system fully integrated, main applications configured.

---

## Project Overview

This dotfiles repository provides a complete Hyprland desktop environment setup with:
- **Unified theme system** using Catppuccin Mocha
- **Modular configuration structure** for easy maintenance
- **Simplified installation** without heavy dependencies on external projects

### Key Design Decisions

#### 1. No External Project Dependencies
- **Decision**: Do not clone upstream HyDE or Omarchy projects
- **Rationale**: Reduces complexity, avoids bloated dependencies, makes the setup self-contained
- **Implementation**: Copied configs as-is, modified paths to local directories

#### 2. Centralized Theme System
- **Decision**: Single Catppuccin Mocha theme (no theme switching UI)
- **Rationale**: Simplifies maintenance, reduces config complexity
- **Structure**:
  ```
  ~/.dots/.config/theme/          # Generated theme outputs
  ~/.dots/extra/themes/           # Theme source files
  ~/.dots/extra/source/templates/ # Theme templates for generation
  ```
- **Process**: `dots-theme-set catppuccin-mocha` generates configs in `~/.dots/.config/theme/`

#### 3. No hyde-shell Dependency
- **Decision**: Do not include hyde-shell scripts
- **Rationale**: Reduces external dependencies, supports standard systemctl commands
- **Changes**: Updated keybindings and commands to use standard equivalents (e.g., `systemctl terminate-user $USER` for logout)

#### 4. Simplified Waybar Configuration
- **Original Omarchy**: 20+ custom modules with complex dependencies
- **Decision**: Keep only essential modules
- **Final Modules**: workspaces, clock, network, battery, pulseaudio, bluetooth, cpu, tray, idle-inhibitor
- **Theme Integration**: Colors imported from `~/.dots/.config/theme/waybar.css`

#### 5. Font Management
- **Created**: `dots-font-set` and `dots-font-list` scripts
- **Purpose**: Manage fonts across kitty, hyprlock, waybar uniformly
- **Default Font**: Mononoki Nerd Font Mono

#### 6. Wlogout Simplification
- **Original**: Used hyde-shell commands
- **Updated**: Replace with `loginctl terminate-user $USER` and `hyprlock`

#### 7. Config File Organization
```
~/.dots/
├── .config/              # Working configs (used directly)
├── .config/theme/        # Generated theme files (created by dots-theme-set)
├── extra/bin/            # Utility scripts
├── extra/themes/         # Theme source files
├── extra/source/         # Reference configs and theme templates
└── etc/                  # System-level configs
```

---

## Installation

### Prerequisites

- **OS**: Arch Linux
- **Bootloader**: GRUB (with [Catppuccin GRUB theme](https://github.com/catppuccin/grub) recommended)
- **Display Manager**: SDDM (with [Catppuccin SDDM theme](https://github.com/catppuccin/sddm) recommended)

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/dots ~/.dots
cd ~/.dots
```

### Step 2: Install Required Packages

Install all required packages using the provided package list:

```bash
yay -S $(cat extra/packages.lst | grep -v '^#' | grep -v '^$')
```

**Package Categories** (60+ total):
- **Audio**: pulseaudio, pipewire, pipewire-alsa, pipewire-pulse, wireplumber
- **Network**: iwd, dhcpcd, networkmanager
- **Window Manager**: hyprland, hyprlock, hyprwayland-protocols
- **Utilities**: swww, wlogout, walker, rofi, dunst, mako, kitty, fastfetch
- **Fonts**: noto-fonts, fontconfig, noto-fonts-cjk, ttf-nerd-fonts-symbols, ttf-mononoki, ttf-jetbrains-mono
- **Portal Services**: xdg-desktop-portal, xdg-desktop-portal-hyprland, xdg-portal-kde
- **Applications**: waybar, btop, git, zsh, starship, neovim, nautilus, firefox
- **AUR Packages**: visual-studio-code-bin, hyprshot, uwsm, sddm-catppuccin-theme, grub-catppuccin-theme

### Step 3: Generate Theme Files

The theme system requires generating config files from templates using Catppuccin Mocha colors:

```bash
~/.dots/extra/bin/dots-theme-set catppuccin-mocha
```

This command:
1. Copies theme files from `~/.dots/extra/themes/catppuccin-mocha/`
2. Generates configs from templates in `~/.dots/extra/source/templates/`
3. Outputs to `~/.dots/.config/theme/`
4. Reloads relevant applications (waybar, hyprlock, kitty, mako, btop)

### Step 4: Create Symlinks

Create symlinks from your XDG config directory to the dotfiles:

```bash
# Backup existing configs if needed
mkdir -p ~/.local/share/backup
[ -d ~/.config ] && mv ~/.config ~/.local/share/backup/config.bak

# Create new config directory and symlink
mkdir -p ~/.config
for dir in ~/.dots/.config/*/; do
  dir_name=$(basename "$dir")
  ln -s ~/.dots/.config/"$dir_name" ~/.config/"$dir_name"
done
```

Or use a simpler approach (if ~/.config doesn't exist):

```bash
ln -s ~/.dots/.config ~/.config
```

### Step 5: Set Default Shell to Zsh

```bash
chsh -s /usr/bin/zsh
```

Log out and log back in for changes to take effect.

### Step 6: Enable Required Services

```bash
# Network manager
sudo systemctl enable --now NetworkManager

# Display manager (SDDM)
sudo systemctl enable sddm

# Wireplumber (audio)
systemctl --user enable --now wireplumber
```

### Step 7: Configure SDDM and GRUB (Optional)

Follow the installation instructions for:
- [Catppuccin SDDM Theme](https://github.com/catppuccin/sddm)
- [Catppuccin GRUB Theme](https://github.com/catppuccin/grub)

---

## Configuration Files

### Essential Configurations

#### Hyprland (`~/.dots/.config/hypr/`)
- **hyprland.conf**: Main Hyprland configuration
  - Imports: `hypridle.conf`, `bindings.conf`, `monitors.conf`, `environment.conf`
  - Theme: Sources hyprland colors from `~/.dots/.config/theme/hyprland.conf`
- **bindings.conf**: Keybindings (Super key as modifier)
- **monitors.conf**: Monitor configuration (auto-generated by Hyprland)
- **environment.conf**: Environment variables
- **hypridle.conf**: Idle and lock screen settings

#### Kitty Terminal (`~/.dots/.config/kitty/`)
- **kitty.conf**: Terminal configuration (merged from HyDE + Omarchy)
  - Font: Mononoki Nerd Font Mono, 9pt
  - Padding: 25px
  - Sources: `~/.dots/.config/theme/kitty.conf` for colors
  - Decorations: Hidden (hide_window_decorations)

#### Waybar (`~/.dots/.config/waybar/`)
- **config.jsonc**: Bar layout and module configuration
- **style.css**: Styling with theme variables imported from `~/.dots/.config/theme/waybar.css`

#### Rofi (`~/.dots/.config/rofi/`)
- **theme.rasi**: Catppuccin Mocha theme (hardcoded)
- **extra/source/rofi/**: 24 theme files and scripts from HyDE (reference)

#### Walker (`~/.dots/.config/walker/`)
- **config.toml**: Configuration
  - Theme: Uses `catppuccin-mocha` from `extra/source/walker/themes/`

#### Mako Notifications (`~/.dots/.config/mako/`)
- **config**: Notification daemon config
  - Colors: Hardcoded Catppuccin Mocha (text-color, border-color, background-color)

#### Btop (`~/.dots/.config/btop/`)
- **btop.conf**: System monitor configuration
  - Theme: Uses `catppuccin-mocha.theme` from `~/.dots/.config/btop/themes/`

#### Wlogout (`~/.dots/.config/wlogout/`)
- **layout_1 & layout_2**: Session menu layouts
  - Updated: Uses `hyprlock` and `loginctl terminate-user $USER`

#### Zsh (`~/.dots/.config/zsh/`)
- **zshrc**: Main zsh configuration
- **Plugins**: Managed (check .zshrc for details)

#### Other Applications
- **starship/**: Shell prompt
- **git/**: Git configuration
- **nvim/**: Neovim (LazyVim setup)
- **dolphin/**: File manager settings
- **wireplumber/**: Audio configuration
- **uwsm/**: Universal Wayland Session Manager

---

## UWSM Configuration

The dotfiles use **UWSM** (Universal Wayland Session Manager) to manage environment variables across the session. The configuration is modular and extensible.

### UWSM Structure

```
~/.dots/.config/uwsm/
├── env                          # Main loader (sources env.d/*.sh)
├── env-hyprland                 # Hyprland-specific loader (sources env-hyprland.d/*.sh)
├── env.d/                       # Global environment variable scripts
│   ├── 01-gpu.sh               # GPU detection and VRAM allocation
│   └── 02-applications.sh      # BROWSER, TERMINAL, EDITOR defaults
└── env-hyprland.d/             # Hyprland-specific environment variables
    └── 00-hypr.sh              # Qt, Firefox, Electron, systemd settings
```

### Reference Implementation

`~/.dots/.config/uwsm-omarchy/` contains the original Omarchy UWSM integration as reference. Key insights:
- Omarchy provided PATH management for its binaries (now unnecessary since we use standard tools)
- Terminal/editor defaults were in a separate `default` file (now consolidated into `02-applications.sh`)
- Optional mise activation support is documented for future use

### Environment Variables by Category

**Application Defaults** (`env.d/02-applications.sh`):
- `BROWSER=firefox` - Default web browser (used by keybindings)
- `TERMINAL=kitty` - Default terminal (used by keybindings)
- `EDITOR=nvim` - Default text editor (used by keybindings)

Override example:
```bash
export BROWSER=chromium TERMINAL=alacritty EDITOR=vim
```

**GPU Setup** (`env.d/01-gpu.sh`):
- Automatically detects GPU hardware (AMD, Intel, NVIDIA, Nouveau)
- Sets appropriate VA-API and rendering drivers
- Configurations for common GPU setups: hybrid Intel-NVIDIA, AMD-only, etc.
- Users can create `env.d/03-custom-gpu.sh` to override defaults

**Hyprland Session** (`env-hyprland.d/00-hypr.sh`):
- **Qt variables**: `QT_QPA_PLATFORM`, `QT_AUTO_SCREEN_SCALE_FACTOR`, `QT_WAYLAND_DISABLE_WINDOWDECORATION`
- **Firefox**: `MOZ_ENABLE_WAYLAND=1` (performance optimization)
- **Electron apps**: `ELECTRON_OZONE_PLATFORM_HINT=auto`
- **Systemd integration**: `HYPRLAND_NO_SD_NOTIFY=1`, `HYPRLAND_NO_SD_VARS=1`

**HiDPI Scaling** (in `extra/source/hypr/envs.conf`):
- `GDK_SCALE=2` - Xwayland apps scaling (for high-DPI displays)
- Configured in Hyprland's native env config (takes precedence over UWSM)

### Extending UWSM

Add custom environment variables by creating new scripts in `~/.dots/.config/uwsm/env.d/`:

```bash
# Create: ~/.dots/.config/uwsm/env.d/03-custom.sh
#!/usr/bin/env sh

# Custom environment variables
export MY_CUSTOM_VAR="value"
export ANOTHER_VAR="another value"
```

Files are sourced alphabetically, so use numeric prefixes to control load order:
- `01-gpu.sh` (first - GPU detection)
- `02-applications.sh` (second - app defaults, uses GPU_SETUP from 01)
- `03-custom.sh` (custom additions)

### UWSM vs Hyprland vs Shell Environment

Three overlapping layers manage environment variables:

| Layer | Location | Loading | Precedence | Use For |
|-------|----------|---------|-----------|---------|
| **UWSM** | `~/.config/uwsm/` | At session start | Lowest | Session-wide vars (GPU, apps) |
| **Hyprland** | `extra/source/hypr/envs.conf` | On Hyprland start | Middle | Hyprland-specific (GDK_SCALE) |
| **Shell** | `~/.config/zsh/` | On shell start | Highest | Shell-specific (PATH, history) |

**Resolution order**: Shell env > Hyprland env > UWSM env

This allows overriding at any level:
- Set `BROWSER` globally in UWSM
- Override in Hyprland's `envs.conf`
- Override again in shell's `.zshrc`

### Troubleshooting UWSM Issues

**Application using wrong defaults:**
1. Check if `env.d/02-applications.sh` was sourced: `echo $BROWSER`
2. Override in shell: `export BROWSER=chromium` in `~/.zshrc`
3. Verify UWSM files have execute permissions: `chmod +x ~/.config/uwsm/env.d/*.sh`

**GPU drivers not detected:**
1. Check what was detected: Look at UWSM logs or check `echo $GPU_SETUP`
2. Create custom GPU config: `~/.config/uwsm/env.d/04-gpu-override.sh`
3. Verify drivers installed: `lspci -vv | grep -i gpu`

**HiDPI scaling not working:**
1. Scaling is in `extra/source/hypr/envs.conf`, not UWSM
2. Edit `~/.dots/extra/source/hypr/envs.conf` and change `GDK_SCALE` value
3. Reload Hyprland: `hyprctl reload` or restart session

---

## Theme System

### Theme Architecture

The theme system enables single-point color management for all applications:

```
User runs: dots-theme-set catppuccin-mocha
    ↓
Copies: ~/.dots/extra/themes/catppuccin-mocha/ → ~/.dots/.config/theme/
    ↓
Generates: ~/.dots/extra/source/templates/*.tpl → ~/.dots/.config/theme/
    ↓
Applications source from: ~/.dots/.config/theme/
```

### Theme Files Generated

When `dots-theme-set` is executed, the following theme files are generated:

| File | Purpose | Used By |
|------|---------|---------|
| `colors.toml` | Base color definitions | Templates |
| `kitty.conf` | Terminal colors | Kitty |
| `waybar.css` | Bar colors | Waybar |
| `mako.ini` | Notification colors | Mako |
| `btop.theme` | System monitor theme | Btop |
| `hyprlock.conf` | Lock screen colors | Hyprlock |
| `hyprland.conf` | Hyprland UI colors | Hyprland |
| `walker.css` | Launcher colors | Walker |
| `neovim.lua` | Editor colors | Neovim |
| `rofi.rasi` | Application launcher colors | Rofi |
| `obsidian.css` | Note app theme | Obsidian |
| `vscode.json` | VS Code colors | VS Code |
| `alacritty.toml` | Alternative terminal | Alacritty (if used) |
| `ghostty.conf` | Alternative terminal | Ghostty (if used) |
| `chromium.theme` | Browser theme | Chromium |
| `icons.theme` | Icon theme | Various |

### Catppuccin Mocha Palette

Primary colors used across the system:

```
Background: #1e1e2e
Foreground: #cdd6f4
Blue:       #89b4fa
Lavender:   #b4befe
Mauve:      #cba6f7
Pink:       #f5c2e7
Red:        #f38ba8
Peach:      #fab387
Yellow:     #f9e2af
Green:      #a6e3a1
Teal:       #94e2d5
```

---

## Utility Scripts

### `dots-theme-set`
Apply a theme and generate all config files.

```bash
~/.dots/extra/bin/dots-theme-set catppuccin-mocha
```

**What it does**:
- Copies theme files to `~/.dots/.config/theme/`
- Generates configs from templates
- Reloads active applications

### `dots-font-set`
Change monospace font across all applications.

```bash
~/.dots/extra/bin/dots-font-set "Mononoki Nerd Font Mono"
```

**Affected applications**: Kitty, Hyprlock, Waybar

### `dots-font-list`
List all available monospace fonts on the system.

```bash
~/.dots/extra/bin/dots-font-list
```

### `dots-theme-set-templates`
Internal script used by `dots-theme-set` to generate configs from templates.

---

## Keybindings

### Window Management
| Binding | Action |
|---------|--------|
| `Super + Enter` | Open terminal |
| `Super + D` | Open application launcher (Walker) |
| `Super + Shift + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle split |
| `Super + Left/Right/Up/Down` | Move focus |
| `Super + Shift + Left/Right/Up/Down` | Move window |

### Applications
| Binding | Action |
|---------|--------|
| `Super + Shift + B` | Open browser |
| `Super + Shift + E` | Open editor |
| `Super + Shift + M` | Open music player (Spotify) |
| `Super + Shift + N` | Open note app (Obsidian) |
| `Super + Shift + O` | Open file manager |

### System
| Binding | Action |
|---------|--------|
| `Super + L` | Lock screen |
| `Super + Alt + L` | Logout |
| `Print` | Screenshot |
| `Super + Alt + Delete` | Open wlogout menu |

**Note**: Some Omarchy-specific bindings reference scripts that aren't included (e.g., `omarchy-launch-*`). These may need customization for your workflow.

---

## Known Limitations and TODO

### Known Issues
1. **Omarchy script references**: Some config files still contain references to omarchy launch scripts (in hyprland bindings)
   - Location: `.config/hypr/bindings.conf`
   - These need to be replaced with your preferred launch methods

2. **Theme switching**: No UI for switching themes (by design - single Catppuccin Mocha theme)
   - To use a different theme, modify `extra/themes/` and run `dots-theme-set`

3. **External app theming**: Some applications not yet themed
   - Obsidian, Discord, Spotify, Firefox, Telegram have theme files in `.config/theme/` but need manual application

### TODO Items
- [ ] Create alternative theme (e.g., Catppuccin Latte)
- [ ] Add theme-switching UI (if needed)
- [ ] Implement background image management system
- [ ] Create setup wizard script for automating installation
- [ ] Add more application-specific configurations
- [ ] Document all available keybindings
- [ ] Create troubleshooting guide

---

## Customization

### Adding a New Application Configuration

1. Create config file in appropriate location under `.config/`
2. If themed, add template to `extra/source/templates/`
3. Create colors palette in `extra/themes/catppuccin-mocha/`
4. Run `dots-theme-set catppuccin-mocha` to generate theme file
5. Have application source from `~/.dots/.config/theme/`

### Changing Keybindings

Edit `~/.dots/.config/hypr/bindings.conf` and reload Hyprland:

```bash
hyprctl reload
```

### Updating Packages

Edit `extra/packages.lst` and reinstall:

```bash
yay -S $(cat extra/packages.lst | grep -v '^#' | grep -v '^$')
```

### Customizing the Theme

1. Modify colors in `extra/themes/catppuccin-mocha/colors.toml`
2. Update theme templates as needed
3. Run `dots-theme-set catppuccin-mocha`

---

## Project Structure

```
~/.dots/
├── .config/                          # User configs (symlinked to ~/.config)
│   ├── btop/                         # System monitor
│   │   └── themes/                   # Btop theme files
│   ├── dolphin/                      # File manager
│   ├── git/                          # Git config
│   ├── hypr/                         # Hyprland
│   │   ├── hyprland.conf
│   │   ├── bindings.conf
│   │   ├── monitors.conf
│   │   ├── environment.conf
│   │   ├── hypridle.conf
│   │   └── hyprlock.conf
│   ├── kitty/                        # Terminal
│   ├── mako/                         # Notifications
│   ├── nvim/                         # Neovim
│   ├── rofi/                         # Application launcher
│   ├── starship/                     # Shell prompt
│   ├── theme/                        # GENERATED theme files
│   ├── walker/                       # Launcher
│   ├── waybar/                       # Status bar
│   ├── wireplumber/                  # Audio
│   ├── wlogout/                      # Session menu
│   ├── zsh/                          # Shell
│   └── ...
│
├── extra/
│   ├── bin/                          # Utility scripts
│   │   ├── dots-font-list
│   │   ├── dots-font-set
│   │   ├── dots-theme-set
│   │   └── dots-theme-set-templates
│   │
│   ├── packages.lst                  # All required packages
│   │
│   ├── themes/                       # Theme source files
│   │   └── catppuccin-mocha/
│   │       ├── colors.toml
│   │       ├── btop.theme
│   │       └── ...
│   │
│   └── source/                       # Reference configs and templates
│       ├── hypr/                     # Hyprland reference configs
│       ├── mako/                     # Mako reference configs
│       ├── rofi/                     # Rofi themes and scripts (from HyDE)
│       ├── walker/                   # Walker themes
│       ├── waybar/                   # Waybar reference configs
│       └── templates/                # Theme templates (.tpl files)
│
├── etc/                              # System-level configs
│   ├── default/
│   └── sddm.conf
│
├── README.md                         # Project overview
├── SETUP.md                          # This file
└── .git/                             # Git repository
```

---

## TODO: Outstanding Tasks

### 1. Wallpaper Cycling with swww
- **Status**: Not implemented
- **Description**: Implement wallpaper cycling using `swww` (Wayland wallpaper daemon) to replace omarchy-menu background functionality
- **Target**: Keybinding `SUPER CTRL + SPACE` for cycling through wallpapers
- **Implementation**: 
  - Research HyDE and Omarchy approaches to swww integration (check their implementations)
  - Research swww transitions and API documentation
  - Create script to cycle through wallpapers in a configured directory
  - Add keybinding to hypr/bindings/utilities.conf
- **Files to modify**: 
  - `extra/source/hypr/bindings/utilities.conf` (Line 13)
  - `extra/source/hypr/autostart.conf` (add swww daemon)

### 2. Review Zsh Configuration
- **Status**: Not reviewed
- **Description**: Audit zsh shell configuration for any remaining HyDE/Omarchy dependencies
- **Files to review**:
  - `~/.dots/.config/zsh/conf.d/hyde/` - Verify all scripts are framework-agnostic
  - `~/.dots/.config/zsh/zshrc` - Check for external script dependencies
- **Action**: Remove HyDE branding, ensure compatibility with other shells if needed

### 3. Review Hyprland Configuration
- **Status**: Not reviewed
- **Description**: Comprehensive audit of Hyprland configuration for outdated or omarchy-specific settings
- **Files to review**:
  - `~/.dots/.config/hypr/` (active configs)
  - `~/.dots/extra/source/hypr/` (reference configs)
- **Action**: Ensure all configs follow modern Hyprland practices and are self-contained

### 4. Starship Prompt Configuration
- **Status**: In progress
- **Description**: Merge Omarchy, HyDE, and pure preset approaches for the shell prompt
- **Target**: Use `starship preset pure-preset` as foundation
- **Current implementations analyzed**:
  - **Pure preset**: Minimal, clean design with essential info (directory, git status, character)
  - **Omarchy config**: Simple format with directory, git branch, git status, and character symbols
  - **Current HyDE config**: Complex with many language/tool indicators, right-aligned modules
- **Merge strategy**:
  1. Start with `starship preset pure-preset` as base
  2. Integrate useful Omarchy elements: simplified git symbols and cleaner format
  3. Keep language/environment detection minimal (only show when in relevant directories)
  4. Preserve character indicator (success ❯ / error ✗) from Omarchy
  5. Consider single-line vs two-line prompt based on use case
- **Files involved**:
  - `~/.dots/.config/starship/starship.toml` (main active config)
  - `~/.dots/.config/starship-omarchy/starship.toml` (reference implementation)
  - `~/.dots/.config/starship/powerline.toml` (alternative theme for reference)
- **Decision needed**: Keep current complex config, or simplify to pure-based minimalist approach?

### 5. UWSM Configuration Consolidation
- **Status**: In progress
- **Description**: Review and merge `uwsm-omarchy/` configuration with new unified UWSM setup
- **Implementation**:
  - Restore `uwsm-omarchy/` directory
  - Analyze env vars and settings
  - Merge valuable configs into main UWSM structure
  - Document any Omarchy-specific setup that should be preserved
- **Files to review**:
  - `~/.dots/.config/uwsm-omarchy/env`
  - `~/.dots/.config/uwsm-omarchy/default/`

---

## Troubleshooting

### Applications not picking up theme colors
- Ensure `dots-theme-set catppuccin-mocha` was run
- Check that theme files exist in `~/.dots/.config/theme/`
- Restart the application

### Symlinks not working
- Ensure `~/.config` was properly symlinked or contains symlinks to dotfiles
- Verify with: `ls -la ~/.config/ | grep dots`

### Missing fonts
- Install nerd fonts: `yay -S noto-fonts ttf-nerd-fonts-symbols ttf-mononoki ttf-jetbrains-mono`
- Rebuild font cache: `fc-cache -fv`

### Hyprland not starting
- Check logs: `journalctl -xe`
- Ensure all dependencies are installed: `yay -S hyprland hyprlock wlogout hyprwayland-protocols`
- Verify SDDM is configured for Hyprland session

### Keybindings not working
- Reload Hyprland: `hyprctl reload`
- Check for conflicts in `bindings.conf`
- Verify syntax with: `grep -n "bind" ~/.dots/.config/hypr/bindings.conf | head -20`

---

## Contributing

Changes to the dotfiles should be made on the `test-5` branch and tested before merging.

```bash
cd ~/.dots
git checkout test-5
# Make changes
git add .
git commit -m "Description of changes"
git push origin test-5
```

---

## Credits

- **HyDE Project**: https://github.com/HyDE-Project/HyDE
- **Omarchy**: https://github.com/basecamp/omarchy
- **Catppuccin**: https://github.com/catppuccin/catppuccin

---

## License

This project builds upon HyDE and Omarchy. Please refer to their respective licenses for more information.
