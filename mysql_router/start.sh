#!/bin/bash

docker run -d -v $PWD/router.ini:/tmp/setup/router.ini yoku0825/mysql_router
