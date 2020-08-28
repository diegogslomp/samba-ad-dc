#!/bin/sh

samba-tool domain provision \
  --server-role=${SERVER_ROLE} --use-rfc2307 --dns-backend=${DNS_BACKEND} \
  --realm=${REALM} --domain=${DOMAIN} --adminpass=${ADMIN_PASS} \
  --option="dns forwarder=${DNS_FORWARDER}"

cat /usr/local/samba/private/krb5.conf > /etc/krb5.conf

SERVER_IP=$(ip a | grep 'scope global' | awk '{print $2}' | awk -F / '{print $1}')

echo -e "namerserver ${SERVER_IP}\nsearch ${SEARCH_DOMAIN}" > /etc/resolv.conf

echo -e "127.0.0.1 localhost localhost.localdomain" > /etc/hosts
echo -e "${SERVER_IP} $(hostname).${SEARCH_DOMAIN} $(hostname)" >> /etc/hosts

samba -F