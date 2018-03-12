#!/bin/sh

docker container run -it -v $HOME/.gitconfig:/root/.gitconfig -v $PWD:/usr/src/app pyaillet/nvim $@
