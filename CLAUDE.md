# CLAUDE.md

Solo game project. Thomas owns *what* and *why*; Claude Code owns *how*.
Thomas does not read code — tests and the review subagent are the gates.

## Start of every session
1. Read `docs/progress.md`.
2. Read the spec you're working on in `docs/specs/`.
3. Skim `docs/gotchas.md`.

## Where things live
| File | What | Update when |
|---|---|---|
| `docs/vision.md` | What the game is / isn't, pillars | Game concept changes |
| `docs/design/` | Detailed game design (combat, companions, …) | Design decided in chat |
| `docs/style-guide.md` | Art + audio rules, generation recipes | Style or recipe changes |
| `docs/ARCHITECTURE.md` | Stack, systems, conventions, where data lives | **Same commit** as adding/removing/renaming a system |
| `docs/decisions.md` | Decision log (D1, D2, …) | A real choice is made |
| `docs/backlog.md` | Next features, small and concrete | Specs added / features done |
| `docs/specs/` | One spec per feature (written in chat) | Before a feature starts |
| `docs/progress.md` | Current state, half-done, next | End of every session (`/end-session`) |
| `docs/glossary.md` | Game terms | A new concept appears |
| `docs/playtest-log.md` | Dated feel/fun notes | After a playtest (`/playtest`) |
| `docs/gotchas.md` | Engine quirks, mistakes already hit | A bug needed more than 2 attempts |
| `assets.csv` | Ledger for every file in `game/assets/` | Every asset added (`/add-asset`) |

## Working rules
- **Pull at the start of every session.**
- **Push after every commit** — chat writes specs to the repo, so local-only commits cause conflicts.
- **Plan first.** Every feature starts in plan mode. Plans are plain language: what changes, what Thomas will see in-game, how it's tested, risks. No code in plans.
- **One feature per session.** If it doesn't fit, split the spec before starting.
- **"Done" means `tools/check --full` passes.** Never report done otherwise.
- **Never delete or weaken a test** without stating the reason in the commit message.
- **Two-strike rule:** if a bug survives two fix attempts, stop, revert, rethink, and log it in `docs/gotchas.md`.
- **Tuning numbers live in data files** under `game/data/`, never hardcoded, never in markdown.
- **No asset without a ledger row** in `assets.csv` and a style-guide check.
- **Commit after every working feature.** Never force push.

## Stack (details in ARCHITECTURE.md)
Godot 4 (stable) · GDScript · gdUnit4 · `tools/check` is the single check entry point.
