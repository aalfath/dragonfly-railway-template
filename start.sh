#!/bin/sh
# Railway start script for Dragonfly.
# - refuses to start without a password
# - keeps snapshots on the /data volume (every 5 minutes and on shutdown)
# - uses 2 I/O threads by default, because a container sees all of the host's CPUs
# Any Dragonfly flag can be set as a DFLY_<flag> variable, for example DFLY_maxmemory=2gb.
set -e

if [ -z "${DRAGONFLY_PASSWORD}" ]; then
  echo "DRAGONFLY_PASSWORD is empty: refusing to start Dragonfly without a password." >&2
  exit 1
fi

# Passed as environment flags, so the password never shows in the process list.
export DFLY_requirepass="${DRAGONFLY_PASSWORD}"
export DFLY_port="${PORT:-6379}"
export DFLY_dir="${DFLY_dir:-/data}"
export DFLY_dbfilename="${DFLY_dbfilename:-dump}"
export DFLY_snapshot_cron="${DFLY_snapshot_cron:-*/5 * * * *}"
export DFLY_proactor_threads="${DFLY_proactor_threads:-2}"

exec /usr/local/bin/entrypoint.sh dragonfly --logtostderr "$@"
