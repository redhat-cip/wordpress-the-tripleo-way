#!/bin/bash

set -eu
set -o pipefail


repos="diskimage-builder tripleo-image-elements
           heat-templates dib-utils"

[ -d repos ] || mkdir repos
(
    cd repos
    for repo in ${repos}; do
        [ -d ${repo} ] || git clone git://github.com/openstack/${repo}
    done
)

ELEMENTS_PATH=$PWD/elements:\
$PWD/repos/diskimage-builder/elements:\
$PWD/repos/heat-templates/hot/software-config/elements:\
$PWD/repos/tripleo-image-elements/elements:
PATH=$PWD/repos/diskimage-builder/bin:$PWD/repos/dib-utils/bin:$PATH

export ELEMENTS_PATH
export PATH


# Delete stack if already exist
if [ `heat stack-list | grep wordpress | wc -l` -gt 0 ]; then
	heat stack-delete wordpress
fi

# Create MariaDB Image
./repos/diskimage-builder/bin/disk-image-create -o mariadb \
    fedora \
    selinux-permissive \
    heat-cfntools \
    os-apply-config \
    os-collect-config \
    vm \
    stackuser \
    heat-config \
    heat-config-script \
    mariadb-solo

# If MariaDB Image exist then delete it
if [ `glance image-list --name mariadb | grep mariadb | wc -l` -gt 0 ]; then
	glance image-delete mariadb
fi

# Upload MariaDB Image
glance image-create --name mariadb --disk-format qcow2 --file mariadb.qcow2 --container-format bare

# Create Wordpress Image
./repos/diskimage-builder/bin/disk-image-create -o wordpress \
    fedora \
    selinux-permissive \
    heat-cfntools \
    os-apply-config \
    os-collect-config \
    vm \
    stackuser \
    heat-config \
    heat-config-script \
    wordpress

# If Wordpress image exist then delete it
if [ `glance image-list --name mariadb | grep mariadb | wc -l` -gt 0 ]; then
	glance image-delete wordpress
fi

# Upload Wordpress Image
glance image-create --name wordpress --disk-format qcow2 --file wordpress.qcow2 --container-format bare

# Finally create the stack with uploaded images
heat stack-create -f heat.yaml wordpress

