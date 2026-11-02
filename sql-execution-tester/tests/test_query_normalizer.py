import unittest

from datetime import datetime
from query_normalizer import replace_time, augment_order_by

class TestTimeReplacer(unittest.TestCase):
    def setUp(self):
        self.frozen_time = datetime(2026, 1, 1, 12, 0, 0)

    def test_current_timestamp(self):
        q = "SELECT CURRENT_TIMESTAMP"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT '2026-01-01 12:00:00'")
        
        q = "SELECT cUrReNt_TiMeStAmP"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT '2026-01-01 12:00:00'")

    def test_current_date_and_time(self):
        q = "SELECT CURRENT_DATE, CURRENT_TIME"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT '2026-01-01', '12:00:00'")

    def test_datetime_now(self):
        q = "SELECT datetime('now')"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT DATETIME('2026-01-01 12:00:00')")
        
        q = "SELECT datetime(  'NOW'  , '+1 day')"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT DATETIME('2026-01-01 12:00:00', '+1 day')")
        
        q = "SELECT datetime('2020-01-01', '+1 day')" # Should not change
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT DATETIME('2020-01-01', '+1 day')")

    def test_string_safety(self):
        # Ensure it doesn't replace 'now' inside regular strings or column names
        q = "SELECT 'now' as now_col FROM t WHERE status = 'now'"
        # sqlglot standardizes the output string, which is fine as long as logic holds
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT 'now' AS now_col FROM t WHERE status = 'now'")
        
    def test_messy_syntax(self):
        q = "sElEcT   datetime( 'now' )   fRoM   t"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), "SELECT DATETIME('2026-01-01 12:00:00') FROM t")

    def test_julianday_and_others(self):
        q = "SELECT julianday('now'), strftime('%s', 'now'), date('now'), time('now')"
        expected = "SELECT JULIANDAY('2026-01-01 12:00:00'), STRFTIME('%s', '2026-01-01 12:00:00'), DATE('2026-01-01 12:00:00'), TIME('2026-01-01 12:00:00')"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), expected)

    def test_invalid_sql(self):
        q = "SELECT FROM WHERE datetime('now')"
        # invalid sql should be returned unchanged
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time), q)

    def test_dynamic_time_sharing(self):
        # Verify that passing the same frozen_time to two queries uses the exact same timestamp
        q1 = "SELECT CURRENT_TIMESTAMP"
        q2 = "SELECT datetime('now')"
        
        frozen = datetime.utcnow()
        timestamp_str = frozen.strftime('%Y-%m-%d %H:%M:%S')
        
        self.assertEqual(replace_time(q1, frozen_time=frozen), f"SELECT '{timestamp_str}'")
        self.assertEqual(replace_time(q2, frozen_time=frozen), f"SELECT DATETIME('{timestamp_str}')")

    def test_mysql_time_functions(self):
        q = "SELECT NOW(), SYSDATE(), LOCALTIME(), LOCALTIMESTAMP(), CURDATE(), CURTIME()"
        expected = "SELECT '2026-01-01 12:00:00', '2026-01-01 12:00:00', '12:00:00', '2026-01-01 12:00:00', '2026-01-01', '12:00:00'"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time, dialect='mysql'), expected)

    def test_postgres_time_functions(self):
        q = "SELECT NOW(), statement_timestamp(), clock_timestamp(), transaction_timestamp(), CURRENT_TIMESTAMP"
        expected = "SELECT '2026-01-01 12:00:00', '2026-01-01 12:00:00', '2026-01-01 12:00:00', '2026-01-01 12:00:00', '2026-01-01 12:00:00'"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time, dialect='postgres'), expected)

    def test_mysql_nested_time_functions(self):
        q = "SELECT DATE_ADD(NOW(), INTERVAL 1 DAY)"
        expected = "SELECT DATE_ADD('2026-01-01 12:00:00', INTERVAL '1' DAY)"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time, dialect='mysql'), expected)

    def test_postgres_precision_time(self):
        q = "SELECT CURRENT_TIMESTAMP(3), LOCALTIMESTAMP(6)"
        expected = "SELECT '2026-01-01 12:00:00', '2026-01-01 12:00:00'"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time, dialect='postgres'), expected)

    def test_postgres_cast_time(self):
        q = "SELECT NOW()::date, CAST(NOW() AS date)"
        expected = "SELECT CAST('2026-01-01 12:00:00' AS DATE), CAST('2026-01-01 12:00:00' AS DATE)"
        self.assertEqual(replace_time(q, frozen_time=self.frozen_time, dialect='postgres'), expected)

if __name__ == '__main__':
    unittest.main()


class TestOrderByAugmenter(unittest.TestCase):

    def setUp(self):
        self.schema = """
        CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
        CREATE TABLE posts (id INTEGER, user_id INTEGER, title TEXT);
        CREATE TABLE tags (id INTEGER, name TEXT UNIQUE);
        CREATE TABLE categories (cat_id INTEGER, category_name TEXT, UNIQUE(cat_id, category_name));
        """

    def test_no_order_by(self):
        q = "SELECT id, name FROM users"
        self.assertEqual(augment_order_by(q, self.schema), q)

    def test_fallback_no_schema(self):
        # Without schema, it falls back to appending SELECT columns
        q = "SELECT id, name FROM users ORDER BY id"
        expected = "SELECT id, name FROM users ORDER BY id, name NULLS LAST"
        self.assertEqual(augment_order_by(q).upper(), expected.upper())

    def test_schema_with_primary_key(self):
        # 'users' has PRIMARY KEY 'id'
        q = "SELECT name FROM users ORDER BY name"
        expected = "SELECT name FROM users ORDER BY name, users.id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_schema_with_unique_constraint(self):
        # 'tags' has no PK, but has UNIQUE 'name'
        q = "SELECT id FROM tags ORDER BY id"
        expected = "SELECT id FROM tags ORDER BY id, tags.name NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_schema_with_table_unique_constraint(self):
        # 'categories' has table-level UNIQUE
        q = "SELECT category_name FROM categories ORDER BY category_name"
        expected = "SELECT category_name FROM categories ORDER BY category_name, categories.cat_id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_schema_no_primary_key(self):
        # 'posts' has no PRIMARY KEY, so it should append all columns
        q = "SELECT title FROM posts ORDER BY title"
        expected = "SELECT title FROM posts ORDER BY title, posts.id NULLS LAST, posts.user_id NULLS LAST"
        # 'title' is already in order by, so it's not appended again
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_schema_join(self):
        # Join between users and posts. users has PK id, posts has no PK.
        q = "SELECT u.id, p.title FROM users u JOIN posts p ON u.id = p.user_id ORDER BY u.name"
        expected = "SELECT u.id, p.title FROM users AS u JOIN posts AS p ON u.id = p.user_id ORDER BY u.name, u.id NULLS LAST, p.id NULLS LAST, p.user_id NULLS LAST, p.title NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_schema_star_select(self):
        # Star select with schema should still append schema columns correctly
        q = "SELECT * FROM users ORDER BY name"
        expected = "SELECT * FROM users ORDER BY name, users.id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_already_ordered_by_pk(self):
        q = "SELECT name FROM users ORDER BY name, id"
        # id is the pk, so it shouldn't append it again
        expected = "SELECT name FROM users ORDER BY name, id"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_already_ordered_by_pk_desc(self):
        q = "SELECT name FROM users ORDER BY id DESC"
        expected = "SELECT name FROM users ORDER BY id DESC"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_complex_expression_order_by(self):
        q = "SELECT id, name FROM users ORDER BY LOWER(name)"
        expected = "SELECT id, name FROM users ORDER BY LOWER(name), users.id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_group_by_fallback(self):
        q = "SELECT user_id, COUNT(*) FROM posts GROUP BY user_id ORDER BY COUNT(*)"
        expected = "SELECT user_id, COUNT(*) FROM posts GROUP BY user_id ORDER BY COUNT(*), user_id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_cte_fallback(self):
        q = "WITH cte AS (SELECT id, name FROM users) SELECT id FROM cte ORDER BY name"
        expected = "WITH cte AS (SELECT id, name FROM users) SELECT id FROM cte ORDER BY name, id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_subquery_fallback(self):
        q = "SELECT id FROM (SELECT id, name FROM users) AS sq ORDER BY name"
        expected = "SELECT id FROM (SELECT id, name FROM users) AS sq ORDER BY name, id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_unknown_table_fallback(self):
        q = "SELECT a, b FROM unknown_table ORDER BY a"
        expected = "SELECT a, b FROM unknown_table ORDER BY a, b NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_alias_in_select_fallback(self):
        q = "SELECT id, name AS user_name FROM users ORDER BY id"
        expected = "SELECT id, name AS user_name FROM users ORDER BY id, user_name NULLS LAST"
        self.assertEqual(augment_order_by(q).upper(), expected.upper())

    def test_union_order_by(self):
        q = "SELECT id, name FROM users UNION SELECT cat_id, category_name FROM categories ORDER BY id"
        expected = "SELECT id, name FROM users UNION SELECT cat_id, category_name FROM categories ORDER BY id, name NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_distinct_order_by(self):
        # DISTINCT should skip base schema append and fallback to selected expressions
        q = "SELECT DISTINCT name, id FROM users ORDER BY name"
        expected = "SELECT DISTINCT name, id FROM users ORDER BY name, id NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_subquery_from_order_by(self):
        # The FROM clause is a subquery, so base tables are not directly visible to the outer query
        q = "SELECT s.id, s.name FROM (SELECT id, name FROM users) AS s ORDER BY s.id"
        expected = "SELECT s.id, s.name FROM (SELECT id, name FROM users) AS s ORDER BY s.id, s.name NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema).upper(), expected.upper())

    def test_postgres_dialect_order_by(self):
        # Postgres supports NULLS LAST natively, but since it's the default for ASC,
        # sqlglot actually removes the explicit NULLS LAST to simplify the query!
        q = "SELECT id, name FROM users ORDER BY name"
        expected = "SELECT id, name FROM users ORDER BY name, users.id"
        self.assertEqual(augment_order_by(q, self.schema, dialect='postgres').upper(), expected.upper())

    def test_mysql_dialect_order_by(self):
        # MySQL doesn't natively support NULLS LAST syntax, sqlglot converts it to CASE WHEN
        q = "SELECT id, name FROM users ORDER BY name"
        expected = "SELECT id, name FROM users ORDER BY name, CASE WHEN users.id IS NULL THEN 1 ELSE 0 END, users.id"
        self.assertEqual(augment_order_by(q, self.schema, dialect='mysql').upper(), expected.upper())

    def test_invalid_syntax(self):
        q = "SELECT id, name FROM users ORDER BY"
        self.assertEqual(augment_order_by(q, self.schema), q)

    def test_mysql_order_by_desc(self):
        q = "SELECT id, name FROM users ORDER BY name DESC"
        expected = "SELECT id, name FROM users ORDER BY name DESC, CASE WHEN users.id IS NULL THEN 1 ELSE 0 END, users.id"
        self.assertEqual(augment_order_by(q, self.schema, dialect='mysql').upper(), expected.upper())

    def test_postgres_order_by_desc(self):
        q = "SELECT id, name FROM users ORDER BY name DESC"
        expected = "SELECT id, name FROM users ORDER BY name DESC, users.id"
        self.assertEqual(augment_order_by(q, self.schema, dialect='postgres').upper(), expected.upper())

    def test_postgres_distinct_on(self):
        q = "SELECT DISTINCT ON (category) category, name FROM users ORDER BY category, name DESC"
        expected = "SELECT DISTINCT ON (category) category, name FROM users ORDER BY category, name DESC"
        self.assertEqual(augment_order_by(q, self.schema, dialect='postgres').upper(), expected.upper())

    def test_order_by_limit_offset(self):
        q = "SELECT id, name FROM users ORDER BY name LIMIT 10 OFFSET 5"
        expected = "SELECT id, name FROM users ORDER BY name, users.id NULLS LAST LIMIT 10 OFFSET 5"
        self.assertEqual(augment_order_by(q, self.schema, dialect='sqlite').upper(), expected.upper())

    def test_group_by_order_by_alias(self):
        q = "SELECT category, COUNT(id) AS cnt FROM users GROUP BY category ORDER BY cnt"
        expected = "SELECT category, COUNT(id) AS cnt FROM users GROUP BY category ORDER BY cnt, category NULLS LAST"
        self.assertEqual(augment_order_by(q, self.schema, dialect='sqlite').upper(), expected.upper())

if __name__ == '__main__':
    unittest.main()
