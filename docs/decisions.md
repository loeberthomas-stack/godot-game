# Decisions Log

Format: what we decided, why, date. Open questions at the bottom.

---

## D1 — Environment first, game later (2026-10-11)
**Decision:** Set up the full work environment before writing any game code. The game concept is out of scope for now.
**Why:** The previous attempt (Unity tower defense) failed by jumping into execution too fast; frustration came from art/assets and a clunky Cowork → Claude Code copy-paste workflow.

## D2 — Repo structure & persistent docs (2026-10-11)
**Decision:**
```
/game            Godot/engine project
/tests           automated tests
/tools           scripts (tests, screenshots, sims, asset check)
/docs
  vision.md         1 page: what the game is / isn't, pillars
  style-guide.md    art + audio direction rules (palette, one visual approach, generation recipes — see D9)
  ARCHITECTURE.md   stack + systems + conventions + where data lives (high-level, NOT a file map)
  decisions.md      this log
  backlog.md        next features, small and concrete
  specs/            one spec per feature (written in chat, see D5)
  progress.md       current state / half-done / next — updated every session end
  glossary.md       game terms for consistent naming
  playtest-log.md   dated feel/fun notes
  gotchas.md        engine quirks & mistakes already hit
assets.csv       asset ledger: path, source URL/tool, author/model, license/terms, attribution needed, AI-generated (y/n), prompt/recipe ref (see D9)
LICENSE          license for own project
CLAUDE.md        short index + working rules, points to /docs
```
**Rules:**
- Asset ledger is machine-checked: a script in /tools fails if any file in /game/assets has no ledger row; runs with the tests.
- ARCHITECTURE.md must be updated in the same commit when a system is added/removed/renamed (enforced in CLAUDE.md, checked by review subagent).
- Every doc needs a clear update trigger, otherwise it doesn't exist.
- Balance/tuning numbers live in data files, not markdown. Bugs → GitHub Issues if the list grows.
- Git from day one, commit after every working feature.

**Why:** Agents need intent and context in the repo, not in chat history. File-by-file code maps go stale; high-level architecture doesn't.

## D3 — Skills strategy (2026-10-11)
**Decision:**
- Borrow engine knowledge: Anthropic `skill-creator` (anthropics/skills) + a Godot skill (candidate: Randroids-Dojo/Godot-Claude-Skills — test runner, headless PlayGodot automation, CI).
- Write own workflow skills (via skill-creator): `/feature`, `/add-asset`, `/end-session`, `/playtest`.
- Don't install large skill collections up front; add engine skills only when Claude repeatedly gets something wrong.
- Review third-party skills (incl. scripts) before installing.
- Skip "build the whole game from a description" pipelines (e.g. Godogen) — but borrow the screenshot-based visual QA idea.

**Why:** Generic repos cover engine knowledge; doc upkeep and workflow are project-specific.

## D4 — Work loop (2026-10-11)
**Decision:**
- **Two modes:** Claude chat = deciding/specifying (what & why). Claude Code = building (how). Handoff via files in the repo, never copy-paste.
- **Two-level planning:** chat produces a *spec* (goal, acceptance criteria, out of scope); Claude Code turns it into a *technical plan* in plan mode against the real code. Thomas approves every plan.
- **Plans written in plain language:** what changes, what Thomas will see in-game, how it's tested, risks. No code in plans.
- **Thomas doesn't read code** unless necessary → tests + review subagent are mandatory gates, not optional.
- **Feature cycle (`/feature`):** pick spec → plan mode → approve → build + tests → automated checks (tests, asset ledger, screenshot) → review subagent → Thomas playtests for feel → docs updated + commit.
- **Pipelining:** while Claude Code builds feature N, chat specs feature N+1. Only one feature executes at a time.
- **Guardrails:** one feature fits one session (else split); two-strike rule on bugs (2 failed fixes → stop, revert, rethink, log in gotchas.md); sessions start by reading progress.md and end with `/end-session`.

**Why:** Approving plans instead of code keeps Thomas in control without reading code. Specs-as-files remove the copy-paste relay. Pipelining uses waiting time without running two builds into each other.

## D5 — Spec handoff: chat commits to repo (2026-10-11)
**Decision:** Chat writes specs directly into the GitHub repo (`/docs/specs/` + `backlog.md`). Claude Code pulls and picks them up. No GitHub Issues for specs for now.
**Why:** One place, no extra system, no copy-paste. Revisit if tracking gets messy.

## D6 — Permissions: auto mode, not bypass (2026-10-11)
**Decision:**
- Claude Code (desktop app, Code tab, running locally) uses **Auto mode** for building: a classifier reviews risky actions instead of prompting for each one.
- Plan mode stays first for every feature; approve with "Yes, and use auto mode".
- Narrow allow rules in project `.claude/settings.json` for routine commands (godot headless, test runner, git add/commit).
- Deny rules for things that should never happen (e.g. force push).
- **No bypassPermissions** on the host machine — only acceptable inside a container/VM.
- Safety net = git commit after every feature.

**Why:** "Always allow" click fatigue was the biggest annoyance; auto mode removes routine prompts while keeping a safety check. Bypass has no protection against mistakes or prompt injection.

## D7 — Engine: Godot 4 (2026-10-11)
**Decision:** Godot 4 (current stable), scripting in GDScript (not C#).
**Accepted trade-offs:**
- Realistic, high-end 3D graphics are not a goal for this project; stylized art direction instead.
- Massive entity counts (~100k) are not a pillar. Plan for hundreds to low thousands of enemies. If a future game needs huge hordes, revisit engine (Unity 6 + ECS was the alternative).
**Why GDScript:** best-known by Claude, no .NET build step, simplest headless testing/CI.
**Why Godot:** text-based scenes/resources Claude can read and edit, headless CLI for automated tests/screenshots/sims, lightweight and solo-friendly.

## D8 — Automation layer (2026-10-11)
**Decision:**
- **One entry point:** `tools/check` (`--fast` / `--full`). Hooks, `/feature`, and CI all call it — never their own variants.
- **Checks by timing:**
  - After every file edit (Claude Code hook): lint + format on changed script.
  - Before Claude reports "done": full test suite, asset ledger check, scene smoke test (load every scene headless, fail on any error), screenshots of key scenes.
  - Before commit: review subagent.
  - On push: GitHub Actions runs `check --full` as backstop.
  - Later: overnight simulation/balance runs once gameplay exists.
- **Test framework:** gdUnit4 (CLI runner, GitHub Action, scene runner with input simulation). Verify compatibility with the chosen Godot skill at install; GUT is the fallback.
- **Screenshot QA:** no pixel-perfect golden images. Automated dumb checks (all-black screen, magenta missing-texture) + Claude visually reviews screenshots against spec and style guide.
- **Review subagent checklist:** every acceptance criterion has a test; **no tests deleted or weakened without a stated reason**; docs updated (ARCHITECTURE.md, assets.csv); CLAUDE.md conventions followed.
- **Scope at setup:** only `tools/check`, lint hook, test runner, asset check, scene smoke test, review subagent. Screenshots + CI with the first features; simulations only once there's gameplay.

**Why:** One script = "passed" always means the same thing. Fast checks run constantly, slow ones at gates. The review subagent replaces Thomas reading code. Building the full pipeline before a game exists would repeat the "too fast into execution" trap in a different form.

## D9 — Art & audio: process now, style with the game (2026-10-11)
**Decision:** The concrete style is chosen together with the game concept. The process rules apply regardless:
- **Style guide before first asset**: fixed palette (~8–16 colors), one rendering approach, size/scale reference.
- **Greybox first**: shapes + solid colors until gameplay is fun; art comes after fun.
- **One source family per game**: one creator/pack, or one fixed generation recipe — never a mix.
- **Prefer procedural / in-engine art** (shaders, particles, simple geometry) where possible — Claude can make and tweak it as code.
- **Juice over detail**: screen shake, hit flashes, particles, sound feedback.
- **AI generation is welcome** for visuals, music and sound (Thomas's weakest area), under these rules:
  - **Recipes, not one-offs:** each asset type has a documented recipe in style-guide.md (tool, model/version, prompt template, reference images/seed). New assets are generated from the recipe.
  - **Unify in-engine:** run generated art through a shared post-process (e.g. palette-limiting / outline shader) so everything looks like one game.
  - **Sound effects:** prefer procedural/code-generated SFX where it fits; AI or packs otherwise.
  - **Licensing:** only tools/tiers whose terms allow commercial use; terms recorded in assets.csv. Track AI-generated content (store pages like Steam ask for disclosure).
- Every asset goes through `/add-asset` (ledger row + style-guide check).
- Concrete generator tools: chosen at game-concept time (after checking current terms).

**Why:** The last attempt's art failed on inconsistency, not on lack of assets. AI generators make inconsistency *worse* unless locked down by recipes and a unifying in-engine pass.

## D10 — Project license: all rights reserved (2026-10-11)
**Decision:** Proprietary, all rights reserved. Third-party assets keep their own licenses (recorded in assets.csv).
**Why:** Keeps every option open; switching to an open license later is easy, taking one back is not.

---

## Open questions
- None.
