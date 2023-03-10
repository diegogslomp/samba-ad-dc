#!/usr/bin/env bash
set -euo pipefail
set -x

repo="diegogslomp/samba-ad-dc"

# Get samba version from last almalinux
version=$(docker run --rm samba:almalinux samba --version | awk '{ print $2 }')

# Update arm64
docker tag samba:arm64 "${repo}:arm64"
docker push "${repo}:arm64"

# Update almalinux (main) tags
for tag in amd64 almalinux "${version}"; do
  docker tag samba:almalinux "${repo}:${tag}"
  docker push "${repo}:${tag}"
  docker rmi "${repo}:${tag}"
done

# Update manifest to accept amd64 and arm64 as latest
docker manifest rm diegogslomp/samba-ad-dc:latest
docker manifest create diegogslomp/samba-ad-dc:latest diegogslomp/samba-ad-dc:amd64 diegogslomp/samba-ad-dc:arm64
docker manifest push diegogslomp/samba-ad-dc:latest

# Cleanup
docker image prune -f
docker images
