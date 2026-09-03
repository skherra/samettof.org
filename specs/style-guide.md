# Charte graphique

## Couleurs

### Palette

Variables LESS (`@variable`), définies une seule fois en tête de `assets/css/samettof.less` :

| Rôle | Variable | Hex |
|---|---|---|
| Accent, liens, éléments actifs | `@blue` | `#0a9fd8` |
| Texte courant (`html`/`body`) | `@grey` | `#666` |
| Texte fort, titres internes, nav-links | `@dark-grey` | `#444` |
| Texte secondaire (légende "visité en") | `@light-grey` | `#ACB2B8` |

```less
@blue:        #0a9fd8;
@light-grey:  #ACB2B8;
@grey:        #666;
@dark-grey:   #444;
@navbar-full-height: 66px;
@footer-height: 36px;
```

Toutes ces variables sont utilisées ailleurs dans le fichier (aucune orpheline détectée).

Plusieurs couleurs sont codées en dur dans `samettof.less` sans être remontées en variable, à ne pas dupliquer sans d'abord les y ajouter si elles doivent devenir réutilisables :

| Couleur | Usage |
|---|---|
| `#36353A` | Halo `text-shadow` (`0px 0px 20px #36353A`) sur les titres en surimpression de photo : `h1`/`h2` du carousel d'accueil, bannière de page, légendes (`h3`) des vignettes de portfolio d'accueil et du calendrier, nom/lien du membre en surimpression de photo (équipe) |
| `#050F1E` | Texte du bloc `.portfolio-item-content` (portfolio d'accueil et du calendrier) |
| `#ffffff` | Fond de repli des bannières de page |
| `rgba(68, 68, 68, 0.75)` | Fond de la modale plein écran des galeries photo |
| `black` | Ombre portée du portrait circulaire de l'en-tête |
| `white` / `#FFF` | Texte en surimpression de photo, mais aussi : fond de page (`body`), fond du pied de page, texte au survol des items de menu déroulant, lien de fermeture de la modale photo |
| `rgba(0, 0, 0, .125)` | Bordure haute du pied de page (même valeur que la bordure de `.card` Bootstrap, réutilisée plutôt que dupliquée) |

Le bleu par défaut de Bootstrap 4 (`#007bff`) est présent dans les variables CSS vendored mais n'est utilisé nulle part dans le HTML/LESS custom du site : l'accent visuel du site est systématiquement `@blue` (`#0a9fd8`), pas le bleu Bootstrap.

### Utilisation

Fond clair par défaut (pas de variable `@bg` : le site n'a pas de fond sombre global, contrairement à d'autres projets de l'auteur). Texte courant en `@grey`. Liens en `@blue` (pas de couleur de survol distincte définie pour les liens simples). Icônes d'accent et éléments actifs (barres de progression, indicateurs de carousel, boutons d'accordéon ouverts) en `@blue`.

## Typographie

- **Police unique** : Ubuntu (Google Fonts), `font-family: Ubuntu, sans-serif` sur `html`/`body`. Pas de police de titres distincte (contrairement à d'autres projets de l'auteur qui combinent deux familles).
- Chargée via l'ancienne API Google Fonts (`css?family=Ubuntu`), sans graisse explicite : seul le poids 400 est effectivement chargé. Les titres utilisent `font-weight: bolder` (mot-clé relatif) : le rendu gras est donc vraisemblablement un gras synthétique du navigateur, pas une graisse Ubuntu dédiée chargée — voir `technical-specifications.md`.
- `rel="preconnect"` vers `fonts.googleapis.com` et `fonts.gstatic.com`.

| Usage | Taille | Graisse | Notes |
|---|---|---|---|
| `h1` carousel d'accueil | 32px | bolder | Majuscules (`text-transform: uppercase`), halo `#36353A` |
| `h2` carousel d'accueil | 24px | bolder | Halo `#36353A` |
| `h1` bannière de page (hors accueil) | 20px | bolder | Majuscules, halo `#36353A` |
| `h1` portfolio / équipe (accueil) | 32px | bolder | Titre de section (pas en surimpression de photo), couleur `@dark-grey`, centré, pas de halo |
| `h3` manifeste / portfolio (halo `#36353A`, en surimpression) / good-to-know | 20px (good-to-know : `font-size` 14px, `line-height` 18px) | bolder | |
| `h2` de contenu (pages simples) | 16px | bolder | `border-bottom: 2px solid #eee`, `span` interne souligné `@blue` (2px) |
| Corps de texte, `main` | 14px, `line-height: 20px` | normal | Couleur `@grey` |
| Légende "visité en" | 14px | normal, italique | Couleur `@light-grey` |

## Espacements et grille

Pas d'échelle d'espacement custom : la grille et les classes utilitaires de Bootstrap 4 (`container`, `container-fluid`, `row`/`col-*`, `p-*`/`m-*`) sont utilisées telles quelles. Aucune media query custom dans `samettof.less` : le responsive repose entièrement sur la grille Bootstrap et le comportement natif de `navbar-expand-lg` (bascule en menu "burger" sous le breakpoint `lg`, 992px).

## Composants UI de base

### En-tête / navigation (`_includes/header.html`)

- Navbar Bootstrap `fixed-top` (toujours visible en scrollant ; `main { margin-top: @navbar-full-height }` compense la hauteur fixe de 66px).
- Logo : `assets/img/dive-flag.webp` (300×300 px), affiché en 40×40 px, `rounded-circle`, ombre portée (`box-shadow: 1px 1px 2px black`), lien vers l'accueil de la langue courante.
- Menu généré depuis `_data/menu.yml` : liens simples et sous-menus déroulants par océan (voir `data-model.md`). `.nav-link` en `@dark-grey`, `@blue` au survol. `.dropdown-item:hover` : fond `@blue`, texte blanc.
- Le sélecteur de langue ne fait pas partie de l'en-tête : il vit dans le pied de page (voir "Pied de page" ci-dessous).

### Pied de page (`_includes/footer.html`)

- Navbar Bootstrap `fixed-bottom` (toujours visible en scrollant ; `main { margin-bottom: @footer-height }` compense la hauteur fixe de 36px), fond blanc, bordure haute `1px solid rgba(0, 0, 0, .125)`. Réutilise la classe `.navbar` (et son flex `justify-content: space-between`) pour répartir ses deux seuls enfants sans grille custom.
- Licence à gauche (`#footer-license`) : lien vers la licence Creative Commons BY-NC-SA 4.0 du contenu (`deed.fr`/`deed.en` selon `page.lang`), icônes Font Awesome (`fab fa-creative-commons`, `-by`, `-nc-eu`, `-sa`) suivies du libellé `CC BY-NC-SA 4.0`.
- Sélecteur de langue à droite (`#footer-lang`, drapeaux emoji 🇫🇷/🇬🇧) : même logique Liquid que l'ancien sélecteur d'en-tête (`site.pages | where:"ref", page.ref`), réutilise la classe `.lang-flag` avec un `padding`/`line-height` réduits propres au pied de page (surchargés sous `#footer-lang`).
- `#worldMap` (carte du monde plein écran) et le cas particulier de la page 404 tiennent compte de cette hauteur fixe en plus de celle de l'en-tête : `height: calc(100vh - @navbar-full-height - @footer-height)` (voir "Cartes interactives" ci-dessous).

### Bannière de page (`_includes/page-banner.html`, toutes les pages hors accueil)

- Hauteur fixe **150px**, `padding: 50px 0`, image de fond en `cover`, une variante par valeur de `sea` (`.banner-{sea}`, image `/assets/img/banner/<sea>.webp`, 1440×150 px).
- Deux `h1` : le premier affiche le nom de l'océan (seulement pour les 6 valeurs de `sea` correspondant à un océan réel ; pour `next`/`bonus`/`faq`/`inspiration`, ce premier `h1` reste vide alors que la classe `.banner-<sea>` s'applique quand même au fond), le second affiche `page.h1`. Texte blanc, halo `#36353A`.

### Carousels (Bootstrap 4, `data-ride="carousel"`)

Le site utilise le composant carousel Bootstrap à cinq endroits, avec des réglages différents :

| Carousel | Autoplay | Indicateurs | Flèches |
|---|---|---|---|
| Accueil (`home-carousel.html`) | Oui | Oui (points) | Standard Bootstrap |
| Galerie pays/bonus, vignettes (`country-carousel.html`, `#photosCarousel`) | Oui | Oui | Custom (`fa-angle-left`/`fa-angle-right`) |
| Galerie pays/bonus, modale plein écran (`#modalCarousel`) | **Non** (`data-ride="false"`) | — | Positionné sur la photo cliquée au clic sur une vignette |
| Carnet de plongée (`country-logbook.html`, `#logCarousel`) | Oui, `data-interval="10000"` (10s) | Non | Custom (`fa-chevron-circle-left`/`-right`), superposées en haut à droite |

Le carousel d'accueil masque sa légende (`h1`/`h2`) sous le breakpoint `md` (`d-none d-md-block`).

### Compteurs animés (`_includes/home-counters.html`, accueil uniquement)

- 4 colonnes, icônes Font Awesome 3x en `@blue`, chiffre 48px bolder `@blue`.
- Animation d'incrémentation (0 → valeur cible en 5000ms) déclenchée sans condition au chargement de la page (`$(document).ready`), puis redéclenchée une seconde fois au premier passage du bloc dans le viewport (`jquery.appear.js` + `counter.js`, voir `technical-specifications.md`).
- Les valeurs cibles (`data-to`) sont codées en dur dans le HTML de l'include, pas calculées depuis les données du site.

### Portfolio (`_includes/home-portfolio.html`, `_includes/country-carousel.html` vignettes, calendrier)

- Tuile `position: relative; overflow: hidden`, image `width/height: 100%`.
- Au survol (`transition: all .5s` sur l'accueil et le calendrier) : zoom + légère rotation de l'image (`scale(1.3) rotate(3deg)`), apparition d'un voile et d'une légende (`opacity: 0 → 1`).
- **Différence entre l'accueil et le calendrier** : sur l'accueil, le texte du bloc (`#050F1E`) n'apparaît qu'au survol (`opacity: 0` par défaut) ; sur le calendrier, il est **toujours visible** (`opacity: 1`), seul le zoom de l'image se déclenche au survol.
- Aucune dimension fixe pour les images sources du portfolio d'accueil : ratios variables (ex. 1000×750, 1004×564, 1024×576).

### Équipe (`_includes/home-team.html`, accueil)

- Une colonne par membre, photo 800×600 px pleine largeur de colonne.
- Nom en surimpression bas-droite (blanc, 20px bolder, halo `#36353A`).
- Icône Instagram en surimpression bas-gauche, affichée uniquement si `item.insta` est renseigné (absent pour Sam).
- Barres de progression fines (`height: 3px`, remplissage `@blue`) sous chaque centre d'intérêt (`likes`), avec le pourcentage `grade`.

### Page pays : présentation et carnet (`country-about.html`, `country-logbook.html`)

- `country-about.html` : texte libre (`country-desc`), suivi d'un accordéon optionnel (`country-desc-sections`, seulement 7 destinations) réutilisant les mêmes classes `.card`/`.card-header`/`.collapse` que `country-practical` et la FAQ, avec une icône `fa-angle-up.control-icon` qui pivote (`rotate(-180deg)`) selon l'état ouvert/fermé.
- `country-logbook.html` : gros guillemet ouvrant (`“`, 64px, `@blue`) chevauchant le texte (`margin-bottom: -40px`) au-dessus de chaque extrait de carnet.

### Page pays : avis chiffrés et informations pratiques (`country-opinion.html`, `country-practical.html`, `country-good-to-know.html`)

- `country-opinion.html` : 4 barres de progression (`height: 1.2rem`) pour Difficulté / Visibilité / Richesse / Ambiance, libellé "x/10" affiché dans la barre (avec décimale si non multiple de 10, ex. 65 → "6.5/10").
- `country-practical.html` : accordéon Bootstrap à 3 volets fixes (Club de plongée, Hébergement, À voir), premier volet ouvert par défaut. Toujours affiché, même si le texte associé est court — pas de garde conditionnelle sur le contenu vide.
- `country-good-to-know.html` : trois blocs d'information (température de l'eau, meilleure saison, faune/flore), chacun avec sa propre icône (voir "Iconographie" ci-dessous).

### Cartes interactives (Leaflet, `country-map.html`, `map.html`, `404.html`)

- Fond de tuiles satellite Esri World Imagery (pas Google Maps), pas de plugin de clustering.
- Marqueurs custom : `diveFlagIcon` (drapeau bleu, site bien exploré), `diveFlagIconGrey` (drapeau gris, site secondaire), `homeIcon` (point "maison", un seul point sur la carte du monde). Toutes les icônes de marqueur : 16×27 px affichées (fichiers sources 50×83 px), avec ombre portée dédiée (`shadow.png`, 76×47 px source, 19×12 px affichée).
- Une icône `eyeIcon` est déclarée dans le script mais n'est utilisée par aucune donnée actuelle (`_data/world-map.yml`, `_data/countries/*.yml`) — probablement prévue pour un usage futur, à vérifier avant de la considérer comme morte.
- `country-map.html` : une carte Leaflet par entrée de `maps` (hauteur fixe 550px), réparties en lignes de 3 colonnes (`col-md-4`) ; le reliquat de la division par 3 (0, 1 ou 2 cartes) se partage à parts égales la largeur de sa propre ligne (ex. 4 cartes → 3 en `col-md-4` + 1 seule en `col-md-12` ; 5 cartes → 3 en `col-md-4` + 2 en `col-md-6`). N'apparaît que si le pays a un champ `maps` (21 des 33 destinations, voir `data-model.md`).
- `map.html` : carte plein écran (`height: calc(100vh - 66px - 36px)`, hauteur de l'en-tête puis du pied de page), centrée sur `[0, 0]`, zoom initial 2, un marqueur par entrée de `_data/world-map.yml`.
- `404.html` : même mécanisme que `map.html`, mais centrée sur un point océanique fictif ("Nemo Point"), avec un unique marqueur menant à un article externe (nouvel onglet).

### Calendrier (`_layouts/calendar.html`)

- Grille de 12 tuiles mensuelles (voir "Portfolio" ci-dessus pour le style visuel des tuiles), chaque tuile ouvrant une modale Bootstrap listant les destinations dont la meilleure saison couvre ce mois.

### Accordéon FAQ (`_layouts/faq.html`)

- Même structure `.card`/`.card-header`/`.collapse` que les autres accordéons du site, mais **toutes les questions sont fermées par défaut** (contrairement à `country-practical.html`, dont le premier volet est ouvert).

### Bonus / Inspiration (`_layouts/bonus.html`, `_layouts/inspiration.html`)

- Deux colonnes (`col-md-6`) : contenu Markdown d'un côté, illustration de l'autre.
- `bonus.html` réutilise le même composant carousel + modale que les pages pays (`country-carousel.html`, sur `photos/bonus/`).
- `inspiration.html` affiche une image statique unique (`/assets/img/inspiration.webp`, 2000×1500 px), pas de galerie.

## Images

| Image | Ratio / dimensions observées |
|---|---|
| Photo de galerie pays/bonus (originale) | Variable, jusqu'à ~2000 px sur le grand côté |
| Vignette de galerie (`-th.webp`) | Grand côté ramené à 600 px (identique à l'original si celui-ci est déjà ≤ 600 px) |
| Carousel d'accueil (`photos/home-carousel/`) | 1920×950 px |
| Portfolio d'accueil (`photos/home-portfolio/`) | Variable (ex. 1000×750, 1004×564, 1024×576) |
| Équipe (`photos/home-team/`) | 800×600 px uniforme |
| Tuile calendrier (`photos/calendar/`) | 600×337 px uniforme |
| Bannière de page (`assets/img/banner/*.webp`) | 1440×150 px exactement |
| Logo (`assets/img/dive-flag.webp`) | 300×300 px (affiché 40×40 px) |
| Illustration inspiration | 2000×1500 px |
| Icônes de marqueur Leaflet | 50×83 px source (affichées 16×27 px) |

## Iconographie

Font Awesome, chargé via Kit distant (voir `technical-specifications.md`), pas de version figée par CDN explicite. Usage mixte de préfixes `fa-`/`fas fa-` selon l'ancienneté du code ajouté.

| Usage | Icône |
|---|---|
| Compteur "pays visités" | `fa-paper-plane` |
| Compteur "plongées" | `fa-flag` |
| Compteur "croisières" | `fa-ship` |
| Compteur "plongeurs heureux" | `fa-smile-o` |
| Instagram (équipe) | `fa-instagram` |
| Chevron d'accordéon (about / practical / FAQ) | `fa-angle-up` (classe `.control-icon`, pivote selon l'état) |
| Flèches du carousel de galerie | `fa-angle-left` / `fa-angle-right` |
| Fermeture de la modale photo | `fas fa-times` |
| Flèches du carnet de plongée | `fas fa-chevron-circle-left` / `fas fa-chevron-circle-right` |
| Température de l'eau | `fa-tint` |
| Meilleure saison | `fas fa-sun` |
| Faune/flore | `fa-eye` |
| Club de plongée | `fa-ship` |
| Hébergement | `fa-bed` |
| À voir | `fa-binoculars` |
| Manifeste (8 items) | `fa-flag-o`, `fa-eye`, `fa-paw`, `fa-anchor`, `fa-certificate`, `fa-globe`, `fa-heart`, `fa-camera-retro` |
| FAQ (par question, front matter `I:`) | variable selon la question (ex. `fa-flag`, `fa-certificate`, `fa-adjust`, `fa-cog`, `fa-briefcase`, `fa-eye`, `fa-camera-retro`, `fa-binoculars`) |
| Lien vers un document annexe (`docs/`) | `fa-mail-forward` (renvoi), `fa-map` ou `fa-file-pdf-o` selon le type de fichier |
| Licence (pied de page) | `fab fa-creative-commons`, `fab fa-creative-commons-by`, `fab fa-creative-commons-nc-eu`, `fab fa-creative-commons-sa` |

| Usage | Emoji |
|---|---|
| Sélecteur de langue FR | 🇫🇷 |
| Sélecteur de langue EN | 🇬🇧 |
| Page 404 (bilingue) | 🇫🇷 🇬🇧 |
| `h1` d'une page pays | Drapeau ISO du pays concerné (un par destination, ex. 🇲🇻 Maldives) |
| Titre du calendrier | 📅 |
| Titre de la page inspiration | 💡 |
| Titre de la page FAQ | 💬 |
| Titre de la page bonus | ♨️ |
| Titre de la carte du monde | 🌍 |
