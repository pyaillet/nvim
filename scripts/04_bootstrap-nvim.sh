#!/usr/bin/env bash

echo "🚀 Bootstrapping neovim"

echo "\n\n" | nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 >/dev/null
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 >/dev/null