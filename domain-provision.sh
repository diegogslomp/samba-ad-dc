#!/bin/bash

samba-tool domain provision \
  --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL \
  --realm=SAMDOM.EXAMPLE.COM --domain=SAMDOM --adminpass=Passw0rd \
  --option="dns forwarder=8.8.8.8"

cat /usr/local/samba/private/krb5.conf > /etc/krb5.conf

if ! grep -q samdom /etc/resov.conf > /dev/null 2>&1; then 
  echo -e "namerserver 10.99.0.1\nsearch samdom.example.com" > /etc/resolv.conf
fi

samba -F