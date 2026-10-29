FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

ARG OPENMP_VERSION=1.6.7.3218
ARG OPENMP_ARCHIVE_SHA256=0f7bfe70bb68ea780fe24a910b69412046e53d10feb65a9d4a9de8ff1f7f1329
ARG PAWN_COMPILER_VERSION=3.10.10
ARG PAWN_COMPILER_ARCHIVE_SHA256=9bbb1df6e933318fce1fa61951e4196b70613c637a5a1d4c96937e147c18468d

# open.mp server (extracts to /opt/Server)
RUN curl -fsSL -o /tmp/omp.tar.gz "https://github.com/openmultiplayer/open.mp/releases/download/v${OPENMP_VERSION}/open.mp-linux-x86.tar.gz" \
    && echo "${OPENMP_ARCHIVE_SHA256}  /tmp/omp.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/omp.tar.gz -C /opt \
    && rm -f /tmp/omp.tar.gz \
    && chmod +x /opt/Server/omp-server \
    && test -x /opt/Server/omp-server \
    && test -f /opt/Server/qawno/include/a_samp.inc

# Pawn compiler (extracts to /opt/tools/pawnc-<version>-linux)
RUN mkdir -p /opt/tools \
    && curl -fsSL -o /tmp/pawnc.tar.gz "https://github.com/pawn-lang/compiler/releases/download/v${PAWN_COMPILER_VERSION}/pawnc-${PAWN_COMPILER_VERSION}-linux.tar.gz" \
    && echo "${PAWN_COMPILER_ARCHIVE_SHA256}  /tmp/pawnc.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/pawnc.tar.gz -C /opt/tools \
    && rm -f /tmp/pawnc.tar.gz \
    && test -x /opt/tools/pawnc-${PAWN_COMPILER_VERSION}-linux/bin/pawncc

COPY bcrp.pwn /opt/src/bcrp.pwn
COPY config.json /opt/Server/config.json

# Compile the gamemode; config.json expects main_scripts "bcrp 1"
RUN mkdir -p /opt/Server/gamemodes \
    && LD_LIBRARY_PATH=/opt/tools/pawnc-${PAWN_COMPILER_VERSION}-linux/lib \
       /opt/tools/pawnc-${PAWN_COMPILER_VERSION}-linux/bin/pawncc /opt/src/bcrp.pwn -i/opt/Server/qawno/include -o/opt/Server/gamemodes/bcrp.amx \
    && test -f /opt/Server/gamemodes/bcrp.amx

WORKDIR /opt/Server

EXPOSE 7777/udp

CMD ["./omp-server"]
