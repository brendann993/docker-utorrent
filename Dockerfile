FROM lsiobase/xenial
MAINTAINER brendann993

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"

RUN \
	mkdir /utorrent

# Install required dependencies.
RUN \
	apt-get -q update && \
    apt-get install curl ibssl1.0.0 libssl-dev -qy
	
# Install utorrent	
RUN \
	curl -s http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 | tar xzf - --strip-components 1 -C /utorrent && \
    chown -R abc:abc /utorrent
	
# Clean up
RUN \
    apt-get -y remove curl && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080 6881
VOLUME /config /media
