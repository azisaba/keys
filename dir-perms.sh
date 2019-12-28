#!/bin/sh

set -eux

chmod -Rc 777 /opt/resourcepacks
chmod -c 700 /opt/logger
chmod -c 700 /opt/support

parallel -j 1 'addgroup -S {/}' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 chmod -c g+s' ::: /opt/minecraft/*
parallel 'chgrp -Rc {/} {}' ::: /opt/minecraft/*
parallel 'chmod -c o-rwx {}' ::: /opt/minecraft/*
parallel 'chmod -Rc g+w {}' ::: /opt/minecraft/*
parallel 'find {} -type d -print0 | xargs -0 setfacl -d -m u::rwX,g::rwX,o::rX' ::: /opt/minecraft/*
