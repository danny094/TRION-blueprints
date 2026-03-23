#!/usr/bin/env bash
# gaming-station-entrypoint.sh
# Führt Stale-Lock-Cleanup durch, dann übergibt an Original-Entrypoint des Basisimages.
set -euo pipefail

echo "[entrypoint] gaming-station prestart cleanup..."
/usr/local/bin/gaming-station-prestart.sh

echo "[entrypoint] handing off to /entrypoint.sh $*"
exec /entrypoint.sh "$@"
