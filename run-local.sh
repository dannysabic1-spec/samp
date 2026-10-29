#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_DIR="$ROOT_DIR/.runtime/Server"

if [[ ! -x "$SERVER_DIR/omp-server" ]]; then
    echo "open.mp server nije pronađen. Pokrenite: bash scripts/prepare-linux.sh" >&2
    exit 1
fi

if [[ ! -f "$ROOT_DIR/gamemodes/bcrp.amx" ]]; then
    bash "$ROOT_DIR/scripts/compile.sh"
fi

cp "$ROOT_DIR/config.json" "$SERVER_DIR/config.json"
cp "$ROOT_DIR/gamemodes/bcrp.amx" "$SERVER_DIR/gamemodes/bcrp.amx"

echo "Pokrećem lokalni Balkan Country RP. Za zaustavljanje pritisnite Ctrl+C."
cd "$SERVER_DIR"
exec ./omp-server
