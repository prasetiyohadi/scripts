#!/bin/sh
set -ex
docker run \
  -d \
  --name mongodb_one \
  -e MONGODB_LOCAL_CONFIG='{}' \
  mongodb agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name mongodb_two \
  --link mongodb_one:mongodb_one \
  -e MONGODB_LOCAL_CONFIG='{}' \
  mongodb agent -server
sleep 1
docker run \
  -d \
  --name mongodb_three \
  --link mongodb_one:mongodb_one \
  --link mongodb_two:mongodb_two \
  -e MONGODB_LOCAL_CONFIG='{}' \
  mongodb agent -server
sleep 1
docker exec -it mongodb_two mongodb join mongodb_one
docker exec -it mongodb_three mongodb join mongodb_one
