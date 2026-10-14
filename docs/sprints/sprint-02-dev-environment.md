# Sprint 2 — Dev environment on Podman in WSL

**Dates:** 2026-10-13 – 2026-10-14
**Status:** ✅ Done
**Goal:** a hello-world stack (Caddy, Django, Postgres) on rootless Podman in WSL, on its own ports, reachable from a phone over HTTPS, without disturbing other projects on the machine.

## What was done

| Step | Where | Result |
|---|---|---|
| 1 | WSL terminal | Confirmed systemd is enabled in WSL and Podman 4.9.3 is installed; `podman compose` uses the Docker Compose v5 binary |
| 2 | Claude chat / WSL terminal | Added `.env.example` with host ports 8443 and 8081 |
| 3 | Browser / WSL terminal | Renamed the project to `visual-bookshelf` ([ADR 0010](../adr/0010-rename-to-visual-bookshelf.md)) |
| 4 | WSL terminal | Added `compose.yaml`, `caddy/Caddyfile` and the Django app in `app/`; the stack runs and answers on `https://localhost:8443` |
| 5 | Claude Code | Set up Claude Code Remote Control so the owner can drive sessions from a phone; updated the `rc` helper script for the rename |
| 6 | Claude Code | Inventoried ports and compose projects (below) |
| 7 | Claude Code | Pointed `.env` at the LAN IP and bound to `0.0.0.0`; added `default_sni` and the `/root.crt` download to the Caddyfile |
| 8 | Windows PowerShell (Administrator) | Added a Hyper-V firewall rule for TCP 8443 and 8081 |
| 9 | iPhone | Installed and trusted Caddy's root certificate; the app opens over HTTPS with no warning |
| 10 | Claude Code | Started `docs/DESIGN.md`; wrote this log |

## Inventory of other projects (2026-10-14)

| What | Found |
|---|---|
| Docker Desktop | Installed, not running at inventory time; its containers could not be listed |
| Podman containers | `onlyoffice` (created, not running) publishes `0.0.0.0:8080` |
| Other compose files under `~/projects` | None (`DNU_adhara`, `cahoco`, `docGen` have no compose file) |
| Windows listeners in 1024–49151 | Only `Code` (VS Code), `GoogleDriveFS`, `OneDrive`, `SurfaceBroker`; none on 8081 or 8443 |
| Podman volumes and networks | Anonymous volumes from other containers; ours are all prefixed `visual-bookshelf_` |

No conflicts. Ports 8443 and 8081 are free.

## Decisions

- Podman in WSL is verified on arm64; D-7 is closed ([ADR 0006](../adr/0006-podman-in-wsl.md)).
- Phone access uses WSL mirrored networking plus a Hyper-V firewall rule, not a port proxy.
- Phones trust Caddy's internal CA, served at `/root.crt` over HTTP during development.
- `docs/DESIGN.md` exists ([ADR 0009](../adr/0009-settled-design-file.md)).

## Lessons

- **"WSL terminal" means a bash prompt, not a running `claude` session.** Commands typed at Claude's `❯` prompt go to Claude as messages. `AGENTS.md` now says so and asks for a reason with each step.
- **A shell opened before a folder rename keeps the old path.** `claude remote-control` started from it registered and trusted the old name. Open a new shell, or `cd` to the new path, after a rename.
- **Editing WSL files from Windows tools can drop the executable bit.** `sed -i` over `\\wsl.localhost` rewrote `~/.local/bin/rc` without `+x`. Edit from inside WSL, or `chmod +x` afterward.
- **Browsers send no SNI to an IP address.** Caddy then failed the handshake until `default_sni` was set.
- **Chrome on iPhone upgrades `http` links to `https`,** so the certificate download on port 8081 failed with `ERR_SSL_PROTOCOL_ERROR`. Use Safari, which iOS requires for profile installs anyway.
- **iOS needs two steps to trust a CA:** install the profile, then enable full trust under Certificate Trust Settings.

## Carried forward

- The LAN IP (`192.168.4.178`) comes from DHCP. If it changes, update `.env` and restart `caddy` and `web`; a DHCP reservation on the router would prevent this.
- Run the stack under Docker once, as ADR 0006 asks; CI will do it from Sprint 8.
- The README now has a Development setup section, so a fresh clone can follow these steps. The one-command install for users arrives in Phase 1.
- The Android steps in the README haven't been tested yet.
