# Écran : FAQ

`_layouts/faq.html`, pages `pages/faq.md` (FR, `/faq/`) / `-en.md` (EN, `/en/faq/`), `ref: faq`.

## Objectif

Répondre aux questions pratiques les plus fréquentes sur la préparation d'un voyage de plongée (choix d'un club, certifications, matériel, budget...), indépendamment d'une destination précise.

## Contenu et structure

- Bannière de page (`sea: faq`, voir `style-guide.md`).
- Accordéon Bootstrap unique (`#faqAccordion`), une entrée par item de `page.qa` (front matter, voir `data-model.md`) : icône, question, réponse en Markdown.

## Interactions

- **Clic sur une question** : ouvre/ferme la réponse associée (accordéon Bootstrap standard, voir `style-guide.md`). Contrairement à l'accordéon "Informations pratiques" des pages destination, **toutes les questions sont fermées par défaut**, aucune n'est ouverte au chargement de la page.
- Pas de lien direct (ancre) vers une question précise : l'accordéon ne modifie pas l'URL.

## États (chargement, erreur, vide)

Aucun état particulier : les 8 questions sont fixées dans le front matter (voir `data-model.md`).

## Responsive

Pas de media query custom : accordéon Bootstrap standard, pleine largeur quelle que soit la taille d'écran.
