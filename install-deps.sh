#!/bin/bash
#
# Ceph distributed storage system
#
# Copyright (C) 2014 Red Hat <contact@redhat.com>
#
# Author: Loic Dachary <loic@dachary.org>
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
DIR=/tmp/install-deps.$$
trap "rm -fr $DIR" EXIT
mkdir -p $DIR

if which apt-get > /dev/null ; then
    sudo apt-get install -y dpkg-dev
    touch $DIR/status
    packages=$(dpkg-checkbuilddeps --admindir=$DIR debian/control 2>&1 | \
        perl -p -e 's/.*Unmet build dependencies: *//;' \
            -e 's/build-essential:native/build-essential/;' \
            -e 's/\(.*?\)//g;' \
            -e 's/ +/\n/g;' | sort)
    sudo apt-get install -y $packages
elif which yum > /dev/null ; then
    sudo yum install -y yum-utils
    sed -e 's/@//g' < ceph.spec.in > $DIR/ceph.spec
    sudo yum-builddep -y $DIR/ceph.spec
else
    cat >&2 <<EOF
$(lsb_release -si) does have yum(1) or apt-get(1) installed,
dependencies will have to be installed manually.
EOF
fi
