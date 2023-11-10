FROM debian:bookworm

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_USER=adi-stef
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=inceptionDB

ENTRYPOINT ["/bin/bash", "/tmp/setup.sh"]

