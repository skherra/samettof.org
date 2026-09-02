# Écran : accueil

`_layouts/index.html`, pages `index.md` (FR) / `index-en.md` (EN), `ref: home`.

## Objectif

Présenter les auteurs (Sam, Tof, Ti'Crab) et donner accès aux différentes sections du site, en mettant en avant les dernières plongées et l'ampleur des voyages effectués.

## Contenu et structure

Cinq blocs assemblés dans cet ordre (pas de bannière de page, contrairement aux autres écrans, voir `page-banner.html` dans `style-guide.md`) :

1. **Carousel** (`home-carousel.html`) : galerie plein écran des photos de `photos/home-carousel/` (voir "Images" dans `data-model.md` pour la construction dynamique de la liste). Légende en surimpression : `page.h1` / `page.h2` (front matter, voir `data-model.md`).
2. **Manifeste** (`home-manifest.html`) : 8 blocs icône + titre + texte (`_data/home-manifest.yml`, voir `data-model.md`).
3. **Portfolio** (`home-portfolio.html`) : grille de photos "dernières plongées" (`_data/portfolio.yml`), chaque tuile liant vers la page pays correspondante avec son libellé et sa date de visite.
4. **Équipe** (`home-team.html`) : une colonne par membre (`_data/home-team.yml`), photo, centres d'intérêt en barres de progression, lien Instagram optionnel.
5. **Compteurs** (`home-counters.html`) : 4 chiffres clés animés (pays visités, plongées, croisières, "plongeurs heureux").

Voir `style-guide.md` pour le détail visuel de chaque composant.

## Interactions

- **Carousel** : autoplay, indicateurs cliquables, flèches Bootstrap standards (voir `style-guide.md`).
- **Tuile de portfolio** : clic navigue vers la page de la destination correspondante ; survol déclenche un zoom de l'image et fait apparaître la légende (masquée par défaut, contrairement au calendrier où elle est toujours visible, voir `style-guide.md`).
- **Compteurs** : l'animation d'incrémentation se déclenche dès le chargement de la page, puis une seconde fois au premier passage du bloc dans le viewport (scroll).

## États (chargement, erreur, vide)

- Les valeurs des compteurs sont codées en dur dans `home-counters.html` (voir `style-guide.md`) : aucun état "vide" ou calculé possible.
- Le carousel, le portfolio et l'équipe dépendent tous de données présentes en dur dans le dépôt (fichiers `_data/*` ou dossier `photos/home-carousel/`) : pas de comportement de repli documenté si l'un de ces fichiers était vide.

## Responsive

- Pas de media query custom (voir "Espacements et grille" dans `style-guide.md`) : la mise en page dépend uniquement de la grille Bootstrap.
- La légende du carousel (`h1`/`h2`) est masquée sous le breakpoint `md` (`d-none d-md-block`).
