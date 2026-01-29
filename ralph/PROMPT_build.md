0a. Study `specs/*` with parallel subagents to learn the application specifications.
0b. Study @IMPLEMENTATION_PLAN.md.
0c. For reference, the application source code is in `game/src/*` (on-chain), `executor/*` (off-chain), and `web/*` (frontend).

## Skills

**Use /solana-dev skill** when:
- Writing or modifying on-chain programs (use Pinocchio, NEVER Anchor)
- Writing client/SDK code (use @solana/kit, NEVER @solana/web3.js)
- Setting up tests (use LiteSVM for program testing)
- Generating typed clients (use Codama)

**Use /solana-review skill** when:
- Cross-checking client instruction builders against on-chain program expectations
- Verifying instruction data layout, account order, signer/writable flags
- Auditing PDA derivations and program ID usage
- Pre-release correctness checks before deployment

## Workflow

1. Your task is to implement functionality per the specifications using parallel subagents. Follow @IMPLEMENTATION_PLAN.md and choose the most important item to address. Before making changes, search the codebase (don't assume not implemented) using parallel subagents. Use only 1 subagent for build/tests.
2. Implement the chosen task fully. Required tests derived from acceptance criteria are part of the task scope. Run all relevant tests for the unit of code you changed. If tests fail, fix and re-run until they pass.
3. When you discover issues, immediately update @IMPLEMENTATION_PLAN.md with your findings using a subagent.
   3b. When your chosen @IMPLEMENTATION_PLAN.md item is done and all relevant tests pass, mark that item complete (check it off and/or remove it per the file's convention), and add any necessary notes (files changed, tests run).
4. When the tests pass, update @IMPLEMENTATION_PLAN.md, then `git add -A` then `git commit` with a message describing the changes.

5. Important: When authoring documentation, capture the why — tests and implementation importance.
6. Important: Single sources of truth, no migrations/adapters. If tests unrelated to your work fail, resolve them as part of the increment.
7. You may add extra logging if required to debug issues.
8. Keep @IMPLEMENTATION_PLAN.md current with learnings using a subagent — future work depends on this to avoid duplicating efforts. Update especially after finishing your turn.
9. When you learn something new about how to run the application, update @AGENTS.md using a subagent but keep it brief. For example if you run commands multiple times before learning the correct command then that file should be updated.
10. For any bugs you notice, resolve them or document them in @IMPLEMENTATION_PLAN.md using a subagent even if it is unrelated to the current piece of work.
11. Implement functionality completely. Placeholders and stubs waste efforts and time redoing the same work.
12. When @IMPLEMENTATION_PLAN.md becomes large periodically clean out the items that are completed from the file using a subagent.
13. If you find inconsistencies in the specs/* then use a high-capability subagent with 'ultrathink' requested to update the specs.
14. IMPORTANT: Keep @AGENTS.md operational only — status updates and progress notes belong in `IMPLEMENTATION_PLAN.md`. A bloated AGENTS.md pollutes every future loop's context.
15. **IMPORTANT: Before any client↔program integration work, invoke /solana-review to verify instruction data layouts and account ordering match between frontend and on-chain code.**

Output <promise>COMPLETE</promise> when your chosen item is marked complete in @IMPLEMENTATION_PLAN.md and all relevant tests pass
