# samba-ad-dc

[![dockerhub](https://img.shields.io/docker/v/diegogslomp/samba-ad-dc)](https://hub.docker.com/r/diegogslomp/samba-ad-dc)
[![gh-actions](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/almalinux-image.yml/badge.svg)](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/almalinux-image.yml)
[![gh-actions](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/rockylinux-image.yml/badge.svg)](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/rockylinux-image.yml)
[![gh-actions](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/debian-image.yml/badge.svg)](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/debian-image.yml)
[![gh-actions](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/ubuntu-image.yml/badge.svg)](https://github.com/diegogslomp/samba-ad-dc/actions/workflows/ubuntu-image.yml)

Samba Active Directory Domain Controller Docker Image

Provision a new domain on Linux
```
docker run -d --privileged \
  --restart=unless-stopped --network=host \
  -e REALM='SAMDOM.EXAMPLE.COM' \
  -e DOMAIN='SAMDOM' \
  -e ADMIN_PASS='Passw0rd' \
  -e DNS_FORWARDER='8.8.8.8' \
  -v dc1_etc:/usr/local/samba/etc \
  -v dc1_private:/usr/local/samba/private \
  -v dc1_var:/usr/local/samba/var \
  --name dc1 --hostname DC1 diegogslomp/samba-ad-dc
```

On Windows Powershell (there's no network host mode so docker ip delivered)
```
docker run -d --privileged `
  --restart=unless-stopped `
  -e REALM='SAMDOM.EXAMPLE.COM' `
  -e DOMAIN='SAMDOM' `
  -e ADMIN_PASS='Passw0rd' `
  -e DNS_FORWARDER='8.8.8.8' `
  -e BIND_NETWORK_INTERFACES=false `
  -v dc1_etc:/usr/local/samba/etc `
  -v dc1_private:/usr/local/samba/private `
  -v dc1_var:/usr/local/samba/var `
  --name dc1 --hostname DC1 diegogslomp/samba-ad-dc
````
Show logs and run tests
```
docker logs dc1 -f
docker exec dc1 samba-tests
```

For external access on Linux, update the `/etc/resolv.conf` and `/etc/hosts` from your host, replacing `host_ip`
```
# /etc/resolv.conf
search samdom.example.com
nameserver host_ip

# /etc/hosts
127.0.0.1     localhost
host_ip       DC1.samdom.example.com     DC1
```

For multiple dc testing (no external access)
```
git clone --single-branch https://github.com/diegogslomp/samba-ad-dc
cd samba-ad-dc
docker compose build
docker compose up -d
docker compose logs -f
for dc in dc{1,2,3,4}; do docker compose exec $dc samba-tests; done
```

To-Do
 - [Sysvol replication workaround](https://wiki.samba.org/index.php/Rsync_based_SysVol_replication_workaround)

Links
 - [Setting up](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller)
 - [Dependencies](https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba)
 - [Exposed ports](https://wiki.samba.org/index.php/Samba_AD_DC_Port_Usage)
