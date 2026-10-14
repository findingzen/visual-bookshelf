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
