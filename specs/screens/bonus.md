# Écran : bonus

`_layouts/bonus.html`, pages `pages/bonus.md` (FR, `/bonus/`) / `-en.md` (EN, `/en/bonus/`), `ref: bonus`.

## Objectif

Partager une sélection de sources d'eau chaude visitées par les auteurs, hors du périmètre strict de la plongée.

## Contenu et structure

- Bannière de page (`sea: bonus`, voir `style-guide.md`).
- Deux colonnes : contenu Markdown libre à gauche (`{{ content }}`, liste de sources d'eau chaude avec liens vers les pages pays correspondantes quand elles existent, voir `data-model.md`), galerie photo à droite.
- La galerie réutilise **exactement le même composant** que celui des pages destination (`country-carousel.html`, voir `screens/country.md` et `style-guide.md`), appliqué au dossier `photos/bonus/` puisque `page.ref == "bonus"` (voir "Images" dans `data-model.md`).

## Interactions

Identiques à la galerie photo d'une page destination : carousel de vignettes avec autoplay, clic pour ouvrir la modale plein écran positionnée sur la photo choisie (voir `screens/country.md`).

## États (chargement, erreur, vide)

Aucun état particulier documenté : la galerie dépend du contenu de `photos/bonus/`, ajouté manuellement au dépôt.

## Responsive

Deux colonnes (`col-md-6`) qui repassent en une colonne sous le breakpoint `md`, comportement natif de la grille Bootstrap.
