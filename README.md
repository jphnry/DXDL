# DXDL Track 2 planner board

This repository contains a static planning board for the eight-week draft in `KLM DXDL Track 2.pdf`.

- `index.html` is the board to publish.
- `board.svg` is a shareable static graphic.
- `.nojekyll` tells GitHub Pages to serve the files directly.

## Publish on GitHub Pages

1. Create a GitHub repository named `dxdl-track-2-board` and upload these three files to its root.
2. In the repository, open **Settings → Pages**.
3. Under **Build and deployment**, select **Deploy from a branch**, choose `main` and `/ (root)`, then save.
4. Share the URL shown under Pages after deployment.

**Access:** Ordinary GitHub Pages sites are publicly accessible, even when the source repository is private. Check whether the draft may be published publicly before enabling Pages. If the board should be team-only, use an access-controlled host instead.

**Progress:** The checkmarks in `index.html` use each visitor's browser storage. Publishing provides one shared view of the plan, but does not make status updates collaborative. Use a shared board service or add authentication and a database for shared progress.

The source PDF has a discrepancy between the calendar and its stated squad-start rule. It also references an undefined Phase 4. The board flags both rather than treating them as settled.
