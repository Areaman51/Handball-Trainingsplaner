# Handball Coaching Tools – Projektstatus

## Ziel
Browserbasierte Coaching-Tool-Suite für Handball-Trainer nach DHB-Standard.
Läuft vollständig im Browser – mit Supabase-Backend für Auth, Datenpersistenz und Echtzeit-Statistik.

---

## Aktuelle Dateien (GitHub Pages – alle im Root)

| Datei | Beschreibung | Version |
|---|---|---|
| `index.html` | **Dashboard** – Kachelnavigation, zentraler Login | v1.260612.1624 |
| `trainingsplaner.html` | Trainingsplaner – Einheiten, Übungsdatenbank, Home-View, Ladescreen, Anwesenheit (Aktiv/Inaktiv, Gäste, Einzel-Aktivierung; **Sortierung nach Position/Nummer/Name**); **handball.net-JSON-Spielplan (Ergebnisse) statt iCal, synchronisierte Saisonauswahl** | v1.260612.1609 |
| `kalender.html` | Zentraler Kalender-Hub (**handball.net-JSON-Spielplan mit Ergebnissen**, iCal nur Fallback; synchronisierte Saisonauswahl) | v1.260608.1946 |
| `handball-bank-statistik.html` | Live-Spielauswertung, Kader, Statistik (**handball.net-JSON: Spielplan/Aufstellung/Live über `schedule`/`combined`, iCal/HTML nur Fallback**) | v5.260807.1502 |
| `spielerstatistik.html` | **Spielerstatistik** – Langzeit + Anwesenheit je Spielerin, Zusatzeinheiten; Aktiv/Inaktiv-Tab, Gast-Anwesenheit; **Spielerliste sortierbar nach Position/Nummer/Name; Zusatzeinheiten einzeln je Spielerin erfass- und löschbar** | v1.260621.1333 |
| `mannschaftsstatistik.html` | **Mannschaftsstatistik** – Saisonbilanz/Spiele/Anwesenheit; **synchronisierte Saisonauswahl + Bilanz-Anreicherung aus handball.net-JSON** | v1.260609.1051 |
| `mannschaftsverwaltung.html` | Zentrale Mannschafts-, Kader- & Kalenderverwaltung (Kader = nur aktive Spieler, eigener Inaktiv-Tab; **handball.net-Integration:** Anlage, Saison-/Wettbewerbsauswahl, Kader-Import über alle Spiele, Nachverknüpfung) | v1.260608.0852 |
| `nutzerverwaltung.html` | Nutzerverwaltung (nur Admin/Manager) | v1.260503.1400 (Kommentar) / v1.260508.2200 (Footer) ⚠ uneinheitlich |
| `mein-profil.html` | Profil-Selbstverwaltung (Name, Verein, Mannschaft, Passwort) | v1.260508.1200 |
| `gegneranalyse.html` | **Gegneranalyse** – Profile, Spielsysteme, Statistik, Auslösehandlungen (**handball.net-JSON-Spielplan mit Ergebnissen/Live über `schedule`, iCal nur Fallback; Saisonbilanz aus Gegner-Sicht; handball.net-Verknüpfung & Kader-Import**) | v1.260623.0941 |
| `handball-taktikboard.html` | Taktikboard (Supabase-Integration ausstehend) | – |
| `CLAUDE.md` | Verbindliche Arbeitsanweisung für alle Sessions | – |
| `scripts/validate.sh` | Validierung vor jeder Auslieferung (Regel 9 der CLAUDE.md) | – |
| `STATUS.md` | Dieses Dokument | – |

> Versionen = Stand im Repo (`main`, 20.09.2026). `kalender.html` hat keinen Versions-Kommentar; `index.html` und `mein-profil.html` haben keinen Sidebar-Footer (nur Kommentar).

---

## Änderungen – Session 20.09.2026 (Arbeitsgrundlage: CLAUDE.md, validate.sh, STATUS.md im Repo)

### `CLAUDE.md` (neu) · `scripts/validate.sh` (neu) · `STATUS.md` (ins Repo übernommen, Stand aktualisiert)

Keine Änderung an den HTML-Seiten, keine Versionsanhebung.

#### Verbindliche Arbeitsanweisung fehlte, Validierung war nur eine manuelle Checkliste

**Ursache:** Regeln (ES-Module, Versionierung, Supabase/RLS, Guards, Validierung) standen verstreut in `STATUS.md` und in Sessions; `STATUS.md` lag nur lokal (Stand 12.06.2026), `scripts/validate.sh` existierte nicht. Das Repo besteht noch aus zehn Single-File-HTMLs mit klassischem `<script>`, Supabase per jsdelivr-UMD und mehrfach kopierten Funktionen (`signOut`, `onAuth`, `toggleSidebar`, `loadSaisons`, `hbnApi`, `parseICal` u. a.; `fetchAllPages` dreifach).

**Fix:**
- `CLAUDE.md` im Root angelegt (Technik, Struktur, Typsicherheit, Sprache/DHB-Terminologie, Versionierung, Editier-Disziplin, Supabase/RLS, Zeit/Matching, Validierung, STATUS-Pflege).
- `scripts/validate.sh` angelegt: fatales Muster `<\/script>`, ausgeglichene `<script>`-Tags, Versions-Kommentar = Sidebar-Footer (Präfix `v1.`/`v5.`, bei geänderten Dateien Version gegenüber `HEAD` erhöht), `// @ts-check` in `.js`, Syntaxprüfung mit `node --check` (nur wenn `node` vorhanden). Altlasten in ungeänderten Dateien sind Warnungen, in geänderten Dateien Fehler.
- `STATUS.md` ins Repo übernommen; Versionstabelle auf den tatsächlichen Repo-Stand gesetzt.

**Bekannte Lücke:** Zwischen dem letzten dokumentierten Stand (12.06.2026) und dem Repo-Stand wurden `gegneranalyse.html` (→ v1.260623.0941), `spielerstatistik.html` (→ v1.260621.1333), `handball-bank-statistik.html` (→ v5.260807.1502) und `index.html` (→ v1.260612.1624) geändert. Diese Änderungen sind hier nicht dokumentiert (Commit-Messages im Repo lauten nur „Add files via upload“) und sollten bei der nächsten Arbeit an der jeweiligen Datei nachgetragen werden.

#### Validierung

`scripts/validate.sh` gegen den Ist-Stand: 0 Fehler, 4 Warnungen (`kalender.html` ohne Versions-Kommentar; `index.html` und `mein-profil.html` ohne Footer-Version; `nutzerverwaltung.html` uneinheitlich). Negativtest in einer Kopie: `<\/script>`-Muster, `.js` ohne `@ts-check`, geänderte Datei ohne Versionsanhebung → jeweils Fehler, Exit-Code 1. Syntaxprüfung mit `node` **nicht** getestet (`node` auf dem Rechner nicht installiert).

---

## Änderungen – Session 12.06.2026 (Bugfix: Übung speichern – TypeError `f-sname`)

### `trainingsplaner.html` (v1.260612.1006 → v1.260612.1609)

#### Übung speichern brach mit `TypeError` ab

Beim Speichern einer Übung warf `saveDrill()` einen `TypeError: null is not an object (evaluating 'document.getElementById('f-sname').value')`; die Übung wurde dadurch nicht gespeichert.

**Ursache:** Die Einheitsdaten (Name, Datum, Zeit, Gruppe, Ort, Schwerpunkt) wurden zuvor aus dem „Übung hinzufügen"-Modal in ein eigenes „Einheit bearbeiten"-Modal (`se-name`/`se-date`/`se-group`/`se-ort`/`se-focus`/`se-notes`, verarbeitet in `saveSessionEdit()`) ausgelagert. `saveDrill()` griff aber noch auf die alten, nicht mehr existierenden Inline-IDs (`f-sname`, `f-sgroup`, `f-date`, `f-time`, `f-ort`, `f-sfocus`) zu → `getElementById` lieferte `null` → Zugriff auf `.value` warf den Fehler.

**Fix:** Die sieben veralteten Zeilen aus `saveDrill()` ersatzlos entfernt. Die Einheitsdaten werden ausschließlich über `saveSessionEdit()` gepflegt – keine Funktionalität ging verloren, die Drill-Speicherung läuft wieder durch.

#### Validierung

Inline-JS extrahiert + `node --check` ✓ · keine `<\/script>`-Artefakte · `<script>`/`</script>` 2/2 ausbalanciert · keine Reste der alten IDs (`f-sname`/`f-sgroup`/`f-sfocus`) · Diff gegen Vorversion auf den `saveDrill`-Kopf begrenzt. (`<div>`-Differenz 543/542 bereits im Original vorhanden, von der Änderung unberührt.)

---

## Änderungen – Session 12.06.2026 (Spielerstatistik: Listensortierung + Zusatzeinheiten einzeln verwalten)

### `spielerstatistik.html` (v1.260606.1358 → v1.260612.1045)

#### 1. Spielerliste sortierbar (analog Trainingsplaner-Anwesenheit)

Neue Sortier-Leiste über der Spielerliste: **Position · Nummer · Name**, bei „Name" zusätzlich **Vorname / Nachname** (Nachname = letztes Namenswort). Position = gewohnte Gruppierung (▲ Feldspielerinnen / ● Torhüterinnen, im Filter „Alle"); Nummer/Name = flache, durchsortierte Liste mit Gruppenlabel. Sortierung wirkt zusätzlich zum bestehenden Positions-Filter (Alle/▲ Feld/● Tor) und löst kein DB-Reload aus (nur `renderPlayerList`). State: `_statSortMode` (`position`/`nummer`/`name`), `_statNameSort` (`vorname`/`nachname`); Helfer `_sortPlayers`/`_nachname`/`_nummerVal`, `renderStatSortBar`; Setter `setStatSortMode`/`setStatNameSort`. Sortierlogik 1:1 wie `trainingsplaner.html` (`localeCompare` mit `'de'`, `sensitivity:'base'`).

#### 2. Zusatzeinheiten: einzeln je Spielerin erfassen & löschen

Bisher konnten Zusatzeinheiten nur über die **zentrale** Mehrfach-Erfassung (Modal in der Kopfzeile) angelegt und gar nicht entfernt werden. Versehentlich doppelte Einträge ließen sich daher nicht bereinigen, was als „doppelte Werte" sichtbar wurde.

- **Einzel-Erfassung:** Im Anwesenheits-Tab je Spielerin neuer Button **➕ Einheit erfassen** → eigenes Modal `zus1-modal` (Datum, Dauer/Art/Notiz optional) legt **genau eine** Zeile für diese Spielerin an. Funktionen `openZus1Modal`/`closeZus1Modal`/`saveZus1`, State `_zus1PlayerId`.
- **Löschen:** Jede Zeile der Liste „Erfasste Zusatzeinheiten" hat jetzt einen 🗑️-Button (`deleteEinzeleinheit(rowId,pid)`, `confirm`-Sicherung, Löschen per `eq('id',rowId)`). Voraussetzung: Item trägt die Zeilen-`id` (in `loadEinzeleinheiten` ergänzt: `items.push({id:z.id,…})`).
- **Bewusst kein Auto-Dedupe:** Zwei Einheiten einer Spielerin am selben Tag bleiben gültig (legitimer Anwendungsfall); Bereinigung erfolgt manuell über den Löschbutton.
- Beide Aktionen nur bei eigenem Team (`canEdit = !_isSharedTeam`); fremde Teams bleiben lesend. Nach Erfassen/Löschen wird die zuvor gewählte Spielerin wieder angezeigt (`_selectedPlayerId`).

#### Validierung

Inline-JS extrahiert + `node --check` ✓ · keine `<\/script>`-Artefakte · `<div>`/`</div>` 217/217, `<script>`/`</script>` 2/2 ausbalanciert · Diff gegen Vorversion auf die o. g. Stellen begrenzt.

#### Offen / Hinweis

Keine Schema-Änderung nötig (`einzeleinheiten` enthält bereits `id`). Falls in einer Mehrtrainer-Konstellation Zeilen mehrerer Trainer für dieselbe `mannschaft_id` sichtbar werden, lässt sich das künftig über einen optionalen `user_id`-Filter in `loadEinzeleinheiten` eingrenzen.

---

## Änderungen – Session 12.06.2026 (Trainingsplaner-Anwesenheit + einheitlicher Kreisläufer-Code KS)

### `trainingsplaner.html` (v1.260609.1015 → v1.260612.1006) · `gegneranalyse.html` (v1.260609.2237 → v1.260612.1019)

#### 1. Anwesenheit: Kreisläuferinnen wieder sichtbar

Die Anwesenheitsliste gruppiert nach primärer Angriffsposition. Nach der Umbenennung des Kreisläufer-Codes `KR → KS` (Mannschaftsverwaltung, 03.06.) fielen Spielerinnen mit Code `KS` aus der fest verdrahteten Gruppen-Reihenfolge `['TW',…,'KR','NONE']` heraus und wurden **still verworfen**. Zwei Korrekturen:
- `_awCanonPos` führt `KR`/`KS` zusammen → Kreisläuferinnen erscheinen unabhängig vom gespeicherten Code unter „▲ Kreisläufer".
- Die Gruppen-Reihenfolge ist jetzt **dynamisch**: unbekannte/neue Positions-Codes landen in einer Auffanggruppe am Ende statt zu verschwinden. Dieser Fehlertyp kann damit nicht mehr auftreten.

#### 2. Anwesenheit: Sortier-Umschalter

Neue Leiste über der Liste: **Position · Nummer · Name**; bei „Name" zusätzlich **Vorname / Nachname** (Nachname = letztes Namenswort). Position = gewohnte Positionsgruppierung; Nummer/Name = flache, durchsortierte Liste (Gäste + Inaktive werden mitsortiert). Wechsel rendert nur neu (`_awRerender`) ohne DB-Reload → ungespeicherte Status bleiben erhalten. State: `awSortMode` (`position`/`nummer`/`name`), `awNameSort` (`vorname`/`nachname`); Helfer `_awSortList`, `_awNachname`, `_awNummerVal`; Setter `setAwSortMode`/`setAwNameSort`.

#### 3. Einheitlicher Kreisläufer-Code: KS (suite-weit)

Auf Wunsch „ein Code überall" wurde der Angriffs-Kreisläufer-Code auf **`KS`** vereinheitlicht, mit `KR`-Legacy-Fallback an allen Lesepfaden:
- `trainingsplaner.html`: `AW_ATTACK_ORDER`/`AW_POS_LABEL`/`_awCanonPos` auf `KS`; Badges zeigen Alt-`KR` als `KS`. Player-Picker `PP_POS_DEF` `KR → KS` inkl. Legacy-Lesefallback für gespeicherte Übungen (`positionen.KR → KS` in `setPlayerPickerValue`).
- `gegneranalyse.html`: `mapHbnPos` → `KS` (Eingänge `KR`/`KL`/`KM`/„Kreis…" bleiben akzeptiert), Positions-Dropdown/`POS_L`/`POS_F`/CSS-Klasse auf `KS`, neuer `canonPos`-Helfer normalisiert Alt-`KR` bei Anzeige, Editor-Vorbelegung und Speichern.
- `mannschaftsverwaltung.html`: bereits `KS` (Legacy-Map `KR→KS` via `migratePosCode` auf Lade- **und** Speicherpfad) — **keine Änderung**.
- `handball-bank-statistik.html`, `mannschaftsstatistik.html`, `spielerstatistik.html`: nutzen nur die grobe Rolle `FL`/`TH`, keinen Feinpositions-Code — **keine Änderung**.

#### 4. Migrationen (ausgeführt ✓ 12.06.2026)

```sql
UPDATE mannschaft_spieler SET angriff_pos = (
  SELECT jsonb_agg(CASE WHEN elem = '"KR"'::jsonb THEN '"KS"'::jsonb ELSE elem END)
  FROM jsonb_array_elements(angriff_pos) elem
) WHERE angriff_pos @> '["KR"]'::jsonb;

UPDATE gegner_spieler SET position='KS' WHERE position='KR';
```

#### Validierung

Beide Dateien: Inline-JS per `node --check` (OK), keine `<\/script>`-Artefakte, Script-/Div-Tag-Bilanz unverändert, Diff exakt auf die betroffenen Stellen begrenzt. Logiktests bestanden: `KR`+`KS` gruppieren gemeinsam unter Kreisläufer, unbekannter Code wird nicht mehr verworfen, Nummer-/Vorname-/Nachname-Sortierung korrekt; `mapHbnPos`/`canonPos` bilden korrekt auf `KS` ab.

---

## Änderungen – Session 09.06.2026 (Gegneranalyse: handball.net-Verknüpfung, Kader-Import & Mannschafts-Picker)

### `gegneranalyse.html` (v1.260609.2157 → v1.260609.2237)

Gegner können jetzt — genau wie eigene Mannschaften in `mannschaftsverwaltung.html` — direkt mit handball.net verknüpft werden. Spielplan/Ergebnisse und Kader werden daraus automatisch ausgelesen.

#### handball.net-Verknüpfung (Such-Picker)
- Mannschafts-Auswahl identisch zur Mannschaftsverwaltung: **Verein suchen → Verein wählen → Mannschaft wählen → Vorschau → verknüpfen** (`hbnGegnerSearch`, `renderGnClubs`, `hbnPickGnClub`, `renderGnTeams`, `hbnPickGnTeam`, `renderGnPreview`, `hbnLinkGegner`).
- Endpoints über `quick-service`: `clubs/search`, `clubs/{id}/teams`, `teams/{id}` (`requestType:'team'`), `teams/{id}/schedule` (`requestType:'schedule'`). Wrapper `hbnApi(path, requestType)` ruft das bestehende `hbnFetch` mit voller URL auf.
- Picker-Stile aus der Mannschaftsverwaltung übernommen (`.hbn-pick*`), Logo-Fix via `fixHbnLogo`.
- Beim Verknüpfen wird aus dem Team-Slug der kanonische iCal-Feed abgeleitet und in `gegner.hbn_ical_url` gespeichert (`{HBN_API_BASE}/calendar/team/{slug}.ics`). Liga wird aus dem Wettbewerb ergänzt, **nur falls leer**; Gegner-Name bleibt unangetastet.
- Status-Block bei vorhandener Verknüpfung mit „🔄 Ändern" und „✕ Lösen" (`renderHbnLinkUI`, `hbnShowPicker`, `hbnUnlinkGegner`). Bisheriges URL-Einfügen bleibt als einklappbarer Fallback erhalten (alle alten IDs unverändert: `hbn-ical-input`, `hbn-load-btn`, `hbn-save-url-btn`, `hbn-sync-btn`).
- Verknüpfungs-Badge in der Detail-Kopfzeile (🌐 handball.net verknüpft).

#### Spielplan/Ergebnisse (automatisch)
- Beim Öffnen des Statistik-Tabs lädt der Spielplan bei vorhandener Verknüpfung **still automatisch** (`loadHbnSaison(silent)` mit unterdrücktem Erfolgs-Toast).
- `resolveHbnTeamUrl(input)` akzeptiert Team-Seite (`…/mannschaften/{slug}`), Spielplan, sportdata- oder iCal-URL und liefert `{slug, tournamentSeason, ical}`. `loadHbnSaison` nutzt ihn vor `parseHbnGameFeed`.

#### Kader-Import (Schlüsselspieler-Tab)
- Button „🌐 Kader aus handball.net" (`openHbnRosterImport`): zieht den Spielplan, nimmt die letzten (bevorzugt gespielten) **bis zu 4 Spiele**, lädt je Spiel die Aufstellung (`requestType:'roster'` auf `…/aufstellung`), erkennt die Gegner-Seite über `heim_slug`/`gast_slug` (Fallback Namensabgleich) und aggregiert den Kader.
- Abgleich-Modal `hbn-roster-modal`: 🆕 neu (vorausgewählt) / ✏️ bekannt-aktualisierbar (Nr./Position, standardmäßig nicht angehakt) / unverändert. Insert/Update in `gegner_spieler`.
- Positions-Mapping auf DHB-Codes (`mapHbnPos`); unbekannt → leer statt falsch. N.N.-Platzhalter werden gefiltert (`isNNName`), Dedup über umlaut-normalisierte Namen (`_normName`).

#### Technik & Konventionen
- **Keine SQL-Migration nötig** — verwendet die bereits vorhandene Spalte `gegner.hbn_ical_url`.
- Slug = handball.net-Team-`id` (z. B. `handball4all.ol-…`), konsistent zu `calendar/team/{slug}.ics` und `teams/{slug}/schedule`.
- iCal-Feed bewusst **ohne** `tournamentSeason` gespeichert → Spielplan/Kader folgen automatisch der aktuellen Saison.
- `node --check` grün, div/script-Tags ausbalanciert (416/416), 5 Modal-Overlays, alle IDs eindeutig. Nur die betroffenen Stellen geändert, übrige Logik unangetastet.

> **Nachtrag 12.06.:** Das Positions-Mapping `mapHbnPos` lieferte hier noch `KR`; am 12.06. suite-weit auf `KS` vereinheitlicht (siehe Eintrag oben).

---

## Änderungen – Session 09.06.2026 (Gegneranalyse: handball.net-JSON für Spielplan & Bilanz)

### `gegneranalyse.html` (v1.260516.1600 → v1.260609.2157)

#### Überblick

Letztes Modul von iCal auf die handball.net-sportdata-JSON-API umgestellt (über `quick-service`). Damit nutzt **kein** Modul mehr iCal als primäre handball.net-Quelle.

#### 1. handball.net-Spielplan des Gegners (`loadHbnSaison`)

- Primär JSON-`schedule`: aus der gespeicherten Feed-URL werden per neuem `parseHbnGameFeed` Slug + `tournamentSeason` extrahiert und `teams/{slug}/schedule?tournamentSeason=…` über `hbnFetch(HBN_API_BASE+path,'schedule')` geladen. Konstante `HBN_API_BASE='https://www.handball.net/a/sportdata/1'` ergänzt.
- Neuer Helfer `mapScheduleGame`: `mapHbnSummary` → internes Spielformat (`datum` `YYYY-MM-DD`, abgeleitete `uhrzeit`, `heim`/`gast`, `score_home`/`score_away`, `status`, `ort`, `url`).
- Neuer Helfer `berlinDateTime(ms)`: ms-Timestamp → Datum/Uhrzeit über `Intl` mit `Europe/Berlin` (DST-bewusst, `sv-SE`-Locale).
- iCal bleibt **Fallback** (Parse-/Netzfehler → `requestType:'ical'`, nur Termine).
- Eigene DB-Scores (Bank-Statistik) ergänzen nur noch dort, wo handball.net (noch) kein Ergebnis liefert → JSON hat Vorrang.

#### 2. Darstellung

- Saisonbilanz jetzt aus **Gegner-Sicht**: grün = Sieg des Gegners, rot = Niederlage. KPI-Labels „Siege Gegner" / „Niederl. Gegner" + „Unentsch." (nur wenn vorhanden).
- „Gespielt/Ausstehend" richtet sich nach vorhandenem Ergebnis statt nur nach Datum; Live-Spiele mit 🔴 markiert.
- **🔄 Sync funktioniert jetzt real**: `_hbnGames` wird befüllt (war zuvor nie gesetzt) und der Button bei vorhandenen Ergebnissen eingeblendet → handball.net-Ergebnisse eigener Spiele in die `spiele`-Tabelle übertragbar. `syncHbnErgebnisse` und `saveHbnIcalUrl` blieben unverändert.
- Hint-/Platzhalter-Texte vom iCal-Wortlaut auf „Spielplan-Feed" aktualisiert.

#### Validierung

Inline-Script per `node --check` (OK); genau ein `</script>`, kein `<\/script>`-Artefakt; Diff nur in Version, HTML-Texten, `HBN_API_BASE`, `loadStatistikTab`-Hints und `loadHbnSaison`; Helfer per Node-Test gegen realistische Daten geprüft (Feed-Parsing, DST Sommer/Winter, Mapping, Gegner-Perspektive).

---

## Änderungen – Session 09.06.2026 (Mannschaftsstatistik: synchronisierte Saison + Bilanz-Anreicherung aus handball.net-JSON)

### `mannschaftsstatistik.html` (v1.260609.1051)

#### Überblick

Die Mannschaftsstatistik nutzt **kein iCal/handball.net-Scraping** – sie rechnet aus Supabase (`spiele`, `spielaktionen`, `spieler_lineup`, `einheiten`). Zwei Verbesserungen: (1) der bisher **lokale** Saison-Picker wird auf die gemeinsame `profiles.aktive_saison_id` umgestellt (geräte-/seitenübergreifend wie Kalender/Trainingsplaner), und (2) die Saisonbilanz wird mit **echten Ergebnissen aus handball.net-JSON** angereichert (für Spiele ohne lokal erfasstes Ergebnis).

#### 1. Synchronisierte Saisonauswahl

`loadSaisons` liest zusätzlich `profiles.aktive_saison_id` und wählt sie beim Laden vor; ohne gespeicherten Wert = Default die Saison, deren Zeitraum heute enthält (sonst neueste), und persistiert diese. `setSaison` schreibt eine konkrete Saisonwahl in die gemeinsame Spalte. **„📅 Alle Saisons" bleibt erhalten als bewusst lokale Ansicht** – sie schreibt nicht in die Spalte und setzt damit die globale Saison anderer Module nicht zurück. Graceful Fallback, falls Spalte nicht migriert. (Default ändert sich dadurch von „Alle Saisons" auf „aktuelle Saison".)

#### 2. Bilanz-Anreicherung aus handball.net-JSON

Neuer schlanker Block: `HBN_API_BASE`, `hbnApi(path)` (POST an `quick-service`, requestType `schedule`), `parseHbnGameFeed`, `feedYear`, `activeSaisonYear`, `hbnLocalDate`, `fetchHbnResults()`. `initMyTeam` lädt jetzt `hbn_team_id` mit. `fetchHbnResults` ermittelt die `tournamentSeasons` aus den Spiel-Feeds des Teams (`mannschaft_kalender`, typ spiele/pokal/sonstige), gekoppelt ans Jahr der aktiven Saison, und baut eine Map `datum → {score_home,score_away,status}` – **nur eigene Spiele** (`heim_slug`/`gast_slug === hbn_team_id`), nur mit Ergebnis. In `loadTeamData` werden Spiele **ohne lokales Ergebnis** über das **Datum** gematcht und mit dem realen Stand/Status nachgezogen (Flag `_fromHbn`); lokal erfasste Ergebnisse haben Vorrang. Anzeige: dezentes 🌐 am Score in der Spiele-Tabelle. Ergebnis-Map gecacht per `${teamId}|${jahr}` (Reset bei Teamwechsel). Ohne `hbn_team_id` oder bei JSON-Fehler: kein Effekt (graceful).

#### Erforderliche Migration

Geteilte Spalte mit Kalender/Trainingsplaner – falls dort schon ausgeführt, hier nichts mehr zu tun:

```sql
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS aktive_saison_id uuid REFERENCES saisons(id) ON DELETE SET NULL;
```

#### Validierung

Inline-Script per `node --check` (OK), Diff gegen Vorversion verifiziert (nur Version, Saison-Logik, handball.net-Block, Bilanz-Loop, 🌐-Marker), Script-Tag-Balance ok, kein `<\/script>`-Artefakt. JSON-Form gegen `parseHbnSchedule`/`mapHbnSummary` der `quick-service` abgeglichen (Match per Datum + Slug, namensunabhängig).

---

## Änderungen – Session 09.06.2026 (Bank-Statistik: handball.net-JSON für Spielplan, Aufstellung & Live)

### `handball-bank-statistik.html` (v5.260609.1034)

#### Überblick

Die Bank-Statistik bezieht handball.net-Daten jetzt **primär über die sportdata-JSON-Endpunkte** (`schedule` für Spielpläne, `combined` für Aufstellung + Live-Ticker) statt über iCal-/HTML-Scraping — genauere Daten (Ergebnisse, DST-korrekte Zeiten, strukturierte Strafen) und bessere Live-Verknüpfung. **Rein chirurgisch in der Fetch-Schicht:** kein Konsument, Aufrufer oder Render-/Matching-Pfad wurde angefasst.

#### Umbau (nur `hbnFetch`)

Die bisherige `hbnFetch` heißt jetzt `hbnRaw` (unverändertes Original-Scraping) und dient als Fallback. Das neue `hbnFetch` ist ein **JSON-primärer Dispatcher** mit Adaptern, die die JSON-Antworten **exakt** auf die alten Antwortformen abbilden:
- **`'ical'` → `teams/{slug}/schedule`** via `adaptScheduleToIcal` → `{games:[{datum,uhrzeit,heim,gast,ort,uid,url,baseUrl, +score_home/score_away/status}]}`. Zeiten jetzt **DST-korrekt** (vorher fester +1h-Offset im iCal-Parser → im Sommer falsch). Slug + `tournamentSeason` aus den Feed-URLs (`hbnIcalTeam`, Kalender-Stil).
- **`'match'` → `games/{id}/combined`** via `adaptCombinedToMatch` → `{heim,gast,datum,uhrzeit,ort, heimRoster/gastRoster[{nummer,name,pos:'FL',hbn_id}], parseMethod:'sportdata-json', score_home/score_away/status, ticker[{minute,playerName,score}]}`. (JSON liefert keine Position → `pos:'FL'`, TW wie gehabt über `enrichLineupFromKader`.)
- **`'ticker'` → `games/{id}/combined`** via `adaptCombinedToTicker` → `{status,score_home,score_away,heim,gast,lastMinute, events[]}`. Die Events kommen aus der Edge Function bereits in der erwarteten Form (`type/team/teamName/playerName/playerNum/minute`), inkl. **Strafen als strukturierte `2min`/`rot`-Events** statt des alten HTML-`<li>`-Hacks; `_debugRawSusp` daher leer.

Spiel-ID aus `…/spiele/{id}/…` über `hbnGameId`; Konstante `HBN_API_BASE`; JSON-Aufruf über `hbnJson(path,requestType)`.

#### Robustheit / Fallback

Erkennt der Dispatcher keinen handball.net-Slug bzw. keine Spiel-ID (z.B. nicht-handball.net-Feed, alte `/ical/team/{num}`-Manuell-URL) **oder** schlägt der JSON-Abruf fehl (try/catch), fällt er automatisch auf `hbnRaw` (Original-Scraping) zurück — kein Funktionsverlust. Alle 8 `hbnFetch`-Aufrufstellen und sämtliche Konsumenten (`loadIcalIntoModal`, `loadAllTeamFeeds`, `renderIcalMain`, `loadMatchIntoModal`/`renderTeamSelection`/`applyRoster`, `fetchTickerSync`, `autoImportTickerActions`, `syncTimerFromTicker`, Wizard) bleiben unverändert.

#### Validierung

Inline-Script per `node --check` (OK), Diff gegen die hochgeladene Vorversion verifiziert (nur Version + `hbnFetch`-Block), Script-Tag-Balance ok, kein `<\/script>`-Artefakt. JSON-Formen 1:1 gegen die `quick-service`-Normalizer (`mapHbnSummary`/`parseHbnSchedule`/`mapHbnLineup`/`parseHbnCombined`) abgeglichen.

#### Offen

- Test mit echtem Spiel empfohlen (Spielplan-Zeiten, Wizard-Aufstellung, Live-Import). Konsole zeigt dann `parseMethod: sportdata-json`.

---

## Änderungen – Session 09.06.2026 (Trainingsplaner: handball.net-JSON-Spielplan + synchronisierte Saisonauswahl)

### `trainingsplaner.html` (v1.260609.1015)

#### Überblick

Der Trainingsplaner übernimmt die **identische Mechanik aus `kalender.html`** (gleiche Funktionsnamen, gleiche Feldlogik): Spiele kommen jetzt **primär per handball.net-JSON** (`schedule` über `quick-service`) statt über iCal-/CORS-Proxys – inkl. Ergebnis/Live/Status an den Events. iCal ist nur noch Fallback. Dazu die **globale, geräteübergreifend gespeicherte Saisonauswahl** über `profiles.aktive_saison_id`, an die handball.net-Wettbewerbe (übers Jahr) und Trainings-/iCal-Feeds (über den Datumsbereich) gekoppelt sind. **Training läuft unverändert über iCal.**

#### 1. JSON-Spielplan primär, iCal nur Fallback

Neue Helfer (1:1 aus dem Kalender, an die Trainingsplaner-Helfer wie `icalDateStr` angepasst): `hbnApi(path,requestType)`, `parseHbnGameFeed(url)`, `hbnScheduleEvents(team,feed,hbn)` (mappt `schedule`-Spiele in Event-Objekte gleicher Form wie iCal **plus** `score_home`/`score_away`/`hbn_status`/`hbn_id`/`heim_slug`/`gast_slug`). Konstanten `HBN_EDGE_FN` (= `quick-service`) und `HBN_API_BASE`. In `refreshAllFeeds` umgebaut:
- **Team-getrieben:** hat eine Mannschaft `hbn_team_id`, werden ihre Spiele ausschließlich per JSON geladen – je verknüpftem `tournamentSeason` ein Abruf (gefiltert auf das Saison-Jahr).
- **iCal-Spielfeeds verknüpfter Teams werden übersprungen** (kein Doppel, keine ergebnislosen Einträge); der per-Feed-JSON-Pfad greift nur für **unverknüpfte** Teams als Fallback (ebenfalls saison-gekoppelt).
- Training-/sonstige iCal-Feeds laufen weiter über die CORS-Proxys, jetzt aber auf den aktiven Saison-Zeitraum gefiltert.

Die Spielanzeige im Kalender-Grid/Monatsliste bleibt vorerst „🏆 …" ohne Endstand-Badge; die JSON-Felder liegen an den Events bereit, falls später eine Ergebnis-/Live-Anzeige wie im Kalender gewünscht wird. Kalender-Legende: „Spiel"-Eintrag jetzt auch für `hbn_team_id`-verknüpfte Teams (vorher nur bei `ical_spiele`).

#### 2. Synchronisierte Saisonauswahl (global, geräteübergreifend)

Liest/schreibt dieselbe Spalte `profiles.aktive_saison_id` wie der Kalender. Funktionen `loadSaisons`, `renderSeasonSelect` (IDs `tp-season`/`tp-season-wrap`), `setActiveSeason` (persistiert + `refreshAllFeeds` + springt ggf. auf den Saison-Zeitraum), `activeSaisonYear`, `feedYear`, `activeSaisonRange`/`inActiveSeasonRange`. Default = die Saison, deren Zeitraum **heute** enthält (sonst neueste). „🏆 Saison"-Dropdown im Kalender-Header links vom Sync-Button (eigene CSS-Klassen `tp-season-*` mit den Trainingsplaner-Tokens), automatisch ausgeblendet ohne `saisons`-Einträge. Eingehängt in `onAuthSuccess` nach `reloadMannschaften` (vor `refreshAllFeeds`). Graceful Fallback, falls Spalte noch nicht migriert.

#### Erforderliche Migration

Geteilte Spalte mit dem Kalender – falls dort bereits ausgeführt, hier nichts mehr zu tun:

```sql
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS aktive_saison_id uuid REFERENCES saisons(id) ON DELETE SET NULL;
```

#### Validierung

Inline-Script per `node --check` geprüft (OK), Diff gegen die hochgeladene Vorversion verifiziert (nur beabsichtigte Stellen, keine fremde Funktionalität berührt), Script-Tag-Balance geprüft, kein `<\/script>`-Artefakt. iCal-Parser des Trainingsplaners bewusst unangetastet gelassen (naive Lokalzeit – für Berlin/HTN unkritisch); TZID-bewusster Parser des Kalenders bei Bedarf nachziehbar.

#### Offen / Nächster Schritt

- Optional: Ergebnis-/Live-Badge im Trainingsplaner-Kalender (Felder liegen bereit).
- Weiter offen: dieselbe Saison-Mechanik in die übrigen Statistik-Seiten einbauen; weitere Konsumenten-Module von iCal auf JSON-`schedule`/`combined` umstellen.

---

## Änderungen – Session 08.06.2026 (Kalender: handball.net-JSON-Migration, Ergebnisse, synchronisierte Saisonauswahl)

### `kalender.html` (v1.260608.1946)

#### Überblick

Der Kalender bezieht Spiele jetzt **primär per handball.net-JSON** (über `quick-service`) statt über öffentliche CORS-Proxys – damit inklusive **Ergebnissen, Live-Stand und Status**. iCal dient nur noch als Fallback. Dazu eine **globale, geräteübergreifend gespeicherte Saisonauswahl**, an die sowohl die handball.net-Wettbewerbe als auch die Trainings-/iCal-Feeds gekoppelt sind (lädt nur die aktive Saison → schneller, keine Alt-Saison-Termine).

#### 1. JSON-Spielplan primär, iCal nur Fallback

Neue Helfer in `kalender.html`: `hbnApi(path,requestType)` (POST an `quick-service` mit Bearer-Token), `parseHbnGameFeed(url)` (erkennt `…/calendar/team/{slug}.ics?tournamentSeason=` → `{slug,tournamentSeason}`), `hbnScheduleEvents(team,feed,hbn)` (mappt `schedule`-Spiele in Event-Objekte gleicher Form wie iCal **plus** `score_home`/`score_away`/`hbn_status`/`hbn_id`). In `syncFeeds`:
- **Team-getrieben:** hat eine Mannschaft `hbn_team_id`, werden ihre Spiele ausschließlich per JSON geladen – je verknüpftem `tournamentSeason` ein Abruf. Heim/Gast-Zuordnung über `heim_slug`/`gast_slug`.
- iCal-Spielfeeds desselben (verknüpften) Teams werden übersprungen; der per-Feed-JSON-Pfad greift nur noch für **unverknüpfte** Teams als Fallback.
- Training-/sonstige iCal-Feeds laufen unverändert über die CORS-Proxys.

Anzeige (Grid + Monatsliste): gespielte Partien zeigen den Endstand (grün) statt der Uhrzeit, laufende ein 🔴 mit Live-Stand. Auch Spiele **mit** Supabase-Eintrag ziehen den Stand aus den handball.net-Daten (die `spiele`-Tabelle speichert keinen Spielstand). Das „Statistik anlegen"-Modal zeigt das Ergebnis. Pokal-Feeds werden jetzt korrekt als Spiele behandelt.

#### 2. Synchronisierte Saisonauswahl (global, geräteübergreifend)

Aktive Saison liegt in `profiles.aktive_saison_id` (→ alle Seiten lesen/schreiben dieselbe Spalte; Sync-Punkt für künftige Module). Im Kalender-Header ein hervorgehobenes Dropdown „🏆 Saison" (aus der `saisons`-Tabelle). Funktionen `loadSaisons` (liest profiles, baut Saison-Datumsbereiche: Start = `end_date` der Vorsaison), `renderSeasonPicker`, `setActiveSeason` (persistiert + lädt neu + springt ggf. auf den Saison-Zeitraum), `activeSaisonYear`, `feedYear`, `activeSaisonRange`/`inActiveSeasonRange`. **Default = die Saison, deren Zeitraum heute enthält** (sonst neueste). Graceful Fallback, falls Spalte noch nicht migriert.

#### 3. Kopplung der Feeds an die aktive Saison (Speed-up)

- **handball.net-Wettbewerbe:** nur Wettbewerbe, deren Jahr (aus dem Feed-Namen, z.B. „… (Hallenrunde 2025/2026)" → 2026) zum `saisons.end_date`-Jahr der aktiven Saison passt, werden geladen.
- **Trainings-/iCal-Feeds (Sportmember, SpielerPlus etc.):** ohne Saisonbezug → werden über den **Datumsbereich** der aktiven Saison gefiltert (`inActiveSeasonRange`). Alt-Saison-Trainings landen nicht mehr im Kalender. Log zeigt „X/Y Events (Saison)".

#### Erforderliche Migration

```sql
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS aktive_saison_id uuid REFERENCES saisons(id) ON DELETE SET NULL;
```

#### Validierung

Jeder `str_replace` mit `node --check` auf extrahiertem Inline-Script geprüft. Live gegen Team `handball4all.ol-hamburg-schleswig-holstein.1343861` (Meine Damen) getestet: 7 Feeds, Ergebnisse korrekt; Saisonfilter reduziert „Trainingsplan 170 → X Events".

#### Offen / zur Klärung

- **Behoben in dieser Session:** Default landete zuvor auf der spätesten (leeren) Saison → per-Feed-Fallback umging den Filter und lud alle Wettbewerbe. Jetzt Default = aktuelle Saison + Fallback gatet auf `hbn_team_id`.
- Saison-Kopplung hängt an `saisons.end_date`. Liegt ein `end_date` in der Vergangenheit, fällt „heute" in die Folgesaison → ggf. manuell wählen.
- **Nächster Schritt:** dieselbe `profiles.aktive_saison_id`-Mechanik in Statistik- und Trainingsplaner-Seiten einbauen (überall synchron). Konsumenten-Module weiter von iCal auf JSON-`schedule`/`combined` umstellen.

---

## Änderungen – Session 07.–08.06.2026 (handball.net-Integration: Anlage, Saisons/Wettbewerbe, Kader-Import, Nachverknüpfung)

### `mannschaftsverwaltung.html` (v1.260608.0852) · `quick-service.ts` (Edge Function, erweitert)

#### Überblick

Vollständige Anbindung der internen handball.net-**sportdata-JSON-API** (`https://www.handball.net/a/sportdata/1`). Mannschaften lassen sich jetzt direkt aus handball.net anlegen (Vereins-/Mannschaftssuche), je Saison/Wettbewerb werden gefilterte Spielplan-Feeds erzeugt, der Kader wird über **alle Spiele** einer Saison aus den Aufstellungen zusammengesetzt, und bestehende Mannschaften können nachträglich verknüpft werden. Die API ist unauthentifiziert, liefert aber **keinen CORS-Header** → alle Aufrufe laufen über die `quick-service`-Edge-Function als Proxy.

#### 1. `quick-service.ts` – JSON-Endpunkte (additiv, bestehende HTML/iCal/Ticker-Logik unberührt)

Neues `SPORTDATA_TYPES`-Set (`schedule`, `combined`, `lineup`, `table`, `game`, `team`, `sportdata`). Früher Early-Return-Zweig: bei diesen requestTypes wird die JSON-URL mit `Accept: application/json` geholt, normalisiert und zurückgegeben. Normalizer: `fixLogo` (`handball-net:` → `https://www.handball.net/`), `mapHbnSummary`, `extractHbnSeasons`, `parseHbnSchedule`, `parseHbnTable`, `mapHbnLineup`/`parseHbnLineup`, `parseHbnTeam`, `parseHbnCombined`. `sportdata` = roher JSON-Durchlass (für `clubs/search` und `clubs/{id}/teams`). **Muss neu deployt werden.**

#### 2. Mannschaft aus handball.net anlegen

Team-Modal mit Modus-Umschalter **🌐 handball.net / ✏️ Manuell**. Ablauf: Vereinssuche (entprellt) → Verein wählen → Mannschaft wählen → Vorschau mit Logo/Verein/anpassbarem Namen. Beim Anlegen werden `hbn_team_id` (der handball.net-Slug) und `logo_url` gespeichert. Funktionen: `hbnApi`, `hbnTeamSearch`, `renderHbnClubs`/`hbnPickClub`, `renderHbnTeams`/`hbnPickTeam`, `renderHbnPreview`, `hbnCreateTeam`, `setTeamMode`. Auswahl über index-basierte `onclick` (kein JSON in Attributen).

#### 3. Saisons & Wettbewerbe – Mehrfachauswahl, ein Feed je Kombination

Der team-iCal liefert ohne Parameter nur den aktuellen Hauptwettbewerb; **verifiziert**, dass `?tournamentSeason={facetId}` exakt einen Wettbewerb + eine Saison filtert. Helfer `_hbnSplitFacet` (trennt „Wettbewerb (Saison)"), `hbnFacetIcsUrl`, `hbnFacetTyp` (Pokal→`pokal`, sonst `spiele`), `hbnFacetCheckboxesHtml` (nach Saison gruppiert, neueste zuerst, aktuelle Saison vorausgewählt, bereits verknüpfte deaktiviert), `hbnCreateFeedsFromContainer`. Pro angehaktem `tournamentSeason` wird ein `mannschaft_kalender`-Eintrag mit `?tournamentSeason=`-URL angelegt. Im **Feeds-Tab** Button **🌐 handball.net-Wettbewerb** (nur bei verknüpften Teams) → Modal `hbn-comp-modal` (`openHbnCompModal`/`hbnAddCompFeeds`) zum Nachziehen neuer Saisons.

#### 4. Kader-Import über alle Spiele einer Saison

Im **Kader-Tab** (Button 🌐 handball.net) bei verknüpften Teams „**Über Saison zusammenstellen**": `toggleHbnImport` (jetzt async) lädt die Wettbewerbs-Facets, `hbnRosterFromSeason()` holt den Spielplan je gewähltem `tournamentSeason`, dedupliziert Spiele über die Spiel-ID, filtert auf gespielte Partien (`beendet`/`live`) und holt jede Aufstellung über `games/{id}/lineup` (4 parallele Worker, Fortschrittsanzeige). Die **eigene** Seite wird per `heim_slug`/`gast_slug === slug` bestimmt; Spielerinnen werden über die stabile handball.net-Spieler-ID aggregiert (häufigste Rückennummer, Einsatzzähler, vollständigster Name). Ergebnis fließt in die bestehende Abgleich-UI (`renderHbnDiff`/`hbnImportSelected` – vorhanden/ähnlich/neu). Einzelspiel-URL-Methode (`hbnLoadRoster`) bleibt als Fallback.

#### 5. Bestehende Mannschaft nachträglich verknüpfen

In der Detailansicht Button **🌐 Verknüpfen** (nur Eigentümer, nur solange `hbn_team_id` leer). `linkExistingTeam(tid)` öffnet das Team-Modal im reinen handball.net-Suchmodus (`tmLinkId`-State, Modus-Tabs ausgeblendet); `renderHbnPreview` verzweigt in den Link-Modus (statt Namensfeld ein Hinweis, Button „🔗 Verknüpfen & Feeds anlegen"). `hbnLinkExisting()` schreibt `hbn_team_id` (+ Logo/Verein nur falls leer) per Update an die bestehende Mannschaft und legt die gewählten Feeds an. Danach sind Feeds- und Kader-Funktionen automatisch verfügbar. Bricht mit Hinweis ab, falls die Spalte `hbn_team_id` fehlt (kein stiller Fehlschlag).

#### Erforderliche Migration

```sql
ALTER TABLE mannschaften ADD COLUMN IF NOT EXISTS hbn_team_id text;
```
(`logo_url` bereits aus früheren Sessions migriert.) Optionale Spalten mit graceful Fallback + Konsolenwarnung.

#### Validierung

- `quick-service.ts`: esbuild-Transpile sauber + Funktionsasserts gegen echte Fixtures
- `mannschaftsverwaltung.html`: jeder `str_replace` mit `node --check` auf extrahiertem Inline-Script geprüft; Diff je Auslieferung gegen Vorversion verifiziert (nur handball.net-Stellen + Version berührt)
- Reale Test-Endpunkte am Team-Slug `handball4all.ol-hamburg-schleswig-holstein.1343861` (HT Norderstedt 1. Damen) abgeglichen

#### Offen / zur Klärung

- **Deploy nötig:** aktualisierte `quick-service`-Edge-Function (JSON-requestTypes) muss deployt sein, sonst greifen Such-/Import-Funktionen nicht.
- **Torhüter-Erkennung:** die Aufstellungs-JSON liefert keine Position (`position` immer `null`) → importierte Spielerinnen werden als Feldspieler angelegt, TW manuell umstellen.
- **Mehrere aktive Spiele-Feeds je Team** (mehrere Saisons verknüpft): Verhalten in der Bank-Statistik prüfen (ggf. nur aktuelle Saison aktiv lassen).
- **Annahme:** JSON-`schedule` akzeptiert `?tournamentSeason=` wie die (verifizierte) iCal — sehr wahrscheinlich (gleiche Filter-Facets); Kader bleibt auch bei ignoriertem Filter korrekt (Dedup über Spieler-ID).
- **Konsumenten-Module:** alle handball.net-Konsumenten auf JSON-`schedule`/`combined` über `quick-service` umgestellt (`kalender.html`, `trainingsplaner.html`, `handball-bank-statistik.html`, `gegneranalyse.html`); iCal nur noch als Fallback. `mannschaftsstatistik.html` rechnet aus Supabase + JSON-Anreicherung.

---

## Änderungen – Session 04.06.2026 (Trainingsplaner: Anwesenheit — Aktiv/Inaktiv, Gäste, Einzel-Aktivierung)

### `trainingsplaner.html` (v1.260604.0922) · `spielerstatistik.html` (v1.260604.0927)

#### Überblick

Drei Erweiterungen des Anwesenheits-Tabs im Trainingsplaner: Aktive und inaktive Kaderspielerinnen sind jetzt getrennt, inaktive Spielerinnen können einmalig für eine Einheit aktiviert werden, und Gastspieler aus anderen Vereinsmannschaften lassen sich zur Einheit hinzufügen – ihre Anwesenheit zählt dabei in der Statistik **ihrer eigenen Mannschaft**. Dafür wurde auch `spielerstatistik.html` erweitert (Gast-Counting + Sidebar-Versionspflege).

#### 1. Aktiv/Inaktiv-Trennung

`_awPlayerStatus(p)` / `_awIsAktiv(p)` — identische Logik wie in `mannschaftsverwaltung.html` und `spielerstatistik.html`. Neue Helfer in `trainingsplaner.html`:
- **`_awParticipates(p)`** — true für aktive Spielerinnen und für einmalig aktivierte inaktive.
- Aktive Kaderspielerinnen → bestehende DHB-Positionsgruppen, zählen in Stats.
- Beendete / inaktive → eigene Gruppe „⏸️ Inaktiv / Ehemalige" am Ende, **nicht** in der Statistik, **kein** Auto-Status. `setAllAnwesenheit` und `syncPlayerCountFromAnwesenheit` operieren nur auf Teilnehmenden + Gästen.

#### 2. Einzel-Aktivierung inaktiver Spielerinnen

State: `let awAktiviert = new Set()` (IDs inaktiver Kaderspielerinnen, die für diese Einheit aktiviert wurden). Jede inaktive Spielerin hat „+ Für diese Einheit" → `awActivateForSession(id)` holt sie in die aktive Liste, belegt Tagesstatus sinnvoll vor (Verletzung/Abwesenheit via `_awAutoStatus`). „− Einheit" → `awDeactivateForSession(id)` entfernt sie wieder. Marker-Chip „einmalig dabei" in der Zeile. Persistenz: `einmalig`-Flag im payload-Eintrag; beim Reload erkennt `loadAnwesenheit` gespeicherte inaktive Spielerinnen und befüllt `awAktiviert` entsprechend.

#### 3. Gastspieler

State: `let awGuests = []` — Gast-Objekte für diese Einheit: `{id, name, nummer, pos, angriff_pos, abwehr_pos, gast_mannschaft_id, gast_mannschaft_name}`. Neuer Button „➕ Gast" (Toolbar) öffnet `#aw-guest-modal`: andere Vereinsmannschaft wählen → Kader laden (mit Fallback, gecacht in `awgKaderCache`) → Spieler/innen ankreuzen → `awgAddSelected()`. Gäste erscheinen in der Gruppe „👤 Gäste" mit Heim-Mannschafts-Chip, Status-Toggle und „− Gast". `awRemoveGuest(id)` entfernt.

Payload in `saveAnwesenheit`: Teilnehmende-Kader (mit `einmalig`-Flag) **+** Gäste (mit `gast:true, gast_mannschaft_id, gast_mannschaft_name`). Nicht-aktivierte inaktive Spielerinnen werden **nicht** gespeichert.

#### 4. Gast-Anwesenheit in der Heimmannschaft (`spielerstatistik.html`)

`loadAttendance` fragt jetzt **alle** eigenen Einheiten im Saison-Zeitraum ab (zuvor nur per `group_name`-Filter). Client-seitige Partition:
- Eigene Session (`group_name === teamName`, kein `gast`-Flag) → reguläre Anwesenheit.
- Gast-Eintrag aus einer anderen Einheit (`rec.gast === true && rec.gast_mannschaft_id === _myTeamId`) → zählt als Anwesenheit in dieser Mannschaft, Sessionname erhält Vermerk „Gast bei …".
- `_activeWeeks` wird nur aus eigenen Sessions befüllt (Soll-Wochenzählung unverändert).

**Einschränkung:** Funktioniert zuverlässig, solange Host- und Heimmannschaft demselben Supabase-Nutzer gehören (RLS: jeder Trainer sieht nur seine eigenen `einheiten`). Für trainerübergreifendes Hochzählen wäre eine geteilte `gast_anwesenheit`-Tabelle mit eigenem RLS nötig (separate Session falls gewünscht).

#### 5. Resets & Kohärenz

`awGuests` und `awAktiviert` werden bei jedem Session-/Mannschaftswechsel zurückgesetzt (Tab-Reset, `awPickTeam`, `awSwitchTeamById`). `_awRerender()` als zentraler Re-Render-Helfer. Auto-Status nur noch für `_awParticipates`-Spielerinnen.

#### Validierung

- Beide `<script>`-Blöcke extrahiert, `node --check` → JS-Syntax OK
- `spielerstatistik.html`: Sidebar-Version (war auf `v1.260602.2115` stehen geblieben) ebenfalls nachgepflegt
- Diffs strikt auf Anwesenheits-Subsystem begrenzt; Planung, Übungsdatenbank, Statistik-Tabs unberührt
- Keine fehlerhaften `<\/script>`-Sequenzen

#### Offen / zur Klärung

- **Cross-Coach-Gäste:** Gasttraining bei einer Mannschaft eines anderen Trainers zählt dort nicht automatisch (RLS). Bei Bedarf: neue Tabelle `gast_anwesenheit` + RLS-Policy.

---

## Änderungen – Session 04.06.2026 (Spielerstatistik: Aktiv/Inaktiv-Tab in der Spielerliste)

### `spielerstatistik.html` (v1.260604.0912)

#### Überblick

Analog zur Mannschaftsverwaltung werden aktive und nicht mehr aktive Spielerinnen jetzt auch in der Spielerstatistik getrennt. Die linke Spielerliste hat eine eigene **Aktiv/Inaktiv**-Tab-Leiste; zusätzlich werden beendete/inaktive Spielerinnen aus dem Zusatzeinheit-Modal ausgeschlossen.

#### 1. Effektiver Aktiv-Status (identische Logik)

`playerStatus(p)` / `isPlayerAktiv(p)` wie in `mannschaftsverwaltung.html`: aktiv nur bei `aktiv === true` **und** (kein `aktiv_bis` ODER `aktiv_bis >= heute`); abgelaufenes `aktiv_bis` → `beendet`, Toggle aus → `inaktiv`.

#### 2. Tab-Leiste über der Spielerliste

Neue segmentierte Leiste **Aktiv (N) / Inaktiv (N)** (`#status-tabs`, gerendert von `renderStatusTabs()`), gesteuert über `setStatusFilter()` und den State `_statusFilter` (Default `aktiv`). Die linke Spalte ist dafür in einen `.player-col`-Wrapper gefasst (Grid-Layout 300px | 1fr bleibt unberührt).

- **Aktiv-Tab:** nur Spielerinnen mit effektivem Status `aktiv`.
- **Inaktiv-Tab:** `beendet` **und** `inaktiv`; jede Karte trägt einen Status-Chip (`.pc-status` — grau „Beendet" / rot „Inaktiv").
- Positionsfilter (Alle/Feld/Tor) und Gruppierung (Feld-/Torhüterinnen) wirken innerhalb beider Tabs weiter.
- Eigene Leer-Zustände: „Kein Kader" (gesamter Kader leer) bzw. „Keine aktiven/inaktiven Spielerinnen".

#### 3. Zusatzeinheit-Modal: nur aktive Spielerinnen

`openZusatzModal()` listet nur noch aktive Spielerinnen (`_players.filter(isPlayerAktiv)`); für beendete/inaktive werden keine Zusatzeinheiten mehr angeboten. Guard ergänzt: „Keine aktiven Spielerinnen im Kader". Die übrigen roster-bezogenen Werte (Team-Standard-Soll im Kopf) sind reine Eingabefelder ohne Aggregation über Spielerinnen → unverändert.

#### 4. Kader-Laden erweitert

`loadKaderWithGameStats()` selektiert zusätzlich `aktiv, aktiv_bis` — mit Fallback auf den Minimal-Select, falls die Spalten in einer Umgebung noch nicht migriert sind (dann gilt jede Spielerin als aktiv, `aktiv` wird beim Mapping auf `true` defaultet, wenn die Spalte fehlt).

#### Validierung

- Haupt-`<script>` extrahiert, `node --check` → JS-Syntax OK
- Diff strikt auf Status-/Listen-/Modal-Logik begrenzt; Stats-Aggregation pro Spielerin (Detail-Tabs) unberührt → keine Regression
- Keine fehlerhaften `<\/script>`-Sequenzen

---

## Änderungen – Session 04.06.2026 (Mannschaftsverwaltung: Inaktiv-Tab & effektiver Aktiv-Status)

### `mannschaftsverwaltung.html` (v1.260604.0848)

#### Überblick

Spieler, die nicht mehr aktiv sind, wurden bisher weiter im Kader geführt. Zudem gab es eine Inkonsistenz: Ein Spieler mit gesetztem, **bereits abgelaufenem** `aktiv_bis` zeigte zwar den „beendet"-Hinweis, das Status-Badge blieb aber trotzdem auf **Aktiv** stehen. Beides ist jetzt aufgelöst — der Status wird zentral berechnet und nicht mehr aktive Spieler wandern in einen eigenen Tab. Damit ist auch die offene Frage aus Session 01.06.2026 beantwortet: Der Aktiv-Schalter wird **nicht** automatisch umgelegt; stattdessen entscheidet eine berechnete Status-Logik über die Darstellung (datumsbasiert), der gespeicherte `aktiv`-Wert bleibt unangetastet.

#### 1. Zentraler effektiver Aktiv-Status (`playerStatus`)

Neue Hilfsfunktion bestimmt den tatsächlichen Status eines Spielers aus `aktiv` **und** `aktiv_bis`:

- **`inaktiv`** — `aktiv === false` (Toggle aus)
- **`beendet`** — `aktiv === true`, aber `aktiv_bis` liegt vor heute (Aktiv-Zeitraum abgelaufen)
- **`aktiv`** — Toggle an und (kein `aktiv_bis` ODER Datum noch nicht überschritten)

Abgeleitete Helfer: `isPlayerAktiv(p)` (`=== 'aktiv'`) und `statusBadge(p)` (rendert Aktiv/Beendet/Inaktiv-Badge). Damit ist der Bug behoben: ein Spieler mit abgelaufenem `aktiv_bis` zeigt jetzt das Badge **Beendet** statt fälschlich **Aktiv**.

#### 2. Eigener Tab „Inaktiv"

Die Tab-Leiste hat einen neuen Tab **Inaktiv** (zwischen Kader und Feeds, für Eigentümer wie geteilte Ansichten). Beide Tabs tragen einen Zähler-Pill (`.tab-count`):

- **Kader** zeigt nur noch Spieler mit effektivem Status `aktiv`. Fußzeile zählt entsprechend (`… Torhüter · … Feldspieler · … aktiv`).
- **Inaktiv** sammelt alle nicht mehr aktiven Spieler (`beendet` **oder** `inaktiv`), mit Info-Box und Aufschlüsselung `X beendet · Y deaktiviert · Z gesamt`. Über das ✏️-Symbol lässt sich ein Spieler wieder aktiv setzen.

Tab-Aufbau erfolgt jetzt über `renderDetailTabs()` (mit Zählern) **nach** dem Laden der Spieler. Nach jeder Spieler-Änderung (Speichern, Löschen, handball.net-Import) aktualisiert `refreshPlayerViews()` Zähler und aktiven Tab gemeinsam.

#### 3. Geteilte Spielerzeile

Die Tabellenzeile wurde in `playerRowHtml(p, owned)` ausgelagert und von Kader- wie Inaktiv-Tab identisch verwendet (kein Duplikat). Sortierung gemeinsam über `sortKader()`.

#### 4. Status-Meta-Chip angepasst

In `statusMetaChips` zeigt der `aktiv_bis`-Chip bei abgelaufenem Datum nur noch das Datum (⏳ `TT.MM.JJJJ`, grau) statt erneut „beendet" — den Status-Wortlaut übernimmt jetzt das **Beendet**-Badge, keine Doppelung. Zukünftige Daten bleiben als blauer `bis TT.MM.JJJJ`-Chip (signalisiert geplantes Ausscheiden bei weiterhin aktivem Spieler).

#### Validierung

- Haupt-`<script>` extrahiert, `node --check` → JS-Syntax OK
- Diff strikt auf die beabsichtigten Stellen begrenzt (Status-/Tab-Logik), keine fremde Funktionalität berührt, keine fehlerhaften `<\/script>`-Sequenzen
- Keine verbleibenden direkten `renderTabKader(...)`-Refresh-Aufrufe (durch `refreshPlayerViews()` ersetzt)

#### Offen / zur Klärung

- **Konsistenz Anwesenheit:** ✅ Vollständig umgesetzt — `spielerstatistik.html` (Aktiv/Inaktiv-Tab), `trainingsplaner.html` (Inaktiv-Gruppe, Einzel-Aktivierung, Gastspieler). `_awPlayerStatus`/`_awIsAktiv` in allen drei Modulen konsistent. Verbleibend: Cross-Coach-Gasttraining (getrennte Tabelle bei Bedarf, siehe Session-Eintrag oben).

---

## Änderungen – Session 03.06.2026 (Mannschaftsverwaltung: Abwehrpositionen pro System)

### `mannschaftsverwaltung.html` (v1.260603.0747)

#### Überblick

Abwehrpositionen werden jetzt **je Abwehrsystem getrennt** erfasst. Eine Spielerin kann im 5:1 hinten Mitte decken und im 4:2 innen, ohne dass sich die Auswahlen vermischen. Pro System bleibt die Klick-Reihenfolge die Priorität (1. = primär). Damit wird die Notiz aus Session 01.06.2026 („kein neues Datenmodell") bewusst abgelöst — der Abwehrsystem-Selektor ist nicht mehr nur Anzeige-Filter, sondern strukturiert die Daten.

#### 1. Datenmodell: `abwehr_pos` von flachem Array → Objekt je System

**Vorher:** flaches, systemunabhängiges Array (`["AL","HL"]`) — dadurch nicht trennbar, wo eine Spielerin in welchem System deckt.

**Nachher:** Objekt mit Abwehrsystem als Schlüssel, jeder Wert ein prioritätsgeordnetes Array:

```json
{ "6:0": ["AL"], "5:1": ["HM","HL"], "4:2": ["IL"] }
```

`angriff_pos` bleibt unverändert ein flaches Array (systemunabhängig).

**Legacy-Migration beim Laden (`_normAbwBySys`):** bestehende flache Arrays werden automatisch dem zuerst passenden System zugeordnet (`_systemForCodes`) — kein Datenverlust, keine DB-Migration der Altdaten nötig. Ungültige Codes/Systeme werden gefiltert; der Lese-Pfad versteht beide Formate.

#### 2. Modal: systemgetrennte Chip-Auswahl

- Status `pmAbwehr` (flaches Array) → **`pmAbwehrBySys`** (Objekt je System)
- `_curAbwArr()` liefert/legt das Positions-Array des aktuell im Dropdown gewählten Systems an
- `togglePmPos` und `renderPmChips` operieren auf dem System-Bucket; Dropdown-Wechsel tauscht nur die angezeigte Auswahl, andere Systeme bleiben erhalten
- Neuer Hinweis `_abwSummary()`: Zeile „Hinterlegt – …" zeigt alle bereits konfigurierten Systeme auf einen Blick, das aktive rot hervorgehoben
- Label-Zusatz „je System getrennt"; `onAbwehrSystemChange()` rendert neu statt zu mischen

#### 3. Kader-Tabelle: Anzeige pro System

`posCell` rendert die Abwehr als einen Chip pro System mit kleinem monospaced System-Präfix (`.pos-def-sys`), z. B. `6:0 ● AL` · `5:1 ● HM, HL`. Tooltip enthält die volle Prioritätsaufschlüsselung. Funktioniert via `_normAbwBySys` auch für Legacy-Altdaten.

#### 4. Speichern & Migration

- `savePlayer` schreibt `abwehr_pos` als aufgeräumtes Objekt (`_cleanAbwBySys` — nur Systeme mit gültigen Positionen); Torhüter → `{}`
- Migrations-Hinweis-SQL: Default für `abwehr_pos` von `'[]'::jsonb` → `'{}'::jsonb`

Optionaler DB-Default für Neuinstallationen (bestehende Spalten müssen **nicht** migriert werden, jsonb speichert beide Formate):

```sql
ALTER TABLE mannschaft_spieler ALTER COLUMN abwehr_pos SET DEFAULT '{}'::jsonb;
```

#### Validierung

- JS-Syntax via `node --check` sauber
- Logiktests bestanden: Legacy-Migration, Objekt-Erhalt, Filterung ungültiger Codes/Systeme, Vorauswahl erstes konfiguriertes System (`_firstConfiguredSystem`), Round-Trip pro System, Aufräumen leerer Buckets
- Diff auf die beabsichtigten Stellen begrenzt, keine verwaisten `pmAbwehr`-Referenzen
- Kompatibilität: `abwehr_pos`/`angriff_pos` werden von keinem anderen Modul gelesen → regressionssicher (die `abwehr_system`-Treffer in `gegneranalyse.html` betreffen das gegnerische System, ein anderes Konzept)

---

## Änderungen – Session 02.06.2026 (Trainingsplaner: Anwesenheit sichtbar + Langzeit-Status bearbeiten)

### `trainingsplaner.html` (v1.260602.1245)

#### Überblick

Der Anwesenheit-Tab zeigte beim Anklicken **gar nichts** an — weder Spielerliste noch Ladehinweis oder Mannschaftsauswahl. Ursache waren zwei unabhängige Bugs; zusätzlich kam eine funktionale Erweiterung (Langzeit-Status bearbeiten) hinzu.

#### Bugfix 1 (Hauptursache): Anwesenheits-Container war per CSS dauerhaft verborgen

**Ursache:** Der Container `#anwesenheit-view` hat im Stylesheet `display:none` als Default (`.aw-view{display:none}`). `showView()` schaltete ihn mit `awv.style.display = (…) ? '' : 'none'` sichtbar — der Wert `''` **entfernt** aber nur das Inline-Style und fällt damit auf die CSS-Regel `display:none` zurück. Der Bereich war also unabhängig vom Kader **immer** verborgen (erklärt auch die ursprüngliche Meldung „ich sehe die Spieler nicht").

**Fix:** Konkreten Anzeigewert setzen statt Leerstring:

```js
awv.style.display = (view==='planer' && sessionTab==='anwesenheit') ? 'block' : 'none';
```

Reiht sich in die bekannte Lernregel ein: *CSS `display:none` im Stylesheet gewinnt gegen `style.display=''` → explizit `'block'` setzen.*

#### Bugfix 2: Mannschaftsauflösung war nur namensbasiert

**Ursache:** `_resolveAwTeam()` suchte die Mannschaft ausschließlich über Namensabgleich (`sessionMeta.group` + `hbs_my_team`). Die Spielerstatistik nutzt dagegen die eindeutige `aktive_mannschaft_id`. Ohne passenden Gruppennamen und ohne gesetztes `hbs_my_team` fand der Trainingsplaner kein Team, während die Statistik korrekt lud (genau dieser Bruch in der namensbasierten Zuordnung war in Session 31.05.2026 bereits als möglicher Leer-Zustand vermerkt).

**Fix:** Auflösung prüft jetzt **zuerst die `aktive_mannschaft_id`** (eindeutiger ID-Abgleich), dann `aktive_mannschaft_name`, danach die bisherigen Namensregeln. Zusätzlich:
- **Mannschafts-Wähler** in der Statistik-Leiste (bei > 1 Team), ID-basiert (`awSwitchTeamById`) — eine falsche Auto-Zuordnung lässt sich direkt korrigieren.
- Team-Auswahl (Picker im Leerzustand + Switcher) setzt jetzt **alle** Schlüssel konsistent: `aktive_mannschaft_id`, `aktive_mannschaft_name`, `hbs_my_team`.

#### Feature: Langzeit-Status je Spielerin direkt im Trainingsplaner bearbeiten

Neben dem reinen Tages-Status (anwesend / abwesend / verletzt) lassen sich nun die **dauerhaften** Abwesenheiten und Verletzungen pflegen — dieselben Daten wie in der Mannschaftsverwaltung:

- **✏️-Button** pro Spielerzeile öffnet ein Modal (`#aw-player-modal`) mit denselben Feldern wie das Spieler-Modal der Mannschaftsverwaltung (Abwesenheiten: Von/Bis/Grund/Notiz; Verletzungen: Art/Von/Bis/Notiz; Datalist mit häufigen Verletzungsarten).
- Speichern schreibt direkt in `mannschaft_spieler.abwesenheiten` / `.verletzungen` — **dauerhaft**, kein einmaliger Eintrag für die Einheit.
- **Status-Chips** in der Liste (🤕 verletzt / 🏖️ abwesend / 📅 ab … / inaktiv) auf Basis des **Einheitsdatums** (Stichtag, sonst heute).
- **Auto-Vorbelegung:** Fällt das Einheitsdatum in eine offene Verletzung → `verletzt`, in eine aktive Abwesenheit → `abwesend`. Greift nur, solange für die Spielerin noch kein expliziter Status gesetzt/gespeichert ist; manuelle Werte bleiben erhalten.
- Statistik-Leiste zeigt zusätzlich den Stichtag (`Stichtag TT.MM.JJJJ`).

Portierte Helfer aus der Mannschaftsverwaltung: `fmtDateDE`, `_normEntryArr`, `_verletzungOffen`, `ABW_GRUENDE` / `ABW_GRUND_LABEL`. Neue Helfer: `_awSessionDate`, `_awAutoStatus`, `_awRecordChips`. Neue Modal-Logik: `openAwPlayerEdit`, `saveAwPlayerEdit`, `renderAwpeAbw/Verl`, `awpeAdd/Upd/Del*`.

#### Kader-Laden erweitert

`loadAnwesenheit()` lädt zusätzlich `abwesenheiten, verletzungen, aktiv, aktiv_bis` aus `mannschaft_spieler` — mit Fallback auf das Minimal-Select, falls diese Spalten in einer Umgebung noch nicht migriert sind (dann entfallen nur Chips + Auto-Vorbelegung).

#### Datenmodell / Migration

**Keine neue Migration nötig** — wiederverwendet die in Session 01.06.2026 angelegten Spalten (`abwesenheiten`, `verletzungen`, `aktiv_bis` auf `mannschaft_spieler`). Die Tages-Anwesenheit bleibt wie gehabt in `einheiten.anwesenheit` (jsonb).

---

## Änderungen – Session 01.06.2026 (Mannschaftsverwaltung: Aktiv-bis, Abwesenheiten & Verletzungen)

### `mannschaftsverwaltung.html` (v1.260601.1640)

#### Überblick

Der Kader kannte bisher nur den binären Status **Aktiv/Inaktiv**. Für die spätere Auswertung in der Spielerstatistik (Anwesenheit, Verfügbarkeit) fehlten drei Datendimensionen, die jetzt direkt im Spieler-Modal erfasst werden können: ein befristetes **Aktiv-bis-Datum**, beliebig viele **geplante Abwesenheiten** und **Verletzungen** mit Zeitraum. Die eigentliche statistische Auswertung erfolgt gesondert in einem späteren Schritt; diese Session liefert nur Datenerfassung + Datenmodell + leichte Sichtbarkeit in der Kadertabelle.

#### Datenmodell (neue Spalten `mannschaft_spieler`)

| Spalte | Typ | Inhalt |
|---|---|---|
| `aktiv_bis` | `date` (nullable) | Ab dem Folgetag nicht mehr in Anwesenheit. Leer = unbefristet. |
| `abwesenheiten` | `jsonb` Default `[]` | `[{von, bis, grund, notiz}]` |
| `verletzungen` | `jsonb` Default `[]` | `[{art, von, bis, notiz}]` |

Datumsformat durchgehend `YYYY-MM-DD`. `bis` leer = laufend (bei Verletzung: aktuell noch verletzt; bei Abwesenheit: offenes Ende).

**SQL-Migration (Supabase):**

```sql
ALTER TABLE mannschaft_spieler ADD COLUMN IF NOT EXISTS aktiv_bis date;
ALTER TABLE mannschaft_spieler ADD COLUMN IF NOT EXISTS abwesenheiten jsonb DEFAULT '[]'::jsonb;
ALTER TABLE mannschaft_spieler ADD COLUMN IF NOT EXISTS verletzungen jsonb DEFAULT '[]'::jsonb;
```

#### Feature: Aktiv bis

Optionales Datumsfeld `#pm-aktiv-bis` unter dem Aktiv-Schalter. Der Aktiv-Schalter selbst bleibt davon unberührt (datumsbasierte Filterung erfolgt später in der Statistik, **kein** Auto-Umschalten des Schalters). Hinweistext erklärt die Wirkung (z. B. Vereinswechsel zum Saisonende).

#### Feature: Abwesenheiten

Wiederholbare Eintragsliste (`#pm-abw-list`) mit „+ Abwesenheit". Felder je Eintrag: Von, Bis, **Grund** (Dropdown), Notiz. Gründe (`ABW_GRUENDE` / `ABW_GRUND_LABEL`): `urlaub`, `beruf`, `schule`, `krankheit` (keine Verletzung), `schwanger` (Schwangerschaft/Elternzeit), `persoenlich`, `sonstiges`.

#### Feature: Verletzungen

Wiederholbare Eintragsliste (`#pm-verl-list`) mit „+ Verletzung". Felder: **Art** (Freitext mit `<datalist id="verl-arten-list">`: Bänderdehnung, Bänderriss, Muskelfaserriss, Zerrung, Prellung, Sehnenentzündung, Kreuzbandriss, Meniskusverletzung, Schulterverletzung, Fingerverletzung, Gehirnerschütterung, Sonstiges), Von, Bis (Rückkehr), Notiz. Offene Verletzungen (kein/zukünftiges Bis-Datum) werden als Karte rot hervorgehoben (`.entry-card.injury-open`).

#### Implementierungsdetails

- Beide Abschnitte liegen **außerhalb** von `#pm-pos-detail` → gelten auch für Torhüter (TH).
- Arbeitskopien `pmAbwesenheiten` / `pmVerletzungen` analog zu `pmAngriff`/`pmAbwehr`. Render-/Add-/Update-/Delete-Funktionen: `renderAbwesenheiten`/`addAbw`/`updAbw`/`delAbw` und `renderVerletzungen`/`addVerl`/`updVerl`/`delVerl`.
- `updAbw`/`updVerl` schreiben nur ins Modell (kein Re-Render) → kein Fokusverlust beim Tippen; nur Add/Delete rendern neu.
- `_normEntryArr()` wandelt jsonb robust in ein Array (akzeptiert Array **oder** JSON-String).
- `_verletzungOffen(v)`: `true`, wenn kein `bis` oder `bis >= heute`.
- Beim Speichern werden leere Einträge verworfen (`_cleanAbw`: hat von/bis/notiz; `_cleanVerl`: hat art/von/bis/notiz).
- `fmtDateDE()` formatiert `YYYY-MM-DD` → `TT.MM.JJJJ` für die Anzeige.

#### Kadertabelle: Status-Meta-Chips

Neue Hilfsfunktion `statusMetaChips(p)` ergänzt die Statuszelle (zusätzlich zum Aktiv/Inaktiv-Badge):

- 📅 `bis TT.MM.JJJJ` bzw. ⏳ `beendet` (wenn `aktiv_bis` in der Vergangenheit)
- 🩼 `verletzt` (× n bei mehreren offenen Verletzungen)
- 🏝️ `abwesend` (laufend) oder 🏝️ `ab TT.MM.JJJJ` (nächste kommende Abwesenheit)

CSS: `.meta-chips`, `.meta-chip` (`.info`/`.injury`/`.injury.healed`/`.absence`) sowie Eintragskarten-Stile (`.entry-block`, `.entry-card`, `.entry-row2`, `.entry-inp`, `.entry-del` …).

#### Speicher-Fallback (vor Migration)

`_isMissingPosCol` → umbenannt/erweitert zu **`_isMissingOptCol`** (erkennt zusätzlich `aktiv_bis`/`abwesenheiten`/`verletzungen`). Fehlen optionale Spalten, werden Pflichtfelder gespeichert und alle optionalen Felder (`angriff_pos`, `abwehr_pos`, `aktiv_bis`, `abwesenheiten`, `verletzungen`) verworfen; Toast + vollständiges Migrations-SQL in der Konsole.

#### Validierung

Haupt-`<script>` extrahiert und mit `new Function(...)` geprüft → JS-Syntax OK. Alle 15 neuen Funktionen genau einmal definiert, kein Verweis mehr auf `_isMissingPosCol`, keine fehlerhaften `<\/script>`-Sequenzen.

#### Offen / zur Klärung

- Soll ein abgelaufenes `aktiv_bis` den Aktiv-Schalter automatisch auf inaktiv setzen, oder weiterhin nur datumsbasiert in der Statistik filtern (aktuell: Letzteres, Schalter unberührt)?
- Auswertung der neuen Felder (Anwesenheits-Soll, Verfügbarkeits-/Verletzungsstatistik) → separate Session, vorrangig in `spieler-statistik.html`.

---

## Änderungen – Session 01.06.2026 (Mannschaftsverwaltung: DHB-Positionen & Abwehrsysteme)

### `mannschaftsverwaltung.html` (v1.260601.1445)

#### Überblick

Die Positionsbezeichnungen im Spieler-Modal entsprachen nur teilweise dem DHB-Standard. Korrigiert wurden der Kreisläufer-Code im Angriff sowie die komplette Abwehr-Nomenklatur. Zusätzlich gibt es jetzt einen **Abwehrsystem-Selektor**, der je gewähltem System nur die zugehörigen Positions-Chips einblendet — übersichtlicher als zuvor alle Codes gleichzeitig.

#### Angriffspositionen

- Kreisläufer-Code `KR` → **`KS`** geändert. Restliche Angriffspositionen unverändert (LA, RL, RM, RR, RA, KS).

#### Abwehrpositionen – DHB-Bezeichnung

Das alte generische, nummerierte Schema (`1`–`6`, `VV`) wurde durch die 10 DHB-Standardpositionen ersetzt (`ABWEHR_POS_LABELS`):

`AL` Außen links · `AR` Außen rechts · `HL` Hinten links · `HM` Hinten Mitte · `HR` Hinten rechts · `IL` Innen links · `IR` Innen rechts · `VL` Vorne links · `VM` Vorne Mitte · `VR` Vorne rechts

#### Feature: Abwehrsystem-Selektor

Neues Dropdown `#pm-abwehr-system` über den Abwehr-Chips. Pro System wird nur die jeweilige Belegung angezeigt (`ABWEHR_SYSTEME`):

| System | Belegung (Reihenfolge = Aufstellung) |
|---|---|
| **6:0** | AL · HL · IL · IR · HR · AR |
| **5:1** | AL · HL · HM · HR · AR · VM (Spitze) |
| **3:2:1** | AL · HM · AR (hinten) · HL · HR (halb) · VM (Spitze) |
| **3:3** | HL · HM · HR (hinten) · VL · VM · VR (vorne) |
| **4:2** | AL · IL · IR · AR (hinten) · VL · VR (vorne) |

- Beim Öffnen eines Spielers wählt `_systemForCodes()` automatisch das erste System, das eine seiner gespeicherten Positionen enthält (sonst 6:0).
- Positionen werden weiterhin als priorisierte Code-Liste in `abwehr_pos` gespeichert; das Dropdown ist reiner Anzeige-Filter (kein neues Datenmodell). Klick-Reihenfolge = Priorität bleibt erhalten. _(Hinweis: in v1.260603.0747 abgelöst — `abwehr_pos` ist jetzt pro System getrennt, siehe Session 03.06.2026.)_
- `renderPmChips()` baut die Abwehr-Chips dynamisch aus `ABWEHR_SYSTEME[pmAbwehrSystem]`; neuer Handler `onAbwehrSystemChange()`.

#### Legacy-Migration (kein Re-Save nötig)

`LEGACY_POS_MAP` + `migratePosCode()` übersetzen alte Codes beim Laden automatisch — angewandt sowohl in `_normPosArr()` (Modal) als auch in `posCell()` (Kadertabelle):

`KR`→`KS`, `1`→`AR`, `2`→`HR`, `3`→`IR`, `4`→`IL`, `5`→`HL`, `6`→`AL`, `VV`→`VM`

Bestehende Spieler zeigen damit sofort die neuen DHB-Bezeichnungen; beim nächsten Speichern werden die neuen Codes persistiert.

#### Validierung

JS-Syntax nach jedem Edit mit `node --check` geprüft. Keine verbleibenden Verweise auf das entfernte `ABWEHR_POS`-Array oder den `KR`-Code (außer in der Migrations-Map).

#### Offen / zur Klärung

- 3:2:1-Chip-Reihenfolge ist nach Linien gruppiert (hinten → halb → Spitze); rein kosmetisch anpassbar.

---

## Änderungen – Session 01.06.2026 (Trainingsplaner: automatische Bild-Optimierung)

### `trainingsplaner.html` (v1.260601.1545)

#### Überblick

Bilder konnten bisher mit beliebiger Dateigröße hochgeladen werden — die Rohdatei wurde unverändert in den Supabase-Storage gelegt. Da Speicherplatz Kosten verursacht, werden Uploads jetzt **vor dem Speichern automatisch herunterskaliert und komprimiert**. Gewählter Kompromiss zwischen Speicherbedarf und Sichtbarkeit auf dem iPad: max. 1600 px längste Kante, Zielgröße ~450 KB.

#### Feature: clientseitige Bild-Optimierung (Canvas)

Neue Funktion `compressImage(file)` verarbeitet jedes Bild beim Hinzufügen (sowohl Datei-Auswahl als auch Drag & Drop laufen jetzt über die gemeinsame async-Funktion `addImageFiles`):

- **Verkleinerung** auf max. `IMG_MAX_DIM = 1600` px längste Kante per Canvas (`imageSmoothingQuality='high'`). Auf Retina-iPad auch im Lightbox-Vollbild scharf.
- **Kompression** auf `IMG_TARGET_BYTES = 450*1024` (~450 KB). Bei JPEG wird die Qualität von 0,85 in 0,08-Schritten bis zur Untergrenze `IMG_MIN_QUALITY = 0.55` abgesenkt, bis die Zielgröße erreicht ist.
- **Transparenz-Erhalt:** Bilder mit Alpha-Kanal (PNG/WebP/GIF, per `getImageData`-Sampling erkannt) bleiben PNG und werden nur verkleinert — keine JPEG-Artefakte an Linien/Text (relevant für Taktikboard-Grafiken). Alles ohne Alpha → JPEG.
- **Toast-Feedback** über die Ersparnis (z. B. „4,2 MB → 380 KB (−91 %)") via neuer Hilfsfunktion `fmtBytes`.

#### Robustheit & Fallbacks

- Nicht decodierbare Formate (z. B. HEIC außerhalb von Safari) → `loadImageEl` rejected, Original wird unverändert übernommen statt zu scheitern.
- Ist das Original bereits kleiner/effizienter und innerhalb der Maximalmaße → Original behalten.
- `File`-Konstruktor in try/catch; fällt bei älteren Engines auf einen mit `.name` annotierten Blob zurück.
- `uploadImageToSupabase` leitet die Dateiendung jetzt zusätzlich aus dem MIME-Typ ab (`image/png`→png, `image/webp`→webp, sonst jpg), falls die komprimierte Datei keinen Namen mitbringt.
- Die Vorschau (`renderFormGallery`) zeigt bereits das optimierte Bild, da `objectUrl` aus der komprimierten Datei erzeugt wird.

#### Hinweistexte

Beide Upload-Zonen (Trainingsplaner-Formular und Übungsdatenbank-Formular) weisen jetzt auf die automatische Verkleinerung hin: „Große Bilder werden automatisch verkleinert (max. 1600 px, ~450 KB)".

#### Stellschrauben

`IMG_MAX_DIM`, `IMG_TARGET_BYTES` und `IMG_MIN_QUALITY` sind als Konstanten am Anfang des Bild-Optimierungs-Blocks zentral anpassbar.

---

## Änderungen – Session 31.05.2026 (Trainingsplaner: Anwesenheitsliste-Fix)

### `trainingsplaner.html` (v1.260531.1430)

#### Überblick

Beim Öffnen des Anwesenheit-Tabs wurden trotz gefülltem Kader keine Spielerzeilen angezeigt — die Statistik-Leiste meldete „X Spielerinnen im Kader", die Liste darunter blieb aber leer.

#### Bugfix: Spieler mit Nicht-TH/FL-Position fielen aus der Render-Liste

**Ursache:** `renderAnwesenheit` teilte den Kader in genau zwei feste Gruppen — `pos==='TH'` (Torhüter) und `pos==='FL'` (Feldspieler). Jeder Spieler mit einem abweichenden `pos`-Wert (leer, `null`, oder eine spezifische DHB-Position wie `RL`/`RM`/`RR`/`LA`/`RA`/`KM`, z.B. aus dem handball.net-Kaderimport via `pos:imported.pos||'FL'`) landete in **keiner** der beiden Gruppen und wurde nie gerendert. Die Statistik-Leiste zählte ihn über `players.length` trotzdem mit → sichtbare Diskrepanz.

**Fix:** Positions-Partition robust gemacht. Neue lokale Hilfsfunktion `_istTH(p)` erkennt Torhüter case-insensitiv (`TH`, `TW`, beginnt mit `TOR`). Alle übrigen Positionswerte zählen als Feldspieler:

```js
const _istTH=p=>{const v=String(p.pos||'').trim().toUpperCase();return v==='TH'||v==='TW'||v.startsWith('TOR');};
const tw=players.filter(_istTH);
const fl=players.filter(p=>!_istTH(p));
```

Damit erscheint jeder Kaderspieler garantiert in genau einer Gruppe, unabhängig vom gespeicherten Positionswert. Das Positionssymbol in der Spielerzeile nutzt jetzt ebenfalls `_istTH` (● für Torhüter, ▲ für Feldspieler) — konsistente DHB-Darstellung auch bei `TW`/`Torwart`-Werten.

#### Hinweis: zwei verbleibende Leer-Zustände (keine Bugs)

Wenn nach dem Fix weiterhin keine Spieler erscheinen, liegt einer von zwei sauber gemeldeten Zuständen vor:
- **„Keine Mannschaft zugewiesen"** — der Mannschaftsname der Einheit (`sessionMeta.group` bzw. `hbs_my_team`) matcht keinen Eintrag in `mannschaften` (exakter, getrimmter Namensabgleich).
- **„Noch keine Spielerinnen im Kader"** — die Mannschaft hat keine Einträge in `mannschaft_spieler`.

---



### `handball-bank-statistik.html` (v2.260517.1930)

#### Überblick

Vier Bugs in `renderKaderView` behoben, die dazu führten, dass die Langzeitstatistik trotz korrekt geladener Spiele (z.B. 31 geladen) deutlich zu wenig Spieler-Daten anzeigte. SP-Spalte und Subtitle stimmten nicht mit der tatsächlichen Spielbeteiligung überein.

---

#### 1. Bugfix: Supabase Row-Limit (1.000 Zeilen) bei `spielaktionen`

**Ursache:** Die `spielaktionen`-Query in `renderKaderView` hatte kein `.limit()`. Supabase schneidet standardmäßig bei **1.000 Zeilen** ab — ohne Fehlermeldung, ohne Warnung. Bei 20+ Spielen mit vollständigem Ticker-Import (eigenes Team + Gegner) ist diese Grenze schnell überschritten. Spiele fehlten dadurch lautlos in der Aggregation.

**Fix:** `.limit(10000)` auf die Query.

---

#### 2. Bugfix: `filteredSpielIds` basierte auf veraltetem globalem `spiele`-Array

**Ursache:** Die Saison-Filterung verwendete den globalen `spiele`-Array, der einmalig beim Login befüllt wird. `spieleMap` hingegen wurde aus einer frischen DB-Abfrage gebaut. Nach dem Login hinzugefügte Spiele waren in `spieleMap` vorhanden, aber nicht in `filteredSpielIds` — bei aktivem Saisonfilter wurden ihre Aktionen dadurch ignoriert.

**Fix:** `filteredSpielIds` wird jetzt aus der frisch abgerufenen lokalen `spiele`-Liste berechnet (IIFE, gleiche Saison-Range-Logik wie `getSpieleFiltered`).

---

#### 3. Bugfix: `isMyTeamAktion` ließ Gegner-Aktionen als „Mein Team" durch

**Ursache:** Gegner-Aktionen aus dem Ticker (z.B. `gegner_tor`) haben `spieler_id = null` und `spieler_lineup = null`. Die alte Fallback-Logik `!lineupTeam → return true` ließ diese im „Mein Team"-Modus in `filteredAkt`. In der Aggregation wurden sie zwar durch `if (!lu) return` übersprungen, aber im Subtitle-Spielzähler (`seasonSpiele`) wurden sie mitgezählt → falsche Anzahl.

**Fix:** Aktionen ohne `spieler_id` und ohne Lineup werden im „Mein Team"-Modus explizit ausgeschlossen. Altdaten mit `spieler_id` aber ohne `team`-Feld werden weiterhin als eigenes Team gewertet.

---

#### 4. SP-Spalte: Basis auf `spieler_lineup` umgestellt (nicht mehr `spielaktionen`)

**Ursache:** Die SP-Zählung pro Spieler basierte ausschließlich auf Spielen mit erfassten Spielaktionen. Spiele ohne Ticker-Import oder manuelle Live-Erfassung fehlten vollständig — auch wenn der Spieler im Lineup stand.

**Fix:** Neuer Query auf `spieler_lineup` (bench ≠ true, `.limit(10000)`) parallel zu den Aktionen. SP-Zahl zeigt jetzt die echte Lineup-basierte Spielbeteiligung.

**Neuer Tooltip auf SP-Zelle:** Bei Hover: `"Lineup: X Spiele · Aktionen erfasst: Y Spiele"` — nur wenn Y < X.

**Neues Suffix `(Y✓)`** neben der SP-Zahl, wenn nicht alle Lineup-Spiele auch Aktionsdaten haben — auf einen Blick erkennbar, für wie viele Spiele Statistikdaten vorliegen.

---

#### 5. Subtitle zeigt Erfassungsstand

**Vorher:** `16 Spiele · 18 Spieler`

**Nachher:** `16 von 31 Spielen erfasst · 18 Spieler` (wenn Aktionsdaten unvollständig)
bzw. `31 Spiele · 18 Spieler` (wenn alle Spiele erfasst)

Ermöglicht auf einen Blick zu erkennen, für wie viele Spiele Ticker-Daten vorliegen.

---

## Änderungen – Session 17.05.2026 (Bank-Statistik: N.N.-Auflösung & Kader-Abgleich)

### `handball-bank-statistik.html` (v1.260517.1800)

#### Überblick

Vollständige N.N.-Erkennung und -Auflösung über drei Ebenen: im Wizard vor dem DB-Insert, beim Spielöffnen per `enrichLineupFromKader`, und rückwirkend spielübergreifend per neuem „Kader-Abgleich"-Dialog. Dazu sauberes Mergen von Statistikdaten bei Nummernwechsel in der Langzeitstatistik.

---

#### 1. Globale `isNN`-Funktion

Neue globale Hilfsfunktion `isNN(name)` ersetzt die bisher lokal in `renderStatistikGegner` definierte Closure.

Erkennt alle bekannten N.N.-Formate:
- `"N. N."` (DHB-Schreibweise)
- `"N.N."` (ohne Leerzeichen)
- `"nn"`, `"nn."` (Kleinbuchstaben-Varianten)
- `"N.N. N.N."` ← **neu**: handball.net gibt Vor- und Nachname getrennt zurück, ergibt nach Normalisierung `"n.n.n.n."`
- Leerer String / null

Wird von `enrichLineupFromKader`, `resolveNNFromKader`, `runKaderAbgleich` und `renderStatistikGegner` gemeinsam genutzt.

---

#### 2. Erweitertes `enrichLineupFromKader` (automatisch beim Spielöffnen)

Läuft bei jedem `openLive()` und `confirmGameStart()` — zwei Aufgaben statt bisher einer:

**a) N.N. auflösen:** Lineup-Einträge mit N.N.-Name und bekannter Trikotnummer werden per Nummer-Lookup gegen den Kader der Mannschaftsverwaltung aufgelöst → echter Name + korrekte Position werden direkt in `spieler_lineup` geschrieben.

**b) Position korrigieren:** Wenn Name oder Nummer matchen, aber die Position (TH/FL) abweicht, wird sie korrigiert (Kader ist maßgeblich).

Verwendet `_wizardKaderCache` — kein Doppel-Request wenn der Kader bereits im Wizard geladen wurde.

---

#### 3. N.N.-Auflösung im Wizard (vor DB-Insert)

Neue Funktion `resolveNNFromKader(players)` + `loadWizardKader()`:

- Wird in `confirmGameStart()` aufgerufen, **bevor** die Spielerliste in `spieler_lineup` gespeichert wird
- Für jeden N.N. / Nummern-Only-Eintrag im eigenen Team: Kader-Lookup per Trikotnummer → echter Name + Position werden im Array gesetzt
- Das, was in die DB kommt, hat von Anfang an die richtigen Namen → Aktionszuordnung im Live-Spiel sofort korrekt
- **Non-blocking:** `Promise.race` gegen 4-Sekunden-Timeout → bei Hänger wird N.N.-Auflösung übersprungen, `enrichLineupFromKader` holt sie danach nach. Spielstart wird nie blockiert.
- Kader-Cache `_wizardKaderCache` wird bei Team-Wechsel (`saveMyTeamConfig`) geleert

**Wizard-Vorschau:** `renderWizardBody` zeigt N.N.-Einträge orange markiert und zählt sie pro Team als `X× N.N.`-Badge. Wenn das eigene Team N.N.-Einträge hat und ein Kader konfiguriert ist, erscheint ein Hinweis-Banner.

---

#### 4. Bugfix: `forceWizard` auf bestehendes Spiel

`confirmGameStart()` löscht das bestehende Lineup jetzt **vor** dem Re-Insert (`DELETE WHERE spiel_id = ?`). Vorher fehlte dieses Delete — der Insert scheiterte am Unique-Constraint, der Button blieb als `⏳` hängen.

---

#### 5. Langzeitstatistik: Mergen bei Nummernwechsel

`renderKaderView` (Schritt 6) sammelt jetzt **alle** Lineup-Einträge, die per Name **oder** Nummer zu einer Kaderspielerin passen — statt nur den ersten Treffer:

- Stats aus allen Matches werden zusammengeführt (Spiele-Set + Aktionen + Aktionszähler)
- Spielerinnen, die in verschiedenen Spielen unter unterschiedlichen Nummern angetreten sind, erscheinen korrekt in einer Zeile
- Bei Nummernabweichung: `≠#X`-Badge (Tooltip) neben dem Namen in der Tabelle

---

#### 6. Kader-Abgleich (spielübergreifend, auf Knopfdruck)

Neuer Button **„🔍 Kader-Abgleich"** in der Langzeitstatistik-Ansicht öffnet ein Modal mit zwei Sektionen:

**N.N. auflösbar:**
- Lädt alle `spieler_lineup`-Einträge des Users (`bench ≠ true`, spielübergreifend)
- Erkennt N.N. / Nummern-Only-Namen (inkl. `"N.N. N.N."`)
- Findet per Trikotnummer den passenden Kader-Eintrag
- Zeigt: Nummer, bisheriger Rohname → aufzulösender Kader-Name, Spiel-Datum und Paarung
- „✓ X auflösen"-Button: Batch-UPDATE in der DB, Langzeitstatistik wird danach neu geladen

**Mögliche Nummernwechsel:**
- Spielerinnen deren Name im Kader bekannt ist, aber in einem Spiel unter anderer Nummer gespielt haben
- Informativ (kein Fix nötig — werden in der Langzeitstatistik bereits automatisch per Name-Match zusammengeführt)
- Hinweistext erklärt das automatische Merging

**Scan-Zusammenfassung** oben im Modal: Gesamt-Einträge, Platzhalter gefunden, auflösbar, nicht auflösbar (Nummer nicht im Kader).

**Fixes ggü. erster Implementierung:**
- `bench`-Filter: `.filter(p => p.bench !== true)` statt `.eq('bench', false)` — erfasst auch ältere Einträge mit `bench = null`
- `isNumberOnly`-Namen werden als Platzhalter erkannt (z.B. `"17."` aus altem Import)
- Debug-Ausgabe in `console.group` bei jedem Abgleichlauf

---

## Änderungen – Session 14.05.2026 (Gegneranalyse)

### `gegneranalyse.html` – Neues Modul (v1.260514.2200)
### `index.html` – Gegneranalyse-Kachel aktiviert

#### Übersicht

Komplett neues Modul für strukturiertes Scouting. Gegner-Profile auf Team-Ebene, mit beliebig vielen Spielanalysen pro Begegnung. Fünf Tabs pro Gegner: Analysen, Spielsysteme, Statistik, Schlüsselspieler, Profil.

#### 1. Gegner-Profile

- Stammdaten: Name, Liga, Trainer, Heimspielstätte
- Vereinsfarbe (Farbwähler, 10 Swatches) als Kartenakzent
- **Trikotfarben Heim / Auswärts:** Hex-Eingabe mit Live-Farbvorschau; wird als kleines H/A-Dot auf der Kachelübersicht und im Detail-Hero angezeigt
- Allgemeine Notizen
- Kachelübersicht mit Analyse- und Spielerzähler pro Gegner

#### 2. Kalender-Import

- Button „Aus Kalender importieren" liest alle `spiele` aus der DB
- Gegner werden automatisch aus `heim`/`gast`-Feldern identifiziert (über `spielart`-Feld + Team-Namensabgleich)
- Bereits angelegte Gegner grün markiert, nicht anwählbar
- Checkbox-Auswahl + einmaliger Bulk-Import

#### 3. Spielanalysen (pro Begegnung)

- Datum, Heim/Auswärts, Ergebnis
- Angriffssystem ▲ + Abwehrsystem ● mit Systemauswahl und Freitext
- Tendenzen & interne Notizen
- **Kalender-Verknüpfung:** beim Anlegen werden alle Spiele gegen diesen Gegner aus der DB als Radio-Liste angeboten; Auswahl befüllt automatisch Datum, Spielort und Ergebnis
- Verknüpfte Analysen zeigen 🔗-Symbol in der Liste

#### 4. Spielsysteme-Tab

- **Angriff ▲ und Abwehr ●:** je eigene Karte mit System-Dropdown, Notizfeld und Bildupload-Zone
- Bild-Upload direkt in Supabase Storage (`gegner-bilder`-Bucket), URL in DB gespeichert
- Live-Vorschau, Ersetzen, Löschen ohne Seitenneuladung
- System-Badge erscheint sofort im Karten-Header nach Auswahl
- **Auslösehandlungen** (ersetzt feste „Standardsituationen"):
  - Dynamische Liste, beliebig viele Einträge
  - „+"-Button legt Eintrag sofort in DB an, Fokus springt ins Namensfeld
  - Name und Notiz speichern per Auto-Save beim Verlassen des Feldes (blur), kein extra Button
  - Jeder Eintrag hat eigene Bildupload-Zone mit Vorschau, Ersetzen, Löschen
  - Einträge per ✕ löschbar (mit Bestätigung)

#### 5. Statistik-Tab

**Eigene Daten (automatisch):**
- KPI-Zeile: Spiele, Siege, Unentschieden, Niederlagen, Ø Tore (wir:sie), Ø 2-Minuten des Gegners
- Letzte Begegnungen mit Ergebnis, Heim/Auswärts-Icon, Sieg/Niederlage farbig kodiert
- Topscorer des Gegners gegen uns (aus `spielaktionen`-Tabelle der Bank-Statistik)

**Seitenbestimmung (`unsereSeite`):**
Namensabgleich (`heim`/`gast`-Feld) als primäres Signal — zuverlässiger als `spielart`, da dieses bei Kalender-importierten Spielen ohne Bank-Statistik-Wizard auf Default `'heim'` steht. `spielart` nur als letzter Fallback.

**handball.net Spielplan (manuell via iCal):**
- iCal-URL einmalig eingeben und laden (dieselbe Edge Function `quick-service` wie Bank-Statistik)
- Zeigt: Spielplan-Umfang (gesamt / gespielt / ausstehend / Heim-Auswärts-Verhältnis)
- Nächstes Spiel als blauer Banner mit Datum, Uhrzeit, Ort
- Vollständiger Spielplan sortiert (neueste zuerst, zukünftige ausgegraut)
- URL per 💾 am Gegner-Profil speicherbar → beim nächsten Öffnen direkt verfügbar
- Hinweis: handball.net iCal enthält keine Ergebnisse – nur Spieltermine. Ergebnisse kommen aus der Bank-Statistik.

**Bugfixes in dieser Entwicklungsphase:**
- `display=''` → `display='block'` für den iCal-Ergebnisbereich (CSS-Klasse `display:none` wurde sonst nicht überschrieben)
- Tab-Leiste mit 5 Tabs: `overflow-x:auto` + `scrollbar-width:none` gegen Überlauf auf kleinen Screens

#### 6. Schlüsselspieler-Tab

- Karten mit Rückennummer, DHB-Position (▲/●), Stärken (grün), Schwächen (rot), Notiz
- Vollständige CRUD-Operationen

#### Neue SQL-Migrationen (Reihenfolge beachten)

1. `gegneranalyse-schema.sql` — Tabellen `gegner`, `gegner_analyse`, `gegner_spieler` mit RLS
2. `gegneranalyse-schema-update.sql` — `trikot_heim`, `trikot_auswaerts` auf `gegner`
3. `gegneranalyse-schema-spielsysteme.sql` — Spielsystem-Spalten auf `gegner` + Storage-Bucket `gegner-bilder`
4. `gegneranalyse-schema-ausloesehandlungen.sql` — Tabelle `gegner_ausloesehandlungen` mit RLS
5. `gegneranalyse-schema-statistik.sql` — `hbn_ical_url` auf `gegner`

---

## Änderungen – Session 14.05.2026 (Kalender)

### `kalender.html` – iCal-Zeitzonenfehler, Doppeltermin-Bug, Ladescreen, Sync-Protokoll (v1.260514.1200)

#### 1. Uhrzeitverschiebung Trainings behoben (+2h statt richtig)

**Ursache:** `parseICalDate` entfernte den `Z`-Suffix (UTC-Marker) aus dem iCal-String und erzeugte dann ein `Date`-Objekt ohne `Z`. Der Browser interpretierte die Zeit als Lokalzeit statt UTC. Ein Event `20250515T174500Z` (= 17:45 UTC = 19:45 CEST) wurde als 17:45 Lokalzeit angezeigt.

**Fix:** `Z`-Suffix wird jetzt erkannt und im ISO-String beibehalten (`...T17:45:00Z`). Der Browser parst das korrekt als UTC und `getHours()` liefert die richtige Lokalzeit.

#### 2. Zweiter Termin am gleichen Tag fehlt

**Ursache:** Die Deduplikation (`einheiten.find(e => e.group_name === ev.mannschaftName)`) unterdrückte bei Vorhandensein *irgendeiner* Supabase-Einheit für ein Team alle iCal-Events dieses Teams am gleichen Tag – auch einen zweiten unabhängigen Termin.

**Fix:** Deduplikation ist jetzt zeitbasiert. Nur wenn Team *und* Uhrzeit übereinstimmen, gilt der iCal-Eintrag als durch eine Supabase-Einheit abgedeckt. Identisch umgesetzt in Grid und Monatsübersicht.

#### 3. Uhrzeitverschiebung Spiele behoben (+1h statt richtig)

**Ursache:** handball.net Spielplan-Feeds liefern `DTSTART;TZID=Europe/Berlin:20251020T203000` – lokale Berliner Zeit mit TZID, kein UTC-Z. Der Parser ignorierte den TZID-Parameter und interpretierte die Zeit als Browser-Lokalzeit (CEST = UTC+2) statt als die explizite Europe/Berlin-Zeit. Ergebnis: 1 Stunde zu früh.

**Fix (mehrstufig):**

- `parseICal()` liest jetzt den `TZID=`-Parameter aus dem DTSTART-Schlüssel
- `ICAL_TZ_MAP` übersetzt iCal-Zeitzonennamen (Windows-Namen, Kurzformen) auf IANA-Namen
- `getIanaTzOffsetMs(ianaZone, utcMs)` berechnet den exakten UTC-Offset via `toLocaleString('sv-SE', {timeZone})` – DST-korrekt, Zwei-Schritt-Verfahren für Grenzfälle
- Fallback: VTIMEZONE-TZID des Feeds wird als Kontext verwendet, wenn VEVENT-Einträge keine eigene TZID haben
- Floating times (kein Z, kein TZID) → Browser-Lokalzeit

#### 4. Supabase-Spiele zeigen weiterhin falsche Zeit (aus DB)

**Ursache:** Supabase-Spiele hatten noch veraltete `uhrzeit`-Werte in der DB (importiert vor dem Timezone-Fix). Da Supabase-Spiele vor iCal-Events gerendert werden und der `exists`-Check das iCal-Event unterdrückt, „gewann" immer die falsche DB-Zeit.

**Fix – Anzeige (Grid + Liste):** Wenn zu einem Supabase-Spiel ein passendes iCal-Event vorhanden ist, wird die iCal-Zeit für die Anzeige bevorzugt. Matching über Datum + Teamname im Summary.

**Fix – DB-Selbstkorrektur (`correctSpielUhrzeiten`):** Nach jedem Feed-Sync werden Supabase-Spiele automatisch geprüft. Weicht die DB-Zeit von der iCal-Zeit ab, wird `uhrzeit` still korrigiert (nur Spiele ohne Status `fertig`). Meldung in der Konsole mit `🔧 Uhrzeit korrigiert: … → …`.

#### 5. Ladescreen

Identisch zum Trainingsplaner: Vollbild-Screen (`#loading-screen`) mit HB-Logo, Spinner und dynamischem Statustext:
- `Verbindung wird hergestellt…`
- `Profil wird geladen…`
- `Mannschaften werden geladen…`
- `Kalender-Feeds werden synchronisiert…`

Blendet nach dem letzten `syncFeeds()` mit 350ms Fade-Out aus und wird aus dem DOM entfernt.

#### 6. Sync-Protokoll → Browser-Konsole

Das temporäre Debug-Panel wurde entfernt. Diagnose-Daten werden jetzt pro Sync als strukturierte `console.group`-Gruppe ausgegeben:
- Timestamp + Zusammenfassung (Feeds OK / Fehler / Termine gesamt)
- Pro Feed: Name, Event-Anzahl, rohe DTSTART-Zeile, VTIMEZONE-TZID, geparste Lokalzeit
- Für Spiel-Feeds zusätzlich: erste 5 Events mit UTC-ISO und lokaler HH:MM-Zeit

Hilfsfunktion `debugGames()` jederzeit in der Browser-Konsole aufrufbar: zeigt Tabelle aller gecachten Spiel-Events mit UTC-ISO, Lokal-Zeit, `toTimeStr`-Wert und Zeitzonenkürzel.

#### 7. Favicon-Fix

Inline-SVG-Favicon (`📅`) im `<head>` ergänzt – verhindert den 404-Fehler beim Browser-Request für `favicon.ico`.

---

## Änderungen – Session 12.05.2026

### `trainingsplaner.html` – UI-Fixes: Buttons, Bleistift-Emoji, Toolbar-Struktur (v1.260512.1600)

#### 1. Reset-Button → Startseite + echter Zurücksetzen-Button

Der bisherige `↺ Reset`-Button hatte eine Doppelfunktion (Startseite + Sitzung löschen) — das war irreführend. Aufgeteilt in zwei separate Funktionen:

- **`🏠 Startseite`** (ghost-Stil): navigiert zur Home-View, ohne Daten zu verändern (`goHome()` → `showHomeView()`)
- **`↺ Zurücksetzen`** (danger-Stil, roter Rahmen): löscht nach Bestätigungsdialog alle Übungen und Abschnitte der aktuellen Einheit (`resetEinheit()`). Einheitsmetadaten (Datum, Titel, Ort etc.) bleiben erhalten.

Beide Buttons auch im mobilen Mehr-Menü aktualisiert. Neue CSS-Klasse `.ctb-danger` (weißer Hintergrund, roter Text/Rahmen, dunkleres Hover).

#### 2. Bleistift-Emoji überall vereinheitlicht

Alle `✏`-Symbole (alter Unicode-Stift ohne Farbe, zu klein) wurden durch `✏️` (Emoji-Selektor, farbig und deutlich größer) ersetzt:
- Session-Header-Button: `font-size:18px`
- Drill-Zeilen-Buttons (Plan + Split-Ansicht): `font-size:16px`
- DB-Panel-Button: `font-size:15px`
- Detail-Modal- und Add-Modal-Buttons: Emoji-Selektor ohne explizite Größenänderung

#### 3. Toolbar in zwei Zeilen aufgeteilt

**Problem:** Alle Buttons (Speichern, + Übung, Abschnitt-Buttons, Drucken, Startseite, Zurücksetzen) lagen in einer einzigen `flex`-Zeile — bei schmalen Viewports unübersichtlich, die Abschnitt-Buttons nicht klar als eigene Gruppe erkennbar.

**Fix:** Die `.content-toolbar` wurde von `display:flex` auf `flex-direction:column` umgestellt, mit zwei expliziten Zeilen:
- **Zeile 1 (`.ctb-row`):** Speichern · + Übung · *(Spacer)* · Drucken · Startseite · Zurücksetzen
- **Zeile 2 (`.ctb-sections-row`):** Label `ABSCHNITTE EINFÜGEN:` + ÷ Aufwärmen · ÷ Hauptteil · ÷ Abschluss

Auf Mobile (≤600px) wird das Label ausgeblendet; beide Zeilen behalten `flex-wrap`.

#### 4. Bugfix: `onfocus`-Attribut als sichtbarer Text im DOM

**Ursache:** Beim vorherigen Edit-Session-`str_replace` wurde der schließende `</div>`-Tag der `.drill-content`-Box gemeinsam mit dem öffnenden `<div class="drill-note-area"><textarea …`-Beginn als einziger Block gesucht. Da der Block nicht exakt übereinstimmte, wurde das Textarea-Öffnungs-Tag und alle nachfolgenden Attribute herausgeschnitten. Ergebnis: `onfocus="autoResizeTA(this)">${noteVal}</textarea>` stand als roher Text im DOM.

**Fix:** Der vollständige `drill-note-area`-Block wurde korrekt wiederhergestellt.

---

## Änderungen – Session 11.05.2026 (Abend IV)

### `trainingsplaner.html` – Strang-Kontrollleiste separat über den Track-Überschriften

**Problem:** Die ＋/－/🗑-Buttons der Strang-Aufteilung standen in derselben Flex-Zeile wie die umbenennbaren Track-Überschriften. Dadurch waren die Überschriften und Buttons auf einer Linie — unübersichtlich und visuell nicht klar getrennt.

**Fix:** Neuer `.split-ctrl-bar` als eigenständige Zeile *oberhalb* von `.split-header`:
- `background:#eef2ff`, gleiche gestrichelte Rahmenlinie wie die Box darunter, obere Ecken abgerundet
- Links: Beschriftung „⚡ GETEILTER STRANG" (dezent, uppercase)
- Rechts: Buttons **＋ Strang / － Strang / 🗑 Löschen** mit korrektem Hover-Styling (blau / neutral / rot)

---

## Änderungen – Session 11.05.2026 (Abend III)

### `trainingsplaner.html` – Plan-UI: Abschnitts-Marker, Zeitzeilen, Pfeil-Navigation

#### 1. Manuelle Abschnitts-Marker

Neue Buttons in der Content-Toolbar: **÷ Aufwärmen · ÷ Hauptteil · ÷ Abschluss**.

Ein Klick fügt einen farbigen Trenner am Ende des `drills`-Arrays ein. Der Trenner zeigt Phasename, Gesamtdauer der folgenden Übungen und Zeitraum (wenn Trainingszeit hinterlegt). Marker werden wie Drills in Supabase gespeichert. Die alte automatische Phasen-Gruppierung entfällt vollständig.

#### 2. Übungskopfzeile (drill-time-bar)

Jede Übung erhält eine eigene graue Kopfzeile mit `Dauer 10 Min · 17:00 – 17:10`.

#### 3. Notiz in eigener Zeile

Das Notizfeld erscheint als eigenständiger gelber Bereich (`.drill-note-area`) unterhalb des Übungsinhalts.

#### 4. Pfeil-Navigation ▲ ▼

Jede Übungszeile und jeder Abschnitts-Marker hat ▲ ▼ Buttons. `moveDrill(idx, dir)` tauscht per Array-Swap und triggert `render()` + Auto-Save (300 ms Debounce).

---

## Änderungen – Session 11.05.2026 (Abend II)

### `trainingsplaner.html` – Positionales Rendering & Strang-UI

#### 1. Positionales Rendering (Kern-Fix)

`render()` iteriert jetzt strikt durch das `drills`-Array in Reihenfolge. Phasen-Trenner erscheinen nur noch, wenn sich die Phase zur vorherigen regulären Übung ändert — kontextuell, nicht als Vorgruppierung. Split-Blöcke erscheinen inline exakt da, wo ihr Marker im Array steht.

#### 2. Strang-Aufteilung: Controls über die Aufteilung gezogen

Neuer `.split-ctrl-bar` als eigene Zeile oberhalb der gestrichelten Box. `.split-header` ist reine Überschriften-Zeile ohne Button-Konkurrenz.

---

## Supabase-Tabellen (Übersicht)

| Tabelle | Inhalt | RLS |
|---|---|---|
| `profiles` | Nutzerprofile (Name, Verein, Rolle, Aktiv-Flag) | ✅ |
| `einheiten` | Trainingseinheiten (user-spezifisch) | ✅ |
| `uebungen` | Übungsdatenbank (user-spezifisch + geteilte DB) | ✅ |
| `kategorien` | Übungskategorien | ✅ |
| `spiele` | Spielmetadaten (Bank-Statistik) | ✅ |
| `spieler_lineup` | Aufstellung je Spiel | ✅ |
| `spielaktionen` | Aktionslog je Spiel inkl. `gegner_name`, `gegner_nummer` | ✅ |
| `mannschaften` | Mannschaften mit Farben, Logo, handball.net-Slug (`hbn_team_id`) | ✅ Eigentümer + Freigabe |
| `mannschaft_spieler` | Kader je Mannschaft (Nr., Name, Pos FL/TH, Aktiv) | ✅ Eigentümer + Freigabe |
| `mannschaft_freigaben` | Explizite Lesezugriffs-Freigaben zwischen Trainern | ✅ |
| `mannschaft_kalender` | Beliebig viele iCal-Feeds je Mannschaft und Typ | ✅ Eigentümer + Freigabe |
| `saisons` | Saisondefinitionen (Name + Enddatum) | ✅ |
| `gegner` | Gegner-Stammprofil (Name, Liga, Trainer, Trikots, Spielsysteme, iCal-URL) | ✅ |
| `gegner_analyse` | Spielanalyse pro Begegnung (Systeme, Ergebnis, Notizen, spiel_id) | ✅ |
| `gegner_spieler` | Schlüsselspieler je Gegner (DHB-Position, Stärken, Schwächen) | ✅ |
| `gegner_ausloesehandlungen` | Dynamische Auslösehandlungen je Gegner mit Bild-URL | ✅ |

### RLS-Besonderheit: Zirkelauflösung
Policy auf `mannschaften` referenziert `mannschaft_freigaben` – Endlosschleife verhindert durch `security invoker`-Funktion `get_freigegebene_mannschaft_ids()`.

---

## SQL-Migrationen (Reihenfolge beachten)

1. `mannschaftsverwaltung_migration.sql`
2. `mannschaft_kalender_migration.sql`
3. `rls_performance_fix.sql`
4. `gegneranalyse-schema.sql` — Tabellen `gegner`, `gegner_analyse`, `gegner_spieler`
5. `gegneranalyse-schema-update.sql` — `trikot_heim`, `trikot_auswaerts`
6. `gegneranalyse-schema-spielsysteme.sql` — Spielsystem-Spalten + Storage-Bucket `gegner-bilder`
7. `gegneranalyse-schema-ausloesehandlungen.sql` — Tabelle `gegner_ausloesehandlungen`
8. `gegneranalyse-schema-statistik.sql` — `hbn_ical_url`
9. Manuelle Patches:

```sql
-- Gegner-Aktionen in spielaktionen
ALTER TABLE spielaktionen ALTER COLUMN spieler_id DROP NOT NULL;
ALTER TABLE spielaktionen ADD COLUMN IF NOT EXISTS gegner_name text;
ALTER TABLE spielaktionen ADD COLUMN IF NOT EXISTS gegner_nummer text;

-- Saison-Verwaltung
CREATE TABLE saisons (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES auth.users NOT NULL,
  name text NOT NULL,
  end_date date NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE saisons ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own saisons" ON saisons
  FOR ALL USING ((select auth.uid()) = user_id)
  WITH CHECK ((select auth.uid()) = user_id);

-- Security-Fix get_freigegebene_mannschaft_ids()
ALTER FUNCTION public.get_freigegebene_mannschaft_ids() SECURITY INVOKER;
REVOKE EXECUTE ON FUNCTION public.get_freigegebene_mannschaft_ids() FROM anon;
GRANT  EXECUTE ON FUNCTION public.get_freigegebene_mannschaft_ids() TO authenticated;

-- handball.net-Verknüpfung (Session 07.–08.06.2026)
ALTER TABLE mannschaften ADD COLUMN IF NOT EXISTS hbn_team_id text;

-- Globale Saisonauswahl (Session 08.06.2026) – geräteübergreifend synchronisiert
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS aktive_saison_id uuid REFERENCES saisons(id) ON DELETE SET NULL;
```

---

## Edge Functions

| Function | Zweck | Status |
|---|---|---|
| `quick-service` | handball.net Proxy: iCal, Match, Aufstellung, Ticker **+ sportdata-JSON** (`schedule`, `combined`, `lineup`, `table`, `game`, `team`, `clubs/search` via `sportdata`) | ✅ deployed (inkl. JSON) |
| `admin-user-ops` | Nutzer löschen (Admin) | ✅ deployed |
| `ical-proxy` | iCal-Feed-Proxy (CORS-sicher) | ⏳ noch nicht deployed |

### Storage Buckets

| Bucket | Inhalt | Zugriff |
|---|---|---|
| `bilder` | Übungsbilder (Trainingsplaner) | Authentifiziert |
| `gegner-bilder` | Spielsystem-Skizzen, Auslösehandlungen (Gegneranalyse) | Öffentlich lesbar, Upload nur eigene Ordner |

---

## Fertige Features – Stand 18.05.2026

### Dashboard & Navigation
- Zentraler Einstiegspunkt mit Kachelnavigation
- Rollenbasierte Sichtbarkeit
- Einheitliche Sidebar + Topbar auf allen Seiten
- Zentraler Login ausschließlich über `index.html`
- Profil-Selbstverwaltung (`mein-profil.html`)
- Meine Mannschaft-Kachel mit aktivem Team, Vereinsname und Schnellwechsel per Chip

### Trainingsplaner
- Home-View mit Kacheln (letzte Einheit, nächste Einheit, Kalender, andere Mannschaft)
- iCal-Fallback in Home-Kacheln: zeigt nächsten Feed-Termin wenn noch keine Supabase-Einheit angelegt
- Zeitbasierte, persönliche Begrüßung mit Vorname
- Ladescreen mit Fortschrittstext
- Team-Wechsler im Sidebar-Widget (Chip-Stil, inkl. Vereinsname)
- Spieleranzahl-Picker mit drei Modi: **Gesamt** (Min-Max-Zahlenfelder), **TW + Feld** (separate Min-Max je TW/Feld), **Positionen** (7 DHB-Positionen)
- **Positionales Rendering:** Übungen erscheinen in exakter Array-Reihenfolge
- **Manuelle Abschnitts-Marker:** ÷ Aufwärmen / ÷ Hauptteil / ÷ Abschluss – farbige Trenner mit Zeitraum und Gesamtdauer; nachträglich per ▲ ▼ verschiebbar
- **Übungskopfzeile:** jede Übung zeigt eigene Zeitspanne
- **Notizfeld als eigene Zeile:** gelber Bereich klar getrennt vom Übungsinhalt
- **Pfeil-Navigation ▲ ▼** für Übungen und Abschnitts-Marker
- **Toolbar zweizeilig:** Zeile 1 (Speichern/Übung/Drucken/Startseite/Zurücksetzen), Zeile 2 (Abschnitte einfügen)
- Übungsdatenbank (privat + geteilte DB)
- iCal-Kalenderintegration
- Supabase-Persistenz für Einheiten und Übungen

### Kalender
- Monatsansicht + Monatsliste
- Supabase-Einheiten + Supabase-Spiele + iCal-Events
- Mehrere Mannschaften mit eigenen Farben
- Navigation zu Trainingsplaner und Bank-Statistik
- **Ladescreen** identisch zum Trainingsplaner
- **Korrekte Zeitzonenauflösung** für alle Feed-Typen: UTC-Z, TZID (Europe/Berlin), floating time + VTIMEZONE-Fallback
- **Zeitbasierte Deduplikation:** zweiter Termin am gleichen Tag korrekt angezeigt
- **DB-Selbstkorrektur:** `correctSpielUhrzeiten()` repariert falsche `uhrzeit`-Werte automatisch

### Gegneranalyse
- Gegner-Profile mit Stammdaten, Vereinsfarbe, Trikotfarben Heim/Auswärts
- Kalender-Import, Spielanalysen, Spielsysteme-Tab, Auslösehandlungen, Statistik-Tab, Schlüsselspieler

### Bank-Statistik
- Drei-Spalten-Layout: Aktionslog | Score | Spieler + Action-Drawer
- Ticker-Synchronisation via handball.net
- Gegner-Aktionen aus Ticker
- Spieler-Lineup-Wizard (handball.net / Kaderliste / manuell)
- Langzeitstatistik mit Saisonfilter
- **N.N.-Auflösung im Wizard:** vor DB-Insert, non-blocking mit 4s-Timeout
- **N.N.-Auflösung beim Spielöffnen:** `enrichLineupFromKader` erkennt `"N.N. N.N."` (handball.net-Format) und alle Varianten
- **Kader-Abgleich:** spielübergreifender Dialog mit Batch-Fix und Nummernwechsel-Erkennung
- **Langzeitstatistik:** Nummernwechsel-Merging (alle Matches per Name oder Nummer zusammengeführt)
- **Bugfix `forceWizard`:** altes Lineup wird vor Re-Insert gelöscht
- **Langzeitstatistik SP-Zählung:** basiert auf `spieler_lineup` (echte Einsätze), nicht `spielaktionen`
- **Langzeitstatistik Subtitle:** zeigt Erfassungsstand `X von Y Spielen erfasst`
- **Supabase Row-Limit:** alle relevanten Queries mit `.limit(10000)` gegen den 1.000-Zeilen-Default
- **Gegner-Aktionen-Filter:** korrekte Trennung von eigenen / fremden Aktionen auch ohne `team`-Feld

---

## In Planung

- [x] Anwesenheitsliste im Trainingsplaner + Verknüpfung mit Spieleranzahl-Picker *(Session 02.06.2026: sichtbar-Fix, ID-basierte Team-Auflösung, Langzeit-Status-Bearbeitung)*
- [x] handball.net-Integration in der Mannschaftsverwaltung: Anlage, Saison-/Wettbewerbsauswahl, Kader-Import über alle Spiele, Nachverknüpfung *(Session 07.–08.06.2026)*
- [x] `quick-service` mit JSON-sportdata-Endpunkten deployt *(08.06.2026)*
- [x] Kalender auf JSON-Spielplan (mit Ergebnissen) umgestellt + synchronisierte Saisonauswahl *(Session 08.06.2026)*
- [x] `aktive_saison_id`-Migration ausgeführt; Saison-Auswahl in Statistik-/Trainingsplaner-Seiten eingebaut (überall synchron) *(09.06.2026)*
- [x] Alle Konsumenten-Module (Kalender, Trainingsplaner, Bank-Statistik, Gegneranalyse) von iCal auf JSON-`schedule`/`combined` umgestellt; iCal nur noch Fallback *(Session 08.–09.06.2026)*
- [ ] Trainingsplaner ↔ Bank-Statistik Cross-Link
- [ ] Taktikboard → Supabase: `board_json` + PNG-Thumbnails in Storage
- [ ] Taktikdatenbank: Spielzüge / Abwehrsysteme
- [ ] Gegneranalyse: Taktikboard-Embed (nach Taktikboard-Fertigstellung)
- [ ] Gegneranalyse: PDF-Export (Kurz- und Vollversion)
- [ ] Vereinsverwaltung (Admin)
- [ ] `ical-proxy` Edge Function deployen
- [ ] Bank-Statistik: PDF-Export pro Spiel
- [ ] Ordnerstruktur bei ~12+ Dateien

---

## Technische Konventionen

- **Terminologie:** DHB-Standard (▲ Angriff, ● Abwehr/TW, ◆ Kreisläufer)
- **Sprache:** Durchgehend Deutsch
- **Dateistruktur:** Single-File HTML, flach im GitHub-Pages-Root (Ist-Zustand; Ziel laut `CLAUDE.md`: ES-Module `hbn.js`, `supabase-client.js`, `shared.js`, `shared.css` im Root, Migration seitenweise)
- **Arbeitsregeln:** `CLAUDE.md` ist verbindlich und hat Vorrang vor älteren Konventionen in dieser Datei. Vor jeder Auslieferung `scripts/validate.sh` ausführen.
- **Supabase:** `dlofjsmnkwltuutpxoer.supabase.co`, `@supabase/supabase-js@2` via CDN
- **Design:** DM Sans + DM Mono, Dark Sidebar (`#141820`), CSS Custom Properties
- **Sidebar-Zustand:** `localStorage('sidebar_collapsed')` — seitenübergreifend persistent
- **Aktives Team:** `localStorage('aktive_mannschaft_id')` + `localStorage('aktive_mannschaft_name')` + `localStorage('hbs_my_team')` — seitenübergreifend. Anwesenheit im Trainingsplaner löst **ID-first** auf (`aktive_mannschaft_id`), dann Name, dann Gruppenname.
- **Versionierung:** `v1.YYMMDD.HHMM` – Uhrzeit immer in CEST: `TZ='Europe/Berlin' date '+%H%M'`
- **Versionsanzeige:** Ganz unten in der Sidebar jeder Seite
- **N.N.-Format handball.net:** `"N.N. N.N."` (Vorname + Nachname getrennt) → nach Normalisierung `"n.n.n.n."`
- **Kader-Cache:** `_wizardKaderCache` — session-weit, wird bei Team-Wechsel geleert
- **Supabase Row-Limit:** Queries die potenziell >1.000 Zeilen zurückgeben immer mit `.limit(10000)` absichern
- **Spieler-Positionen:** `mannschaft_spieler.angriff_pos` = flaches Array (systemunabhängig); `mannschaft_spieler.abwehr_pos` = Objekt je Abwehrsystem (`{"6:0":["AL"],"5:1":["HM"]}`), Array-Reihenfolge = Priorität. Lese-Pfad (`_normAbwBySys`) akzeptiert auch das alte flache Array (Legacy-Migration aufs erste passende System). `abwehr_pos` nur in `mannschaftsverwaltung.html`; `angriff_pos` zusätzlich in `trainingsplaner.html` (Anwesenheits-Gruppierung nach primärer Angriffsposition).
- **Kreisläufer-Code = `KS` (Angriff), suite-weit einheitlich.** Früher `KR`; Umstellung 03.06. (Mannschaftsverwaltung) → 12.06. überall. Alle Lesepfade akzeptieren Alt-`KR` als Fallback und zeigen es als `KS` (`migratePosCode` in `mannschaftsverwaltung.html`, `_awCanonPos` in `trainingsplaner.html`, `canonPos`/`mapHbnPos` in `gegneranalyse.html`). DB-Daten per Migration auf `KS` (12.06.: `mannschaft_spieler.angriff_pos`, `gegner_spieler.position`). Statistikmodule (`spielerstatistik`/`mannschaftsstatistik`/`handball-bank-statistik`) nutzen nur die grobe Rolle `FL`/`TH`, keinen Feinpositions-Code.
- **Effektiver Aktiv-Status:** ein Spieler ist nur dann „aktiv", wenn `aktiv === true` **und** (`aktiv_bis` leer **oder** `aktiv_bis >= heute`). Abgelaufenes `aktiv_bis` → Status `beendet`, `aktiv === false` → `inaktiv`. Der gespeicherte `aktiv`-Wert wird nie automatisch umgeschaltet; die Darstellung wird berechnet (`playerStatus`/`isPlayerAktiv` in `mannschaftsverwaltung.html` und `spielerstatistik.html`; `_awPlayerStatus`/`_awIsAktiv`/`_awParticipates` in `trainingsplaner.html`). Module, die Anwesenheit/Verfügbarkeit auswerten, sollten dieselbe Logik nutzen statt nur `aktiv` zu prüfen.
- **Gast-Anwesenheit (trainingsplaner.html):** Gastspieler werden im `einheiten.anwesenheit.spieler[]`-Payload mit `{gast:true, gast_mannschaft_id, gast_mannschaft_name}` abgelegt; ihre ID ist die echte `mannschaft_spieler.id` aus der Heimmannschaft. `spielerstatistik.html`'s `loadAttendance` scannt alle eigenen Einheiten und zählt Gast-Einträge, deren `gast_mannschaft_id === _myTeamId`, als reguläre Anwesenheit. Funktioniert nur für denselben Supabase-Nutzer (RLS). Cross-Trainer-Gäste brauchen eine separate `gast_anwesenheit`-Tabelle.
- **Anwesenheits-State (trainingsplaner.html):** `anwesenheitDaten` (id → Status), `awGuests` (Gast-Objekte), `awAktiviert` (Set inaktiver aktivierter IDs) — alle drei bei Einheits-/Mannschaftswechsel zurücksetzen. `awgKaderCache` (Gast-Team-Kader, separater Cache).
- **handball.net sportdata-API:** interne JSON-Backend-API unter `https://www.handball.net/a/sportdata/1`, unauthentifiziert, **ohne CORS** → immer über die `quick-service`-Edge-Function proxen (requestTypes `schedule`/`combined`/`lineup`/`table`/`game`/`team`/`sportdata`). Logos kommen mit Präfix `handball-net:` → ersetzen durch `https://www.handball.net/`. Zeitstempel = Epoch-Millisekunden.
- **handball.net-Slug (`mannschaften.hbn_team_id`):** stabiler Team-Slug (z.B. `handball4all.ol-hamburg-schleswig-holstein.1343861`), Voraussetzung für alle handball.net-Funktionen in der Mannschaftsverwaltung. Heim/Gast-Zuordnung eines Spiels immer über `heim_slug`/`gast_slug === hbn_team_id` (nicht über Namen).
- **tournamentSeason-Filter:** `…/calendar/team/{slug}.ics?tournamentSeason={facetId}` (und der JSON-`schedule`) filtern exakt auf einen Wettbewerb + eine Saison. Ohne Parameter liefert der team-iCal nur den aktuellen Hauptwettbewerb. Die Facets stammen aus dem `schedule`-Response (`meta.facets`/`saisons`), gruppiert per `_hbnSplitFacet` (Klammerzusatz = Saison). Pro Facet ein `mannschaft_kalender`-Feed.
- **handball.net-Kader = aus Aufstellungen rekonstruiert:** es gibt **keinen** Squad-Endpunkt. Der Kader wird über alle gespielten Partien (`games/{id}/lineup`) zusammengesetzt und über die stabile Spieler-ID dedupliziert. Die Aufstellungs-JSON enthält **keine Position** (`position` immer `null`) → kein Torwart-Erkennen möglich, Import als Feldspieler, TW manuell.
- **Kalender + Trainingsplaner: JSON primär, iCal Fallback.** Hat ein Team `hbn_team_id`, kommen seine Spiele ausschließlich aus dem JSON-`schedule` (mit Ergebnis/Status); iCal-Spielfeeds desselben Teams werden übersprungen. Der per-Feed-JSON-Pfad ist nur Fallback für **unverknüpfte** Teams. `parseHbnGameFeed(url)` erkennt handball.net-Feeds; `hbnScheduleEvents` mappt in dieselbe Event-Form wie iCal plus `score_home/score_away/hbn_status`. Spiele mit Supabase-Eintrag ziehen den Stand ebenfalls aus den handball.net-Daten (die `spiele`-Tabelle speichert keinen Spielstand).
- **Globale Saisonauswahl:** in `profiles.aktive_saison_id` (FK → `saisons`), geräteübergreifend; **jede Seite liest/schreibt dieselbe Spalte** (gemeinsamer Sync-Punkt). Default = Saison, deren Zeitraum heute enthält. Saison-Datumsbereich: Start = `end_date` der Vorsaison (exklusiv), Ende = eigenes `end_date`. Kopplung an Feeds: handball.net-Wettbewerbe per **Jahr** (aus Feed-Name vs. `end_date`-Jahr), Trainings-/iCal-Feeds per **Datumsbereich** (`inActiveSeasonRange`) → keine Alt-Saison-Termine.

---

## Letzter Stand
Versionen: `gegneranalyse.html` v1.260623.0941 · `handball-bank-statistik.html` v5.260807.1502 · `mannschaftsstatistik.html` v1.260609.1051 · `trainingsplaner.html` v1.260612.1609 · `spielerstatistik.html` v1.260621.1333 · `index.html` v1.260612.1624 · `kalender.html` v1.260608.1946 · `mannschaftsverwaltung.html` v1.260608.0852 · `mein-profil.html` v1.260508.1200 · `nutzerverwaltung.html` v1.260503.1400/v1.260508.2200 · `quick-service.ts` (sportdata-JSON, deployt)
Migrationen: `profiles.aktive_saison_id` ✓ (09.06.) · `mannschaft_spieler.angriff_pos` & `gegner_spieler.position` `KR→KS` ✓ (12.06.). Keine offenen Pflicht-Migrationen bekannt (Änderungen seit 12.06. nicht dokumentiert, siehe Session 20.09.2026).
Zuletzt bearbeitet: 20. September 2026 (CEST) – `CLAUDE.md`, `scripts/validate.sh`, `STATUS.md`
