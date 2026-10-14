# CLAUDE.md

@AGENTS.md

## Claude-specific notes

- Shared project rules live in `AGENTS.md` (imported above) so that contributors using other AI tools get the same instructions. Edit rules there, not here. This file holds only what is specific to Claude Code.
- Personal, machine-specific notes go in `CLAUDE.local.md`, which is git-ignored. So does `.claude/settings.local.json`.
- Claude Code runs **inside WSL** (VS Code WSL remote, or `claude` in a WSL shell). Don't run it from Windows against `\\wsl.localhost`: Git rejects the repo as "dubious ownership", edits drop the executable bit, and hooks would run in PowerShell.
- The owner often drives sessions from a phone via Remote Control. Run commands yourself; when something needs sudo, a password or interactive input, say what and why, then carry on with the rest.

## Sprint commands

- `/sprint-start [N]` reads the docs in the order `AGENTS.md` gives, creates or resumes the sprint log, and gives **only the next step**. Use it at the start of every session.
- `/sprint-close` checks the sprint's *Done when* against its log, updates every doc `AGENTS.md` requires, and asks before committing.
- Both live in `.claude/commands/`. Change the workflow there, not in a chat.

## Permissions

`.claude/settings.json` holds the project permissions:

- **Allowed without a prompt:** read-only Git (`status`, `diff`, `log`, `show`, `branch`, `ls-files`), `ls`/`tree`/`wc`/`file`, and routine `podman compose` commands (`ps`, `logs`, `build`, `up`, `restart`, `stop`).
- **Denied:** reading or editing `.env`, `*.pem`, `*.key`, the deploy key and `~/.ssh`; `compose config` (it prints `.env` values); `down -v` and volume removal; force-push; `git config --global`; changing the remote.
- Don't look for a way around a deny rule. If one blocks real work, tell the owner and propose a change to the rule.
- Changes to these permissions need the owner's explicit approval; auto mode won't let Claude widen its own permissions.

## Edit hook rules

These rules don't depend on this project, so they can move to `~/.claude/CLAUDE.md` and `~/.claude/settings.json` unchanged. The hook enforces them: `.claude/hooks/post-edit.sh`, run as a `PostToolUse` hook on `Edit|Write|MultiEdit`.

- **Every text file is LF.** The hook rejects a file with CRLF line endings. When that happens, rewrite the file with LF; don't work around the hook. Files git marks as binary or `eol=crlf` are skipped.
- **Python is formatted by ruff after every edit.** The hook runs `ruff format` from the nearest `.venv`, or from `PATH`. Don't hand-format Python or argue with the formatter's output. If ruff can't be found, the hook skips formatting; run `uv sync` in `app/` to install it.
- **To roll these up globally:** copy the script to `~/.claude/hooks/`, put the same hook block in `~/.claude/settings.json` with the command `~/.claude/hooks/post-edit.sh`, and move this section to `~/.claude/CLAUDE.md`. Then remove the project copy, or each file gets checked twice.
