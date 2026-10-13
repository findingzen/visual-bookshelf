# AGENTS.md

Instructions for AI coding agents (Claude Code and others) working on **happy-bookshelf**.
Humans are welcome to read this too; contributor guidance for people lives in `CONTRIBUTING.md`.

## Project in one paragraph

happy-bookshelf is an open-source, self-hosted home-library catalogue, delivered as a PWA. Books are identified by ISBN barcode (later by cover and spine), catalogued with metadata from free open sources, and placed on virtual shelves with real physical dimensions so different arrangements can be previewed. Read `docs/ARCHITECTURE.md` before making structural changes.

## Starting a session

Read these first, in this order:

1. `docs/sprints/README.md` — current status, last completed sprint, what's next.
2. The latest sprint log in `docs/sprints/`.
3. `docs/REQUIREMENTS.md` — the owner's original brief.
4. `docs/ARCHITECTURE.md` and `docs/adr/` — the design and the reasoning behind it.

## Stack

- Backend: Django, PostgreSQL, Django-Q2 (Postgres as broker, no Redis)
- Frontend: Django templates + HTMX + Alpine.js; Lit web components only for the shelf wall and scanner. **No React.**
- Styling: plain CSS with custom properties (design tokens). No utility framework.
- Runtime: Docker Compose, Caddy for HTTPS. All images must support `linux/arm64`.
- Python dependencies: `uv`

## Working style

These rules come from the project owner and apply to every session.

1. **One step at a time.** Each sprint starts with detailed instructions, but give only the next step, then wait. The owner may get stuck and needs room to ask.
2. **Say where each step runs.** Label every step with its location: **Claude chat**, **Claude Code**, **WSL terminal**, or **browser**.
3. **Skip obvious verification.** The owner handles routine checks (does it print the expected greeting, did the push succeed). Don't ask for their output; the owner will report problems.
4. **Docs are part of the work.** At the end of every planning session and every sprint, update `docs/ARCHITECTURE.md`, add or update ADRs in `docs/adr/`, and write the sprint log in `docs/sprints/`. A sprint isn't done until its docs are.
5. **Decisions get recorded.** When a choice is made, update the *Open decisions* table in `docs/ARCHITECTURE.md` and write an ADR.
6. **Design matters.** This app is for lovers of books and art. UI work should be deliberate, typographic and warm, never default-looking.

## Repository rules

- **Line endings are LF.** Enforced by `.gitattributes`. Never commit CRLF files; Docker containers break on CRLF shell scripts.
- **Never commit secrets.** Configuration goes in `.env` (git-ignored); every variable is documented in `.env.example`.
- **Never print, read aloud or commit private keys.**
- **Commit messages** follow Conventional Commits: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`.
- **Licences:** code is MIT. Book data contributed to the shared catalogue (Commons) is CC0. Bundled fonts keep their own licences (usually OFL).

## Local environment

- Development machine: Windows on Arm, working inside **WSL**.
- Code lives in the WSL filesystem (`~/code/happy-bookshelf`), **never** under `/mnt/c`.
- The Git remote uses the SSH alias `github-happy-bookshelf` (key `~/.ssh/happy-bookshelf`, GitHub account `findingzen`). Do not change the remote to plain `github.com`.
- Git identity is set **locally** in this repo. Do not create or edit a global `~/.gitconfig`; other projects on this machine use different GitHub accounts.
- Avoid collisions with other local projects: compose project name `happy-bookshelf`, non-default host ports, Postgres not published to the host.

## External services

- Prefer free, keyless sources (Open Library). Cache every response.
- Fetch Open Library covers by **cover ID**, not ISBN (the ISBN covers endpoint is rate-limited).
- Send a descriptive `User-Agent` with the project URL on every outbound request.
EOF_HB

cat > docs/REQUIREMENTS.md <<'EOF_HB'
# Requirements

The owner's original brief from Planning Session 0 (2026-10-13), lightly edited for clarity. `docs/ARCHITECTURE.md` explains how each one is met. If a requirement changes, edit it here and note the date.

## Product

1. **Identify books** through (a) ISBN barcode scan and, later, (b) cover and spine recognition.
2. **Low-cost hardware** for scanning barcodes, covers and spines.
3. **Low to zero API costs** for identifying a book.
4. **Persistent and secure storage** for each person's library; redundant storage later.
5. **Shared lookup:** new titles and supplemental information go into a global catalogue that augments publicly available sources.
6. **Custom views,** so not all title information has to be shown at once.
7. **Progressive web app** that works on desktop and mobile, independent of the host OS.
8. **Django backend with a non-React frontend.** Open to changing this for good reasons.
9. **Physical location tracking** that doesn't depend on the real room layout. Total shelf space is treated as one linear run; the app suggests organisations and sortings, and virtually fills shelves using each book's width and position. Every book is a visual, movable object with physical dimensions and a spine that resembles the real one (standardised spines first, variation later). This shows both the collection as it is and how different groupings would look.
10. **Documentation-first open source.** Docs and READMEs are updated at the end of every planning session and sprint.
11. **Match the owner's documentation style** from the docgen project. *(Pending: owner to share docgen docs.)*
12. **Beautiful UI,** suited to lovers of art and books.

## Process

13. **Each sprint starts with detailed instructions, one step at a time,** in case the owner gets stuck.
14. **Clear separation** of what runs in Claude chat versus Claude Code.
15. **Initial sprints:** create the repo on GitHub and locally; keep its SSH setup from disturbing other projects; choose a Windows-on-Arm dev architecture that doesn't conflict with other local projects; set up and tune Claude Code for this project.

## Added during Session 0

- **Shelf prototype early:** validate the virtual shelf with ~50 real books before building the shared catalogue or recognition.
- **Measuring with rulers:** rulers fixed to shelf edges give a photo scale; spine widths come from coordinate distances.
- **Open-source readiness:** showcase GIF or demo, two-minute quick start, ADRs, contributor on-ramp, visible design quality.
- **Ownership:** the project lives under the `findingzen` GitHub account.
EOF_HB

cat > docs/sprints/README.md <<'EOF_HB'
# Sprints

**Start here when resuming work.** This page always says where the project stands and what comes next.

## Current status

| | |
|---|---|
| **Phase** | 0 — Foundations |
| **Last completed** | Sprint 1 — Repository and SSH isolation |
| **Next** | Sprint 2 — Windows-on-Arm dev architecture |
| **Waiting on the owner** | docgen documentation samples, so the docs can match that style |

## Sprint log

| Sprint | Goal | Status | Log |
|---|---|---|---|
| 1 | Create the repo; isolate its SSH identity | ✅ Done | [sprint-01-repo-and-ssh.md](sprint-01-repo-and-ssh.md) |
| 2 | Arm64 Windows dev architecture without conflicts | ⏭ Next | — |
| 3 | Set up and tune Claude Code for the project | Planned | — |
| 4 | Shelf prototype with ~50 real books | Planned | — |

## How sprints work

- A sprint begins with a short plan: goal, steps, and where each step runs (Claude chat, Claude Code, WSL terminal, browser).
- Steps are given **one at a time**.
- A sprint ends with its log written here, `docs/ARCHITECTURE.md` updated, and an ADR for every decision made.
EOF_HB

cat > docs/sprints/sprint-01-repo-and-ssh.md <<'EOF_HB'
# Sprint 1 — Repository and SSH isolation

**Dates:** 2026-10-13
**Status:** ✅ Done
**Goal:** create `happy-bookshelf` on GitHub and locally, without disturbing the SSH or Git setup of other projects on the same machine.

## What was done

| Step | Where | Result |
|---|---|---|
| 1 | WSL terminal | Inventoried `~/.ssh` and Git config. Found three existing GitHub host entries and no global `~/.gitconfig` in WSL |
| 2 | WSL terminal | Generated a dedicated key: `~/.ssh/happy-bookshelf` (ed25519, passphrase-protected) |
| 3 | Browser | Created public repo `findingzen/happy-bookshelf` with the MIT licence, no generated README |
| 4 | Browser | Added the public key to the `findingzen` account |
| 5 | WSL terminal | Added SSH host alias `github-happy-bookshelf` with `IdentitiesOnly yes` (config backed up first) |
| 6 | WSL terminal | Cloned to `~/code/happy-bookshelf` via the alias; set name and noreply email **locally** |
| 7–8 | WSL terminal | Added README, architecture doc, `AGENTS.md`, `CLAUDE.md`, `.gitattributes`, `.gitignore` |
| 9 | WSL terminal | Added this log, requirements, ADRs |

## Resulting setup

- **Remote:** `git@github-happy-bookshelf:findingzen/happy-bookshelf.git`
- **SSH key:** used only for this repo, through the alias.
- **Git identity:** set in `.git/config`; there is deliberately no global config.
- **Line endings:** LF everywhere, enforced by `.gitattributes`.

## Decisions

- Name: `happy-bookshelf`.
- Licence: MIT — see [ADR 0003](../adr/0003-mit-licence.md).
- Shelf prototype moved up to Sprint 4 — see [ADR 0005](../adr/0005-shelf-prototype-first.md).

## Lessons

- **Files dragged in from Windows Explorer bring `:Zone.Identifier` files with them.** Copy with `cp` from `/mnt/c` instead; `.gitignore` now excludes them anyway.
- **Browsers rename dotfiles on download** (`.gitignore` → `gitignore.txt`). Check names before copying.
- **Downloads from Claude chat can fail.** Pasting heredoc blocks into the terminal is a reliable fallback.
- **Git config precedence:** repo-local settings always override global ones. The real risk is the reverse: a repo without local identity silently falling back to a global one.

## Carried forward

- Owner to share docgen docs so documentation can match that style.
