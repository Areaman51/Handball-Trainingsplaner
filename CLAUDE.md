# CLAUDE.md – Verbindliche Arbeitsanweisung

Handball Coaching Tools: browserbasierte Coaching-Suite nach DHB-Standard.
Diese Regeln gelten für **jede** Session und haben Vorrang vor eigenen Vorlieben. Bei Konflikt mit
README.md oder Altcode gilt diese Datei. Vor jeder Arbeit zusätzlich `STATUS.md` lesen.

## 1. Technik

- **Vanilla JavaScript mit nativen ES-Modulen** (`<script type="module">`), Import Maps für externe Abhängigkeiten.
- **Kein Build-Schritt, kein Framework, kein npm-Bundling.** Die App wird unverändert von GitHub Pages
  ausgeliefert und muss vom iPad aus editierbar bleiben (nur Textdateien, keine Toolchain).
- Externe Pakete ausschließlich über **esm.sh**, eingebunden per Import Map, z. B.
  `"@supabase/supabase-js": "https://esm.sh/@supabase/supabase-js@2"`.
- Backend: **Supabase** (Auth, PostgreSQL mit RLS, Edge Functions, Storage).
  Edge Functions: `quick-service` (handball.net-Proxy), `admin-user-ops`, `ical-proxy`.
- Hosting: GitHub Pages, Branch `main`, Root.
- Schriften: DM Sans + DM Mono (Google Fonts).
- **Modul-Falle:** Module haben keinen globalen Scope. Inline-Handler (`onclick="fn()"`) funktionieren nur,
  wenn die Funktion an `window` hängt (`window.fn = fn`) oder per `addEventListener` gebunden wird.
  Beim Umstellen einer Seite alle Inline-Handler prüfen.

## 2. Struktur

- **Flache Dateistruktur im Repo-Root**, keine Unterordner. Modul-Split in `/tools/`, `/admin/` erst nach Absprache.
- Gemeinsamer Code gehört in Root-Module:

| Datei | Inhalt |
|---|---|
| `hbn.js` | handball.net: Edge-Function-Aufruf, Spielplan-/Feed-Parser, Aufstellung, Ticker |
| `supabase-client.js` | Client-Erzeugung (URL/Anon-Key **nur hier**), `fetchAllPages()` |
| `shared.js` | Auth/Session-Guard, Sidebar, Toast, Saison-Logik, Berliner Zeit, Teamnamen-Abgleich, Positions-Helfer |
| `shared.css` | Gemeinsame Variablen, Sidebar, Buttons, Modals |

- **Keine Kopien derselben Funktion in mehreren HTML-Dateien.** Vor jeder neuen Hilfsfunktion im Modul suchen
  (`grep -n "function name" *.html *.js`); vorhandene Kopie beim Anfassen ins Modul heben und die Kopien
  in den Seiten durch `import` ersetzen.
- **Ist-Zustand (Stand dieser CLAUDE.md):** Alle 10 Seiten sind Single-File-HTMLs mit klassischem
  `<script>`, Supabase über `cdn.jsdelivr.net` (UMD) und je eigener Kopie von URL/Key, `signOut`, `onAuth`,
  `toggleSidebar`, `loadSaisons`, `getSaisonRange`, `hbnApi`, `parseHbnGameFeed`, `parseICal`, `showToast`
  u. a. `fetchAllPages` existiert dreifach (bank-statistik, mannschaftsstatistik, spielerstatistik).
  Die Migration erfolgt **schrittweise, Seite für Seite, wenn ohnehin angefasst** – kein Big-Bang-Umbau.

## 3. Typsicherheit

- **Alle neuen und überarbeiteten `.js`-Dateien beginnen mit `// @ts-check`** (erste Zeile).
- Öffentliche (exportierte) Funktionen bekommen JSDoc: `@param {Typ} name`, `@returns {Typ}`;
  gemeinsame Datentypen per `@typedef` (z. B. `Spieler`, `Spiel`, `Aktion`).
- Ziel: Editor-Typprüfung ohne Kompilierung. Kein `tsc`-Lauf, kein `.ts`.
- Neue Logik in `.js`-Module legen, nicht in Inline-Skripte – nur dort greift `@ts-check`.

## 4. Sprache – alles Deutsch

- UI-Labels, Code-Kommentare, **Variablen- und Funktionsnamen**, Commit-Messages: Deutsch.
  Bestehende englische Bezeichner nicht flächig umbenennen (Regel 6); neue Namen deutsch.
  DB-Tabellen/-Spalten und Supabase-API-Namen bleiben unverändert.
- DHB-Standardbegriffe: **Einheit, Kader, Torhüter, Anwesenheit, Mannschaft** (nicht Training-Session,
  Roster, Keeper, Attendance, Team in der UI).
- **Rollen:** `TH` = Torhüter, `FL` = Feldspieler.
- **Angriffspositionen:** `LA`, `RL`, `RM`, `RR`, `RA`, `KS`. Legacy-Code **`KR` wird beim Lesen akzeptiert**
  und auf `KS` normalisiert (Vorlage: `canonPos` in `gegneranalyse.html`), **geschrieben wird nur `KS`**.
- **Abwehrsysteme:** `6:0`, `5:1`, `3:2:1`, `3:3`, `4:2`.
- **Abwehrpositionen als Objekt pro System**, z. B. `{"6:0":["AL"],"5:1":["HM"]}`. Positionscodes aus den
  bestehenden Konstanten übernehmen, keine neuen erfinden. Ist-Zustand: `abwehr_pos` wird in
  `trainingsplaner.html` (`_awAbw`) noch als flaches Array gelesen – Array-Altdaten beim Lesen tolerieren,
  neu im Objektformat schreiben.
- **Darstellung:** Angriff `▲`, Abwehr **inklusive Torhüter** `●`. Taktikboard zusätzlich `■` Torhüter, `◆` Kreisläufer.
- **Positionslabels immer aus der Eigen-Tor-Perspektive** der jeweiligen Mannschaft.

## 5. Versionierung

- Format: `v1.YYMMDD.HHMM`, immer aus der Systemzeit erzeugen, nie schätzen:
  ```
  TZ='Europe/Berlin' date '+v1.%y%m%d.%H%M'
  ```
- **`handball-bank-statistik.html` nutzt Präfix `v5.`** statt `v1.` (`v5.YYMMDD.HHMM`).
- Pro geänderter HTML-Datei an **zwei Stellen** setzen, **immer gemeinsam**:
  1. HTML-Kommentar direkt nach `<!DOCTYPE html>`, z. B. `<!-- Handball Coaching Tools v1.260612.1609 — Trainingsplaner -->`
  2. Sidebar-Footer (sichtbarer Versions-String)
- Nur Dateien versionieren, die tatsächlich geändert wurden. Reine `.js`/`.css`-Module tragen keine Versionsnummer,
  ihre Änderung wird über die betroffenen Seiten und in `STATUS.md` dokumentiert.
- Bekannte Abweichungen im Ist-Zustand (beim Anfassen der Datei mitkorrigieren): `kalender.html` hat keinen
  Kommentar nach `<!DOCTYPE html>`; `nutzerverwaltung.html` hat unterschiedliche Versionen an beiden Stellen.

## 6. Editier-Disziplin

- **Chirurgische Edits** (gezieltes Ersetzen einzelner Stellen). Keine Vollrewrites ohne Not; Dateien haben 500–6300 Zeilen.
- **Fremde Funktionalität nie anfassen**, auch nicht „nebenbei aufräumen“ oder umformatieren.
- **Read-only-Guards erhalten und bei jedem neuen Feature mitziehen:** `_isSharedTeam` (Mannschaft gehört
  einem anderen Nutzer und ist nur freigegeben) und `canEdit`. Jede neue schreibende Aktion (Button, Modal,
  Speichern, Löschen) prüft den Guard – UI **und** Schreibpfad. Vorbild: `spielerstatistik.html` (`canEdit`).
- **Optionale DB-Spalten** (Migration evtl. noch nicht eingespielt): Fehler abfangen, `console.warn` mit
  Spaltenname und **In-App-Hinweis** anzeigen, App läuft weiter – **nie ein Crash**. Vorbild:
  `gegneranalyse.html` (`hbn_spiel`, `hbn_logo_url`) und `spielerstatistik.html` (Migrationshinweis).
- **Migrationen immer idempotent:** `CREATE TABLE IF NOT EXISTS`, `ADD COLUMN IF NOT EXISTS`,
  `CREATE INDEX IF NOT EXISTS`. `CREATE POLICY` kennt kein `IF NOT EXISTS` → vorher `DROP POLICY IF EXISTS`.
  Migrationen als SQL-Datei im Root ablegen und in `STATUS.md` nennen.
- Keine Secrets im Repo. Der Supabase-**Anon-Key** ist öffentlich und gehört ausschließlich in
  `supabase-client.js`; `service_role`-Keys niemals in Client-Code.

## 7. Supabase

- **`fetchAllPages()` für jede Query, die mehr als 1000 Zeilen liefern kann** (`spielaktionen`, `spieler_lineup`,
  Anwesenheit, Langzeitstatistik). PostgREST kürzt serverseitig still bei 1000 Zeilen, auch bei clientseitigem
  `.limit(10000)`. `.limit(n)` ist nur für bewusst kleine Ergebnisse (`.limit(1)`) gedacht.
- **Aktions- und Lineup-Queries filtern über `spiel_id IN (filteredSpielIds)`, nicht über `user_id`.**
  Aktionen werden unter der `user_id` des erfassenden Trainers gespeichert, die Spiele gehören dem Eigentümer.
  Leere ID-Liste mit Platzhalter-UUID absichern (siehe `DEAD_ID` in `handball-bank-statistik.html`).
- **RLS-Policies:**
  - `auth.uid()` immer als `(SELECT auth.uid())` wrappen (einmalige Auswertung pro Query).
  - Set-returning Functions **nicht direkt** im Policy-Ausdruck, sondern
    `EXISTS (SELECT 1 FROM get_freigegebene_mannschaft_ids() AS x WHERE x = id)`.
  - `get_freigegebene_mannschaft_ids()` bleibt **`SECURITY INVOKER`**, `EXECUTE` für `anon` entzogen
    (`REVOKE EXECUTE ... FROM anon`). Die README nennt noch `security definer` – veraltet, diese Regel gilt.
- Edge Functions immer mit `Authorization: Bearer <session.access_token>` aufrufen.
- RLS auf allen Tabellen; neue Tabelle = RLS aktivieren + Policies im selben Migrationsskript.

## 8. Zeit und Matching

- **Berliner Zeit DST-korrekt** über `Intl.DateTimeFormat`/`toLocaleString('sv-SE', { timeZone: 'Europe/Berlin' })`
  bzw. Offsetberechnung daraus. **Niemals ein fester Offset (+1h/+2h).**
  Vorlagen: `berlinDateTime()` in `gegneranalyse.html`, TZID-Behandlung in `kalender.html`.
  Zielort: `shared.js` (eine Implementierung).
- **Teamnamen-Abgleich dreistufig, in dieser Reihenfolge:** 1. exakt (normalisiert) → 2. Teilstring → 3. Wort-Token.
  Die erste Stufe mit eindeutigem Treffer gewinnt; mehrdeutige Treffer nicht raten, sondern zur Auswahl anbieten.
  (Spielerabgleich im Kader-Import: `mannschaftsverwaltung.html`, Stufen vorhanden/ähnlich/neu.)

## 9. Validierung – vor jeder Auslieferung

- **`scripts/validate.sh` ausführen** und Ausgabe prüfen. Erst bei grünem Lauf committen/pushen.
- **Fatal:** das Muster `<\/script>` (Backslash vor Slash). Es führt dazu, dass der gesamte Seiteninhalt als
  Script konsumiert wird. Echte Script-Endtags immer als `</script>` schreiben; wird das Muster in einem
  JS-String gebraucht, den String zerlegen (`'<' + '/script>'`). `validate.sh` schlägt bei jedem Treffer fehl.
- Erwartete Prüfungen des Skripts: `<\/script>`-Muster; ausgeglichene `<script>`/`</script>`-Tags;
  Versions-Kommentar und Sidebar-Footer stimmen überein; neue/überarbeitete `.js` beginnen mit `// @ts-check`;
  Syntaxprüfung der Module (`node --check`, falls verfügbar).
- **Status:** `scripts/validate.sh` existiert im Repo noch nicht und muss angelegt werden, bevor sich diese
  Regel befolgen lässt. Nicht stillschweigend überspringen – fehlt das Skript, das melden.

## 10. STATUS.md – nach jeder Session aktualisieren

Aufbau:
1. **Versionstabelle** aller Dateien (Datei, Beschreibung, aktuelle Version).
2. **Changelog, neueste Session zuerst**, je Eintrag: **Ursache** → **Fix** → **Validierung**.
3. **Technische Konventionen** (Abschnitt fortschreiben, wenn neue Muster entstehen).
4. **Footer „Letzter Stand“** (Datum, Uhrzeit Berliner Zeit, betroffene Dateien).

Hinweis: `STATUS.md` fehlt im Repo (README verweist darauf). Eine ältere Kopie (Stand 12.06.2026) liegt lokal
beim Nutzer; sie muss ins Repo-Root übernommen und auf den heutigen Stand gebracht werden.

## 11. Arbeitsablauf pro Session

1. `CLAUDE.md` und `STATUS.md` lesen, betroffene Dateien gezielt lesen (große Dateien per Zeilenbereich).
2. Chirurgisch ändern (Regel 6), gemeinsamen Code in Module heben (Regel 2).
3. Version pro geänderter HTML-Datei an beiden Stellen setzen (Regel 5).
4. `scripts/validate.sh` ausführen (Regel 9).
5. `STATUS.md` aktualisieren (Regel 10).
6. Commit auf Deutsch, aussagekräftig, mit Angabe der Dateien; nur committen/pushen, wenn der Nutzer es verlangt.
