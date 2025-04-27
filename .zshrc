# Set up ZSH
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt CDABLE_VARS
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt COMPLETE_ALIASES

unsetopt BEEP
unsetopt NO_MATCH

bindkey -e

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# The following lines were added by compinstall
zstyle :compinstall filename '/home/ing/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set up alias
source ~/.aliases

# Set up dotfiles config
cfg config --local status.showUntrackedFiles no

# Set up asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Set up starship prompt
eval "$(starship init zsh)"
starship preset pure-preset -o ~/.config/starship.toml

# Set up antidote
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

# Set up thefuck
eval $(thefuck --alias)

# Set bindkeys
bindkey "^I" autosuggest-accept
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
