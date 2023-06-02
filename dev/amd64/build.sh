#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ -z "$SMB_VERSION" ]]; then
  SMB_VERSION=$(dev/latest-published-samba.sh)
fi
export SMB_VERSION

docker compose build
