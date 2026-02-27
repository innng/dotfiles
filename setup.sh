#!/bin/bash
# Setup script for Hyprland configuration
# Copies configs from ~/.dots/config/ to ~/.config/

set -e

DOTS_DIR="$HOME/.dots"
CONFIG_DIR="$DOTS_DIR/config"
TARGET_DIR="$HOME/.config"

echo "Setting up Hyprland configuration..."

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy all config directories
for dir in "$CONFIG_DIR"/*/; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        echo "Copying $dirname..."
        cp -r "$dir" "$TARGET_DIR/"
    fi
done

# Copy individual config files
for file in "$CONFIG_DIR"/*.*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "Copying $filename..."
        cp "$file" "$TARGET_DIR/"
    fi
done

# Make scripts executable
find "$TARGET_DIR/hypr" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "Setup complete!"
echo ""
echo "Start Hyprland with: exec Hyprland"
