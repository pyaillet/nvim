FROM ubuntu:jammy as neovim_build

RUN apt-get update -y && apt-get install -y build-essential git
ENV NVIM_TAG=stable
ENV TARGET_DIR=/work/dest

WORKDIR /work

COPY build-neovim.sh .

RUN ./build-neovim.sh

FROM ubuntu:jammy as neovim

ENV KEYRING=/usr/share/keyrings/nodesource.gpg
ENV NODE_VERSION=node_16.x
ENV GO_VERSION=1.19.2
ENV DISTRO=jammy

COPY --from=neovim_build /work/dest /usr/local
COPY install-go.sh install-rust.sh install-node.sh /tmp
COPY init.lua /tmp/init.lua
COPY global.vim /tmp/sysinit.vim

RUN apt-get update \
  && apt-get install -y --no-install-recommends ripgrep fzf git wget curl gnupg ca-certificates zsh \
  && /tmp/install-go.sh \
  && /tmp/install-rust.sh \
  && /tmp/install-node.sh \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /etc/xdg/nvim \
  && mv /tmp/init.lua /tmp/sysinit.vim /etc/xdg/nvim \
  && sed '/^-- End packer setup$/q' /etc/xdg/nvim/init.lua > /etc/xdg/nvim/first.lua \
  && nvim --headless -u /etc/xdg/nvim/first.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' \
  && nvim --headless -u /etc/xdg/nvim/first.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync'


