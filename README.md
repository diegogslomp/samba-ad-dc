# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

## Use [pre-built](https://hub.docker.com/r/diegogslomp/samba-ad-dc) Almalinux image

Download [docker-compose.yml](https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml) file, start the domain controller, show logs (Ctrl+c to exit) and run tests
```
curl -LO https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml
docker-compose up -d
docker-compose logs -f
docker-compose exec dc1 samba-tests
```

## Or build Almalinux, Ubuntu and Rockylinux DCs

Clone this repo, build images, start DCs, show logs (Ctrl+c to exit) and run tests
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
