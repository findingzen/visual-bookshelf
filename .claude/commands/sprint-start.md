---
description: Resume or start a sprint — read the project docs in order, then give only the first step
argument-hint: "[sprint number, optional]"
---

Start or resume a sprint on visual-bookshelf. Sprint requested: $ARGUMENTS (if empty, use the **Next** or in-progress sprint from the status page).

1. Read, in this order:
   - `docs/sprints/README.md` (current status and the sprint table)
   - the latest log in `docs/sprints/` (and the requested sprint's log, if it exists)
   - `docs/REQUIREMENTS.md`
   - `docs/ARCHITECTURE.md` and the ADR index in `docs/adr/README.md`
   - `docs/DESIGN.md` — settled decisions; do not reopen them without implementation evidence of a blocker
2. If the sprint has no log yet, create `docs/sprints/sprint-NN-<slug>.md` in the same format as earlier logs: title, dates, status 🚧 In progress, goal, a **Plan** table (Step | Where | What | Why), empty **What was done**, **Lessons** and **Carried forward** sections. Set the sprint to 🚧 In progress in `docs/sprints/README.md`.
3. If the sprint is already in progress, find the first step that is not in **What was done**.
4. Reply briefly:
   - one line on where the project stands
   - the plan table (only for a new sprint)
   - **only the next step**, labeled with where it runs (Claude chat, Claude Code, WSL terminal, browser) and a one-line reason
   - if it runs in a WSL terminal and the owner may be inside `claude`, say how to exit first

Then stop and wait. Do not run later steps.
