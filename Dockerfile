FROM python:3.9

MAINTAINER ShinseiTom

#ENV ARCHIPELAGO_VERSION="0.4.1"
#ENV ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

#EXPOSE 80


COPY go.sh /


#I'm sure I need to do a run to install stuff, but I don't know what
#RUN mkdir -p baseroms && \
#    mkdir -p archipelago

RUN ls

RUN chmod +x /go.sh

RUN ls

RUN /go.sh



#WORKDIR /archipelago

#COPY /archipelago /archipelago

#RUN chmod +x /archipelago/go.sh
#RUN chmod +x go.sh

#mountable volumes to hold the webserver and baseroms
#VOLUME ["/archipelago"]
#VOLUME ["/baseroms"]

CMD go.sh $ARCHIPELAGO_URL $ARCHIPELAGO_VERSION
#CMD echo "this is a test"