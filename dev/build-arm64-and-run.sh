#!/usr/bin/env bash
set -euo pipefail
set -x

export SMB_VERSION=$(dev/latest-published-samba.sh)

docker stop dc1
docker rm dc1
docker volume rm dc1-samba

docker buildx build \
  --platform linux/arm64 \
  -f dockerfiles/almalinux \
  --load --tag samba:arm64 .

docker run -d --privileged \
  --restart=unless-stopped \
  --network=host \
  --platform linux/arm64 \
  -e REALM='DGS.NET' \
  -e DOMAIN='DGS' \
  -e ADMIN_PASS='Passw0rd' \
  -e DNS_FORWARDER='8.8.8.8' \
  -v dc1-samba:/usr/local/samba \
  --name dc1 --hostname DC1 samba:arm64

docker logs dc1 -f