# 0008 — Design direction before the prototype; tokens, CUBE CSS and an editorial type scale

**Status:** Accepted · **Date:** 2026-10-13

## Context

The owner wants design to be a forethought, not an afterthought, and finds utility-first CSS (Tailwind) too sterile for this project. The first thing most visitors will see is the README showcase of the shelf prototype. The architecture already chose plain CSS with custom properties and no utility framework, but named no method and placed the design system in Phase 1, after the prototype.

Alternatives considered: utility-first (Tailwind), component frameworks (Bootstrap, Bulma), classless stylesheets (Pico, Simple.css), naming methodologies alone (BEM), vendor design languages (Material, Carbon).

## Decision

- The design direction gets its own sprint (**Sprint 4**) before the shelf prototype: palette, typefaces, type and space scales, and a static styleguide page.
- CSS is hand-written and organized as **CUBE CSS**: design tokens as custom properties, a few layout compositions, small component blocks, and exceptions.
- Type follows an **editorial** approach: a modular scale, a comfortable measure and vertical rhythm, as in book design.
- The Lit components take the same tokens through custom properties, which cross the shadow DOM boundary.

## Consequences

- The prototype and its showcase are built on the real palette and type, so the first public image already looks like the project.
- No CSS build step and no framework dependency.
- The look is the project's own, at the cost of writing components that a framework would have supplied.
- Phase 1 no longer has a separate design-system sprint; `/styleguide` moves into the Django app when the skeleton exists.
- Typeface choices are made in Sprint 4 and recorded in their own ADR.
