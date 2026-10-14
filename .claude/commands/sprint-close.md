---
description: Close the current sprint — check its done-when criteria and update every doc AGENTS.md requires
---

Close the in-progress sprint on visual-bookshelf. A sprint isn't done until its docs are.

1. Read `docs/sprints/README.md`, the sprint's log and `AGENTS.md`. Compare the sprint's **Done when** column against what was actually done. If anything is missing, list it and ask whether to finish it, carry it forward, or drop it. Stop there until the owner answers.
2. Update the docs, keeping American English and LF line endings:
   - **Sprint log:** fill **What was done** (Step | Where | Result), **Lessons** and **Carried forward**; set the end date and status ✅ Done.
   - **`docs/sprints/README.md`:** mark the sprint done, set **Last completed** and **Next**, and update **Waiting on the owner**.
   - **`docs/ARCHITECTURE.md`:** reflect structural changes; update the *Open decisions* table for every decision made.
   - **`docs/adr/`:** write an ADR for each decision made in the sprint, and add it to `docs/adr/README.md`.
   - **`docs/DESIGN.md`:** record what is now built and settled.
   - **README *Development setup* and `.env.example`:** update them if any setup or development step changed. Steps that only apply to the owner's machine go in the sprint log instead.
3. Show `git status` and a short summary of the doc changes. Propose a Conventional Commit message ending with the Claude co-author line, and ask before committing or pushing.
