samba-ad-dc
===========

#. Clone, build and run with docker-compose::

    git clone https://github.com/diegogslomp/samba-ad-dc
    cd samba-ad-dc
    docker-compose build
    docker-compose up

#. Tests::

    docker-compose exec dc samba --version
    docker-compose exec dc testparm
    docker-compose exec dc smbclient -L localhost -U%
    docker-compose exec dc smbclient //localhost/netlogon -UAdministrator -c 'ls'
    docker-compose exec dc nslookup DC1.samdom.example.com
    docker-compose exec dc host -t SRV _ldap._tcp.samdom.example.com
    docker-compose exec dc kinit administrator
    docker-compose exec dc klist
    docker-compose exec dc /usr/local/samba/bin/wbinfo -u

#. Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

#. Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
