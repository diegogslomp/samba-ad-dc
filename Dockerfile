FROM almalinux:8

RUN yum update -y && \
  yum install epel-release -y && \
  yum install dnf-plugins-core -y && \
  yum config-manager --set-enabled powertools && \
  yum install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel \
  keyutils-libs-devel krb5-workstation libacl-devel libaio-devel \
  libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools \
  libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl \
  perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography \
  python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel \
  tar zlib-devel \
  bind-utils flex dbus-devel libtirpc-devel python3-markdown bison perl-JSON iproute -y && \
  yum clean all -y

ENV SMB_VERSION latest
ENV PATH /usr/local/samba/bin:/usr/local/samba/sbin:$PATH
ENV LC_CTYPE C.UTF-8
ENV LC_MESSAGES C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /usr/local/src/
RUN curl -O https://download.samba.org/pub/samba/samba-$SMB_VERSION.tar.gz && \
  mkdir samba && \
  tar zxvf samba-$SMB_VERSION.tar.gz -C samba --strip-components=1 && \
  rm -rf samba-$SMB_VERSION.tar.gz

WORKDIR /usr/local/src/samba/
RUN ./configure && \
  make -j 3 && \
  make install && \
  rm -rf /usr/local/src/samba

WORKDIR /usr/local/sbin
COPY sbin /usr/local/sbin
CMD bash -c "samba-domain-provision && samba -F"
EXPOSE 137/udp 138/udp 139 445
