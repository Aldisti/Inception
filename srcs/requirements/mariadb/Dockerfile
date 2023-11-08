FROM debian:bookworm

RUN apt update
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

# RUN sh /tmp/setup.sh
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_USER=mysql
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=inceptionDB
ENV MYSQL_HOST=mariadb

RUN sh /tmp/setup.sh

ENTRYPOINT ["mysqld_safe"]

