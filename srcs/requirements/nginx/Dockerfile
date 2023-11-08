FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install vim curl openssl nginx -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN sh /tmp/setup.sh

CMD ["nginx", "-g", "daemon off"]

