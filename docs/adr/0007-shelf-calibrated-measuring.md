# 0007 — Measure books from photos calibrated by the shelf

**Status:** Accepted · **Date:** 2026-10-13 · Amends [0005](0005-shelf-prototype-first.md)

## Context

ADR 0005 planned to measure about 50 books using rulers fixed to the shelves. The owner does not want to measure books by hand and asked for a method that corrects itself, suggesting photos from the left, the middle and the right of the shelf.

A shelf opening is a rectangle of known size. Four known points in a plane are enough to remove perspective from a photo of that plane, taken from any angle.

## Decision

The prototype covers **one IKEA Billy shelf** and however many books stand on it.

1. The owner tape-measures the shelf opening (inner width and height) once.
2. The spines are pushed flush with the shelf's front edge, so they lie in the plane of the opening.
3. Three photos are taken: from the left, the middle and the right.
4. In each photo the four inner corners of the opening are marked. This gives a homography from pixels to millimetres in the plane of the opening.
5. Spine boundaries are marked by hand on the rectified photo, giving each book's thickness and height.
6. The result is corrected in two ways:
   - each book has three independent measurements; the median is used, and a book whose measurements disagree is flagged;
   - the owner tape-measures the occupied run (first spine's left edge to last spine's right edge), the thicknesses must add up to it, and the residual is spread across the books in proportion to thickness.

Rulers and fiducial markers are not used.

## Consequences

- No hardware beyond a phone and a tape measure.
- The method depends on flush spines. A spine recessed 50 mm reads about 3% narrow from 1.5 m and shifts sideways in off-centre photos. If flush spines prove impractical, two views are enough to solve for each book's recess; that is built only if needed.
- Boundaries are marked by hand in the prototype. Automatic detection is later work and shares ground with spine recognition (Phase 3).
- Book depth (cover width) cannot be measured from the front. The spine view does not need it.
- The prototype shrinks from about 50 books to one shelf, which is enough to judge whether arranging spines is useful.
