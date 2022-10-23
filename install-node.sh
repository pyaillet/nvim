#!/usr/bin/env bash

curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/nodesource.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/nodesource.gpg] https://deb.nodesource.com/$NODE_VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src [signed-by=/etc/apt/trusted.gpg.d/nodesource.gpg] https://deb.nodesource.com/$NODE_VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list
apt-get update
apt-get install -y nodejs
npm install --global yarn

