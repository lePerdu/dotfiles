#!/bin/bash

cd $(dirname $0)

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

cp_cmd="ln -sf"

all_configs="bash editorconfig fish git kak termite tilix"

command_exists() {
    command -v $1 > /dev/null 2>&1
}

backup_files() {
    return
    if test -f "$1"; then
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
    configs="$all_configs"
fi

for config in $configs; do
    case $config in
        bash)
            install_files bashrc $HOME/.bashrc
            ;;

        editorconfig)
            install_files editorconfig $HOME/.editorconfig

        fish)
            install_files config/fish $XDG_CONFIG_HOME/fish
            install_files config/omf $XDG_CONFIG_HOME/omf
            ;;

        git)
            install_files gitconfig $HOME/.gitconfig

        kak)
            install_files config/kak $XDG_CONFIG_HOME/kak
            # Link system autoload files
            ln -sf $(dirname $(which kak))/../share/kak/autoload \
                $XDG_CONFIG_HOME/kak/autoload/system
            ;;

        termite)
            install_files config/termite $XDG_CONFIG_HOME/termite
            ;;

        tilix)
            install_files config/tilix $XDG_CONFIG_HOME/tilix
            ;;

        *)
            echo "Unknown config: $config"
            ;;
    esac
done

