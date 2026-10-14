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
| 6 | WSL terminal | Cloned to `~/zendev_wsl/happy-bookshelf` via the alias; set name and noreply email **locally** |
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
- **Heredoc pastes can fail too.** If the first `cat >` line is lost, everything lands in one file with the `EOF_HB` markers inside it. This happened to step 9 and was repaired in Sprint 1b; check `git status` for unexpected paths before committing.
- **Git config precedence:** repo-local settings always override global ones. The real risk is the reverse: a repo without local identity silently falling back to a global one.

## Carried forward

- Owner to share docgen docs so documentation can match that style. *(Shared on 2026-10-13.)*
