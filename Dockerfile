FROM python:3.9

MAINTAINER ShinseiTom

ENV ARCHIPELAGO_VERSION="0.4.1"
ENV ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

EXPOSE 80/tcp
EXPOSE 80/udp


#I'm sure I need to do a run to install stuff, but I don't know what
RUN mkdir -p baseroms && \
	mkdir -p archipelago


#folder to hold the webserver and baseroms
VOLUME ["/archipelago"]
VOLUME ["/baseroms"]


COPY go.sh /archipelago/go.sh

WORKDIR /archipelago

RUN chmod +x go.sh

CMD /archipelago/go.sh $ARCHIPELAGO_URL $ARCHIPELAGO_VERSION