FROM python:3.9

MAINTAINER ShinseiTom

ENV ARCHIPELAGO_VERSION="0.4.1"
ENV ARCHIPELAGO_URL="https://github.com/ArchipelagoMW/Archipelago/archive/refs/tags/"

#EXPOSE 80


COPY torun.sh /


#I'm sure I need to do a run to install stuff, but I don't know what
RUN mkdir -p baseroms && \
	mkdir -p archipelago




#WORKDIR /archipelago

#COPY /archipelago /archipelago

#RUN chmod +x /archipelago/torun.sh
RUN chmod +x torun.sh

#mountable volumes to hold the webserver and baseroms
#VOLUME ["/archipelago"]
#VOLUME ["/baseroms"]

CMD ./torun.sh $ARCHIPELAGO_URL $ARCHIPELAGO_VERSION
CMD echo "this is a test"