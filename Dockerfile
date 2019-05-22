FROM centos:7

RUN yum install epel-release -y
RUN yum install wget attr bind-utils docbook-style-xsl gcc gdb \
  krb5-workstation libsemanage-python libxslt perl perl-ExtUtils-MakeMaker \
  perl-Parse-Yapp perl-Test-Base pkgconfig policycoreutils-python \
  python-crypto gnutls-devel libattr-devel keyutils-libs-devel libacl-devel \
  libaio-devel libblkid-devel libxml2-devel openldap-devel pam-devel \
  popt-devel readline-devel zlib-devel systemd-devel \
  python python-devel python36 python36-devel \
  lmdb-devel jansson-devel gpgme-devel pygpgme libarchive-devel -y

ARG SMB_VERSION

WORKDIR /usr/local/src/
RUN wget https://download.samba.org/pub/samba/samba-${SMB_VERSION}.tar.gz && \
  mkdir samba && \
  tar zxvf samba-${SMB_VERSION}.tar.gz -C samba --strip-components=1

WORKDIR /usr/local/src/samba/
RUN ./configure && \
  make -j 3 && \
  make install

RUN rm -rf /usr/local/src/samba-${SMB_VERSION}.tar.gz

ENV PATH /usr/local/samba/bin:/usr/local/samba/sbin:$PATH
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_NUMERIC en_GB.UTF-8
ENV LC_TIME en_GB.UTF-8
ENV LC_COLLATE en_GB.UTF-8
ENV LC_MONETARY en_GB.UTF-8
ENV LC_MESSAGES en_GB.UTF-8

COPY domain-provision.sh /usr/local/samba/sbin/domain-provision
CMD domain-provision

EXPOSE 137/udp 138/udp 139 445
