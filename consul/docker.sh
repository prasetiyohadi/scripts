#!/usr/bin/env bash
set -ex
docker run \
  -d \
  --name consul_one \
  -e CONSUL_LOCAL_CONFIG='{
    "datacenter":"localcontainer",
    "addresses": {
      "http": "0.0.0.0"
    },
    "server":true,
    "ui":true,
    "enable_debug":true
  }' \
  consul agent -server -bootstrap-expect=3
sleep 1
docker run \
  -d \
  --name consul_two \
  --link consul_one:consul_one \
  -e CONSUL_LOCAL_CONFIG='{
    "datacenter":"localcontainer",
    "addresses": {
      "http": "0.0.0.0"
    },
    "server":true,
    "ui":true,
    "enable_debug":true
  }' \
  consul agent -server
sleep 1
docker run \
  -d \
  --name consul_three \
  --link consul_one:consul_one \
  --link consul_two:consul_two \
  -e CONSUL_LOCAL_CONFIG='{
    "datacenter":"localcontainer",
    "addresses": {
      "http": "0.0.0.0"
    },
    "server":true,
    "ui":true,
    "enable_debug":true
  }' \
  consul agent -server
sleep 1
docker exec -it consul_two consul join consul_one
docker exec -it consul_three consul join consul_one
