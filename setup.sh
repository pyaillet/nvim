#!/bin/sh

alias nv='docker container run -it -v "$(pwd)":/usr/src/app pyaillet/nvim nvim $@'

