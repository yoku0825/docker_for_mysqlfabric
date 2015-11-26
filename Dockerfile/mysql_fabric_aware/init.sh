#!/bin/bash

service mysqld start
mysql -uroot -e "CREATE USER root; GRANT ALL ON *.* TO root WITH GRANT OPTION;"
mysql -uroot -e "CREATE USER fabric; GRANT ALL ON *.* TO fabric;"
mysql -uroot -e "CREATE USER ap; GRANT ALL ON ap.* TO ap;"
mysql -uroot -e "RESET MASTER"
service mysqld stop

rm /var/lib/mysql/auto.cnf
