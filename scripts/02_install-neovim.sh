#!/usr/bin/env bash

NVIM_PLATFORM="${NVIM_PLATFORM:-linux64}"
NVIM_VERSION="${NVIM_VERSION:-v0.8.0}"

if which nvim; then
  echo "✅ neovim already installed"
else
  echo "📦 Installing neovim ${NVIM_VERSION}-${NVIM_PLATFORM}"
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-${NVIM_PLATFORM}.tar.gz -o /tmp/nvim.tar.gz

  mkdir -p ${HOME}/.local

  tar --strip-components=1 --directory ${HOME}/.local -xzf /tmp/nvim.tar.gz
  rm -Rf /tmp/nvim.tar.gz
fi