#!/usr/bin/env bash
set -euo pipefail

curl -sL https://samba.org |
  grep 'stable/samba' |
  head -1 |
  awk '{print $3}'