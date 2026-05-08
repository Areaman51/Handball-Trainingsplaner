# 🤾 Handball Coaching Tools

> Browserbasierte Coaching-Suite für Handball-Trainer nach DHB-Standard.
> Kostenlos, ohne Installation – läuft direkt im Browser auf jedem Gerät.

---

## 🗂 Projektmodule

| Datei | Modul | Version | Status |
|---|---|---|---|
| `index.html` | **Dashboard** – Startseite mit Kachelnavigation | v1.260508.1200 | ✅ |
| `trainingsplaner.html` | Trainingsplaner – Einheiten, Übungsdatenbank, iCal | v1.260508.1200 | ✅ |
| `kalender.html` | Zentraler Kalender-Hub | v1.260503.1700 | ✅ |
| `handball-bank-statistik.html` | Live-Spielauswertung, Kader, Statistik | v1.260510.1300 | ✅ |
| `mannschaftsverwaltung.html` | Mannschafts-, Kader- & Kalenderverwaltung | v1.260507.1115 | ✅ |
| `nutzerverwaltung.html` | Nutzerverwaltung (nur Admin/Manager) | v1.260503.1700 | ✅ |
| `mein-profil.html` | Profil-Selbstverwaltung für jeden Nutzer | v1.260508.1200 | ✅ |
| `handball-taktikboard.html` | Taktikboard | – | 🔜 Supabase-Integration ausstehend |

---

## ✨ Features

### 🏠 Dashboard (`index.html`)
- Zentraler Einstiegspunkt für alle Tools nach dem Login
- Kachelnavigation in drei Bereichen: Arbeitsbereich, Mein Bereich, Administration
- Admin-Bereich (Nutzerverwaltung, Freigaben, Vereinsverwaltung) nur für Admin/Manager sichtbar
- Bald-Badges für noch nicht fertige Module (Taktikboard, Gegneranalyse, Vereinsverwaltung)
- Pending-Indikator auf der Freigaben-Kachel bei ausstehenden Übungsvorschlägen
- Alle anderen Seiten leiten bei fehlender Session auf das Dashboard zurück

### 👤 Mein Profil (`mein-profil.html`)
- Für jeden angemeldeten Nutzer erreichbar – kein Admin-Zugang erforderlich
- Bearbeitbar: Name, Verein, Mannschaft, Passwort (mit Stärke-Anzeige)
- Schreibgeschützt: E-Mail, Rolle, Registrierungsdatum, Nutzer-ID
- Passwort-Änderung ausklappbar mit Bestätigungsfeld

### 🏃 Mannschaftsverwaltung (`mannschaftsverwaltung.html`)
- Zentrale Datenbasis für alle Tools – Mannschaften, Kader und Kalender an einem Ort
- **Eigentümerschaft:** Jeder Trainer verwaltet nur seine eigenen Mannschaften
- **Freigabe-System:** Einzelne Trainer gezielt freischalten (Lesezugriff)
- **Kader:** Spieler mit Rückennummer, Position (▲ Feldspieler / ● Torhüter) und Aktiv-Status
- **handball.net-Import:** Kader direkt aus Spielaufstellungen laden mit automatischem Abgleich (exakt / ähnlich / neu)
- **Kalender (Feeds):** Beliebig viele iCal-Kalender je Mannschaft, kategorisiert nach Training · Spielplan · Pokal · Sonstige
- **Farben:** Zwei Kalenderfarben je Mannschaft für den Trainingsplaner

### 📋 Trainingsplaner (`trainingsplaner.html`)
- Trainingseinheiten nach DHB-Phasen und Kategorien
- Drag & Drop Sortierung, Druckansicht (A4), geteilte Übungsdatenbank
- Übungen: Organisation, Min/Max Spieler, Ablauf, Variationen, Schwerpunkt, Bilder, YouTube-Links
- Parallele Stränge (Gruppentraining), Sitzungsnotizen je Übung
- Admin-Deeplink vom Dashboard: `trainingsplaner.html?admin=freigabe`

### 📅 Kalender (`kalender.html`)
- Monatskalender mit Trainingseinheiten und iCal-Feeds aller Mannschaften
- Klick auf Trainingseinheit → Trainingsplaner, Klick auf Spiel → Bank-Statistik

### 📊 Bank-Statistik (`handball-bank-statistik.html`)

#### Meine Spiele / Dashboard
- Kachelansicht aller Spiele mit Status (Geplant / Live / Beendet) und Ergebnis
- **Saisonfilter:** Saisons über Enddatum definieren – neue Saison startet automatisch am Folgetag
- Spiele anlegen: aus handball.net-Spielplan (iCal), manuell oder aus Kaderliste

#### Live-Erfassung
- Drei-Spalten-Layout: Aktionslog links, Score-Leiste oben, Spieler-Kacheln rechts
- DHB-Kennzahlen je Spieler: Handlungseffektivität, Wurfquote, Assists, Turn-Overs u.v.m.
- Torhüter-Statistik: Abwehrquote, Gehalten, Kassiert
- Automatische Torhüter-Erkennung über Kader-Abgleich
- Rückgängig-Funktion für alle Aktionen

#### handball.net-Ticker-Synchronisation
- Tore, 7m-Tore, 2-Minuten-Strafen und Rote Karten werden automatisch importiert
- Beide Teams vollständig erfasst – auch Gegner ohne namentliche Erfassung (Nummern-only)
- Zählbasiertes Dedup: mehrere Tore desselben Spielers in einer Spielminute korrekt erkannt
- Auto-Ticker (alle 2 oder 5 Minuten) oder manuelle Synchronisation

#### Spieler-Lineup-Wizard
- **Aus handball.net:** Aufstellung automatisch laden, eigenes Team auswählen
- **Aus Kaderliste:** Spieler per Checkbox auswählen, Spielart wählen
- **Manuell:** Spieler direkt im Formular eingeben
- Gegner-Lineup wird mitgespeichert für Ticker-Zuordnung und Gegner-Statistik

#### Statistik-Ansicht
- Einzelspiel-Auswertung nach DHB-Kennzahlen
- **Toggle Mein Team / Gegner:** Gegner-Ansicht mit Ticker-Ereignissen je Spieler
- Langzeitstatistik mit Saisonfilter (aggregiert über alle Spiele der Saison)

#### UI & Bedienung
- Sidebar einklappbar per ✕ / Burger-Menü (☰) – auf dem iPad standardmäßig eingeklappt
- Einstellungen werden in Supabase gespeichert (geräteübergreifend, iPad-kompatibel)

### 🎯 Taktikboard (`handball-taktikboard.html`) — 🔜 in Entwicklung
- IHF-konforme Feldgeometrie, DHB-Positionssymbole (▲ ● ■ ◆)
- Formationen 6:0 / 5:1 / 4:2, Trainingsaufbau-Modus
- Bézier-Pfade, Freihandzeichnen, Phasenwechsel per Swipe
- Positionslabels aus Eigen-Tor-Perspektive (DHB-konform)
- Supabase-Integration: **noch ausstehend**

### ⚙️ Nutzerverwaltung (`nutzerverwaltung.html`)
- Nur für Admins/Manager: Rollen, Aktivierung, Freigabe-Workflow
- Zugänglich über Admin-Bereich des Dashboards

---

## 🔗 Cross-Tool-Navigation

```
index.html (Dashboard)
 ├── trainingsplaner.html
 ├── kalender.html
 ├── handball-bank-statistik.html
 ├── mannschaftsverwaltung.html
 ├── mein-profil.html            (alle Nutzer)
 └── nutzerverwaltung.html       (nur Admin/Manager)

trainingsplaner.html  ←→  kalender.html
kalender.html         ←→  handball-bank-statistik.html
bank-statistik.html   →   mannschaftsverwaltung.html (Sidebar)

Alle Seiten → index.html bei fehlender Session oder Abmeldung
```

---

## 🛠 Tech Stack

| Bereich | Technologie |
|---|---|
| Frontend | Vanilla HTML / CSS / JS (Single-File, kein Build-Schritt) |
| Backend | Supabase (Auth, PostgreSQL, RLS, Edge Functions) |
| handball.net | Supabase Edge Function `quick-service` (Deno / TypeScript) |
| iCal | CORS-Proxies + Edge Function `ical-proxy` (geplant) |
| Schriften | DM Sans + DM Mono via Google Fonts |
| Hosting | GitHub Pages (flache Dateistruktur, Root) |

---

## 🗄 Datenbankstruktur (Supabase)

| Tabelle | Zweck |
|---|---|
| `profiles` | Nutzerprofil (Name, Verein, Rolle, aktiv) |
| `einheiten` | Trainingseinheiten mit Übungen (JSONB) |
| `einheit_freigaben` | Freigabe zwischen Nutzern |
| `uebungen` | Private Übungsdatenbank |
| `geteilte_uebungen` | Öffentliche / geteilte Übungen |
| `kategorien` | DHB-Übungskategorien |
| `einladungen` | Einladungs-Tokens |
| `mannschaften` | Mannschaftsstammdaten + Kalenderfarben |
| `mannschaft_spieler` | Kader pro Mannschaft (Nr., Name, Pos, Aktiv) |
| `mannschaft_freigaben` | Trainer-Freigaben (Lesezugriff auf fremde Mannschaften) |
| `mannschaft_kalender` | iCal-Feeds pro Mannschaft |
| `spiele` | Spielverwaltung (Bank-Statistik) |
| `spieler_lineup` | Aufstellung pro Spiel (eigene + Gegner als `bench=true`) |
| `spielaktionen` | Aktionen pro Spieler inkl. Gegner-Ereignisse |
| `saisons` | Saisondefinitionen (Name + Enddatum) |

Alle Tabellen mit Row Level Security (RLS). `mannschaften` nutzt eine `security definer`-Funktion
(`get_freigegebene_mannschaft_ids`) zur Auflösung eines RLS-Zirkelverweises.

---

## ⚡ Edge Functions

| Function | Zweck | Status |
|---|---|---|
| `quick-service` | handball.net Proxy: iCal, Aufstellung, Ticker (beide Teams) | ✅ deployed |
| `admin-user-ops` | Nutzer löschen (nur Admin-Rolle) | ✅ deployed |
| `ical-proxy` | CORS-sicherer iCal-Proxy | ⏳ geplant |

---

## 🚀 Deployment (GitHub Pages)

Alle Dateien liegen flach im Repository-Root. Keine Unterordner, kein Build-Schritt.

```
/
├── index.html                    ← Dashboard (Einstiegspunkt)
├── trainingsplaner.html
├── kalender.html
├── handball-bank-statistik.html
├── handball-taktikboard.html
├── mannschaftsverwaltung.html
├── nutzerverwaltung.html
├── mein-profil.html
├── README.md
└── STATUS.md
```

> **Ordnerstruktur:** Bleibt vorerst flach. Eine Aufteilung in `/tools/` und `/admin/` ist geplant,
> sobald weitere Module (Gegneranalyse, Vereinsverwaltung, Taktikdatenbank) hinzukommen.

**Einmalige SQL-Migrationen** (Supabase SQL-Editor, Reihenfolge beachten):
1. `mannschaftsverwaltung_migration.sql`
2. `mannschaft_kalender_migration.sql`
3. Manuelle Patches (siehe STATUS.md)

Settings → Pages → Deploy from branch → main → / (root) → Save

---

## 📌 DHB-Konventionen

| Symbol | Bedeutung |
|---|---|
| ▲ | Angriffspositionen |
| ● | Abwehrpositionen inkl. Torhüter |
| ■ | Torhüter (Taktikboard) |
| ◆ | Kreisläufer (Taktikboard) |

Positionslabels immer aus der Eigen-Tor-Perspektive der jeweiligen Mannschaft.

---

## 🗺 Roadmap

- [ ] Taktikboard → Supabase-Integration (`board_json` + PNG-Thumbnails in Storage)
- [ ] Taktikboard UI-Fertigstellung (Supabase-Integration Voraussetzung)
- [ ] Gegneranalyse (neues Modul)
- [ ] Vereinsverwaltung (Admin – Vereine und fremde Mannschafts-Feeds anlegen)
- [ ] Trainingsplaner ↔ Bank-Statistik Cross-Link (Sidebar)
- [ ] Anwesenheitsliste im Trainingsplaner (Spieler aus `mannschaft_spieler`)
- [ ] Taktikdatenbank (Spielzüge, Abwehrsysteme)
- [ ] `ical-proxy` Edge Function deployen
- [ ] Bank-Statistik: PDF-Export pro Spiel
- [ ] Ordnerstruktur (`/tools/`, `/admin/`) bei ~12+ Dateien

---

## 🔐 Sicherheit

- RLS auf allen Tabellen; Nutzer sehen nur eigene + explizit freigegebene Daten
- Mannschaften: Eigentümer-Modell mit expliziten Freigaben
- Admin-Operationen nur mit Rolle `admin`
- Supabase Auth (bcrypt, Leaked-Password-Schutz)
- Alle Seiten prüfen Session beim Start und leiten ohne Login zu `index.html` weiter

---

## 📄 Lizenz

Für privaten und vereinsinternen Gebrauch entwickelt.
