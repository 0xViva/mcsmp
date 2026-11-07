#!/bin/sh
# Restart the mcsmp server (clean save on stop, then start again).
set -eu

systemctl --user restart mcsmp.service
echo "mcsmp restarted"
