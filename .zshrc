# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi

# Set custom options
setopt INTERACTIVE_COMMENTS

# Enable autocompletion
autoload -Uz compinit
compinit

# Load antidote
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

# Load custom aliases
source ~/.aliases

# Custom keybindings configuration for Zsh
bindkey '^I^I' autosuggest-accept
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Show random Pokemon
pokeget random --hide-name
