# Style guide

## Colors

### Palette

LESS variables (`@variable`), defined once at the top of `assets/css/samettof.less`:

| Role | Variable | Hex |
|---|---|---|
| Accent, links, active elements | `@blue` | `#0a9fd8` |
| Body text (`html`/`body`) | `@grey` | `#666` |
| Strong text, inner headings, nav-links | `@dark-grey` | `#444` |
| Secondary text ("visited in" caption) | `@light-grey` | `#ACB2B8` |

```less
@blue:        #0a9fd8;
@light-grey:  #ACB2B8;
@grey:        #666;
@dark-grey:   #444;
@navbar-full-height: 66px;
@footer-height: 36px;
```

All these variables are used elsewhere in the file (no orphan detected).

Several colors are hard-coded in `samettof.less` without being promoted to variables; do not duplicate them without first adding them there if they need to become reusable:

| Color | Usage |
|---|---|
| `#36353A` | `text-shadow` halo (`0px 0px 20px #36353A`) on headings overlaid on photos: `h1`/`h2` of the home carousel, page banner, captions (`h3`) of the home portfolio and calendar tiles, member name/link overlaid on the photo (team) |
| `#050F1E` | Text of the `.portfolio-item-content` block (home portfolio and calendar) |
| `#ffffff` | Fallback background of the page banners |
| `rgba(68, 68, 68, 0.75)` | Background of the photo galleries' full-screen modal |
| `black` | Drop shadow of the round portrait in the header |
| `white` / `#FFF` | Text overlaid on photos, but also: page background (`body`), footer background, text of dropdown menu items on hover, close link of the photo modal |
| `rgba(0, 0, 0, .125)` | Footer top border (same value as the Bootstrap `.card` border, reused rather than duplicated) |

The default Bootstrap 4 blue (`#007bff`) is present in the vendored CSS variables but is not used anywhere in the site's custom HTML/LESS: the site's visual accent is always `@blue` (`#0a9fd8`), not the Bootstrap blue.

### Usage

Light background by default (no `@bg` variable: the site has no global dark background, unlike other projects of the author). Body text in `@grey`. Links in `@blue` (no distinct hover color defined for plain links). Accent icons and active elements (progress bars, carousel indicators, open accordion buttons) in `@blue`.

## Typography

- **Single typeface**: Ubuntu (Google Fonts), `font-family: Ubuntu, sans-serif` on `html`/`body`. No separate heading typeface (unlike other projects of the author that combine two families).
- Loaded through the old Google Fonts API (`css?family=Ubuntu`), with no explicit weight: only weight 400 is actually loaded. Headings use `font-weight: bolder` (relative keyword): the bold rendering is therefore most likely a browser-synthesized bold, not a dedicated loaded Ubuntu weight. See `technical-specifications.md`.
- `rel="preconnect"` to `fonts.googleapis.com` and `fonts.gstatic.com`.

| Usage | Size | Weight | Notes |
|---|---|---|---|
| Home carousel `h1` | 32px | bolder | Uppercase (`text-transform: uppercase`), `#36353A` halo |
| Home carousel `h2` | 24px | bolder | `#36353A` halo |
| Page banner `h1` (except home) | 20px | bolder | Uppercase, `#36353A` halo |
| Portfolio / team `h1` (home) | 32px | bolder | Section heading (not overlaid on a photo), `@dark-grey` color, centered, no halo |
| Manifesto / portfolio (`#36353A` halo, overlaid) / good-to-know `h3` | 20px (good-to-know: `font-size` 14px, `line-height` 18px) | bolder | |
| Content `h2` (simple pages) | 16px | bolder | `border-bottom: 2px solid #eee`, inner `span` underlined in `@blue` (2px) |
| Body text, `main` | 14px, `line-height: 20px` | normal | `@grey` color |
| "Visited in" caption | 14px | normal, italic | `@light-grey` color |

## Spacing and grid

No custom spacing scale: the Bootstrap 4 grid and utility classes (`container`, `container-fluid`, `row`/`col-*`, `p-*`/`m-*`) are used as-is. No custom media query in `samettof.less`: responsiveness relies entirely on the Bootstrap grid and the native behavior of `navbar-expand-lg` (switches to a "burger" menu below the `lg` breakpoint, 992px).

## Base UI components

### Header / navigation (`_includes/header.html`)

- Bootstrap `fixed-top` navbar (always visible while scrolling; `main { margin-top: @navbar-full-height }` offsets the fixed 66px height).
- Logo: `assets/img/dive-flag.webp` (300×300 px), displayed at 40×40 px, `rounded-circle`, drop shadow (`box-shadow: 1px 1px 2px black`), link to the home page of the current language.
- Menu generated from `_data/menu.yml`: plain links and per-ocean dropdown submenus (see `data-model.md`). `.nav-link` in `@dark-grey`, `@blue` on hover. `.dropdown-item:hover`: `@blue` background, white text.
- The language switcher is not part of the header: it lives in the footer (see "Footer" below).

### Footer (`_includes/footer.html`)

- Bootstrap `fixed-bottom` navbar (always visible while scrolling; `main { margin-bottom: @footer-height }` offsets the fixed 36px height), white background, top border `1px solid rgba(0, 0, 0, .125)`. Reuses the `.navbar` class (and its `justify-content: space-between` flex) to lay out its only two children without a custom grid.
- License on the left (`#footer-license`): link to the content's Creative Commons BY-NC-SA 4.0 license (`deed.fr`/`deed.en` according to `page.lang`), Font Awesome icons (`fab fa-creative-commons`, `-by`, `-nc-eu`, `-sa`) followed by the label `CC BY-NC-SA 4.0`.
- Language switcher on the right (`#footer-lang`, emoji flags 🇫🇷/🇬🇧): same Liquid logic as the former header switcher (`site.pages | where:"ref", page.ref`), reuses the `.lang-flag` class with a reduced `padding`/`line-height` specific to the footer (overridden under `#footer-lang`).
- `#worldMap` (full-screen world map) and the special case of the 404 page account for this fixed height in addition to the header's: `height: calc(100vh - @navbar-full-height - @footer-height)` (see "Interactive maps" below).

### Page banner (`_includes/page-banner.html`, every page except home)

- Fixed height **150px**, `padding: 50px 0`, `cover` background image, one variant per `sea` value (`.banner-{sea}`, image `/assets/img/banner/<sea>.webp`, 1440×150 px).
- Two `h1`: the first shows the ocean name (only for the 6 `sea` values matching an actual ocean; for `next`/`bonus`/`faq`/`inspiration`, this first `h1` stays empty while the `.banner-<sea>` class still applies to the background), the second shows `page.h1`. White text, `#36353A` halo.

### Carousels (Bootstrap 4, `data-ride="carousel"`)

The site uses the Bootstrap carousel component in five places, with different settings:

| Carousel | Autoplay | Indicators | Arrows |
|---|---|---|---|
| Home (`home-carousel.html`) | Yes | Yes (dots) | Standard Bootstrap |
| Country/bonus gallery, thumbnails (`country-carousel.html`, `#photosCarousel`) | Yes | Yes | Custom (`fa-angle-left`/`fa-angle-right`) |
| Country/bonus gallery, full-screen modal (`#modalCarousel`) | **No** (`data-ride="false"`) | n/a | Positioned on the clicked photo when a thumbnail is clicked |
| Dive log (`country-logbook.html`, `#logCarousel`) | Yes, `data-interval="10000"` (10s) | No | Custom (`fa-chevron-circle-left`/`-right`), overlaid at the top right |

The home carousel hides its caption (`h1`/`h2`) below the `md` breakpoint (`d-none d-md-block`).

### Animated counters (`_includes/home-counters.html`, home only)

- 4 columns, 3x Font Awesome icons in `@blue`, 48px bolder figure in `@blue`.
- Increment animation (0 → target value in 5000ms) triggered unconditionally when the page loads (`$(document).ready`), then triggered a second time the first time the block enters the viewport (`jquery.appear.js` + `counter.js`, see `technical-specifications.md`).
- The target values (`data-to`) are hard-coded in the include's HTML, not computed from the site data.

### Portfolio (`_includes/home-portfolio.html`, `_includes/country-carousel.html` thumbnails, calendar)

- Tile `position: relative; overflow: hidden`, image `width/height: 100%`.
- On hover (`transition: all .5s` on the home page and the calendar): zoom + slight rotation of the image (`scale(1.3) rotate(3deg)`), a veil and a caption appear (`opacity: 0 → 1`).
- **Difference between the home page and the calendar**: on the home page, the block's text (`#050F1E`) only appears on hover (`opacity: 0` by default); on the calendar, it is **always visible** (`opacity: 1`), only the image zoom is triggered on hover.
- No fixed dimensions for the home portfolio source images: variable ratios (e.g. 1000×750, 1004×564, 1024×576).

### Team (`_includes/home-team.html`, home)

- One column per member, 800×600 px photo at full column width.
- Name overlaid at the bottom right (white, 20px bolder, `#36353A` halo).
- Instagram icon overlaid at the bottom left, displayed only if `item.insta` is set (absent for Sam).
- Thin progress bars (`height: 3px`, `@blue` fill) under each interest (`likes`), with the `grade` percentage.

### Country page: description and dive log (`country-about.html`, `country-logbook.html`)

- `country-about.html`: free text (`country-desc`), followed by an optional accordion (`country-desc-sections`, only 7 destinations) reusing the same `.card`/`.card-header`/`.collapse` classes as `country-practical` and the FAQ, with a `fa-angle-up.control-icon` icon that rotates (`rotate(-180deg)`) according to the open/closed state.
- `country-logbook.html`: large opening quotation mark (`“`, 64px, `@blue`) overlapping the text (`margin-bottom: -40px`) above each log excerpt.

### Country page: ratings and practical information (`country-opinion.html`, `country-practical.html`, `country-good-to-know.html`)

- `country-opinion.html`: 4 progress bars (`height: 1.2rem`) for Difficulty / Visibility / Diversity / Atmosphere, "x/10" label displayed inside the bar (with a decimal if not a multiple of 10, e.g. 65 → "6.5/10").
- `country-practical.html`: Bootstrap accordion with 3 fixed panels (Dive shop, Accommodation, To see), first panel open by default. Always displayed, even if the associated text is short: no conditional guard on empty content.
- `country-good-to-know.html`: three information blocks (water temperature, best season, fauna/flora), each with its own icon (see "Iconography" below).

### Interactive maps (Leaflet, `country-map.html`, `map.html`, `404.html`)

- Esri World Imagery satellite tile layer (not Google Maps), no clustering plugin.
- Custom markers: `diveFlagIcon` (blue flag, well-explored site), `diveFlagIconGrey` (grey flag, secondary site), `homeIcon` ("home" point, a single point on the world map). All marker icons: displayed at 16×27 px (50×83 px source files), with a dedicated drop shadow (`shadow.png`, 76×47 px source, displayed at 19×12 px).
- An `eyeIcon` icon is declared in the script but is used by no current data (`_data/world-map.yml`, `_data/countries/*.yml`): probably intended for future use, to be checked before considering it dead.
- `country-map.html`: one Leaflet map per `maps` entry (fixed 550px height), laid out in rows of 3 columns (`col-md-4`); the remainder of the division by 3 (0, 1 or 2 maps) shares the width of its own row equally (e.g. 4 maps → 3 in `col-md-4` + a single one in `col-md-12`; 5 maps → 3 in `col-md-4` + 2 in `col-md-6`). Only appears if the country has a `maps` field (21 of the 33 destinations, see `data-model.md`).
- `map.html`: full-screen map (`height: calc(100vh - 66px - 36px)`, header height then footer height), centered on `[0, 0]`, initial zoom 2, one marker per entry of `_data/world-map.yml`.
- `404.html`: same mechanism as `map.html`, but centered on a fictional oceanic point ("Nemo Point"), with a single marker leading to an external article (new tab).

### Calendar (`_layouts/calendar.html`)

- Grid of 12 monthly tiles (see "Portfolio" above for the visual style of the tiles), each tile opening a Bootstrap modal listing the destinations whose best season covers that month.

### FAQ accordion (`_layouts/faq.html`)

- Same `.card`/`.card-header`/`.collapse` structure as the other accordions of the site, but **all questions are closed by default** (unlike `country-practical.html`, whose first panel is open).

### Bonus / Inspiration (`_layouts/bonus.html`, `_layouts/inspiration.html`)

- Two columns (`col-md-6`): Markdown content on one side, illustration on the other.
- `bonus.html` reuses the same carousel + modal component as the country pages (`country-carousel.html`, on `photos/bonus/`).
- `inspiration.html` displays a single static image (`/assets/img/inspiration.webp`, 2000×1500 px), no gallery.

## Images

| Image | Observed ratio / dimensions |
|---|---|
| Country/bonus gallery photo (original) | Variable, up to ~2000 px on the long side |
| Gallery thumbnail (`-th.webp`) | Long side reduced to 600 px (identical to the original if it is already ≤ 600 px) |
| Home carousel (`photos/home-carousel/`) | 1920×950 px |
| Home portfolio (`photos/home-portfolio/`) | Variable (e.g. 1000×750, 1004×564, 1024×576) |
| Team (`photos/home-team/`) | 800×600 px uniform |
| Calendar tile (`photos/calendar/`) | 600×337 px uniform |
| Page banner (`assets/img/banner/*.webp`) | Exactly 1440×150 px |
| Logo (`assets/img/dive-flag.webp`) | 300×300 px (displayed at 40×40 px) |
| Inspiration illustration | 2000×1500 px |
| Leaflet marker icons | 50×83 px source (displayed at 16×27 px) |

## Iconography

Font Awesome, loaded through a remote Kit (see `technical-specifications.md`), no version pinned through an explicit CDN. Mixed use of `fa-`/`fas fa-` prefixes depending on when the code was added.

| Usage | Icon |
|---|---|
| "Countries visited" counter | `fa-paper-plane` |
| "Dives" counter | `fa-flag` |
| "Cruises" counter | `fa-ship` |
| "Happy divers" counter | `fa-smile-o` |
| Instagram (team) | `fa-instagram` |
| Accordion chevron (about / practical / FAQ) | `fa-angle-up` (`.control-icon` class, rotates according to state) |
| Gallery carousel arrows | `fa-angle-left` / `fa-angle-right` |
| Photo modal close | `fas fa-times` |
| Dive log arrows | `fas fa-chevron-circle-left` / `fas fa-chevron-circle-right` |
| Water temperature | `fa-tint` |
| Best season | `fas fa-sun` |
| Fauna/flora | `fa-eye` |
| Dive shop | `fa-ship` |
| Accommodation | `fa-bed` |
| To see | `fa-binoculars` |
| Manifesto (8 items) | `fa-flag-o`, `fa-eye`, `fa-paw`, `fa-anchor`, `fa-certificate`, `fa-globe`, `fa-heart`, `fa-camera-retro` |
| FAQ (per question, front matter `I:`) | varies by question (e.g. `fa-flag`, `fa-certificate`, `fa-adjust`, `fa-cog`, `fa-briefcase`, `fa-eye`, `fa-camera-retro`, `fa-binoculars`) |
| Link to an attached document (`docs/`) | `fa-mail-forward` (pointer), `fa-map` or `fa-file-pdf-o` depending on the file type |
| License (footer) | `fab fa-creative-commons`, `fab fa-creative-commons-by`, `fab fa-creative-commons-nc-eu`, `fab fa-creative-commons-sa` |

| Usage | Emoji |
|---|---|
| FR language switcher | 🇫🇷 |
| EN language switcher | 🇬🇧 |
| 404 page (bilingual) | 🇫🇷 🇬🇧 |
| Country page `h1` | ISO flag of the country concerned (one per destination, e.g. 🇲🇻 Maldives) |
