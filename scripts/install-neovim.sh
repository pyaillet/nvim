#!/usr/bin/env bash

NVIM_PLATFORM="${NEOVIM_PLATFORM:-linux64}"
NVIM_VERSION="${NEOVIM_VERSION:-v0.8.0}"

echo "📦 Installing neovim ${NVIM_VERSION}-${NVIM_PLATFORM}"
curl -L https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-${NEOVIM_PLATFORM}.tar.gz -o /tmp/nvim.tar.gz

mkdir -p ${HOME}/.local

tar --strip-components=1 --directory ${HOME}/.local -xzf /tmp/nvim.tar.gz
rm -Rf /tmp/nvim.tar.gz