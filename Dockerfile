FROM centos:7

RUN yum install epel-release -y
RUN yum install wget attr bind-utils \
        docbook-style-xsl gcc gdb krb5-workstation \
        libsemanage-python libxslt perl perl-ExtUtils-MakeMaker \
        perl-Parse-Yapp perl-Test-Base pkgconfig policycoreutils-python \
        python-crypto gnutls-devel libattr-devel keyutils-libs-devel \
        libacl-devel libaio-devel libblkid-devel libxml2-devel openldap-devel \
        pam-devel popt-devel python-devel readline-devel zlib-devel systemd-devel \
        lmdb-devel jansson-devel gpgme-devel pygpgme libarchive-devel -y

WORKDIR /usr/local/src/

ENV SMB_VERSION 4.9.8

RUN wget https://download.samba.org/pub/samba/samba-${SMB_VERSION}.tar.gz && \
    mkdir samba && \
    tar zxvf samba-${SMB_VERSION}.tar.gz -C samba --strip-components=1

WORKDIR /usr/local/src/samba/

RUN ./configure && \
    make -j 3 && \
    make install

ENV PATH "/usr/local/samba/bin:/usr/local/samba/sbin:$PATH"

CMD samba-tool

EXPOSE 137/udp 138/udp 139 445
