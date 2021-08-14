# samba-ad-dc

Samba4 Active Directory Domain Controller Docker Image

Copy and edit `docker-compose.yml`:
```
mkdir samba-ad-dc && cd samba-ad-dc
curl -o docker-compose.yml \
https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml

```

Or clone this repo and build latest samba:
```
git clone https://github.com/diegogslomp/samba-ad-dc
cd samba-ad-dc
docker build --no-cache --tag diegogslomp/samba-ad-dc .
```

Run domain provision, start samba daemon and test it:
```
docker-compose up -d
docker-compose exec samba-ad-dc_dc1_1 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
