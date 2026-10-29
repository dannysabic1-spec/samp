# Pawn kompajler i include fajlovi

Kompajler i open.mp include fajlovi nisu kopirani u repozitorij. Preuzimaju se iz službenih izdanja, provjeravaju SHA-256 kontrolnim sumama i čuvaju lokalno u `.tools/` i `.runtime/`.

Iz korijena projekta pokrenite:

```bash
bash scripts/prepare-linux.sh
bash scripts/compile.sh
```

Na Linuxu kompajler i open.mp server iz službenog paketa su 32-bitni. Upute za potrebne sistemske biblioteke nalaze se u `INSTALLATION.md`.
