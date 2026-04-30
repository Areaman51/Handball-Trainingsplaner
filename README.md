# 🤾 Handball Trainingsmanager

> Browserbasiertes Coaching-Tool für Handball-Trainer nach DHB-Standard.
> Entwickelt als vollständiger Ersatz für kommerzielle Software wie XPS Sideline –
> kostenlos, ohne Installation, läuft direkt im Browser.

---

## 🗂 Projektmodule

| Tool | Datei | Beschreibung |
|---|---|---|
| **Trainingsplaner** | `index.html` | Trainingsplanung, Übungsdatenbank, Kalender |
| **Bank-Statistik** | `handball-bank-statistik.html` | Live-Spielauswertung direkt von der Bank |
| **Taktikboard** | `handball-taktikboard.html` | Taktisches Zeichenbrett (IHF/DHB-Standard) |

---

## ✨ Features

### 📋 Trainingsplaner
- Trainingseinheiten anlegen, bearbeiten, teilen
- DHB-Phasen: Aufwärmen / Hauptteil / Ausklang
- Drag & Drop, parallele Stränge, Tagesnotizen, Druckansicht
- Automatische Gesamtdauer (parallele Stränge korrekt berechnet)
- Kalenderansicht mit Monatsnavigation
- Private Übungsdatenbank + geteilte Teamdatenbank
- 28 DHB-Standardübungen per Knopfdruck
- Admin-Panel: Nutzerverwaltung, Freigaben, Rollen

### 📊 Bank-Statistik
- **Spielverwaltung**: Spiele anlegen, Status verfolgen, Spielstand verwalten
- **handball.net Integration**:
  - iCal-Spielplan importieren → Spiele direkt aus dem Kalender anlegen
  - Aufstellung automatisch laden (`/aufstellung`)
  - Live-Ticker importieren (`/ticker`): Tore, 7m, Strafen
  - Auto-Ticker: automatischer Refresh alle 2 oder 5 Minuten
- **Game-Start-Wizard**: beim ersten Öffnen automatisch Aufstellung laden, Team wählen, Timer-Modus festlegen
- **Live-Erfassung**: Spieler antippen → Aktionsbuttons (DHB-Kategorien)
- **Statistik**: Handlungseffektivität, Wurfquote, Abwehrquote, +/-Wert
- **Alles in Supabase**: jede Aktion sofort gespeichert, kein Datenverlust
- Optimiert für iPad (Quer- und Hochformat)

### 🖊 Taktikboard
- IHF-konforme Feldgeometrie
- DHB-Spielerformen: ▲ Angriff · ● Abwehr · ■ Torhüter · ◆ Kreisläufer
- Formationen (6:0, 5:1, 4:2), Trainings-Setup-Modus
- Bezier-Pfeile, Freihandzeichnen, Farbauswahl
- Mobile-optimiert (Touch, Long-Press zum Löschen)

---

## 🛠 Tech Stack

| Bereich | Technologie |
|---|---|
| Frontend | Vanilla HTML + CSS + JavaScript (Single File per Tool) |
| Backend | [Supabase](https://supabase.com) (Auth, PostgreSQL, RLS, Edge Functions) |
| Edge Functions | Deno / TypeScript (`quick-service`) |
| Fonts | DM Sans + DM Mono (Google Fonts) |
| Hosting | GitHub Pages (Flat-File, kein Build-Step) |

---

## 🚀 Setup

### 1. Supabase-Projekt

Bestehendes Projekt: `dlofjsmnkwltuutpxoer.supabase.co`

### 2. Datenbank-Schema

Im Supabase **SQL Editor** ausführen:

```sql
-- Bank-Statistik Tabellen (einmalig)
-- Inhalt von bank-statistik-supabase-setup.sql einfügen

-- Falls Spalten fehlen (Migration):
ALTER TABLE spieler_lineup ADD COLUMN IF NOT EXISTS team TEXT DEFAULT 'home';
ALTER TABLE spiele        ADD COLUMN IF NOT EXISTS hbn_url TEXT DEFAULT '';
```

### 3. Edge Function deployen

Supabase Dashboard → **Edge Functions** → `quick-service` → **Edit**
→ Inhalt von `quick-service.ts` in `index.ts` einfügen → **Deploy**

### 4. GitHub Pages

```
Repository-Struktur (flach, keine Unterverzeichnisse):
├── index.html                        ← Trainingsplaner (Hauptdatei)
├── handball-bank-statistik.html      ← Bank-Statistik
├── handball-taktikboard.html         ← Taktikboard
├── quick-service.ts                  ← Edge Function (Referenz)
├── bank-statistik-supabase-setup.sql ← SQL-Schema (Referenz)
├── README.md
└── STATUS.md
```

Settings → Pages → Deploy from branch → `main` → `/` → Save

---

## 🔗 handball.net Integration

Die Edge Function `quick-service` proxyt handball.net serverseitig und parst:

| Request-Typ | URL-Format | Liefert |
|---|---|---|
| `ical` | `webcal://handball.net/…/team/….ics` | Spielplan mit Datum, Teams, Ort |
| `match` | `…/spiele/…/aufstellung` | Spielinfo + beide Kader (TH/FL) |
| `ticker` | `…/spiele/…/ticker` | Spielstand + Events (Tore, Strafen) |

**Beispiel-URLs:**
```
iCal:        webcal://handball.net/a/sportdata/1/calendar/team/handball4all.ol-hamburg-schleswig-holstein.1343861.ics
Aufstellung: https://www.handball.net/spiele/handball4all.ol-hamburg-schleswig-holstein.8742581/aufstellung
Ticker:      https://www.handball.net/spiele/handball4all.ol-hamburg-schleswig-holstein.8742581/ticker
```

Die App leitet aus der gespeicherten Base-URL automatisch `/aufstellung` und `/ticker` ab.

---

## 🗄 Datenbankschema (Überblick)

### Trainingsplaner
- `profiles` — Nutzer (Name, Verein, Mannschaft, Rolle, aktiv)
- `einheiten` — Trainingseinheiten (JSONB)
- `uebungen` — Private Übungen
- `shared_exercises` / `exercise_shares` — Geteilte DB

### Bank-Statistik
- `spiele` — Spielmetadaten (`hbn_url`, Score, Status, Timer)
- `spieler_lineup` — Aufstellung pro Spiel (`team`: home/away)
- `spielaktionen` — Aktionen (Typ, Minute, Polarität, Spieler)

Alle Tabellen mit **Row Level Security** — jeder Nutzer sieht nur eigene Daten.

---

## 📌 DHB-Terminologie

| Symbol | Bedeutung |
|---|---|
| ▲ | Angriffspositionen (Feldspieler) |
| ● | Abwehrpositionen inkl. Torhüter |

**Feldspieler-Statistik:** Handlungseffektivität (HE%), Wurfquote (WQ%), Tore, 7m, Assists, 7m geholt, 2min geholt, Turn-Over, Fehlwurf, Fehlwurf 7m, Technischer Fehler, Fehlpass, 1:1 Gegentor, 7m verursacht, 2min/Rot

**Torhüter-Statistik:** Abwehrquote (AQ%), Gehalten, 7m gehalten, Kassiert, 7m kassiert, Assists

---

## 🗺 Roadmap

- [ ] Sidebar-Link Trainingsplaner ↔ Bank-Statistik
- [ ] Spielauswertungen im Trainingsplaner (Verknüpfung Spiel ↔ Einheit)
- [ ] Taktikboard-Integration (Supabase Storage, Thumbnails)
- [ ] Anwesenheitsliste
- [ ] Taktikdatenbank (Spielzüge, Abwehrsysteme)
- [ ] Sommerzeit-Korrektur im Ticker-Parser

---

## 📄 Lizenz

Privater und vereinsinterner Gebrauch.
