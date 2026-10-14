# 0006 — Podman in WSL for development

**Status:** Accepted · **Date:** 2026-10-13 · To be verified in Sprint 2

## Context

The development machine is Windows on Arm. Docker Desktop is installed and used by other projects on it. This project must not collide with their containers, networks, volumes or ports. The owner prefers Podman.

## Decision

- Development uses **rootless Podman inside the WSL Ubuntu distribution**, not Docker Desktop.
- The stack is described by one `compose.yaml` that runs unchanged under both `podman compose` and `docker compose`.
- The documented quick start uses Docker commands, because most contributors have Docker; a note gives the Podman equivalent.

## Consequences

- Nothing is shared with Docker Desktop, so other projects cannot be disturbed.
- Rootless Podman cannot bind host ports below 1024. The project already uses non-default high ports (for example `8740`).
- Podman's compose support needs systemd enabled in WSL; Sprint 2 checks this first.
- Compose features must be limited to what both runtimes support. CI runs the stack under Docker so the contributor path stays tested.
- Reaching the app from a phone needs WSL mirrored networking or a port forward, whichever runtime is used. Sprint 2 settles this.
- If Sprint 2 finds a blocker on arm64, this record is superseded rather than edited.
