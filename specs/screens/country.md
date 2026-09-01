# Écran : page pays / destination

`_layouts/country.html`, écran générique partagé par les 33 pages de destination du site (voir `data-model.md`) : ce document ne décrit pas une destination en particulier, mais le comportement commun à toutes, piloté par le front matter de la page et par `_data/countries/<ref>.yml`. Toute différence entre destinations se limite au contenu, jamais au comportement.

## Objectif

Donner au visiteur toutes les informations utiles pour évaluer et préparer une plongée dans cette destination : présentation, avis chiffrés, informations pratiques, retours d'expérience vécus, galerie photo et cartes des sites.

## Contenu et structure

- Bannière de page (`page-banner.html`, voir `style-guide.md`) : nom de l'océan + `page.h1` (nom de la destination précédé d'un drapeau).
- Quatre blocs empilés, chacun sur deux colonnes (`container-fluid`, voir `style-guide.md` pour le détail visuel) :
  1. **Présentation** (`country-about.html`, `page.country-desc` + accordéon optionnel `country-desc-sections`) + **galerie photo** (`country-carousel.html`).
  2. **Avis chiffrés** (`country-opinion.html`, 4 barres de progression) + **informations pratiques** (`country-practical.html`, accordéon Club/Hébergement/À voir).
  3. **Carnet de plongée** (`country-logbook.html`, `page.log-books`) + **bon à savoir** (`country-good-to-know.html`, température, saison, faune).
  4. **Cartes des sites** (`country-map.html`), pleine largeur, **affiché uniquement si la destination a un champ `maps`** (21 des 33 destinations, voir `data-model.md`).

Voir `data-model.md` pour le détail des champs front matter et `_data/countries/<ref>.yml` consommés par chacun de ces blocs.

## Interactions

- **Galerie photo** : le carousel principal affiche les vignettes ; un clic sur une vignette ouvre une modale plein écran positionnée sur la photo cliquée (`$('#modalCarousel').carousel(index)`), avec ses propres flèches, sans autoplay contrairement au carousel principal (voir `style-guide.md`).
- **Accordéon "Présentation"** (si `country-desc-sections` est renseigné) et **accordéon "Informations pratiques"** : ouverture/fermeture au clic, comportement standard Bootstrap. Le premier volet de "Informations pratiques" est ouvert par défaut ; l'accordéon de "Présentation" est fermé par défaut (aucun volet initial imposé observé).
- **Carnet de plongée** : autoplay (10s) entre les différents extraits si plusieurs entrées existent, navigation manuelle possible via les flèches custom.
- **Cartes** : popup Leaflet standard au clic sur un marqueur, affichant uniquement le libellé `place` du point (voir `style-guide.md`). Contrairement à la carte du monde, un point de `maps` ne devient pas un lien même s'il porte un `ref` (voir `data-model.md`) : ce champ existe dans les données mais n'est pas exploité par cet écran.

## États (chargement, erreur, vide)

- **`country-practical.html` n'a pas de garde conditionnelle** : les trois volets (Club, Hébergement, À voir) s'affichent toujours, même si le texte associé est très court. En pratique, `dive-shop`/`accommodation`/`to-see` sont toujours renseignés (voir `data-model.md`).
- **`country-logbook.html` n'a pas de garde conditionnelle** sur `log-books` : si ce champ était vide, le titre "Log Book" et un carousel vide s'afficheraient quand même. Non observé en pratique (toutes les destinations ont au moins une entrée).
- **`country-map.html` a une garde conditionnelle** (`{%- if mapList -%}`) : le bloc "Cartes des sites" ne s'affiche pas du tout pour les 12 destinations sans champ `maps` (voir `data-model.md`).
- **`country-about.html`** : l'accordéon de sous-sections ne s'affiche que si `country-desc-sections` est renseigné (7 destinations sur 33, voir `data-model.md`).

## Responsive

Pas de media query custom : mise en page à deux colonnes (`col-md-6`) qui repasse en une colonne en dessous du breakpoint `md`, comportement natif de la grille Bootstrap.
