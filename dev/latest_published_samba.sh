#!/usr/bin/env bash
set -euo pipefail

curl -sL https://download.samba.org/pub/samba |
  grep LATEST |
  awk -F\" '{ print $12 }' |
  awk -F- '{ print $4 }'
