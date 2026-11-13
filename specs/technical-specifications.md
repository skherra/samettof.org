# Technical specifications

## Technical stack

### Site generation

- **Jekyll 4.4.1**: layouts, includes, front matter, `_data/`, pages (no collections).
- **Ruby 3.3.12** (`.ruby-version`).
- `webrick` (local development server), `html-proofer` (dead link check in CI, see "Hosting and deployment"), `json`.
- No Jekyll plugin packaged as a gem (the `Gemfile` only declares `jekyll`, `webrick`, `json`, `html-proofer`): the site's only build extension is a local file, `_plugins/less_compiler.rb`, loaded automatically by Jekyll.
- No `plugins:` or `collections:` section in `_config.yml`.

### CSS / UI

- **LESS**, compiled to CSS by a Jekyll hook (`_plugins/less_compiler.rb`) rather than at build time: a single source file, `assets/css/samettof.less`, compiled to `assets/dist/css/samettof.css`.
- **Bootstrap 4.6.2** (not Bootstrap 5): grid, navbar, carousel, modal, accordion (`card`/`collapse`), progress bars. Vendored in `assets/dist/` (not loaded from a CDN).
- **jQuery 3.7.1 ("slim" build)** vendored, required by the Bootstrap 4 bundle (unlike Bootstrap 5, which has no jQuery dependency).
- **Leaflet 1.9.3** vendored (`assets/dist/css/leaflet.min.css`, `assets/dist/js/leaflet.min.js` + icons in `assets/dist/images/`): interactive maps (see "Architecture" below).
- **Font Awesome**, loaded through a remote Kit (`https://kit.fontawesome.com/7dfeb2d2f7.js`), with the same kit identifier as on another site of the author, which suggests a Font Awesome account shared across several projects.
- **Google Fonts**: Ubuntu only, loaded through the old `css?family=Ubuntu` API (not `css2`), with no explicit weight in the URL. Only weight 400 is therefore actually loaded, whereas headings use `font-weight: bolder` (relative CSS keyword): the "bold" rendering of headings is therefore probably a browser-synthesized bold rather than an actually loaded Ubuntu weight. See `style-guide.md`.
- Design values (colors, typography, spacing) are defined in `style-guide.md`, not here.

### JavaScript

- **Vanilla JS + jQuery plugins** for the custom interactions: `assets/js/jquery.appear.js` (third-party plugin, detects when an element enters the viewport) and `assets/js/counter.js` (`$.fn.countTo` plugin + site-specific initialization code), both used only for the animated counters on the home page (see `screens/home.md`).
- All the other interactions (carousel, modal, accordion, burger menu) are delegated to the Bootstrap 4 components through `data-*` attributes, without custom JS.
- No JS framework (React, Vue, Angular), no bundler.
- No script is loaded with `defer` or `async`.

### Not used

- Node.js committed in the repository (no `package.json`, `node_modules/`), although the LESS hook depends on the `lessc` binary installed globally via npm on the build machine (see "Local maintenance scripts" below): it is a local development tool, not a dependency of the repository.
- JS bundler, custom CSS framework beyond Bootstrap, SCSS/Sass (LESS only, despite `jekyll-sass-converter` being present as a transitive dependency of Jekyll in `Gemfile.lock`: this gem is not used).
- Database, backend or own API.
- Cookies, tracking, analytics.
- `jekyll-sitemap` plugin (the sitemap is a hand-made Jekyll page, see "SEO").
- Content Security Policy, JSON-LD.
- Data validation script (see "General conventions" in `data-model.md`).

---

## Hosting and deployment

- **Host:** GitHub Pages
- **Domain:** `www.samettof.org` (`CNAME` file at the root, with the `www` subdomain)
- **Deployment:** automatic, via GitHub Actions (`.github/workflows/jekyll.yml`), triggered on push to the `master` branch, or manually (`workflow_dispatch`)
- **Build (`build` job, 15-minute timeout):**
  - `actions/checkout@v7`
  - `ruby/setup-ruby` (pinned by commit SHA, `bundler-cache: true`)
  - `actions/configure-pages@v6`
  - `bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"`, environment variable `JEKYLL_ENV: production`, run explicitly rather than delegated to the native GitHub Pages integration
  - `actions/upload-pages-artifact@v5`
- **Link check:** `html-proofer` runs on `_site/` after the build, with `continue-on-error: true` (reports dead links without failing the deployment). Options: `--ignore-urls` (Google Fonts, and several diving partner domains cited in the editorial content), `--ignore-status-codes "429,403"`, `--no-check-external-hash`.
- **Deployment (`deploy` job):** `actions/deploy-pages@v5`, `github-pages` environment.
- **Dependabot** (`.github/dependabot.yml`): weekly updates of GitHub Actions and gems (`bundler`).

---

## Architecture (page generation, routing)

### Rendering

The site is fully static, generated at build time by Jekyll. No dynamic server-side rendering, no own API.

### Page generation

Unlike a mechanism based on a `Jekyll::Generator` plugin, **every page of the site is a Markdown file committed** to the repository (country pages included): no page is generated in memory at build time. The photo galleries (country and bonus pages) are not individual pages per photo: they are scans of `site.static_files` when an existing page is rendered (see "Images" in `data-model.md`), not separate pages.

### URL structure

| Page type | Layout | FR example | EN example |
|---|---|---|---|
| Home | `index` | `/` | `/en/` |
| Country page | `country` | `/indien/maldives/` | `/en/indian/maldives/` |
| World map | `map` | `/carte/` | `/en/map/` |
| Calendar | `calendar` | `/calendrier/` | `/en/calendar/` |
| FAQ | `faq` | `/faq/` | `/en/faq/` |
| Bonus | `bonus` | `/bonus/` | `/en/bonus/` |
| Inspiration | `inspiration` | `/inspiration/` | `/en/inspiration/` |
| 404 | `404` | `/404.html` (single, bilingual page) | n/a |
| robots.txt | `null` | `/robots.txt` | n/a |
| sitemap.xml | `null` | `/sitemap.xml` | n/a |

French pages have no language prefix (French = default language); English pages are prefixed with `/en/`. For country pages, the ocean segment and the destination slug are **translated independently per language** in the `permalink` (e.g. `indien` → `indian`, `mer-rouge` → `redsea`, `hawai` FR → `hawaii` EN): see "Naming conventions" below and "General conventions" in `data-model.md` for the warning about `ref` vs `permalink`.

### Interface strings

No centralized translation file: each conditional label is written directly in the layouts and includes, in the form `{% if page.lang == "fr" %}...{% else %}...{% endif %}` (repeated in most of the `country-*`, `home-*` includes and `page-banner.html`). The other multilingual content goes through `fr-*`/`en-*` keys in the `_data/*.yml` files (see "General conventions" in `data-model.md`).

---

## Local maintenance scripts

Only one mechanism of this kind on this site:

| Mechanism | File | Role | Trigger |
|---|---|---|---|
| LESS → CSS compilation | `_plugins/less_compiler.rb` | Recompiles `assets/dist/css/samettof.css` from `assets/css/samettof.less` if the source is newer than the compiled file | Jekyll hook (`pre_render`), on every local `jekyll serve`/`jekyll build` |

No `scripts/` folder, no `Rakefile`, no local generation of thumbnails or detail pages beyond this hook.

---

## Performance

- Lazy loading (`loading="lazy"`) on some images: header logo, home carousel, home portfolio, team, country page carousel thumbnails, images of the calendar's monthly modals. **Absent** on the images of the galleries' full-screen modal and on the static image of the inspiration page.
- All photos are in WebP format.
- No script is loaded with `defer`/`async` (see "JavaScript" above).
- No cookies, no tracking, no analytics.

---

## Accessibility

- **Target browsers:** not explicitly documented in the code; in the absence of a known requirement, latest stable versions of evergreen browsers (Chrome, Firefox, Safari, Edge).
- `aria-label` present on the standard Bootstrap interactive components (modal close button, navbar "burger" button) as well as on the footer license link (label localized according to `page.lang`).
- Alternative text on images: uneven quality. Descriptive on some blocks (team, home portfolio), but often literal or empty on the photo carousels (country galleries, home carousel): known accessibility limitation, not fixed to date.
- Navigation: standard Bootstrap 4 components (modal, accordion, dropdown), no custom keyboard handling beyond their native behavior.
- `role="main"` on the `<main>` element of each layout.
- **Known limitation:** the Leaflet maps (world map, destination maps, 404 page) rely on mouse/touch interaction (popup on marker click) without a textual alternative listing the same information.

---

## SEO

- Static rendering: each page exists independently at crawl time.
- Basic tags in `_includes/head.html`: `<meta name="description">`, `<meta name="author">`, `<title>`, `canonical` link.
- **hreflang** generated manually in Liquid (no plugin): `site.pages | where: "ref", page.ref`, sorted by language, one `<link rel="alternate" hreflang="...">` tag per existing language version.
- Full **Open Graph**: `og:type`, `og:site_name`, `og:title`, `og:description`, `og:url`, `og:locale` (`fr_FR`/`en_US` according to `page.lang`) and `og:image`. Logic: looks for `/photos/<page.ref>/0001.webp` in `site.static_files`, otherwise falls back to `/assets/img/dive-flag.webp`.
- **Twitter Card** (`summary_large_image`, title, description).
- **No JSON-LD**, **no CSP tag** (`Content-Security-Policy`) on this site.
- `robots.txt` (Jekyll page, `layout: null`): allows indexing, references `sitemap.xml`.
- **`sitemap.xml`**: auto-generated Jekyll page (`layout: null`, Liquid loop over `site.pages`), not the `jekyll-sitemap` plugin. It lists as a `<url>` entry every page where `page.title` is set, FR and EN alike, excluding the pages marked `sitemap.exclude: 'yes'` (mechanism used by `sitemap.xml` itself and by `404.md` to exclude themselves). Each entry includes, via `site.pages | where: "ref", page.ref`, the full set of `hreflang` alternates (self-referencing included), in line with Google's recommended practice for multilingual sitemaps. Includes `image:image` extensions for the photos of a country page.
- No ownership verification file (Google Search Console or equivalent) was identified at the root during this investigation: to be checked if such a mechanism is used.

---

## File structure

```
/
├── _config.yml
├── CNAME                            # www.samettof.org
├── 404.md                           # single, bilingual page
├── index.md / index-en.md           # home (FR / EN)
├── robots.txt / sitemap.xml         # auto-generated Jekyll pages, layout: null
│
├── _layouts/
│   ├── index.html                   # home: carousel + manifesto + portfolio + team + counters
│   ├── country.html                 # country page: about + carousel + opinion + practical + logbook + good-to-know + map
│   ├── map.html                     # full-screen world map (Leaflet)
│   ├── calendar.html                # 12-month grid + per-month modal
│   ├── faq.html                     # accordion
│   ├── bonus.html                   # content + gallery
│   ├── inspiration.html             # content + static image
│   ├── default.html                 # unused: no page or layout has `layout: default`
│   └── 404.html
│
├── _includes/
│   ├── head.html                    # <head>: meta, OG, hreflang, fonts, CSS, conditional Leaflet
│   ├── header.html                  # fixed navbar (top): menu, per-ocean submenus
│   ├── footer.html                  # fixed navbar (bottom): CC license, language switcher
│   ├── scripts.html                 # JS scripts at the end of <body>
│   ├── page-banner.html             # page banner (except home), variant per `sea`
│   ├── home-carousel.html, home-manifest.html, home-portfolio.html, home-team.html, home-counters.html
│   └── country-about.html, country-carousel.html, country-good-to-know.html, country-logbook.html,
│       country-map.html, country-opinion.html, country-practical.html
│
├── _plugins/
│   └── less_compiler.rb             # recompiles samettof.less -> samettof.css on local build
│
├── assets/
│   ├── css/samettof.less            # single source of custom styles
│   ├── dist/                        # Bootstrap 4.6.2, jQuery slim, Leaflet 1.9.3, samettof.css (compiled)
│   ├── js/                          # jquery.appear.js, counter.js (not vendored, see "JavaScript")
│   ├── img/                         # logo, per-ocean banners, inspiration image, map icons
│   └── src/                         # .psd sources of the map icons
│
├── docs/                            # dive maps and itineraries (image/PDF), referenced from the content
│
├── pages/<ocean>/<slug>[-en].md     # country pages, 6 per-ocean folders (atlantic, caribbean, indian,
│                                     # mediterranean, pacific, redsea)
├── pages/{calendar,world-map,faq,bonus,inspiration}[-en].md
│
├── _data/
│   ├── countries/<ref>.yml          # one file per country (33), bilingual structured data
│   └── calendar.yml, home-manifest.yml, home-team.yml, menu.yml, portfolio.yml, world-map.yml   # bilingual, single file
│
└── photos/
    ├── <ref>/NNNN[-th].webp         # photos + thumbnails per country (and `bonus/`)
    ├── home-carousel/, home-portfolio/, home-team/, calendar/   # images of the home / calendar blocks
```

### Configuration (`_config.yml`)

```yaml
url: "https://www.samettof.org"
baseurl: ""

title: "Sam & Tof | Plongée"
description: "Sam & Tof - Plongée sous marine et voyages"
author: "Sam & Tof"
lang: "fr"

timezone: Europe/Paris
encoding: utf-8

exclude:
  - Gemfile
  - Gemfile.lock
  - vendor/
  - .bundle/
  - .sass-cache/
  - .jekyll-cache/
  - README.md
  - specs/
  - CLAUDE.md
```

No plugin declared (see "Site generation" above). `exclude:` removes `specs/` and `CLAUDE.md` from the build: they are working files of the repository, not site content, and Jekyll would otherwise publish them as-is under `_site/`.

---

## Naming conventions

| Element | Convention | Example |
|---|---|---|
| `ref` (technical identifier, shared by both languages) | English kebab-case | `french-polynesia`, `mexico-baja-california` |
| `permalink` (public URL) | translated independently per language, including the ocean segment for country pages | `/indien/maldives/` (FR) vs `/en/indian/maldives/` (EN) |
| Markdown/YAML/LESS files | kebab-case | `world-map.yml`, `samettof.less` |
| CSS identifiers/classes | simple semantic names, no enforced prefix | `#worldMap`, `.page-banner`, `.portfolio-item-content` |
| JS variables/functions | camelCase | `countTo()`, `diveFlagIcon` |
| Gallery images | `NNNN.webp` (4 digits) + `NNNN-th.webp` for the thumbnail | `photos/maldives/0001.webp` / `0001-th.webp` |
