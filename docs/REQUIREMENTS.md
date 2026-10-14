# Requirements

The owner's original brief from Planning Session 0 (2026-10-13), lightly edited for clarity. `docs/ARCHITECTURE.md` explains how each one is met. If a requirement changes, edit it here and note the date.

## Product

1. **Identify books** through (a) ISBN barcode scan and, later, (b) cover and spine recognition.
2. **Low-cost hardware** for scanning barcodes, covers and spines.
3. **Low to zero API costs** for identifying a book.
4. **Persistent and secure storage** for each person's library; redundant storage later.
5. **Shared lookup:** new titles and supplemental information go into a global catalog that augments publicly available sources.
6. **Custom views,** so not all title information has to be shown at once.
7. **Progressive web app** that works on desktop and mobile, independent of the host OS.
8. **Django backend with a non-React frontend.** Open to changing this for good reasons.
9. **Physical location tracking** that doesn't depend on the real room layout. Total shelf space is treated as one linear run; the app suggests organizations and sortings, and virtually fills shelves using each book's width and position. Every book is a visual, movable object with physical dimensions and a spine that resembles the real one (standardized spines first, variation later). This shows both the collection as it is and how different groupings would look.
10. **Documentation-first open source.** Docs and READMEs are updated at the end of every planning session and sprint.
11. **Match the owner's documentation style** from the docgen project. *(Sample shared 2026-10-13: docgen's "Settled Design" file.)*
12. **Beautiful UI,** suited to lovers of art and books.

## Process

13. **Each sprint starts with detailed instructions, one step at a time,** in case the owner gets stuck.
14. **Clear separation** of what runs in Claude chat versus Claude Code.
15. **Initial sprints:** create the repo on GitHub and locally; keep its SSH setup from disturbing other projects; choose a Windows-on-Arm dev architecture that doesn't conflict with other local projects; set up and tune Claude Code for this project.

## Added during Session 0

- **Shelf prototype early:** validate the virtual shelf with ~50 real books before building the shared catalog or recognition.
- **Measuring with rulers:** rulers fixed to shelf edges give a photo scale; spine widths come from coordinate distances.
- **Open-source readiness:** showcase GIF or demo, two-minute quick start, ADRs, contributor on-ramp, visible design quality.
- **Ownership:** the project lives under the `findingzen` GitHub account.

## Changed during Session 1 (2026-10-13)

- **Prototype scope:** one IKEA Billy shelf and the books on it, replacing "~50 real books".
- **Measuring:** no measuring books by hand and no rulers. Photos from the left, middle and right of the shelf, calibrated by the shelf's known dimensions, with a method that corrects itself.
- **Design is a forethought:** the design direction is set before the prototype is drawn. Tailwind is too sterile for this project.
- **Podman** is preferred over Docker Desktop for development.
