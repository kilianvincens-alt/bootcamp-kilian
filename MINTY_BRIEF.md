# MINTY · Brief produit & design

> Version 0.1 · Mai 2026 · Référence vivante pour le développement. À relire à chaque tour avant de coder.

## 1. Le projet en 30 secondes

Marketplace française mobile-first de cartes à collectionner Pokémon (extension Magic, Yu-Gi-Oh, One Piece, Lorcana en phase 2). Différenciation : la marketplace française la plus sécurisée. Chaque carte est vérifiée par IA puis par un expert humain. Chaque paiement est séquestré jusqu'à réception confirmée.

- **Tagline** : Drop culture meets trust.
- **Promesse** : Sérieux comme une banque, désirable comme un sneaker drop.
- **Trois mots** : Sell · Buy · Trade.

## 2. Cibles

- **Collectionneurs confirmés** (25-40 ans) — génération Pokémon 1999, nostalgiques, transigent en confiance
- **Débutants** (16-25 ans) — veulent oser se lancer sans peur de l'arnaque
- Peur commune n°1 : se faire arnaquer
- Le système de confiance à 4 niveaux résout les deux cibles avec un seul mécanisme

## 3. Système de confiance à 4 niveaux

1. IA vérifie chaque carte mise en vente (photo standardisée face / dos / tranche)
2. Si doute IA → escalade à un expert humain
3. Si doute expert → annonce publiée avec badge transparent « Authenticité non garantie »
4. Si fake confirmé → suppression + signalement vendeur (3 strikes = bannissement)

Couplé à un **paiement séquestré Stripe Connect** (argent libéré seulement à réception confirmée).

## 4. Identité visuelle

### Couleurs (variables CSS exactes)

```
--ink:        #0F1410   /* Noir profond — type, UI base */
--ink-soft:   #1a221d
--mint:       #5EE2A0   /* Vert menthe — signature, CTA, dot */
--mint-deep:  #2ec77f   /* CTA hover, point signature */
--cream:      #F2EFE7   /* Surface principale, fond pages */
--paper:      #FAF8F2   /* Surface secondaire, cartes */
--gold:       #D4AF37   /* Grade 10 / Rare */
--silver:     #B8B8B8   /* Grade 9 / Near Mint */
--bronze:     #CD7F32   /* Grade 8 / Excellent */
--holo-red:   #FF3B5C   /* Alert / Fake / Litige */
--trust-blue: #2D6CDF   /* Verified IA + Humans */
--coral:      #D85A30   /* Monétisation (boosts, crédits, pricing) */
```

### Typographie

- **Space Grotesk** (Google Fonts) — poids 400 / 500 / 700
  - 400 : body
  - 500 : UI, boutons, libellés, navigation
  - 700 : display, titres, hero
- **JetBrains Mono** — 400 / 500
  - Labels (uppercase, letter-spacing 0.22em), prix tabulaires, codes, metadata
- Letter-spacing display : -0.02em à -0.045em selon taille
- Sentence case sauf labels mono qui sont UPPERCASE

### Ton

- Phrases courtes. Termine par un point.
- Voix française neutre, sobre, précise.
- Mots-clés : Authentifié. Mint condition. Sealed payment. Trade safely. Verified by humans. Backed by IA.

### Do

- Surfaces mates, papier crème, encre noire profonde
- Détails iridescents très ciblés (foil holo uniquement pour rareté Holo / Ultra / Secret)
- Aucun dégradé sauf foil holographique
- Ombres douces, longues, basses opacités
- Coins arrondis 12-16px sur tous les modules UI
- Icônes line, stroke 1.5px, caps ronds
- Le point vert menthe comme signature (badge, puce, séparateur)

### Don't

- Esthétique geek / otaku années 2000
- Couleurs criardes saturées partout, pas de vert kaki agressif
- Mascottes officielles, fan-art, illustrations enfantines
- Effets 3D bling, néons gaming, glassmorphism daté
- Stock photos de mains tenant des billets
- Templates startup générique, gradient violet / bleu SaaS

## 5. Sitemap — 34 écrans cibles (adaptés au MVP bootcamp)

### Priorité MVP (10 écrans pour soutenance J5)

1. Home (Drops + Trending)
2. Recherche / Catalogue
3. Fiche carte (badge auth + historique prix + vendeur)
4. Panier
5. Checkout (escrow visible)
6. Confirmation commande
7. Sell flow (catalogue → photos → état → IA → publié)
8. Trade (proposer + sceller)
9. Profil + ma collection
10. Page Confiance (différenciante)

### Phase 2 (post-MVP)

Onboarding (splash, 3 slides, signup/login, KYC, permissions), Messages, Notifications, Dashboard vendeur, Wallet, Expédition, Boost, Crédit troc paywall, Litige & SAV, Pricing & Minty+, Paramètres, Aide, CGU.

## 6. Monétisation — 4 sources de revenus

### Source 1 · Commission 5 % sur transactions
- vs eBay 12 %, Vinted 10 %, Whatnot 8 %
- Prélevée au capture Stripe
- Encaissée à la livraison confirmée (déblocage escrow)
- Visible en clair dans le panier et au checkout

### Source 2 · Boosts d'annonces

- **Spotlight 24h** — 1,99 € — Tête des recherches sur la carte ciblée 24h
- **Top 7 jours** — 4,99 € — Top 3 résultats set / rareté pendant 7j
- **Home Featured 48h** — 9,99 € — Carrousel home + push aux abonnés

Label discret "Featured · Minty" sur les annonces boostées. Max 20 % de cartes boostées visibles à l'écran. Tous les boosts inclus avec Minty+.

### Source 3 · Crédits Troc (paywall)

- 1 troc gratuit par mois par utilisateur
- Max 3 trocs actifs simultanés
- Si quota épuisé OU 3 trocs actifs → paywall
- Options : +1 troc 2,99 € · Pack 5 trocs 9,99 € (valide 90j) · Minty+ illimité

### Source 4 · Abonnement Minty+ (récurrent 4,99 €/mois)

- Trocs illimités
- Tous les boosts inclus
- Badge premium sur profil
- Early access aux drops (futur)

## 7. Seed data — 12 cartes minimum pour la démo

Sets : Base, Jungle, Fossile, Neo Genesis. Cartes iconiques : Dracaufeu, Tortank, Florizarre, Pikachu, Mewtwo, Alakazam, Léviator, Lugia, Mew, Insécateur, Ronflex, Dracolosse.

Images via `https://images.pokemontcg.io/{setCode}/{number}_hires.png` (CDN officiel TCG, gratuit).
Avatars via `https://i.pravatar.cc/150?u={username}`.

Pour chaque listing :
- imageUrl
- marketPrice (de 18 € à 850 € selon rareté)
- priceHistory : 30 points, sinus + bruit autour du market price
- authStatus : verified (80 %), pending (15 %), unguaranteed (5 %)
- boost : aucun, spotlight, ou featured (max 20 %)

## 8. Parcours de démo (pour le pitch J5)

### Scénario 1 · Le doute du débutant
Home → fiche Dracaufeu PSA 10 → onglet « Authenticité » → Page Confiance → retour → Acheter → checkout avec escrow visible → confirmation.

### Scénario 2 · Le power-seller
Sell → choisir carte dans le catalogue (1-clic, 30 sec) → photos → état → IA Verified → suggestion Boost → Home Featured 48h → confirmation → Dashboard avec stats.

### Scénario 3 · Le troqueur
Trade → Proposer → builder n vs n → Sceller → « Trocs ce mois : 1/1 utilisé » → tente un 2e → Paywall → Minty+.

### Scénario 4 · La transparence
Pricing → tableau comparatif vs eBay / Vinted / Whatnot → CTA Minty+.

## 9. Contraintes techniques (cadre bootcamp Delta)

- Un seul fichier `index.html` à la racine du repo
- Bibliothèques chargées via CDN (pas de `npm install`, pas de build)
- Pas de framework lourd (pas de React / Vue / Next.js / Svelte)
- Backend Supabase obligatoire (auth + BDD pour les listings, users, orders, trades)
- Hosting GitHub Pages, push = déployé en 1-2 min
- Mobile-first, fonctionne à 390px

### Stack effectivement utilisée

- HTML / CSS / Vanilla JS
- Tailwind CSS via CDN (avec config inline pour les tokens Minty)
- Lucide Icons via CDN (icônes line)
- Chart.js via CDN (historique des prix)
- Supabase JS via CDN (auth + BDD)
- Routing maison par hash (#/home, #/card/:id, etc.)
- État UI en mémoire (Map / Array JavaScript)
