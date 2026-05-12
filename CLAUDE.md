# Minty — projet bootcamp de Kilian

> Marketplace française mobile-first de cartes à collectionner Pokémon. Différenciation : la marketplace française la plus sécurisée (IA + expert humain + paiement séquestré). Take rate 5 %.

## Référence projet

Lire **`MINTY_BRIEF.md`** en début de chaque session avant de coder : il contient le positionnement, l'identité visuelle (couleurs, typo, ton), le sitemap, la monétisation et les contraintes.

## Stack imposée par le bootcamp Delta

- **Frontend** : HTML / CSS / JS vanilla, **un seul fichier `index.html`**
- **Bibliothèques** : via CDN uniquement (pas de `npm install`, pas de build)
- **Pas de framework** (pas de React / Vue / Next / Svelte)
- **Backend** : Supabase (projet `psmdivtvaewlouobxyxn`) — auth + BDD
- **Hosting** : GitHub Pages, branche `main`, `/ (root)`, déploiement auto au push
- **Auth git** : `gh` CLI (OAuth navigateur)

Stack effective : Tailwind CDN + Lucide CDN + Chart.js CDN + Supabase JS CDN + Google Fonts (Space Grotesk + JetBrains Mono).

## URLs

- Public : https://kilianvincens-alt.github.io/bootcamp-kilian/
- Repo : https://github.com/kilianvincens-alt/bootcamp-kilian
- Supabase dashboard : https://supabase.com/dashboard/project/psmdivtvaewlouobxyxn

## Notes Supabase

- URL projet : `https://psmdivtvaewlouobxyxn.supabase.co`
- Clé côté navigateur : **`Publishable key`** (format `sb_publishable_...`)
- Clé actuelle : `sb_publishable_eJB9sQpnfDr_N-n6Pl424g_75MLG_0U`
- ⚠️ Les legacy keys (`anon` JWT `eyJ...`) sont **désactivées** sur ce projet → toujours utiliser la publishable key
- ⚠️ Ne jamais utiliser `sb_secret_...` côté frontend
- Smoke test connexion : `fetch('/auth/v1/settings')` avec header `apikey` (l'endpoint `/rest/v1/` racine répond 401 même authentifié)

## Workflow standard

```bash
cd ~/Desktop/bootcamp-kilian
# … modifier index.html ou autre …
git add .
git commit -m "message clair"
git push origin main
# Live sur https://kilianvincens-alt.github.io/bootcamp-kilian/ en 1-2 min
```

## État d'avancement

### J1 (2026-05-11) — Cadrage & Setup ✅
- Stack 7/7 checkpoints validés (GitHub Pages, Supabase, Node, Claude Code, repo cloné, push, connexion JS↔Supabase)
- Copycat verrouillé : **Vinted appliqué aux cartes à collectionner, Pokémon-first**
- Différenciation : **la marketplace française la plus sécurisée** (IA + expert + escrow)
- Nom : **Minty**
- Cibles : collectionneurs confirmés (25-40) + débutants (16-25) — peur commune = arnaque
- Take rate : 5 % (vs eBay 12 %, Vinted 10 %, Whatnot 8 %)

### J2 (2026-05-12) — Modélisation financière (en cours)
- Marché secondaire C2C France : ~50-65 M€/an · Pokémon = ~28 M€/an
- Marché Europe : ~800 M€/an
- Projections : 1 % part FR = 25k€/an · 5 % = 125k€/an · 10 % = ~300k€/an · 5 % Europe = ~2M€/an
- Sources triangulées : The Pokémon Company, Cardmarket GMV, Asmodee
- **Build du MVP commencé en avance** (iter. 1 = foundation + Home + Card Detail + Trust + Cart + Checkout)

### J3 (2026-05-19) — Build prototype (à venir)
- Spec MVP finalisé
- Schéma BDD Supabase
- Itération sur le MVP

## Conventions de communication avec Kilian

- Expliquer en **français simple**, niveau débutant complet
- Étapes une par une, attendre confirmation
- Exécuter les commandes shell soi-même quand c'est possible
- Pour actions interactives (auth OAuth, etc.) → Terminal Mac ou préfixe `!`
- En cas d'erreur : traduire en français simple + proposer le fix
- Confirmer visuellement à chaque étape (ouvrir la page, comparer)
- Pas de framework, pas de complexité gratuite — KISS

## Conventions de code

- Tout dans `index.html` à la racine (HTML + CSS inline + JS inline)
- CSS variables des tokens Minty (cf. `MINTY_BRIEF.md` section 4)
- Tailwind config inline avec les tokens Minty
- Pas d'animation complexe sauf foil holo + fade-in d'écran
- Mobile-first strict, fonctionne à 390px
- Routing par hash (#/home, #/card/:id, #/trust, #/cart, #/checkout)
- Seed data en mémoire JS pour l'instant (migration Supabase en iter. 3)

## Prochaines itérations

- **Iter. 2** : Sell flow complet (catalogue → photos → état → IA simulée → publié) + Trade flow + Profil
- **Iter. 3** : Migration des seed data vers Supabase + auth signup/login + BDD réelle
- **Iter. 4** : Polish (transitions, skeleton loaders, toasts) + parcours de démo verrouillé pour soutenance J5
