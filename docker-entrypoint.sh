#!/bin/sh
set -e

if [ ! -f /data/config.yaml ]; then
    cp /config-defaults.yaml /data/config.yaml
fi

exec "$@"
