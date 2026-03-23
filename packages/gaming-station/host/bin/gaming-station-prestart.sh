#!/usr/bin/env bash
# gaming-station-prestart.sh
# Bereinigt stale Lock-/Singleton-/PID-Artefakte im persistenten Steam-Home
# bevor Steam startet. Konservativ — keine Library, keine Saves, keine Login-Daten.
set -euo pipefail

STEAM_HOME="${STEAM_HOME:-/home/default/.steam}"
CEF_CACHE="${STEAM_HOME}/steam/ubuntu12_32/steamwebhelper"

log() { echo "[prestart] $*"; }

# ── 1. Chromium/CEF Singleton Locks ──────────────────────────────────────────
for base in \
  "${STEAM_HOME}/steam/config" \
  "${STEAM_HOME}/steam/ubuntu12_32" \
  "${STEAM_HOME}/.local/share/Steam" \
  "/home/default/.local/share/Steam/config" \
  "/home/default/.local/share/Steam/ubuntu12_32"; do
  for artifact in SingletonLock SingletonCookie SingletonSocket; do
    target="${base}/${artifact}"
    if [ -e "${target}" ] || [ -L "${target}" ]; then
      rm -f "${target}"
      log "removed: ${target}"
    fi
  done
done

# ── 2. Stale .lock Dateien in CEF/Chromium-Profil-Ordnern ────────────────────
for lockfile in \
  "${STEAM_HOME}/steam/config/.lock" \
  "${STEAM_HOME}/steam/ubuntu12_32/.lock" \
  "/home/default/.local/share/Steam/config/.lock"; do
  if [ -e "${lockfile}" ]; then
    rm -f "${lockfile}"
    log "removed: ${lockfile}"
  fi
done

# ── 3. Stale PID-Dateien ─────────────────────────────────────────────────────
for pidfile in \
  "/tmp/steam.pid" \
  "/tmp/steamwebhelper.pid"; do
  if [ -e "${pidfile}" ]; then
    rm -f "${pidfile}"
    log "removed: ${pidfile}"
  fi
done

# ── 4. Stale X11/Unix Sockets von alten Steam-Prozessen ──────────────────────
for sock in /tmp/.steam-*; do
  if [ -S "${sock}" ]; then
    rm -f "${sock}"
    log "removed socket: ${sock}"
  fi
done

log "prestart cleanup done"
