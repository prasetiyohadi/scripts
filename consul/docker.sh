#!/usr/bin/env bash
set -euo pipefail
###
### consul/docker.sh - manage consul container
###
### Usage: docker.sh [OPTIONS] COMMAND
###
### Options:
###   -h        Show this message.
###
### Commands:
###   clean     Clean resources
###   deploy    Deploy resources
###   images    List images
###   networks  List networks
###   ps        List containers
###   purge     Remove all resources

help() {
    sed -Ene 's/^### ?//;T;p' "$0"
}

fail() {
    help
    exit 1
}

# Initialize options variables
PREFIX="consul"

#clean##
#clean## consul/docker.sh - manage consul container
#clean##
#clean## Usage: docker.sh clean [OPTIONS] NAME
#clean##
#clean## Options:
#clean##   -h   Show this message.
#clean##   -t   Set resource type, default is container, allowed values: container, image, network.

help_clean() {
    sed -Ene 's/^#clean## ?//;T;p' "$0"
}

fail_clean() {
    help_clean
    exit 1
}

# Clean resources
clean() {
    if [ -z "$name" ]; then
        echo "nothing to clean"
        help_clean
        exit 0
    elif [ "$TYPE" == "container" ]; then
        echo "stopping $name container..."
        docker stop "$name" > /dev/null
        echo "deleting $name container..."
        docker rm "$name" > /dev/null
    elif [ "$TYPE" == "image" ]; then
        echo "deleting $name image..."
        docker rmi "$name" > /dev/null
    elif [ "$TYPE" == "network" ]; then
        echo "deleting $name network..."
        docker network rm "$name" > /dev/null
    else
        echo "no resource with type $TYPE"
    fi
}

#deploy##
#deploy## consul/docker.sh - manage consul container
#deploy##
#deploy## Usage: docker.sh deploy [OPTIONS] RESOURCE
#deploy##
#deploy## Options:
#deploy##   -h      Show this message.
#deploy##
#deploy## Available resources:
#deploy##   consul  Deploy consul cluster
#deploy##   network Create consul docker network

help_deploy() {
    sed -Ene 's/^#deploy## ?//;T;p' "$0"
}

fail_deploy() {
    help_deploy
    exit 1
}

# Consul deployment
consul() {
    docker pull consul
    docker run \
        -d \
        -e CONSUL_LOCAL_CONFIG='{
            "datacenter":"consul",
            "addresses": {
              "http": "0.0.0.0"
            },
            "server":true,
            "ui":true,
            "enable_debug":true
        }' \
        --name consul_one \
        --network $PREFIX \
        consul agent -server -bootstrap-expect=3
    docker run \
        -d \
        -e CONSUL_LOCAL_CONFIG='{
            "datacenter":"consul",
            "addresses": {
              "http": "0.0.0.0"
            },
            "server":true,
            "ui":true,
            "enable_debug":true
        }' \
        --name consul_two \
        --network $PREFIX \
        consul agent -server
    docker run \
        -d \
        -e CONSUL_LOCAL_CONFIG='{
            "datacenter":"consul",
            "addresses": {
              "http": "0.0.0.0"
            },
            "server":true,
            "ui":true,
            "enable_debug":true
        }' \
        --name consul_three \
        --network $PREFIX \
        consul agent -server
    sleep 1
    docker exec consul_two consul join consul_one
    docker exec consul_three consul join consul_one
}

# Create network
network() {
  docker network create $PREFIX
}

# Purge deployment
purge() {
    read -p "All resources will be deleted. Continue[yn]? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for w in one two three; do
            echo "stopping consul_$w container..."
            docker stop consul_$w
        done
        for w in one two three; do
            echo "deleting consul_$w container..."
            docker rm consul_$w
        done
        echo "deleting consul image..."
        docker rmi consul > /dev/null
        echo "deleting $PREFIX network..."
        docker network rm "$PREFIX" > /dev/null
    fi
}

OPTIND=1
while getopts ":h?" opt; do
    case ${opt} in
        h) help && exit 0;;
        :) echo "Error: option -${OPTARG} requires an argument." && fail;;
        \?) echo "Error: option -${OPTARG} does not exist." && fail;;
    esac
done
shift $((OPTIND-1))
[[ $# -ge 1 ]] && export CMD="$1" || export CMD=""
case $CMD in
    "clean")
        OPTIND=2
        TYPE=container
        while getopts ":t:h?" opt; do
            case ${opt} in
                h) help_clean && exit 0;;
                t) TYPE=$OPTARG;;
                :) echo "Error: option -${OPTARG} requires an argument." && fail_clean;;
                \?) echo "Error: option -${OPTARG} does not exist." && fail_clean;;
            esac
        done
        shift $((OPTIND-1))
        [[ $# -ge 1 ]] && export name="$1" || export name=""
        clean;;
    "deploy")
        OPTIND=2
        while getopts ":h?" opt; do
            case ${opt} in
                h) help_deploy && exit 0;;
                :) echo "Error: option -${OPTARG} requires an argument." && fail_deploy;;
                \?) echo "Error: option -${OPTARG} does not exist." && fail_deploy;;
            esac
        done
        shift $((OPTIND-1))
        [[ $# -ge 1 ]] && export CMD="$1" || export CMD=""
        case $CMD in
            "consul") consul;;
            "network") network;;
            *) echo "nothing to deploy" && help_deploy && exit 0;;
        esac;;
    "images") docker images;;
    "networks") docker network ls;;
    "ps") docker ps -a;;
    "purge") purge;;
    *) help && exit 0;;
esac
