# samba-ad-dc

Samba4 Active Directory Domain Controller Docker Image

Copy `docker-compose.yml` file, edit it and run:
```
mkdir samba-ad-dc && cd samba-ad-dc
curl https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml \
--output docker-compose.yml
docker-compose up -d
docker-compose exec dc1 samba-tests
```

Or build docker image with latest samba version:
```
git clone https://github.com/diegogslomp/samba-ad-dc
cd samba-ad-dc
docker build --tag diegogslomp/samba-ad-dc .
docker-compose up -d
docker-compose exec dc1 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
