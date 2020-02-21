#!/bin/ash

set -eux

parallel -C ' ' -a src/mapping.txt -j 1 'adduser -D -h {2} {1} || true'
parallel -C ' ' -a src/mapping.txt -j 1 'printf "$(openssl rand -base64 15)\n%.0s" 1 2 | passwd {1}'
parallel -C ' ' -a src/mapping.txt -j 1 'echo -n {3} | tr : "\x0" | xargs -0 -n 1 adduser {1} || true'

parallel -C ' ' -a src/mapping.txt 'mkdir -p {2}/.ssh'
parallel -C ' ' -a src/mapping.txt 'chmod -c 700 {2}/.ssh'
parallel -C ' ' -a src/mapping.txt 'touch {2}/.ssh/authorized_keys'
parallel -C ' ' -a src/mapping.txt 'chmod -c 600 {2}/.ssh/authorized_keys'
parallel -C ' ' -a src/mapping.txt 'cp -f keys/{1}.keys {2}/.ssh/authorized_keys'
parallel -C ' ' -a src/mapping.txt 'chown -Rc {1}: {2}/.ssh'

parallel -C ' ' -a src/mapping.txt '{4} && ln -nfs /opt/resourcepacks {2}/resourcepacks || true'
parallel -C ' ' -a src/mapping.txt '{4} && ln -nfs /opt/minecraft/lgw/plugins {2}/lgwplugins || true'
parallel -C ' ' -a src/mapping.txt '{4} && ln -nfs /opt/minecraft {2}/server || true'
parallel -C ' ' -a src/mapping.txt '{4} && find {2} -mindepth 1 -maxdepth 1 -type l -print0 | xargs -0 chown -hc {1}: || true'
