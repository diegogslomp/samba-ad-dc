#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ ! -f samba.tar.gz ]]; then
  curl -o samba.tar.gz https://download.samba.org/pub/samba/samba-latest.tar.gz
fi

ARM64=$(docker buildx ls | grep arm64) || true
if [[ "$ARM64" == '' ]]; then
  docker run --privileged --rm \
    tonistiigi/binfmt --install all
fi

docker buildx build \
  --platform linux/arm64 \
  -f dockerfiles/almalinux \
  --load --tag samba:arm64 .
