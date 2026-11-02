import unittest
import sqlite3
from collections import Counter
from execution_tester import execution_test, normalize_sql

class BaseQueryComparatorTests(unittest.TestCase):
    dialect = "sqlite"

    def _execution_test(self, schema=None, dataset=None, gold_sql="", prediction_sql="", **kwargs):
        kwargs["dialect"] = self.dialect
        if hasattr(self, 'db_config'):
            kwargs["db_config"] = self.db_config
            
        from execution_tester import execution_test, normalize_sql
        
        skip_normalize = kwargs.pop("skip_normalize", False)
        if skip_normalize:
            return execution_test(schema, dataset, gold_sql, prediction_sql, **kwargs)
            
        mock_time = kwargs.pop("mock_time", True)
        augment_order = kwargs.pop("augment_order", True)
        
        norm_gold = normalize_sql(gold_sql, schema, mock_time=mock_time, augment_order=augment_order, dialect=self.dialect)
        norm_pred = normalize_sql(prediction_sql, schema, mock_time=mock_time, augment_order=augment_order, dialect=self.dialect)
        
        return execution_test(schema, dataset, norm_gold, norm_pred, **kwargs)

    def setUp(self):
        self.schema = """
        CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
        CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT,
            FOREIGN KEY(user_id) REFERENCES users(id));
        """
        self.dataset = """
        INSERT INTO users (id, name) VALUES (1, 'Alice');
        INSERT INTO users (id, name) VALUES (2, 'Bob');
        INSERT INTO posts (id, user_id, title) VALUES (1, 1, 'Hello World');
        INSERT INTO posts (id, user_id, title) VALUES (2, 2, 'My Post');
        INSERT INTO posts (id, user_id, title) VALUES (3, 1, 'Another Post');
        """


    def test_random_function_deterministic(self):
        gold_sql = "SELECT RANDOM()"
        prediction_sql = "SELECT RANDOM()"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql, skip_normalize=True)
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertEqual(res["gold_sql_result"], res["prediction_sql_result"])

    def test_normalize_preserves_semantics(self):
        # normalize_sql shouldn't semantically change deterministic queries without order by
        gold_sql = "SELECT id FROM users"
        from execution_tester import normalize_sql
        norm_gold = normalize_sql(gold_sql, self.schema, dialect=self.dialect)
        
        # Test they both execute and return identical results
        res_raw = self._execution_test(self.schema, self.dataset, gold_sql, gold_sql, skip_normalize=True)
        res_norm = self._execution_test(self.schema, self.dataset, norm_gold, norm_gold, skip_normalize=True)
        
        self.assertEqual(res_raw["gold_sql_result"], res_norm["gold_sql_result"])

    def test_identical_queries(self):
        gold_sql = "SELECT * FROM users"
        prediction_sql = "SELECT * FROM users "
        self.assertEqual(self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)["status"], "EQ_EXEC")

    def test_different_number_of_tuples(self):
        gold_sql = "SELECT * FROM users"
        prediction_sql = "SELECT * FROM users WHERE id = 1"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "NEQ")
        self.assertEqual(res["reason"], "row_count_mismatch")
        self.assertEqual(res["gold_sql_result"], [(1, 'Alice'), (2, 'Bob')])
        self.assertEqual(res["prediction_sql_result"], [(1, 'Alice')])

    def test_same_number_different_tuples(self):
        gold_sql = "SELECT name FROM users WHERE id = 1" # Alice
        prediction_sql = "SELECT name FROM users WHERE id = 2" # Bob
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "NEQ")
        self.assertEqual(res["reason"], "value_mismatch")
        self.assertEqual(res["gold_sql_result"], [('Alice',)])
        self.assertEqual(res["prediction_sql_result"], [('Bob',)])

    def test_same_tuples_unordered(self):
        gold_sql = "SELECT user_id FROM posts"
        prediction_sql = "SELECT user_id FROM posts ORDER BY user_id DESC"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertCountEqual(res["gold_sql_result"], [(1,), (2,), (1,)])
        self.assertCountEqual(res["prediction_sql_result"], [(2,), (1,), (1,)])

    def test_same_tuples_ordered_match(self):
        gold_sql = "SELECT user_id \nFROM posts ORDER BY user_id ASC, id ASC"
        prediction_sql = "select user_id from posts order by user_id asc, id asc"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertEqual(res["gold_sql_result"], [(1,), (1,), (2,)])
        self.assertEqual(res["prediction_sql_result"], [(1,), (1,), (2,)])

    def test_relaxed_column_ordering(self):
        gold_sql = "SELECT id, name FROM users"
        prediction_sql = "SELECT name, id FROM users"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql, strict_column_ordering=False)
        self.assertEqual(res["status"], "EQ_EXEC")

    def test_strict_column_ordering(self):
        gold_sql = "SELECT id, name FROM users"
        prediction_sql = "SELECT name, id FROM users"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql, strict_column_ordering=True)
        self.assertEqual(res["status"], "NEQ_SCO")

    def test_same_multiset_no_order(self):
        gold_sql = "SELECT user_id FROM posts WHERE user_id = 1 OR user_id = 2"
        prediction_sql = "SELECT user_id FROM posts"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertEqual(Counter(res["gold_sql_result"]), Counter([(1,), (2,), (1,)]))
        self.assertEqual(Counter(res["prediction_sql_result"]), Counter([(1,), (2,), (1,)]))

    def test_one_query_fails(self):
        gold_sql = "SELECT * FROM users"
        prediction_sql = "SELECT * FROM non_existent_table"
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "ERROR_QUERY_EXECUTION")
        self.assertEqual(res["gold_sql_result"], [(1, 'Alice'), (2, 'Bob')])
        self.assertIsNone(res["prediction_sql_result"])

    def test_both_queries_fail(self):
        # We need distinct queries to avoid early EQ return
        gold_sql = "SELECT * FROM nope1"
        prediction_sql = "SELECT * FROM nope2"
        self.assertEqual(self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)["status"], "ERROR_QUERY_EXECUTION")

    def test_schema_loading_fails(self):
        bad_schema = "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT" # missing )
        gold_sql = "SELECT * FROM users"
        prediction_sql = "select * from users"
        self.assertEqual(self._execution_test(bad_schema, self.dataset, gold_sql, prediction_sql)["status"], "ERROR_SCHEMA_LOADING")

    def test_foreign_key_violation_with_constraints(self):
        bad_dataset = "INSERT INTO posts (id, user_id, title) VALUES (1, 999, 'No User');"
        gold_sql = "SELECT * FROM posts"
        prediction_sql = "select * from posts"
        self.assertEqual(self._execution_test(self.schema, bad_dataset, gold_sql, prediction_sql)["status"], "ERROR_DATASET_LOADING")

    def test_foreign_key_insertion_order_does_not_matter(self):
        reverse_dataset = """
        INSERT INTO posts (id, user_id, title) VALUES (1, 1, 'Hello World');
        INSERT INTO users (id, name) VALUES (1, 'Alice');
        """
        gold_sql = "SELECT * FROM posts"
        prediction_sql = "select * from posts"
        res = self._execution_test(self.schema, reverse_dataset, gold_sql, prediction_sql)
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertEqual(res["gold_sql_result"], [(1, 1, 'Hello World')])
        self.assertEqual(res["prediction_sql_result"], [(1, 1, 'Hello World')])

    def test_time_based_functions(self):
        if getattr(self, 'dialect', 'sqlite') != 'sqlite':
            self.skipTest("Time string formats are SQLite specific")
        gold_sql = "SELECT CURRENT_TIMESTAMP, CURRENT_DATE, CURRENT_TIME, datetime('now'), julianday('now')"
        prediction_sql = "select CURRENT_TIMESTAMP, CURRENT_DATE, CURRENT_TIME, datetime('now'), julianday('now')"
        
        res = self._execution_test(self.schema, self.dataset, gold_sql, prediction_sql)
        
        self.assertEqual(res["status"], "EQ_EXEC")
        self.assertEqual(res["gold_sql_result"], res["prediction_sql_result"])

class TestSqliteQueryComparator(BaseQueryComparatorTests):
    dialect = 'sqlite'

class TestPostgresQueryComparator(BaseQueryComparatorTests):
    dialect = 'postgres'
    db_config = {"host": "localhost", "port": 54320, "user": "postgres", "password": "postgres", "dbname": "postgres"}
    
    @classmethod
    def setUpClass(cls):
        import psycopg2
        try:
            conn = psycopg2.connect(**cls.db_config)
            conn.close()
        except Exception as e:
            raise unittest.SkipTest(f"Postgres not available: {e}")

class TestMysqlQueryComparator(BaseQueryComparatorTests):
    dialect = 'mysql'
    db_config = {"host": "localhost", "port": 33060, "user": "root", "password": "test"}

    @classmethod
    def setUpClass(cls):
        import pymysql
        try:
            conn = pymysql.connect(**cls.db_config)
            conn.close()
        except Exception as e:
            raise unittest.SkipTest(f"MySQL not available: {e}")
