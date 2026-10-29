# Balkan Country RP

Osnova stvarnog **open.mp servera za igranje uloga** s GameModeom u Pawnu. Projekat nije web simulacija i ne kopira tuđe ili procurjele GameMode fajlove.

## Status projekta

**Faza A — osnovna struktura i GameMode.**

Trenutno postoje početni GameMode, konfiguracija servera, skripte za preuzimanje službenih alata, kompajliranje, lokalno pokretanje i statičku provjeru. Još nisu napravljeni registracija, prijava, lokalni RP chat ni komande `/me`, `/do`, `/b`, `/report` i `/pomoc`, baza podataka, ekonomija, poslovi, organizacije, administracija niti web panel. Server ih ne prikazuje kao gotove sisteme.

## Brzi početak

Za Ubuntu/Debian pripremite 32-bitne sistemske biblioteke, zatim iz ovog direktorija pokrenite:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install --yes curl tar screen libc6:i386 libatomic1 libatomic1:i386

bash scripts/prepare-linux.sh
bash scripts/validate-phase-a.sh
bash scripts/compile.sh
bash scripts/run-local.sh
```

`prepare-linux.sh` preuzima open.mp `1.6.7.3218` i Pawn kompajler `3.10.10` iz njihovih službenih GitHub izdanja te provjerava SHA-256 kontrolne sume. Preuzeti binarni fajlovi ostaju lokalno u `.runtime/` i `.tools/`; ne ulaze u Git.

## Dokumentacija

- `INSTALLATION.md` — instalacija alata i pokretanje na Ubuntu/Debian sistemu.
- `HOSTING.md` — ograničenja ove početne faze i osnova za Linux VPS.
- `SECURITY.md` — sigurnosne postavke i još neimplementirani dijelovi.
- `CHANGELOG.md` — promjene po fazama.
- `qawno/README.md` — porijeklo kompajlera i include fajlova.

## Alati i službeni izvori

- Replit: <https://replit.com/>
- GitHub: <https://github.com/>
- open.mp preuzimanje servera: <https://open.mp/downloads/server>
- open.mp konfiguracija `config.json`: <https://open.mp/docs/server/config.json>
- open.mp instalacija na Linuxu: <https://open.mp/docs/server/LinuxServerInstallation>
- Pawn kompajler 3.10.10: <https://github.com/pawn-lang/compiler/releases/tag/v3.10.10>

## GitHub

Za GitHub napravite prazan repozitorij i prenesite sadržaj direktorija `BalkanCountryRP/`. Nemojte slati `.runtime/`, `.tools/`, `.amx` ni stvarne tajne. GitHub Actions workflow i potpune upute za objavu dodajemo u Fazi F.

## Važno

U ovom okruženju nije potvrđeno pokretanje open.mp servera niti kompajliranje Pawn-a: ovdje nedostaje 32-bitni Linux učitavač potreban za službene Linux binarne fajlove. Izvorni kod i konfiguracijska struktura mogu se provjeriti ovdje; konačnu kompilaciju treba potvrditi na podržanom Linux sistemu ili kroz budući CI workflow.
