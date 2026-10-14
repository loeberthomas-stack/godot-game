# Gotchas

Engine quirks and mistakes already hit. Add an entry whenever a bug needed more than two attempts (two-strike rule).

<!-- ## Short title (YYYY-MM-DD)
- Symptom:
- Cause:
- Fix / rule:
-->

## Godot `--import` doesn't check scripts, and exits 0 on asset errors (2026-10-14)
- Symptom: a script with a syntax error passed `--headless --import`; a corrupt PNG printed `ERROR: Error importing ...` but Godot still exited 0.
- Cause: import only processes assets (scripts aren't parsed), and import errors don't change the exit code.
- Fix / rule: `tools/check` compiles scripts separately with `--check-only -s res://file.gd` (exit 1 on parse error) and scans import output for `ERROR` lines. Don't rely on `--import` alone.

## gdUnit4 command-line runner quirks (2026-10-14)
- Symptom: runner refuses to start headless; every run prints two `ERROR: ... 127.0.0.1:0` lines; the "Statistics" line says PASSED even when tests failed.
- Cause: gdUnit4 blocks headless runs by default (UI/input tests can't work without a window). The port-0 errors are intentional — `runtest.cmd` uses them to disable Godot's interactive debugger. The Statistics colour/label is cosmetic.
- Fix / rule: pass `--headless ... --ignoreHeadlessMode`. Ignore the two port-0 error lines. Judge pass/fail **only by the exit code** (0 = pass, 100 = failures, 101 = warnings). Run `runtest.cmd` from inside `game/` (it uses `--path .`). Decline gdUnit4's in-editor "update available" prompt — the version is pinned (ARCHITECTURE.md).
