#!/bin/bash

service mysqld start
mysql -p$(awk '/root@localhost/{print $NF}' /var/log/mysqld.log) --connect-expired-password -e "ALTER USER user() IDENTIFIED BY ''"
mysql -uroot -e "CREATE USER root; GRANT ALL ON *.* TO root WITH GRANT OPTION;"
mysql -uroot -e "CREATE USER fabric; GRANT ALL ON *.* TO fabric WITH GRANT OPTION;"
mysql -uroot -e "CREATE USER ap; GRANT ALL ON ap.* TO ap;"
mysql -uroot -e "RESET MASTER"
service mysqld stop

rm /var/lib/mysql/auto.cnf
