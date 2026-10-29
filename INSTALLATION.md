# Instalacija i lokalno pokretanje

Ove upute pokrivaju samo početnu Fazu A. Za sada se može pokrenuti osnovni server s jednom klasom igrača i porukom dobrodošlice. Registracija, prijava, baza podataka i drugi RP sistemi još nisu dostupni.

## Potrebno

- Ubuntu/Debian Linux ili kompatibilan Linux VPS.
- Mrežna veza za preuzimanje službenih izdanja.
- 32-bitne biblioteke za open.mp i Pawn kompajler.

Službeno open.mp Linux uputstvo navodi Ubuntu 20.04 ili noviji i Debian-sisteme. U terminalu instalirajte potrebne sistemske pakete:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install --yes curl tar screen libc6:i386 libatomic1 libatomic1:i386
```

## Priprema projekta

Uđite u direktorij `BalkanCountryRP`, pa pokrenite:

```bash
bash scripts/prepare-linux.sh
```

Skripta preuzima:

- open.mp server `1.6.7.3218` u `.runtime/`;
- Pawn kompajler `3.10.10` u `.tools/`;
- odgovarajuće Pawn include fajlove iz open.mp paketa.

Prije raspakivanja provjeravaju se SHA-256 kontrolne sume zapisane u `versions.env`. Binarni fajlovi se ne predaju niti spremaju u Git repozitorij.

## Provjera i kompajliranje

```bash
bash scripts/validate-phase-a.sh
bash scripts/compile.sh
```

Ako kompajler nije na podrazumijevanoj lokaciji, navedite putanju ručno:

```bash
PAWNCC="/putanja/do/pawncc" \
PAWN_INCLUDE="/putanja/do/Server/qawno/include" \
bash scripts/compile.sh
```

Uspješno kompajliranje napravi `gamemodes/bcrp.amx`. Taj fajl se ignoriše u Git-u i može se ponovo generisati iz `gamemodes/bcrp.pwn`.

## Pokretanje

```bash
bash scripts/run-local.sh
```

Skripta kopira `config.json` i kompajlirani GameMode u lokalno preuzeti open.mp direktorij, pa pokreće `omp-server`. Za zaustavljanje pritisnite `Ctrl+C`.

Razvojna konfiguracija koristi UDP port `7777`, ne objavljuje server na javnoj listi (`announce: false`) i drži RCON isključen. Nemojte otvarati server javnosti dok ne promijenite i provjerite postavke u `config.json`.

## Ako se server ne pokrene

- `cannot execute binary file` ili poruka o nedostajućem učitavaču obično znači da nedostaju 32-bitne biblioteke. Ponovite instalaciju paketa iz odjeljka „Potrebno“.
- Greška za `a_samp.inc` znači da nisu preuzeti include fajlovi; ponovo pokrenite `bash scripts/prepare-linux.sh`.
- Greška kompajlera ne znači da je GameMode testiran ili funkcionalan; sačuvajte cijeli izlaz i provjerite verziju kompajlera i include direktorij.

Službeni izvori:

- <https://open.mp/downloads/server>
- <https://open.mp/docs/server/config.json>
- <https://open.mp/docs/server/LinuxServerInstallation>
- <https://github.com/pawn-lang/compiler/releases/tag/v3.10.10>
