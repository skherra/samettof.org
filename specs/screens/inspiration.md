# Écran : inspiration

`_layouts/inspiration.html`, pages `pages/inspiration.md` (FR, `/inspiration/`) / `-en.md` (EN, `/en/inspiration/`), `ref: inspiration`.

## Objectif

Partager des recommandations de livres et de vidéos ayant inspiré les auteurs pour leurs voyages de plongée.

## Contenu et structure

- Bannière de page (`sea: inspiration`, voir `style-guide.md`).
- Deux colonnes : illustration statique unique (`/assets/img/inspiration.webp`, 2000×1500 px, voir `style-guide.md`) à gauche, contenu Markdown libre à droite (`{{ content }}`, liste de recommandations avec icônes selon le type — livre, vidéo — et liens externes vers des sites tiers comme Babelio, YouTube, IMDb, Goodreads ou les sites d'éditeurs).
- Contrairement à l'écran bonus, **pas de galerie photo** ici : l'illustration est fixe.

## Interactions

Aucune interaction spécifique à cet écran au-delà des liens externes du contenu Markdown (ouverture standard, comportement du navigateur).

## États (chargement, erreur, vide)

Aucun état particulier : contenu entièrement statique.

## Responsive

Deux colonnes (`col-md-6`) qui repassent en une colonne sous le breakpoint `md`, comportement natif de la grille Bootstrap.
