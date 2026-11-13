# Screen: bonus

`_layouts/bonus.html`, pages `pages/bonus.md` (FR, `/bonus/`) / `-en.md` (EN, `/en/bonus/`), `ref: bonus`.

## Goal

Share a selection of hot springs visited by the authors, outside the strict scope of diving.

## Content and structure

- Page banner (`sea: bonus`, see `style-guide.md`).
- Two columns: free Markdown content on the left (`{{ content }}`, list of hot springs with links to the matching country pages when they exist, see `data-model.md`), photo gallery on the right.
- The gallery reuses **exactly the same component** as the destination pages (`country-carousel.html`, see `screens/country.md` and `style-guide.md`), applied to the `photos/bonus/` folder since `page.ref == "bonus"` (see "Images" in `data-model.md`).

## Interactions

Identical to the photo gallery of a destination page: thumbnail carousel with autoplay, click to open the full-screen modal positioned on the chosen photo (see `screens/country.md`).

## States (loading, error, empty)

No particular state documented: the gallery depends on the content of `photos/bonus/`, added manually to the repository.

## Responsive

Two columns (`col-md-6`) that collapse into a single column below the `md` breakpoint, native behavior of the Bootstrap grid.
