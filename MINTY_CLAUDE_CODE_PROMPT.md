# Minty — Prompt Claude Code pour le MVP cliquable

Ce document contient **deux choses à coller dans Claude Code** :

1. **Partie A** — le prompt initial à lancer dans une nouvelle session Claude Code (à la racine de ton repo).
2. **Partie B** — le contenu du fichier `MINTY_BRIEF.md` à créer dans ton repo (Claude Code le lira à chaque tour).

> **Ordre recommandé** : ouvre Claude Code dans un dossier vide, lance le prompt A, laisse-le créer le projet, puis colle B dans le fichier `MINTY_BRIEF.md` qu'il aura créé.

---

## PARTIE A · Prompt initial Claude Code

Copie tout ce qui est entre les `===` ci-dessous et colle-le dans Claude Code en première instruction.

```
===

Tu vas construire avec moi le MVP cliquable d'une marketplace française de cartes à collectionner Pokémon, nom de marque "Minty". C'est un prototype front-end uniquement, navigable, avec données mockées en mémoire. Pas de backend réel, pas de base de données, pas d'auth réelle. L'objectif : pouvoir montrer 34 écrans cohérents à des utilisateurs et investisseurs en 2 semaines.

ÉTAPE 1 — Setup du projet

Crée à la racine un projet Next.js 14 avec App Router, TypeScript, Tailwind CSS, et les packages suivants :
- next@14, react@18, react-dom@18, typescript
- tailwindcss, autoprefixer, postcss
- lucide-react (icônes)
- framer-motion (transitions)
- recharts (graph historique de prix)
- clsx, tailwind-merge

Structure de dossiers à créer :
/app
  /(marketing)         → landing, /trust, /pricing, /help, /legal
  /(app)               → toutes les routes app authentifiées (mockées)
    /home
    /search
    /catalog
    /card/[id]
    /offer/[id]
    /cart
    /checkout
    /orders/[id]
    /sell
      /pick
      /photos
      /state
      /review
    /dashboard
    /boost/[listingId]
    /trade
      /list
      /propose/[targetUserId]
      /[tradeId]
      /credits
    /messages
    /notifications
    /profile/[username]
    /collection
    /follow
    /reviews
    /settings
    /dispute/[orderId]
  /onboarding
  /auth
    /signup
    /login
    /kyc
    /permissions
/components
  /ui                  → primitives (Button, Card, Badge, Input, etc.)
  /minty               → composants spécifiques (CardListing, HoloFoil, TrustBadge, BoostBanner, PriceChart, etc.)
  /layout              → AppShell, BottomNav, TopBar
/lib
  /mock                → données mockées (cartes, users, listings, orders, trades)
  /design              → tokens Minty (couleurs, typo)
  /utils
/styles
  globals.css

ÉTAPE 2 — Lis impérativement le fichier MINTY_BRIEF.md à la racine avant d'écrire la moindre ligne de code produit. Il contient :
- L'identité visuelle Minty (couleurs, typo, ton, do/don't)
- Le sitemap complet des 34 écrans avec ce que chaque écran doit contenir
- Les règles de monétisation (commission 5%, boosts, quota troc, Minty+)
- Les données mock à générer

Si MINTY_BRIEF.md n'existe pas encore à la racine, arrête-toi, dis-le-moi, et je te le fournirai avant que tu écrives le code.

ÉTAPE 3 — Ordre d'implémentation strict

Tu vas construire dans cet ordre, en t'arrêtant à chaque jalon pour me montrer le résultat avant de continuer :

JALON 1 — Tokens & layout shell
1.1  globals.css avec les variables CSS Minty (--ink #0F1410, --mint #5EE2A0, --mint-deep #2ec77f, --cream #F2EFE7, --paper #FAF8F2, --gold #D4AF37, --silver #B8B8B8, --bronze #CD7F32, --holo-red #FF3B5C, --trust-blue #2D6CDF)
1.2  Configure Tailwind pour utiliser ces variables. Polices via next/font : Space Grotesk (400/500/700) + JetBrains Mono (400/500)
1.3  Composant Logo Minty (wordmark "Minty" + point vert menthe + cadre arrondi optionnel) en 3 variantes : icon, wordmark, lockup
1.4  AppShell avec TopBar (logo + recherche + notifications + avatar) et BottomNav 5 onglets (Home / Search / Sell / Trade / Profile)
1.5  Primitives UI : Button (primary mint, secondary outline, ghost, destructive), Card, Badge, Input, Modal, Sheet, Tabs, Skeleton

→ STOP. Montre-moi l'AppShell vide avec la BottomNav et un screenshot du Logo. J'attends mon OK avant de continuer.

JALON 2 — Données mock & catalogue Pokémon
2.1  Génère un fichier /lib/mock/cards.ts avec 60 cartes Pokémon mockées (Charizard, Pikachu, Mewtwo, Blastoise, Venusaur, Gyarados, Dragonite, etc., toutes éditions Base/Jungle/Fossil/Team Rocket/Neo Genesis). Chaque carte : id, name, set, setNumber, rarity (Common/Uncommon/Rare/Holo/Ultra/Secret), imageUrl (utilise les URLs publiques de https://images.pokemontcg.io/ — exemple base1-4 pour Charizard Base Set — vérifie les patterns), marketPrice30d, lastSalePrice, salesCount30d, priceHistory (array de 30 points {date, price})
2.2  Génère /lib/mock/users.ts avec 12 utilisateurs : @kvincens (moi), @cardking, @pokefr, @holomint, etc. Chaque user : id, username, avatarUrl (https://i.pravatar.cc/150?u=...), bio, joinedAt, salesCount, rating (1-5), strikes, isVerified, isMintyPlus, tradeQuotaUsedThisMonth, activeTradesCount
2.3  Génère /lib/mock/listings.ts avec 40 annonces : id, cardId, sellerId, condition (Mint/NM/EX/LP/DMG), price, photos (3 URLs face/dos/tranche), authStatus (Verified/Pending/Unguaranteed), boostStatus (null | Spotlight24h | Top7d | HomeFeatured48h), boostExpiresAt, listedAt
2.4  Génère /lib/mock/orders.ts (8 commandes à différents statuts), /lib/mock/trades.ts (5 trocs), /lib/mock/notifications.ts
2.5  Crée un Provider React Context /lib/mock/MockProvider.tsx qui expose useCards, useUsers, useListings, useOrders, useTrades + useCurrentUser (renvoie @kvincens par défaut). Tout en mémoire, mutations possibles via useReducer pour simuler les actions.

→ STOP. Montre-moi un tableau simple listant les 60 cartes avec leurs prix. J'attends mon OK.

JALON 3 — Écrans Onboarding + Home (zones 01 et 02 du sitemap)
3.1  Splash (01.01) avec animation 1.2s framer-motion
3.2  Onboarding 3 slides (01.02) — chaque slide est plein écran cream avec illustration SVG simple (pas de stock photo), texte court, dot indicator. Les 3 messages : "Authentifié par IA + humains", "Paiement séquestré jusqu'à réception", "Sell · Buy · Trade"
3.3  Sign up / Login (01.03) avec boutons Apple/Google/Email mockés (clic → redirige direct vers /onboarding/kyc)
3.4  KYC light (01.04) — formulaire tel + adresse + bouton "Connecter Stripe" mocké
3.5  Permissions (01.05) — 3 cartes Notif/Photo/Contacts avec toggle, bouton "Continuer"
3.6  Home (02.01) — 3 sections verticales : Drops du moment (carrousel horizontal cartes featured boostées avec label discret "Featured · Minty"), Trending 7j (grille 2 colonnes), Pour toi (grille 2 colonnes). Max 20% de cartes boostées visibles à l'écran.
3.7  Search (02.02) — search bar sticky, suggestions, filtres en sheet bottom (set, rareté, état min, prix max, vendeurs vérifiés)
3.8  Catalog / Sets (02.03) — grille de packs par série avec compteur d'annonces
3.9  Messages (02.04) — liste de threads avec miniature carte + statut
3.10 Notifications (02.05) — liste chronologique

→ STOP. Montre-moi les 10 écrans en screenshots. J'attends mon OK.

JALON 4 — Parcours acheteur (zone 03)
4.1  Fiche carte / annonce (03.01) — hero visuel carte + photos vendeur en thumbnails (tap = zoom), bloc prix + CTA Acheter / Faire une offre, badge IA Verified/Pending/Unguaranteed (très visible), label "Featured · Minty" discret si boostée, onglets Description/Vendeur/Expédition/Similaires
4.2  Historique prix (03.02) — modal ou /app/card/[id]/history avec recharts (LineChart 30/90/365j toggle), volumes, médiane, dernière vente
4.3  Faire une offre (03.03) — sheet avec input prix + message court, prix moyen marché en référence, durée 48h
4.4  Panier (03.04) — multi-vendeurs, chaque ligne montre vendeur + frais de port, total + breakdown take rate 5% visible
4.5  Checkout (03.05) — formulaire Stripe Payment Element mocké, adresse, livraison Mondial Relay/Colissimo, bandeau escrow rassurant
4.6  Suivi commande (03.06) — Timeline 5 étapes (Payé → Préparée → Expédiée → En transit → Livrée), tracking, bouton "Signaler un problème"
4.7  Réception & confirmation (03.07) — modal "Tout est conforme ?" Oui (escrow débloqué + review form 5 étoiles) / Non (litige 07.03)

→ STOP. Montre-moi le parcours acheteur en clic-à-clic. J'attends mon OK.

JALON 5 — Parcours vendeur + Boost (zone 04 incluant 04.08)
5.1  Sell pick (04.01) — recherche dans catalogue 18k cartes (sur le mock de 60, on simule le pattern), sélection 1-clic
5.2  Photos guidées (04.02) — 3 slots Face/Dos/Tranche avec overlay caméra simulé (placeholder + bouton upload mocké qui assigne une image stub)
5.3  État & prix suggéré (04.03) — slider Mint/NM/EX/LP/DMG avec mini visuels de référence, prix suggéré pré-rempli (basé sur marketPrice30d), input éditable
5.4  IA pré-vérif (04.04) — loader 2s puis statut au hasard (80% Verified, 15% Pending, 5% Unguaranteed pour la démo). Card finale avec suggestion "Booster cette annonce ?" → bouton vers /boost/[id]
5.5  Dashboard vendeur (04.05) — Tabs : Annonces actives / Ventes en cours / Historique / Stats / Boosts. KPIs en haut. Chaque annonce active a un bouton "Booster"
5.6  Expédition (04.06) — étiquette pré-générée (PDF mocké en image), info Mondial Relay/Colissimo
5.7  Wallet & payout (04.07) — solde dispo + séquestré + historique payouts. Breakdown clair : -5% commission + dépenses boost. Bouton "Virer sur mon compte"
5.8  Boost une annonce (04.08) — écran corail, 3 cards de boost :
     • Spotlight 24h · 1,99 €
     • Top 7 jours · 4,99 €
     • Home Featured 48h · 9,99 €
     Chaque card explique impressions estimées, durée, zones d'affichage. Stripe Checkout mocké. Post-achat → écran de confirmation avec compteur de temps restant et stats simulées (impressions, clics, conversion).
     Mention : "Inclus avec Minty+"

→ STOP. Montre-moi le parcours vendeur. J'attends mon OK.

JALON 6 — Troc + Paywall (zone 05 incluant 05.05)
6.1  Wishlist & vitrine troc (05.01) — deux listes côte à côte : "Je cherche" / "Je donne". Toggle public/privé.
6.2  Proposer un troc (05.02) — builder n cartes vs n cartes, valorisation marché de chaque pile + delta, suggestion de carte d'appoint si déséquilibre
6.3  Chat négociation (05.03) — thread de chat dédié au troc, possibilité de modifier la proposition, historique des versions
6.4  Sceller le troc (05.04) — récap final, compteur quota visible en haut ("Trocs ce mois : 0/1 gratuit"). Si quota épuisé OU activeTradesCount >= 3 → bouton "Sceller" est désactivé et un lien rouge "Crédit nécessaire" mène vers /trade/credits
6.5  Crédit troc paywall (05.05) — écran corail, 3 options :
     • +1 troc · 2,99 €
     • Pack 5 trocs · 9,99 € (valide 90j)
     • Minty+ · 4,99 €/mois (trocs illimités + boosts inclus + badge)
     Stripe Checkout mocké. Post-achat → retour au troc qu'on voulait sceller.

→ STOP. Montre-moi le parcours troc + paywall. J'attends mon OK.

JALON 7 — Profil & social (zone 06)
7.1  Profil public (06.01) — header avatar + bio + badges (Verified Seller, X ventes, ancienneté, Minty+ si applicable), vitrine cartes en vente, note moyenne, boutons Suivre + Message
7.2  Ma collection (06.02) — vue privée, valorisation totale 30j, filtres set/rareté, toggle "à vendre" / "à troquer" sur chaque carte
7.3  Abonnements (06.03) — liste des vendeurs suivis, feed nouvelles annonces
7.4  Reviews & reputation (06.04) — notes étoiles + commentaires, compteur strikes (max 3)

→ STOP.

JALON 8 — Système, légal & monétisation (zone 07)
8.1  Paramètres (07.01) — compte, adresses, paiement, notifications, langue, mode sombre, gestion Minty+, suppression compte
8.2  Aide / Centre (07.02) — FAQ par catégorie
8.3  Litige & SAV (07.03) — form de litige, upload photos mocké, timeline statut
8.4  Page Confiance (07.04) — page éditoriale, 4 niveaux d'auth illustrés, escrow Stripe expliqué. Doit être impressionnante : c'est ton différenciant.
8.5  CGU · RGPD (07.05) — page texte standard
8.6  Pricing & Minty+ (07.06) — page corail, transparence revenus : tableau comparatif vs eBay/Vinted/Whatnot, détail commission 5%, boosts, crédits troc, abo Minty+ 4,99 €/mois. CTA "Passer à Minty+"

→ STOP. Récapitulatif final + checklist des 34 écrans + démo guidée.

JALON 9 — Polish
9.1  Transitions framer-motion entre les écrans (fade + slide subtil)
9.2  Skeleton loaders sur les listes (mock setTimeout 600ms à l'init)
9.3  Toasts pour les actions (offre envoyée, troc proposé, boost activé)
9.4  Mode démo : un bouton flottant discret en dev permet de switcher de user (acheteur / vendeur power-seller / utilisateur Minty+)
9.5  README.md avec instructions de lancement + parcours de démo recommandés

CONTRAINTES TECHNIQUES STRICTES

- Mobile-first. Tout doit être utilisable et beau à 390px. Les vues desktop sont secondaires.
- Pas de localStorage / sessionStorage : tout en mémoire React Context.
- Pas de backend, pas d'API call réel. Stripe = mocké visuellement.
- Pas de generated stock photo. Pour les visuels de cartes Pokémon, utilise les URLs publiques de l'API pokemontcg.io. Pour les avatars, pravatar.cc. Pour les illustrations onboarding, dessine en SVG inline.
- Pas de gradient sauf l'effet holo foil (réservé aux badges rareté et aux cartes Holo/Ultra).
- Coins arrondis : 12-16px sur tous les modules UI, 8-10px sur les inputs.
- Icônes : lucide-react, stroke 1.5.
- Aucune dépendance UI lourde (pas de shadcn pour le MVP, on garde light) — primitives custom.

CONTRAINTES DE LIVRABLE

- À chaque jalon, fais un git commit avec un message descriptif.
- Si tu hésites entre deux options de design, propose-moi les deux en screenshots et je tranche.
- Si tu vois une incohérence dans le sitemap ou le brief, signale-la avant d'improviser.
- Toujours respecter MINTY_BRIEF.md en priorité sur tes intuitions.

Commence par confirmer que tu as compris, puis demande-moi de te fournir MINTY_BRIEF.md, puis attaque JALON 1.

===
```

---

## PARTIE B · Contenu de `MINTY_BRIEF.md`

Crée un fichier `MINTY_BRIEF.md` à la racine de ton repo avec le contenu suivant. Claude Code le lira en référence à chaque tour.

```markdown
# MINTY · Brief produit & design

> Version 0.1 · Mai 2026 · Référence pour Claude Code

## 1. Le projet en 30 secondes

Marketplace française mobile-first de cartes à collectionner Pokémon (extension Magic, Yu-Gi-Oh, One Piece, Lorcana en phase 2). Différenciation : la marketplace française la plus sécurisée. Chaque carte est vérifiée par IA puis par un expert humain. Chaque paiement est séquestré jusqu'à réception confirmée.

**Tagline :** Drop culture meets trust.
**Promesse :** Sérieux comme une banque, désirable comme un sneaker drop.
**Trois mots :** Sell · Buy · Trade.

## 2. Cibles

- **Collectionneurs confirmés (25-40 ans)** — génération Pokémon 1999, nostalgiques, transigent en confiance.
- **Débutants (16-25 ans)** — veulent oser se lancer sans peur de l'arnaque.
- **Peur commune n°1 :** se faire arnaquer. Le système de confiance à 4 niveaux résout les deux cibles avec un seul mécanisme.

## 3. Système de confiance à 4 niveaux

1. IA vérifie chaque carte mise en vente (photo standardisée face/dos/tranche).
2. Si doute IA → escalade à un expert humain.
3. Si doute expert → annonce publiée avec badge transparent "Authenticité non garantie".
4. Si fake confirmé → suppression + signalement vendeur (3 strikes = bannissement).

Couplé à un paiement séquestré Stripe Connect (argent libéré seulement à réception confirmée).

## 4. Identité visuelle

### Couleurs (CSS variables exactes)

```css
--ink:        #0F1410;   /* Noir profond — type, UI base */
--ink-soft:   #1a221d;
--mint:       #5EE2A0;   /* Vert menthe — signature, CTA, dot */
--mint-deep:  #2ec77f;   /* Variante CTA hover, point signature */
--cream:      #F2EFE7;   /* Surface principale, fond pages */
--paper:      #FAF8F2;   /* Surface secondaire, cartes */
--gold:       #D4AF37;   /* Grade 10 / Rare */
--silver:     #B8B8B8;   /* Grade 9 / Near Mint */
--bronze:     #CD7F32;   /* Grade 8 / Excellent */
--holo-red:   #FF3B5C;   /* Alert / Fake / Litige */
--trust-blue: #2D6CDF;   /* Verified IA + Humans */
--coral:      #D85A30;   /* Monétisation (boosts, crédits, pricing) */
```

### Typographie

- **Space Grotesk** (Google Fonts) — poids 400 / 500 / 700
  - 400 : body
  - 500 : UI, boutons, libellés, navigation
  - 700 : display, titres, hero
- **JetBrains Mono** — 400 / 500
  - Labels (uppercase, letter-spacing 0.22em), prix tabulaires, codes, metadata
- Letter-spacing display : `-0.02em` à `-0.045em` selon taille
- Toujours **sentence case** sauf pour les labels mono qui sont UPPERCASE

### Ton

- Phrases courtes. Termine par un point.
- Voix française neutre, sobre, précise.
- Mots-clés : Authentifié. Mint condition. Sealed payment. Trade safely. Verified by humans. Backed by IA.

### Do

- Surfaces mates, papier crème, encre noire profonde.
- Détails iridescents très ciblés (foil holo uniquement pour signaler la rareté Holo/Ultra/Secret).
- Aucun dégradé sauf foil holographique.
- Ombres douces, longues, basses opacités.
- Coins arrondis 12-16px sur tous les modules UI.
- Icônes line, stroke 1.5px, caps ronds.
- Le point vert menthe comme signature (badge, puce, séparateur).

### Don't

- Esthétique geek/otaku années 2000.
- Couleurs criardes saturées partout, pas de vert kaki agressif.
- Mascottes officielles, fan-art, illustrations enfantines.
- Effets 3D bling, néons gaming, glassmorphism daté.
- Stock photos de mains tenant des billets.
- Templates startup générique, gradient violet/bleu SaaS.

## 5. Le sitemap — 34 écrans validés

### 01 · Onboarding & entrée
- 01.01 Splash — logo centré, point vert animé, transition 1.2s
- 01.02 Onboarding — 3 slides : IA+humains, escrow, Sell/Buy/Trade
- 01.03 Sign up / Login — email + Apple + Google
- 01.04 KYC light — tel + adresse + Stripe Connect Express (skippable si acheteur seul)
- 01.05 Permissions — notif + photo + contacts (tout skippable)

### 02 · Home & navigation
- 02.01 Home — Drops, Trending 7j, Pour toi (max 20% boostées visibles)
- 02.02 Recherche — catalogue 18k cartes, filtres, max 3 boosts "Sponsorisés" en encart isolé
- 02.03 Catalogue / Sets — browse par série/génération
- 02.04 Messages — inbox transactionnelle avec miniatures cartes
- 02.05 Notifications — chronologique

### 03 · Acheteur · browse → checkout
- 03.01 Fiche carte — visuel, photos vendeur, badge IA, label "Featured · Minty" discret si boostée
- 03.02 Historique prix — 30/90/365j, recharts
- 03.03 Faire une offre — sheet, 48h
- 03.04 Panier — multi-vendeurs, take rate 5% visible
- 03.05 Checkout — Stripe + escrow (€ source de revenu 1)
- 03.06 Suivi commande — timeline 5 étapes
- 03.07 Réception & confirmation — Oui débloque escrow + review / Non → litige

### 04 · Vendeur · list → ship → payout
- 04.01 Vendre · choisir carte — depuis catalogue (1-clic, 30s)
- 04.02 Photos guidées — Face/Dos/Tranche overlay
- 04.03 État & prix suggéré — slider Mint/NM/EX/LP/DMG
- 04.04 IA pré-vérif — Verified / Pending / Unguaranteed, suggestion Boost
- 04.05 Dashboard vendeur — annonces, ventes, stats, Boosts
- 04.06 Expédition — étiquette Mondial Relay/Colissimo
- 04.07 Wallet & payout — solde, breakdown -5% + boosts
- 04.08 Boost annonce (€ source de revenu 2) — 1,99 / 4,99 / 9,99 €

### 05 · Troc · 1 gratuit/mois puis payant
- 05.01 Wishlist & vitrine troc — Je cherche / Je donne
- 05.02 Proposer un troc — builder n vs n + valorisation
- 05.03 Chat négociation — thread + historique versions
- 05.04 Sceller le troc — quota 1/mois affiché, escrow double envoi, max 3 trocs actifs simultanés
- 05.05 Crédit troc paywall (€ source de revenu 3) — 2,99 € / 9,99 € pack 5 / Minty+ 4,99 €/mois

### 06 · Profil collectionneur & social
- 06.01 Profil public — avatar, bio, badges, vitrine, note, Suivre/Message
- 06.02 Ma collection — privée, valorisation totale 30j
- 06.03 Abonnements — vendeurs suivis
- 06.04 Reviews & reputation — étoiles, strikes (3 = ban)

### 07 · Système, légal & monétisation
- 07.01 Paramètres — compte, paiement, Minty+, RGPD
- 07.02 Aide — FAQ par catégorie
- 07.03 Litige & SAV — médiation, SLA 72h, escrow bloqué
- 07.04 Page Confiance — 4 niveaux d'auth + escrow (différenciant clé)
- 07.05 CGU · RGPD
- 07.06 Pricing & Minty+ (€ source de revenu 4) — transparence, abo 4,99 €/mois

## 6. Monétisation — règles métier

### Commission 5% (vs eBay 12%, Vinted 10%, Whatnot 8%)
- Prélevée au moment du capture Stripe.
- Encaissée par Minty à la livraison confirmée (déblocage escrow).
- Visible en clair dans le panier et au checkout.

### Boosts (annonce mise en avant)

| Boost | Tarif | Effet | Zone d'affichage |
|---|---|---|---|
| Spotlight 24h | 1,99 € | Tête des recherches sur la carte ciblée pendant 24h | Search |
| Top 7 jours | 4,99 € | Top 3 des résultats set/rareté pendant 7j | Search |
| Home Featured 48h | 9,99 € | Carrousel home + push aux abonnés | Home |

- Label discret "Featured · Minty" sur les annonces boostées (pas de gros badge).
- Max 20% de cartes boostées visibles à l'écran.
- Tous les boosts inclus avec abo Minty+.

### Troc — quota & paywall
- 1 troc gratuit par mois par utilisateur (le scellement consomme le quota, la proposition non).
- Max 3 trocs actifs simultanés (pour éviter le bypass).
- Si quota épuisé OU 3 trocs actifs → paywall 05.05.
- Options paywall : +1 troc 2,99 € · Pack 5 trocs 9,99 € (valide 90j) · Minty+ 4,99 €/mois (illimité).

### Minty+ (abo récurrent 4,99 €/mois)
- Trocs illimités
- Tous les boosts inclus
- Badge premium sur profil
- Early access aux drops (futur)

## 7. Données mock à générer

### Cartes (60 minimum)
Set Base : Charizard (base1-4), Blastoise, Venusaur, Pikachu, Mewtwo, Alakazam, Gyarados, Dragonite, Machamp, Magneton, Nidoking, Ninetales, Poliwrath, Raichu, Zapdos, Beedrill, Clefairy, Hitmonchan, Chansey.
Set Jungle : Scyther, Vaporeon, Jolteon, Flareon, Pidgeot, Snorlax, Wigglytuff.
Set Fossil : Aerodactyl, Lapras, Articuno, Moltres, Zapdos, Dragonite.
Set Team Rocket : Dark Charizard, Dark Blastoise, Rocket's Mewtwo.
Set Neo Genesis : Lugia, Typhlosion, Meganium, Feraligatr.
Modernes : Charizard VMAX, Pikachu VMAX, Mew V, etc.

Pour chaque carte :
- imageUrl via https://images.pokemontcg.io/{setCode}/{number}.png (high-res) ou /low.png
- marketPrice30d entre 5€ et 2500€ selon rareté
- priceHistory : 30 points avec tendance réaliste (sinus + bruit)
- salesCount30d entre 3 et 200

### Users (12)
Avatar via https://i.pravatar.cc/150?u={username}.
1 user power-seller (200+ ventes, rating 4.9), 1 user Minty+, 1 user débutant (0 ventes), le reste varié.

### Listings (40)
Mix Verified (80%) / Pending (15%) / Unguaranteed (5%).
8 listings boostés répartis sur les 3 types de boost.

### Orders, Trades, Notifications, Reviews
Voir le brief de jalons.

## 8. Parcours de démo recommandés (pour le pitch)

1. **Le doute du débutant** : Home → fiche Charizard PSA 10 → onglet "Authenticité" → Page Confiance → retour → Acheter → checkout avec escrow visible
2. **Le power-seller** : Sell → choisir carte → photos → état → IA Verified → suggestion Boost → choisir Home Featured 48h → confirmation → Dashboard avec stats
3. **Le troqueur** : Trade → Proposer → builder de troc → Sceller → "Trocs ce mois : 1/1 utilisé" → tente un 2e → Paywall → Minty+
4. **La transparence** : Pricing → tableau comparatif vs eBay/Vinted/Whatnot
```

---

## Comment l'utiliser concrètement

1. **Installe Claude Code** si pas déjà fait (https://docs.claude.com/claude-code).
2. **Crée un dossier vide** `minty-mvp/` et ouvre-le dans Claude Code.
3. **Lance la Partie A** comme premier message.
4. Claude Code va te demander le brief — réponds en lui collant le contenu de la **Partie B** dans un fichier `MINTY_BRIEF.md` à la racine.
5. **Suis les jalons un par un**. À chaque "STOP", regarde, teste sur ton mobile (Claude Code expose un dev server), valide ou corrige avant de passer au jalon suivant.
6. **Garde MINTY_BRIEF.md vivant** : si tu changes d'avis sur un tarif, une couleur, une mécanique, modifie le brief, et au tour suivant Claude Code l'utilisera comme nouvelle référence.

## Temps estimé par jalon

- Jalon 1 (setup + tokens) : 1 jour
- Jalon 2 (mock data) : 1 jour
- Jalon 3 (onboarding + home) : 2 jours
- Jalon 4 (acheteur) : 2 jours
- Jalon 5 (vendeur + boost) : 2-3 jours
- Jalon 6 (troc + paywall) : 1-2 jours
- Jalon 7 (profil) : 1 jour
- Jalon 8 (système + pricing) : 1-2 jours
- Jalon 9 (polish) : 1-2 jours

**Total réaliste : 12 à 16 jours de travail en solo avec Claude Code**, en respectant les pauses entre jalons. Si tu fonces sans valider, tu peux compresser à 7-8 jours mais tu vas accumuler des incohérences difficiles à rattraper.

## Sur ta question "Claude design"

Une nuance : Claude Code **peut** faire le design directement. Tu n'as pas besoin de passer par un Claude séparé pour le design. La Partie B (brief) lui donne tous les tokens visuels Minty, et le prompt impose des contraintes esthétiques claires.

Si tu veux quand même séparer les deux rôles (Code et Design), une option est : utiliser Claude.ai en parallèle de Claude Code pour générer des composants React isolés en artifacts, les tester visuellement, puis les copier dans le repo. Mais pour un MVP cliquable, ça crée plus de friction qu'autre chose. Je te recommande de tout faire dans Claude Code avec ce prompt.
