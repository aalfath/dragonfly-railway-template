# Dragonfly for Railway: the official image, pinned by version and digest,
# plus a small start script (password required, data on /data, sane thread count).
FROM ghcr.io/dragonflydb/dragonfly:v2.1.0@sha256:94891bb22ce2fb0f7a5a3ff1bb3b2fbbc5830e2523293e47723d87fa3e5b1184

COPY --chmod=755 start.sh /usr/local/bin/railway-start.sh

EXPOSE 6379
WORKDIR /data

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/railway-start.sh"]
