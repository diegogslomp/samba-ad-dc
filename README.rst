samba-ad-dc-dnsmasq
===================

Add cache and multiple forwarders to samba4  (Samba Internal DNS Back End + Dnsmasq)

#. Create an interface to dnsmasq listen (Debian)::

    # /etc/network/interfaces
    ...
    # dnsmasq
    auto lo:0
    iface lo:0 inet static
    address 127.0.0.5

# If Centos/Rhel server::

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

#. Install dnsmasq and restrict to only listen on IP 127.0.0.5::
    
    # /etc/dnsmasq.conf
    listen-address=127.0.0.5
    bind-interfaces
    resolv-file=/etc/dnsmasq.resolv
    log-facility=/var/log/dnsmasq.log
    cache-size=9999

#. Restrict primary interfaces to Samba and add Dnsmasq as forwarder::
    
    # /etc/samba/smb.conf
    [global]
    dns forwarder 127.0.0.5
    ...
    interfaces = eth0 lo  
    bind interfaces only = yes 
    
#. Restart Dnsmasq + Samba

#. Add dnsmasq to startup
