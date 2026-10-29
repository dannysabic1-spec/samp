#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../versions.env
source "$ROOT_DIR/versions.env"

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

OPENMP_ARCHIVE="$TEMP_DIR/open.mp-linux-x86.tar.gz"
PAWN_ARCHIVE="$TEMP_DIR/pawnc-linux.tar.gz"

OPENMP_URL="https://github.com/openmultiplayer/open.mp/releases/download/v${OPENMP_VERSION}/open.mp-linux-x86.tar.gz"
PAWN_URL="https://github.com/pawn-lang/compiler/releases/download/v${PAWN_COMPILER_VERSION}/pawnc-${PAWN_COMPILER_VERSION}-linux.tar.gz"

provjeri_kontrolnu_sumu() {
    local ocekivana="$1"
    local fajl="$2"
    if ! printf '%s  %s\n' "$ocekivana" "$fajl" | sha256sum --check --status; then
        echo "Kontrolna suma ne odgovara za $(basename "$fajl"); preuzimanje je odbijeno." >&2
        exit 1
    fi
}

echo "Preuzimam službeni open.mp server ${OPENMP_VERSION}..."
curl --fail --location --silent --show-error "$OPENMP_URL" --output "$OPENMP_ARCHIVE"
provjeri_kontrolnu_sumu "$OPENMP_ARCHIVE_SHA256" "$OPENMP_ARCHIVE"

echo "Preuzimam Pawn kompajler ${PAWN_COMPILER_VERSION}..."
curl --fail --location --silent --show-error "$PAWN_URL" --output "$PAWN_ARCHIVE"
provjeri_kontrolnu_sumu "$PAWN_COMPILER_ARCHIVE_SHA256" "$PAWN_ARCHIVE"

mkdir -p "$ROOT_DIR/.runtime" "$ROOT_DIR/.tools"
tar -xzf "$OPENMP_ARCHIVE" -C "$ROOT_DIR/.runtime"
tar -xzf "$PAWN_ARCHIVE" -C "$ROOT_DIR/.tools"

SERVER_DIR="$ROOT_DIR/.runtime/Server"
PAWNCC="$ROOT_DIR/.tools/pawnc-${PAWN_COMPILER_VERSION}-linux/bin/pawncc"
if [[ ! -x "$SERVER_DIR/omp-server" || ! -f "$SERVER_DIR/qawno/include/a_samp.inc" || ! -x "$PAWNCC" ]]; then
    echo "Preuzeti paketi nemaju očekivanu strukturu. Provjerite službena izdanja." >&2
    exit 1
fi

echo "Alati su spremni."
echo "open.mp: $SERVER_DIR"
echo "Pawn kompajler: $PAWNCC"
echo "Pokrenite: bash scripts/compile.sh"
