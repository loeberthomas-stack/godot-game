# Vision

One page max. New session? Start here, then `decisions.md` (D14).

## Pitch
A creature-collecting RPG where battles are real-time autobattles: recruit, level and combine a squad whose synergies win fights you watch unfold. Pokémon's progression, without Pokémon's boring battles.

## Pillars
1. **The squad is the game** — the depth is in team building: companion choice, active spells, traits, evolutions, synergies.
2. **Battles worth watching** — real time, 6 vs 6, speed matters, sizes matter. Fights are short, readable (you see *why* you won or lost) and flashy.
3. **Collect and grow** — the adventure rewards new companions; every fight feeds progression.

## Layers
1. **Fight** *(prototype focus)* — two teams of 6 fight in real time on a top-down battlefield until one side is dead. The player positions the team before the fight, then watches (speed-up button). No control during the fight (D14).
2. **Team management** *(next)* — out of combat only: level-ups, choosing the 3 active spells from a bigger arsenal, traits, evolutions, combining companions for synergies. Most of the design work goes here.
3. **Adventure / RPG** *(later)* — Pokémon-style progression; new companions are found or won here. Stand-in until then: a route of 5–8 fights on a node map, with XP and recruit rewards.

## Fight rules (first draft — refine in specs)
- **6 vs 6.**
- **Fine-grained positioning:** no coarse one-unit-per-tile grid. Companions have different sizes (e.g. 6 vs 8 units across) with matching hit/hurt boxes. Fine hex grid vs. continuous space with circular footprints: decided in the technical plan.
- **Move speed:** distance a companion can move per second.
- **3 active spells** per companion, chosen from a larger arsenal in the team management layer.
- **Spells have range, cooldown and priority.** A companion casts its highest-priority spell that is in range and off cooldown, otherwise the next one, otherwise it moves.
- **Known gap:** pure priority is too dumb for situational spells (e.g. heal only when an ally in range is low). Direction: each spell gets a **condition** ("ally below 50 % HP", "≥ 3 enemies in area") — gambit-style, like Final Fantasy XII. Conditions may later become something the player tunes in the team management layer.
- **Roles are tendencies, not boxes:** hybrids are allowed (e.g. a tanky healer).
- **Spell library:** spells are defined once (e.g. Chain Lightning) and can be assigned to many companions — Pokémon-style learnsets.
- **Spell attributes:** cast time, damage, crit chance, crit damage, range, cooldown, … Damage is a **range** (Firebolt 25–30, Chain Lightning 10–50), not a fixed number.
- **Values are calculated at cast/hit time, never stored as final numbers.** A spell's base values pass through a **modifier stack** from all active sources: level-ups (e.g. +crit for all of a companion's spells), timed buffs (+10 % damage for 20 s), auras, potions, items. Order of operations must be fixed and documented (proposal: base → flat bonuses → additive % → multiplicative %), because it decides how fast power snowballs.
- **Deterministic simulation:** a fight runs headless from a seed — including every damage roll and crit — so thousands of fights can be simulated for balancing (D8) and any fight can be replayed exactly.

## Initial companions (draft, not final)
| Companion | Element | Likely role tendency |
|---|---|---|
| Marten | Electric | Fast skirmisher / assassin |
| Lizard | Fire | Ranged mage, area damage |
| Armadillo | Earth / rock | Tank |
| Axolotl | Water | Healer / support |
| Mouse | Arcane | Mage / control |
| Bear | Fighting / blunt | Bruiser, stuns |
| Spider | Nature / poison | Damage over time, control |
| Dog | Doom / warlock | Curses, drain |
| Cat | Bleed / scratch | Assassin, bleed stacks |
| Chicken | Holy | Holy damage + buffs |

**Tags:** every companion has an **element** and an **archetype** (e.g. tank, bruiser, assassin, mage, support), so companions share tags and synergies can form. Exact lists TBD.

**Long term:** the roster grows well beyond 10 — Pokémon-scale (100+) is the horizon, not the prototype. Consequence for the build: companions, spells and tags are **data, not code** from day one. Adding companion #11 or #100 should mean adding a data file (+ art), never writing new systems. New spell *behaviours* may need code; new spells built from existing behaviours must not.

## Prototype scope
1. Battle simulation core (headless, seeded): movement, sizes/collision, targeting, 3 spells with priority/range/cooldown, damage, death, win/loss.
2. Top-down visual battle view of that simulation (greybox: shapes, colors, hit flashes, damage numbers).
3. Pre-fight placement + speed-up button.
4. First 4 companions covering different tendencies (e.g. Armadillo, Bear, Lizard, Axolotl) — prove the system before building all 10.
5. Remaining 6 companions.

Fun to watch with grey shapes first (D9).

## Open questions
- **Player actions during the fight** (potions, spells) — contradicts D14 ("you position, then watch"); decide before speccing
- Modifier stacking rules (additive vs. multiplicative %) and how wide damage ranges may be
- Fine hex grid vs. continuous positioning (technical plan)
- Spell condition system design
- Synergy rules (what shared tags actually do)
- Fight length target (assumption: 20–40 s at normal speed)
- Third-person spectating camera — later

## What it is NOT (v1)
- Control during fights (you position, then watch)
- Multiplayer — not ruled out later (PvP against friends), not in v1
- Pokémon-style overworld — node-map route first
- Realistic graphics
