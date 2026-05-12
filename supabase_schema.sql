-- =====================================================================
-- MINTY · Schéma Supabase complet (iter. 3a)
-- =====================================================================
-- À exécuter dans Supabase Dashboard → SQL Editor → New Query → Run
-- Idempotent : peut être re-lancé sans casser (drop + recreate)
-- =====================================================================

-- 1. Nettoyage (au cas où on relance)
drop table if exists trades cascade;
drop table if exists orders cascade;
drop table if exists listings cascade;
drop table if exists cards cascade;
drop table if exists profiles cascade;

-- =====================================================================
-- 2. Tables
-- =====================================================================

-- Catalogue des cartes Pokémon (immuable, pré-rempli)
create table cards (
  id text primary key,
  name text not null,
  set_name text not null,
  number text not null,
  image text not null,
  rarity text not null,
  market_price numeric not null,
  created_at timestamptz default now()
);

-- Profils utilisateurs (séparé de auth.users — on ajoutera la liaison à l'iter. 3c)
create table profiles (
  id text primary key,
  username text not null unique,
  avatar text not null,
  rating numeric default 0,
  sales integer default 0,
  is_power boolean default false,
  is_minty_plus boolean default false,
  created_at timestamptz default now()
);

-- Annonces de vente
create table listings (
  id text primary key,
  card_id text not null references cards(id) on delete cascade,
  seller_id text not null references profiles(id) on delete cascade,
  price numeric not null check (price > 0),
  condition text not null check (condition in ('Mint','NM','EX','LP','DMG')),
  auth_status text not null check (auth_status in ('verified','pending','unguaranteed')),
  boost text check (boost in ('spotlight','featured','top7')),
  shipping numeric default 3.5,
  created_at timestamptz default now()
);

-- Commandes (panier → paiement → escrow → livré)
create table orders (
  id uuid primary key default gen_random_uuid(),
  listing_id text not null references listings(id) on delete cascade,
  buyer_id text not null references profiles(id) on delete cascade,
  status text default 'pending' check (status in ('pending','paid','shipped','delivered','disputed','refunded')),
  total numeric not null,
  created_at timestamptz default now()
);

-- Trocs carte-contre-carte
create table trades (
  id uuid primary key default gen_random_uuid(),
  proposer_id text not null references profiles(id) on delete cascade,
  target_id text not null references profiles(id) on delete cascade,
  my_cards text[] not null,
  their_cards text[] not null,
  status text default 'pending' check (status in ('pending','accepted','declined','sealed','completed')),
  created_at timestamptz default now()
);

-- =====================================================================
-- 3. Row Level Security (RLS) — autorise la lecture publique via publishable key
-- =====================================================================

alter table cards    enable row level security;
alter table profiles enable row level security;
alter table listings enable row level security;
alter table orders   enable row level security;
alter table trades   enable row level security;

-- Catalogue + profils + annonces : lecture publique
create policy "public read cards"    on cards    for select using (true);
create policy "public read profiles" on profiles for select using (true);
create policy "public read listings" on listings for select using (true);

-- Orders et trades : on les rendra restrictifs en iter. 3c (avec auth)
-- Pour l'instant lecture publique aussi pour tester
create policy "public read orders" on orders for select using (true);
create policy "public read trades" on trades for select using (true);

-- =====================================================================
-- 4. Seed data
-- =====================================================================

-- 4.1 · 16 cartes Pokémon
insert into cards (id, name, set_name, number, image, rarity, market_price) values
  ('c1',  'Dracaufeu',  'Set de Base', '4/102',  'https://images.pokemontcg.io/base1/4_hires.png',  'Holo Rare',   850),
  ('c2',  'Tortank',    'Set de Base', '2/102',  'https://images.pokemontcg.io/base1/2_hires.png',  'Holo Rare',   320),
  ('c3',  'Florizarre', 'Set de Base', '15/102', 'https://images.pokemontcg.io/base1/15_hires.png', 'Holo Rare',   280),
  ('c4',  'Mewtwo',     'Set de Base', '10/102', 'https://images.pokemontcg.io/base1/10_hires.png', 'Holo Rare',   195),
  ('c5',  'Alakazam',   'Set de Base', '1/102',  'https://images.pokemontcg.io/base1/1_hires.png',  'Holo Rare',   90),
  ('c6',  'Pikachu',    'Set de Base', '58/102', 'https://images.pokemontcg.io/base1/58_hires.png', 'Commune',     18),
  ('c7',  'Léviator',   'Set de Base', '6/102',  'https://images.pokemontcg.io/base1/6_hires.png',  'Holo Rare',   220),
  ('c8',  'Lugia',      'Neo Genesis', '9/111',  'https://images.pokemontcg.io/neo1/9_hires.png',   'Holo Rare',   450),
  ('c9',  'Mew',        'Promo',       '8/8',    'https://images.pokemontcg.io/basep/8_hires.png',  'Promo',       140),
  ('c10', 'Insécateur', 'Jungle',      '10/64',  'https://images.pokemontcg.io/base2/10_hires.png', 'Holo Rare',   65),
  ('c11', 'Ronflex',    'Jungle',      '11/64',  'https://images.pokemontcg.io/base2/11_hires.png', 'Holo Rare',   55),
  ('c12', 'Dracolosse', 'Fossile',     '4/62',   'https://images.pokemontcg.io/base3/4_hires.png',  'Holo Rare',   140),
  ('c13', 'Magmar',     'Fossile',     '39/62',  'https://images.pokemontcg.io/base3/39_hires.png', 'Peu commune', 8),
  ('c14', 'Électhor',   'Fossile',     '15/62',  'https://images.pokemontcg.io/base3/15_hires.png', 'Holo Rare',   95),
  ('c15', 'Artikodin',  'Fossile',     '2/62',   'https://images.pokemontcg.io/base3/2_hires.png',  'Holo Rare',   110),
  ('c16', 'Sulfura',    'Fossile',     '12/62',  'https://images.pokemontcg.io/base3/12_hires.png', 'Holo Rare',   130);

-- 4.2 · 6 profils (5 vendeurs + Kilian débutant)
insert into profiles (id, username, avatar, rating, sales, is_power, is_minty_plus) values
  ('u1', 'MaxCollect',   'https://i.pravatar.cc/150?u=max',    4.9, 247, true,  false),
  ('u2', 'LeoCards',     'https://i.pravatar.cc/150?u=leo',    4.7, 38,  false, true),
  ('u3', 'Cécile_TCG',   'https://i.pravatar.cc/150?u=cecile', 4.8, 89,  false, false),
  ('u4', 'PokéParis',    'https://i.pravatar.cc/150?u=paris',  4.6, 22,  false, false),
  ('u5', 'Yann_Vintage', 'https://i.pravatar.cc/150?u=yann',   5.0, 156, true,  false),
  ('kilian', 'Kilian_TCG', 'https://i.pravatar.cc/150?u=kilian', 0, 0,    false, false);

-- 4.3 · 15 annonces de seed
insert into listings (id, card_id, seller_id, price, condition, auth_status, boost, shipping) values
  ('l1',  'c1',  'u1', 820, 'NM',   'verified',     'featured',  4.5),
  ('l2',  'c2',  'u3', 310, 'EX',   'verified',     null,        4.5),
  ('l3',  'c4',  'u5', 190, 'NM',   'verified',     'spotlight', 3.5),
  ('l4',  'c8',  'u1', 440, 'Mint', 'verified',     null,        6.5),
  ('l5',  'c5',  'u2', 85,  'NM',   'verified',     null,        3.5),
  ('l6',  'c6',  'u4', 22,  'EX',   'pending',      null,        3.5),
  ('l7',  'c7',  'u3', 210, 'NM',   'verified',     null,        4.5),
  ('l8',  'c12', 'u5', 135, 'EX',   'verified',     null,        4.5),
  ('l9',  'c3',  'u1', 270, 'NM',   'verified',     null,        4.5),
  ('l10', 'c9',  'u2', 145, 'NM',   'unguaranteed', null,        3.5),
  ('l11', 'c10', 'u4', 60,  'LP',   'verified',     null,        3.5),
  ('l12', 'c11', 'u3', 52,  'EX',   'verified',     null,        3.5),
  ('l13', 'c14', 'u5', 88,  'NM',   'verified',     null,        3.5),
  ('l14', 'c15', 'u1', 105, 'NM',   'verified',     null,        3.5),
  ('l15', 'c16', 'u3', 125, 'EX',   'verified',     null,        3.5);

-- =====================================================================
-- 5. Vérification (commentaires informatifs)
-- =====================================================================
-- select count(*) from cards;     -- doit retourner 16
-- select count(*) from profiles;  -- doit retourner 6
-- select count(*) from listings;  -- doit retourner 15
