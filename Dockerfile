FROM alpine:3.7 as fzy_builder

RUN apk update && \
	apk add git gcc make libc-dev

RUN git clone https://github.com/jhawthorn/fzy.git && \
	cd fzy && \
	make

FROM alpine:3.7

RUN apk update && \
	apk add curl gcc git libc-dev neovim the_silver_searcher python3 python3-dev && \
	pip3 install neovim && \
	apk del gcc libc-dev python3-dev && \
	rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/bin/ /usr/local/share/man/man1/

COPY --from=fzy_builder /fzy/fzy /usr/local/bin/
COPY --from=fzy_builder /fzy/fzy.1 /usr/local/share/man/man1/

ADD data /root

WORKDIR /root

RUN /root/install.sh && \
	rm /root/install.sh

WORKDIR /usr/src/app

VOLUME /usr/src/app
