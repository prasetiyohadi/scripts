#!/bin/sh
set -ex

export MINIO_ALIAS=minio-1
export MINIO_HOST=http://192.168.39.140:9000
export MINIO_ACCESS_KEY=EZWJU9LGRXAI27W7GIBN
export MINIO_SECRET_KEY=uYlz+PxnsU7g9uTAgeOv8nH1KhCO7dKz+OgfhVWE

if [ -f $(which mc > /dev/null) ]; then
  mc config host add ${MINIO_ALIAS} ${MINIO_HOST} ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
fi
