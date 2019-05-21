samba-ad-dc
===========

Creating samba container::

    docker run --privileged -it --name samba diegogslomp/samba-ad-dc:4.9.8 bash

Provisioning Samba AD in Non-interactive Mode::

    samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL \
    --realm=SAMDOM.EXAMPLE.COM --domain=SAMDOM --adminpass=Passw0rd

Configuring Kerberos::

    cp -uf /usr/local/samba/private/krb5.conf /etc/
    
Configuring the DNS Resolver::

    IP=$(ip a | grep 'scope global' | awk '{print $2}' | awk -F '/' '{print $1}')
    cat /etc/resolv.conf > ~/etc/resolv.conf.new
    echo -e "namerserver $IP\nsearch samdom.example.com\n" > ~/resolv.conf.new
    cp -uf ~/resolv.conf.new /etc/resolv.conf

Verifying::

    samba
    
Testing::
    
    smbclient -L localhost -U%
    host -t SRV _ldap._example.com
    kinit administrator
    klist
    /usr/local/samba/bin/wbinfo -u
    
Official site: https://wiki.samba.org/index.php/User_Documentation
