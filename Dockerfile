FROM ubuntu:rolling as neovim_build

RUN apt-get update -y && apt-get install -y build-essential git
ENV NVIM_TAG=stable
ENV TARGET_DIR=/work/dest

WORKDIR /work

COPY build-neovim.sh .

RUN ./build-neovim.sh

FROM ubuntu:rolling as neovim

COPY --from=neovim_build /work/dest /usr/local
