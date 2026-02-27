# Diff Proposals - Configuration Integration

## Overview

This document contains proposed modifications to merge copied configurations from HyDE and Omarchy projects. Each modification is presented as a diff that can be reviewed and approved before applying.

**Total Proposals**: 6 major changes across key configuration files

---

## PROPOSAL 1: Hyprland Configuration Integration

### Description
Merge Omarchy's user configs with default configs to create a cohesive Hyprland setup.

### Current State
- `~/.dots/.config/hypr/hyprland.conf` sources Omarchy defaults from `~/.local/share/omarchy/` (which may not exist)
- We have copied both user and default configs locally

### Proposed Change
Update `hyprland.conf` to source from local dotfiles instead of external paths:

```diff
--- a/~/.dots/.config/hypr/hyprland.conf
+++ b/~/.dots/.config/hypr/hyprland.conf
@@ -1,20 +1,20 @@
 # Learn how to configure Hyprland: https://wiki.hyprland.org/Configuring/
 
-# Use defaults Omarchy defaults (but don't edit these directly!)
-source = ~/.local/share/omarchy/default/hypr/autostart.conf
-source = ~/.local/share/omarchy/default/hypr/bindings/media.conf
-source = ~/.local/share/omarchy/default/hypr/bindings/clipboard.conf
-source = ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf
-source = ~/.local/share/omarchy/default/hypr/bindings/utilities.conf
-source = ~/.local/share/omarchy/default/hypr/envs.conf
-source = ~/.local/share/omarchy/default/hypr/looknfeel.conf
-source = ~/.local/share/omarchy/default/hypr/input.conf
-source = ~/.local/share/omarchy/default/hypr/windows.conf
-source = ~/.config/omarchy/current/theme/hyprland.conf
+# Use local Omarchy defaults (reference copies in ~/.dots/extra/source/hypr/)
+source = ~/.config/hypr/defaults/autostart.conf
+source = ~/.config/hypr/defaults/bindings/media.conf
+source = ~/.config/hypr/defaults/bindings/clipboard.conf
+source = ~/.config/hypr/defaults/bindings/tiling-v2.conf
+source = ~/.config/hypr/defaults/bindings/utilities.conf
+source = ~/.config/hypr/defaults/envs.conf
+source = ~/.config/hypr/defaults/looknfeel.conf
+source = ~/.config/hypr/defaults/input.conf
+source = ~/.config/hypr/defaults/windows.conf
 
 # Change your own setup in these files (and overwrite any settings from defaults!)
 source = ~/.config/hypr/monitors.conf
 source = ~/.config/hypr/input.conf
 source = ~/.config/hypr/bindings.conf
 source = ~/.config/hypr/looknfeel.conf
 source = ~/.config/hypr/autostart.conf
 
 # Add any other personal Hyprland configuration below
 # windowrule = workspace 5, match:class qemu
```

### Additional Action Required
Copy defaults to `~/.dots/.config/hypr/defaults/`:
```bash
mkdir -p ~/.dots/.config/hypr/defaults/{bindings,apps}
cp ~/.dots/extra/source/hypr/*.conf ~/.dots/.config/hypr/defaults/
cp ~/.dots/extra/source/hypr/bindings/*.conf ~/.dots/.config/hypr/defaults/bindings/
cp ~/.dots/extra/source/hypr/apps/*.conf ~/.dots/.config/hypr/defaults/apps/
```

### Impact
- ✅ Removes external path dependency
- ✅ Keeps defaults in dotfiles for portability
- ✅ User configs can override defaults
- ✅ Easy to customize in `~/.config/hypr/` files

---

## PROPOSAL 2: Rofi Theme - Catppuccin Mocha Colors

### Description
Update Rofi theme to use Catppuccin Mocha colors for consistency across the desktop.

### Current State
`~/.dots/.config/rofi/theme.rasi` uses some Catppuccin colors but not consistently:
```
main-bg:    #11111be6  ✓ (Mocha base)
main-fg:    #cdd6f4ff  ✓ (Mocha text)
main-br:    #cba6f7ff  ✗ (Not Mocha standard)
main-ex:    #f5e0dcff  ✓ (Mocha rosewater)
select-bg:  #b4befeff  ✗ (Not Mocha standard)
select-fg:  #11111bff  ✓ (Mocha base)
```

### Reference Colors (from `catppuccin-mocha.toml`)
```
accent = #89b4fa (blue)
cursor = #f5e0dc (rosewater)
foreground = #cdd6f4 (text)
background = #1e1e2e (base)
selection_background = #f5e0dc (rosewater)
```

### Proposed Change
```diff
--- a/~/.dots/.config/rofi/theme.rasi
+++ b/~/.dots/.config/rofi/theme.rasi
@@ -1,10 +1,10 @@
 * {
-    main-bg:            #11111be6;
+    main-bg:            #1e1e2ee6;
     main-fg:            #cdd6f4ff;
-    main-br:            #cba6f7ff;
+    main-br:            #89b4faff;
     main-ex:            #f5e0dcff;
-    select-bg:          #b4befeff;
+    select-bg:          #89b4faff;
     select-fg:          #11111bff;
     separatorcolor:     transparent;
     border-color:       transparent;
 }
```

### Rationale
- Uses official Catppuccin Mocha accent (blue #89b4fa) for borders and selection
- Darkens background slightly to match exact Mocha base (#1e1e2e)
- Maintains contrast and readability

### Impact
- ✅ Consistent with Catppuccin Mocha across all apps
- ✅ Better visual integration with system theme
- ✅ Selection color now matches cursor/highlight

---

## PROPOSAL 3: Kitty Terminal Font Configuration

### Description
Update Kitty font to use available Nerd Fonts from our package list (FiraCode, Mononoki, JetBrains Mono).

### Current State
`~/.dots/.config/kitty/hyde.conf` specifies:
```
font_family CaskaydiaCove Nerd Font Mono
```

This font is not in our PACKAGES.lst and may not be available.

### Proposed Changes

**Option A: Use FiraCode Nerd Font (Recommended for ligatures)**
```diff
--- a/~/.dots/.config/kitty/hyde.conf
+++ b/~/.dots/.config/kitty/hyde.conf
@@ -1,6 +1,6 @@
 # This is the configuration file for kitty terminal
 # For more information, see https://sw.kovidgoyal.net/kitty/conf.html
 # For your custom configurations, put it in ./kitty.conf
-font_family CaskaydiaCove Nerd Font Mono
+font_family Fira Code Nerd Font Mono
 bold_font auto
 italic_font auto
 bold_italic_font auto
```

**Option B: Use JetBrains Mono Nerd Font**
```diff
-font_family CaskaydiaCove Nerd Font Mono
+font_family JetBrains Mono Nerd Font
```

**Option C: Use Mononoki Nerd Font**
```diff
-font_family CaskaydiaCove Nerd Font Mono
+font_family Mononoki Nerd Font
```

### Recommendation
**FiraCode** - Best for programming with excellent ligature support and readability

### Impact
- ✅ Font is available in PACKAGES.lst
- ✅ Improved ligature support for code
- ✅ Better terminal experience
- ⚠️ Font size may need adjustment (currently 9.0)

---

## PROPOSAL 4: Kitty Color Scheme Verification

### Description
Verify that Kitty's current Catppuccin Mocha colors match our reference palette.

### Current State
`~/.dots/.config/kitty/theme.conf` uses Catppuccin Mocha colors.

### Analysis
Comparing with `~/.dots/extra/colors/catppuccin-mocha.toml`:

**Matching Colors ✓**
- foreground: #CDD6F4 (text)
- background: #1E1E2E (base)
- cursor: #F5E0DC (rosewater)
- color0-15: All match reference palette

**Status**: ✅ **NO CHANGES NEEDED** - Colors are already correctly configured

### Impact
- ✓ Kitty is already using correct Catppuccin Mocha colors
- ✓ Ready for use

---

## PROPOSAL 5: Starship Prompt Configuration

### Description
Choose between HyDE's and Omarchy's Starship configurations.

### Current State
We have two versions:
- `~/.dots/.config/starship.hyde/` - Full HyDE configuration directory
- `~/.dots/.config/starship.toml.omarchy` - Single Omarchy config file

### Analysis

**HyDE Version** (`starship.hyde/`):
- Full directory structure with modular configs
- Complex theming system
- More customizations

**Omarchy Version** (`starship.toml.omarchy`):
- Single file configuration
- Simpler, more maintainable
- Cleaner format

### Proposed Change
Use Omarchy's simpler configuration and create standardized location:

```bash
# Create standard starship location
mkdir -p ~/.dots/.config/starship

# Use Omarchy version as primary (simpler, more maintainable)
mv ~/.dots/.config/starship.toml.omarchy ~/.dots/.config/starship/starship.toml

# Keep HyDE version as backup reference
mv ~/.dots/.config/starship.hyde ~/.dots/.config/starship/starship.hyde-backup
```

### Result
```
~/.dots/.config/starship/
├── starship.toml          (Active Omarchy config)
└── starship.hyde-backup/  (Reference copy)
```

### Impact
- ✅ Simpler, single-file configuration
- ✅ Easier to maintain and customize
- ✅ HyDE version available as reference
- ✅ Standard naming convention

---

## PROPOSAL 6: Shell Configuration - Zsh Setup

### Description
Verify and prepare Zsh configuration for use.

### Current State
Full HyDE Zsh configuration copied to `~/.dots/.config/zsh/`

### Analysis
Zsh config from HyDE is comprehensive with:
- Plugin configurations
- Theme settings
- Custom functions
- Aliases

**Status**: Already configured and ready to use

### Recommended Actions
```bash
# Create symlink for shell initialization (if needed)
# ln -s ~/.dots/.config/zsh ~/.config/zsh
```

### Impact
- ✓ HyDE Zsh config is comprehensive
- ✓ Ready to use as-is
- ✓ No modifications required
- ✅ **NO CHANGES NEEDED**

---

## Summary of Proposals

| # | Component | Type | Priority | Status |
|---|-----------|------|----------|--------|
| 1 | Hyprland | Integration | HIGH | Needs approval + action |
| 2 | Rofi Theme | Enhancement | HIGH | Needs approval |
| 3 | Kitty Font | Configuration | MEDIUM | Needs approval |
| 4 | Kitty Colors | Verification | LOW | ✅ No changes |
| 5 | Starship | Organization | MEDIUM | Needs approval |
| 6 | Zsh Shell | Verification | LOW | ✅ No changes |

---

## Application Order

1. **First**: Proposal 1 (Hyprland) - Foundational
2. **Second**: Proposal 2 (Rofi) - Visual consistency
3. **Third**: Proposal 3 (Kitty font) - User experience
4. **Fourth**: Proposal 5 (Starship) - Organization
5. **Verification**: Proposals 4 & 6 - Already correct

---

## Next Steps

Please review each proposal and provide:

1. **APPROVAL** - Apply the proposed diff
2. **MODIFICATION** - What should change
3. **SKIP** - Don't apply this change

Once you provide feedback, I will:
- Apply approved changes
- Create new diffs for modifications
- Generate final configuration
- Create installation/setup guide

