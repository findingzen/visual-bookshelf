# visual-bookshelf

> A home-library catalog for people who love books as objects.
> Scan, catalog and arrange your shelves — then see how they could look.

*Status: Phase 0, foundations. The development stack runs; there are no features yet.*

---

## What it does

- **Scan** a book's ISBN barcode with your phone's camera — no app store, no paid API.
- **Catalog** editions and your own copies, with metadata from free, open sources such as Open Library.
- **Shelve** your books virtually: real dimensions, real shelf widths, spines you can drag around.
- **Rearrange** the whole collection by author, color, height, subject or call number, and preview the result before lifting a single book.
- **View** your library your way, with saved custom views.
- **Contribute** missing titles and corrections to a shared, openly licensed catalog.
- **Own your data:** self-hosted, exportable, private by default.

## Planned features by phase

| Phase | Theme | Highlights |
|---|---|---|
| 0 | Foundations | Repo, dev environment, documentation |
| 1 | Catalog | ISBN scanning, metadata lookup, custom views, installable PWA |
| 2 | Shelves | Virtual bookcases, arrangement engine, backups |
| 3 | Recognition | Spine and cover recognition, scan station, shared catalog |
| 4 | Share | Public demo, first release |

See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full design.

## Tech stack

Django · PostgreSQL · HTMX · Alpine.js · Lit · Docker Compose · Caddy

Runs on `linux/amd64` and `linux/arm64` (including Windows on Arm and Raspberry Pi).

## Quick start

*A one-command install for users arrives in Phase 1. Until then, see Development setup.*

## Development setup

This runs the development stack: Caddy for HTTPS, Django and PostgreSQL. Commands use Docker; with Podman, replace `docker compose` with `podman compose`.

### Prerequisites

- Git, and Docker with Compose v2, or Podman 4 with a compose provider.
- On Windows: work inside WSL 2, with the repository in the WSL filesystem (`~/...`), not under `/mnt/c`. File watching is slow there and line endings get mixed.

### 1. Clone and configure

```bash
git clone https://github.com/findingzen/visual-bookshelf.git
cd visual-bookshelf
cp .env.example .env
```

Edit `.env` and replace each `change-me` with a real value. `.env.example` explains every variable, including how to generate `DJANGO_SECRET_KEY`. Set `DJANGO_DEBUG=true` for development.

The defaults use host ports **8443** (HTTPS) and **8081** (HTTP), so the stack doesn't clash with other projects on 443, 80 or 8080. Change `VB_HTTPS_PORT` and `VB_HTTP_PORT` if those are taken too.

### 2. Start the stack

```bash
docker compose up -d --build
```

Open <https://localhost:8443>. The first visit shows a certificate warning, because Caddy signs the certificate with its own local certificate authority. To remove the warning, download the authority's public certificate from <http://localhost:8081/root.crt> and add it to your system's or browser's trusted roots.

### 3. Open it on a phone (optional)

Barcode scanning will use the phone's camera, which requires trusted HTTPS. To reach the stack from a phone on the same Wi-Fi:

1. **Point the stack at your LAN address.** In `.env`, set `VB_BIND_ADDRESS=0.0.0.0` and `VB_SITE_HOST` to your computer's LAN IP. Add that IP to `DJANGO_ALLOWED_HOSTS`, and add `https://<ip>:8443` to `DJANGO_CSRF_TRUSTED_ORIGINS`. Then run `docker compose up -d --force-recreate caddy web`. Caddy answers only on `VB_SITE_HOST`, so use `https://<ip>:8443` on the computer too.
2. **Windows with WSL only: let the phone reach WSL.**
   - In `%UserProfile%\.wslconfig`, set `networkingMode=mirrored` under `[wsl2]`, then run `wsl --shutdown`.
   - Open the two ports in the Hyper-V firewall, once, from PowerShell run as Administrator:
     ```powershell
     New-NetFirewallHyperVRule -Name "visual-bookshelf-dev" -DisplayName "visual-bookshelf dev (8443, 8081)" -Direction Inbound -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -Protocol TCP -LocalPorts 8443,8081
     ```
   - Make sure your Wi-Fi network is set to *Private* in Windows.
3. **Trust the certificate on the phone.**
   - **iPhone:** open `http://<ip>:8081/root.crt` in **Safari**; Chrome on iOS upgrades the link to `https` and fails. Install the profile from Settings, then turn on full trust under *Settings → General → About → Certificate Trust Settings*.
   - **Android:** download the same URL, then install it under *Settings → Security → Encryption & credentials → Install a certificate → CA certificate*. Menu names vary by manufacturer.
4. Open `https://<ip>:8443` on the phone.

If your router assigns a new IP, repeat step 1. A DHCP reservation on the router keeps the IP fixed.

## Documentation

| Document | Contents |
|---|---|
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | How the system fits together and why |
| [`docs/adr/`](docs/adr/) | Architecture decision records |
| [`docs/sprints/`](docs/sprints/) | Sprint plans and retrospectives |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | How to contribute |
| `CHANGELOG.md` | Release history *(Phase 1)* |

## Data sources and thanks

Book metadata and covers come from [Open Library](https://openlibrary.org), a project of the Internet Archive. Please be kind to their servers.

## License

[MIT](LICENSE). Book data contributed to the shared catalog is released under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
