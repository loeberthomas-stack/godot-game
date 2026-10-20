# Backlog

Small, concrete items. Each links to a spec in `docs/specs/` before work starts.
Order = priority.

## Setup (environment, D1–D9)
- [x] Repo skeleton + docs + CLAUDE.md
- [x] Godot 4 project in `game/`
- [x] gdUnit4 installed, one passing smoke test
- [x] `tools/check` (`--fast` / `--full`)
- [ ] Asset ledger check script
- [ ] Scene smoke test (load every scene headless)
- [ ] Lint/format hook on edit
- [ ] `.claude/settings.json`: narrow allow rules + deny force push
- [ ] Review subagent
- [ ] Skills: install skill-creator + Godot skill (after review)
- [ ] Skills: write `/feature`, `/add-asset`, `/end-session`, `/playtest`

## Game — prototype (layer 1, see vision.md)
_Each item needs a spec in `docs/specs/` before work starts. No game feature before the Setup list is done._
- [ ] Flat arena with hills and walls
- [ ] Third-person WASD movement + camera (no "up = Y" assumption, D13)
- [ ] Auto-cast spell + key-press spell
- [ ] Enemy type + spawner that scales over time
- [ ] XP / coin drops and pickup
- [ ] Level-up: pick 1 of 3 upgrades
- [ ] One companion: follow + attack
- [ ] Run win condition
