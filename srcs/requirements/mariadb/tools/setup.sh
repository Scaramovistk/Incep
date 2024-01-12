#!/bin/bash
if [ ! -d "/var/lib/mysql/${DB_NAME}" ];
then
	echo "Inception : ${DB_NAME} database is being created."
	service mariadb start
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_PASS_ROOT}';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS_ROOT}';"
	mysqladmin -u root -p$DB_PASS_ROOT shutdown
else
	echo "Inception : ${DB_NAME} database is already there.";
fi
exec "mysqld_safe";
