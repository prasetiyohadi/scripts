#!/bin/sh
set -ex
docker run \
  -d \
  --name elasticsearch_one \
  -e ES_LOCAL_CONFIG='{}' \
  elasticsearch agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name elasticsearch_two \
  --link elasticsearch_one:elasticsearch_one \
  -e ES_LOCAL_CONFIG='{}' \
  elasticsearch agent -server
sleep 1
docker run \
  -d \
  --name elasticsearch_three \
  --link elasticsearch_one:elasticsearch_one \
  --link elasticsearch_two:elasticsearch_two \
  -e ES_LOCAL_CONFIG='{}' \
  elasticsearch agent -server
sleep 1
docker exec -it elasticsearch_two elasticsearch join elasticsearch_one
docker exec -it elasticsearch_three elasticsearch join elasticsearch_one
