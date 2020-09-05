#!/bin/sh
set -ex
docker run \
  -d \
  --name haproxy_one \
  -e HAPROXY_LOCAL_CONFIG='{}' \
  haproxy agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name haproxy_two \
  --link haproxy_one:haproxy_one \
  -e HAPROXY_LOCAL_CONFIG='{}' \
  haproxy agent -server
sleep 1
docker run \
  -d \
  --name haproxy_three \
  --link haproxy_one:haproxy_one \
  --link haproxy_two:haproxy_two \
  -e HAPROXY_LOCAL_CONFIG='{}' \
  haproxy agent -server
sleep 1
docker exec -it haproxy_two haproxy join haproxy_one
docker exec -it haproxy_three haproxy join haproxy_one
