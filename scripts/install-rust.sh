#!/usr/bin/env sh

if which rustc; then
  echo "✅ Rust already installed"
else
  echo "📦 Installing rust"
  curl -L https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o /tmp/rustup-init
  chmod +x /tmp/rustup-init
  /tmp/rustup-init -y -q
  rm /tmp/rustup-init
fi

