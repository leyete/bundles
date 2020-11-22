# directories.zsh - Directory manipulation.

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'
alias rd='rmdir'

function d() {
  if [[ -n "$1" ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}

compdef _dirs d

alias l='LC_ALL=C ls -lAh --group-directories-first --color=auto'
alias ls='LC_ALL=C ls --group-directories-first --color=auto'
alias la='LC_ALL=C ls -lah --group-directories-first --color=auto'

eval "$(dircolors $XDG_DATA_HOME/zsh/dircolors256)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# vim: ft=zsh ts=2 sw=2 sts=2 foldenable fdm=marker et fenc=utf-8
