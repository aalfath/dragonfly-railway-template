# Changelog

Each entry is one version of this template. Read it before you apply an update from Railway: breaking changes come first.

## 2.1.0 (2026-11-16)

- First release: Dragonfly v2.1.0 (`ghcr.io/dragonflydb/dragonfly:v2.1.0@sha256:94891bb22ce2fb0f7a5a3ff1bb3b2fbbc5830e2523293e47723d87fa3e5b1184`).
- Licence note: from v2.1.0 Dragonfly is under the Dragonfly Source-Available License (DSAL) instead of BSL 1.1. Production use is free up to 100 vCPUs in total; read the [licence](https://github.com/dragonflydb/dragonfly/blob/main/LICENSE.md).
- Password required (`DRAGONFLY_PASSWORD`, generated), data on the `/data` volume with a snapshot every 5 minutes and on shutdown, 2 I/O threads by default, health check on `/metrics`.
