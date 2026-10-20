# Vision

One page max. New session? Start here, then `decisions.md` (D13).

## Pitch
A 3D bullet heaven where you and a squad of quirky elemental companions snowball from weakling to unstoppable.

## Pillars
1. **Snowball power** — you grow exponentially stronger; the fun is optimizing that growth faster than the enemies scale.
2. **Your squad matters** — companions move, think and fight with their own elements; they are not just orbiting weapons.
3. **Short, replayable runs** — level-up choices, companions and elements make every run play differently.

## Layers
1. **Run** *(prototype focus)* — third-person WASD in a 3D world, waves of enemies that scale over time. Spells fire automatically or on click/key, aiming is loose. Companions follow you with simple pathing and AI and attack with melee or magic spells. Kills and coin pickups give XP; level-ups upgrade your spells or companions (percentage boosts). The run has a win condition.
2. **Character management** *(later)* — between runs: a flat set of base attributes to level up (HP, crit %, crit damage, base damage, projectile size, autocast frequency, …). Runs scale these by %; this layer sets the base values. Maybe multiple heroes, items or buffs later.
3. **Adventure / RPG** *(long shot)* — Pokémon-style progression through a story by beating runs and boss levels. Possibly its own game; the game may be engaging enough without it.

## Elements
Fire, ice, electric, poison — for spells, companions and enemies.

## Maps
- **Prototype:** flat arena with hills and walls, procedurally varied.
- **Later experiment (time-boxed):** spherical "planet" maps of different sizes, gravity pulling towards the center, horizon not visibly curving. Systems should not assume "up = Y" so the experiment stays cheap (D13).

## Prototype scope (layer 1 only)
- Flat arena with a few hills and walls
- Third-person WASD movement; one auto-cast spell + one spell on key press
- One enemy type, spawning more and stronger over time
- XP / coin drops; level-up = pick 1 of 3 upgrades
- **One** companion that follows and attacks
- Win condition (survive X minutes or kill a final boss)
- Low-poly placeholder graphics (greybox first, D9)

Fun with grey cubes first; elements, more companions and the planet come after.

## Open questions
- Run length (survivors-likes: 10–30 min) — decides pacing and win condition
- Companions: brought into the run, found during it, or both
- Can companions die — balancing question, out of the prototype
- Exact level-up mechanics

## What it is NOT (for now)
- Story-driven (layer 3 is a long shot)
- Multiplayer
- Realistic graphics or precision aiming
- 100k-entity hordes — hundreds of enemies (D7)
