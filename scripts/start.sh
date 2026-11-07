#!/bin/sh
# Start the mcsmp server.
set -eu

systemctl --user start mcsmp.service
echo "mcsmp started"
