samba-ad-dc-centos7-install
===========================

#. Update and install shh epel bash-completion (Optional)::
   
    yum update -y
    yum install openssh-server wget epel-release bash-completion -y

#. Samba dependences::
   
    yum install attr bind-utils docbook-style-xsl gcc gdb krb5-workstation libsemanage-python libxslt perl perl-ExtUtils-MakeMaker perl-Parse-Yapp perl-Test-Base pkgconfig policycoreutils-python python-crypto gnutls-devel libattr-devel keyutils-libs-devel libacl-devel libaio-devel libblkid-devel libxml2-devel openldap-devel pam-devel popt-devel python-devel readline-devel zlib-devel systemd-devel -y

#. Download and install from source::
   
    cd /usr/local/src/
    wget https://download.samba.org/pub/samba/stable/samba-4.8.1.tar.gz
    tar zxvf samba-4.8.1.tar.gz 
    cd /usr/local/src/samba-4.8.1/
    ./configure
    make -j 3
    make install

#. TODO: Add /usr/local/samba/bin and sbin to PATH::
   
    vim /root/.bash_profile 

#. None of them must berunning::
    
    ps ax | egrep 'samba|smbd|nmdb|winbindd'

#. Copy generated krb5 file to /etc:: 

    mv /etc/krb5.conf /etc/krb5.conf.ORIG
    cp /usr/local/samba/private/krb5.conf /etc/

#. Create domain::
   
    samba-tool domain provision --use-rfc2307 --interactive

#. Disable firewal and network-manager ,static address::

    systemctl disable firewalld.service
    systemctl stop firewalld.service 
    systemctl stop NetworkManager
    systemctl disable NetworkManager

#. TODO: Add NM_CONTROLLED="no" to ifcfg-enp0s3::
   
    vim /etc/sysconfig/network-scripts/ifcfg-enp0s3

#. TODO: Add domain and nameservers::
   
    vim /etc/resolv.conf

#. TODO: Add host.domain::
   
    vim /etc/hosts

#. Enable network after NetworkManager disabled::

    systemctl enable network
    systemctl restart network

#. Start samba::
   
    samba

#. Tests::
   
    smbclient -L localhost -U%
    host -t SRV _ldap._example.com
    kinit administrator
    klist
    /usr/local/samba/bin/wbinfo -u
