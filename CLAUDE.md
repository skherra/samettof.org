# samettof.org

Scuba diving travel site of Sam & Tof (and Ti'Crab): one page per country/destination visited (description, dive shop, accommodation, dive log, dive site map), a world map, a best-season calendar, an FAQ and a bonus page (hot springs). Static, multilingual site (French / English), built with Jekyll and hosted on GitHub Pages.

## Role of `specs/`

`specs/` documents the design decisions. `specs/` is the source of truth for any change: before writing or modifying code, read the spec files relevant to the task.

## Structure of `specs/`

- **`functional-specifications.md`**: site scope, target visitors, user journeys, cross-cutting rules (multilingual, navigation, header and footer).
- **`data-model.md`**: the content families (country page, home page, calendar, world map, FAQ, bonus, inspiration), their data files (`_data/*.yml`), page front matter, naming conventions (`ref`, permalinks translated per language).
- **`technical-specifications.md`**: technical stack, hosting/deployment, architecture (page generation, routing), performance, accessibility, SEO.
- **`style-guide.md`**: visual identity (colors, typography, spacing), base UI components (header, page banner, carousels, Leaflet maps, progress bars), iconography.
- **`screens/`**: one functional specification per screen (goal, content, interactions, states, responsive):
  - `home.md`: home (carousel, manifesto, portfolio, team, counters)
  - `country.md`: generic country/destination page screen (about thirty pages, a single behavior)
  - `world-map.md`: interactive world map
  - `calendar.md`: best-season calendar
  - `faq.md`: frequently asked questions
  - `bonus.md`: hot springs
  - `inspiration.md`: travel inspiration (books, videos)

## When and how to use these specs

- **Before any implementation**, read the file(s) relevant to the task. The four cross-cutting specs (`functional-specifications.md`, `data-model.md`, `technical-specifications.md`, `style-guide.md`) apply to the whole site; each file in `screens/` adds what is specific to that screen.
- **The files constantly reference each other** ("see `X.md`") rather than duplicating information. Follow these references rather than guessing: if a screen mentions a rule defined elsewhere (the multilingual behavior, a color from the style guide...), the source of truth is the referenced file, not the screen citing it.
- **When modifying a spec**, search for the other files that reference it (`grep` the file name in `specs/`) and check that they remain consistent with the change.
- **When in doubt, or when the specs are silent** on a point needed for the implementation, ask rather than assume: these are design decisions, not free implementation details.
- **When the existing code and a spec diverge**: these specs were written after the fact, from the code in place. A divergence spotted during a task can therefore have two origins, to be told apart before acting: either the spec misdescribes an intentional behavior (fix the spec), or the code contains an oversight or a bug that writing the specs brought to light (report it to the user, do not silently fix it as part of an unrelated task). Once a spec is confirmed correct, it is authoritative: if a later implementation must depart from it, update the spec and explain why rather than silently diverging in the code.

## Before each commit

- **Check all files in `specs/`** for consistency, not only those directly modified by the commit.
- **If one or more specs need to be adjusted**, block the commit: propose the necessary updates and wait for approval before applying them, then commit.

## Established conventions

- Everything in the repository is written in English: specs (`specs/`), this file, code, comments, commit messages. The only French text is the site content itself (French pages, `fr-*` keys in `_data/*.yml`) and the permalinks of French pages.
- File names, folders, slugs and technical identifiers are in English, in kebab-case (e.g. `french-polynesia`, `home-carousel.html`), except the permalinks of French pages, which are in French (see "Naming conventions" in `technical-specifications.md`).
- The colors and components of the visual identity are defined once, in `style-guide.md`: do not introduce new color values or new component styles elsewhere without adding them there first.
- `specs/` and this file are excluded from the Jekyll build (see `exclude:` in `_config.yml`): they are working files of the repository, not site content.
