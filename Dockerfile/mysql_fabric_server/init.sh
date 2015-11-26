#!/bin/bash

service mysqld start
mysql -uroot -e "CREATE USER root; GRANT ALL ON *.* TO root WITH GRANT OPTION;"
mysql -uroot -e "CREATE USER fabric@localhost; GRANT ALL ON *.* TO fabric@localhost;"
yes "admin" | mysqlfabric manage setup
service mysqld stop
