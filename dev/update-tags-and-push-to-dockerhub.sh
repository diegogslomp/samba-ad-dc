#!/usr/bin/env bash
set -euo pipefail

repo="diegogslomp/samba-ad-dc"

# Update ubuntu, debian and rockylinux tags
for tag in ubuntu debian rockylinux; do
  docker tag "samba:${tag}" "${repo}:${tag}"
  docker push "${repo}:${tag}"
  docker rmi "${repo}:${tag}"
done

# Get samba version from last almalinux
version=$(docker run --rm samba:almalinux samba --version | awk '{ print $2 }')
# Update almalinux (main) tags
for tag in almalinux "${version}" latest; do
  docker tag samba:almalinux "${repo}:${tag}"
  docker push "${repo}:${tag}"
  docker rmi "${repo}:${tag}"
done

# Cleanup
docker image prune -f
docker images