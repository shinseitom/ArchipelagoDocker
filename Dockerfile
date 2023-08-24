FROM python:3.9-alpine

MAINTAINER ShinseiTom

ARG ARCHIPELAGO_VERSION="0.4.1"
ARG ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

EXPOSE 80

#I'm sure I need to do a run to install stuff, but I don't know what
RUN mkdir -p baseroms && \
    mkdir -p archipelago && \
	mkdir -p temp/Archipelago-$ARCHIPELAGO_VERSION

RUN apk add --update curl gcc python3-dev musl-dev && \
    rm -rf /var/cache/apk/*

COPY go.sh /
COPY install_requirements.py /temp/Archipelago-$ARCHIPELAGO_VERSION

WORKDIR /temp

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN chmod +x /go.sh
#RUN curl -L $ARCHIPELAGO_URL$ARCHIPELAGO_VERSION".tar.gz" > "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"
RUN wget -O "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz" $ARCHIPELAGO_URL$ARCHIPELAGO_VERSION".tar.gz"
RUN tar -xf "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"

WORKDIR "Archipelago-"$ARCHIPELAGO_VERSION
RUN python3 -u setup.py -y || true && \
    echo "\n" | python3 -u install_requirements.py

WORKDIR /

#mountable volumes to hold the webserver and baseroms
VOLUME ["/archipelago"]
VOLUME ["/baseroms"]

ENV VERSION=$ARCHIPELAGO_VERSION
CMD ./go.sh $VERSION