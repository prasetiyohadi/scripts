#!/bin/sh
set -ex
docker run \
  -d \
  --name rabbitmq_one \
  -e RABBITMQ_LOCAL_CONFIG='{}' \
  rabbitmq agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name rabbitmq_two \
  --link rabbitmq_one:rabbitmq_one \
  -e RABBITMQ_LOCAL_CONFIG='{}' \
  rabbitmq agent -server
sleep 1
docker run \
  -d \
  --name rabbitmq_three \
  --link rabbitmq_one:rabbitmq_one \
  --link rabbitmq_two:rabbitmq_two \
  -e RABBITMQ_LOCAL_CONFIG='{}' \
  rabbitmq agent -server
sleep 1
docker exec -it rabbitmq_two rabbitmq join rabbitmq_one
docker exec -it rabbitmq_three rabbitmq join rabbitmq_one
