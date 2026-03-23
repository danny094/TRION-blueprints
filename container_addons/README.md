# Container Addons

Container Addons sind kleine, container- oder stack-spezifische Wissensdokumente
für `TRION shell`.

Ziel:
- kleiner stabiler Shell-Systemprompt
- containerbezogene Runtime-Fakten separat halten
- kommandospezifisches Wissen modular nachladbar machen
- 8B-Modelle nicht mit riesigen Core-Prompts überladen

Wichtig:
- Das ist **nicht** der allgemeine "model scan"- oder Dokument-Scan-Ordner.
- Diese Addons sind ein eigener Retrieval-Baustein für Container-/Shell-Kontext.
- Addons sollen kurz, operational und verifizierbar bleiben.

Empfohlene Struktur:

```text
intelligence_modules/container_addons/
  README.md
  ADDON_SPEC.md
  templates/
    base-shell-addon.md
    gaming-headless-addon.md
  profiles/
    gaming-station/
      00-profile.md
      10-runtime.md
      20-diagnostics.md
      30-known-issues.md
```

Geplante spätere Nutzung:
- Shell-Controller bestimmt ein Container-Profil
- passende Addons werden per Tags/Metadaten ausgewählt
- daraus werden wenige relevante Abschnitte in den Shell-Kontext gezogen

Für neue Addons zuerst `ADDON_SPEC.md` lesen.
