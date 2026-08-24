# Squid Proxy run as docker (docker-compose)

Squid is a caching and forwarding HTTP web proxy. It has a wide variety of uses, including speeding up a web server by caching repeated requests



## With Authentication
Run with [basic authentication](/with_authentication/readme.md)


## Without Authentication
Running Squid Proxy in internet without authentication is very dangerous and can lead to legal, security, and resource consumption issues.

Run [without authentication](/without_authentication/readme.md)

## Layout note (hp)

`with_authentication/` and `without_authentication/` are the portable templates —
bind and port are env-overridable via `SQUID_BIND` / `SQUID_PORT`.

The **top-level `docker-compose.yml` + `config/squid.conf` are hp's live
deployment** (container `squid`, project `squid-docker-compse`) and are kept
deliberately: that is what the running proxy bind-mounts. It binds all interfaces
so neither a DHCP renumber nor a tailscaled re-address can silently fail the bind,
and scopes access in the ACL (tailnet + LAN) rather than by bind address.

heron monitors it: a `proxy_egress` check proves traffic actually relays, and a
`port_publish` check catches the failure that left this container serving nothing
for 19 days in Aug 2026 (dockerd restarted under it and never rebuilt the port
publish, while the container stayed `running` and healthy).
