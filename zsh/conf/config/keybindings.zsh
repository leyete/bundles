# keybindings.zsh - ZSH keybindings configuration.

bindkey -v

# {{{ COMPLETION KEYBINDINGS

[[ -n "${terminfo[kcbt]}" ]] && \
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through completion menu backwards

# }}}

# {{{ HISTORY KEYBINDINGS

bindkey -s '\el' 'ls\n'                           # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward  # bash-like ctrl-r to search the history backwards

# [PageUp] - Up a line of history / [PageDown] - Down a line of history
[[ -n "${terminfo[kpp]}" ]] && bindkey "${terminfo[kpp]}" up-line-or-history
[[ -n "${terminfo[knp]}" ]] && bindkey "${terminfo[knp]}" down-line-or-history

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

bindkey ' ' magic-space  # do history expansion

# }}}

# {{{ LINE MANIPULATION

bindkey '^[[1;5C' forward-word                        # [Ctrl+RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl+LeftArrow] - move backward one word

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# }}}

# vim: ft=zsh ts=2 sts=2 sw=2 foldenable fdm=marker et fenc=utf-8 :
