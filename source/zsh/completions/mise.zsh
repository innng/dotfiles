export PATH='/home/ing/.local/bin:/home/ing/.dots/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/ing/.spicetify'
autoload -Uz add-zsh-hook
add-zsh-hook -d precmd _mise_hook_precmd 2>/dev/null
add-zsh-hook -d chpwd _mise_hook_chpwd 2>/dev/null
(( $+functions[_mise_hook_precmd] )) && unset -f _mise_hook_precmd
(( $+functions[_mise_hook_chpwd] )) && unset -f _mise_hook_chpwd
(( $+functions[_mise_hook] )) && unset -f _mise_hook
(( $+functions[mise] )) && unset -f mise
unset MISE_SHELL
unset __MISE_DIFF
unset __MISE_SESSION
unset __MISE_ZSH_PRECMD_RUN
unset __MISE_ZSH_CHPWD_RAN
export MISE_SHELL=zsh
if [ -z "${__MISE_ORIG_PATH:-}" ]; then
  export __MISE_ORIG_PATH="$PATH"
fi
export __MISE_ZSH_PRECMD_RUN=0
export __MISE_ZSH_CHPWD_RAN=0

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /home/ing/.local/bin/mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command /home/ing/.local/bin/mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command /home/ing/.local/bin/mise "$command" "$@"
}

autoload -Uz add-zsh-hook
_mise_hook() {
  eval "$(/home/ing/.local/bin/mise hook-env -s zsh)";
}
_mise_hook_precmd() {
  if [[ "${__MISE_ZSH_CHPWD_RAN:-0}" == "1" ]]; then
    export __MISE_ZSH_CHPWD_RAN=0
    return
  fi
  eval "$(/home/ing/.local/bin/mise hook-env -s zsh --reason precmd)";
}
_mise_hook_chpwd() {
  export __MISE_ZSH_CHPWD_RAN=1
  eval "$(/home/ing/.local/bin/mise hook-env -s zsh --reason chpwd)";
}
add-zsh-hook precmd _mise_hook_precmd
add-zsh-hook chpwd _mise_hook_chpwd

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if [[ "$1" != "mise" && "$1" != "mise-"* ]] && /home/ing/.local/bin/mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi
