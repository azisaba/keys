#!/bin/sh

set -eux

chmod -c 700 /srv/discord/logger
chmod -c 700 /srv/discord/support

chmod -c 755 /opt/resourcepacks
chmod -c 666 /opt/resourcepacks/*.zip
setfacl -d -m u::rwX,g::rwX,o::rwX /opt/resourcepacks

parallel -j 1 'addgroup -S {/}' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 chmod -c g+s' ::: /opt/minecraft/*
parallel 'chgrp -Rc {/} {}' ::: /opt/minecraft/*
parallel 'chmod -c o-rwx {}' ::: /opt/minecraft/*
parallel 'chmod -Rc g+w {}' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 setfacl -d -m u::rwX,g::rwX,o::rX' ::: /opt/minecraft/*
