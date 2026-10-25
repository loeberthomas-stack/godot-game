# Combat Design

Living design reference for the fight layer. First draft. **Numbers, spells, statuses and combos here are examples of what the system must support** — not final content, balance or limits. Specs in `docs/specs/` refine individual parts.

## Basics
- **6 vs 6**, real time, top-down, until one team is dead.
- Player positions the team before the fight; speed-up button. The player's role during the fight is small (no action combat); whether they get some actions (potions, spells) is an **open question**, see below.
- **Deterministic:** a fight runs headless from a seed — every damage roll, crit and proc included — so fights can be mass-simulated for balancing (D8) and replayed exactly.

## Positioning and movement
- **Fine-grained positioning**, no coarse one-unit-per-tile grid. Companions have different sizes (e.g. 6 vs 8 units across) with matching hit/hurt boxes.
- Fine hex grid vs. continuous space with circular footprints: decided in the technical plan (leaning continuous; placement can still snap to a grid).
- **Move speed:** distance a companion can move per second.

## Abilities (decided 2026-10-25 — topic 1)
Every companion has **three ability slots + one passive**. In team management the player picks **one ability per slot** from the companion's options. Not every ability has to be powerful — a wide range is the goal.

| Slot | Trigger | Role |
|---|---|---|
| **Auto attack** | Whenever nothing else fires | Steady damage, healing or buff; **fills mana**. Melee (move into range first; single target or cleave hitbox) or ranged (projectile, AoE, chain, …). Can itself be a spell (e.g. a small Firebolt). |
| **Cooldown ability** | Cooldown ready **and** condition met | Utility: interrupts, jumps, shields, CC, … |
| **Ultimate** | Mana bar full | The big moment; one per companion |
| **Passive** | Always on | Aura or trait, e.g. "nearby enemies −attack speed", "teammates +fire resistance" |

**Action order** (one action at a time, deterministic): when free → ultimate if mana full → else cooldown ability if ready and condition met → else auto attack.

**Mana**
- Gained from **attacking and from taking damage**; the ratio is per companion in data.
- **Starting mana** per companion (default 0) — tuning knob for openers.
- **No mana gain while casting the ultimate** (prevents chaining).
- **Interrupted ultimate = mana lost.** Guardrail: interrupts must not be so strong that ultimates never land — tuned via short ultimate cast times, long interrupt cooldowns, tenacity / diminishing returns (topic 2), and maybe "unstoppable" ultimates.

**Cooldown abilities**
- **Not available at fight start**: first availability = its own value per ability, default = the full cooldown (staggers the opening; a rogue's opener can be earlier).
- **Fire-ASAP vs. hold-for-condition** is a flag per ability. Holding abilities wait for a valid target.
- **Target selection:** filter = enemies/allies in range that meet the condition (e.g. "currently casting") → then pick by priority (e.g. healer over damage dealer, then lowest HP).

**Healers are mostly hybrids** (examples, not final):
- Druid-style: auto = damage spell ("moonfire"), cooldown = heal over time, ultimate = AoE that heals allies and damages enemies
- Priest-style: auto = heal, cooldown = shield, ultimate = TBD
- Controller-style: auto = damage, cooldown = CC, ultimate = mass heal

**Spell library:** abilities are defined once and can be assigned to many companions (Pokémon-style learnsets).
**Attributes:** cast time, damage (a **range**), crit chance, crit damage, range, cooldown or mana cost, area, statuses applied, targeting rule, condition, …
**Defensive abilities** exist: shields, block, reflect, damage reduction, cleanse, …
**Attack speed is a key stat:** more attacks → more mana → more ultimates.

## Damage variance as personality
Damage ranges are a design tool, not noise. Some spells/elements are **reliable** (narrow range), others are **swingy** (wide range, high potential).
Example direction: fire = high potential, unreliable; ice = lower, steady. Balance target is expected value; variance is flavour.

## Stats
**Offensive:** damage, crit chance, crit damage, cast speed, attack/spell range, …
**Defensive:** HP, armor, block, reflect, **resistance per element** (fire, water, …).
**Movement:** move speed, size.

**Every companion has its own resistance profile** — e.g. the fire lizard resists fire but has negative water resistance. Profiles are per companion (in its data), so companions stay distinct; items and level-ups can modify them. This makes team composition matter: facing a water-heavy team, you swap fire out and bring nature.
Resistances are the **only** matchup system — no additional Pokémon-style type-chart multiplier on top, so a matchup is always explainable by one number.

## Modifier stack (decided)
Values are **calculated at cast/hit time, never stored as final numbers.** Sources: level-ups, items, auras, timed buffs, potions, combos, statuses.

Order of operations:
1. **Base** value (from the spell/companion data)
2. **+ Flat** bonuses
3. **× (1 + sum of additive %)** — items, power-ups, level-ups: all additive with each other
4. **× each modifier in the final layer** — e.g. buffs ("+10 % damage for 20 s"), combos ("+X % per poison stack on the target"), and anything else flagged as final-layer
5. Roll within the damage range, then crit, then target defenses/resistances

Additive is the baseline; one multiplicative layer at the end. **Which layer a modifier belongs to is a property of the modifier, set in data** — the system must not hard-code which source types go where.

## Crit (decided 2026-10-23)
- **Crit damage is its own stat**, base **+50 %** (a crit deals 150 %).
- **Overcrit:** crit chance above 100 % converts into crit damage (proposal: 1 % excess → +1 % crit damage), so the stat never goes dead.
- Rejected for now: tiered "super crits" (flashier, more complex).

## Status effects
Hard/soft control: **stun, fear, root, slow** (e.g. ice slows), … Damage/heal over time: **burn, poison, bleed** (DoTs), **regeneration** (HoTs), …
Each status is data with: duration, tick interval, value per tick, **stacking rule** (refresh / add stack / independent instances / ignore), max stacks, and a visual indicator (must stay readable with 12 units on screen).

Proposal to keep DoTs distinct (not decided):
| Status | Stacking | Ticks | Feel |
|---|---|---|---|
| Poison | Stacks (each application adds a stack, own duration), cap TBD | Slow, steady | Builds up over time; combo fuel ("+X % per stack") |
| Burn | No stacks, reapply refreshes duration | Fast, strong | Burst over a short time |
| Bleed | Stacks, short duration | Medium | Rewards fast repeated hits (cat) |

**Prototype statuses:** stun, slow, fear, burn, poison (+ bleed if cheap) — enough to prove the stacking rules and combos.

## Combos
Spells can get bonuses against targets with a status, e.g.:
- +50 % crit chance against **stunned** targets
- +20 % damage against **burning** targets

Combos create synergies **between companions** (Bear stuns → Cat crits) and **within one companion** (spell 1 applies burn, spell 3 punishes burning). Combos are modifiers in the same stack, with a condition — not a separate system.

## Items (later — team management layer)
Equippable items that give bonuses (feed the modifier stack). Ideally visible on the companion — later step, after greybox.

## Review decisions (2026-10-23)
Answers from the full design review. Where these conflict with older text above, these win.

**Types**
- Damage **types**: physical (blunt, bleed/scratch, …) + elements (fire, water/ice, electric, nature/poison, arcane, holy, doom, …). List TBD.
- **Physical is countered by armor; elements by elemental resistance.**
- Defense formula: TBD (see "Defense formula" topic).

**Attacks and spells**
- Every companion has a **basic attack** (melee or ranged, with a range). Attack speed is a stat.
- A basic attack can itself be a spell (e.g. a fire companion's basic attack is a small Firebolt).
- Resource and priority: see "Abilities" (decided).
- Crit chance: spell base crit + companion crit stat, combined in the additive % step.
- Cast times can be **interrupted** (stun etc.); an interrupted spell goes on cooldown. Dedicated interrupt spells exist.

**Targeting**
- Each spell has a **targeting rule** in data (nearest, lowest HP, furthest, highest threat, …) + a **taunt** status.
- Later: player-set targeting preferences in the team management layer that override/prioritize spell rules.

**Crowd control**
- **Tenacity** is a stat from the start (reduces CC duration).
- Short CC immunity after stun/fear ends; **diminishing returns**: separate deep-dive topic.

**Hit and defense**
- **Hit rating vs. dodge**, plus **block**. Spell reflect: maybe later.
- **No friendly fire.**
- Default healing exists. Lifesteal, anti-heal, overheal/shields: **no defaults**; applied via specific companions, spells, statuses or upgrades (backlog, not prototype).
- Death effects (revive, summon, on-death triggers): yes in general, not prototype.
- Stat list: broad baseline from the start (cooldown reduction, attack speed, healing power, tenacity, lifesteal, hit, dodge, block, …), even if some are only used by specific companions or spells.

**Fight flow**
- **Overtime:** after X seconds damage ramps (or healing drops) every few seconds; hard cap → higher remaining total HP % wins.
- **Battlefield:** rectangle in thirds — own third for placement, middle third empty (maybe a bit larger) so teams march towards each other. No obstacles in the prototype; obstacles and maybe **elevation** later.
- **Enemy teams:** hand-built data teams + random teams for simulation; fixed equal level in the prototype.
- **Post-fight summary / combat log** (damage dealt/taken, healing, CC applied per companion) is part of the prototype.

**Spell behaviours** (single target, area, cone, line, chain, self, ally, summon, dash, …) are the *code* part — a big ongoing area. Prototype: a small subset to get going.

## Deep-dive topics (next)
1. ~~Spell resource & priority~~ — decided, see "Abilities"
2. Crowd control: tenacity, diminishing returns, immunity windows, interrupts
3. Defense formula: armor/resistance curve, hit vs. dodge vs. block order
4. Type list and resistance profiles
5. Targeting rules list
6. Spell behaviour primitives for the prototype

## Open questions
- **Player actions during the fight** (potions, spells) — open (D14)
- How wide damage ranges may go in general (balance via simulation)
- Status stacking rules per status (proposal above)
- See "Deep-dive topics" above
- Condition system design (what conditions exist, how they're expressed in data)
- Synergy rules (what shared tags actually do) — see `companions.md`
- Fight length target (assumption: 20–40 s at normal speed)
