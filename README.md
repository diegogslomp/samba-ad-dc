# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

1. Provision a new domain and start [Almalinux image](https://hub.docker.com/r/diegogslomp/samba-ad-dc) DC
```
docker run -d --restart=always --privileged \
  -e REALM='SAMDOM.EXAMPLE.COM' \
  -e SEARCH_DOMAIN='samdom.example.com' \
  -e DOMAIN='SAMDOM' \
  -e ADMIN_PASS='Passw0rd' \
  -e SERVER_ROLE='dc' \
  -e DNS_BACKEND='SAMBA_INTERNAL' \
  -e DNS_FORWARDER='8.8.8.8' \
  -p 53:53 -p 53:53/udp \
  -p 88:88 -p 88:88/udp \
  -p 123:123/udp -p 137:137/udp -p 138:138/udp \
  -p 139:139 -p 389:389 -p 389:389/udp \
  -p 445:445 -p 464:464 -p 464:464/udp \
  -p 636:636 -p 3268:3268 -p 3269:3269 \
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
docker-compose build
docker-compose up -d
docker-compose logs -f
for dc in dc{1,2,3}; do docker-compose exec $dc samba-tests; done
```

TODO: 

  - [ ] [Sysvol replication workaround](https://wiki.samba.org/index.php/Rsync_based_SysVol_replication_workaround)
  
Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba

Exposing ports: https://wiki.samba.org/index.php/Samba_AD_DC_Port_Usage
