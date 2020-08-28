#!/bin/sh
echo -e "\n### samba --version ###\n"
samba --version
echo -e "\n### testparm ###\n"
testparm
echo -e "\n### smbclient -L localhost -U% ###\n"
smbclient -L localhost -U%
echo -e "\n### smbclient //localhost/netlogon -UAdministrator -c 'ls' ###\n"
smbclient //localhost/netlogon -UAdministrator -c 'ls'
echo -e "\n### nslookup $(hostname).${SEARCH_DOMAIN} ###\n"
nslookup $(hostname).${SEARCH_DOMAIN}
echo -e "\n### host -t SRV _ldap._tcp.${SEARCH_DOMAIN} ###\n"
host -t SRV _ldap._tcp.${SEARCH_DOMAIN}
echo -e "\n### kinit administrator ###\n"
kinit administrator
echo -e "\n### klist ###\n"
klist
echo -e "\n### /usr/local/samba/bin/wbinfo -u ###\n"
/usr/local/samba/bin/wbinfo -u