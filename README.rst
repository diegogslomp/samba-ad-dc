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

    docker run --privileged -it -p 139:139 -p 445:445 \
    --network samba --ip 10.99.0.1 --hostname DC01 \
    --add-host "localhost.localdomain:127.0.0.1" \
    --add-host "DC01.samdom.example.com:10.99.0.1" \
    --name samba diegogslomp/samba-ad-dc:4.9.8 bash

#. Provisioning Samba AD in Non-interactive Mode::

    samba-tool domain provision \
    --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL \
    --realm=SAMDOM.EXAMPLE.COM --domain=SAMDOM --adminpass=Passw0rd \
    --option="dns forwarder=8.8.8.8"

#. Configuring Kerberos and DNS Resolver::

    cat /usr/local/samba/private/krb5.conf > /etc/krb5.conf
    echo -e "namerserver 10.99.0.1\nsearch samdom.example.com" > /etc/resolv.conf

#. Starting Samba Service::

    samba

#. Testing::

    testparm
    smbclient -L localhost -U%
    smbclient //localhost/netlogon -UAdministrator -c 'ls'
    nslookup DC01.samdom.example.com
    host -t SRV _ldap._tcp.samdom.example.com
    kinit administrator
    klist
    /usr/local/samba/bin/wbinfo -u

#. Type `Ctrl-p + Ctrl-q` to detach the tty without exiting the shell

#. Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller
