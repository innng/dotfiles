#!/usr/bin/env zsh

# Sources vital global environment variables and configurations
# shellcheck disable=SC1091
if ! . "$ZDOTDIR/conf.d/hyde/env.zsh"; then
    echo "Error: Could not source $ZDOTDIR/conf.d/hyde/env.zsh"
    return 1
fi

if [[ $- == *i* ]] && [ -f "$ZDOTDIR/conf.d/hyde/terminal.zsh" ]; then
    . "$ZDOTDIR/conf.d/hyde/terminal.zsh" || echo "Error: Could not source $ZDOTDIR/conf.d/hyde/terminal.zsh"
fi
