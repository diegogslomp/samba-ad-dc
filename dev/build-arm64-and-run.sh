#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ -z "$SMB_VERSION" ]]; then
  SMB_VERSION=$(dev/latest-published-samba.sh)
fi
export SMB_VERSION

docker stop dc1 || true
docker rm dc1 || true
docker volume rm dc1-samba || true

ARM64=$(docker buildx ls | grep arm64)
if [[ "$ARM64" == false ]]; then
  docker run --privileged --rm \
    tonistiigi/binfmt --install all
fi

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
