#!/usr/bin/env bash
set -euo pipefail

# Update ubuntu, debian and rockylinux tags
for tag in ubuntu debian rockylinux; do
  docker tag "samba:${tag}" "diegogslomp/samba-ad-dc:${tag}"
  docker push "diegogslomp/samba-ad-dc:${tag}"
  docker rmi "diegogslomp/samba-ad-dc:${tag}"
done

# Get samba version from last almalinux
samba_version=$(docker run --rm samba:almalinux samba --version | awk '{ print $2 }')
# Update almalinux (main) tags
for tag in almalinux "${samba_version}" latest; do
  docker tag samba:almalinux "diegogslomp/samba-ad-dc:${tag}"
  docker push "diegogslomp/samba-ad-dc:${tag}"
  docker rmi "diegogslomp/samba-ad-dc:${tag}"
done

# Cleanup
docker image prune -f
docker images