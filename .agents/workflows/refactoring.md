---
description: Refactor codebase components following core software engineering principles while preserving behavioral equivalence and test suite correctness.
---

- Refactor to ensure clear responsibilities and separation of concerns: ensure each function, class, or module has a single, well-defined purpose, and keep distinct concerns separate.
- Do not mix code into unrelated stages of pipeline, keep responsibilities of distinct pipeline stages separate (AST parsing, data generation, post-processing repairs, and SQL serialization).
- Keep each attack strategy self-contained in its own file and focused on a single semantic mutation class; do not bundle multiple unrelated attack roles into a single strategy.
- Avoid duplication: identify and reuse existing abstractions or shared utilities, and eliminate unnecessary duplicate logic.
- Keep it simple and scoped: prefer the simplest solution that satisfies current requirements; avoid premature abstractions or unnecessary layers of indirection that does not help with anything.
- Fail fast and remain observable: detect invalid states early and preserve or improve useful errors, structured logging, and other diagnostic signals. Do not use arbitrary print statements.
- Make minimal, atomic, and reversible changes: refactor incrementally in small, focused steps rather than broad, sweeping rewrites.
- Preserve existing behavior: do not change externally observable functionality unless explicitly required. Verify that the refactored code remains behaviorally equivalent.
- Never weaken, bypass, or modify test runners or regression test cases to accommodate refactored code.
- Do not clutter the codebase with redundant logic; if existing logic can be extended or slightly refactored to fix a bug, prefer doing that.
- Make sure generated code adhere strictly to the coding rules: maintain deterministic data generation, avoid hardcoded values or benchmark shortcuts.