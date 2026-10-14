# Progress

Updated at the end of every session (`/end-session`). Newest state only — history is in git.

## Current state
- Godot 4.7.2 project in `game/` (Compatibility renderer, placeholder main scene).
- gdUnit4 v6.2.1; `game/tests/main_scene_smoke_test.gd` (3 cases).
- `tools/check --fast | --full` exists (D12). `--full` passes on everything built so far (2026-10-14) — Godot project, gdUnit4 and `tools/check` items are done.
- Every failure path was proven: broken script, corrupt asset, failing test (runner says "PASSED", exit 100 → FAIL), Godot not found, bad flag.

Godot on Thomas's PC: `C:\Tools\Godot_v4.7.2-stable_win64_console.exe`, set in git-ignored `tools/local.env`. Run quirks: `docs/gotchas.md`.

## Half-done
Nothing.

## Next
- Asset ledger check script (add as a `tools/check` step).
- Linux run of `tools/check` is unverified until CI exists (no WSL here).
