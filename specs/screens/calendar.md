# Écran : calendrier

`_layouts/calendar.html`, pages `pages/calendar.md` (FR, `/calendrier/`) / `-en.md` (EN, `/en/calendar/`), `ref: calendar`.

## Objectif

Aider le visiteur à choisir une période de voyage en listant, mois par mois, les destinations du site dont c'est la meilleure saison de plongée.

## Contenu et structure

- Bannière de page (`sea: next`, partagée avec l'écran "Prochaines bulles" ; le premier `h1` de la bannière reste vide puisque `next` ne correspond à aucun des six océans, voir `style-guide.md`).
- Grille de 12 tuiles, une par mois (`_data/calendar.yml`, voir `data-model.md`), même traitement visuel que le portfolio d'accueil (voir "Portfolio" dans `style-guide.md`) à la différence que la légende du mois reste toujours visible (pas seulement au survol).

## Interactions

- **Clic sur une tuile mois** : ouvre une modale Bootstrap listant, par ordre alphabétique, toutes les destinations dont au moins une entrée `best-seasons` (`_data/countries/<ref>.yml`, voir `data-model.md`) couvre ce mois, avec un lien vers chaque page pays. La logique gère le passage d'une saison à cheval sur deux années civiles (ex. décembre → avril). Une destination avec plusieurs entrées `best-seasons` correspondant au même mois n'apparaît qu'une seule fois dans la liste.
- **Survol d'une tuile** : zoom léger de l'image de fond (voir `style-guide.md`).

## États (chargement, erreur, vide)

- Toutes les entrées `best-seasons` de chaque destination sont prises en compte pour le classement mensuel (une seule destination en a plusieurs : `indonesia`, 3 entrées).
- Un mois sans destination correspondante affiche une modale vide (comportement non vérifié explicitement).

## Responsive

Pas de media query custom : grille Bootstrap standard (`col-*`), modale Bootstrap standard.
