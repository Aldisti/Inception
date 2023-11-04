FROM debian:buster

COPY ./tools/setupd.sh /tmp/setup.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN sh /tmp/setup.sh

CMD []

