# Spécifications fonctionnelles générales

## Contexte et objectifs

Le site présente les voyages de plongée sous-marine de Sam, Tof et Ti'Crab : une trentaine de destinations visitées à travers le monde (Atlantique, Caraïbes, océan Indien, Méditerranée, mer Rouge, Pacifique), chacune documentée par une description du site, du club de plongée fréquenté, de l'hébergement, un carnet de plongée (extraits vécus) et une carte des spots. Le site propose aussi une vue d'ensemble (carte du monde, calendrier des meilleures saisons par destination) et des pages de contenu éditorial (FAQ, bonus, inspirations).

L'objectif est d'aider un visiteur qui prépare un voyage de plongée à choisir une destination et une période, et à trouver des informations pratiques issues de l'expérience directe des auteurs.

## Périmètre du site

Dans le périmètre :

- Page d'accueil présentant les auteurs et donnant accès aux différentes sections (voir `screens/home.md`).
- Consultation de chaque destination visitée (une trentaine, réparties par océan) : description, club de plongée, hébergement, à voir, carnet de plongée, cartes des sites (voir `screens/country.md`).
- Carte du monde interactive de l'ensemble des lieux visités (voir `screens/world-map.md`).
- Calendrier des meilleures saisons de plongée par destination (voir `screens/calendar.md`).
- FAQ pratique sur la préparation d'un voyage de plongée (voir `screens/faq.md`).
- Page bonus (sources d'eau chaude visitées) (voir `screens/bonus.md`).
- Page d'inspirations voyage (livres, vidéos) (voir `screens/inspiration.md`).
- Page non trouvée (voir "Page non trouvée" ci-dessous).
- Site multilingue (français, anglais).

Voir aussi "Hors périmètre" ci-dessous.

## Utilisateurs cibles

Le site s'adresse à des visiteurs qui préparent ou envisagent un voyage de plongée sous-marine : famille, amis, plongeurs à la recherche de retours d'expérience, curieux arrivés depuis un moteur de recherche ou un réseau social. Il n'y a pas de distinction de rôle côté visiteur : pas de compte, pas d'espace personnel, pas de contenu personnalisé.

Le contenu (descriptions, carnets de plongée, données de chaque destination) est produit par les auteurs directement dans les fichiers sources du dépôt (voir `data-model.md`), pas via une interface d'administration.

## Parcours utilisateurs principaux

1. Un visiteur arrive sur la page d'accueil, découvre les auteurs (manifeste, portfolio des dernières plongées, présentation de l'équipe, compteurs de voyages) et accède aux sections via le menu de navigation.
2. S'il cherche une destination précise, il la trouve dans le menu (classé par océan) ou sur la carte du monde, et arrive sur sa page dédiée : description du site de plongée, avis chiffrés (difficulté, visibilité, richesse, ambiance), informations pratiques (club, hébergement, à voir), carnet de plongée, galerie photo, et éventuellement des cartes détaillées des spots.
3. S'il hésite entre plusieurs destinations selon la période de voyage, il consulte le calendrier, qui liste par mois les destinations dont c'est la meilleure saison.
4. S'il a des questions pratiques génériques (matériel, certification, budget...), il consulte la FAQ.
5. Depuis n'importe quelle page, il navigue vers une autre section via le menu, toujours visible en haut de page.

## Règles transverses

### Multilingue

- Le site est disponible en français et en anglais.
- Le français est la langue par défaut (`lang: "fr"` dans `_config.yml`) : ses pages sont servies à la racine du site, sans préfixe (`/`, `/faq/`...). L'anglais est préfixé par `/en/`.
- Chaque page existe en deux fichiers sources distincts (un par langue), reliés entre eux par un identifiant commun (`ref`, voir `data-model.md`) plutôt que par une traduction dynamique.
- Contrairement à un site avec pied de page, le sélecteur de langue est intégré à l'en-tête (drapeaux emoji 🇫🇷/🇬🇧), à l'intérieur du menu qui se replie derrière le bouton "burger" sur mobile (voir "En-tête / navigation" dans `style-guide.md`, commun à tout le site).
- Il n'existe aucun mécanisme de détection automatique de la langue du navigateur ni de mémorisation d'un choix de langue : chaque page est statique et sert la langue de son URL.
- Il n'y a pas de contenu partiellement traduit dans ce site : chaque destination et chaque page fonctionnelle existent systématiquement dans les deux langues (voir "Conventions générales" dans `data-model.md`), à l'exception de la page non trouvée (voir ci-dessous).

### Navigation

- Menu de navigation unique, en en-tête, présent sur toutes les pages (`fixed-top`, toujours visible en scrollant) : un lien par page fonctionnelle simple (carte du monde, calendrier, inspiration, FAQ, bonus) et un sous-menu déroulant par océan listant ses destinations (voir `_data/menu.yml` dans `data-model.md`). L'ordre des entrées suit l'ordre éditorial du fichier de données, pas un tri alphabétique (ex. dans les Caraïbes, les Saintes apparaît après le Mexique-Yucatán).
- **Pas de pied de page** sur ce site (contrairement à d'autres projets de l'auteur) : aucune information (réseaux sociaux, licence, sélecteur de langue) n'est répétée en bas de page. Le sélecteur de langue vit dans l'en-tête (voir "Multilingue" ci-dessus).
- Aucun lien externe vers d'autres sites de l'auteur n'a été trouvé sur ce site (pas de "sites soeurs" au sens où d'autres projets de l'auteur le pratiquent) : les seuls liens externes identitaires sont les comptes Instagram individuels de Tof et Ti'Crab dans la présentation de l'équipe sur l'accueil (voir `screens/home.md`), Sam n'en ayant pas de renseigné.

### Page non trouvée

- Contrairement aux autres pages du site, il n'existe qu'**une seule page 404** pour les deux langues (`404.md`, `permalink: /404.html`), pas une paire FR/EN reliée par `ref` (voir "Conventions générales" dans `data-model.md`) : exception à la règle multilingue ci-dessus.
- Elle affiche une carte interactive centrée sur un point océanique fictif ("Nemo Point"), avec un marqueur menant à un article externe, plutôt qu'un simple message d'erreur (voir "Cartes interactives" dans `style-guide.md`).

## Hors périmètre

- Comptes utilisateurs, authentification.
- Édition de contenu via une interface web : le contenu est créé et modifié directement dans les fichiers sources (voir `data-model.md`).
- Contenu généré par les visiteurs (commentaires, notes, contributions).
- Recherche ou filtrage libre des destinations : la seule vue filtrée est le calendrier par mois (voir `screens/calendar.md`), il n'existe pas de recherche texte ni de filtre par critère (région, difficulté...).
- Détection ou mémorisation automatique de la langue du visiteur (voir "Multilingue" ci-dessus).
- Cookies, tracking, analytics : aucun mécanisme de ce type sur le site (voir "Performance" dans `technical-specifications.md`).
