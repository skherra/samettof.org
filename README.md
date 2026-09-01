samettof.org
============

Diving and travel journal of Sam & Tof (and Ti'Crab): a page per country/
destination visited (dive site description, dive shop, accommodation,
dive log, site maps), a world map, a best-season calendar, an FAQ, and a
few editorial pages. Static site built with Jekyll, hosted on GitHub Pages
at https://www.samettof.org.

See [`specs/`](specs/) for the site's design decisions (functional scope,
data model, technical stack, style guide, screens) and
[`CLAUDE.md`](CLAUDE.md) for how to use them.

## Local development

Requires Ruby (see `.ruby-version`).

    bundle install
    bundle exec jekyll serve

The site is served at http://localhost:4000. CSS is compiled from
`assets/css/samettof.less` to `assets/dist/css/samettof.css` automatically
on each build; this requires `lessc` to be installed locally (see
`specs/technical-specifications.md`).

To check for broken links, as CI does:

    bundle exec htmlproofer ./_site

## Adding content

A new destination needs, for each language:

- `pages/<ocean>/<slug>.md` (French) and `<slug>-en.md` (English), with a
  shared `ref` (see `specs/data-model.md` for the front matter fields).
- A matching `_data/countries/<ref>.yml` with the ratings, water
  temperature, best seasons and fauna.
- Photos under `photos/<ref>/`: no listing to maintain, the gallery is
  built by scanning that folder at build time.

See `specs/data-model.md` for the exact file formats and naming
conventions.

## Deployment

Automatic, via GitHub Actions (`.github/workflows/jekyll.yml`) on every
push to `master`.
