samba-ad-dc
===========

Run docker container::

    docker run -d --privileged --hostname DC1 --name dc1 diegogslomp/samba-ad-dc
    docker exec -it dc1 samba-tests
    # ADMIN_PASS Passw0rd

Or clone, build and run with docker-compose::

    git clone https://github.com/diegogslomp/samba-ad-dc
    cd samba-ad-dc
    docker-compose build
    docker-compose up
    docker-compose exec dc1 samba-tests

Official site: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller

Dependencies: https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
