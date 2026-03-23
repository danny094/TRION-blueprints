# Offene Punkte und nächste Schritte

## Was jetzt gut funktioniert

- Container-Commander ist deutlich stabiler
- Gaming-Container ist als echter Testfall nutzbar
- StorageBroker und Commander sind näher zusammengerückt
- TRION kann direkt im Containerkontext analysieren
- `trion shell` ist praktisch nutzbar
- container-spezifisches Shellwissen ist vorbereitet
- hostnahes Sunshine + Moonlight funktioniert grundsätzlich
- `gaming-station` bleibt bei normalem Stop erhalten
- `gaming-station` startet nach `stop -> start` ohne erneuten Steam-Installer weiter
- die laufende `gaming-station`-Generation ist jetzt konsistent mit dem aktuellen Host-Bridge-Blueprint
- Steam-Home ist persistent unter `/data/.../steam-home`
- der Commander-/Quota-Stand wird jetzt gegen den realen Docker-Zustand synchronisiert
- Bind-Mount-Hostpfade unter `/data/...` werden jetzt nativ über `storage-host-helper` vorbereitet
- Big Picture wird nachweislich wieder auf `1920x1080` stabilisiert, wenn das sichtbare Steam-Fenster zurück auf `1280x800` fällt

## Offene Punkte

### Sunshine / Gaming Runtime

- Der eigentliche Streaming-Pfad läuft jetzt hostnah statt im Container
- Sunshine-WebUI, Pairing und Stream funktionieren
- `HEVC` wurde bereits erfolgreich im Log beobachtet, bleibt aber weiterhin etwas, das je Session sauber mit dem Client ausgehandelt werden muss
- noVNC bleibt eher Debug-/Installationspfad als Gaming-Hauptweg
- Audio-/Input-Fehler sind im aktuellen Sunshine-Log nicht auffällig

### Gaming Station Runtime

- Der frühere Generations-Mismatch zwischen altem `primary`-Container und neuem Host-Bridge-Blueprint ist bereinigt
- Dockerfile-basierte `gaming-station`-Images nutzen jetzt content-basierte Tags statt nur `latest`
- Der frühere stale Commander-/HTTP-Quota-Zustand wurde durch Docker-State-Sync deutlich entschärft
- Mount-Precreate für Host-Bind-Pfade unter `/data` läuft jetzt host-aware über `storage-host-helper`
- Big-Picture-Fullscreen ist deutlich robuster, sollte aber bei weiteren echten Neustarts und Reconnects weiter beobachtet werden
- Host-Bridge-Container wie `gaming-station` liefern im Container-Detail jetzt wieder sinnvolle Zugänge, obwohl der Container selbst keine Docker-Ports publiziert
- dafür werden Host-Companion-`access_links` synthetisch in `ports`/`connection` des Detail-Response ergänzt

### Marketplace / Composite Addon

- `gaming-station` ist jetzt als optionales `composite_addon` vorbereitet
- Bundle-Support kann `Blueprint + Host Companion + Paketdateien` gemeinsam tragen
- Host-Companion-Dateien können über `storage-host-helper` nativ auf dem Host materialisiert werden
- ein `binary_bootstrap` für `sunshine` ist vorbereitet
- ein sicherer `gaming-station-shadow`-Pfad wurde live verifiziert, ohne den laufenden Host-Service zu beschädigen
- ein kontrollierter lokaler Marketplace-Install gegen einen temporären Shadow-Bundle-Pfad wurde erfolgreich durchgeführt
- dabei wurde ein echter Export-/Import-Roundtrip-Bug gefunden und behoben:
  - `export_bundle()` muss Blueprint-Daten im JSON-Modus serialisieren, sonst landen Python-Tags wie `NetworkMode` im YAML
- der eigentliche End-to-End-Pfad `frischer Paket-Install -> Deploy -> Host Companion startet -> Container startet` ist noch als nächster größerer Test offen
- eine kleine Store-Ecke bleibt dabei sichtbar:
  - `delete_blueprint()` ist Soft-Delete
  - Wiederverwendung derselben Blueprint-ID kann deshalb in SQLite an `UNIQUE` scheitern, wenn man Test-IDs nicht variiert

### TRION Shell

- GUI-Interaktionen sind besser, aber noch nicht perfekt
- echte autonome Mehrschritt-Ausführung wurde bewusst noch nicht aktiviert
- Risk-Gates sind aktuell eher leichtgewichtig als tief integriert
- der frühere WebSocket-Race im Shell-Attach-Pfad wurde entschärft:
  - `attach`/`stdin` werden nicht mehr still verworfen, wenn der Socket noch nicht `OPEN` ist
  - beim Reconnect wird der aktuell angehängte Container automatisch erneut attached

### Addons

- `addon_docs` werden inzwischen im Commander-UI angezeigt
- das Addon-System ist vorbereitet, aber noch jung
- mehr Containerprofile würden den praktischen Nutzen schnell erhöhen

## Empfohlene nächste Schritte

1. Controller-Input in Steam Big Picture praktisch gegenprüfen
2. HEVC-/Bitrate-/Client-Abstimmung für Moonlight weiter feinjustieren
3. weitere echte Restart-/Reconnect-Zyklen gegen Big-Picture-Fullscreen prüfen
4. weitere Containerprofile ergänzen, z. B. Datenbank-, MCP-, Web- und Service-Container
5. Shell-Policy weiter schärfen, vor allem für GUI- und Write-Aktionen
6. später Mikro-Loops und erst danach echte Shell-Autonomie nachziehen
7. bei Bedarf Blueprint-seitige Addon-Registrierung ergänzen
8. Commander-UI optional klarer anzeigen lassen, wenn ein Service `stopped and preserved` ist
9. den echten Marketplace-Installflow für `gaming-station` fertigziehen, inkl. Host-Companion-Start und Repair-Pfad
10. den trägen Tabwechsel / verspätete Panel-Updates im Commander gezielt untersuchen

## Mögliche spätere Ausbaustufen

- eigener `shell control model`-Schalter
- user-erweiterbare Addon-Sammlungen pro Blueprint
- stärkere Recovery-/Verification-Strategien
- feinere Storage-/Commander-/TRION-Integration auf Asset-Ebene
