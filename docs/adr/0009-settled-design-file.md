# 0009 — A settled-design file alongside the architecture proposal

**Status:** Accepted · **Date:** 2026-10-13

## Context

Requirement 11 asks that the documentation match the owner's docgen project. The sample shared is docgen's "Settled Design" file: decisions that are verified and closed, stated as present-tense facts, grouped by topic, each naming the file or function that implements it, with no history and no rationale.

`docs/ARCHITECTURE.md` is a different kind of document: a proposal, written before any code, with open questions.

## Decision

- `docs/ARCHITECTURE.md` stays the proposal and roadmap.
- `docs/DESIGN.md` is the settled-design file, in the docgen style. An entry is added only when something is built and verified. It is created in Sprint 2 with the first such facts.
- Its rules are docgen's: do not reopen a settled decision without implementation evidence of a blocker; change the file only when a settled fact changes.
- ADRs keep the reasoning; sprint logs keep the history. Neither is repeated in `docs/DESIGN.md`.

## Consequences

- An agent or contributor can read what is true now without reading how it came to be.
- As work is built, sections of the architecture proposal are replaced by links to the settled file, so the two do not drift apart.
- Closing a sprint includes updating `docs/DESIGN.md`.
