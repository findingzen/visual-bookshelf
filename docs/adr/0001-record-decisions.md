# 0001 — Record architecture decisions

**Status:** Accepted · **Date:** 2026-10-13

## Context

happy-bookshelf is open source and built across many short sprints, partly with AI coding agents that start each session without memory. Contributors and agents need to know not only what was decided, but why.

## Decision

Record every significant decision as a numbered ADR in `docs/adr/`, and keep the *Open decisions* table in `docs/ARCHITECTURE.md` in sync.

## Consequences

- Anyone, human or agent, can recover the reasoning behind the design.
- Writing an ADR is part of finishing any sprint that makes a decision.
