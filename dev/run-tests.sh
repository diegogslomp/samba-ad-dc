#!/usr/bin/env bash
set -euo pipefail
set -x

for dc in dc{1,2,3,4}; do
  docker compose exec $dc samba-tests
done
