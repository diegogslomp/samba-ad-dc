#!/bin/bash

samba-tool domain provision \
  --server-role=${SERVER_ROLE} --use-rfc2307 --dns-backend=${DNS_BACKEND} \
  --realm=${REALM} --domain=${DOMAIN} --adminpass=${ADMIN_MASS} \
  --option="dns forwarder=${DNS_FORWARDER}"

if ! grep -q ${DOMAIN} /etc/krb5.conf > /dev/null 2>&1; then
  cat /usr/local/samba/private/krb5.conf > /etc/krb5.conf
fi

if ! grep -q ${SEARCH_DOMAIN} /etc/resov.conf > /dev/null 2>&1; then
  echo -e "namerserver ${SERVER_IP}\nsearch ${SEARCH_DOMAIN}" > /etc/resolv.conf
fi

samba -F