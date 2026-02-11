#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ ! -f samba.tar.gz ]]; then
  curl -o samba.tar.gz https://download.samba.org/pub/samba/samba-latest.tar.gz
  rm -rf samba && mkdir samba
  tar zxvf samba.tar.gz -C samba --strip-components=1
fi

docker compose build
