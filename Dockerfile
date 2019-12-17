FROM centos:8

RUN yum update -y
RUN yum install epel-release -y
RUN yum install dnf-plugins-core -y
RUN yum config-manager --set-enabled PowerTools

RUN yum install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel \
    keyutils-libs-devel krb5-workstation libacl-devel libaio-devel \
    libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools \
    libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl \
    perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography \
    python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel \
    tar zlib-devel bind-utils -y

ENV SMB_VERSION latest

ENV SERVER_IP 10.99.0.1
ENV SERVER_ROLE dc
ENV SERVER_HOSTNAME DC1
ENV DNS_BACKEND SAMBA_INTERNAL
ENV REALM SAMDOM.EXAMPLE.COM
ENV SEARCH_DOMAIN samdom.example.com
ENV DOMAIN SAMDOM
ENV ADMIN_PASS Passw0rd
ENV DNS_FORWARDER 8.8.8.8

ENV PATH /usr/local/samba/bin:/usr/local/samba/sbin:$PATH

ENV LC_CTYPE C.UTF-8
ENV LC_MESSAGES C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /usr/local/src/
RUN curl -O https://download.samba.org/pub/samba/samba-${SMB_VERSION}.tar.gz && \
  mkdir samba && \
  tar zxvf samba-${SMB_VERSION}.tar.gz -C samba --strip-components=1

WORKDIR /usr/local/src/samba/
RUN ./configure && \
  make -j 3 && \
  make install

RUN rm -rf /usr/local/src/samba-${SMB_VERSION}.tar.gz

COPY domain-provision.sh /usr/local/samba/sbin/domain-provision
CMD domain-provision

EXPOSE 137/udp 138/udp 139 445
