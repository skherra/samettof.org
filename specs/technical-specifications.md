# Spécifications techniques

## Stack technique

### Génération de site

- **Jekyll 4.4.1** : layouts, includes, front matter, `_data/`, pages (pas de collections).
- **Ruby 3.3.12** (`.ruby-version`).
- `webrick` (serveur de développement local), `html-proofer` (vérification de liens morts en CI, voir "Hébergement et déploiement"), `json`.
- Aucun plugin Jekyll packagé en gem (le `Gemfile` ne déclare que `jekyll`, `webrick`, `json`, `html-proofer`) : la seule extension de build du site est un fichier local, `_plugins/less_compiler.rb`, chargé automatiquement par Jekyll.
- Pas de section `plugins:` ni `collections:` dans `_config.yml`.

### CSS / UI

- **LESS**, compilé en CSS par un hook Jekyll (`_plugins/less_compiler.rb`) plutôt qu'au moment du build : un seul fichier source, `assets/css/samettof.less`, compilé vers `assets/dist/css/samettof.css`.
- **Bootstrap 4.6.2** (pas Bootstrap 5) : grille, navbar, carousel, modale, accordéon (`card`/`collapse`), barres de progression. Vendored dans `assets/dist/` (pas chargé depuis un CDN).
- **jQuery 3.7.1 (build "slim")** vendored, requis par le bundle Bootstrap 4 (contrairement à Bootstrap 5, qui n'a pas de dépendance jQuery).
- **Leaflet 1.9.3** vendored (`assets/dist/css/leaflet.min.css`, `assets/dist/js/leaflet.min.js` + icônes dans `assets/dist/images/`) : cartes interactives (voir "Architecture" ci-dessous).
- **Font Awesome**, chargé via un Kit distant (`https://kit.fontawesome.com/7dfeb2d2f7.js`) — même identifiant de kit que sur un autre site de l'auteur, ce qui suggère un compte Font Awesome partagé entre plusieurs projets.
- **Google Fonts** : Ubuntu uniquement, chargée via l'ancienne API `css?family=Ubuntu` (pas `css2`), sans graisse explicite dans l'URL — seul le poids 400 est donc effectivement chargé, alors que les titres utilisent `font-weight: bolder` (mot-clé CSS relatif) : le rendu "gras" des titres est donc probablement un gras synthétique du navigateur plutôt qu'une graisse Ubuntu réellement chargée. Voir `style-guide.md`.
- Les valeurs de design (couleurs, typographie, espacements) sont définies dans `style-guide.md`, pas ici.

### JavaScript

- **Vanilla JS + plugins jQuery** pour les interactions custom : `assets/js/jquery.appear.js` (plugin tiers, détecte l'entrée d'un élément dans le viewport) et `assets/js/counter.js` (plugin `$.fn.countTo` + code d'initialisation propre au site), tous deux utilisés uniquement pour les compteurs animés de l'accueil (voir `screens/home.md`).
- Toutes les autres interactions (carousel, modale, accordéon, menu burger) sont déléguées aux composants Bootstrap 4 via attributs `data-*`, sans JS custom.
- Pas de framework JS (React, Vue, Angular), pas de bundler.
- Aucun script n'est chargé avec `defer` ou `async`.

### Ce qu'on n'utilise pas

- Node.js committé dans le dépôt (pas de `package.json`, `node_modules/`), bien que le hook LESS dépende du binaire `lessc` installé globalement via npm sur la machine de build (voir "Scripts de maintenance locaux" ci-dessous) — c'est un outil de développement local, pas une dépendance du dépôt.
- Bundler JS, framework CSS custom au-delà de Bootstrap, SCSS/Sass (LESS uniquement, malgré `jekyll-sass-converter` présent comme dépendance transitive de Jekyll dans `Gemfile.lock` — cette gem n'est pas exploitée).
- Base de données, backend ou API propre.
- Cookies, tracking, analytics.
- Plugin `jekyll-sitemap` (le sitemap est une page Jekyll faite à la main, voir "SEO").
- Content Security Policy, JSON-LD.
- Script de validation des données (voir "Conventions générales" dans `data-model.md`).

---

## Hébergement et déploiement

- **Hébergeur :** GitHub Pages
- **Domaine :** `www.samettof.org` (fichier `CNAME` à la racine, avec le sous-domaine `www`)
- **Déploiement :** automatique, via GitHub Actions (`.github/workflows/jekyll.yml`), déclenché sur push sur la branche `master`, ou manuellement (`workflow_dispatch`)
- **Build (job `build`, timeout 15 minutes) :**
  - `actions/checkout@v7`
  - `ruby/setup-ruby` (épinglé par SHA de commit, `bundler-cache: true`)
  - `actions/configure-pages@v6`
  - `bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"`, variable d'environnement `JEKYLL_ENV: production`, exécuté explicitement plutôt que délégué à l'intégration native GitHub Pages
  - `actions/upload-pages-artifact@v5`
- **Vérification des liens :** `html-proofer` tourne sur `_site/` après le build, en `continue-on-error: true` (rapporte les liens morts sans faire échouer le déploiement). Options : `--ignore-urls` (Google Fonts, et plusieurs domaines de partenaires de plongée cités dans le contenu éditorial), `--ignore-status-codes "429,403"`, `--no-check-external-hash`.
- **Déploiement (job `deploy`) :** `actions/deploy-pages@v5`, environnement `github-pages`.
- **Dependabot** (`.github/dependabot.yml`) : mises à jour hebdomadaires des GitHub Actions et des gems (`bundler`).

---

## Architecture (génération des pages, routage)

### Rendu

Le site est entièrement statique, généré au build par Jekyll. Aucun rendu dynamique côté serveur, aucune API propre.

### Génération des pages

Contrairement à un mécanisme à base de plugin `Jekyll::Generator`, **toutes les pages du site sont des fichiers Markdown committés** dans le dépôt (pages pays comprises) : il n'existe aucune page générée en mémoire au moment du build. Les galeries photo (pages pays et bonus) ne sont pas des pages individuelles par photo : ce sont des scans de `site.static_files` au moment du rendu d'une page existante (voir "Images" dans `data-model.md`), pas des pages séparées.

### Structure des URLs

| Type de page | Layout | Exemple FR | Exemple EN |
|---|---|---|---|
| Accueil | `index` | `/` | `/en/` |
| Page pays | `country` | `/indien/maldives/` | `/en/indian/maldives/` |
| Carte du monde | `map` | `/carte/` | `/en/map/` |
| Calendrier | `calendar` | `/calendrier/` | `/en/calendar/` |
| FAQ | `faq` | `/faq/` | `/en/faq/` |
| Bonus | `bonus` | `/bonus/` | `/en/bonus/` |
| Inspiration | `inspiration` | `/inspiration/` | `/en/inspiration/` |
| 404 | `404` | `/404.html` (page unique, bilingue) | — |
| robots.txt | `null` | `/robots.txt` | — |
| sitemap.xml | `null` | `/sitemap.xml` | — |

Les pages françaises n'ont pas de préfixe de langue (français = langue par défaut) ; les pages anglaises sont préfixées `/en/`. Pour les pages pays, le segment d'océan et le slug de la destination sont **traduits indépendamment par langue** dans le `permalink` (ex. `indien` → `indian`, `mer-rouge` → `redsea`, `hawai` FR → `hawaii` EN) : voir "Conventions de nommage" ci-dessous et "Conventions générales" dans `data-model.md` pour la mise en garde sur `ref` vs `permalink`.

### Textes d'interface

Pas de fichier centralisé de traductions : chaque libellé conditionnel est écrit directement dans les layouts et includes, sous la forme `{% if page.lang == "fr" %}...{% else %}...{% endif %}` (répété dans la plupart des includes `country-*`, `home-*`, `page-banner.html`). Les autres contenus multilingues passent par des clés `fr-*`/`en-*` dans les fichiers `_data/*.yml` (voir "Conventions générales" dans `data-model.md`).

---

## Scripts de maintenance locaux

Un seul mécanisme de ce type sur ce site :

| Mécanisme | Fichier | Rôle | Déclenchement |
|---|---|---|---|
| Compilation LESS → CSS | `_plugins/less_compiler.rb` | Recompile `assets/dist/css/samettof.css` depuis `assets/css/samettof.less` si la source est plus récente que le fichier compilé | Hook Jekyll (`pre_render`), à chaque `jekyll serve`/`jekyll build` local |

Pas de dossier `scripts/`, pas de `Rakefile`, pas de génération locale de vignettes ou de pages de détail au-delà de ce hook.

---

## Performance

- Lazy loading (`loading="lazy"`) sur certaines images : logo de l'en-tête, carousel d'accueil, portfolio d'accueil, équipe, vignettes des carousels de pages pays, images des modales mensuelles du calendrier. **Absent** sur les images de la modale plein écran des galeries et sur l'image statique de la page inspiration.
- Toutes les photos sont au format WebP.
- Aucun script n'est chargé avec `defer`/`async` (voir "JavaScript" ci-dessus).
- Pas de cookies, pas de tracking, pas d'analytics.

---

## Accessibilité

- **Navigateurs cibles :** non explicitement documentés dans le code ; à défaut d'exigence connue, dernières versions stables des navigateurs évergreens (Chrome, Firefox, Safari, Edge).
- `aria-label` présent sur les composants interactifs standards de Bootstrap (bouton de fermeture de modale, bouton "burger" de la navbar) ainsi que sur le lien de licence du pied de page (libellé localisé selon `page.lang`).
- Texte alternatif sur les images : qualité inégale — descriptif sur certains blocs (équipe, portfolio d'accueil), mais souvent littéral ou vide sur les carousels de photos (galeries pays, carousel d'accueil) : limite d'accessibilité connue, pas corrigée à ce jour.
- Navigation : composants Bootstrap 4 standards (modale, accordéon, dropdown), pas de gestion clavier custom au-delà de leur comportement natif.
- `role="main"` sur l'élément `<main>` de chaque layout.
- **Limite connue :** les cartes Leaflet (carte du monde, cartes de destination, page 404) reposent sur une interaction souris/tactile (popup au clic sur un marqueur) sans alternative textuelle listant les mêmes informations.

---

## SEO

- Rendu statique : chaque page existe indépendamment au moment du crawl.
- Balises de base dans `_includes/head.html` : `<meta name="description">`, `<meta name="author">`, `<title>`, lien `canonical`.
- **hreflang** généré manuellement en Liquid (pas de plugin) : `site.pages | where: "ref", page.ref`, trié par langue, une balise `<link rel="alternate" hreflang="...">` par version linguistique existante.
- **Open Graph** complet : `og:type`, `og:site_name`, `og:title`, `og:description`, `og:url`, `og:locale` (`fr_FR`/`en_US` selon `page.lang`) et `og:image` — logique : cherche `/photos/<page.ref>/0001.webp` dans `site.static_files`, sinon retombe sur `/assets/img/dive-flag.webp`.
- **Twitter Card** (`summary_large_image`, titre, description).
- **Pas de JSON-LD**, **pas de balise CSP** (`Content-Security-Policy`) sur ce site.
- `robots.txt` (page Jekyll, `layout: null`) : autorise l'indexation, référence `sitemap.xml`.
- **`sitemap.xml`** : page Jekyll auto-générée (`layout: null`, boucle Liquid sur `site.pages`), pas le plugin `jekyll-sitemap`. Elle liste comme entrée `<url>` toutes les pages où `page.title` est renseigné, FR comme EN, à l'exclusion des pages marquées `sitemap.exclude: 'yes'` (mécanisme utilisé par `sitemap.xml` elle-même et par `404.md` pour s'auto-exclure). Chaque entrée reprend, via `site.pages | where: "ref", page.ref`, le jeu complet des alternates `hreflang` (y compris auto-référent), conformément à la pratique recommandée par Google pour les sitemaps multilingues. Inclut des extensions `image:image` pour les photos d'une page pays.
- Un fichier de vérification de propriété (Google Search Console ou équivalent) n'a pas été identifié à la racine lors de cette recherche — à vérifier si un tel mécanisme est utilisé.

---

## Structure des fichiers

```
/
├── _config.yml
├── CNAME                            # www.samettof.org
├── 404.md                           # page unique, bilingue
├── index.md / index-en.md           # accueil (FR / EN)
├── robots.txt / sitemap.xml         # pages Jekyll auto-générées, layout: null
│
├── _layouts/
│   ├── index.html                   # accueil : carousel + manifeste + portfolio + équipe + compteurs
│   ├── country.html                 # page pays : about + carousel + opinion + practical + logbook + good-to-know + map
│   ├── map.html                     # carte du monde plein écran (Leaflet)
│   ├── calendar.html                # grille des 12 mois + modale par mois
│   ├── faq.html                     # accordéon
│   ├── bonus.html                   # contenu + galerie
│   ├── inspiration.html             # contenu + image statique
│   ├── default.html                 # non utilisé : aucune page ni layout n'a `layout: default`
│   └── 404.html
│
├── _includes/
│   ├── head.html                    # <head> : meta, OG, hreflang, fonts, CSS, Leaflet conditionnel
│   ├── header.html                  # navbar fixe (haut) : menu, sous-menus par océan
│   ├── footer.html                  # navbar fixe (bas) : licence CC, sélecteur de langue
│   ├── scripts.html                 # scripts JS en fin de <body>
│   ├── page-banner.html             # bannière de page (hors accueil), variante par `sea`
│   ├── home-carousel.html, home-manifest.html, home-portfolio.html, home-team.html, home-counters.html
│   └── country-about.html, country-carousel.html, country-good-to-know.html, country-logbook.html,
│       country-map.html, country-opinion.html, country-practical.html
│
├── _plugins/
│   └── less_compiler.rb             # recompile samettof.less -> samettof.css au build local
│
├── assets/
│   ├── css/samettof.less            # source unique de styles custom
│   ├── dist/                        # Bootstrap 4.6.2, jQuery slim, Leaflet 1.9.3, samettof.css (compilé)
│   ├── js/                          # jquery.appear.js, counter.js (non vendored, voir "JavaScript")
│   ├── img/                         # logo, bannières par océan, image inspiration, icônes de carte
│   └── src/                         # sources .psd des icônes de carte
│
├── docs/                            # cartes de plongée et itinéraires (image/PDF), référencés depuis le contenu
│
├── pages/<ocean>/<slug>[-en].md     # pages pays, 6 dossiers par océan (atlantic, caribbean, indian,
│                                     # mediterranean, pacific, redsea)
├── pages/{calendar,world-map,faq,bonus,inspiration}[-en].md
│
├── _data/
│   ├── countries/<ref>.yml          # un fichier par pays (33), données chiffrées bilingues
│   └── calendar.yml, home-manifest.yml, home-team.yml, menu.yml, portfolio.yml, world-map.yml   # bilingues, un seul fichier
│
└── photos/
    ├── <ref>/NNNN[-th].webp         # photos + vignettes par pays (et `bonus/`)
    ├── home-carousel/, home-portfolio/, home-team/, calendar/   # images des blocs d'accueil / calendrier
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

Aucun plugin déclaré (voir "Génération de site" ci-dessus). `exclude:` retire `specs/` et `CLAUDE.md` du build (voir plus bas) : ce sont des fichiers de travail du dépôt, pas du contenu du site, et Jekyll les publierait sinon tels quels sous `_site/`.

---

## Conventions de nommage

| Élément | Convention | Exemple |
|---|---|---|
| `ref` (identifiant technique, commun aux deux langues) | kebab-case anglais | `french-polynesia`, `mexico-baja-california` |
| `permalink` (URL publique) | traduit indépendamment par langue, y compris le segment d'océan pour les pages pays | `/indien/maldives/` (FR) vs `/en/indian/maldives/` (EN) |
| Fichiers Markdown/YAML/LESS | kebab-case | `world-map.yml`, `samettof.less` |
| Identifiants/classes CSS | noms sémantiques simples, pas de préfixe imposé | `#worldMap`, `.page-banner`, `.portfolio-item-content` |
| Variables/fonctions JS | camelCase | `countTo()`, `diveFlagIcon` |
| Images de galerie | `NNNN.webp` (4 chiffres) + `NNNN-th.webp` pour la vignette | `photos/maldives/0001.webp` / `0001-th.webp` |
