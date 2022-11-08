#!/usr/bin/env bash

NVIM_PLATFORM="${NVIM_PLATFORM:-linux64}"
NVIM_VERSION="${NVIM_VERSION:-v0.8.0}"
NVIM_CHECKSUM="1af27471f76f1b4f7ad6563c863a4a78117f0515e3390ee4d911132970517fa7"

if which nvim; then
  echo "✅ neovim already installed"
else
  echo "📦 Installing neovim ${NVIM_VERSION}-${NVIM_PLATFORM}"
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-${NVIM_PLATFORM}.tar.gz -o /tmp/nvim.tar.gz

  echo "🔏 Checking neovim checksum..."
  echo "${NVIM_CHECKSUM} nvim.tar.gz" >> /tmp/nvim.tar.gz.sha256
  cd /tmp
  sha256sum -c /tmp/nvim.tar.gz.sha256 
  cd -

  mkdir -p ${HOME}/.local

  tar --strip-components=1 --directory ${HOME}/.local -xzf /tmp/nvim.tar.gz
  rm -Rf /tmp/nvim.tar.gz*
fi