# Sprint 3 — Set up and tune Claude Code

**Dates:** 2026-10-14 – 2026-10-14
**Status:** ✅ Done
**Goal:** Claude Code runs inside WSL; permissions, sprint start and close commands and an LF/format hook are in place; `CLAUDE.md` is expanded.

## Plan

| Step | Where | What | Why |
|---|---|---|---|
| 1 | VS Code | Reopen the project through the WSL remote and install the Claude Code extension there | Until now Claude Code ran on Windows and reached WSL over `\\wsl.localhost`: Git refused the repo as "dubious ownership", edits dropped the executable bit, and searches were slow. Hooks must also run in bash, not PowerShell |
| 2 | Claude Code | Add `.claude/settings.json` with project permissions: allow routine read-only and stack commands; deny reading `.env` and `~/.ssh` | Fewer prompts for safe commands, and a hard stop on secrets and private keys |
| 3 | Claude Code | Add `/sprint-start` and `/sprint-close` commands | Each session reads the right docs first, and each sprint closes with the docs AGENTS.md requires |
| 4 | Claude Code | Add a hook that rejects CRLF and formats Python after each edit | `.gitattributes` fixes line endings only at commit time; the hook catches them as files are written |
| 5 | Claude Code | Expand `CLAUDE.md`; update README setup, `docs/DESIGN.md`, this log | Docs are part of the work |

## What was done

| Step | Where | Result |
|---|---|---|
| 1 | VS Code | Project reopened through the WSL remote; Claude Code now runs inside WSL. `git status` works without the "dubious ownership" error |
| 2 | Claude Code | `.claude/settings.json` added: read-only git and routine `podman compose` commands are allowed; `.env`, keys, `~/.ssh`, `compose config` (it prints `.env` values), `down -v`, volume removal, force-push, global git config and remote changes are denied. Auto mode refused to let Claude write its own permissions until the owner approved it explicitly |
| 3 | Claude Code | Added `.claude/commands/sprint-start.md` (reads the docs in order, creates or resumes the log, gives only the next step) and `sprint-close.md` (checks done-when, updates log, status page, ARCHITECTURE, ADRs, DESIGN and setup docs, then asks before committing) |
| 4 | Claude Code | Added `.claude/hooks/post-edit.sh` as a `PostToolUse` hook on `Edit\|Write\|MultiEdit`: it rejects CRLF files (exit 2, so Claude must fix them) and runs `ruff format` from the nearest `.venv` on Python files. The script doesn't depend on this project; `CLAUDE.md` now states its rules and how to move it to `~/.claude/` |
| 5 | Claude Code | Expanded `CLAUDE.md` (where Claude runs, sprint commands, permissions, edit hook rules); README gained *Local Python tooling* and *Working with an AI agent*; `docs/DESIGN.md` gained *Python tooling* and *AI agent setup* |

## Lessons

- **The hook found a CRLF file on its first run.** `CLAUDE.md` was LF in the index but CRLF in the working tree, probably from an edit made on the Windows side. `.gitattributes` would have hidden this until commit time, so the hook earns its place.
- **Ruff isn't on `PATH` outside a project.** The hook looks for the nearest `.venv`, so files outside `app/` are checked for CRLF but not formatted. A global rollup needs ruff installed globally (`uv tool install ruff`) to format everywhere.
- **Auto mode won't let Claude widen its own permissions.** Writing `.claude/settings.json` needed the owner's explicit approval. That is the intended safeguard, so plan for one manual approval whenever permissions change.

## Decisions

- Ruff is the Python formatter, and a Claude Code edit hook enforces LF and formatting ([ADR 0011](../adr/0011-ruff-and-edit-time-checks.md), D-12).

## Carried forward

- **Optional, owner:** move the edit hook and its rules to `~/.claude/` (steps in `CLAUDE.md`), then delete the project copy so files aren't checked twice.
- CI (Sprint 8) should run `ruff format --check`, because the hook covers only agent edits.
- No `[tool.ruff]` configuration and no linting yet; add them when the Django skeleton lands in Sprint 8.
- The Sprint 2 items still apply: the DHCP-assigned LAN IP, one run under Docker, and untested Android steps.
