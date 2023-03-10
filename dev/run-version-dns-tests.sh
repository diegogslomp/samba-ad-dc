#!/usr/bin/env bash
set -euo pipefail

for dc in dc{1,2,3,4}; do
  docker compose exec $dc samba --version
done

for dc in dc{1,2,3,4}; do
  docker compose exec $dc host -t SRV "_ldap._tcp.dgs.net"
done
