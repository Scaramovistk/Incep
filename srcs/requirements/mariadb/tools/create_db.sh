#!/bin/sh

# Run mysql_upgrade
mysql_upgrade

# Start MariaDB service
systemctl start mariadb

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  echo "There's a Database already"
else
  # Install expect if not installed
  apt-get update
  apt-get install -y expect

  # Run mysql_secure_installation using expect
  expect <<_EOF_
    spawn mysql_secure_installation
    expect "Enter current password for root (enter for none):"
    send "\n"
    expect "Enter current password for root (enter for none):"
    send "\n"
    expect "Set root password?"
    send "y\n"
    expect "New password:"
    send "root4life\n"
    expect "Re-enter new password:"
    send "root4life\n"
    expect "Remove anonymous users?"
    send "y\n"
    expect "Disallow root login remotely?"
    send "n\n"
    expect "Remove test database and access to it?"
    send "y\n"
    expect "Reload privilege tables now?"
    send "y\n"
    expect eof
_EOF_

  # Grant privileges
  echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

  # Create and grant privileges for the specified database
  echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

  # Import SQL dump to the database
  mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

# Stop MariaDB service
systemctl stop mariadb

# Execute the command passed as arguments
exec "$@"

