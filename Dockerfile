FROM centos:8

RUN yum update -y
RUN yum install epel-release -y
RUN yum install dnf-plugins-core -y
RUN yum config-manager --set-enabled powertools

RUN yum install docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel \
  keyutils-libs-devel krb5-workstation libacl-devel libaio-devel \
  libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools \
  libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl \
  perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography \
  python3-dns python3-gpg python36-devel readline-devel rpcgen systemd-devel \
  tar zlib-devel bind-utils flex dbus-devel libtirpc-devel python3-markdown -y && \
  yum clean all

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
  make install

WORKDIR /usr/local/samba/sbin
COPY provision-and-start.sh provision-and-start
RUN chmod +x provision-and-start
COPY samba-tests.sh samba-tests
RUN chmod +x samba-tests

CMD provision-and-start
EXPOSE 137/udp 138/udp 139 445
