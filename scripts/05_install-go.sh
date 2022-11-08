#!/usr/bin/env sh

GO_VERSION="${1}"
GO_VERSION="${GO_VERSION:-1.19.2}"
GO_PLATFORM="${2}"
GO_PLATFORM="${GO_PLATFORM:-linux-amd64}"
GO_CHECKSUM="${3}"
GO_CHECKSUM="${GO_CHECKSUM:-5e8c5a74fe6470dd7e055a461acda8bb4050ead8c2df70f227e3ff7d8eb7eeb6}"

if which go; then
  echo "✅ Go already installed"
else
  echo "📦 Installing Go ${GO_VERSION}-${GO_PLATFORM}"
  curl -L "https://go.dev/dl/go${GO_VERSION}.${GO_PLATFORM}.tar.gz" -o /tmp/go.tar.gz

  echo "🔏 Checking go checksum..."
  echo "${GO_CHECKSUM} go.tar.gz" >> /tmp/go.tar.gz.sha256
  cd /tmp
  sha256sum -c /tmp/go.tar.gz.sha256 
  cd -

  tar --directory ${HOME}/.local --strip-components=1 -xzf /tmp/go.tar.gz
  rm -rf /tmp/go*.tar.gz
fi