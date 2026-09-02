# Écran : carte du monde

`_layouts/map.html`, pages `pages/world-map.md` (FR, `/carte/`) / `-en.md` (EN, `/en/map/`), `ref: world-map`.

## Objectif

Donner une vue d'ensemble géographique de tous les lieux visités par les auteurs, plongées comme escales sans page dédiée.

## Contenu et structure

- Pas de bannière de page (le layout n'inclut pas `page-banner.html`, contrairement aux autres écrans hors accueil).
- Carte Leaflet plein écran (`#worldMap`, hauteur `calc(100vh - 66px - 36px)`, entre l'en-tête et le pied de page), centrée sur `[0, 0]`, zoom initial 2, fond de tuiles satellite Esri World Imagery (voir `style-guide.md`).
- Un marqueur par entrée de `_data/world-map.yml` (voir `data-model.md` pour le détail des champs), plus un marqueur "Home sweet home" (icône dédiée `homeIcon`) à Paris.

## Interactions

- **Clic sur un marqueur** : ouvre un popup Leaflet standard (comportement natif de la librairie, pas de JS custom) affichant le libellé du lieu, éventuellement un lien vers sa page pays si le point porte un `ref` (voir `data-model.md`), et la date de visite.
- Zoom/déplacement de la carte : interactions Leaflet standards (molette, glisser, boutons +/-).
- Pas de filtre par océan, par saison ni par type de lieu : tous les marqueurs sont affichés simultanément.

## États (chargement, erreur, vide)

- Aucun état particulier : la liste de marqueurs vient intégralement de `_data/world-map.yml`, présente à chaque build.

## Responsive

Pas de media query custom : la carte occupe systématiquement `calc(100vh - 66px - 36px)`, quelle que soit la taille d'écran ; le zoom/pan tactile est géré nativement par Leaflet sur mobile.
