# Screen: calendar

`_layouts/calendar.html`, pages `pages/calendar.md` (FR, `/calendrier/`) / `-en.md` (EN, `/en/calendar/`), `ref: calendar`.

## Goal

Help the visitor choose a travel period by listing, month by month, the site's destinations whose best diving season it is.

## Content and structure

- Page banner (`sea: next`; the first `h1` of the banner stays empty since `next` matches none of the six oceans, see `style-guide.md`).
- Grid of 12 tiles, one per month (`_data/calendar.yml`, see `data-model.md`), same visual treatment as the home portfolio (see "Portfolio" in `style-guide.md`), except that the month caption is always visible (not only on hover).

## Interactions

- **Click on a month tile**: opens a Bootstrap modal listing, in alphabetical order, every destination for which at least one `best-seasons` entry (`_data/countries/<ref>.yml`, see `data-model.md`) covers that month, with a link to each country page. The logic handles seasons spanning two calendar years (e.g. December → April). A destination with several `best-seasons` entries matching the same month appears only once in the list.
- **Hover over a tile**: slight zoom of the background image (see `style-guide.md`).

## States (loading, error, empty)

- All the `best-seasons` entries of each destination are taken into account for the monthly listing (only one destination has several: `indonesia`, 3 entries).
- A month with no matching destination displays an empty modal (behavior not explicitly verified).

## Responsive

No custom media query: standard Bootstrap grid (`col-*`), standard Bootstrap modal.
