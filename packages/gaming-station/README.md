# Gaming Station Composite Addon

Dieses Paket beschreibt `gaming-station` als optionales Hybrid-Addon:

- `gaming-station`-Blueprint fuer Steam/App-State im Container
- `sunshine-host-bridge` als Host-Companion fuer Streaming, Xorg und Eingabebruecke

## Ziel

Das Paket soll spaeter ueber den TRION-Shop installierbar sein, ohne den TRION-Core hart mit Gaming-Logik zu verdrahten.

## Enthaltene Host-Bausteine

- User-Service fuer hostnahes Sunshine
- X11-Session-Skripte
- uinput-/DRI-Prepare-Skript
- Xorg-Headless-Konfiguration
- EDID-Asset in textueller Hex-Form

## Wichtige Architekturentscheidung

- Steam bleibt im Container
- Sunshine laeuft auf dem Host
- Storage und Steam-Home bleiben unter `/data/services/gaming-station/...`

## Aktueller Status

Die Dateien in diesem Paket sind derzeit Paketinhalt und Dokumentation. Die automatische Materialisierung auf den Host wird in einem spaeteren Installer-/Deploy-Schritt verdrahtet.
