#!/bin/ash

set -eux

chmod -c 777 /srv/azifry/data/resourcepacks
chmod -c 666 /srv/azifry/data/resourcepacks/*.zip
setfacl -d -m u::rwX,g::rwX,o::rwX /srv/azifry/data/resourcepacks

chmod -c 600 /srv/azifry/secrets/*

parallel -j 1 'addgroup -S {/} || :' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 chmod -c g+s' ::: /opt/minecraft/*
parallel 'chgrp -Rc {/} {}' ::: /opt/minecraft/*
parallel 'chmod -c o-rwx {}' ::: /opt/minecraft/*
parallel 'chmod -Rc g+w {}' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 setfacl -d -m u::rwX,g::rwX,o::rX' ::: /opt/minecraft/*

chmod -c 700 /srv/discord/colorful-discord
chmod -c 700 /srv/discord/support
