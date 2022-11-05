#!/usr/bin/env bash

NODE_VERSION="${1}"
NODE_VERSION="${NODE_VERSION:-v18.12.1}"
NODE_PLATFORM="${2}"
NODE_PLATFORM="${NODE_PLATFORM:-linux-x64}"

if which node; then
  echo "✅ node already installed"
else
  echo "📦 Installing node ${NODE_VERSION}-${NODE_PLATFORM}"
  curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_PLATFORM}.tar.xz -o /tmp/node.tar.xz

  tar --strip-components=1 --directory ${HOME}/.local -xJf /tmp/node.tar.xz
  rm -Rf /tmp/node.tar.xz
fi