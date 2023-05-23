#!/usr/bin/env bash
set -eo pipefail
set -x

docker compose down -v
docker compose up -d
docker compose logs -f
