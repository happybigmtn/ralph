# Agent Instructions (Ralph Template)

This repo uses the Ralph loop: specs -> plan -> build, with tests providing backpressure.

## Sources Of Truth

- Requirements live in `specs/**/*.md` (excluding `specs/archive/`).
- The current prioritized worklist lives in `IMPLEMENTATION_PLAN.md`.
- The build agent should treat the next unchecked plan item as the only in-scope work for an iteration.

## Operating Rules

- Do not invent requirements: every requirement must map to an explicit Acceptance Criteria ID in specs.
- Do not create extra planning docs; keep planning inside `IMPLEMENTATION_PLAN.md`.
- Keep changes tight: avoid drive-by refactors and unrelated formatting churn.

## Backpressure

- All tests/backpressure listed under the selected plan item must exist and pass before considering the task complete.
- If a required AC is missing/unclear, record it under "Missing/Unknown" in `IMPLEMENTATION_PLAN.md` instead of guessing.

## Commit/Push Policy

- Do not commit or push unless the user explicitly asks.
