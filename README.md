# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

Create a folder, copy/edit `docker-compose.yml` and run:

```
mkdir samba-ad-dc && cd samba-ad-dc
curl -o docker-compose.yml \
https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml
docker-compose up -d
docker-compose exec samba-ad-dc_dc1_1 samba-tests
```

Or clone this repo, build images and run:

```
git clone https://github.com/diegogslomp/samba-ad-dc
cd samba-ad-dc
docker build --no-cache --tag diegogslomp/samba-ad-dc:centos -f Dockerfile .
docker build --no-cache --tag diegogslomp/samba-ad-dc:ubuntu -f Dockerfile.ubuntu .
cp docker-compose.override_.yml docker-compose.override.yml
docker-compose up -d dc1 && docker-compose logs -f
docker-compose up -d dc2 && docker-compose logs -f
docker-compose exec samba-ad-dc_dc1_1 samba-tests
docker-compose exec samba-ad-dc_dc2_1 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
