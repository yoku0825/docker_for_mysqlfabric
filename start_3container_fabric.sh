#!/bin/bash

echo -n "Starting MySQL Fabric Server.."
server_container_id=$(docker run -d --hostname="mysql-fabric" yoku0825/mysql_fabric_server)
server_ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" $server_container_id)
mysqlfabric="docker run --rm yoku0825/mysql_fabric_command --param=protocol.xmlrpc.address=$server_ip:32274"

until $mysqlfabric manage ping > /dev/null 2>&1 ; do
  sleep 3
done
echo "done"
$mysqlfabric group create myfabric > /dev/null

for n in $(seq 1 3) ; do
  echo -n "Starting MySQL Fabric-aware mysqld $n/3 .."
  node_container_id=$(docker run -d --hostname="mysql-server$n" yoku0825/mysql_fabric_aware)
  node_ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" $node_container_id)

  until mysql -uroot -h$node_ip -e "SELECT USER()" > /dev/null 2>&1 ; do
    sleep 3
  done
  echo "done"
  $mysqlfabric group add myfabric $node_ip:3306 > /dev/null
done

$mysqlfabric group promote myfabric > /dev/null
$mysqlfabric group activate myfabric > /dev/null
$mysqlfabric group lookup_servers myfabric
