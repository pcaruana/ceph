#!/bin/bash
#
# Copyright (C) 2014 Red Hat <contact@redhat.com>
#
# Author: Loic Dachary <loic@dachary.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library Public License for more details.
#
source test/docker-test-helper.sh

supported='([ubuntu]="14.04" [centos]="centos7")'
main_docker "$@" --all "$supported" --compile
main_docker "$@" --all "$supported" --user root --dev test/ceph-disk.sh test_activate_dev

# Local Variables:
# compile-command: "cd ../.. ; make -j4 && test/osd/ceph-disk-root.sh"
# End:
