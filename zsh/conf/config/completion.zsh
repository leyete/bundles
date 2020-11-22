# completion.zsh - ZSH completion configuration.

unsetopt menu_complete  # don't set the first completion entry
unsetopt flowcontrol
setopt auto_menu        # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*:*:*:*:*' menu select

# Case-sensitive completion style.
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories.
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Use caching.
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# vim: ft=zsh ts=2 sts=2 sw=2 foldenable fdm=marker et fenc=utf-8
