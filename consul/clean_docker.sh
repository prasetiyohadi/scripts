#!/bin/sh
set -ex
for w in one two three; do docker stop consul_$w; done
for w in one two three; do docker rm consul_$w; done
