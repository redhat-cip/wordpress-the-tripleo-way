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

ELEMENTS_PATH=$PWD/repos/diskimage-builder/elements:\
$PWD/repos/heat-templates/hot/software-config/elements:\
$PWD/repos/tripleo-image-elements/elements:\
$PWD/elements
PATH=$PWD/repos/diskimage-builder/bin:$PWD/repos/dib-utils/bin:$PATH

export ELEMENTS_PATH
export PATH



#./repos/diskimage-builder/bin/disk-image-create -o mariadb \
#    fedora \
#    selinux-permissive \
#    heat-cfntools \
#    os-apply-config \
#    os-collect-config \
#    vm \
#    stackuser \
#    heat-config \
#    heat-config-script \
#    mariadb

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


#glance image-create --name mariadb --disk-format qcow2 --file mariadb.qcow2 --container-format bare

glance image-create --name wordpress --disk-format qcow2 --file wordpress.qcow2 --container-format bare
