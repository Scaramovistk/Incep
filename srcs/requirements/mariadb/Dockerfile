FROM debian:bullseye

EXPOSE 3306

RUN	apt update \
	&& apt install -y --no-install-recommends --no-install-suggests \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chown root:root /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "mysqld"]
