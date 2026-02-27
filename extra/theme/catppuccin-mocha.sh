#!/bin/bash
# Catppuccin Mocha Color Palette
# Single source of truth for all application colors
# 
# Usage: source this file in scripts to access color variables
# Example: source ~/.dots/extra/theme/catppuccin-mocha.sh

# ============================================================
# Basic Colors
# ============================================================

export THEME_NAME="Catppuccin Mocha"

# Primary palette
export THEME_BG="#1e1e2e"           # Background - dark blue-gray
export THEME_FG="#cdd6f4"           # Foreground - light blue-gray
export THEME_PRIMARY="#89b4fa"      # Primary accent - blue
export THEME_SECONDARY="#f5c2e7"    # Secondary - pink
export THEME_ACCENT="#cba6f7"       # Accent - purple

# Background variants
export THEME_BG_DARK="#11111b"      # Darker background
export THEME_BG_LIGHT="#45475a"     # Lighter background
export THEME_BG_MEDIUM="#313244"    # Medium background

# Text variants
export THEME_FG_LIGHT="#bac2de"     # Light text
export THEME_FG_MUTED="#a6adc8"     # Muted text

# Selection colors
export THEME_SELECT_BG="#f5e0dc"
export THEME_SELECT_FG="#1e1e2e"

# ============================================================
# UI Colors
# ============================================================

export THEME_BORDER="#89b4fa"       # Border color (primary)
export THEME_ERROR="#f38ba8"        # Error - red
export THEME_SUCCESS="#a6e3a1"      # Success - green
export THEME_WARNING="#f9e2af"      # Warning - yellow
export THEME_INFO="#89b4fa"         # Info - blue

# Additional UI colors
export THEME_OVERLAY="#1e1e2e"      # Overlay
export THEME_SURFACE="#313244"      # Surface

# ============================================================
# ANSI Colors (0-15 for terminal emulators)
# ============================================================

# Dark colors (0-7)
export THEME_COLOR0="#45475a"       # Black
export THEME_COLOR1="#f38ba8"       # Red
export THEME_COLOR2="#a6e3a1"       # Green
export THEME_COLOR3="#f9e2af"       # Yellow
export THEME_COLOR4="#89b4fa"       # Blue
export THEME_COLOR5="#f5c2e7"       # Magenta
export THEME_COLOR6="#94e2d5"       # Cyan
export THEME_COLOR7="#bac2de"       # White

# Bright colors (8-15)
export THEME_COLOR8="#585b70"       # Bright Black
export THEME_COLOR9="#f38ba8"       # Bright Red
export THEME_COLOR10="#a6e3a1"      # Bright Green
export THEME_COLOR11="#f9e2af"      # Bright Yellow
export THEME_COLOR12="#89b4fa"      # Bright Blue
export THEME_COLOR13="#f5c2e7"      # Bright Magenta
export THEME_COLOR14="#94e2d5"      # Bright Cyan
export THEME_COLOR15="#a6adc8"      # Bright White

# ============================================================
# Extended Colors
# ============================================================

# Additional shades and colors
export THEME_FLAMINGO="#f2cdcd"
export THEME_MAUVE="#cba6f7"
export THEME_LAVENDER="#b4befe"
export THEME_TEAL="#94e2d5"
export THEME_PEACH="#fab387"
export THEME_MAROON="#eba0ac"
export THEME_SAPPHIRE="#74c7ec"
export THEME_SKY="#89dceb"

# ============================================================
# Catppuccin Mocha Color Reference
# ============================================================
# Background: #1e1e2e
# Foreground: #cdd6f4
# 
# Palette (High saturation):
#   Red:     #f38ba8  | Maroon:   #eba0ac
#   Green:   #a6e3a1  | Peach:    #fab387
#   Yellow:  #f9e2af  | Yellow:   #f9e2af
#   Blue:    #89b4fa  | Sapphire: #74c7ec
#   Magenta: #f5c2e7  | Flamingo: #f2cdcd
#   Cyan:    #94e2d5  | Sky:      #89dceb
#
# Grays:
#   #11111b (darkest)
#   #1e1e2e (dark)
#   #313244 (medium)
#   #45475a (light)
#   #585b70 (lighter)
#   #6c7086 (lightest gray)
#   #7f849c
#   #9399b2
#   #bac2de (subtle)
#   #cdd6f4 (foreground)
# ============================================================
