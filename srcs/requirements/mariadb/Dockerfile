FROM debian:bullseye-slim

EXPOSE 3306

RUN echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/999no-check-valid-until \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
       mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chown root:root /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "mysqld"]
