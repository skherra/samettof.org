# Screen: inspiration

`_layouts/inspiration.html`, pages `pages/inspiration.md` (FR, `/inspiration/`) / `-en.md` (EN, `/en/inspiration/`), `ref: inspiration`.

## Goal

Share recommendations of books and videos that inspired the authors for their diving trips.

## Content and structure

- Page banner (`sea: inspiration`, see `style-guide.md`).
- Two columns: a single static illustration (`/assets/img/inspiration.webp`, 2000×1500 px, see `style-guide.md`) on the left, free Markdown content on the right (`{{ content }}`, list of recommendations with icons by type (book, video) and external links to third-party sites such as Babelio, YouTube, IMDb, Goodreads or publishers' sites).
- Unlike the bonus screen, **no photo gallery** here: the illustration is fixed.

## Interactions

No interaction specific to this screen beyond the external links in the Markdown content (standard opening, browser behavior).

## States (loading, error, empty)

No particular state: fully static content.

## Responsive

Two columns (`col-md-6`) that collapse into a single column below the `md` breakpoint, native behavior of the Bootstrap grid.
