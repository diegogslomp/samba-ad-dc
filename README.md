# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

## Use [pre-built](https://hub.docker.com/r/diegogslomp/samba-ad-dc) almalinux image

1. Download docker-compose.yml
```
curl -LO https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml
```

2. Start DC and show logs (Ctrl+c to exit)
```
docker-compose up -d && docker-compose logs -f
```

3. Run tests
```
docker-compose exec dc1 samba-tests
```

## Or build almalinux and ubuntu DCs

1. Clone this repo
```
git clone --depth=1 https://github.com/diegogslomp/samba-ad-dc && cd samba-ad-dc
```

2. Build almalinux, ubuntu and rockylinux images
```
docker-compose build
```

3. Start DCs and show logs (Ctrl+c to exit)
```
docker-compose up -d && docker-compose logs -f
```

4. Run tests
```
docker-compose exec dc1 samba-tests
docker-compose exec dc2 samba-tests
docker-compose exec dc3 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
