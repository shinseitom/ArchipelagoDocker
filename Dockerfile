FROM python:3.9

MAINTAINER ShinseiTom

ARG ARCHIPELAGO_VERSION="0.4.1"
ARG ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

EXPOSE 80

#I'm sure I need to do a run to install stuff, but I don't know what
RUN mkdir -p baseroms && \
    mkdir -p archipelago && \
	mkdir -p temp/Archipelago-$ARCHIPELAGO_VERSION

COPY go.sh /
COPY install_requirements.py /temp/Archipelago-$ARCHIPELAGO_VERSION

RUN chmod +x go.sh

WORKDIR /temp

#RUN pip install --upgrade pip
ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

RUN curl -L $ARCHIPELAGO_URL$ARCHIPELAGO_VERSION".tar.gz" > "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz" && /
    tar -xf "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"
#RUN tar -xf "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"

WORKDIR "Archipelago-"$ARCHIPELAGO_VERSION
RUN python3 -u setup.py -y || true && \
    echo "\n" | python3 -u install_requirements.py
#COPY install_requirements.py .
#RUN echo "\n" | python3 -u install_requirements.py

WORKDIR /

#mountable volumes to hold the webserver and baseroms
VOLUME ["/archipelago"]
VOLUME ["/baseroms"]

ENV VERSION=$ARCHIPELAGO_VERSION
CMD ./go.sh $VERSION