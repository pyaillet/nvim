#!/usr/bin/env bash

NVIM_TAG="${1:-stable}"

BUILD_DIR=$(mktemp -d)
TARGET_DIR="${TARGET_DIR:-"${BUILD_DIR}/dest/"}"

ubuntu_install_dep () {
  apt-get update
  apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
}

ubuntu_build_deb() {
  cd "${BUILD_DIR}"
  git clone -b "${NVIM_TAG}" --single-branch --depth 1 https://github.com/neovim/neovim.git

  cd neovim && make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="${TARGET_DIR}"
  make install
}

ubuntu_install_dep
ubuntu_build_deb "${NVIM_TAG}"

