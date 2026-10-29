#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../versions.env
source "$ROOT_DIR/versions.env"

SOURCE_FILE="$ROOT_DIR/gamemodes/bcrp.pwn"
OUTPUT_FILE="${PAWN_OUTPUT:-$ROOT_DIR/gamemodes/bcrp.amx}"

PAWNCC="${PAWNCC:-}"
if [[ -z "$PAWNCC" ]]; then
    DEFAULT_COMPILER="$ROOT_DIR/.tools/pawnc-${PAWN_COMPILER_VERSION}-linux/bin/pawncc"
    if [[ -x "$DEFAULT_COMPILER" ]]; then
        PAWNCC="$DEFAULT_COMPILER"
    elif command -v pawncc >/dev/null 2>&1; then
        PAWNCC="$(command -v pawncc)"
    fi
fi

if [[ -z "$PAWNCC" || ! -x "$PAWNCC" ]]; then
    echo "Pawn kompajler nije pronađen. Prvo pokrenite: bash scripts/prepare-linux.sh" >&2
    exit 1
fi

PAWN_INCLUDE="${PAWN_INCLUDE:-}"
if [[ -z "$PAWN_INCLUDE" ]]; then
    for candidate in \
        "$ROOT_DIR/.runtime/Server/qawno/include" \
        "$ROOT_DIR/qawno/include" \
        "$ROOT_DIR/Server/qawno/include"; do
        if [[ -f "$candidate/a_samp.inc" ]]; then
            PAWN_INCLUDE="$candidate"
            break
        fi
    done
fi

if [[ -z "$PAWN_INCLUDE" || ! -f "$PAWN_INCLUDE/a_samp.inc" ]]; then
    echo "Nedostaje službeni a_samp.inc. Preuzmite open.mp paket putem scripts/prepare-linux.sh." >&2
    exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"
echo "Kompajliram GameMode..."
"$PAWNCC" "$SOURCE_FILE" "-i$PAWN_INCLUDE" "-o$OUTPUT_FILE"
echo "Uspješno je napravljen: $OUTPUT_FILE"
