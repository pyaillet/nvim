#!/bin/sh

mkdir -p \
	~/.config/nvim/colors \
	~/.vim/plugged \
	~/.config/nvim/autoload \
	~/.local/share/nvim

mv init.vim ~/.config/nvim/

mv autoload/* ~/.config/nvim/autoload/
mv theme/* ~/.config/nvim/colors/
mv plugins/* ~/.local/share/nvim/

rmdir autoload
rmdir theme

nvim +PlugInstall +qall +silent
