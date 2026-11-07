#!/bin/sh
# Install the systemd/Quadlet units from this repo into the user's config dirs.
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

mkdir -p "$HOME/.config/containers/systemd" "$HOME/.config/systemd/user"

install -m 0644 "$ROOT/units/mcsmp.container"       "$HOME/.config/containers/systemd/mcsmp.container"
install -m 0644 "$ROOT/units/mcsmp-backup.service"  "$HOME/.config/systemd/user/mcsmp-backup.service"
install -m 0644 "$ROOT/units/mcsmp-backup.timer"    "$HOME/.config/systemd/user/mcsmp-backup.timer"
install -m 0644 "$ROOT/units/mcsmp-snapshot.service" "$HOME/.config/systemd/user/mcsmp-snapshot.service"
install -m 0644 "$ROOT/units/mcsmp-snapshot.timer"  "$HOME/.config/systemd/user/mcsmp-snapshot.timer"

chmod +x "$ROOT/scripts/"*.sh "$ROOT/scripts/"*.py "$ROOT/console"
systemctl --user daemon-reload

cat <<EOF
units installed.

  build:  podman build -t localhost/mcsmp-server:25 "$ROOT/container"
  start:  systemctl --user start mcsmp
  enable: systemctl --user enable mcsmp-backup.timer mcsmp-snapshot.timer
          (the Quadlet mcsmp unit is enabled by its [Install] section)

The playit agent is shared with atm11 (units/playit.service in that repo).
Create the second tunnel with: "$ROOT/scripts/playit-tunnel.py" create
EOF
