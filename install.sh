#!/bin/sh

set -eux

parallel -C ' ' -a mapping.txt -j 1 'adduser -D -h {2} {1}'
parallel -C ' ' -a mapping.txt -j 1 'printf "$(openssl rand -base64 15)\n%.0s" 1 2 | passwd {1}'
parallel -C ' ' -a mapping.txt -j 1 'echo -n {3} | tr : "\x0" | xargs -0 -n 1 adduser {1}'
parallel -C ' ' -a mapping.txt 'mkdir -p {2}/.ssh'
parallel -C ' ' -a mapping.txt 'chmod -c 700 {2}/.ssh'
parallel -C ' ' -a mapping.txt 'touch {2}/.ssh/authorized_keys'
parallel -C ' ' -a mapping.txt 'chmod -c 600 {2}/.ssh/authorized_keys'
parallel -C ' ' -a mapping.txt 'curl -o {2}/.ssh/authorized_keys https://raw.githubusercontent.com/AzisabaNetwork/azisabash/master/key/{1}.keys'
parallel -C ' ' -a mapping.txt 'chown -Rc {1}: {2}/.ssh'
