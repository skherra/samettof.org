# General functional specifications

## Context and goals

The site presents the scuba diving trips of Sam, Tof and Ti'Crab: about thirty destinations visited around the world (Atlantic, Caribbean, Indian Ocean, Mediterranean, Red Sea, Pacific), each documented with a description of the site, the dive shop used, the accommodation, a dive log (first-hand excerpts) and a map of the dive spots. The site also offers an overview (world map, best-season calendar per destination) and editorial content pages (FAQ, bonus, inspiration).

The goal is to help a visitor preparing a diving trip choose a destination and a period, and find practical information drawn from the authors' direct experience.

## Site scope

In scope:

- Home page presenting the authors and giving access to the various sections (see `screens/home.md`).
- Browsing each visited destination (about thirty, grouped by ocean): description, dive shop, accommodation, things to see, dive log, dive site maps (see `screens/country.md`).
- Interactive world map of all the places visited (see `screens/world-map.md`).
- Calendar of the best diving seasons per destination (see `screens/calendar.md`).
- Practical FAQ on preparing a diving trip (see `screens/faq.md`).
- Bonus page (hot springs visited) (see `screens/bonus.md`).
- Travel inspiration page (books, videos) (see `screens/inspiration.md`).
- Page not found (see "Page not found" below).
- Multilingual site (French, English).

See also "Out of scope" below.

## Target users

The site is aimed at visitors preparing or considering a scuba diving trip: family, friends, divers looking for first-hand feedback, curious visitors coming from a search engine or a social network. There is no role distinction on the visitor side: no account, no personal space, no personalized content.

The content (descriptions, dive logs, per-destination data) is written by the authors directly in the repository's source files (see `data-model.md`), not through an admin interface.

## Main user journeys

1. A visitor lands on the home page, discovers the authors (manifesto, portfolio of the latest dives, team presentation, trip counters) and reaches the sections through the navigation menu.
2. If they are looking for a specific destination, they find it in the menu (grouped by ocean) or on the world map, and land on its dedicated page: description of the dive site, ratings (difficulty, visibility, diversity, atmosphere), practical information (dive shop, accommodation, things to see), dive log, photo gallery, and possibly detailed maps of the dive spots.
3. If they are hesitating between several destinations depending on the travel period, they check the calendar, which lists, per month, the destinations whose best season it is.
4. If they have generic practical questions (gear, certification, budget...), they check the FAQ.
5. From any page, they navigate to another section through the menu, always visible at the top of the page.

## Cross-cutting rules

### Multilingual

- The site is available in French and English.
- French is the default language (`lang: "fr"` in `_config.yml`): its pages are served at the root of the site, without prefix (`/`, `/faq/`...). English is prefixed with `/en/`.
- Each page exists as two separate source files (one per language), linked to each other by a shared identifier (`ref`, see `data-model.md`) rather than by dynamic translation.
- The language switcher (emoji flags 🇫🇷/🇬🇧) lives in the footer, always visible, on the right (see "Footer" in `style-guide.md`, shared by the whole site).
- There is no mechanism for automatically detecting the browser language or remembering a language choice: each page is static and serves the language of its URL.
- There is no partially translated content on this site: every destination and every functional page systematically exists in both languages (see "General conventions" in `data-model.md`), except the page not found (see below).

### Navigation

- Single navigation menu, in the header, present on every page (`fixed-top`, always visible while scrolling): one link per simple functional page (world map, calendar, inspiration, FAQ, bonus) and one dropdown submenu per ocean listing its destinations (see `_data/menu.yml` in `data-model.md`). The order of the entries follows the editorial order of the data file, not an alphabetical sort (e.g. in the Caribbean, Les Saintes comes after Mexico-Yucatán).
- **Fixed footer** (`fixed-bottom`, always visible while scrolling), present on every page: site license (CC0 1.0 Universal, code and content) on the left, language switcher on the right (see "Multilingual" above and "Footer" in `style-guide.md`). No social networks or other repeated information in the footer.
- No external link to other sites of the author was found on this site (no "sister sites" in the sense practiced by other projects of the author): the only identity-related external links are the individual Instagram accounts of Tof and Ti'Crab in the team presentation on the home page (see `screens/home.md`), Sam having none set.

### Page not found

- Unlike the other pages of the site, there is **a single 404 page** for both languages (`404.md`, `permalink: /404.html`), not a FR/EN pair linked by `ref` (see "General conventions" in `data-model.md`): an exception to the multilingual rule above.
- It displays an interactive map centered on a fictional oceanic point ("Nemo Point"), with a marker leading to an external article, rather than a plain error message (see "Interactive maps" in `style-guide.md`).

## Out of scope

- User accounts, authentication.
- Content editing through a web interface: content is created and modified directly in the source files (see `data-model.md`).
- Visitor-generated content (comments, ratings, contributions).
- Free search or filtering of destinations: the only filtered view is the calendar by month (see `screens/calendar.md`), there is no text search or filter by criterion (region, difficulty...).
- Automatic detection or memorization of the visitor's language (see "Multilingual" above).
- Cookies, tracking, analytics: no such mechanism on the site (see "Performance" in `technical-specifications.md`).
