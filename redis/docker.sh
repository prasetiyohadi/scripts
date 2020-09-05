#!/bin/sh
set -ex
docker run \
  -d \
  --name redis_one \
  -e REDIS_LOCAL_CONFIG='{}' \
  redis agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name redis_two \
  --link redis_one:redis_one \
  -e REDIS_LOCAL_CONFIG='{}' \
  redis agent -server
sleep 1
docker run \
  -d \
  --name redis_three \
  --link redis_one:redis_one \
  --link redis_two:redis_two \
  -e REDIS_LOCAL_CONFIG='{}' \
  redis agent -server
sleep 1
docker exec -it redis_two redis join redis_one
docker exec -it redis_three redis join redis_one
