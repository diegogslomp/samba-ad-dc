#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ ! -f samba.tar.gz ]]; then
  curl -o samba.tar.gz https://download.samba.org/pub/samba/samba-latest.tar.gz
fi

docker compose build
