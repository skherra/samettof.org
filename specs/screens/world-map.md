# Screen: world map

`_layouts/map.html`, pages `pages/world-map.md` (FR, `/carte/`) / `-en.md` (EN, `/en/map/`), `ref: world-map`.

## Goal

Give a geographical overview of all the places visited by the authors, dives as well as stopovers without a dedicated page.

## Content and structure

- No page banner (the layout does not include `page-banner.html`, unlike the other screens apart from the home page).
- Full-screen Leaflet map (`#worldMap`, height `calc(100vh - 66px - 36px)`, between the header and the footer), centered on `[0, 0]`, initial zoom 2, Esri World Imagery satellite tile layer (see `style-guide.md`).
- One marker per entry of `_data/world-map.yml` (see `data-model.md` for the field details), plus a "Home sweet home" marker (dedicated `homeIcon` icon) in Paris.

## Interactions

- **Click on a marker**: opens a standard Leaflet popup (native library behavior, no custom JS) showing the place label, possibly a link to its country page if the point has a `ref` (see `data-model.md`), and the visit date.
- Map zoom/pan: standard Leaflet interactions (mouse wheel, drag, +/- buttons).
- No filter by ocean, season or place type: all markers are displayed at once.

## States (loading, error, empty)

- No particular state: the list of markers comes entirely from `_data/world-map.yml`, present at every build.

## Responsive

No custom media query: the map always takes up `calc(100vh - 66px - 36px)`, regardless of screen size; touch zoom/pan is handled natively by Leaflet on mobile.
