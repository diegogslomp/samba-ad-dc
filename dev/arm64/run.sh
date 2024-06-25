#!/usr/bin/env bash
set -eo pipefail
set -x

docker stop dc1 || true
docker rm dc1 || true
docker volume rm dc1-etc dc1-private dc1-var || true

docker run -d --privileged \
  --restart=unless-stopped \
  --network=host \
  --platform linux/arm64 \
  -e REALM='DGS.NET' \
  -e DOMAIN='DGS' \
  -e ADMIN_PASS='Passw0rd' \
  -e DNS_FORWARDER='8.8.8.8' \
  -v dc1-etc:/usr/local/samba/etc \
  -v dc1-private:/usr/local/samba/private \
  -v dc1-var:/usr/local/samba/var \
  --name dc1 --hostname DC1 samba:arm64

docker logs dc1 -f
