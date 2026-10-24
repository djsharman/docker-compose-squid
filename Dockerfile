# hp's live squid. Canonical's ubuntu/squid on the 24.04 LTS track, with the
# Ubuntu security pocket applied at build time: the upstream tag is refreshed
# only every few months, so on its own it ships a stale openssl. Rebuild to pick
# up new fixes (Qual raises a task when this image falls behind):
#   docker compose build --pull --no-cache && docker compose up -d
FROM ubuntu/squid:6.6-24.04_edge

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
