#!/bin/sh

mkdir -p ~/.config/nvim/colors ~/.vim/plugged ~/.config/nvim/autoload
mv init.vim ~/.config/nvim/

mv autoload/* ~/.config/nvim/autoload/
mv theme/* ~/.config/nvim/colors/

rmdir autoload
rmdir theme

cd ~/.vim/plugged
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/cloudhead/neovim-fuzzy.git
git clone https://github.com/roxma/nvim-completion-manager.git
git clone https://github.com/roxma/ncm-flow.git
git clone https://github.com/vim-airline/vim-airline.git
