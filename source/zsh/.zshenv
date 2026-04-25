#!/usr/bin/env zsh

ZSH_CACHE_DIR="$HOME/.cache/zsh"
ZDOTDIR="$HOME/.config/zsh"
ZSH_SOURCE_DIR="$HOME/.dots/source/zsh"
PATH="$HOME/.local/bin:$HOME/.dots/bin:$PATH"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export PATH ZSH_SOURCE_DIR \
  XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME
