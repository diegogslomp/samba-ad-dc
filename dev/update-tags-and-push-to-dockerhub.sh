#!/usr/bin/env bash
set -euo pipefail
set -x

repo="diegogslomp/samba-ad-dc"

# Get samba version from last almalinux
version=$(docker run --rm samba:almalinux samba --version | awk '{ print $2 }')

# Update almalinux (main) tags
for tag in "${version}" almalinux latest; do
  docker tag samba:almalinux "${repo}:${tag}"
  docker push "${repo}:${tag}"
  docker rmi "${repo}:${tag}"
done

# Cleanup
docker image prune -f
docker images
