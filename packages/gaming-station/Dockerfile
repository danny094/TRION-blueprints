FROM josh5/steam-headless:latest

# Cleanup-Script ins Image kopieren
COPY host/bin/gaming-station-prestart.sh /usr/local/bin/gaming-station-prestart.sh
RUN chmod +x /usr/local/bin/gaming-station-prestart.sh

# Wrapper-Entrypoint der Cleanup vor dem Original-Start ausführt
COPY host/bin/gaming-station-entrypoint.sh /usr/local/bin/gaming-station-entrypoint.sh
RUN chmod +x /usr/local/bin/gaming-station-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/gaming-station-entrypoint.sh"]
