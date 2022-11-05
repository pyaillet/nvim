#!/usr/bin/env sh

GO_VERSION="${1}"
GO_VERSION="${GO_VERSION:-1.19.2}"
GO_PLATFORM="${2}"
GO_PLATFORM="${GO_PLATFORM:-linux-amd64}"

echo "📦 Installing Go ${GO_VERSION}-${GO_PLATFORM}"
curl -L "https://go.dev/dl/go${GO_VERSION}.${GO_PLATFORM}.tar.gz" -o /tmp/go.tar.gz
tar --directory ${HOME}/.local --strip-components=1 -xzf /tmp/go.tar.gz
rm -rf /tmp/go*.tar.gz
