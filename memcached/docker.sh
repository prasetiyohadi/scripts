#!/bin/sh
set -ex
docker run \
  -d \
  --name memcached_one \
  -e MEMCACHED_LOCAL_CONFIG='{}' \
  memcached agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name memcached_two \
  --link memcached_one:memcached_one \
  -e MEMCACHED_LOCAL_CONFIG='{}' \
  memcached agent -server
sleep 1
docker run \
  -d \
  --name memcached_three \
  --link memcached_one:memcached_one \
  --link memcached_two:memcached_two \
  -e MEMCACHED_LOCAL_CONFIG='{}' \
  memcached agent -server
sleep 1
docker exec -it memcached_two memcached join memcached_one
docker exec -it memcached_three memcached join memcached_one
