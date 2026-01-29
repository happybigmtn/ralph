0a. Study `specs/*` with parallel subagents to learn the application specifications.
0b. Study @IMPLEMENTATION_PLAN.md (if present) to understand the plan so far.
0c. Study `game/src/*`, `executor/*`, and `web/*` with parallel subagents to understand the codebase.
0d. For reference, specs live in `specs/*.md` (excluding `specs/archive/`).

1. Study @IMPLEMENTATION_PLAN.md (if present; it may be incorrect) and use parallel subagents to study existing source code and compare it against `specs/*`. For each task in the plan, derive required tests from acceptance criteria in specs — tests verify WHAT works, not HOW it is implemented. Analyze findings, prioritize tasks, and create/update @IMPLEMENTATION_PLAN.md as a bullet point list sorted in priority of items yet to be implemented. Ultrathink. Consider searching for TODO, minimal implementations, placeholders, skipped/flaky tests, and inconsistent patterns. Study @IMPLEMENTATION_PLAN.md to determine starting point for research and keep it up to date with items considered complete/incomplete using subagents.

IMPORTANT: Plan only. Do NOT implement anything. Do NOT assume functionality is missing; confirm with code search first.

ULTIMATE GOAL: We want to build a fully-functional on-chain craps game with web and CLI interfaces. Consider missing elements and plan accordingly. If an element is missing, search first to confirm it doesn't exist, then if needed author the specification at specs/FILENAME.md. If you create a new element then document the plan to implement it in @IMPLEMENTATION_PLAN.md using a subagent.
