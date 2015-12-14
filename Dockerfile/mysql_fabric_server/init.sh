#!/bin/bash

service mysqld start
mysql -p$(awk '/root@localhost/{print $NF}' /var/log/mysqld.log) --connect-expired-password -e "ALTER USER user() IDENTIFIED BY ''"
mysql -uroot -e "CREATE USER root; GRANT ALL ON *.* TO root WITH GRANT OPTION;"
mysql -uroot -e "CREATE USER fabric@localhost; GRANT ALL ON *.* TO fabric@localhost;"
yes "admin" | mysqlfabric manage setup
service mysqld stop
