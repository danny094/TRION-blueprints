# Bundle-Struktur: gaming-station.trion-bundle.tar.gz

## Pflichtinhalt jedes Standard-Bundles

```
gaming-station.trion-bundle.tar.gz
├── meta.json               ← Bundle-Metadaten (id, version, package_type)
├── blueprint.yaml          ← Identisch mit blueprints/gaming/gaming-station.yaml
├── package.json            ← Identisch mit packages/gaming-station/package.json
├── package/
│   └── host/
│       ├── bin/
│       │   ├── start-host-sunshine-session.sh
│       │   ├── host-sunshine-xsession.sh
│       │   ├── gaming-station-steam.sh
│       │   └── sunshine-host-prepare.sh
│       ├── config/
│       │   └── sunshine/
│       │       ├── sunshine.conf
│       │       └── apps.json
│       ├── etc/
│       │   └── X11/
│       │       ├── 90-sunshine-headless.conf
│       │       └── Xwrapper.config
│       └── systemd-user/
│           └── sunshine-host.service
└── container_addons/
    └── profiles/
        ├── gaming-station/
        │   ├── 00-profile.md
        │   ├── 10-runtime.md
        │   ├── 20-diagnostics.md
        │   └── 30-known-issues.md
        ├── generic-linux/
        │   └── 00-shell-basics.md
        ├── runtime-supervisord/
        │   └── 10-supervisord.md
        ├── headless-x11-novnc/
        │   └── 10-headless-x11-novnc.md
        ├── apps-sunshine/
        │   └── 20-sunshine.md
        └── apps-steam-headless/
            └── 20-steam-headless.md
```

## meta.json Schema

```json
{
  "id": "gaming-station",
  "name": "Gaming Station",
  "version": "1.0.0",
  "package_type": "composite_addon",
  "trion_compat": { "min": "2.0.0", "max": "3.0.0" },
  "has_host_companion": true,
  "supports_trion_addons": true,
  "created_at": "2026-03-23T00:00:00Z"
}
```

## Wichtige Hinweise für den Installer

- `blueprint.yaml` und `package.json` müssen JSON-sauber sein (keine Python-Tags wie `!!python/object`)
- `container_addons/` wird nach dem Install in den TRION-Addon-Scan-Pfad kopiert
- `package/host/` wird über `storage-host-helper` auf den Host materialisiert
- Live-Host-Dateien unter `~/.config/sunshine/` oder `/etc/X11/` sind NICHT die Quelle — nur `package/host/` ist Source of Truth
