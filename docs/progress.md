# Progress

Updated at the end of every session (`/end-session`). Newest state only — history is in git.

## Current state
Repo skeleton and docs exist. Godot 4.7.2 project in `game/` (Compatibility renderer, placeholder main scene) imports and runs headless without errors — checked by hand, since `tools/check` doesn't exist yet.

Godot on Thomas's PC: `C:\Tools\Godot_v4.7.2-stable_win64_console.exe` (use the `_console` exe for scripts).

## Half-done
Nothing. The Godot project item is only fully "done" once `tools/check --full` exists and passes on it.

## Next
gdUnit4 + one smoke test. Open question for that plan: gdUnit4 only sees tests inside the Godot project, so the top-level `tests/` folder likely moves to `game/tests/`.
