samba-ad-dc
===========

#. AD Settings::

    Server role: dc
    NIS extensions enabled
    Internal DNS back end
    Kerberos realm and AD DNS zone: samdom.example.com
    NetBIOS domain name: SAMDOM
    Domain administrator password: Passw0rd
    DNS Forwarder: 8.8.8.8

#. Creating docker network::

    docker network create --driver=bridge --subnet=10.99.0.0/16 \
    --ip-range=10.99.0.0/24 --gateway 10.99.0.254 samba

#. Creating samba container::

    docker run --privileged -d \
    --network samba \
    --ip 10.99.0.1 \
    --hostname DC1 \
    --add-host "localhost.localdomain:127.0.0.1" \
    --add-host "DC1.samdom.example.com:10.99.0.1" \
    -e "SERVER_IP=10.99.0.1" \
    -e "SERVER_ROLE=dc" \
    -e "DNS_BACKEND=SAMBA_INTERNAL" \
    -e "REALM=SAMDOM.EXAMPLE.COM" \
    -e "SEARCH_DOMAIN=samdom.example.com" \
    -e "DOMAIN=SAMDOM" \
    -e "ADMIN_MASS=Passw0rd" \
    -e "DNS_FORWARDER=8.8.8.8" \
    --name samba diegogslomp/samba-ad-dc

#. Testing::

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
