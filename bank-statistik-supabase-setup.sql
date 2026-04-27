-- ═══════════════════════════════════════════════════════════════
-- HANDBALL BANK-STATISTIK — Supabase Setup
-- In Supabase: SQL Editor → New Query → Run
-- ═══════════════════════════════════════════════════════════════

-- ── 1. SPIELE ──────────────────────────────────────────────────
-- Spielmetadaten: ein Datensatz pro Spiel
CREATE TABLE IF NOT EXISTS spiele (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  datum       DATE,
  uhrzeit     TIME,
  liga        TEXT DEFAULT '',
  spielnr     TEXT DEFAULT '',
  heim        TEXT DEFAULT '',          -- eigene Mannschaft (immer "Heim" im Sinne der App)
  gast        TEXT DEFAULT '',          -- Gegner
  ort         TEXT DEFAULT '',
  spielart    TEXT DEFAULT 'heim',      -- 'heim' | 'auswaerts'
  hz          INTEGER DEFAULT 1,
  score_home  INTEGER DEFAULT 0,
  score_away  INTEGER DEFAULT 0,
  status      TEXT DEFAULT 'geplant',   -- 'geplant' | 'live' | 'beendet'
  timer_offset INTEGER DEFAULT 0,       -- Spieluhr in Sekunden (zuletzt gespeichert)
  notizen     TEXT DEFAULT '',
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ── 2. SPIELER-LINEUP ──────────────────────────────────────────
-- Spielerliste je Spiel (Aufstellung)
CREATE TABLE IF NOT EXISTS spieler_lineup (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  spiel_id    UUID REFERENCES spiele(id) ON DELETE CASCADE NOT NULL,
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  nummer      TEXT DEFAULT '',
  name        TEXT DEFAULT '',
  pos         TEXT DEFAULT 'FL',        -- 'FL' (Feldspieler) | 'TH' (Torhüter)
  bench       BOOLEAN DEFAULT FALSE,    -- auf der Bank (ausgezogen)
  sort_order  INTEGER DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ── 3. SPIELAKTIONEN ───────────────────────────────────────────
-- Jede erfasste Aktion (ein Datensatz pro Tipp auf der Bank)
CREATE TABLE IF NOT EXISTS spielaktionen (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  spiel_id     UUID REFERENCES spiele(id) ON DELETE CASCADE NOT NULL,
  spieler_id   UUID REFERENCES spieler_lineup(id) ON DELETE CASCADE NOT NULL,
  user_id      UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type         TEXT NOT NULL,           -- 'tor', 'assist', 'turnover', etc.
  label        TEXT NOT NULL,           -- Anzeigename
  color        TEXT DEFAULT '',
  polarity     INTEGER DEFAULT 0,       -- +1 (positiv) | -1 (negativ)
  spielminute  INTEGER DEFAULT 0,
  erstellt_am  TIMESTAMPTZ DEFAULT NOW()
);

-- ── 4. ROW LEVEL SECURITY ──────────────────────────────────────
-- Jeder Trainer sieht nur seine eigenen Spiele

ALTER TABLE spiele ENABLE ROW LEVEL SECURITY;
ALTER TABLE spieler_lineup ENABLE ROW LEVEL SECURITY;
ALTER TABLE spielaktionen ENABLE ROW LEVEL SECURITY;

-- Policies: jeder Nutzer darf nur auf seine eigenen Zeilen zugreifen
CREATE POLICY "spiele_own"   ON spiele         FOR ALL USING (user_id = auth.uid());
CREATE POLICY "lineup_own"   ON spieler_lineup FOR ALL USING (user_id = auth.uid());
CREATE POLICY "aktionen_own" ON spielaktionen  FOR ALL USING (user_id = auth.uid());

-- ── 5. INDEXES ─────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_spiele_user     ON spiele(user_id, datum DESC);
CREATE INDEX IF NOT EXISTS idx_lineup_spiel    ON spieler_lineup(spiel_id);
CREATE INDEX IF NOT EXISTS idx_aktionen_spiel  ON spielaktionen(spiel_id);
CREATE INDEX IF NOT EXISTS idx_aktionen_sp     ON spielaktionen(spieler_id);

-- ═══════════════════════════════════════════════════════════════
-- FERTIG. Tabellen, RLS und Indexes angelegt.
-- ═══════════════════════════════════════════════════════════════
