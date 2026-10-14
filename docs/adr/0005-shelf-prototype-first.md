# 0005 — Prototype the shelf before Commons and recognition

**Status:** Accepted · **Date:** 2026-10-13 · Scope and measuring method amended by [0007](0007-shelf-calibrated-measuring.md); sprint numbers by [0008](0008-design-first-tokens-and-cube.md)

## Context

ISBN scanning and cataloging are well served by existing products. The project's distinctive idea is the virtual shelf: books as physical objects with real dimensions, arranged on real shelf space, with different organizations previewed before moving anything. Whether that is genuinely useful has not been tested. Physical dimension data is also sparse in public sources.

## Decision

After Phase 0 setup, build a **throwaway shelf prototype** (Sprint 4) with about 50 of the owner's real books, measured using rulers fixed to the shelves. Defer the Commons and cover/spine recognition until the prototype shows the idea is worth building on.

## Consequences

- The project's core value is tested in days rather than months.
- Early work produces the README showcase GIF.
- The prototype code is expected to be discarded or heavily rewritten; it should not dictate the final data model.
- Measuring books becomes a first-class feature, not an afterthought.
