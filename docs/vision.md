# Vision

One page max. New session? Start here, then `decisions.md` (D14). Detailed design: `docs/design/`.

## Pitch
A creature-collecting RPG where battles are real-time autobattles: recruit, level and combine a squad whose synergies win fights you watch unfold. Pokémon's progression, without Pokémon's boring battles.

## Pillars
1. **The squad is the game** — the depth is in team building: companion choice, active spells, items, traits, evolutions, synergies, counters.
2. **Battles worth watching** — real time, 6 vs 6, speed and size matter, statuses and combos chain. Fights are short, readable (you see *why* you won or lost) and flashy.
3. **Collect and grow** — the adventure rewards new companions and items; every fight feeds progression.

## Layers
1. **Fight** *(prototype focus)* — see `design/combat.md`.
2. **Team management** *(next)* — out of combat: level-ups, choosing one ability per slot (auto / cooldown / ultimate) from the companion's options, items, traits, evolutions, team composition and counters. Most of the design work goes here.
3. **Adventure / RPG** *(later)* — Pokémon-style progression; new companions found or won here. Stand-in until then: a route of 5–8 fights on a node map.

## Key design rules
- Companions, spells, items, statuses: **data, not code** (`design/companions.md`).
- Values are **calculated at cast time** through one modifier stack: additive baseline, one multiplicative layer last (`design/combat.md`).
- Damage **ranges** give elements personality: reliable vs. swingy.
- Fights are **deterministic from a seed** → mass simulation for balancing.

## Prototype scope
1. Battle simulation core (headless, seeded): movement, sizes/collision, targeting, stats incl. defenses/resistances, modifier stack, damage ranges, death, win/loss.
2. Abilities: auto attack (fills mana) + cooldown ability + ultimate (mana) + passive per companion, with conditions and targeting; statuses (stun, slow, fear, burn, poison) with stacking rules, and combos.
3. Top-down **3D** battle view (greybox low-poly: shapes, colors, hit flashes, damage numbers, status icons) + post-fight summary (damage/healing/CC per companion).
4. Pre-fight placement + speed-up button.
5. First 4 companions (Bear, Lizard, Axolotl, Spider).
6. Batch simulation tool: N seeded fights, win rates per companion.
7. Remaining 6 companions.

Not in the prototype: items, team management, route/adventure.

## What it is NOT (v1)
- Multiplayer — not ruled out later (PvP against friends), not in v1
- Pokémon-style overworld — node-map route first
- Realistic graphics
- Action combat by the player — the player's in-fight role is small; exact actions open (`design/combat.md`)
