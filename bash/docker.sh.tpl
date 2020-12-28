#!/usr/bin/env bash
set -euo pipefail
###
### PROJECT/docker.sh - manage PROJECT container
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
###   volumes   List volumes

help() {
    sed -Ene 's/^### ?//;T;p' "$0"
}

fail() {
    help
    exit 1
}

# Initialize options variables
PREFIX="PROJECT"

#clean##
#clean## PROJECT/docker.sh - manage PROJECT container
#clean##
#clean## Usage: docker.sh clean [OPTIONS] NAME
#clean##
#clean## Options:
#clean##   -h   Show this message.
#clean##   -t   Set resource type, default is container, allowed values: container, image, network, volume.

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
    elif [ "$TYPE" == "volume" ]; then
        echo "deleting $name volume..."
        docker volume rm "$name" > /dev/null
    else
        echo "no resource with type $TYPE"
    fi
}

#deploy##
#deploy## PROJECT/docker.sh - manage PROJECT container
#deploy##
#deploy## Usage: docker.sh deploy [OPTIONS] RESOURCE
#deploy##
#deploy## Options:
#deploy##   -h      Show this message.
#deploy##
#deploy## Available resources:
#deploy##   network Create docker network
#deploy##   PROJECT Create PROJECT infrastructure

help_deploy() {
    sed -Ene 's/^#deploy## ?//;T;p' "$0"
}

fail_deploy() {
    help_deploy
    exit 1
}

#PROJECT##
#PROJECT## PROJECT/docker.sh - manage PROJECT container
#PROJECT##
#PROJECT## Usage: docker.sh deploy PROJECT [OPTIONS]
#PROJECT##
#PROJECT## Options:
#PROJECT##   -h     Show this message.
#PROJECT##   -n     Network name, default is PROJECT.

help_PROJECT() {
    sed -Ene 's/^#PROJECT## ?//;T;p' "$0"
}

fail_PROJECT() {
    help_PROJECT
    exit 1
}

# PROJECT deployment
PROJECT() {
    ERR="Deploy the network first!"
    docker network inspect $NETWORK 1>/dev/null 2>&1 || (echo $ERR && exit 1)
}

#network##
#network## PROJECT/docker.sh - manage PROJECT container
#network##
#network## Usage: docker.sh deploy network [OPTIONS]
#network##
#network## Options:
#network##   -h     Show this message.
#network##   -n     Network name, default is PROJECT.

help_network() {
    sed -Ene 's/^#network## ?//;T;p' "$0"
}

fail_network() {
    help_network
    exit 1
}

# Create network
network() {
    echo "creating $NETWORK network..."
    docker network create $NETWORK
}

# Purge deployment
purge() {
    read -p "All resources will be deleted. Continue[yn]? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
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
            "PROJECT")
                OPTIND=2
                NETWORK=$PREFIX
                while getopts ":n:h?" opt; do
                    case ${opt} in
                        h) help_PROJECT && exit 0;;
                        n) NETWORK=$OPTARG;;
                        :) echo "Error: option -${OPTARG} requires an argument." && fail_PROJECT;;
                        \?) echo "Error: option -${OPTARG} does not exist." && fail_PROJECT;;
                    esac
                done
                shift $((OPTIND-1))
                PROJECT;;
            "network")
                OPTIND=2
                NETWORK=$PREFIX
                while getopts ":n:h?" opt; do
                    case ${opt} in
                        h) help_network && exit 0;;
                        n) NETWORK=$OPTARG;;
                        :) echo "Error: option -${OPTARG} requires an argument." && fail_network;;
                        \?) echo "Error: option -${OPTARG} does not exist." && fail_network;;
                    esac
                done
                shift $((OPTIND-1))
                network;;
            *) echo "nothing to deploy" && help_deploy && exit 0;;
        esac;;
    "images") docker images;;
    "networks") docker network ls;;
    "ps") docker ps -a;;
    "purge") purge;;
    "volumes") docker volume ls;;
    *) help && exit 0;;
esac
