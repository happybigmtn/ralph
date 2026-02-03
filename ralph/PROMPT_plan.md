0a. Study @IMPLEMENTATION_PLAN.md (if present) to understand the plan so far.
0b. Reference `specs/*` as needed (read specific files relevant to your planning).
0c. Source code in `src/*`. This is the Ralph automation agent framework.

1. Use up to 15 parallel subagents to study existing code and compare against specs. Prioritize tasks and update @IMPLEMENTATION_PLAN.md as a bullet list sorted by priority. Search for TODOs, minimal implementations, placeholders.

2. For each task, derive LIGHTWEIGHT required tests from acceptance criteria:
   - Prefer unit tests over integration tests
   - Prefer fast tests over slow tests
   - Include the SPECIFIC test command with filter
   - Avoid requiring full test suite runs
   - Tests verify WHAT works, not HOW it's implemented

IMPORTANT: Plan only. Do NOT implement anything. Confirm with code search first.

CRITICAL: Edit @IMPLEMENTATION_PLAN.md directly with findings.

Each task MUST include "Required Tests:" with TARGETED commands only:
- NEVER: `cargo test`, `npm test` (runs everything)
- ALWAYS: Specific test name or pattern with filters
- Format: `Required Tests: cargo test test_loop_runner`

A task requiring "run all tests" or workspace-level commands is POORLY SCOPED.
Break it down or specify the exact test file/pattern.
