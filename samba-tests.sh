#!/bin/sh
echo "### samba --version"
samba --version
echo "### testparm"
testparm
echo "### smbclient -L localhost -U%"
smbclient -L localhost -U%
echo "### smbclient //localhost/netlogon -UAdministrator -c 'ls'"
smbclient //localhost/netlogon -UAdministrator -c 'ls'
echo "### nslookup $(hostname).${SEARCH_DOMAIN}"
nslookup $(hostname).${SEARCH_DOMAIN}
echo "### host -t SRV _ldap._tcp.${SEARCH_DOMAIN}"
host -t SRV _ldap._tcp.${SEARCH_DOMAIN}
echo "### kinit administrator"
kinit administrator
echo "### klist"
klist
echo "### /usr/local/samba/bin/wbinfo -u"
/usr/local/samba/bin/wbinfo -u