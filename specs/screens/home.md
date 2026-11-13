# Screen: home

`_layouts/index.html`, pages `index.md` (FR) / `index-en.md` (EN), `ref: home`.

## Goal

Present the authors (Sam, Tof, Ti'Crab) and give access to the various sections of the site, highlighting the latest dives and the extent of the trips made.

## Content and structure

Five blocks assembled in this order (no page banner, unlike the other screens, see `page-banner.html` in `style-guide.md`):

1. **Carousel** (`home-carousel.html`): full-screen gallery of the photos in `photos/home-carousel/` (see "Images" in `data-model.md` for how the list is built dynamically). Overlaid caption: `page.h1` / `page.h2` (front matter, see `data-model.md`).
2. **Manifesto** (`home-manifest.html`): 8 blocks of icon + title + text (`_data/home-manifest.yml`, see `data-model.md`).
3. **Portfolio** (`home-portfolio.html`): grid of "latest dives" photos (`_data/portfolio.yml`), each tile linking to the matching country page with its label and visit date.
4. **Team** (`home-team.html`): one column per member (`_data/home-team.yml`), photo, interests as progress bars, optional Instagram link.
5. **Counters** (`home-counters.html`): 4 animated key figures (countries visited, dives, cruises, "happy divers").

See `style-guide.md` for the visual details of each component.

## Interactions

- **Carousel**: autoplay, clickable indicators, standard Bootstrap arrows (see `style-guide.md`).
- **Portfolio tile**: click navigates to the matching destination page; hover triggers an image zoom and reveals the caption (hidden by default, unlike the calendar where it is always visible, see `style-guide.md`).
- **Counters**: the increment animation starts as soon as the page loads, then a second time the first time the block enters the viewport (scroll).

## States (loading, error, empty)

- The counter values are hard-coded in `home-counters.html` (see `style-guide.md`): no "empty" or computed state is possible.
- The carousel, the portfolio and the team all depend on data hard-coded in the repository (`_data/*` files or the `photos/home-carousel/` folder): no documented fallback behavior if one of these files were empty.

## Responsive

- No custom media query (see "Spacing and grid" in `style-guide.md`): the layout depends solely on the Bootstrap grid.
- The carousel caption (`h1`/`h2`) is hidden below the `md` breakpoint (`d-none d-md-block`).
