#!/usr/bin/env bash
set -eo pipefail
set -x

docker stop dc1 || true
docker rm dc1 || true
docker volume rm dc1-etc dc1-private dc1-var || true
