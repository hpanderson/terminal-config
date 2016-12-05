# Terminal Config

To use, create symlinks to `.bashrc`, `.tmux.conf`, `.vimrc`, `.vim` and `.gitignore_global` in your home directory. 

Add `.gitignore_global` to git using the command:

	git config --global core.excludesfile ~/.gitignore_global

## Clang Complete

This uses a hand made clang complete file. Another option would be to generate one with the included python script with cmake (assuming an out of source build, using g++):

	CXX='~/.vim/bin/cc_args.py g++' cmake ..
	make

Then copy the resulting `.clang_complete` file to the project root.

