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
- Code lives in the WSL filesystem (`~/zendev_wsl/happy-bookshelf`), **never** under `/mnt/c`.
- The Git remote uses the SSH alias `github-happy-bookshelf` (key `~/.ssh/happy-bookshelf`, GitHub account `findingzen`). Do not change the remote to plain `github.com`.
- Git identity is set **locally** in this repo. Do not create or edit a global `~/.gitconfig`; other projects on this machine use different GitHub accounts.
- Avoid collisions with other local projects: compose project name `happy-bookshelf`, non-default host ports, Postgres not published to the host.

## External services

- Prefer free, keyless sources (Open Library). Cache every response.
- Fetch Open Library covers by **cover ID**, not ISBN (the ISBN covers endpoint is rate-limited).
- Send a descriptive `User-Agent` with the project URL on every outbound request.
