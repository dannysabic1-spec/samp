# Sigurnost

## Postavke u Fazi A

- Server nije objavljen na javnoj listi: `announce` je `false`.
- RCON je isključen: `rcon.enable` je `false`.
- Nema lozinki, tokena, baze podataka ni vanjskih webhook tajni u repozitoriju.
- Poruke igrača se ne upisuju u log (`logging.log_chat` je `false`).

## Ograničenja

Registracija, sigurno čuvanje lozinki, provjera ovlaštenja, ekonomija, administracija, ograničavanje komandi i trajna pohrana nisu implementirani. Nemojte tvrditi da ove zaštite postoje niti koristiti ovu osnovu kao gotov javni RP server.

Prije javnog pokretanja promijenite razvojne postavke, provjerite firewall i ograničite pristup serveru. Nikada ne dodajte stvarne pristupne podatke u `config.json`, GitHub ili logove. Sigurnosni model baze i administratorskog panela pripada kasnijim fazama.
