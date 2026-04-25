#!/usr/bin/env zsh

ZSH_SOURCE_DIR="$HOME/.dots/source/zsh"
PATH="$HOME/.local/bin:$HOME/.dots/bin:$PATH"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

LESSHISTFILE="${LESSHISTFILE:-/tmp/less-hist}"
HISTFILE="${HISTFILE:-$HOME/.config/zsh/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# TODO: update this to ~/.dots/source/starship and create template file from it
STARSHIP_CONFIG="$XDG_CONFIG_HOME/theme/starship.toml"

export PATH ZSH_SOURCE_DIR \
    XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME \
    LESSHISTFILE HISTFILE HISTSIZE SAVEHIST ZSH_AUTOSUGGEST_STRATEGY \
    STARSHIP_CONFIG
