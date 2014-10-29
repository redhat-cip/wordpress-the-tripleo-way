# Example of Wordpress installation, using the TripleO way

* DiskImage-Builder <https://github.com/openstack/diskimage-builder>
* os-apply-config <https://github.com/openstack/os-apply-config> tools
* Heat

# How to start

`build_image.sh` will:

1. fetch the different tools
2. generate the MariaDB and Apache host images
3. inject the images in Glance
4. call Heat

    > source ~/openrc
    > ./build_image.sh
