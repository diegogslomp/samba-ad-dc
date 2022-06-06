# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

1. Provision a new domain and start [Almalinux image](https://hub.docker.com/r/diegogslomp/samba-ad-dc)
```
docker run -d --privileged \
  --restart=always --network=host \
  -e REALM='SAMDOM.EXAMPLE.COM' \
  -e SEARCH_DOMAIN='samdom.example.com' \
  -e DOMAIN='SAMDOM' \
  -e ADMIN_PASS='Passw0rd' \
  -e SERVER_ROLE='dc' \
  -e DNS_BACKEND='SAMBA_INTERNAL' \
  -e DNS_FORWARDER='8.8.8.8' \
  -v dc1-samba:/usr/local/samba \
  --name dc1 --hostname DC1 diegogslomp/samba-ad-dc
```

2. Show logs (Ctrl+c to exit) and run tests
```
docker logs dc1 -f
docker exec dc1 samba-tests
```

3. For multiple DCs testing:
```
git clone --depth=1 https://github.com/diegogslomp/samba-ad-dc
cd samba-ad-dc
docker compose build
docker compose up -d
docker compose logs -f
for dc in dc{1,2,3}; do docker compose exec $dc samba-tests; done
```

TODO:

  - [ ] [Sysvol replication workaround](https://wiki.samba.org/index.php/Rsync_based_SysVol_replication_workaround)

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba

Exposed ports: https://wiki.samba.org/index.php/Samba_AD_DC_Port_Usage
