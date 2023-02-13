#!/usr/bin/env bash
set -euo pipefail
set -x

docker compose down -v
docker compose build
docker compose up -d
docker compose logs -f