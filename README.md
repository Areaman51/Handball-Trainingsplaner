# 🤾 Handball Trainingsmanager

> Browserbasiertes Coaching-Tool für Handball-Trainer nach DHB-Standard. Entwickelt als vollständiger Ersatz für kommerzielle Software wie XPS Sideline – kostenlos, ohne Installation, läuft direkt im Browser.

---

## ✨ Features

### 📋 Trainingsplaner
- Trainingseinheiten anlegen, bearbeiten, löschen und teilen
- Session-Header mit Name, Datum, Uhrzeit, Gruppe, Ort und Schwerpunkt
- Übungen strukturiert nach DHB-Phasen und Kategorien
- Drag & Drop Sortierung der Übungen
- **Parallele Stränge** – Einheit aufteilen (z. B. Gruppe A / Gruppe B), parallel planen und wieder zusammenführen
- **Tagesnotizen** pro Übung (werden mit der Einheit gespeichert, nicht dauerhaft in der Übungsdatenbank)
- **Trainernotizen** sichtbar im Session-Header
- Automatische Gesamtdauerkalkulation (parallele Stränge werden korrekt als Maximum gerechnet)
- Druckansicht optimiert für A4

### 📅 Kalender
- Monatsübersicht aller Trainingseinheiten
- Klick auf Tag → neue Einheit mit vorausgewähltem Datum
- Klick auf Einheit → lädt diese direkt in den Planer

### 🗂 Übungsdatenbank
- Private Übungsdatenbank pro Nutzer
- Strukturiert nach DHB-Phasen und Kategorien (Aufwärmen / Hauptteil / Ausklang)
- Volltextsuche und Phasenfilter
- 28 DHB-Standardübungen per Knopfdruck ladbar (Duplikat-Schutz)
- Detail-Ansicht mit Bildern, YouTube-Einbettung, Aufbau, Ablauf, Variationen, Schwerpunkt

### 🌐 Geteilte Datenbank
- Übungen zwischen Trainern teilen und freigeben
- Freigabe-Workflow über Admin-Panel
- Geteilte Übungen direkt in eigene Einheiten übernehmen

### 🔗 Einheiten teilen
- Trainingseinheiten gezielt mit einzelnen Nutzern teilen
- Zwei Modi: **Nur Ansicht** oder **Bearbeiten erlaubt**
- Freigaben jederzeit anpassbar oder entziehbar

### ⚙️ Administration
- Nutzerverwaltung (Rollen: admin, manager, trainer)
- Nutzer aktivieren/deaktivieren
- Freigaben für geteilte Übungen genehmigen/ablehnen
- Kategorieverwaltung

### 📱 Mobile-Support
- Vollständig responsive (optimiert für iPhone & Android)
- Bottom-Navigation auf Mobilgeräten
- Modals als Bottom Sheet
- Safe-area-inset für Notch-Geräte

---

## 🛠 Tech Stack

| Bereich | Technologie |
|---|---|
| Frontend | Vanilla HTML, CSS, JavaScript (Single File) |
| Backend | [Supabase](https://supabase.com) (Auth, PostgreSQL, Storage, RLS) |
| Fonts | DM Sans + DM Mono via Google Fonts |
| Hosting | GitHub Pages |
| Auth | Supabase Auth (E-Mail + Passwort) |

---

## 🚀 Setup

### 1. Supabase-Projekt anlegen

Erstelle ein neues Projekt auf [supabase.com](https://supabase.com).

### 2. Datenbank-Schema einrichten

Führe folgendes SQL im Supabase SQL Editor aus:

```sql
-- Profile
CREATE TABLE public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name text,
  email text,
  verein text,
  mannschaft text,
  role text DEFAULT 'trainer',
  aktiv boolean DEFAULT true,
  eingeladen_von uuid REFERENCES auth.users(id),
  created_at timestamptz DEFAULT now()
);

-- Trainingseinheiten
CREATE TABLE public.einheiten (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name text DEFAULT 'Trainingseinheit',
  group_name text,
  date date,
  time text,
  ort text,
  focus text,
  notes text,
  drills text,
  updated_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

-- Einheit-Freigaben (nutzer-spezifisch)
CREATE TABLE public.einheit_freigaben (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  einheit_id uuid NOT NULL REFERENCES public.einheiten(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  owner_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  mode text NOT NULL DEFAULT 'view' CHECK (mode IN ('view','edit')),
  created_at timestamptz DEFAULT now(),
  UNIQUE(einheit_id, user_id)
);

-- Übungsdatenbank (privat)
CREATE TABLE public.uebungen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  phase text,
  cat text,
  name text,
  duration text,
  players text,
  aufbau text,
  ablauf text,
  variationen text,
  augenmerk text,
  youtube text,
  bilder text[],
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Geteilte Übungen
CREATE TABLE public.geteilte_uebungen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  original_id uuid REFERENCES public.uebungen(id),
  vorgeschlagen_von uuid REFERENCES auth.users(id),
  freigegeben_von uuid REFERENCES auth.users(id),
  status text DEFAULT 'ausstehend',
  created_at timestamptz DEFAULT now()
);

-- Kategorien
CREATE TABLE public.kategorien (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  phase text,
  key text,
  label text,
  color text,
  erstellt_von uuid REFERENCES auth.users(id),
  created_at timestamptz DEFAULT now()
);

-- Freigabe-Log
CREATE TABLE public.freigabe_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  uebung_id uuid REFERENCES public.geteilte_uebungen(id),
  aktion text,
  von_user uuid REFERENCES auth.users(id),
  created_at timestamptz DEFAULT now()
);

-- Einladungen
CREATE TABLE public.einladungen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text,
  role text,
  eingeladen_von uuid REFERENCES auth.users(id),
  token text,
  verwendet boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);
```

### 3. RLS & Policies aktivieren

RLS für alle Tabellen aktivieren und Policies gemäß dem Projekt einrichten (siehe `STATUS.md`).

### 4. Supabase-Zugangsdaten eintragen

In der HTML-Datei die folgenden Zeilen mit deinen Projektdaten ersetzen:

```js
const SUPABASE_URL = 'https://DEIN-PROJEKT.supabase.co';
const SUPABASE_ANON_KEY = 'DEIN-ANON-KEY';
```

### 5. Auf GitHub Pages deployen

1. Repository erstellen
2. `handball_trainer_v4_12.html` als `index.html` hochladen
3. **Settings → Pages → Deploy from branch → main → / (root) → Save**
4. Nach 1–2 Minuten erreichbar unter `https://USERNAME.github.io/REPO/`

---

## 📁 Projektstruktur

```
handball-trainer/
├── index.html                  ← Hauptanwendung (Trainingsplaner)
├── handball-taktikboard.html   ← Separates Taktikboard (standalone)
├── README.md
└── STATUS.md                   ← Interner Entwicklungsstand
```

---

## 🔐 Sicherheit

- Row Level Security (RLS) auf allen Tabellen
- Nutzer sehen ausschließlich eigene Daten
- Admin-Operationen nur mit Rolle `admin`
- Auth via Supabase (bcrypt-Passwort-Hashing, Leaked-Password-Schutz aktiv)

---

## 🗺 Roadmap

- [ ] Taktikboard in Trainingseinheiten einbetten
- [ ] Anwesenheitsliste (Tab vorhanden, Logik folgt)
- [ ] Taktikdatenbank (Spielzüge, Abwehrsysteme)
- [ ] Bilder via Supabase Storage
- [ ] Dynamische Kategorieverwaltung im Admin-Panel

---

## 📌 Terminologie

Das Tool folgt dem DHB-Standard:

| Symbol | Bedeutung |
|---|---|
| ▲ | Angriffspositionen |
| ● | Abwehrpositionen inkl. Torhüter |

---

## 📄 Lizenz

Dieses Projekt ist für den privaten und vereinsinternen Gebrauch entwickelt.
