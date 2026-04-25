LESSHISTFILE="${LESSHISTFILE:-/tmp/less-hist}"
HISTFILE="${HISTFILE:-$HOME/.config/zsh/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# TODO: update this to ~/.dots/source/starship and create template file from it
STARSHIP_CONFIG="$XDG_CONFIG_HOME/theme/starship.toml"

export LESSHISTFILE HISTFILE HISTSIZE SAVEHIST ZSH_AUTOSUGGEST_STRATEGY \
  STARSHIP_CONFIG

