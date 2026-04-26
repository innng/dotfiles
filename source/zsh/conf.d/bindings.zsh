# Use emacs key bindings
bindkey -e

bindkey "^[[1;5C" forward-word  # ctrl + right
bindkey "^[[1;5D" backward-word # ctrl + left
bindkey "^A" beginning-of-line  # ctrl + a
bindkey "^E" end-of-line        # ctrl + e

# Arrow keys: history search matching current input
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[C" forward-char
bindkey "^[[D" backward-char

if (( ${+functions[_history-substring-search-begin]} )); then
  bindkey "^[[A" history-substring-search-up    # up
  bindkey "^[[B" history-substring-search-down  # down
fi

# Double tab to accept suggestions
bindkey '^I^I' autosuggest-accept

# Restore del key functions
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word
