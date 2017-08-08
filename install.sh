#!/bin/bash

command_exists() {
	command -v $1 > /dev/null 2>&1
}

cd $(dirname $0)

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

if command_exists tmux; then
	if test -f $HOME/.tmux.conf; then
		echo "Copying $HOME/.tmux.conf to $HOME/.tmux.conf.old"
		mv $HOME/.tmux.conf $HOME/.tmux.conf.old
	fi

	echo "Installing .tmux.conf"
	$CP_CMD tmux.conf $HOME/.tmux.conf
	$CP_CMD -r config/tmux $HOME/.config/tmux
fi

if command_exists zsh; then
	if test -f $HOME/.zshrc ; then
		echo "Copying $HOME/.zshrc to $HOME/.zshrc.old"
		mv $HOME/.zshrc $HOME/.zshrc.old
	fi

	if test -d $HOME/.oh-my-zsh; then
		echo "Installing $HOME/.zshrc"
		$CP_CMD zshrc $HOME/.zshrc
		echo "Installing custom Oh-my-zsh plugins and themes to $HOME/.oh-my-zsh/custom"
		$CP_CMD -r oh-my-zsh-custom/* $HOME/.oh-my-zsh/custom/
	fi
fi

if command_exists bash; then
	if test -f $HOME/.bashrc; then
		echo "Copying $HOME/.bashrc to $HOME/.bashrc.old"
		mv $HOME/.bashrc $HOME/.bashrc.old
	fi

	echo "Installing $HOME/.bashrc"
	$CP_CMD bashrc $HOME/.bashrc
fi

if command_exists nvim; then
	if test -d $HOME/.config/nvim; then
		echo "Copying $HOME/.config/nvim to $HOME/.config/nvim.old"
		rm -rf $HOME/.config/nvim.old
		mv $HOME/.config/nvim $HOME/.config/nvim.old
	fi

	echo "Installing $HOME/.config/nvim"
	mkdir -p $HOME/.config # Just in case
	$CP_CMD -r config/nvim $HOME/.config/nvim

	if test -f $HOME/.nvimrc; then
		echo "Copying $HOME/.nvimrc to $HOME/.nvimrc.old"
		mv $HOME/.nvimrc $HOME/.nvimrc.old
	fi

	echo "Linking $HOME/.nvimrc to $HOME/.config/nvim/init.vim"
	ln -sf $HOME/.config/nvim/init.vim $HOME/.nvimrc

	nvim -c ':PlugInstall' -c ':quit'
fi

if test -f $HOME/.Xdefault; then
	echo "Copying $HOME/.Xdefaults to $HOME/.Xdefaults.old"
	mv $HOME/.Xdefaults $HOME/.Xdefaults.old
fi

echo "Installing $HOME/.Xdefaults"
$CP_CMD Xdefaults $HOME/.Xdefaults

