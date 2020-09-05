#!/usr/bin/env bash
set -euxo pipefail

export MINIO_ALIAS=
export MINIO_HOST=
export MINIO_ACCESS_KEY=
export MINIO_SECRET_KEY=

if [ -f $(which mc > /dev/null) ]; then
  mc config host add ${MINIO_ALIAS} ${MINIO_HOST} ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
fi
