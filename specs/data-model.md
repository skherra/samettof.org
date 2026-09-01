# Modèle de données

## Vue d'ensemble

Le site porte plusieurs familles de contenu, chacune avec son propre front matter et, pour certaines, son propre fichier `_data/*.yml` :

- **Page pays / destination** (voir `screens/country.md`) : une trentaine de pages, chacune combinant un front matter riche (texte éditorial) et un fichier `_data/countries/<ref>.yml` (données chiffrées et structurées).
- **Page d'accueil**, **carte du monde**, **calendrier**, **FAQ**, **bonus**, **inspiration**, **prochaines bulles** : une page fonctionnelle chacune, pilotée par un ou plusieurs fichiers `_data/*.yml` dédiés.
- **Page 404** : une seule page, sans équivalent par langue.

Toutes les pages (sauf la 404) existent en deux fichiers Markdown, un par langue, reliés par un champ `ref` commun (voir "Conventions générales" ci-dessous). Aucun script ne valide automatiquement la cohérence de ces données (voir "Conventions générales").

## Page d'accueil (front matter)

`index.md` (français, `permalink: /`) et `index-en.md` (anglais, `permalink: /en/`), `layout: index`, `ref: home` :

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

| Champ | Rôle |
|---|---|
| `h1` | Titre affiché en surimpression sur le carousel d'accueil |
| `h2` | Sous-titre affiché sous le `h1` |

Le contenu Markdown après le front matter n'est pas utilisé (le layout `index.html` assemble uniquement des includes pilotés par `_data/*`, voir `screens/home.md`).

Le carousel plein écran de l'accueil n'a pas de fichier de données dédié : comme pour les galeries de pages pays (voir "Images" ci-dessous), sa liste de photos est un scan automatique de `site.static_files`, ici sur `photos/home-carousel/`. Convention de nommage différente de celle des galeries pays : `NNN.webp` (3 chiffres, ex. `001.webp` à `014.webp`), sans vignette `-th.`.

### Données de l'accueil

| Fichier | Rôle |
|---|---|
| `_data/home-manifest.yml` (FR) / `_data/home-manifest-en.yml` (EN) | 8 items du bloc "manifeste" (`icon`, `title`, `text`) — **seule donnée du site dupliquée en deux fichiers séparés par langue plutôt qu'en clés bilingues** (voir "Conventions générales") |
| `_data/home-team.yml` | Présentation de l'équipe, bilingue dans un seul fichier (voir ci-dessous) |
| `_data/portfolio.yml` | Sélection de photos "dernières plongées", bilingue (voir ci-dessous) |

`_data/home-team.yml` :

```yaml
- img: sam.jpg
  name: Sam
  likes:
    - fr-label: La nature et les grands espaces
      en-label: Nature and the great outdoors
      grade: 90
  insta: christophe.uw
```

| Champ | Description |
|---|---|
| `img` | Nom de fichier dans `photos/home-team/`, écrit en `.jpg` dans le YAML mais servi en `.webp` via un filtre Liquid `\| replace: '.jpg', '.webp'` (vestige d'une ancienne convention, voir `technical-specifications.md`) |
| `name` | Prénom affiché |
| `likes` | Liste de centres d'intérêt, chacun avec `fr-label`/`en-label` et `grade` (0-100, affiché en barre de progression) |
| `insta` | Optionnel : identifiant Instagram, absent pour Sam, présent pour Tof (`christophe.uw`) et Ti'Crab (`TiCrab_travels`) |

`_data/portfolio.yml` :

```yaml
- img: marseille.webp
  page-ref: france
```

| Champ | Description |
|---|---|
| `img` | Nom de fichier dans `photos/home-portfolio/` |
| `page-ref` | `ref` de la page pays associée ; le libellé et la date affichés (`visited-in`) sont lus sur cette page cible via `site.pages \| where: "ref", page-ref \| where: "lang", page.lang`, pas dupliqués dans `portfolio.yml` |

Un même `page-ref` peut apparaître plusieurs fois avec des `img` différentes (ex. `france` ×3, `philippines` ×2).

## Page pays / destination

### Front matter

Un fichier par langue à la racine de `pages/<ocean>/` (français) et `pages/<ocean>/<slug>-en.md` (anglais), `layout: country` :

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
  Texte de présentation de la destination (Markdown).

country-desc-sections:      # optionnel, voir ci-dessous
  - title: Cerbère Banyuls
    text: |
      Texte Markdown

dive-shop: |
  Texte Markdown sur le(s) club(s) de plongée fréquenté(s).

accommodation: |
  Texte Markdown sur l'hébergement.

to-see: |
  Texte Markdown sur les activités hors plongée.

log-books:
  - author: Sam
    place: Guraidhoo Kandu - South Male Atoll
    date: 25/12/2015
    text: |
      Récit Markdown d'une plongée précise.
```

| Champ | Rôle |
|---|---|
| `ref` | Identifiant partagé entre les deux langues de cette page (voir "Conventions générales") ; aussi la clé vers `_data/countries/<ref>.yml` et vers le dossier `photos/<ref>/` |
| `permalink` | Traduit indépendamment par langue, y compris le segment d'océan (voir "Conventions de nommage" dans `technical-specifications.md`) |
| `sea` | Un des six océans (`atlantic`, `caribbean`, `indian`, `mediterranean`, `pacific`, `redsea`), pilote la variante visuelle de la bannière de page (voir `style-guide.md`) |
| `menu` | Libellé affiché dans le sous-menu de navigation et repris comme libellé par défaut sur la carte du monde et le portfolio d'accueil quand aucun libellé dédié n'est fourni |
| `visited-in` | Date(s) de visite en texte libre (ex. "Décembre 2015"), affichée en italique dans le bloc pratique |
| `h1` | Nom de la destination précédé d'un emoji drapeau ISO du pays |
| `country-desc` | Texte de présentation (Markdown), peut contenir des liens vers des fichiers de `docs/` (voir ci-dessous) |
| `country-desc-sections` | **Optionnel**, présent sur seulement 7 des 33 pages pays (`indonesia`, `france`, `italy`, `french-polynesia`, `philippines`, `mexico-baja-california`, `egypt`) : liste de sous-sections (`title`/`text`) affichées en accordéon sous `country-desc`, pour les destinations couvrant plusieurs sites géographiques distincts |
| `dive-shop`, `accommodation`, `to-see` | Toujours présents (vérifié sans exception sur les pages existantes), affichés dans un accordéon à 3 volets même si le texte est court |
| `log-books` | Toujours au moins une entrée (vérifié sans exception) ; `author`, `place`, `date` (texte libre, pas toujours au format JJ/MM/AAAA), `text` (Markdown) |

Tous les autres champs (`layout`, `ref`, `permalink`, `lang`, `lang-flag`, `title`, `description`, `sea`, `menu`, `visited-in`, `h1`, `country-desc`, `dive-shop`, `accommodation`, `to-see`, `log-books`) sont présents sur les 33 pages pays sans exception.

### Données chiffrées (`_data/countries/<ref>.yml`)

Un fichier par pays, nommé d'après `ref` (33 fichiers, correspondance 1:1 avec les pages pays) :

```yaml
difficulty: 70
visibility: 60
diversity: 80
atmosphere: 70

water-temperatures:
  - fr-water-temperature-period: En décembre
    en-water-temperature-period: In December
    water-temperature: 30
    fr-water-temperature-comment: Tubbataha & Coron   # optionnel
    en-water-temperature-comment: Tubbataha & Coron   # optionnel

best-seasons:
  - fr-best-season-from: décembre
    fr-best-season-to: avril
    en-best-season-from: December
    en-best-season-to: April
    fr-best-season-comment:      # optionnel, parfois vide
    en-best-season-comment:

fauna:
  - fr-name: Requins baleines
    en-name: Whale sharks
    strong: true       # optionnel : met le nom en avant dans l'affichage

maps:                   # optionnel, voir ci-dessous
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

| Champ | Description |
|---|---|
| `difficulty`, `visibility`, `diversity`, `atmosphere` | Entiers 0-100, toujours présents sur les 33 fichiers, affichés en barres de progression "x/10" (voir `screens/country.md`) |
| `water-temperatures` | Toujours présent, une entrée par période distincte (généralement une seule ; 8 destinations en ont plusieurs : `bonaire`, `egypt`, `france`, `french-polynesia`, `martinique`, `mexico-baja-california`, `philippines` (2 chacune), `indonesia` (3)). `water-temperature` est généralement un entier mais peut être une plage textuelle (ex. `"17-20"` pour `south-africa`) |
| `best-seasons` | Toujours présent, même structure à entrées multiples possibles (une seule destination en a plusieurs : `indonesia`, 3 entrées) |
| `fauna` | Toujours présent, liste de taille variable (2 à 42 entrées observées) |
| `maps` | **Optionnel**, présent sur 21 des 33 fichiers (les 12 sans carte : belize, canary-islands, cape-verde, hawaii, japan, les-saintes, madagascar, maldives, mozambique, sao-tome, south-africa, tanzania). Une entrée par carte (une destination peut en avoir plusieurs, jusqu'à 4 pour les Philippines), chaque carte avec ses propres `points` (voir "Cartes interactives" dans `style-guide.md` pour l'affichage et la répartition en grille) |

`maps[].points[].icon` vaut `diveFlagIcon` (site bien exploré) ou `diveFlagIconGrey` (site secondaire/moins exploré). Un point peut aussi porter un `ref` et des `fr-date`/`en-date` dans les données (ex. `_data/countries/france.yml`), mais `country-map.html` ne lit que `point.place` pour construire le popup : ces champs sont présents dans le YAML sans être exploités par le template actuel (voir "Cartes interactives" dans `style-guide.md`).

### Images (`photos/<ref>/`)

Convention commune à toutes les galeries du site (pages pays et page bonus, voir ci-dessous) :

| Fichier | Rôle |
|---|---|
| `NNNN.webp` (4 chiffres) | Photo pleine résolution, affichée dans la modale plein écran |
| `NNNN-th.webp` | Vignette utilisée dans le carousel de la page. Si la photo originale fait déjà ≤ 600 px de large, la vignette est un fichier identique à l'original (constaté sur `maldives/0001.webp`) ; sinon, plus grande dimension ramenée à 600 px |

**Aucune liste explicite en front matter** : la galerie d'une page est construite par un scan automatique de `site.static_files` filtré sur `photos/<page.ref>/*.webp` (en excluant les fichiers `-th.` pour la liste principale). Ajouter une photo dans le bon dossier suffit, sans toucher au front matter (voir `screens/country.md`).

Le premier fichier `0001.webp` d'un dossier sert aussi d'image Open Graph par défaut de la page (voir "SEO" dans `technical-specifications.md`).

### Cartes et PDF annexes (`docs/`)

`docs/` contient des cartes de plongée et un itinéraire au format image (`.webp`) ou PDF, référencés **uniquement depuis le texte Markdown** de `country-desc` (jamais en front matter structuré), avec le même fichier utilisé par les deux langues :

```markdown
**<i class="fa fa-mail-forward"></i>**{: .accent-color} Voici la carte des sites de plongées : [<i class="fa fa-map"></i>](/docs/south-africa-alishoal-map.webp){: target="_blank"}.
```

Convention de nommage : `<ref>-<description>.webp` (ou `.pdf`), avec une exception observée (`docs/lanzarote-guia-ideal.pdf`, référencé depuis la page `canary-islands`, nommé d'après la localité plutôt que le `ref` de la page).

## Page 404

`404.md`, `layout: "404"`, `ref: "404"`, `permalink: /404.html`, `sitemap: {exclude: 'yes'}`. Contrairement aux autres pages du site, il n'existe qu'**une seule page 404** pour les deux langues (`lang-flag: 🇫🇷 🇬🇧`, `lang: fr`), affichant une carte Leaflet centrée sur un point océanique fictif ("Nemo Point").

## Carte du monde (front matter et données)

`pages/world-map.md` / `-en.md`, `layout: map`, `ref: world-map`, pas de champ `sea` (le layout n'inclut pas de bannière). Toutes les données viennent de `_data/world-map.yml` :

```yaml
- lat: -20.43522
  lng: 57.32068
  icon: diveFlagIcon
  fr-country: Ile Maurice
  en-country: Mauritius
  fr-date: septembre 2013
  en-date: September 2013
```

| Champ | Description |
|---|---|
| `lat`, `lng` | Obligatoires |
| `icon` | `diveFlagIcon` (destination de plongée) ou `homeIcon` (un seul point, "Home sweet home", Paris) |
| `ref` | Optionnel : lie le point à une page pays existante. Si présent, le libellé du popup devient un lien vers cette page ; à défaut de `fr-country`/`en-country`, le libellé affiché est `menu` de la page cible, et à défaut de `fr-date`/`en-date`, la date affichée est `visited-in` de la page cible |
| `place` | Optionnel, sous-titre libre ajouté après un tiret (utile pour les archipels avec plusieurs points, ex. Polynésie française ×11, Philippines ×4) |
| `fr-country` / `en-country` | Optionnel : libellé affiché sans lien si `ref` est absent (lieux visités sans page dédiée, ex. Île Maurice, Vietnam), ou libellé de substitution si fourni en complément d'un `ref` |
| `fr-date` / `en-date` | Optionnel, voir `ref` ci-dessus |

Un même `ref` peut apparaître plusieurs fois (plusieurs sites dans le même pays).

## Calendrier (front matter et données)

`pages/calendar.md` / `-en.md`, `layout: calendar`, `ref: calendar`, `sea: next` (partagé avec `next-bubbles`, sert uniquement à choisir la variante de bannière, voir `style-guide.md`). Pas de contenu propre au-delà du front matter commun : toute la donnée vient de `_data/calendar.yml` croisé avec `best-seasons` de chaque `_data/countries/<ref>.yml` (voir `screens/calendar.md`).

`_data/calendar.yml` :

```yaml
- num: 1
  img: 0001.webp
  fr-name: janvier
  en-name: January
```

12 entrées, une par mois. `img` référence `photos/calendar/<img>` (le filtre Liquid `\| replace: '.jpg','.webp'` appliqué à ce champ est un no-op ici, vestige de la même ancienne convention que `home-team.yml`).

## FAQ (front matter)

`pages/faq.md` / `-en.md`, `layout: faq`, `ref: faq`, `sea: faq` :

```yaml
qa:
  - N: 01
    I: fa-flag
    Q: "Comment choisir un club de plongée ?"
    A: |
      Réponse Markdown.
```

`qa` : liste de 8 items. `N` (numéro/identifiant, chaîne), `I` (classe d'icône Font Awesome complète, préfixe `fa-` inclus, voir `style-guide.md`), `Q` (question), `A` (réponse Markdown). Structure identique FR/EN.

## Bonus (front matter)

`pages/bonus.md` / `-en.md`, `layout: bonus`, `ref: bonus`, `sea: bonus`. Contenu Markdown libre après le front matter (`{{ content }}`, liste de sources d'eau chaude avec liens vers les pages pays correspondantes quand elles existent). Réutilise le même mécanisme de galerie que les pages pays (voir "Images" ci-dessus) sur `photos/bonus/`, puisque `page.ref == "bonus"`.

## Inspiration (front matter)

`pages/inspiration.md` / `-en.md`, `layout: inspiration`, `ref: inspiration`, `sea: inspiration`. Contenu Markdown libre (liste de recommandations livres/vidéos avec liens externes). Pas de galerie photo : une image statique unique (`/assets/img/inspiration.webp`) sert d'illustration, voir `style-guide.md`.

## Prochaines bulles (front matter)

`pages/next-bubbles.md` / `-en.md`, `layout: next`, `ref: next-bubbles`, `sea: next` :

```yaml
h2: Souhaits de bubulles
bubbles:
  - month: Mar
    day:
    icon: fa-flag
    content: |
      ?
  - month: "????"
    day: "??"
    icon: fa-ship
    content: |
      Océan Pacifique : Cook, Tonga, Philippines, ...
```

`bubbles` : liste ordonnée manuellement (pas de tri par date). Une envie sans date encore fixée s'exprime par convention littérale plutôt que par un champ absent : `day` vide, ou `month`/`day` renseignés à `"????"`/`"??"`. Cette page n'apparaît pas dans `_data/menu.yml` (voir "Navigation" dans `functional-specifications.md`).

## Conventions générales

- **Slugs** : minuscules ASCII et tirets (kebab-case) en anglais pour tout identifiant technique (`ref`, noms de fichiers `_data/countries/*.yml`, dossiers `photos/*/`), ex. `french-polynesia`, `mexico-baja-california`.
- **`ref` commun aux deux langues d'une même page**, toujours identique entre le fichier FR et le fichier EN (vérifié sans exception) : c'est la clé qui relie les deux versions linguistiques (sélecteur de langue, alternates `hreflang`, sitemap, image Open Graph par défaut, voir `technical-specifications.md`). Le `permalink`, lui, est traduit indépendamment par langue (voir "Conventions de nommage" dans `technical-specifications.md`) — ne jamais utiliser le `permalink` pour retrouver l'équivalent d'une page dans l'autre langue, toujours passer par `ref`.
- **Un contenu ajouté existe dans les deux langues** : chaque page `pages/*.md` a son pendant `-en.md` (vérifié systématiquement), et chaque fichier `_data/countries/<ref>.yml` sert les deux langues via des clés `fr-*`/`en-*` plutôt que des fichiers séparés — seule exception : `home-manifest.yml`/`home-manifest-en.yml`, dupliqué en deux fichiers plutôt qu'en clés bilingues dans un seul (incohérence de convention à signaler, pas à corriger sans validation).
- **Pas de script de validation des données** : aucune vérification automatique de l'unicité des `ref`, de la présence des deux fichiers de langue, ou de la correspondance entre une page pays et son fichier `_data/countries/<ref>.yml`. Ces règles sont respectées par convention, pas vérifiées mécaniquement (la CI ne fait qu'un `jekyll build` suivi d'un `html-proofer` non bloquant, voir `technical-specifications.md`).
