#!/bin/sh

alias nv='docker container run -it -v "$HOME/.gitconfig:/root/.gitconfig" -v "$(pwd)":/usr/src/app pyaillet/nvim:0.2.2-charlyx $@'

