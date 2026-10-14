# Progress

Updated at the end of every session (`/end-session`). Newest state only — history is in git.

## Current state
- Godot 4.7.2 project in `game/` (Compatibility renderer, placeholder main scene).
- gdUnit4 v6.2.1 installed; `game/tests/main_scene_smoke_test.gd` (3 cases) passes headless, and a deliberately broken version was confirmed to fail (exit 100).
- Tests now live in `game/tests/` (D2 amended).
- All checked by hand so far — `tools/check` doesn't exist yet.

Godot on Thomas's PC: `C:\Tools\Godot_v4.7.2-stable_win64_console.exe` (use the `_console` exe for scripts). The gdUnit4 runner reads it from the `GODOT_BIN` env var — set per command, not system-wide. Runner quirks: see `docs/gotchas.md`.

## Half-done
Nothing.

## Next
- `tools/check` (`--fast` / `--full`).
- **Once `tools/check` exists: re-run `tools/check --full` over everything built so far** (Godot project, gdUnit4, smoke test). Only then do those items count as "done" per CLAUDE.md.
