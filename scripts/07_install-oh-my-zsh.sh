#!/usr/bin/env bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "exec zsh" >> ~/.bashrc

echo "alias vi=nvim" >> ~/.zshrc
echo "alias vim=nvim" >> ~/.zshrc
