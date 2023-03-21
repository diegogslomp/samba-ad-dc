#!/usr/bin/env bash
set -euo pipefail

curl -sL https://wiki.samba.org/index.php/Main_Page |
  grep "Current_Stable_Release" |
  awk -F ">" '{print $8}' |
  awk -F "<" '{print $1}'
