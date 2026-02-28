#!/usr/bin/env sh

# Wayland and Hyprland-specific environment variables
# These are sourced by UWSM when launching a Hyprland session

# Qt Variables - Essential for Qt applications on Wayland
# https://wiki.hyprland.org/Configuring/Environment-variables/#qt-variables
QT_QPA_PLATFORM="${QT_QPA_PLATFORM:-wayland;xcb}"
QT_AUTO_SCREEN_SCALE_FACTOR="${QT_AUTO_SCREEN_SCALE_FACTOR:-1}"
QT_WAYLAND_DISABLE_WINDOWDECORATION="${QT_WAYLAND_DISABLE_WINDOWDECORATION:-1}"
QT_QPA_PLATFORMTHEME="${QT_QPA_PLATFORMTHEME:-qt6ct}"

# Application Wayland Support
MOZ_ENABLE_WAYLAND="${MOZ_ENABLE_WAYLAND:-1}"
ELECTRON_OZONE_PLATFORM_HINT="${ELECTRON_OZONE_PLATFORM_HINT:-auto}"

# Hyprland Systemd Integration
# Prevents double-notification issues and conflicts with systemd/dbus environment management
HYPRLAND_NO_SD_NOTIFY=1
HYPRLAND_NO_SD_VARS=1

export QT_QPA_PLATFORM QT_AUTO_SCREEN_SCALE_FACTOR \
    QT_WAYLAND_DISABLE_WINDOWDECORATION QT_QPA_PLATFORMTHEME \
    MOZ_ENABLE_WAYLAND ELECTRON_OZONE_PLATFORM_HINT \
    HYPRLAND_NO_SD_NOTIFY HYPRLAND_NO_SD_VARS

# Optional: Set if some toolkits are not working properly
# Create ~/.config/uwsm/env-hyprland.d/toolkit.sh and add the following as needed:
# export GDK_BACKEND="${GDK_BACKEND:-wayland,x11,*}"
# export SDL_VIDEODRIVER="${SDL_VIDEODRIVER:-wayland}"
# export CLUTTER_BACKEND="${CLUTTER_BACKEND:-wayland}"
