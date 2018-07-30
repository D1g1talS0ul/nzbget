FROM alpine:latest
# change username 'me' to your username
COPY nzbget.conf /opt/nzbget/

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
