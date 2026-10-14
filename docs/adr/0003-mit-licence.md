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
