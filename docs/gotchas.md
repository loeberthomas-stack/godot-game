# Gotchas

Engine quirks and mistakes already hit. Add an entry whenever a bug needed more than two attempts (two-strike rule).

<!-- ## Short title (YYYY-MM-DD)
- Symptom:
- Cause:
- Fix / rule:
-->

## gdUnit4 command-line runner quirks (2026-10-14)
- Symptom: runner refuses to start headless; every run prints two `ERROR: ... 127.0.0.1:0` lines; the "Statistics" line says PASSED even when tests failed.
- Cause: gdUnit4 blocks headless runs by default (UI/input tests can't work without a window). The port-0 errors are intentional — `runtest.cmd` uses them to disable Godot's interactive debugger. The Statistics colour/label is cosmetic.
- Fix / rule: pass `--headless ... --ignoreHeadlessMode`. Ignore the two port-0 error lines. Judge pass/fail **only by the exit code** (0 = pass, 100 = failures, 101 = warnings). Run `runtest.cmd` from inside `game/` (it uses `--path .`). Decline gdUnit4's in-editor "update available" prompt — the version is pinned (ARCHITECTURE.md).
