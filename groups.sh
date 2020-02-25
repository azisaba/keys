#!/bin/ash

set -eux

parallel -C ' ' -a src/mapping.txt -j 1 'echo -n {3} | tr : "\x0" | xargs -0 -n 1 adduser {1} || :'
