FROM python:3.10-slim

MAINTAINER ShinseiTom

# for updating in the future
ARG ARCHIPELAGO_VERSION="0.4.6"
ARG ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

# I don't need pip yelling at me
ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1
ARG PIP_ROOT_USER_ACTION=ignore

# webui port, but might be useless considering the way the multiworld server ports work
EXPOSE 80

# make all the base folders I need
RUN mkdir -p baseroms && \
    mkdir -p archipelago && \
	mkdir -p temp/Archipelago-$ARCHIPELAGO_VERSION

# copy in the needed scripts to finish setup and startup the image
COPY go.sh /
COPY install_requirements.py /temp/Archipelago-$ARCHIPELAGO_VERSION

# do a lot of work in temp directory
WORKDIR /temp

# installs curl/git/python3-tk then cleans up after itself,
# sets the startup script as executable,
# downloads/unzips/removes archipelago zip,
# then runs archipelago's setup script and a mini-script I made with the important
# parts of the WebHost.py file that installs more dependencies
RUN apt update && \
    apt install curl git python3-tk -y && \
    apt clean && \
    chmod +x /go.sh && \
    curl -L $ARCHIPELAGO_URL$ARCHIPELAGO_VERSION".tar.gz" > "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz" && \
    tar -xf "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz" && \
    rm "Archipelago-"$ARCHIPELAGO_VERSION".tar.gz"

WORKDIR "Archipelago-"$ARCHIPELAGO_VERSION

RUN python3 -u setup.py -y || true && \
    echo "\n" | python3 -u install_requirements.py

WORKDIR /

#mountable volumes to hold the webserver and baseroms
VOLUME ["/archipelago"]
VOLUME ["/baseroms"]

ENV VERSION=$ARCHIPELAGO_VERSION
CMD ./go.sh $VERSION
