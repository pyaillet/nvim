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

cd ~/.vim/plugged
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/cloudhead/neovim-fuzzy.git
git clone https://github.com/Shougo/deoplete.nvim.git
git clone https://github.com/roxma/nvim-yarp.git
git clone https://github.com/roxma/vim-hug-neovim-rpc.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/airblade/vim-gitgutter.git
