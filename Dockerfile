FROM python:3

MAINTAINER ShinseiTom


RUN mkdir -p testing
COPY . /testing
WORKDIR /testing

RUN ls -ltra
RUN chmod +x test.sh
RUN ls -ltra

CMD ["sh", "/testing/test.sh"]
