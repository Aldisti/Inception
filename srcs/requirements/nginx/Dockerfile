FROM debian:buster

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN sh /tmp/setup.sh

CMD ["nginx", "-g", "daemon off"]

