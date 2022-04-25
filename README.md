# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

Run [Almalinux image](https://hub.docker.com/r/diegogslomp/samba-ad-dc)
```
docker run -d --restart=always --privileged -e REALM='SAMDOM.EXAMPLE.COM' -e SEARCH_DOMAIN='samdom.example.com' -e DOMAIN='SAMDOM' -e ADMIN_PASS='Passw0rd' -e SERVER_ROLE='dc' -e DNS_BACKEND='SAMBA_INTERNAL' -e DNS_FORWARDER='8.8.8.8' -v samba:/usr/local/samba -p 389:389 -p 137/udp -p 138/udp -p 445:445 --name dc1 diegogslomp/samba-ad-dc
```

Show logs (Ctrl+c to exit) and run tests
```
docker logs dc1 -f
docker exec dc1 samba-tests
```

For multiple DCs testing:
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
