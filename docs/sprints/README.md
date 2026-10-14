# Sprints

**Start here when resuming work.** This page always says where the project stands and what comes next.

## Current status

| | |
|---|---|
| **Phase** | 0 — Foundations |
| **Last completed** | Sprint 2 — Dev environment on Podman in WSL |
| **Next** | Sprint 3 — Set up and tune Claude Code |
| **Waiting on the owner** | Nothing |

## Sprint log

### Phase 0 — Foundations

| Sprint | Goal | Done when | Status | Log |
|---|---|---|---|---|
| 1 | Create the repo; isolate its SSH identity | — | ✅ Done | [sprint-01-repo-and-ssh.md](sprint-01-repo-and-ssh.md) |
| 1b | Unpack the ADRs and sprint 1 log from a failed paste; add `CONTRIBUTING.md` | — | ✅ Done | Lesson recorded in the sprint 1 log |
| 2 | Dev environment on Podman in WSL ([ADR 0006](../adr/0006-podman-in-wsl.md)) | Ports and compose names of other projects are inventoried; a hello-world stack (Caddy, Django, Postgres) runs on its own ports; `.env.example` exists; the app opens on a phone over HTTPS; `docs/DESIGN.md` is started | ✅ Done | [sprint-02-dev-environment.md](sprint-02-dev-environment.md) |
| 3 | Set up and tune Claude Code | Claude Code runs inside WSL; permissions, sprint start and close commands and an LF/format hook are in place; `CLAUDE.md` is expanded | ⏭ Next | — |
| 4 | Design direction ([ADR 0008](../adr/0008-design-first-tokens-and-cube.md)) | Palette, typefaces, type and space scales exist as tokens; a static styleguide page shows them in light and dark; typefaces have an ADR | Planned | — |
| 5 | Prototype: data | The books on one Billy shelf are fetched by ISBN from Open Library into a JSON file, with covers and dominant colors | Planned | — |
| 6 | Prototype: measuring ([ADR 0007](../adr/0007-shelf-calibrated-measuring.md)) | A page rectifies three shelf photos from the marked corners, takes clicked spine boundaries, and writes reconciled thickness and height for every book | Planned | — |
| 7 | Prototype: shelf | An SVG shelf drawn to scale in the Sprint 4 design offers four or five orderings and drag-to-move; the README showcase is recorded; a go/no-go ADR is written | Planned | — |

Sprints 5–7 are throwaway code with no Django ([ADR 0005](../adr/0005-shelf-prototype-first.md)).

### Phase 1 — Catalog

Starts only if Sprint 7 says go.

| Sprint | Goal | Status |
|---|---|---|
| 8 | Django skeleton with auth, tests, CI, a multi-arch image build and a working quick start; `/styleguide` moves into the app | Planned |
| 9 | Data model (Work, Edition, Copy, Author, Library) with the scoped manager and cross-library isolation tests | Planned |
| 10 | Lookup chain: Open Library client, `SourceRecord`, Django-Q2 worker, covers by cover ID | Planned |
| 11 | Scanning: typed and HID-scanner input, then the phone camera over LAN HTTPS, then continuous mode | Planned |
| 12 | Copy editing, Gallery and Ledger views, views saved as data | Planned |
| 13 | PWA install, offline scan queue, CSV/JSON export, `v0.1` tag | Planned |

Phase 2 (shelf model, arrangement engine, `<shelf-wall>`, backups) is planned after Sprint 7, because the prototype should shape it.

## Planning sessions

| Session | Date | Outcome |
|---|---|---|
| 0 | 2026-10-13 | Requirements, architecture proposal, ADRs 0001–0005 |
| 1 | 2026-10-13 | Sprint plan above; Podman, shelf-calibrated measuring, design-first order and the settled-design file (ADRs 0006–0009) |

## How sprints work

- A sprint begins with a short plan: goal, steps, and where each step runs (Claude chat, Claude Code, WSL terminal, browser).
- Steps are given **one at a time**.
- A sprint ends with its log written here, `docs/ARCHITECTURE.md` and `docs/DESIGN.md` updated, and an ADR for every decision made.
