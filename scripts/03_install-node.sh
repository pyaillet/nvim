#!/usr/bin/env bash

NODE_VERSION="${1}"
NODE_VERSION="${NODE_VERSION:-v18.12.1}"
NODE_PLATFORM="${2}"
NODE_PLATFORM="${NODE_PLATFORM:-linux-x64}"
NODE_CHECKSUM="${3}"
NODE_CHECKSUM="${NODE_CHECKSUM:-4481a34bf32ddb9a9ff9540338539401320e8c3628af39929b4211ea3552a19e}"

if which node; then
  echo "✅ node already installed"
else
  echo "📦 Installing node ${NODE_VERSION}-${NODE_PLATFORM}"
  curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_PLATFORM}.tar.xz -o /tmp/node.tar.xz

  echo "🔏 Checking node checksum..."
  echo "${NODE_CHECKSUM} node.tar.xz" >> /tmp/node.tar.xz.sha256
  cd /tmp
  sha256sum -c /tmp/node.tar.xz.sha256 
  cd -

  tar --strip-components=1 --directory ${HOME}/.local -xJf /tmp/node.tar.xz
  rm -Rf /tmp/node.tar.xz*
fi