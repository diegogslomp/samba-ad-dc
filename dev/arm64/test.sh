#!/usr/bin/env bash
set -eo pipefail
set -x

docker exec dc1 samba-tests
