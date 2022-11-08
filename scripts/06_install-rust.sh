#!/usr/bin/env sh

RUSTUP_CHECKSUM="5cc9ffd1026e82e7fb2eec2121ad71f4b0f044e88bca39207b3f6b769aaa799c"

if which rustc; then
  echo "✅ Rust already installed"
else
  echo "📦 Installing rust"
  curl -L https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o /tmp/rustup-init
  
  echo "🔏 Checking rustup checksum..."
  echo "${RUSTUP_CHECKSUM} rustup-init" >> /tmp/rustup-init.sha256
  cd /tmp
  sha256sum -c /tmp/rustup-init.sha256 
  cd -

  chmod +x /tmp/rustup-init
  /tmp/rustup-init -y -q
  rm /tmp/rustup-init*
fi

