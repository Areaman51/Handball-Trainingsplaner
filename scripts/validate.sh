#!/usr/bin/env bash
# Validierung vor jeder Auslieferung (CLAUDE.md, Regel 9).
#
# Aufruf:  scripts/validate.sh            → alle *.html und *.js im Repo-Root
#          scripts/validate.sh datei ...  → nur die genannten Dateien
#
# FEHLER  → Exit-Code 1, nicht ausliefern.
# WARNUNG → Altlast in unveränderter Datei, wird beim Anfassen der Datei behoben.
# Kompatibel mit macOS-bash 3.2 (kein mapfile, keine assoziativen Arrays).

set -u
cd "$(dirname "$0")/.." || exit 2

fehler=0
warnungen=0
fehl()  { echo "FEHLER   $1"; fehler=$((fehler + 1)); }
warn()  { echo "WARNUNG  $1"; warnungen=$((warnungen + 1)); }
info()  { echo "         $1"; }

VERSION_RE='v[0-9]+\.[0-9]{6}\.[0-9]{4}'

if [ "$#" -gt 0 ]; then
  dateien="$*"
else
  dateien=$(ls *.html *.js 2>/dev/null)
fi

# Geänderte Dateien (gegenüber HEAD, inkl. neuer Dateien): dort sind Versionsfehler fatal.
geaendert=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  geaendert=$( { git diff --name-only HEAD 2>/dev/null; git ls-files --others --exclude-standard 2>/dev/null; } | sort -u)
fi
ist_geaendert() { printf '%s\n' "$geaendert" | grep -qxF "$1"; }

# Versionsfehler: fatal bei geänderten Dateien, sonst nur Warnung.
versionsproblem() {
  if ist_geaendert "$1"; then fehl "$1: $2"; else warn "$1: $2 (Altlast, ungeänderte Datei)"; fi
}

# ── 1. Fatales Muster <\/script> ────────────────────────────────────────────
for f in $dateien; do
  if grep -n -F '<\/script>' "$f" >/dev/null 2>&1; then
    fehl "$f: fatales Muster <\\/script> in Zeile(n): $(grep -n -F '<\/script>' "$f" | cut -d: -f1 | tr '\n' ' ')"
  fi
done

# ── 2. <script>-Tags ausgeglichen (nur HTML) ────────────────────────────────
for f in $dateien; do
  case "$f" in *.html) ;; *) continue ;; esac
  auf=$(grep -o -i -E '<script[ >]' "$f" | wc -l | tr -d ' ')
  zu=$(grep -o -i -F '</script>' "$f" | wc -l | tr -d ' ')
  [ "$auf" -eq "$zu" ] || fehl "$f: <script>-Tags unausgeglichen ($auf geöffnet, $zu geschlossen)"
done

# ── 3. Version: Kommentar nach <!DOCTYPE html> = Sidebar-Footer, Präfix, erhöht ──
for f in $dateien; do
  case "$f" in *.html) ;; *) continue ;; esac
  erste=$(sed -n '1p' "$f")
  kommentar=$(sed -n '2p' "$f" | grep -o -E "$VERSION_RE" | head -1)
  case "$erste" in
    *'<!DOCTYPE html>'*|*'<!doctype html>'*) ;;
    *) fehl "$f: Zeile 1 ist nicht <!DOCTYPE html>" ;;
  esac
  if [ -z "$kommentar" ]; then
    versionsproblem "$f" "kein Versions-Kommentar direkt nach <!DOCTYPE html>"
    continue
  fi
  anzahl=$(grep -o -E "$VERSION_RE" "$f" | sort -u | wc -l | tr -d ' ')
  if [ "$anzahl" -ne 1 ]; then
    versionsproblem "$f" "Versionen an mehreren Stellen uneinheitlich: $(grep -o -E "$VERSION_RE" "$f" | sort -u | tr '\n' ' ')"
  fi
  if [ "$(grep -o -E "$VERSION_RE" "$f" | wc -l | tr -d ' ')" -lt 2 ]; then
    versionsproblem "$f" "Version nur an einer Stelle (Kommentar und Sidebar-Footer müssen beide gesetzt sein)"
  fi
  if [ "$f" = "handball-bank-statistik.html" ]; then
    case "$kommentar" in v5.*) ;; *) versionsproblem "$f" "Präfix muss v5. sein, ist $kommentar" ;; esac
  else
    case "$kommentar" in v1.*) ;; *) versionsproblem "$f" "Präfix muss v1. sein, ist $kommentar" ;; esac
  fi
  # Bei geänderten, bereits versionierten Dateien muss die Version erhöht worden sein.
  if ist_geaendert "$f" && git cat-file -e "HEAD:$f" 2>/dev/null; then
    alt=$(git show "HEAD:$f" | sed -n '2p' | grep -o -E "$VERSION_RE" | head -1)
    if [ -n "$alt" ] && [ "$alt" = "$kommentar" ]; then
      fehl "$f: geändert, aber Version unverändert ($kommentar)"
    fi
  fi
done

# ── 4. // @ts-check als erste Zeile jeder .js-Datei ─────────────────────────
for f in $dateien; do
  case "$f" in *.js) ;; *) continue ;; esac
  [ "$(sed -n '1p' "$f")" = "// @ts-check" ] || fehl "$f: erste Zeile ist nicht '// @ts-check'"
done

# ── 5. Syntaxprüfung (nur wenn node vorhanden) ──────────────────────────────
if command -v node >/dev/null 2>&1; then
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  for f in $dateien; do
    case "$f" in
      *.js)
        cp "$f" "$tmp/modul.mjs"
        node --check "$tmp/modul.mjs" >"$tmp/out" 2>&1 || { fehl "$f: Syntaxfehler"; sed 's/^/           /' "$tmp/out" | head -8; }
        ;;
      *.html)
        # Inline-Skripte (ohne src, ohne importmap) je Block extrahieren.
        awk -v dir="$tmp" '
          /^[[:space:]]*<script([[:space:]][^>]*)?>[[:space:]]*$/ && !/src=/ && !/importmap/ {
            n++; ext = ($0 ~ /type="module"/) ? "mjs" : "js"; datei = dir "/block" n "." ext; drin = 1; next }
          /^[[:space:]]*<\/script>/ { drin = 0; next }
          drin { print > datei }' "$f"
        for b in "$tmp"/block*; do
          [ -e "$b" ] || continue
          node --check "$b" >"$tmp/out" 2>&1 || { fehl "$f: Syntaxfehler in Inline-Skript"; sed 's/^/           /' "$tmp/out" | head -8; }
          rm -f "$b"
        done
        ;;
    esac
  done
else
  info "Syntaxprüfung übersprungen (node nicht gefunden)."
fi

echo
if [ "$fehler" -gt 0 ]; then
  echo "Validierung FEHLGESCHLAGEN: $fehler Fehler, $warnungen Warnung(en)."
  exit 1
fi
echo "Validierung bestanden: 0 Fehler, $warnungen Warnung(en)."
