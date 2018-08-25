#!/bin/bash

cd $(dirname $0)

local XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

local CP_CMD=

case $1 in
	link|ln|)
		$CP_CMD=ln
		;;

	copy|cp)
		$CP_CMD="cp -r"
		;;

	*)
		echo "usage: ./install.sh [copy|cp|link|ln]"
		exit 1
		;;
esac

command_exists() {
	command -v $1 > /dev/null 2>&1
}

backup_files() {
    if test -f "$1"; then
        echo "Copying $1 to $1.old"
        mv "$1" "$1.old"
    fi
}

install_files() {
    backup_files $2

    echo "Installing $1 to $2"
    mkdir -p $(dirname $2)
    $CP_CMD "$1" "$2"
}

if command_exists tmux; then
    install_files tmux.conf $HOME/.tmux.conf
    install_files config/tmux $XDG_CONFIG_HOME/tmux
fi

if command_exists zsh; then
    install_files zshrc $HOME/.zshrc
    install_files oh-my-zsh-custom/\* $HOME/.oh-my-zsh/custom
fi

if command_exists bash; then
    install_files bashrc $HOME/.bashrc
fi

if command_exists fish; then
    install_files config/fish $XDG_CONFIG_HOME/fish
    install_files config/omf $XDG_CONFIG_HOME/omf
fi

if command_exists nvim; then
    install_files config/nvim $XDG_CONFIG_HOME/nvim

    backup_files $HOME/.nvimrc
    echo "Linking $HOME/.nvimrc to $XDG_CONFIG_HOME/nvim/init.vim"
    ln -sf $XDG_CONFIG_HOME/nvim/init.vim $HOME/.nvimrc

    # Install dein plugins
    nvim -c ':call dein#update()' -c ':quit'
fi

if test -f $HOME/.Xdefaults; then
    install_files Xdefaults $HOME/.Xdefaults
fi

