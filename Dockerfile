FROM alpine:3.7 as fzy_builder

RUN apk update && \
	apk add git gcc make libc-dev

RUN git clone https://github.com/jhawthorn/fzy.git && \
	cd fzy && \
	make

FROM alpine:3.7

RUN apk update && \
	apk add git neovim the_silver_searcher && \
	rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/bin/ /usr/local/share/man/man1/

COPY --from=fzy_builder /fzy/fzy /usr/local/bin/
COPY --from=fzy_builder /fzy/fzy.1 /usr/local/share/man/man1/

ADD data /root

WORKDIR /root

RUN /root/install.sh

VOLUME /usr/src/app
