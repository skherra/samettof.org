# Screen: country / destination page

`_layouts/country.html`, generic screen shared by the site's 33 destination pages (see `data-model.md`): this document does not describe a particular destination, but the behavior common to all of them, driven by the page's front matter and by `_data/countries/<ref>.yml`. Any difference between destinations is limited to content, never to behavior.

## Goal

Give the visitor all the useful information to assess and prepare a dive in this destination: presentation, ratings, practical information, first-hand accounts, photo gallery and dive site maps.

## Content and structure

- Page banner (`page-banner.html`, see `style-guide.md`): ocean name + `page.h1` (destination name preceded by a flag).
- Four stacked blocks, each on two columns (`container-fluid`, see `style-guide.md` for the visual details):
  1. **Presentation** (`country-about.html`, `page.country-desc` + optional accordion `country-desc-sections`) + **photo gallery** (`country-carousel.html`).
  2. **Ratings** (`country-opinion.html`, 4 progress bars) + **practical information** (`country-practical.html`, Dive shop/Accommodation/To see accordion).
  3. **Dive log** (`country-logbook.html`, `page.log-books`) + **good to know** (`country-good-to-know.html`, temperature, season, fauna).
  4. **Dive site maps** (`country-map.html`), full width, **displayed only if the destination has a `maps` field** (21 of the 33 destinations, see `data-model.md`).

See `data-model.md` for the details of the front matter and `_data/countries/<ref>.yml` fields consumed by each of these blocks.

## Interactions

- **Photo gallery**: the main carousel displays the thumbnails; clicking a thumbnail opens a full-screen modal positioned on the clicked photo (`$('#modalCarousel').carousel(index)`), with its own arrows, without autoplay unlike the main carousel (see `style-guide.md`).
- **"Presentation" accordion** (if `country-desc-sections` is set) and **"Practical information" accordion**: open/close on click, standard Bootstrap behavior. The first panel of "Practical information" is open by default; the "Presentation" accordion is closed by default (no initial panel enforced observed).
- **Dive log**: autoplay (10s) between the excerpts if there are several entries, manual navigation possible through the custom arrows.
- **Maps**: standard Leaflet popup on marker click, showing only the `place` label of the point (see `style-guide.md`). Unlike the world map, a `maps` point does not become a link even if it has a `ref` (see `data-model.md`): this field exists in the data but is not used by this screen.

## States (loading, error, empty)

- **`country-practical.html` has no conditional guard**: the three panels (Dive shop, Accommodation, To see) are always displayed, even if the associated text is very short. In practice, `dive-shop`/`accommodation`/`to-see` are always filled in (see `data-model.md`).
- **`country-logbook.html` has no conditional guard** on `log-books`: if this field were empty, the "Log Book" title and an empty carousel would still be displayed. Not observed in practice (every destination has at least one entry).
- **`country-map.html` has a conditional guard** (`{%- if mapList -%}`): the "Dive site maps" block is not displayed at all for the 12 destinations without a `maps` field (see `data-model.md`).
- **`country-about.html`**: the sub-section accordion is only displayed if `country-desc-sections` is set (7 destinations out of 33, see `data-model.md`).

## Responsive

No custom media query: two-column layout (`col-md-6`) that collapses into a single column below the `md` breakpoint, native behavior of the Bootstrap grid.
