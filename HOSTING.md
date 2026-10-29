# Linux hosting

**Status: početne upute; produkcijsko postavljanje nije završeno ni testirano.**

open.mp multiplayer server zahtijeva dugotrajan proces i UDP promet. Koristite Linux VPS ili hosting koji izričito podržava trajne game-server procese i UDP port. Web-only/serverless hosting nije zamjena za open.mp server.

Za početni test na VPS-u:

1. Instalirajte Ubuntu/Debian pakete navedene u `INSTALLATION.md`.
2. Prenesite projekat na VPS i pokrenite `bash scripts/prepare-linux.sh`.
3. Pokrenite `bash scripts/validate-phase-a.sh`, `bash scripts/compile.sh` i `bash scripts/run-local.sh`.
4. Otvorite UDP `7777` u firewallu samo kada želite omogućiti vanjske klijente. Primjer za UFW:

   ```bash
   sudo ufw allow 7777/udp
   ```

5. Potvrdite da su port, konfiguracija, logovi i pravila hostinga ispravni prije dijeljenja servera.

Za pregled sesije možete pokrenuti server unutar `screen`:

```bash
screen -S bcrp bash scripts/run-local.sh
```

Odvajanje od sesije: `Ctrl+A`, zatim `D`. Povratak: `screen -r bcrp`. Zaustavite server kontrolisano iz njegove konzole ili zatvaranjem sesije nakon testa.

Ova faza **ne** postavlja systemd servis, automatsko ponovno pokretanje, monitoring, sigurnosne kopije ni produkcijsku politiku firewall-a. To treba uraditi i provjeriti prije stvarnog javnog rada servera. Službeni vodič: <https://open.mp/docs/server/LinuxServerInstallation>.
