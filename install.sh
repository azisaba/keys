#!/bin/sh

set -eux

parallel -C ' ' -a mapping.txt -j 1 'adduser -D -h {2} {1}'
parallel -C ' ' -a mapping.txt -j 1 'printf "$(openssl rand -base64 15)\n%.0s" 1 2 | passwd {1}'
parallel -C ' ' -a mapping.txt -j 1 'echo -n {3} | tr : "\x0" | xargs -0 -n 1 adduser {1}'
