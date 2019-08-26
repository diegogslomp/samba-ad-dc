samba-ad-dc
===========

Samba Active Directory Domain Controller install with Dnsmasq cache

Centos7 install
---------------

#. Samba dependences::
   
    yum install wget attr bind-utils docbook-style-xsl gcc gdb krb5-workstation libsemanage-python libxslt perl perl-ExtUtils-MakeMaker perl-Parse-Yapp perl-Test-Base pkgconfig policycoreutils-python python-crypto gnutls-devel libattr-devel keyutils-libs-devel libacl-devel libaio-devel libblkid-devel libxml2-devel openldap-devel pam-devel popt-devel python-devel readline-devel zlib-devel systemd-devel -y

#. Disable SELinux:: 

    # /etc/selinux/config
    SELINUX=disabled
    
#. Disable for current session::
    
    setenforce 0
    
#. Download and install from source::
   
    cd /usr/local/src/
    wget https://download.samba.org/pub/samba/samba-latest.tar.gz
    tar zxvf samba-latest.tar.gz
    cd /usr/local/src/samba-latest/
    ./configure
    make -j 3
    make install

#. Add samba bin/sbin to PATH::
   
    # /root/.bash_profile
    ...
    export PATH=/usr/local/samba/bin/:/usr/local/samba/sbin:$PATH 

#. Check if none of the services are running::
    
    ps ax | egrep 'samba|smbd|nmdb|winbindd'

#. Create domain::
   
    samba-tool domain provision --use-rfc2307 --interactive
    
#. Copy generated krb5 file to /etc:: 

    mv /etc/krb5.conf /etc/krb5.conf.ORIG
    cp /usr/local/samba/private/krb5.conf /etc/


#. Disable firewal and network-manager ,static address::

    systemctl disable firewalld.service
    systemctl disable NetworkManager
    systemctl stop firewalld.service 
    systemctl stop NetworkManager


#. Disable the interface management from NetworkManager::

    # /etc/sysconfig/network-scripts/ifcfg-enp0s3
    NM_CONTROLLED="no"

#. Add search domain and the host itself as nameserver::
   
    # /etc/resolv.conf
    search example.com
    nameserver <host_ip>

#. Add host.domain to hosts file::

    # /etc/hosts
    127.0.0.1     localhost localhost.localdomain
    <host_ip>     DC1.example.com     DC1

#. Restart network after NetworkManager disabled::

    systemctl restart network

#. Start samba::
   
    samba

#. Tests::
   
    smbclient -L localhost -U%
    host -t SRV _ldap._example.com
    kinit administrator
    klist
    /usr/local/samba/bin/wbinfo -u
    
#. Create systemctl service file::

    # /etc/systemd/system/samba-ad-dc.service
    [Unit]
    Description=Samba Active Directory Domain Controller
    After=network.target remote-fs.target nss-lookup.target

    [Service]
    Type=forking
    ExecStart=/usr/local/samba/sbin/samba -D
    PIDFile=/usr/local/samba/var/run/samba.pid
    ExecReload=/bin/kill -HUP $MAINPID

    [Install]
    WantedBy=multi-user.target

#. Reload daemon and enable::

    systemctl daemon-reload
    systemctl enable samba-ad-dc


Add DnsMasq Cache
-----------------

#. Create an interface to dnsmasq listen (Debian)::

    # /etc/network/interfaces
    ...
    # dnsmasq
    auto lo:0
    iface lo:0 inet static
    address 127.0.0.5

#. For Centos/Rhel::

    # /etc/sysconfig/network-scripts/ifcfg-lo:0
    DEVICE="lo:0"
    BOOTPROTO="static"
    IPADDR="127.0.0.5"
    NETMASK="255.255.255.255"
    ONBOOT="yes"

#. Bring it up::
    
    ifup lo:0
    
#. Create dnsmasq.resolv config file and add nameservers (dns forwarder from current smb.conf)::

    # /etc/dnsmasq.resolv
    # OpenDNS as example
    nameserver 208.67.222.222

#. Install dnsmasq and restrict to only listen on the new loopback interface::
    
    # /etc/dnsmasq.conf
    interface=lo:0
    bind-interfaces
    no-hosts
    resolv-file=/etc/dnsmasq.resolv
    log-facility=/var/log/dnsmasq.log
    cache-size=9999
    # For tests
    #log-queries

#. Restrict primary interfaces to Samba and add Dnsmasq as forwarder::
    
    # /etc/samba/smb.conf
    [global]
    dns forwarder 127.0.0.5
    ...
    # Check which is the primary interface:
    # ip a | grep '<BROADCAST' | awk -F ': ' '{print $2}'
    interfaces = enp0s3 lo  
    bind interfaces only = yes 
    
#. Restart dnsmasq and samba

#. Add dnsmasq to startup

Official site: https://wiki.samba.org/index.php/User_Documentation
