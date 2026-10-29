# Testiranje

`phase-a.test.mjs` provjerava JSON konfiguracije i osnovne elemente Pawn izvornog koda. To nisu testovi pokretanja stvarnog servera niti testovi igranja.

Pokretanje:

```bash
bash scripts/validate-phase-a.sh
```

Kompajliranje GameModea je odvojena provjera i zahtijeva 32-bitni Pawn kompajler te službene open.mp include fajlove. GitHub Actions workflow bit će dodan u Fazi F.
