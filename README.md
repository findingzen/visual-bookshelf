# happy-bookshelf

> A home-library catalogue for people who love books as objects.
> Scan, catalogue and arrange your shelves — then see how they could look.

*Status: planning (Phase 0). Nothing runs yet.*

---

## What it does

- **Scan** a book's ISBN barcode with your phone's camera — no app store, no paid API.
- **Catalogue** editions and your own copies, with metadata from free, open sources such as Open Library.
- **Shelve** your books virtually: real dimensions, real shelf widths, spines you can drag around.
- **Rearrange** the whole collection by author, colour, height, subject or call number, and preview the result before lifting a single book.
- **View** your library your way, with saved custom views.
- **Contribute** missing titles and corrections to a shared, openly licensed catalogue.
- **Own your data:** self-hosted, exportable, private by default.

## Planned features by phase

| Phase | Theme | Highlights |
|---|---|---|
| 0 | Foundations | Repo, dev environment, documentation |
| 1 | Catalogue | ISBN scanning, metadata lookup, custom views, installable PWA |
| 2 | Shelves | Virtual bookcases, arrangement engine, backups |
| 3 | Recognition | Spine and cover recognition, scan station, shared catalogue |
| 4 | Share | Public demo, first release |

See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full design.

## Tech stack

Django · PostgreSQL · HTMX · Alpine.js · Lit · Docker Compose · Caddy

Runs on `linux/amd64` and `linux/arm64` (including Windows on Arm and Raspberry Pi).

## Quick start

*Coming in Phase 1.*

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

## Licence

[MIT](LICENSE). Book data contributed to the shared catalogue is released under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
