#!/bin/bash

function add_home_symlink()
{
	local __file=$1
	echo "Linking ${__file}"
	rm -rf ~/${__file}
	ln -s ${HOME}/terminal-config/${__file} ${HOME}/${__file}
}

add_home_symlink .vimrc
add_home_symlink .vim
add_home_symlink .bashrc
add_home_symlink .tmux.conf
add_home_symlink .gitignore_global

