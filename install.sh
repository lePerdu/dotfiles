#!/bin/bash

cd $(dirname $0)

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

cp_cmd="ln -sf"

all_configs="editorconfig emacs fish git"
default_configs="$all_configs"

command_exists() {
    command -v $1 > /dev/null 2>&1
}

backup_files() {
    if test -e "$1"; then
        echo "Copying $1 to $1~"
        mv "$1" "$1~"
    fi
}

install_files() {
    backup_files $2

    echo "Installing $PWD/$1 to $2"
    mkdir -p $(dirname $2)
    $cp_cmd "$PWD/$1" "$2"
}

while getopts lc opt; do
    case $opt in
        l) cp_cmd="ln -sf" ;;
        c) cp_cmd="cp -r" ;;
        ?) echo "usage: $0 [-lc] <configs...>"
           echo "  available configs:" $all_configs
           exit 2
           ;;
    esac
done

shift $(( $OPTIND - 1 ))

configs="$*"
if test -z "$configs"; then
    configs="$default_configs"
fi

for config in $configs; do
    case $config in
        editorconfig)
            install_files editorconfig $HOME/.editorconfig
            ;;

        emacs)
            install_files config/emacs $XDG_CONFIG_HOME/emacs
            ;;

        fish)
            install_files config/fish $XDG_CONFIG_HOME/fish
            ;;

        git)
            install_files gitconfig $HOME/.gitconfig
            ;;

        *)
            echo "Unknown config: $config"
            ;;
    esac
done

