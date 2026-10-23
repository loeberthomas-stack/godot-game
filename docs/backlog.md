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

## Game — prototype: fight layer (see vision.md, D14)
_Each item needs a spec in `docs/specs/` before work starts. No game feature before the Setup list is done._
- [ ] Battle simulation core: headless, seeded, deterministic (movement, sizes/collision, targeting, damage, death, win/loss)
- [ ] Spells: 3 active per companion, priority + range + cooldown (+ first condition, e.g. heal when ally low)
- [ ] Top-down battle view of the simulation (greybox, hit flashes, damage numbers)
- [ ] Pre-fight placement + speed-up button
- [ ] First 4 companions (e.g. Armadillo, Bear, Lizard, Axolotl)
- [ ] Batch simulation tool: run N seeded fights, report win rates per companion
- [ ] Remaining 6 companions
