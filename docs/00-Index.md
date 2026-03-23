# Jarvis Container Commander + TRION Doku

Erstellt am: 2026-03-22

Diese Notizen fassen die Arbeiten rund um `Container Commander`, `gaming-station`, `TRION shell`, `StorageBroker` und die neuen `container_addons` zusammen.

Ergänzung vom 2026-03-23:

- `gaming-station` streamt jetzt nicht mehr mit Sunshine im Container, sondern über hostnahes Sunshine.
- Der Moonlight-Pairing-Hänger wurde auf Host-Sunshine-Version/Pairing-Verhalten eingegrenzt und mit einem älteren offiziellen Build umgangen.
- Host-Display und Steam Big Picture wurden auf einen sauberen `1920x1080`-Pfad gebracht.
- `gaming-station` wird beim normalen Commander-Stop standardmäßig erhalten statt gelöscht.
- `gaming-station` wird jetzt zusätzlich als optionales `composite addon` für den Marketplace vorbereitet statt fest im TRION-Core verdrahtet.
- Für dieses Composite-Addon existiert jetzt ein sicherer `shadow install`-Pfad, der Host-Dateien materialisiert, ohne den laufenden Sunshine-Service zu überschreiben.

## Inhalt

- [[01-Frontend-Commander-Fixes]]
- [[02-Gaming-Station-Storage-Sunshine-noVNC]]
- [[03-TRION-Shell-Mode]]
- [[04-Container-Addons]]
- [[05-Open-Issues-Next-Steps]]
- [[06-Gaming-Station-Setup-Guide]]
- [[07-Gaming-Station-GitHub-Package-Prep]]

## Kurzfassung

- Scroll- und Layout-Probleme im Container-Commander-Dashboard wurden behoben.
- Das Logs-/Shell-Panel wurde stabilisiert, inklusive Containerwechsel und besserem xterm-Rendering.
- `gaming-station` wurde als echter Steam-Headless- + Sunshine-Testcontainer aufgebaut.
- Die ursprüngliche Container-Sunshine-Architektur wurde später auf `Host Sunshine + Container Steam Bridge` umgebaut.
- StorageBroker und Container Commander wurden für externe Storage-Pfade enger verdrahtet.
- `gaming-station` wird als Shop-/Marketplace-Paket mit `Blueprint + Host Companion + Binary Bootstrap` vorbereitet.
- `TRION shell` wurde als eigener Commander-Modus eingeführt.
- Der Shellmodus wurde mit Verifikation, Loop-Guard und strukturierter Exit-Summary gehärtet.
- Für container-spezifisches Shellwissen wurde ein neues `container_addons`-System vorbereitet und für `gaming-station` erstmals angebunden.

## Hauptziele dieser Ausbaustufe

1. Container im Commander besser sichtbar und steuerbar machen.
2. Einen realen Gaming-Container als Integrationsprobe für StorageBroker + Commander nutzen.
3. TRION direkt im Container-Debugging nutzbar machen.
4. Shell-Wissen modular halten, statt riesige Systemprompts zu bauen.
