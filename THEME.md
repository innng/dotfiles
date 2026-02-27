# Theme Architecture

## Overview

The dotfiles use a **centralized, generator-based theme system** for consistent, maintainable color management across all applications.

**Key principle**: Single source of truth → Generated configs → Application integration

---

## Architecture

### Single Source of Truth

**File**: `~/.dots/extra/theme/catppuccin-mocha.sh`

Defines all colors as shell variables:

```bash
export THEME_BG="#1e1e2e"           # Background
export THEME_FG="#cdd6f4"           # Foreground
export THEME_PRIMARY="#89b4fa"      # Primary accent (blue)
export THEME_SECONDARY="#f5c2e7"    # Secondary accent (pink)
export THEME_ACCENT="#cba6f7"       # Accent accent (purple)

# ANSI Colors (0-15)
export THEME_COLOR0="#45475a"
# ... plus 15 more colors

# UI Colors
export THEME_ERROR="#f38ba8"        # Error/destructive
export THEME_SUCCESS="#a6e3a1"      # Success
export THEME_WARNING="#f9e2af"      # Warning
```

### Theme Generator

**File**: `~/.dots/extra/theme/generate-theme.sh`

Reads color variables and generates application-specific configs:

```bash
~/.dots/extra/theme/generate-theme.sh [theme-file]
```

**Usage**:
```bash
# Generate from catppuccin-mocha.sh (default)
~/.dots/extra/theme/generate-theme.sh

# Generate from a different theme
~/.dots/extra/theme/generate-theme.sh catppuccin-latte.sh
```

### Generated Configs

Generated files are created in `~/.dots/extra/theme/generated/`:

```
generated/
├── rofi.colors          # Rofi launcher colors
├── dunst.colors         # Dunst notification colors
├── hyprland.colors      # Hyprland window manager colors
└── kitty.colors         # Kitty terminal colors
```

**Important**: Generated files should **never be edited manually**. They are recreated each time the generator runs.

### Application Integration

Each application sources its generated color file:

#### Rofi

**File**: `~/.config/rofi/theme.rasi`

```rasi
/* Import theme colors from generated config */
@import "../../extra/theme/generated/rofi.colors"
```

#### Dunst

**File**: `~/.config/dunst/dunst.conf`

```ini
[colors]
background = #1e1e2e
foreground = #cdd6f4
frame_color = #89b4fa

# ... (added by generator)
```

#### Hyprland

**File**: `~/.config/hypr/hyprland.conf`

```conf
# Theme Colors - sourced from generated config
source = ~/.dots/extra/theme/generated/hyprland.colors
```

#### Kitty

**File**: `~/.config/kitty/hyde.conf`

```conf
# Theme Colors - sourced from generated config
include ../../extra/theme/generated/kitty.colors
```

---

## How It Works

### Step-by-Step Flow

1. **Edit theme definition** (optional)
   ```bash
   vim ~/.dots/extra/theme/catppuccin-mocha.sh
   ```

2. **Run generator**
   ```bash
   ~/.dots/extra/theme/generate-theme.sh
   ```

3. **Generator creates configs**
   - Reads `catppuccin-mocha.sh`
   - Loads all color variables
   - Converts to each app's format
   - Writes to `generated/` directory

4. **Apps use generated files**
   - Applications source/import generated files
   - Colors are applied immediately
   - No application restarts needed (usually)

### Color Formats

The same colors are converted to different application formats:

**Theme Definition** (Shell):
```bash
export THEME_BG="#1e1e2e"
```

**Rofi** (CSS-like):
```css
main-bg: #1e1e2ee6;
```

**Dunst** (INI):
```ini
background = #1e1e2e
```

**Hyprland** (0xffRRGGBB):
```conf
$bg = 0xff1e1e2e
```

**Kitty** (Raw hex):
```conf
background #1e1e2e
```

---

## Current Theme: Catppuccin Mocha

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Background | #1e1e2e | Main background |
| Foreground | #cdd6f4 | Main text |
| Primary | #89b4fa | Accent (blue) |
| Secondary | #f5c2e7 | Secondary (pink) |
| Accent | #cba6f7 | Accent (purple) |
| Error | #f38ba8 | Destructive actions |
| Success | #a6e3a1 | Success/positive |
| Warning | #f9e2af | Warnings/attention |

### ANSI Colors

Full 16-color palette for terminal emulators:

- **0-7**: Dark colors (black, red, green, yellow, blue, magenta, cyan, white)
- **8-15**: Bright variants

Reference: `~/.dots/extra/theme/catppuccin-mocha.sh`

---

## Adding a New Theme

To add support for a different theme (e.g., Catppuccin Latte):

### 1. Create Theme File

```bash
cp ~/.dots/extra/theme/catppuccin-mocha.sh \
   ~/.dots/extra/theme/catppuccin-latte.sh
```

### 2. Edit Colors

```bash
vim ~/.dots/extra/theme/catppuccin-latte.sh

# Update all color variables to Latte palette
export THEME_BG="#eff1f5"           # Light background
export THEME_FG="#4c4f69"           # Dark text
export THEME_PRIMARY="#1e66f5"      # Different primary
# ... etc
```

### 3. Generate Configs

```bash
~/.dots/extra/theme/generate-theme.sh catppuccin-latte.sh
```

### 4. Verify

Colors across all apps instantly update!

---

## Switching Themes

To switch between different themes:

```bash
# Switch to Latte
~/.dots/extra/theme/generate-theme.sh catppuccin-latte.sh

# Switch back to Mocha
~/.dots/extra/theme/generate-theme.sh catppuccin-mocha.sh

# Or just the default
~/.dots/extra/theme/generate-theme.sh
```

---

## Modifying Colors

### Quick Edit

To change a single color temporarily, edit the theme file:

```bash
vim ~/.dots/extra/theme/catppuccin-mocha.sh

# Change a color (e.g., primary from blue to red)
export THEME_PRIMARY="#e74c3c"

# Regenerate
~/.dots/extra/theme/generate-theme.sh
```

### Create Variant

To create a variant (e.g., darker background):

```bash
cp ~/.dots/extra/theme/catppuccin-mocha.sh \
   ~/.dots/extra/theme/catppuccin-mocha-dark.sh

# Edit colors, then generate
~/.dots/extra/theme/generate-theme.sh catppuccin-mocha-dark.sh
```

---

## File Structure

```
~/.dots/extra/theme/
├── catppuccin-mocha.sh              # Main theme definition
├── catppuccin-latte.sh              # Alternative theme (optional)
├── generate-theme.sh                # Generator script
└── generated/                        # AUTO-GENERATED (don't edit)
    ├── rofi.colors
    ├── dunst.colors
    ├── hyprland.colors
    └── kitty.colors
```

---

## Automation

### Installation

`INSTALL.sh` automatically generates theme files:

```bash
bash ~/.dots/INSTALL.sh
# ... during installation, runs: generate-theme.sh
```

### Manual Generation

After editing theme definitions:

```bash
~/.dots/extra/theme/generate-theme.sh
```

---

## Benefits

### Single Source of Truth
- ✅ All colors defined in one place
- ✅ No duplication
- ✅ Easy to verify consistency

### Theme Switching
- ✅ Change entire theme with one command
- ✅ Add new themes in minutes
- ✅ Test color schemes instantly

### Maintainability
- ✅ Clear separation of concerns
- ✅ Generated files marked as auto-generated
- ✅ Documentation in theme file itself

### No Dependencies
- ✅ Pure shell script
- ✅ No template engines (no jinja2, envsubst, etc.)
- ✅ Just variable substitution

### Flexibility
- ✅ Easy to add new applications
- ✅ Different color formats per app
- ✅ Can manually override generated files if needed

---

## Troubleshooting

### Colors not updating?

1. Verify generation succeeded:
   ```bash
   ~/.dots/extra/theme/generate-theme.sh
   ```

2. Restart the application:
   ```bash
   # Kill and restart (e.g., rofi)
   pkill rofi
   rofi -show run
   ```

3. For Hyprland, reload config:
   ```bash
   hyprctl reload
   ```

### Generated files look wrong?

1. Check theme file:
   ```bash
   cat ~/.dots/extra/theme/catppuccin-mocha.sh
   ```

2. Verify generator script:
   ```bash
   bash ~/.dots/extra/theme/generate-theme.sh --verbose
   ```

3. Check generated output:
   ```bash
   cat ~/.dots/extra/theme/generated/rofi.colors
   ```

### How to add colors to app not yet supported?

1. Create generator function in `generate-theme.sh`:
   ```bash
   generate_myapp_colors() {
       local file="$GENERATED_DIR/myapp.colors"
       cat > "$file" << EOF
   # Generated config for MyApp
   color_bg = $THEME_BG
   color_fg = $THEME_FG
   EOF
   }
   ```

2. Call in main():
   ```bash
   main() {
       # ... other generators ...
       generate_myapp_colors
   }
   ```

3. Update app config to source generated file

---

## Related Files

- **Theme definitions**: `~/.dots/extra/theme/catppuccin-*.sh`
- **Generator script**: `~/.dots/extra/theme/generate-theme.sh`
- **Generated configs**: `~/.dots/extra/theme/generated/*`
- **Installation automation**: `~/.dots/INSTALL.sh`

---

## Maintenance

### When to regenerate?

- ✅ After editing a theme definition file
- ✅ After switching themes
- ✅ After modifying generator script
- ✅ When adding new applications

### When NOT to regenerate?

- ❌ Don't edit generated files manually
- ❌ Don't commit generated files to version control (gitignore added)
- ❌ Don't run generator while apps are loading

---

## Summary

The theme system provides:

1. **Centralized color management** in shell format
2. **Automatic generation** of application-specific configs
3. **Instant theme switching** without editing multiple files
4. **Easy addition** of new themes and applications
5. **Clear separation** between manual edits (theme) and auto-generated (configs)

**Workflow**: Edit theme → Run generator → Enjoy consistent colors everywhere!
