# Combat Design

Living design reference for the fight layer. First draft — numbers are examples, not balance. Specs in `docs/specs/` refine individual parts.

## Basics
- **6 vs 6**, real time, top-down, until one team is dead.
- Player positions the team before the fight, then watches (speed-up button). In-fight player actions: **open question**, see below.
- **Deterministic:** a fight runs headless from a seed — every damage roll, crit and proc included — so fights can be mass-simulated for balancing (D8) and replayed exactly.

## Positioning and movement
- **Fine-grained positioning**, no coarse one-unit-per-tile grid. Companions have different sizes (e.g. 6 vs 8 units across) with matching hit/hurt boxes.
- Fine hex grid vs. continuous space with circular footprints: decided in the technical plan (leaning continuous; placement can still snap to a grid).
- **Move speed:** distance a companion can move per second.

## Spells
- **Spell library:** spells are defined once and can be assigned to many companions (Pokémon-style learnsets).
- **3 active spells** per companion, chosen from a larger arsenal in the team management layer.
- **Attributes:** cast time, damage (a **range**), crit chance, crit damage, range, cooldown, area, status effects applied, …
- **Selection:** a companion casts its highest-priority spell that is in range, off cooldown and whose **condition** is met; otherwise the next; otherwise it moves.
- **Conditions** (gambit-style, like Final Fantasy XII): "ally in range below 50 % HP", "≥ 3 enemies in area", "target is stunned", … May later become player-tunable in the team management layer.
- **Defensive spells** exist: shields, block, reflect, damage reduction, cleanse, …

## Damage variance as personality
Damage ranges are a design tool, not noise. Some spells/elements are **reliable** (narrow range), others are **swingy** (wide range, high potential).
Example direction: fire = high potential, unreliable; ice = lower, steady. Balance target is expected value; variance is flavour.

## Stats
**Offensive:** damage, crit chance, crit damage, cast speed, attack/spell range, …
**Defensive:** HP, armor, block, reflect, **resistance per element** (fire, water, …).
**Movement:** move speed, size.

Element resistances make team composition matter: facing a water-heavy team, you swap fire out and bring nature. Matchups come from stats (default resistances per element, modifiable by items/level-ups) — not a separate hard-coded type chart, so there is one system, not two.

## Modifier stack (decided)
Values are **calculated at cast/hit time, never stored as final numbers.** Sources: level-ups, items, auras, timed buffs, potions, combos, statuses.

Order of operations:
1. **Base** value (from the spell/companion data)
2. **+ Flat** bonuses
3. **× (1 + sum of additive %)** — items, power-ups, level-ups: all additive with each other
4. **× each multiplicative modifier** — buffs (e.g. "+10 % damage for 20 s" from a companion) and similar, applied last
5. Roll within the damage range, then crit, then target defenses/resistances

Additive is the baseline; one multiplicative layer at the end. Which sources are multiplicative is decided per modifier in data.

## Status effects
Hard/soft control: **stun, fear, root, slow**, … Damage/heal over time: **burn, poison, bleed** (DoTs), **regeneration** (HoTs), …
Each status: duration, stacking rule (refresh / stack / ignore), visual indicator (must stay readable with 12 units on screen).

## Combos
Spells can get bonuses against targets with a status, e.g.:
- +50 % crit chance against **stunned** targets
- +20 % damage against **burning** targets

Combos create synergies **between companions** (Bear stuns → Cat crits) and **within one companion** (spell 1 applies burn, spell 3 punishes burning). Combos are modifiers in the same stack, with a condition — not a separate system.

## Items (later — team management layer)
Equippable items that give bonuses (feed the modifier stack). Ideally visible on the companion — later step, after greybox.

## Open questions
- **Player actions during the fight** (potions, spells) — contradicts D14 ("you position, then watch"); decide before speccing
- How wide damage ranges may go in general (balance via simulation)
- Status stacking rules per status
- Condition system design (what conditions exist, how they're expressed in data)
- Synergy rules (what shared tags actually do) — see `companions.md`
- Fight length target (assumption: 20–40 s at normal speed)
