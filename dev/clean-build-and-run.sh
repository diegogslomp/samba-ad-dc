#!/usr/bin/env bash
set -euo pipefail
set -x

docker compose down -v
docker build --platform="linux/arm64" -f dockerfiles/almalinux --load --tag samba:arm64 .
docker compose build
docker compose up -d
docker compose logs -f