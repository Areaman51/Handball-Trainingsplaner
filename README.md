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

### 📊 Bank-Statistik (NEU)
- Live-Spielauswertung direkt von der Trainerbank
- Spieler-Aufstellung je Spiel mit Torhüter- und Feldspieler-Unterscheidung (DHB-Standard)
- Aktionserfassung per Tipp: Tor, Assist, 7m, 2min, Fehlwurf, Fehlpass, Turn-Over, 1:1 Gegentor u.v.m.
- Spieluhr mit Startt/Stopp; Synchronisation mit handball.net Liveticker per Doppelklick
- Spielstand automatisch beim Tor-Erfassen hochgezählt
- Undo-Funktion für die letzte Aktion
- Statistik-Auswertung nach dem Spiel: Handlungseffektivität, Wurfquote, Abwehrquote, +/-Wert
- Alle Daten live in Supabase gespeichert (kein Datenverlust bei Tablet-Schlaf)
- Export als JSON für Weiterverarbeitung
- Optimiert für iPad (Quer- und Hochformat)

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

Führe die SQL-Dateien nacheinander im Supabase SQL Editor aus:

**a) Trainingsplaner-Tabellen** (siehe vorhandene Dokumentation)

**b) Bank-Statistik-Tabellen** – Inhalt von `bank-statistik-supabase-setup.sql` ausführen:

```sql
-- Spiele, Spieler-Lineup, Spielaktionen
-- (vollständiges SQL in bank-statistik-supabase-setup.sql)
```

### 3. Auf GitHub Pages deployen

1. Repository erstellen
2. Dateien hochladen:
   ```
   index.html                        ← Trainingsplaner (Hauptdatei)
   handball-bank-statistik.html      ← Bank-Statistik
   handball-taktikboard.html         ← Taktikboard
   README.md
   STATUS.md
   bank-statistik-supabase-setup.sql ← Nur als Referenz, nicht vom Browser geladen
   ```
3. **Settings → Pages → Deploy from branch → main → / (root) → Save**
4. Nach 1–2 Minuten erreichbar unter `https://USERNAME.github.io/REPO/`

---

## 📁 Projektstruktur

```
handball-trainer/
├── index.html                        ← Trainingsplaner (Hauptanwendung)
├── handball-bank-statistik.html      ← Bank-Statistik (Spielauswertung)
├── handball-taktikboard.html         ← Taktikboard (standalone)
├── bank-statistik-supabase-setup.sql ← SQL-Schema für Bank-Statistik
├── README.md
└── STATUS.md                         ← Interner Entwicklungsstand
```

---

## 🔐 Sicherheit

- Row Level Security (RLS) auf allen Tabellen
- Nutzer sehen ausschließlich eigene Daten
- Admin-Operationen nur mit Rolle `admin`
- Auth via Supabase (bcrypt-Passwort-Hashing, Leaked-Password-Schutz aktiv)

---

## 🗺 Roadmap

- [ ] Bank-Statistik → Sidebar-Link im Trainingsplaner
- [ ] Spielauswertungen im Trainingsplaner sichtbar (Verknüpfung Spiel ↔ Einheit)
- [ ] handball.net Liveticker-Integration (automatische Zeitübernahme)
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
| ▲ | Angriffspositionen (Feldspieler) |
| ● | Abwehrpositionen inkl. Torhüter |

---

## 📄 Lizenz

Dieses Projekt ist für den privaten und vereinsinternen Gebrauch entwickelt.
