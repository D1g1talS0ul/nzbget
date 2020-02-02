FROM alpine:latest
# change username 'me' to your username
COPY nzbget.conf /opt/nzbget/

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --upgrade --virtual=build-dependencies \
	gcc \
	libc-dev \
	libxml2-dev \
	libxslt-dev \
	make \
	py2-pip \
	py3-pip \
	python2-dev \
	python3-dev && \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	libxml2 \
	libxslt \
	openssl \
	p7zip \
	python2 \
	python3 \
	unrar \
	wget && \
 echo "**** install python packages ****" && \

 pip2 install --no-cache-dir \
	apprise \
	chardet \
	pynzbget &&\
 pip3 install --no-cache-dir \
        apprise \
        chardet \
        pynzbget &&\
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

RUN echo -e '#!/bin/sh\nsu me -c "/opt/nzbget/nzbget -s -o OutputMode=log"' > /root/start.sh && \
    chmod +x /root/start.sh && \
    apk add --no-cache wget && \
    wget https://nzbget.net/download/nzbget-latest-bin-linux.run && \
    chmod +x nzbget-latest-bin-linux.run && sh nzbget-latest-bin-linux.run --destdir /opt/nzbget && \
    mkdir /opt/nzbget/dst && \
    adduser -s /bin/sh -G root -G tty -D me && \
    chown -R me /opt/nzbget

VOLUME ["/mnt/Plex", "/mnt/Plex3", "/mnt/movies"]

EXPOSE 6789

CMD ["/root/start.sh"]
