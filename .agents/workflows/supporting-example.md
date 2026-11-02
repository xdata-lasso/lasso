---
description: Given an example, fix the codebase to support test data generation for it.
---

- For a given example query pair and a schema, reason whether these queries are actually non-equivalent. 
- If these are actually equivalent, terminate and notify the user.
- If they are non-equivalent, modify only
the src/ codebase to generate required test data for proving
non-equivalence (NEQ) of query pairs in the example. 
- If changes to testing scripts are required, first request a review from user.
- Note that you can also consider prediction query for data generation if it is easier to prove it non-eqvauilent that way.
- Before coding, create a minimal reproducible test case in
test_cases/.
- Always use the project’s virtual environment (venv).
- Read and use the test_runner.py correctly for testing your im-
plementation. Use –debug flag to inspect the actual datasets
and ensure they are generated as expected. If you face any unexpected issues you can also try evaluate_lasso.py with relevant flags for running only that instance. 
- Verify the newly created reproducible test case actually fails
initially.
- Analyze and reason what kind of dataset is required to refute
equivalence.
- First verify directly (not generating by code) that the dataset
would actually proves the queries are not equivalent.
- Implement a required generalized solution in src/ (no one-off
fixes).
- Verify the base data generator produces non-empty results
for the reference query and verify generating data using the
mutant query produces non-empty results for the mutant.
- Verify the minimal test case passes after the implementation.
- Finally, verify the original provided example also passes.
- Ensure your solution did not cause any regressions, if there
are any regression, you will re-consider your solution and
fix them.
- Acknowledge me that you will also follow the coding rules
strictly.