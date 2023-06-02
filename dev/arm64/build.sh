#!/usr/bin/env bash
set -eo pipefail
set -x

if [[ -z "$SMB_VERSION" ]]; then
  SMB_VERSION=$(dev/latest-published-samba.sh)
fi
export SMB_VERSION

ARM64=$(docker buildx ls | grep arm64) || true
if [[ "$ARM64" == '' ]]; then
  docker run --privileged --rm \
    tonistiigi/binfmt --install all
fi

docker buildx build \
  --platform linux/arm64 \
  -f dockerfiles/almalinux \
  --build-arg SMB_VERSION=$SMB_VERSION \
  --load --tag samba:arm64 .
