# 0010 — Rename the project to visual-bookshelf

**Status:** Accepted · **Date:** 2026-10-14 · Supersedes the name chosen in D-1

## Context

The project began as `happy-bookshelf`. The owner renamed the GitHub repository to `visual-bookshelf` during Sprint 2, before any containers, volumes or application code existed, so a full rename costs almost nothing now and a great deal later.

## Decision

- The project name is `visual-bookshelf` everywhere: GitHub repository `findingzen/visual-bookshelf`, compose project name, volume prefixes, database name and user, local folder `~/projects/visual-bookshelf`.
- The SSH host alias becomes `github-visual-bookshelf` and the key `~/.ssh/visual-bookshelf`. The key itself is unchanged; only its file name moves.
- Historical records (sprint logs, accepted ADRs) keep the old name where it describes what happened at the time, with a note pointing here.

## Consequences

- Old GitHub URLs redirect, but every reference in the repository uses the new name.
- `CLAUDE.local.md`, editor workspaces and any shell shortcuts that point at the old folder need updating by hand.
- Claude Code keys its per-project memory by folder path, so the renamed folder starts with empty project memory.
