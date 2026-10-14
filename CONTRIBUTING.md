# Contributing

Thank you for looking. visual-bookshelf is in Phase 0: the design is written down and no application code exists yet, so the most useful contributions right now are comments on the design.

## Where to start

- [`README.md`](README.md) says what the project is for.
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) says how it is meant to work.
- [`docs/adr/`](docs/adr/) holds the decisions already made and why.
- [`docs/sprints/README.md`](docs/sprints/README.md) says where the work stands.

Open an issue if something in the design looks wrong, or if you know a free source of book dimensions.

## Ground rules

- **Commits** follow Conventional Commits: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`.
- **Line endings** are LF, enforced by `.gitattributes`.
- **Secrets** never go in the repository. Configuration belongs in `.env`, documented in `.env.example`.
- **Decisions** are recorded as an ADR in `docs/adr/`, in the same pull request as the change.
- **Licenses:** code is MIT. Book data contributed to the shared catalog is CC0. By contributing you agree to both.

Setup instructions, tests and `good first issue`s arrive with Phase 1, when there is something to run.

AI coding agents read [`AGENTS.md`](AGENTS.md) instead.
