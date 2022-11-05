#!/usr/bin/env bash

echo "🚀 Bootstrapping neovim"

nvim --headless -es -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -es -c 'autocmd User PackerComplete quitall' -c 'PackerSync'