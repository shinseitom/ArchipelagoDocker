FROM python:3.9

MAINTAINER ShinseiTom

ARG ARCHIPELAGO_VERSION="0.4.1"
ARG ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

EXPOSE 80

#I'm sure I need to do a run to install stuff, but I don't know what
RUN mkdir -p baseroms && \
    mkdir -p archipelago && \
	mkdir -p temp

COPY go.sh /

RUN chmod +x go.sh


WORKDIR /temp

RUN curl -L $ARCHIPELAGO_URL$ARCHIPELAGO_VERSION".tar.gz" > "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"
RUN tar -xf "Archipelago-"$2".tar.gz"
WORKDIR "Archipelago-"$ARCHIPELAGO_VERSION
RUN echo "\n" | python3 -u setup.py

WORKDIR /

#mountable volumes to hold the webserver and baseroms
VOLUME ["/archipelago"]
VOLUME ["/baseroms"]

CMD ./go.sh $ARCHIPELAGO_VERSION