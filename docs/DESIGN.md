# Settled Design

What is built and verified, stated as fact. Reasoning lives in [`docs/adr/`](adr/); history lives in [`docs/sprints/`](sprints/). The proposal and roadmap are in [`docs/ARCHITECTURE.md`](ARCHITECTURE.md).

**Rules** ([ADR 0009](adr/0009-settled-design-file.md)): do not reopen a settled decision without implementation evidence of a blocker. Change this file only when a settled fact changes.

---

## Development environment

- Development runs on rootless Podman 4.9 inside WSL Ubuntu 24.04 (`aarch64`), with systemd enabled in `/etc/wsl.conf`. Docker Desktop is not used. ([ADR 0006](adr/0006-podman-in-wsl.md))
- `podman compose` delegates to the Docker Compose v5 binary at `~/.local/bin/docker-compose`; the same `compose.yaml` runs under `docker compose`.
- Every image in the stack runs natively on `linux/arm64`.
- WSL uses mirrored networking (`networkingMode=mirrored` in `%UserProfile%\.wslconfig`), so ports published in WSL appear on the Windows LAN address.

## Compose stack

- `compose.yaml` sets `name: visual-bookshelf`. Containers, the network and volumes (`pgdata`, `caddy_data`, `caddy_config`) carry that prefix.
- Three services: `caddy` (Caddy 2), `web` (Django under gunicorn, built from `app/Dockerfile`), `db` (PostgreSQL 16).
- `web` starts only after `db` passes its `pg_isready` healthcheck.
- Postgres is not published to the host. Only `caddy` publishes ports: `VB_HTTPS_PORT` (8443) and `VB_HTTP_PORT` (8081), bound to `VB_BIND_ADDRESS`.
- Caddy's container ports equal its host ports, so redirects and certificates use the port the browser sees.
- `app/Dockerfile` installs dependencies with `uv` from `uv.lock` and runs as the unprivileged user `app` (uid 1000).

## Configuration

- All configuration comes from `.env` (git-ignored). Every variable is documented in `.env.example`.
- `COMPOSE_PROJECT_NAME`, the `VB_*` port and host variables, the `DJANGO_*` settings and the `POSTGRES_*` credentials are the full set.

## HTTPS and phone access

- Caddy serves `VB_SITE_HOST` only, with a certificate from its internal CA (`tls internal`, `caddy/Caddyfile`).
- `default_sni` is set to `VB_SITE_HOST`, because browsers send no SNI to an IP address.
- Plain HTTP on `VB_HTTP_PORT` redirects to HTTPS on `VB_HTTPS_PORT`, except `/root.crt`, which serves the internal CA's public root certificate as `application/x-x509-ca-cert`. The private key is never served.
- **Phone access** needs four things:
  1. `.env`: `VB_BIND_ADDRESS=0.0.0.0`; `VB_SITE_HOST` set to the PC's LAN IP; that IP added to `DJANGO_ALLOWED_HOSTS` and, as `https://<ip>:8443`, to `DJANGO_CSRF_TRUSTED_ORIGINS`.
  2. A Hyper-V firewall rule opening TCP 8443 and 8081 to WSL, created once from an Administrator PowerShell:
     ```powershell
     New-NetFirewallHyperVRule -Name "visual-bookshelf-dev" -DisplayName "visual-bookshelf dev (8443, 8081)" -Direction Inbound -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -Protocol TCP -LocalPorts 8443,8081
     ```
  3. The phone trusts the CA once. On iPhone: open `http://<ip>:8081/root.crt` **in Safari**, install the profile in Settings, then enable it under *General → About → Certificate Trust Settings*.
  4. The phone opens `https://<ip>:8443`.
- With a LAN IP as `VB_SITE_HOST`, `https://localhost:8443` does not answer; the PC uses the IP too.
