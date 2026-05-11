# bootcamp-kilian

Projet du bootcamp **Ops & Product · Delta Business School** de Kilian Vincens.

## Stack actuelle

- **Frontend** : HTML/CSS/JS vanilla (pas de framework), un seul fichier `index.html`
- **Backend** : Supabase (projet `psmdivtvaewlouobxyxn`)
- **Hosting** : GitHub Pages, branche `main`, source `/ (root)`
- **Auth git** : `gh` CLI (OAuth navigateur, pas de PAT)

## URLs clés

- Public : https://kilianvincens-alt.github.io/bootcamp-kilian/
- Repo : https://github.com/kilianvincens-alt/bootcamp-kilian
- Supabase dashboard : https://supabase.com/dashboard/project/psmdivtvaewlouobxyxn

## Notes Supabase

- URL projet : `https://psmdivtvaewlouobxyxn.supabase.co`
- Clé côté navigateur : **`Publishable key`** (format `sb_publishable_...`) — nouveau système
- ⚠️ Les legacy keys (`anon` JWT `eyJ...`) sont désactivées par défaut sur ce projet — toujours utiliser la publishable key
- ⚠️ Ne jamais utiliser `sb_secret_...` côté frontend
- Smoke test : `fetch('/auth/v1/settings')` avec header `apikey` (l'endpoint `/rest/v1/` racine répond 401 même authentifié)

## Workflow standard

```bash
cd ~/Desktop/bootcamp-kilian
# … modifier index.html ou autre …
git add .
git commit -m "message clair"
git push origin main
# Live sur https://kilianvincens-alt.github.io/bootcamp-kilian/ en 1-2 min
```

## État au 2026-05-11

- Repo cloné, GitHub Pages activé
- Page HTML : titre violet `#C8A2D9` sur fond noir, sous-titre, signature
- Panneau "Stack status" qui ping Supabase au chargement
- **Prochaine étape (J1 bootcamp)** : créer une vraie table Supabase (ex: `messages`), configurer Row Level Security, faire un read/write depuis la page
