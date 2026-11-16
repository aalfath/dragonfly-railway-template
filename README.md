[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/dragonfly-3?utm_medium=integration&utm_source=button&utm_campaign=dragonfly)

# Dragonfly on Railway

A one-click [Railway](https://railway.com) template for [Dragonfly](https://www.dragonflydb.io), the Redis- and Memcached-compatible in-memory data store.

It deploys **Dragonfly v2.1.0** from the official image `ghcr.io/dragonflydb/dragonfly:v2.1.0`, pinned by digest in the [`Dockerfile`](Dockerfile).

## What you get

- One service, `Dragonfly`, built from this repo, with a password generated at deploy time (no default password).
- A volume on `/data`. Dragonfly writes a snapshot every 5 minutes and when it shuts down, and loads it again on start, so data survives redeploys and restarts.
- Private access over Railway's network, plus a TCP proxy for access from outside Railway (password required).
- A health check on `/metrics`, the only HTTP path Dragonfly serves without the password (Prometheus metrics, no keys or values).

## Variables

| Variable | Default | What it is |
| --- | --- | --- |
| `DRAGONFLY_PASSWORD` | generated, 32 characters | Password for the `default` user |
| `PORT` | `6379` | Port Dragonfly listens on. Keep 6379: the URLs and the health check use it |
| `DRAGONFLY_URL` | `redis://default:…@${{RAILWAY_PRIVATE_DOMAIN}}:6379` | Connection URL on the private network |
| `REDIS_URL` | same as `DRAGONFLY_URL` | The same URL under the name most Redis clients expect |
| `DRAGONFLY_PUBLIC_URL` | `redis://default:…@${{RAILWAY_TCP_PROXY_DOMAIN}}:${{RAILWAY_TCP_PROXY_PORT}}` | Connection URL through the TCP proxy |

Use it from another service in the same project with `REDIS_URL=${{Dragonfly.REDIS_URL}}`.

Optional, not set by the template: any Dragonfly flag can be passed as a `DFLY_<flag>` variable, for example `DFLY_maxmemory=2gb`, `DFLY_cache_mode=true` (evict keys when memory is full), `DFLY_proactor_threads=4` (more I/O threads; each needs about 256 MB) or `DFLY_snapshot_cron=0 * * * *`. See the [flag reference](https://www.dragonflydb.io/docs/managing-dragonfly/flags).

If you don't need access from outside Railway, delete the TCP proxy in the service's Settings → Networking.

## Updates

This template builds from this repository, so Railway tells everyone who deployed it when a change lands on `main` (a new Dragonfly version, for example). You choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first.

## Licence

This repository's wrapper files are MIT-licensed. Dragonfly itself is not: from v2.1.0 it's under the [Dragonfly Source-Available License (DSAL)](https://github.com/dragonflydb/dragonfly/blob/main/LICENSE.md), which allows production use up to 100 vCPUs in total and doesn't allow offering it to others as a standalone database or caching service. Dragonfly is a trademark of DragonflyDB Ltd.; this template isn't affiliated with or endorsed by them.
