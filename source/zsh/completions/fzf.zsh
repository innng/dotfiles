    # Ctrl-R fzf completion
    if command -v fzf &>/dev/null; then
        eval "$(fzf --zsh)"
    fi
