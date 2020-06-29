#!/bin/bash

cd $(dirname $0)

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

cp_cmd="ln -sf"

all_configs="zsh fish bash nvim kak kak-lsp vis tmux Xdefaults tilix termite"

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
        tmux)
            install_files tmux.conf $HOME/.tmux.conf
            install_files config/tmux $XDG_CONFIG_HOME/tmux
            ;;

        zsh)
            install_files zshrc $HOME/.zshrc
            install_files oh-my-zsh-custom/\* $HOME/.oh-my-zsh/custom
            ;;

        bash)
            install_files bashrc $HOME/.bashrc
            ;;

        fish)
            install_files config/fish $XDG_CONFIG_HOME/fish
            install_files config/omf $XDG_CONFIG_HOME/omf
            ;;

        nvim)
            install_files config/nvim $XDG_CONFIG_HOME/nvim

            backup_files $HOME/.nvimrc
            echo "Linking $HOME/.nvimrc to $XDG_CONFIG_HOME/nvim/init.vim"
            ln -sf $XDG_CONFIG_HOME/nvim/init.vim $HOME/.nvimrc

            # Install dein plugins
            nvim -c ':call dein#update()' -c ':quit'
            ;;

        kak)
            install_files config/kak $XDG_CONFIG_HOME/kak
            # Link system autoload files
            ln -sf $(dirname $(which kak))/../share/kak/autoload \
                $XDG_CONFIG_HOME/kak/autoload/system
            ;;

        kak-lsp)
            install_files config/kak-lsp $XDG_CONFIG_HOME/kak-lsp
            ;;

        vis)
            install_files config/vis $XDG_CONFIG_HOME/vis
            ;;

        tilix)
            install_files config/tilix $XDG_CONFIG_HOME/tilix
            ;;

        termite)
            install_files config/termite $XDG_CONFIG_HOME/termite
            ;;

        Xdefaults)
            install_files Xdefaults $HOME/.Xdefaults
            ;;

        *)
            echo "Unknown config: $config"
            ;;
    esac
done

