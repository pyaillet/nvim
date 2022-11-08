#!/usr/bin/env sh

mkdir -p "${HOME}"/.config

cp -R config/* "${HOME}/.config/"

echo "alias vi=nvim\nalias vim=nvim\n" >> ~/.zshrc
