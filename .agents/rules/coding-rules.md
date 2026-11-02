---
trigger: always_on
---

- Reason formally and write academically sound solutions rooted in SQL semantics, relational algebra, and query equivalence.
- Never rely on intuition, column/schema naming conventions, or implementation shortcuts.
- Never hardcode specific table names, specific column names, specific query structures, benchmark-specific assumptions, or one-off hacks.
- Never rely on heuristics like if column == "salary", or positional shortcuts like targeting only the first table or second table.
- Ensure every attack implementation generalizes across schemas, aliases, and SQL dialects when possible, including real-world complex or messy queries.
- No random data generation is allowed; datasets must be generated intentionally and deterministically.
- Generated datasets must strictly consist of INSERT statements only; never include DDL, indexing statements (e.g. CREATE INDEX), or schema modifications within the dataset.



- When required, work on an existing attack strategy or create a new attack strategy.
- Each attack strategy role must be separate and must not handle multiple things that are significantly different.
- Never make individual attack strategies too long, and keep attack names to the point.
- Note that a test case might contain different types of errors and might need more than one attack strategy implemented.
- Add a detailed comment at the top of each strategy explaining what the algorithm does and how it designs the dataset.
- Understand that equivalence refutation can sometimes be easier using two-way data generation (generating test data from the prediction query); work on strategies accordingly when it makes refutation easier.
- You will always use sqlite and sqlite related queries / ddl for development of LASSO.

- When available, extract and use literals and values from the SQL query for the same column, without hardcoding values in the codebase.
- Do not assume the same literal value applies to other columns, unless they belong to the same equivalence class.
- If required, use the faker library to generate new values for columns.
- After each dataset generation, reset uniqueness in Faker so that new datasets are independent of previously used values and limited fake data is not exhausted.
- For dataset designs where the number of values needs to be known at once, gather the unique values upfront and then use them to design the dataset.
- You can use Z3 for satisfying complex constraints when required, but prefer programmatic crafting of datasets instead of Z3 (it is okay if it becomes lengthy code).



- Always use test_runner.py to test a particular test case; use the --debug flag to see logs rather than creating multiple mini files to debug issues.
- Use a proper logging system within the actual code rather than arbitrary print statements.
- Always inspect the output of test_runner.py for debugging and to confirm mutation status.
- Always make sure the mutant is killed by a dataset created intentionally, not just by an arbitrary dataset or for technically wrong reasons.
- If inspection of test_runner.py output reveals a mutant was killed for an unintended or accidental reason, modify the dataset generation strategy so the kill happens as intended.
- If AI assistant advice is given, critically evaluate potential flaws and drawbacks, and discuss potential disadvantages and better alternative approaches before adopting.
- Make sure you don't get stuck running any scripts. 
- Avoid running scripts that can take a long time. Never run whole benchmarks, full benchmark directories, or unconstrained batch loops across many test cases.
- Always target and test individual test cases one by one using test_runner.py on a specific JSON file, rather than batch-executing suites.
- If inspecting multiple cases, test only 1 to 3 targeted cases individually with strict timeouts (e.g., under 15-30 seconds), and immediately terminate any hanging or long-running scripts.
- You should be aware of any hanging scripts and kill them when required.

- Write clean code following best practices (for example, no imports in the middle of a file).
- Always think and add code such that it does not break other features.
- Before completing a task, re-check that all rules from this file are followed.
- Do not clutter the codebase with redundant logic; if existing logic can be extended or slightly refactored to fix a bug, prefer doing that.
- If you find any existing code that violates these rules, refactor it immediately.
- When supporting a novel feature or semantic bug scenario, add a simplified test case in the test_cases/ folder rewritten to highlight only that specific semantic bug without copying the exact benchmark example.
- Ensure test case schemas and DDLs are well-formed and valid according to relational semantics and SQLite foreign key constraints (e.g., non-primary-key columns referenced by foreign keys must declare an explicit UNIQUE constraint in the DDL).

Questions to Consider Before Implementing

- What type of data do we need?
- What can be the rules to design such a dataset?
- Does this generalize to any type of query, including real-world complex or messy queries?
- Is there any existing code that needs to be extended to support this?
- "Will this always work? Is my implementation choice correct?"