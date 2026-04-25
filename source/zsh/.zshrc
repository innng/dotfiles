#!/usr/bin/env zsh

_antidote_init() {
  source "/usr/share/zsh-antidote/antidote.zsh"
  zstyle ':antidote:bundle' file "$ZSH_SOURCE_DIR/plugins.txt"
  zstyle ':antidote:static' file "$ZDOTDIR/plugins.zsh"
  antidote load "$ZSH_SOURCE_DIR/plugins.txt"
}

_load_functions() {
  for file in "$ZSH_SOURCE_DIR/functions/"*.zsh; do
    [ -r "$file" ] && source "$file"
  done
}

_load_completions() {
  for file in "$ZSH_SOURCE_DIR/completions/"*.zsh; do
    [ -r "$file" ] && source "$file"
  done
}

_load_compinit() {
  autoload -Uz compinit
  setopt EXTENDED_GLOB

  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi

  _comp_options+=(globdots)
}

fpath=("$ZSH_SOURCE_DIR/completions" "${fpath[@]}")

_load_compinit
_antidote_init
_load_functions
_load_completions

typeset -U path

bindkey "^[[1;5C" forward-word  # ctrl + right
bindkey "^[[1;5D" backward-word # ctrl + left
bindkey "^A" beginning-of-line  # ctrl + a
bindkey "^E" end-of-line        # ctrl + e

if (( ${+functions[_history-substring-search-begin]} )); then
  bindkey "^[[A" history-substring-search-up    # up
  bindkey "^[[B" history-substring-search-down  # down
fi

if command -v starship &>/dev/null; then
  source "$ZSH_SOURCE_DIR/starship_init.zsh"
fi

if [[ $- == *i* ]]; then
  if command -v fastfetch >/dev/null; then
    fastfetch
  fi
fi

source "$ZSH_SOURCE_DIR/alias.zsh"
