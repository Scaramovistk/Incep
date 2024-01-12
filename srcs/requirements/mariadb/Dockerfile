# MARIADB

FROM debian:bullseye

RUN  apt update -y && apt-get install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]

