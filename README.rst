samba-ad-dc-dnsmasq
===================

Add cache and multiple forwarders to samba4  (Samba Internal DNS Back End + Dnsmasq)

#. Create an interface to dnsmasq listen::

    # /etc/network/interfaces
    ...
    # dnsmasq
    auto lo:0
    iface lo:0 inet static
    address 127.0.0.5

#. Bring it up::
    
    ifup lo:0
    
#. Create dnsmasq.resolv config file and add nameservers (dns forwarder from current smb.conf)::

    # /etc/dnsmasq.resolv
    # OpenDNS as example
    nameserver 208.67.222.222

#. Install dnsmasq and restrict to only listen on IP 127.0.0.5 (and nothing else)::
    
    # /etc/dnsmasq.conf
    interface=lo:0
    resolv-file=/etc/dnsmasq.resolv
    cache = 9999
    log-facility=/var/log/dnsmasq.log
    # For tests
    #log-queries

#. Restrict primary interfaces to Samba and add Dnsmasq as forwarder::
    
    # /etc/samba/smb.conf
    [global]
    dns forwarder 127.0.0.5
    ...
    interfaces = eth0 lo  
    bind interfaces only = yes 
    
#. Restart Samba + Dnsmasq
