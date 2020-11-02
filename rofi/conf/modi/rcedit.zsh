#!/usr/bin/env zsh
# Custom rofi modi script to edit the most common configuration files.

# NOTE: EDIT THE FILE LOCATIONS HERE -> <key>: file name, <value>: file location
declare -A configs; configs=(
    zshenv "$HOME/.zshenv"
    zprofile "$XDG_CONFIG_HOME/zsh/.zprofile"
    zshrc "$XDG_CONFIG_HOME/zsh/.zshrc"
    alacritty.yml "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
    bspwmrc "$XDG_CONFIG_HOME/bspwm/bspwmrc"
    init.vim "$XDG_CONFIG_HOME/nvim/init.vim"
    config.rasi "$XDG_CONFIG_HOME/rofi/config.rasi"
    sxhkdrc "$XDG_CONFIG_HOME/sxhkd/sxhkdrc"
    Xresources "$XDG_CONFIG_HOME/xorg/Xresources"
    xinitrc "$XDG_CONFIG_HOME/xorg/xinitrc"
    xprofile "$XDG_CONFIG_HOME/xorg/xprofile"
    polybar "$XDG_CONFIG_HOME/polybar/config"
)

# Show available configuration files.
function show-files() {
    printf "\x00prompt\x1frcedit\n"
    for f ( ${(k)configs} ); do [[ -f "${configs[$f]}" ]] && printf "$f\n"; done
}

# Edit the supplied file.
function edit-file() {
    local selection="${${${(M)ROFI_RETV:#1}:+${configs[$1]}}:-$1}"

    if [[ -z "$TERMINAL" || -z "$EDITOR" ]]; then
        coproc (rofi -e "You must set the TERMINAL and EDITOR variables." >/dev/null 2>&1)
        exit 0
    fi

    coproc ($TERMINAL -e $EDITOR "$selection" & >/dev/null 2>&1)
}

if [[ ${ROFI_RETV} -eq 0 ]] { show-files } else { edit-file "$1" }
