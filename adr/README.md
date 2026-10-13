# Architecture decision records

Each significant decision gets a short record: the context, the decision, and its consequences. Records are never deleted; a decision that changes gets a new record that supersedes the old one.

| ADR | Title | Status | Date |
|---|---|---|---|
| [0001](0001-record-decisions.md) | Record architecture decisions | Accepted | 2026-10-13 |
| [0002](0002-django-htmx-lit.md) | Django + HTMX, with Lit for the shelf wall | Accepted | 2026-10-13 |
| [0003](0003-mit-licence.md) | MIT licence for code | Accepted | 2026-10-13 |
| [0004](0004-cc0-commons-data.md) | CC0 for shared catalogue data | Accepted | 2026-10-13 |
| [0005](0005-shelf-prototype-first.md) | Prototype the shelf before Commons and recognition | Accepted | 2026-10-13 |

New records copy the structure of 0001: **Context**, **Decision**, **Consequences**.
EOF_HB

cat > docs/adr/0001-record-decisions.md <<'EOF_HB'
# 0001 — Record architecture decisions

**Status:** Accepted · **Date:** 2026-10-13

## Context

happy-bookshelf is open source and built across many short sprints, partly with AI coding agents that start each session without memory. Contributors and agents need to know not only what was decided, but why.

## Decision

Record every significant decision as a numbered ADR in `docs/adr/`, and keep the *Open decisions* table in `docs/ARCHITECTURE.md` in sync.

## Consequences

- Anyone, human or agent, can recover the reasoning behind the design.
- Writing an ADR is part of finishing any sprint that makes a decision.
EOF_HB

cat > docs/adr/0002-django-htmx-lit.md <<'EOF_HB'
# 0002 — Django + HTMX, with Lit for the shelf wall

**Status:** Accepted · **Date:** 2026-10-13

## Context

The owner prefers a Django backend and a non-React frontend, but is open to other options for good reasons. Most screens are lists, forms and detail pages. One screen — the virtual shelf wall, with draggable spines drawn to real dimensions — needs substantial client-side state. The barcode scanner also runs in the browser.

## Decision

- Django renders pages; **HTMX** handles partial updates; **Alpine.js** handles small UI state.
- The shelf wall and scanner are **Lit web components**, bundled with esbuild.
- No React or other single-page-app framework.

## Consequences

- Most of the app needs no JavaScript build step and very little client code.
- The interactive shelf gets a proper component model without committing the whole app to a framework.
- The shelf component talks to Django through a small JSON API, which must be designed and documented.
- If SVG rendering becomes too slow for large libraries, the renderer inside the component can switch to Canvas without changing its interface.
EOF_HB

cat > docs/adr/0003-mit-licence.md <<'EOF_HB'
# 0003 — MIT licence for code

**Status:** Accepted · **Date:** 2026-10-13

## Context

The two main candidates were AGPL-3.0, which requires anyone running a modified version as a network service to share their changes, and MIT, which permits almost any use. The owner's priority is visibility and adoption.

## Decision

All code in this repository is released under the **MIT licence**.

## Consequences

- Lowest friction for users, contributors and companies; no corporate "no AGPL" policies to block adoption.
- Anyone may build a closed or commercial product, including a hosted service, from this code without sharing changes. This was accepted knowingly.
- All dependencies in the planned stack use permissive licences, so there are no compatibility conflicts.
- Data and fonts are licensed separately (see ADR 0004; fonts keep their own licences).
EOF_HB

cat > docs/adr/0004-cc0-commons-data.md <<'EOF_HB'
# 0004 — CC0 for shared catalogue data

**Status:** Accepted · **Date:** 2026-10-13

## Context

The Commons is a shared catalogue of bibliographic facts contributed by users: titles, ISBNs, dimensions, cover and spine images. Its main upstream source, Open Library, publishes its metadata as CC0.

## Decision

Bibliographic data contributed to the Commons is released under **CC0** (public domain dedication). Personal data — ownership, location, notes, ratings — never enters the Commons.

## Consequences

- Data can flow both ways with Open Library without licence conflicts.
- Contributors must be told clearly, at the point of contribution, that their bibliographic contributions are public domain.
- Cover images may carry the publisher's copyright regardless of our licence; how cover images are shared needs its own review before a hosted Commons exists.
EOF_HB

cat > docs/adr/0005-shelf-prototype-first.md <<'EOF_HB'
# 0005 — Prototype the shelf before Commons and recognition

**Status:** Accepted · **Date:** 2026-10-13

## Context

ISBN scanning and cataloguing are well served by existing products. The project's distinctive idea is the virtual shelf: books as physical objects with real dimensions, arranged on real shelf space, with different organisations previewed before moving anything. Whether that is genuinely useful has not been tested. Physical dimension data is also sparse in public sources.

## Decision

After Phase 0 setup, build a **throwaway shelf prototype** (Sprint 4) with about 50 of the owner's real books, measured using rulers fixed to the shelves. Defer the Commons and cover/spine recognition until the prototype shows the idea is worth building on.

## Consequences

- The project's core value is tested in days rather than months.
- Early work produces the README showcase GIF.
- The prototype code is expected to be discarded or heavily rewritten; it should not dictate the final data model.
- Measuring books becomes a first-class feature, not an afterthought.
