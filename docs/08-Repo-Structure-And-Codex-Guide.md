# TRION Blueprints — Repo-Struktur

## Verzeichnisbaum

```
TRION-blueprints/
│
├── index.json                          ← Zentraler Katalog (TRION liest hier rein)
│
├── blueprints/                         ← Container-YAMLs (blueprint_type: blueprint)
│   ├── automation/
│   │   └── n8n-automation.yaml
│   ├── data-science/
│   │   └── jupyter-datascience.yaml
│   ├── development/
│   │   ├── postgres-db.yaml
│   │   ├── pgadmin.yaml
│   │   └── redis-cache.yaml
│   ├── gaming/
│   │   └── gaming-station.yaml         ← composite_addon Blueprint
│   └── media/
│       ├── ffmpeg-processor.yaml
│       └── whisper-stt.yaml
│
├── packages/                           ← Paketdefinitionen für composite_addons
│   └── gaming-station/
│       ├── package.json                ← host_companion, storage, postchecks, addons
│       ├── README.md
│       └── host/
│           ├── bin/                    ← Helper-Scripts (Source of Truth)
│           ├── config/sunshine/        ← Sunshine-Konfiguration
│           ├── etc/X11/               ← Xorg-Konfiguration
│           └── systemd-user/          ← sunshine-host.service
│
├── container_addons/                   ← TRION Shell Wissens-Dokumente
│   ├── ADDON_SPEC.md                   ← Schema + Loader-Beschreibung
│   └── profiles/
│       ├── gaming-station/             ← Container-spezifisch
│       │   ├── 00-profile.md
│       │   ├── 10-runtime.md
│       │   ├── 20-diagnostics.md
│       │   └── 30-known-issues.md
│       ├── generic-linux/              ← Generisch / wiederverwendbar
│       ├── runtime-supervisord/
│       ├── headless-x11-novnc/
│       ├── apps-sunshine/
│       └── apps-steam-headless/
│
├── bundles/                            ← Installierbare .trion-bundle.tar.gz
│   ├── BUNDLE_SPEC.md                  ← Bundle-Format-Beschreibung
│   └── gaming-station.trion-bundle.tar.gz  ← (wird vom Installer gebaut)
│
└── docs/                               ← Entwickler-Dokumentation
    ├── 00-Index.md
    ├── 01-Frontend-Commander-Fixes.md
    ├── 02-Gaming-Station-Storage-Sunshine-noVNC.md
    ├── 03-TRION-Shell-Mode.md
    ├── 04-Container-Addons.md
    ├── 05-Open-Issues-Next-Steps.md
    ├── 06-Gaming-Station-Setup-Guide.md
    └── 07-Gaming-Station-GitHub-Package-Prep.md
```

## Was Codex als nächstes im Installer umsetzen muss

### 1. `package_type` erkennen
```python
if blueprint["package_type"] == "composite_addon":
    load_package_json(blueprint["package_url"])
    run_host_companion_install()
    install_container_addons()
```

### 2. Host-Companion installieren
- Scripts aus `package/host/bin/` → `~/.local/bin/` (executable)
- Config aus `package/host/config/` → `~/.config/sunshine/`
- etc-Dateien aus `package/host/etc/` → `/etc/...` (root required)
- Service aus `package/host/systemd-user/` → `~/.config/systemd/user/`
- `systemctl --user daemon-reload && systemctl --user enable sunshine-host.service`

### 3. Storage vorbereiten
- Alle `storage.scopes[].path` via `storage-host-helper` anlegen
- Permissions: `danny:danny`, `755`

### 4. Postchecks ausführen
- Nach Install alle `postchecks` der Reihe nach prüfen
- Bei `on_fail: "run_bootstrap"` → `binary_bootstrap.fallback_script` ausführen

### 5. Container Addons installieren
- `container_addons/profiles/` aus Bundle → `intelligence_modules/container_addons/profiles/`
- Nur paket-eigene Profile beim Uninstall entfernen
- Generische Profile (`generic-linux` etc.) bleiben erhalten

### 6. Blueprint YAML sauber exportieren
- YAML darf keine Python-spezifischen Tags enthalten (`!!python/object` etc.)
- `export_bundle()` muss Blueprint-Daten im JSON-Modus serialisieren

## Designentscheidungen

| Entscheidung | Begründung |
|---|---|
| `system_prompt` schlank | Wird bei jedem Turn mitgeschickt → Tokenlast. Addons nur bei Shell-Bedarf geladen. |
| `container_addons` separat | Modular, wiederverwendbar, user-erweiterbar, Core bleibt schlank |
| `composite_addon` als eigener Typ | Standard-Blueprints bleiben einfach. Additiv, kein Breaking Change. |
| Live-Host-Dateien nicht als Source | Materialisierte Dateien ändern sich → Git würde immer divergieren |
| `stop = preserve` für gaming-station | Steam-State und -Home bleiben erhalten. Stop ≠ Delete. |
