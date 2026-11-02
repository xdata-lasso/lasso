import unittest
from column_matcher import check_column_subset

class TestColumnMatcher(unittest.TestCase):

    def test_exact_match(self):
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            (1, 'a'),
            (2, 'b'),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_permuted_match(self):
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            ('a', 1),
            ('b', 2),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_extra_columns(self):
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            (1, 'x', 'a'),
            (2, 'y', 'b'),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_missing_column(self):
        res1 = [
            (1, 'a', 'x'),
            (2, 'b', 'y'),
        ]
        res2 = [
            (1, 'a'),
            (2, 'b'),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_ordered_match_success(self):
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            ('a', 1),
            ('b', 2),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=True))

    def test_ordered_match_failure(self):
        # Rows don't match index-by-index
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            ('b', 2),
            ('a', 1),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=True))

    def test_different_row_values(self):
        res1 = [
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            (1, 'a'),
            (3, 'b'),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_correlated_failure_linear_check_flaw(self):
        # Column multisets match perfectly individually:
        # Col 0: {1, 3}
        # Col 1: {2, 4}
        # But the rows are (1,4) and (3,2) instead of (1,2) and (3,4)
        res1 = [
            (1, 2),
            (3, 4),
        ]
        res2 = [
            (1, 4),
            (3, 2),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_duplicate_columns_match(self):
        res1 = [
            (1, 1),
            (2, 2),
        ]
        res2 = [
            (1, 1, 3),
            (2, 2, 4),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_duplicate_columns_fail_if_reused(self):
        # res1 requires two columns of [1, 2], but res2 only has one.
        res1 = [
            (1, 1),
            (2, 2),
        ]
        res2 = [
            (1, 3),
            (2, 4),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_empty_results(self):
        self.assertTrue(check_column_subset([], [], order_matters=False))
        self.assertTrue(check_column_subset([], [], order_matters=True))

    def test_one_empty_result(self):
        self.assertFalse(check_column_subset([(1,)], [], order_matters=False))
        self.assertFalse(check_column_subset([], [(1,)], order_matters=False))

    def test_different_row_counts(self):
        res1 = [(1, 'a')]
        res2 = [(1, 'a'), (1, 'a')]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))
        self.assertFalse(check_column_subset(res2, res1, order_matters=False))

    def test_data_types(self):
        res1 = [(None, 1.5, True)]
        res2 = [(True, None, 1.5)]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_complex_permutation_with_extra_cols(self):
        res1 = [
            (1, 2, 3),
            (4, 5, 6),
        ]
        res2 = [
            (99, 3, 88, 1, 2),
            (77, 6, 66, 4, 5),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_duplicate_rows(self):
        res1 = [
            (1, 'a'),
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            ('a', 1),
            ('a', 1),
            ('b', 2),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_duplicate_rows_mismatch(self):
        res1 = [
            (1, 'a'),
            (1, 'a'),
            (2, 'b'),
        ]
        res2 = [
            ('a', 1),
            ('b', 2),
            ('b', 2),
        ]
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_tricky_backtracking(self):
        # res1 has columns that look very similar, making backtracking guess and fail
        res1 = [
            (1, 1, 2),
            (1, 2, 1),
        ]
        res2 = [
            (2, 1, 1),
            (1, 2, 1),
        ]
        self.assertTrue(check_column_subset(res1, res2, order_matters=False))

    def test_stress_backtracking_medium(self):
        # C=8. 8! = 40,320 permutations. Should be fast but non-trivial.
        C = 8
        res1 = []
        for i in range(C):
            row = [0] * C
            row[i] = 1
            res1.append(tuple(row))
        res2 = list(res1)
        res2[0] = tuple([1, 1] + [0]*(C-2))
        res2[1] = tuple([0] * C)
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

    def test_stress_backtracking_heavy(self):
        # C=10. 10! = 3,628,800 permutations. 
        # All columns have exactly one '1', so the pruning phase is completely useless 
        # (every column matches every other column's value counts).
        # But res2 has a row with two '1's, while res1 only has rows with one '1'.
        # Therefore, no permutation will ever match, forcing the algorithm to explore 
        # all 3.6 million combinations before giving up.
        C = 10
        res1 = []
        for i in range(C):
            row = [0] * C
            row[i] = 1
            res1.append(tuple(row))
        res2 = list(res1)
        res2[0] = tuple([1, 1] + [0]*(C-2))
        res2[1] = tuple([0] * C)
        self.assertFalse(check_column_subset(res1, res2, order_matters=False))

if __name__ == '__main__':
    unittest.main()
