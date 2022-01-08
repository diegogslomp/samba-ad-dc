# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

## Use [pre-built](https://hub.docker.com/r/diegogslomp/samba-ad-dc) centos image

1. Download docker-compose.yml
```
curl -o docker-compose.yml \
https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml
```

2. Start DC and show logs (Ctrl+c to exit)
```
docker-compose up -d && docker-compose logs -f
```

3. Run tests
```
docker-compose exec dc1 samba-tests
```

## Or build centos and ubuntu DCs

1. Clone this repo
```
git clone --depth 1 https://github.com/diegogslomp/django-monitor
```

2. Build centos and ubuntu images
```
docker build --no-cache --tag diegogslomp/samba-ad-dc:centos -f Dockerfile .
docker build --no-cache --tag diegogslomp/samba-ad-dc:ubuntu -f Dockerfile.ubuntu .
```

3. Copy and edit yml file with domain info
```
cp docker-compose.override_.yml docker-compose.override.yml
```

4. Start DCs and show logs (Ctrl+c to exit)
```
docker-compose up -d dc1 && docker-compose logs -f
docker-compose up -d dc2 && docker-compose logs -f
```

5. Run tests
```
docker-compose exec dc1 samba-tests
docker-compose exec dc2 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
