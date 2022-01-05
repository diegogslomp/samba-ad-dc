# samba-ad-dc

Samba Active Directory Domain Controller Docker Image

Download example file and run docker-compose up:

```
# Create and enter ad folder
mkdir ad && cd ad

# Download docker-compose example file
curl -o docker-compose.yml \
https://raw.githubusercontent.com/diegogslomp/samba-ad-dc/master/docker-compose.yml

# Start DCs and show logs (Ctrl+c to exit)
docker-compose up -d && docker-compose -f

# Test it
docker-compose exec ad_dc1_1 samba-tests
```

Or clone this repo, build your own images and run:

```
# Download repo
git clone https://github.com/diegogslomp/samba-ad-dc ad && cd ad

# Build own centos and ubuntu images
docker build --no-cache --tag diegogslomp/samba-ad-dc:centos -f Dockerfile .
docker build --no-cache --tag diegogslomp/samba-ad-dc:ubuntu -f Dockerfile.ubuntu .

# Copy and edit vars from override file with domain info 
cp docker-compose.override_.yml docker-compose.override.yml

# Start DCs and show logs (Ctrl+c to exit)
docker-compose up -d dc1 && docker-compose logs -f
docker-compose up -d dc2 && docker-compose logs -f

# Test it
docker-compose exec ad_dc1_1 samba-tests
docker-compose exec ad_dc2_1 samba-tests
```

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
