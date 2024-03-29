#!/usr/bin/env bash
# -- samver
# -- https://samver.org/
# -- in a git repo, spits out a goodly version

if date --version &>/dev/null; then
  # GNU
  echo "$(date --utc --date="$(git show -s --format=%ci)" +%Y%m%d%H%M)-$(git rev-parse --short HEAD)"
else
  # BSD
  echo "$(date -u -j -f %s "$(git show -s --format=%ct)" +%Y%m%d%H%M)-$(git rev-parse --short HEAD)"
fi
