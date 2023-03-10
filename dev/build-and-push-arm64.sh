#!/usr/bin/env bash
set -euo pipefail
set -x

repo="diegogslomp/samba-ad-dc"
docker buildx build --platform="linux/arm64" -f dockerfiles/almalinux --load --tag samba:arm64 .
docker tag samba:arm64 "${repo}:arm64"
docker push "${repo}:arm64"