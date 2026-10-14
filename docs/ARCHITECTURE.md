# Architecture

High-level only. No file-by-file map — agents read code for that.
**Update in the same commit** whenever a system is added, removed or renamed.

## Stack
- **Engine:** Godot 4.7.x (stable), Compatibility renderer (D11)
- **Language:** GDScript (static typing preferred)
- **Tests:** gdUnit4 v6.2.1 (vendored in `game/addons/gdUnit4/`), run headless
- **Checks:** `tools/check --fast | --full` — the only entry point; hooks, skills and CI all call it
- **CI:** GitHub Actions runs `tools/check --full` on push *(added with first features)*

## Folders
- `game/` — Godot project
  - `game/assets/` — every file here needs a row in `assets.csv`
  - `game/data/` — tuning/balance values (resources or JSON)
  - `game/tests/` — automated tests (gdUnit4 only scans inside the Godot project)
  - `game/addons/` — third-party Godot plugins, committed as-is (don't edit)
- `tools/` — check, screenshot, asset-ledger and simulation scripts
- `docs/` — see CLAUDE.md

## Systems
_None yet. Add one entry per system: name, responsibility, how it talks to others (signals, autoloads, data)._

## Conventions
- Files/folders: `snake_case`. Classes: `PascalCase`. Signals: past tense (`enemy_died`).
- Systems communicate via signals; autoloads only for truly global state.
- No magic numbers in scripts — read from `game/data/`.

## Where data lives
- Tuning values: `game/data/`
- Asset provenance: `assets.csv`
