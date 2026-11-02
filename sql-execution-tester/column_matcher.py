from collections import Counter

def check_column_subset(res1: list[tuple], res2: list[tuple], order_matters: bool) -> bool:
    """
    Checks if there exists a subset of columns in res2, potentially in a different order,
    such that when we look only at those columns in res2, the rows exactly match the rows in res1
    (including any duplicate rows).
    If order_matters is True, it checks if the exact sequence of rows from top to bottom matches.
    """
    if not res1 and not res2:
        return True
    if not res1 or not res2:
        return False
        
    C = len(res1[0])
    K = len(res2[0])
    
    if K < C:
        return False

    if order_matters:
        # When order_matters=True, the results are treated as exact ordered sequences of rows.
        # This means row 0 in res1 must match row 0 in res2, row 1 must match row 1, etc.
        # Because the row alignment is perfectly fixed, we can just treat each column 
        # as an independent ordered list (a tuple of values from top to bottom).
        
        # zip(*res) transposes the list of rows into a list of columns. 
        # Example: res1 = [(1, 'a'), (2, 'b')] -> cols1 = [(1, 2), ('a', 'b')]
        cols1 = list(zip(*res1))
        cols2 = list(zip(*res2))
        
        # We use Counter (a tool that counts how many times things appear) to check if every 
        # column sequence in cols1 exists in cols2.
        #
        # Why Counter and not a standard set()?
        # 1. Duplicate Columns: If query1 selects the same column twice (e.g. SELECT A, A),
        #    cols1 will contain the exact same column sequence twice. Counter tracks this 
        #    (e.g., Counter({ (1, 2): 2 }) means the column (1, 2) appears twice).
        # 2. Subset Check with Duplicates: The `<=` operator on Counters checks if cols2 has 
        #    AT LEAST as many occurrences of every column as cols1. This elegantly ensures 
        #    that if query1 demands two identical columns, query2 must supply at least two!
        c1 = Counter(cols1)
        c2 = Counter(cols2)
        return all(c1[k] <= c2[k] for k in c1)


    # When order_matters=False, row order is ignored. 
    # We must find the right columns in res2 to match the columns in res1, such that
    # the final rows (including any duplicate rows) match perfectly.
    
    # [PRUNING PHASE - Narrowing down choices]
    # To avoid trying every single possible combination of columns (which could take a very long time),
    # we first calculate the count of values for each individual column.
    # 
    # For each column index (like `i`), we iterate through all rows and extract `row[i]`.
    # This isolates a single vertical "slice" of the table. We wrap that slice in `Counter()` 
    # to count how many times each value appears.
    # For example, if a column's values are [1, 5, 1, 3], Counter turns it into {1: 2, 5: 1, 3: 1}.
    # By doing this for every column, we can instantly reject bad column matches:
    # if column `i` in res1 has a completely different count of values than column `j` in res2,
    # then column `j` can NEVER map to column `i`, no matter how the rows are shuffled!
    cols1_value_counts = [Counter(row[i] for row in res1) for i in range(C)]
    cols2_value_counts = [Counter(row[j] for row in res2) for j in range(K)]

    # possible_matches[i] will store a list of valid candidate column indices in res2 
    # that could potentially match column i in res1.
    possible_matches = []
    for i in range(C):
        # A fundamental requirement for identical rows is that they must have 
        # the exact same number of rows.
        if len(res1) != len(res2):
            return False
            
        # A column `j` in res2 is only a valid candidate if its value counts exactly 
        # match the value counts of column `i` in res1.
        matches = [j for j in range(K) if cols1_value_counts[i] == cols2_value_counts[j]]
        
        # If any column in res1 has ZERO candidate matches in res2, it's impossible 
        # to form a valid mapping. We can immediately fail and save computation time.
        if not matches:
            return False
        possible_matches.append(matches)


    # If we didn't calculate `Counter(res1)` just once right here, the computer would 
    # have to re-count every single row in `res1` from scratch, thousands of times!
    # 
    # For example, if res1 is:
    #   Row 1: (1, 'Alice')
    #   Row 2: (1, 'Alice')  <-- Duplicate row
    #   Row 3: (2, 'Bob')
    #
    # `res1_counter` becomes a saved snapshot that already knows the final counts:
    #   { (1, 'Alice'): 2,  (2, 'Bob'): 1 }
    # 
    # Now, the guessing phase only has to count the newly rearranged res2 rows and 
    # compare it instantly against this pre-computed snapshot.
    res1_counter = Counter(res1)
    
    # [GUESSING PHASE]
    # We recursively try different ways to link columns from res1 to res2.
    # col_idx: The current column index in res1 we are trying to link.
    # current_perm: The sequence of linked res2 column indices chosen so far.
    # used_cols: A set of already linked res2 columns (to ensure we don't pick the same column twice).
    def backtrack(col_idx, current_perm, used_cols):
        if col_idx == C:
            # Base Case: We have fully linked all C columns!
            # Now we recreate the res2 rows using only our chosen sequence of columns.
            # 
            # --- EXAMPLE OF RECREATING ROWS ---
            # Suppose C (number of columns we need) is 2.
            # And our current_perm (our guess) is [1, 0].
            # This means: "Take column 1 from res2 and put it first, then take column 0 from res2 and put it second."
            #
            # If a row in res2 is (99, 'Alice', 'extra_data'),
            # the new recreated row will be: (row[1], row[0]) -> ('Alice', 99).
            # We do this for every single row in res2 to create `permuted_res2`.
            permuted_res2 = [tuple(row[current_perm[i]] for i in range(C)) for row in res2]
            
            # Finally, check if this complete column mapping worked!
            # We use Counter to compare the rows. This is because row order doesn't matter, 
            # but if a row appears twice in res1, it MUST appear exactly twice in our new permuted_res2.
            return res1_counter == Counter(permuted_res2)
            
        # Try assigning each valid candidate for the current column
        for j in possible_matches[col_idx]:
            if j not in used_cols:
                # 1. Choose candidate `j`
                used_cols.add(j)
                current_perm.append(j)
                
                # 2. Explore further down the decision tree
                if backtrack(col_idx + 1, current_perm, used_cols):
                    return True # If a deeper exploration found a valid mapping, bubble it up!
                    
                # 3. Un-choose candidate `j` (backtrack) and try the next one
                current_perm.pop()
                used_cols.remove(j)
                
        return False # Exhausted all candidates for this column without success

    return backtrack(0, [], set())
