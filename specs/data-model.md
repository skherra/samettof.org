# Data model

## Overview

The site carries several content families, each with its own front matter and, for some, its own `_data/*.yml` file:

- **Country / destination page** (see `screens/country.md`): about thirty pages, each combining a rich front matter (editorial text) and a `_data/countries/<ref>.yml` file (numeric and structured data).
- **Home page**, **world map**, **calendar**, **FAQ**, **bonus**, **inspiration**: one functional page each, driven by one or more dedicated `_data/*.yml` files.
- **404 page**: a single page, with no per-language counterpart.

Every page (except the 404) exists as two Markdown files, one per language, linked by a shared `ref` field (see "General conventions" below). No script automatically validates the consistency of this data (see "General conventions").

## Home page (front matter)

`index.md` (French, `permalink: /`) and `index-en.md` (English, `permalink: /en/`), `layout: index`, `ref: home`:

```yaml
layout: index
ref: home
permalink: /

lang: fr
lang-flag: 🇫🇷

title: Sam & Tof | Plongée
description: Sam & Tof - Plongée sous-marine et voyages
h1: Sam & Tof | Plongée sous-marine
h2: Des informations utiles pour préparer un voyage plongée&nbsp;!
```

| Field | Role |
|---|---|
| `h1` | Title overlaid on the home carousel |
| `h2` | Subtitle displayed below the `h1` |

The Markdown content after the front matter is not used (the `index.html` layout only assembles includes driven by `_data/*`, see `screens/home.md`).

The full-screen home carousel has no dedicated data file: as for the country page galleries (see "Images" below), its photo list is an automatic scan of `site.static_files`, here on `photos/home-carousel/`. Naming convention different from the country galleries: `NNN.webp` (3 digits, e.g. `001.webp` to `014.webp`), without a `-th.` thumbnail.

### Home page data

| File | Role |
|---|---|
| `_data/home-manifest.yml` | 8 items of the "manifesto" block (`icon`, `fr-title`/`en-title`, `fr-text`/`en-text`), bilingual in a single file (see "General conventions") |
| `_data/home-team.yml` | Team presentation, bilingual in a single file (see below) |
| `_data/portfolio.yml` | Selection of "latest dives" photos, bilingual (see below) |

`_data/home-team.yml`:

```yaml
- img: sam.jpg
  name: Sam
  likes:
    - fr-label: La nature et les grands espaces
      en-label: Nature and the great outdoors
      grade: 90
  insta: christophe.uw
```

| Field | Description |
|---|---|
| `img` | File name in `photos/home-team/`, written as `.jpg` in the YAML but served as `.webp` through a Liquid filter `\| replace: '.jpg', '.webp'` (leftover from an old convention, see `technical-specifications.md`) |
| `name` | Displayed first name |
| `likes` | List of interests, each with `fr-label`/`en-label` and `grade` (0-100, displayed as a progress bar) |
| `insta` | Optional: Instagram handle, absent for Sam, present for Tof (`christophe.uw`) and Ti'Crab (`TiCrab_travels`) |

`_data/portfolio.yml`:

```yaml
- img: marseille.webp
  page-ref: france
```

| Field | Description |
|---|---|
| `img` | File name in `photos/home-portfolio/` |
| `page-ref` | `ref` of the associated country page; the displayed label and date (`visited-in`) are read from that target page via `site.pages \| where: "ref", page-ref \| where: "lang", page.lang`, not duplicated in `portfolio.yml` |

The same `page-ref` can appear several times with different `img` values (e.g. `france` ×3, `philippines` ×2).

## Country / destination page

### Front matter

One file per language at the root of `pages/<ocean>/` (French) and `pages/<ocean>/<slug>-en.md` (English), `layout: country`:

```yaml
layout: country
ref: maldives
permalink: /indien/maldives/

lang: fr
lang-flag: 🇫🇷

title: Plongée aux Maldives
description: Sam & Tof - Plongée sous-marine aux Maldives

sea: indian
menu: Maldives
visited-in: Décembre 2015
h1: 🇲🇻 Maldives

country-desc: |
  Destination presentation text (Markdown).

country-desc-sections:      # optional, see below
  - title: Cerbère Banyuls
    text: |
      Markdown text

dive-shop: |
  Markdown text about the dive shop(s) used.

accommodation: |
  Markdown text about the accommodation.

to-see: |
  Markdown text about non-diving activities.

log-books:
  - author: Sam
    place: Guraidhoo Kandu - South Male Atoll
    date: 25/12/2015
    text: |
      Markdown account of a specific dive.
```

| Field | Role |
|---|---|
| `ref` | Identifier shared between the two languages of this page (see "General conventions"); also the key to `_data/countries/<ref>.yml` and to the `photos/<ref>/` folder |
| `permalink` | Translated independently per language, including the ocean segment (see "Naming conventions" in `technical-specifications.md`) |
| `sea` | One of the six oceans (`atlantic`, `caribbean`, `indian`, `mediterranean`, `pacific`, `redsea`), drives the visual variant of the page banner (see `style-guide.md`) |
| `menu` | Short label without emoji, used as the alternative text (`alt`) of the photo in the home portfolio |
| `visited-in` | Visit date(s) as free text (e.g. "Décembre 2015"), displayed in italics in the practical block |
| `h1` | Destination name preceded by the country's ISO flag emoji; displayed at the top of the country page (see `style-guide.md`) and reused as the text of the links to this page in the navigation submenu, the home portfolio and the world map (default fallback, see "World map (front matter and data)" below) |
| `country-desc` | Presentation text (Markdown), may contain links to files in `docs/` (see below) |
| `country-desc-sections` | **Optional**, present on only 7 of the 33 country pages (`indonesia`, `france`, `italy`, `french-polynesia`, `philippines`, `mexico-baja-california`, `egypt`): list of sub-sections (`title`/`text`) displayed as an accordion below `country-desc`, for destinations covering several distinct geographical sites |
| `dive-shop`, `accommodation`, `to-see` | Always present (verified without exception on the existing pages), displayed in a 3-panel accordion even if the text is short |
| `log-books` | Always at least one entry (verified without exception); `author`, `place`, `date` (free text, not always in DD/MM/YYYY format), `text` (Markdown) |

All the other fields (`layout`, `ref`, `permalink`, `lang`, `lang-flag`, `title`, `description`, `sea`, `menu`, `visited-in`, `h1`, `country-desc`, `dive-shop`, `accommodation`, `to-see`, `log-books`) are present on all 33 country pages without exception.

### Structured data (`_data/countries/<ref>.yml`)

One file per country, named after `ref` (33 files, 1:1 match with the country pages):

```yaml
difficulty: 70
visibility: 60
diversity: 80
atmosphere: 70

water-temperatures:
  - fr-water-temperature-period: En décembre
    en-water-temperature-period: In December
    water-temperature: 30
    fr-water-temperature-comment: Tubbataha & Coron   # optional
    en-water-temperature-comment: Tubbataha & Coron   # optional

best-seasons:
  - fr-best-season-from: décembre
    fr-best-season-to: avril
    en-best-season-from: December
    en-best-season-to: April
    fr-best-season-comment:      # optional, sometimes empty
    en-best-season-comment:

fauna:
  - fr-name: Requins baleines
    en-name: Whale sharks
    strong: true       # optional: highlights the name in the display

maps:                   # optional, see below
  - id: cerbere
    center-lat: 43.333578
    center-lng: 3.960239
    zoom: 8
    points:
      - lat: 42.447914
        lng: 3.171583
        icon: diveFlagIcon
        place: Canadelles
```

| Field | Description |
|---|---|
| `difficulty`, `visibility`, `diversity`, `atmosphere` | Integers 0-100, always present on all 33 files, displayed as "x/10" progress bars (see `screens/country.md`) |
| `water-temperatures` | Always present, one entry per distinct period (usually a single one; 8 destinations have several: `bonaire`, `egypt`, `france`, `french-polynesia`, `martinique`, `mexico-baja-california`, `philippines` (2 each), `indonesia` (3)). `water-temperature` is an integer in most cases, but thirteen destinations out of thirty-three have at least one text range (e.g. `"17-20"`): `azores`, `costa-rica-cocos`, `egypt`, `galapagos`, `iceland`, `italy`, `madagascar`, `mexico-baja-california`, `micronesia`, `palau`, `sao-tome`, `south-africa`, `spain` |
| `best-seasons` | Always present, same structure with possible multiple entries (only one destination has several: `indonesia`, 3 entries) |
| `fauna` | Always present, list of variable length (2 to 42 entries observed) |
| `maps` | **Optional**, present on 21 of the 33 files (the 12 without a map: belize, canary-islands, cape-verde, hawaii, japan, les-saintes, madagascar, maldives, mozambique, sao-tome, south-africa, tanzania). One entry per map (a destination can have several, up to 4 for the Philippines), each map with its own `points` (see "Interactive maps" in `style-guide.md` for the display and grid layout) |

`maps[].points[].icon` is either `diveFlagIcon` (well-explored site) or `diveFlagIconGrey` (secondary/less-explored site). A point can also carry a `ref` and `fr-date`/`en-date` in the data (e.g. `_data/countries/france.yml`), but `country-map.html` only reads `point.place` to build the popup: these fields are present in the YAML without being used by the current template (see "Interactive maps" in `style-guide.md`).

### Images (`photos/<ref>/`)

Convention shared by all the galleries of the site (country pages and bonus page, see below):

| File | Role |
|---|---|
| `NNNN.webp` (4 digits) | Full-resolution photo, displayed in the full-screen modal |
| `NNNN-th.webp` | Thumbnail used in the page carousel. If the original photo is already ≤ 600 px wide, the thumbnail is a file identical to the original (observed on `maldives/0001.webp`); otherwise, largest dimension reduced to 600 px |

**No explicit list in the front matter**: a page's gallery is built by an automatic scan of `site.static_files` filtered on `photos/<page.ref>/*.webp` (excluding the `-th.` files for the main list). Adding a photo to the right folder is enough, without touching the front matter (see `screens/country.md`).

The first file `0001.webp` of a folder is also the page's default Open Graph image (see "SEO" in `technical-specifications.md`).

### Maps and attached PDFs (`docs/`)

`docs/` contains dive maps and an itinerary as images (`.webp`) or PDF, referenced **only from the Markdown text** of `country-desc` (never in structured front matter), with the same file used by both languages:

```markdown
**<i class="fa fa-mail-forward"></i>**{: .accent-color} Voici la carte des sites de plongées : [<i class="fa fa-map"></i>](/docs/south-africa-alishoal-map.webp){: target="_blank"}.
```

Naming convention: `<ref>-<description>.webp` (or `.pdf`), with one observed exception (`docs/lanzarote-guia-ideal.pdf`, referenced from the `canary-islands` page, named after the locality rather than the page's `ref`).

## 404 page

`404.md`, `layout: "404"`, `ref: "404"`, `permalink: /404.html`, `sitemap: {exclude: 'yes'}`. Unlike the other pages of the site, there is **a single 404 page** for both languages (`lang-flag: 🇫🇷 🇬🇧`, `lang: fr`), displaying a Leaflet map centered on a fictional oceanic point ("Nemo Point").

## World map (front matter and data)

`pages/world-map.md` / `-en.md`, `layout: map`, `ref: world-map`, no `sea` field (the layout does not include a banner). All the data comes from `_data/world-map.yml`:

```yaml
- lat: -20.43522
  lng: 57.32068
  icon: diveFlagIcon
  fr-country: Ile Maurice
  en-country: Mauritius
  fr-date: septembre 2013
  en-date: September 2013
```

| Field | Description |
|---|---|
| `lat`, `lng` | Required |
| `icon` | `diveFlagIcon` (diving destination) or `homeIcon` (a single point, "Home sweet home", Paris) |
| `ref` | Optional: links the point to an existing country page. If present, the popup label becomes a link to that page; without `fr-country`/`en-country`, the displayed label is the target page's `h1`, and without `fr-date`/`en-date`, the displayed date is the target page's `visited-in` |
| `place` | Optional, free subtitle appended after a dash (useful for archipelagos with several points, e.g. French Polynesia ×11, Philippines ×4) |
| `fr-country` / `en-country` | Optional: label displayed without a link if `ref` is absent (places visited without a dedicated page, e.g. Mauritius, Vietnam), or substitute label if provided alongside a `ref`. A single entry has neither `ref` nor `fr-country`/`en-country`: the "Home sweet home" point (`homeIcon` icon), whose popup then only shows `place` |
| `fr-date` / `en-date` | Optional, see `ref` above |

The same `ref` can appear several times (several sites in the same country).

## Calendar (front matter and data)

`pages/calendar.md` / `-en.md`, `layout: calendar`, `ref: calendar`, `sea: next` (picks the banner variant, see `style-guide.md`). No content of its own beyond the common front matter: all the data comes from `_data/calendar.yml` crossed with the `best-seasons` of each `_data/countries/<ref>.yml` (see `screens/calendar.md`).

`_data/calendar.yml`:

```yaml
- num: 1
  img: 0001.webp
  fr-name: janvier
  en-name: January
```

12 entries, one per month. `img` references `photos/calendar/<img>` (the Liquid filter `\| replace: '.jpg','.webp'` applied to this field is a no-op here, leftover from the same old convention as `home-team.yml`).

## FAQ (front matter)

`pages/faq.md` / `-en.md`, `layout: faq`, `ref: faq`, `sea: faq`:

```yaml
qa:
  - N: 01
    I: fa-flag
    Q: "Comment choisir un club de plongée ?"
    A: |
      Markdown answer.
```

`qa`: list of 8 items. `N` (number/identifier, string), `I` (full Font Awesome icon class, `fa-` prefix included, see `style-guide.md`), `Q` (question), `A` (Markdown answer). Same structure in FR and EN.

## Bonus (front matter)

`pages/bonus.md` / `-en.md`, `layout: bonus`, `ref: bonus`, `sea: bonus`. Free Markdown content after the front matter (`{{ content }}`, list of hot springs with links to the matching country pages when they exist). Reuses the same gallery mechanism as the country pages (see "Images" above) on `photos/bonus/`, since `page.ref == "bonus"`.

## Inspiration (front matter)

`pages/inspiration.md` / `-en.md`, `layout: inspiration`, `ref: inspiration`, `sea: inspiration`. Free Markdown content (list of book/video recommendations with external links). No photo gallery: a single static image (`/assets/img/inspiration.webp`) serves as illustration, see `style-guide.md`.

## General conventions

- **Slugs**: lowercase ASCII and hyphens (kebab-case) in English for every technical identifier (`ref`, `_data/countries/*.yml` file names, `photos/*/` folders), e.g. `french-polynesia`, `mexico-baja-california`.
- **`ref` shared by both languages of a page**, always identical between the FR file and the EN file (verified without exception): it is the key linking the two language versions (language switcher, `hreflang` alternates, sitemap, default Open Graph image, see `technical-specifications.md`). The `permalink`, on the other hand, is translated independently per language (see "Naming conventions" in `technical-specifications.md`): never use the `permalink` to find a page's counterpart in the other language, always go through `ref`.
- **Added content exists in both languages**: each `pages/*.md` page has its `-en.md` counterpart (systematically verified), and each `_data/*.yml` file (including `_data/countries/<ref>.yml`) serves both languages through `fr-*`/`en-*` keys in a single file rather than separate per-language files.
- **No data validation script**: no automatic check of `ref` uniqueness, of the presence of both language files, or of the match between a country page and its `_data/countries/<ref>.yml` file. These rules are followed by convention, not mechanically enforced (CI only runs a `jekyll build` followed by a non-blocking `html-proofer`, see `technical-specifications.md`).
