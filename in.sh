#!/bin/sh

docker container run -it -v $PWD:/usr/src/app pyaillet/nvim nvim $@
