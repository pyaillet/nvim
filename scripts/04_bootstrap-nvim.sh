#!/usr/bin/env bash

echo "🚀 Bootstrapping neovim"

echo "\n\n" | nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'