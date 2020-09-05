#!/bin/sh
set -ex
docker run \
  -d \
  --name mysql_one \
  -e MYSQL_LOCAL_CONFIG='{}' \
  mysql agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name mysql_two \
  --link mysql_one:mysql_one \
  -e MYSQL_LOCAL_CONFIG='{}' \
  mysql agent -server
sleep 1
docker run \
  -d \
  --name mysql_three \
  --link mysql_one:mysql_one \
  --link mysql_two:mysql_two \
  -e MYSQL_LOCAL_CONFIG='{}' \
  mysql agent -server
sleep 1
docker exec -it mysql_two mysql join mysql_one
docker exec -it mysql_three mysql join mysql_one
