# 0011 — Ruff for Python formatting, enforced by an edit hook

**Status:** Accepted · **Date:** 2026-10-14

## Context

`.gitattributes` normalizes line endings to LF, but only when files are committed. Until then, a CRLF file in the working tree can still break a shell script inside a container, and editors on the Windows side of WSL write CRLF. Python code also needs one formatter, so that neither people nor agents argue about style in diffs. Black, Ruff, or no formatter yet were the options.

## Decision

- **Ruff** is the Python formatter. It is a dev dependency in `app/pyproject.toml`, installed with `uv sync`, and runs with its defaults until a reason to configure it appears.
- A Claude Code `PostToolUse` hook (`.claude/hooks/post-edit.sh`) runs after every agent edit. It rejects a file with CRLF line endings, so the agent must fix it, and runs `ruff format` on Python files.
- The hook contains nothing specific to this project, so the owner can move it to `~/.claude/` for every project.

## Consequences

- Line endings are now checked as files are written, not only at commit time. The hook found a CRLF `CLAUDE.md` on its first run.
- Formatting by people, and linting, are not enforced yet. CI from Sprint 8 should run `ruff format --check`, and a pre-commit hook could follow if people's edits drift.
- Contributors using other agents don't get the hook; the LF rule in `AGENTS.md` and `.gitattributes` still applies to them.
