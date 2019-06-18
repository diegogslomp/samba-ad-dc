samba-ad-dc
===========

#. Active Directory Settings::

    SERVER_IP=10.99.0.1
    SERVER_ROLE=dc
    SERVER_HOSTNAME=DC1
    DNS_BACKEND=SAMBA_INTERNAL
    REALM=SAMDOM.EXAMPLE.COM
    SEARCH_DOMAIN=samdom.example.com
    DOMAIN=SAMDOM
    ADMIN_PASS=Passw0rd
    DNS_FORWARDER=8.8.8.8

#. Create docker network::

    docker network create --driver=bridge --subnet=10.99.0.0/16 \
    --ip-range=10.99.0.0/24 --gateway 10.99.0.254 samba

#. Create samba container::

    docker run --privileged -d \
    --network samba \
    --ip "${SERVER_IP}" \
    --hostname "${SERVER_HOSTNAME}" \
    --add-host "localhost.localdomain:127.0.0.1" \
    --add-host "${SERVER_HOSTNAME}.samdom.example.com:${SERVER_IP}" \
    -e "SERVER_IP=${SERVER_IP}" \
    -e "SERVER_ROLE=${SERVER_ROLE}" \
    -e "DNS_BACKEND=${DNS_BACKEND}" \
    -e "REALM=${REALM}" \
    -e "SEARCH_DOMAIN=${SEARCH_DOMAIN}" \
    -e "DOMAIN=${DOMAIN}" \
    -e "ADMIN_PASS=${ADMIN_PASS}" \
    -e "DNS_FORWARDER=${DNS_FORWARDER}" \
    --name samba diegogslomp/samba-ad-dc

#. Tests::

    docker exec -it samba samba --version
    docker exec -it samba testparm
    docker exec -it samba smbclient -L localhost -U%
    docker exec -it samba smbclient //localhost/netlogon -UAdministrator -c 'ls'
    docker exec -it samba nslookup DC1.samdom.example.com
    docker exec -it samba host -t SRV _ldap._tcp.samdom.example.com
    docker exec -it samba kinit administrator
    docker exec -it samba klist
    docker exec -it samba /usr/local/samba/bin/wbinfo -u

#. Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller
