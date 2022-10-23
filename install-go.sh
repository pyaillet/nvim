#!/usr/bin/env sh

curl -L https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz -o /tmp/go.linux-amd64.tar.gz
tar -C /usr/local -xzf /tmp/go.linux-amd64.tar.gz
rm -rf /tmp/go*.tar.gz

echo 'PATH="${PATH}:/usr/local/go/bin' >> /etc/profile.d/10-go-path
