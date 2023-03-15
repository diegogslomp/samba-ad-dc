#!/usr/bin/env bash
set -euo pipefail
set -x

export SMB_VERSION=$(dev/latest-published-samba.sh)

docker compose down -v
docker compose build
docker compose up -d
docker compose logs -f
