samba-ad-dc
===========

samba-tool -h::

    docker run --rm --name samba diegogslomp/samba-ad-dc:4.9.8

TODO domain provision::

    samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL \
    --realm=SAMDOM.EXAMPLE.COM --domain=SAMDOM --adminpass=Passw0rd

    mv /etc/krb5.conf /etc/krb5.conf.ORIG
    cp /usr/local/samba/private/krb5.conf /etc/
    

TODO tests::
    
    smbclient -L localhost -U%
    host -t SRV _ldap._example.com
    kinit administrator
    klist
    /usr/local/samba/bin/wbinfo -u
    
Local install and DNS Cache: https://github.com/diegogslomp/samba-ad-dc/blob/master/local-install-and-dns-cache.rst

Official site: https://wiki.samba.org/index.php/User_Documentation
