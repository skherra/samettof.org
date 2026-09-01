# Écran : prochaines bulles

`_layouts/next.html`, pages `pages/next-bubbles.md` (FR, `/prochaines-bulles/`) / `-en.md` (EN, `/en/next-bubbles/`), `ref: next-bubbles`.

## Objectif

Partager les envies de prochains voyages de plongée des auteurs, à des stades de certitude variables (destination et date confirmées, ou simple envie encore floue).

## Contenu et structure

- Bannière de page (`sea: next`, partagée avec l'écran calendrier, voir `data-model.md`).
- `page.h2` : sous-titre ("Souhaits de bubulles").
- Liste chronologique d'envies de voyage (`page.bubbles`, front matter, voir `data-model.md`), chaque entrée avec un badge date, une icône et un texte libre Markdown.

## Interactions

Aucune interaction spécifique : liste statique, pas de tri, pas de filtre. L'ordre d'affichage suit l'ordre de la liste dans le front matter, pas un ordre chronologique calculé.

## États (chargement, erreur, vide)

Une envie sans date confirmée s'exprime par une convention de contenu plutôt que par un champ manquant : `day` vide, ou `month`/`day` renseignés littéralement à `"????"`/`"??"` (voir `data-model.md`). Ce ne sont pas des états gérés par le layout, mais des valeurs de texte ordinaires.

## Responsive

Pas de media query custom : liste en pleine largeur, comportement natif de la grille Bootstrap.
