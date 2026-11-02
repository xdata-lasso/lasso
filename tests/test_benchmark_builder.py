"""
Unit test suite verifying benchmark construction fidelity, constraint parsing,
column arity rules, and multi-tool dialect preparation.
"""

import os
import sys
import unittest
import sqlglot

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SRC_DIR = os.path.join(BASE_DIR, "src")
EXP_DIR = os.path.join(BASE_DIR, "experiments")
if EXP_DIR not in sys.path:
    sys.path.insert(0, EXP_DIR)
if SRC_DIR not in sys.path:
    sys.path.insert(0, SRC_DIR)

from build_benchmarks import (
    parse_ddl_to_polygon,
    parse_polygon_constraints,
    get_query_output_column_count,
    process_item,
    check_sqlite_query_validity,
    has_order_by_or_limit
)
from evaluate_xdata import prepare_postgres_ddl, get_sample_data_path


class TestBenchmarkBuilder(unittest.TestCase):

    def test_parse_ddl_to_polygon_composite_fk(self):
        """Verify composite foreign keys map child columns 1-to-1 with parent columns."""
        ddl = """
        CREATE TABLE parent (
            building VARCHAR(50),
            room_number INT,
            PRIMARY KEY (building, room_number)
        );
        CREATE TABLE child (
            c_id INT PRIMARY KEY,
            b_name VARCHAR(50),
            r_num INT,
            FOREIGN KEY (b_name, r_num) REFERENCES parent(building, room_number)
        );
        """
        poly_schema = parse_ddl_to_polygon(ddl, "test_schema")
        tables = poly_schema["Tables"]
        parent_idx = str(next(i for i, t in enumerate(tables) if t["TableName"].lower() == "parent"))
        child_tbl = next(t for t in tables if t["TableName"].lower() == "child")
        fkeys = child_tbl.get("FKeys", [])
        self.assertEqual(len(fkeys), 2)
        self.assertEqual(fkeys[0]["FName"], "b_name")
        self.assertEqual(fkeys[0]["PName"], "building")
        self.assertEqual(fkeys[0]["PTable"], parent_idx)
        self.assertEqual(fkeys[1]["FName"], "r_num")
        self.assertEqual(fkeys[1]["PName"], "room_number")
        self.assertEqual(fkeys[1]["PTable"], parent_idx)

    def test_parse_polygon_constraints(self):
        """Verify check constraints with operators, inversions, and negative numbers, and ensure NULL is not treated as NOT NULL."""
        ddl = """
        CREATE TABLE test_table (
            id INT PRIMARY KEY,
            val INT CHECK (val > 0),
            inv_val INT CHECK (0 < inv_val),
            neg_val INT CHECK (neg_val >= -5),
            name VARCHAR(50) UNIQUE,
            status VARCHAR(10) NOT NULL,
            opt_notes TEXT NULL,
            UNIQUE (val, inv_val)
        );
        """
        constraints = parse_polygon_constraints(ddl, "test_schema")
        
        # Check distinct constraint (both column-level and table-level)
        distincts = [c for c in constraints if 'distinct' in c]
        self.assertTrue(any("test_table.name" in c['distinct'] for c in distincts))
        self.assertTrue(any("test_table.val" in c['distinct'] and "test_table.inv_val" in c['distinct'] for c in distincts))
        
        # Check not null constraint: status is NOT NULL, opt_notes is NULL
        not_nulls = [c for c in constraints if 'not_null' in c]
        self.assertTrue(any(c['not_null'] == "test_table.status" for c in not_nulls))
        self.assertFalse(any(c.get('not_null') == "test_table.opt_notes" for c in not_nulls))
        
        # Check standard gt
        gts = [c for c in constraints if 'gt' in c]
        self.assertTrue(any(c['gt'] == ["test_table.val", 0] for c in gts))
        
        # Check inverted 0 < inv_val -> inv_val > 0
        self.assertTrue(any(c['gt'] == ["test_table.inv_val", 0] for c in gts))
        
        # Check negative value
        gtes = [c for c in constraints if 'gte' in c]
        self.assertTrue(any(c['gte'] == ["test_table.neg_val", -5] for c in gtes))

    def test_spotit_ddl_preserves_not_null_and_unique(self):
        """Verify transform_ddl_for_spotit preserves NOT NULL and UNIQUE constraints with normalized names."""
        import schema_translator
        from build_benchmarks import transform_ddl_for_spotit

        ddl = """
        CREATE TABLE "cards" (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            uuid TEXT NOT NULL UNIQUE,
            "hasFoil" INTEGER DEFAULT 0 NOT NULL,
            "optionalNote" TEXT NULL
        );
        """
        uir = schema_translator.parse_ddl_to_uir(ddl)
        spotit_ddl = transform_ddl_for_spotit(uir)

        self.assertIn('"HASFOIL" INT NOT NULL', spotit_ddl)
        self.assertIn('"UUID" TEXT NOT NULL', spotit_ddl)
        self.assertIn('UNIQUE ("UUID")', spotit_ddl)
        self.assertIn('PRIMARY KEY ("ID")', spotit_ddl)
        self.assertNotIn('"OPTIONALNOTE" TEXT NOT NULL', spotit_ddl)
        self.assertIn('"OPTIONALNOTE" TEXT', spotit_ddl)


    def test_get_query_output_column_count(self):
        """Verify output column counting across projections and stars."""
        schema_dict = {
            "users": {"id": "int", "name": "varchar", "age": "int"}
        }
        
        # Explicit projections
        ast1 = sqlglot.parse_one("SELECT id, name FROM users")
        self.assertEqual(get_query_output_column_count(ast1, schema_dict), 2)
        
        # Star with known single table
        ast2 = sqlglot.parse_one("SELECT * FROM users")
        self.assertEqual(get_query_output_column_count(ast2, schema_dict), 3)
        
        # Star with unknown table returns None (safe fallback)
        ast3 = sqlglot.parse_one("SELECT * FROM unknown_table")
        self.assertIsNone(get_query_output_column_count(ast3, schema_dict))

    def test_prepare_postgres_ddl_table_name_extraction(self):
        """Verify CREATE TABLE IF NOT EXISTS properly resolves table dependencies in topological sort."""
        ddl = """
        CREATE TABLE child (
            c_id INT PRIMARY KEY,
            e_id INT REFERENCES "European_Football"(id)
        );
        CREATE TABLE IF NOT EXISTS "European_Football" (
            id INT PRIMARY KEY,
            team VARCHAR(100)
        );
        """
        cleaned_ddl = prepare_postgres_ddl(ddl)
        # Parent table "european_football" MUST appear BEFORE child table in topologically sorted DDL
        parent_pos = cleaned_ddl.lower().find("european_football")
        child_pos = cleaned_ddl.lower().find("child")
        self.assertTrue(parent_pos != -1 and child_pos != -1)
        self.assertLess(parent_pos, child_pos, "Parent table European_Football must be sorted before child table")

    def test_process_item_arity_and_validation(self):
        """Verify process_item allows extra columns, eliminates fewer columns, and catches errors."""
        schemas_data = {
            "db1": {
                "ddl": 'CREATE TABLE "t1" ("c1" INT, "c2" INT, "c3" INT);',
                "sqlglot_schema": {"t1": {"c1": "int", "c2": "int", "c3": "int"}}
            }
        }
        
        item = {
            "id": "q1",
            "schema_id": "db1",
            "dialect": "sqlite",
            "gold_sql": 'SELECT "c1", "c2" FROM "t1"',
            "predictions": [
                # Pred 0: Extra columns (ALLOWED per user instruction)
                {"prediction_sql": 'SELECT "c1", "c2", "c3" FROM "t1"', "source": "m_extra"},
                # Pred 1: Fewer columns (ELIMINATED)
                {"prediction_sql": 'SELECT "c1" FROM "t1"', "source": "m_fewer"},
                # Pred 2: Equal to gold (ELIMINATED)
                {"prediction_sql": 'SELECT "c1", "c2" FROM "t1"', "source": "m_eq"},
                # Pred 3: SQLite invalid (same column count as gold, but invalid column)
                {"prediction_sql": 'SELECT nonexistent_col, "c2" FROM "t1"', "source": "m_invalid"}
            ]
        }
        
        processed, stats, warnings, elim_records = process_item(item, schemas_data)
        
        surviving_preds = processed.get("predictions", [])
        # Only pred 0 should survive
        self.assertEqual(len(surviving_preds), 1)
        self.assertEqual(surviving_preds[0]["source"], ["m_extra"])
        
        reasons = [r["reason"] for r in elim_records]
        self.assertTrue(any("fewer output columns" in r for r in reasons))
        self.assertTrue(any("Equal to Gold" in r for r in reasons))
        self.assertTrue(any("Invalid for SQLite" in r for r in reasons))

    def test_generate_ddl_from_raw_constraints(self):
        """Verify generate_ddl_from_raw parses YAML NOT NULL, UNIQUE, CHECK, and FKs."""
        import tempfile
        import json
        from build_benchmarks import generate_ddl_from_raw

        schema_content = {
            "Tables": [
                {
                    "TableName": "Department",
                    "PKeys": [{"Name": "dept_id", "Type": "int"}],
                    "FKeys": [],
                    "Others": [{"Name": "dept_name", "Type": "varchar"}]
                },
                {
                    "TableName": "Employee",
                    "PKeys": [{"Name": "emp_id", "Type": "int"}],
                    "FKeys": [],
                    "Others": [
                        {"Name": "emp_name", "Type": "varchar"},
                        {"Name": "department_id", "Type": "int"},
                        {"Name": "salary", "Type": "int"}
                    ]
                }
            ]
        }

        yaml_content = """
        c1: "Employee.emp_name != NULL"
        c2: "unique(Employee.emp_name)"
        c3: "Employee.salary > 0"
        c4: "Employee.department_id <- Department.dept_id"
        """

        with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as sf, \
             tempfile.NamedTemporaryFile("w", suffix=".yml", delete=False) as yf:
            json.dump(schema_content, sf)
            sf.flush()
            yf.write(yaml_content)
            yf.flush()
            
            schema_path = sf.name
            yaml_path = yf.name

        try:
            ddl = generate_ddl_from_raw(schema_path, yaml_path)
            self.assertIn('"emp_name" VARCHAR(255) NOT NULL', ddl)
            self.assertIn('UNIQUE ("emp_name")', ddl)
            self.assertIn('CHECK ("salary" > 0)', ddl)
            self.assertIn('FOREIGN KEY ("department_id") REFERENCES "Department"("dept_id")', ddl)
        finally:
            os.remove(schema_path)
            os.remove(yaml_path)

    def test_character_varchar_normalization(self):
        """Verify CHARACTER VARCHAR dialect construct is normalized across schema_translator and prepare_postgres_ddl."""
        import schema_translator
        from build_benchmarks import prepare_postgres_ddl

        ddl = """
        CREATE TABLE "airports" (
            "apid" INTEGER PRIMARY KEY,
            "iata" CHARACTER VARCHAR(3),
            "icao" CHARACTER VARCHAR(4)
        );
        """
        cleaned = schema_translator.clean_ddl(ddl)
        self.assertNotIn("CHARACTER VARCHAR", cleaned)
        self.assertIn("VARCHAR(3)", cleaned)
        self.assertIn("VARCHAR(4)", cleaned)

        uir = schema_translator.parse_ddl_to_uir(ddl)
        self.assertIn("AIRPORTS", uir["tables"][0]["name"].upper())

        pg_ddl = prepare_postgres_ddl(ddl)
        parsed_pg = sqlglot.parse(pg_ddl, read="postgres")
        self.assertTrue(bool(parsed_pg))

    def test_spotit_composite_primary_keys(self):
        """Verify composite primary keys are emitted as a single grouped constraint in SpotIt format."""
        import schema_translator

        ddl = """
        CREATE TABLE "order_items" (
            "order_id" INT,
            "item_id" INT,
            "qty" INT,
            PRIMARY KEY ("order_id", "item_id")
        );
        """
        uir = schema_translator.parse_ddl_to_uir(ddl)
        schema, constraints = schema_translator.uir_to_spotit_format(uir)

        pk_constraints = [c for c in constraints if "primary" in c]
        self.assertEqual(len(pk_constraints), 1)
        self.assertEqual(pk_constraints[0]["primary"], ["ORDER_ITEMS__ORDER_ID", "ORDER_ITEMS__ITEM_ID"])

    def test_sanitize_polygon_schema(self):
        """Verify sanitize_polygon_schema drops foreign keys pointing to nonexistent columns in target tables."""
        from build_benchmarks import sanitize_polygon_schema

        raw_polygon_data = {
            "Tables": [
                {
                    "TableName": "player",
                    "PKeys": [{"Name": "player_id", "Type": "TEXT"}],
                    "FKeys": [],
                    "Others": [{"Name": "name", "Type": "TEXT"}]
                },
                {
                    "TableName": "fielding_postseason",
                    "PKeys": [],
                    "FKeys": [
                        {"FName": "player_id", "PName": "player_id", "PTable": 0},
                        {"FName": "team_id", "PName": "team_id", "PTable": 0}  # Invalid: team_id not in player
                    ],
                    "Others": [{"Name": "team_id", "Type": "TEXT"}, {"Name": "player_id", "Type": "TEXT"}]
                }
            ]
        }
        sanitized = sanitize_polygon_schema(raw_polygon_data)
        fkeys = sanitized["Tables"][1]["FKeys"]
        self.assertEqual(len(fkeys), 1)
        self.assertEqual(fkeys[0]["FName"], "player_id")

    def test_has_order_by_or_limit(self):
        """Verify AST detection of ORDER BY, LIMIT, OFFSET, FETCH clauses without false positives."""
        # Queries without ORDER BY / LIMIT
        self.assertFalse(has_order_by_or_limit("SELECT c1, c2 FROM t1"))
        self.assertFalse(has_order_by_or_limit("SELECT order_by_col FROM limitation_table"))
        self.assertFalse(has_order_by_or_limit('SELECT "order by" FROM "limit"'))

        # Queries with ORDER BY
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM t1 ORDER BY c1"))
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM (SELECT c1 FROM t1 ORDER BY c1)"))
        self.assertTrue(has_order_by_or_limit("WITH c AS (SELECT c1 FROM t1 ORDER BY c1) SELECT * FROM c"))
        self.assertTrue(has_order_by_or_limit("SELECT c1, RANK() OVER (ORDER BY c1 DESC) FROM t1"))

        # Queries with LIMIT / FETCH / OFFSET
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM t1 LIMIT 10"))
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM t1 FETCH FIRST 10 ROWS ONLY"))
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM t1 OFFSET 5"))
        self.assertTrue(has_order_by_or_limit("SELECT c1 FROM (SELECT c1 FROM t1 LIMIT 5)"))

    def test_process_item_order_limit_preserved(self):
        """Verify queries with ORDER BY / LIMIT are preserved and not eliminated."""
        schemas_data = {
            "db1": {
                "ddl": 'CREATE TABLE "t1" ("c1" INT, "c2" INT);',
                "sqlglot_schema": {"t1": {"c1": "int", "c2": "int"}}
            }
        }

        # Case 1: Gold query contains ORDER BY / LIMIT
        item_gold_order = {
            "id": "q_gold_order",
            "schema_id": "db1",
            "dialect": "sqlite",
            "gold_sql": 'SELECT "c1" FROM "t1" ORDER BY "c1"',
            "predictions": [
                {"prediction_sql": 'SELECT "c1", "c2" FROM "t1"', "source": "m1"}
            ]
        }

        res_gold, stats_gold, _, elim_records = process_item(
            dict(item_gold_order), schemas_data
        )
        self.assertEqual(len(res_gold.get("predictions", [])), 1)
        self.assertNotIn("Gold query contains ORDER BY or LIMIT clause", stats_gold)

        # Case 2: Prediction query contains ORDER BY / LIMIT
        item_pred_order = {
            "id": "q_pred_order",
            "schema_id": "db1",
            "dialect": "sqlite",
            "gold_sql": 'SELECT "c1" FROM "t1"',
            "predictions": [
                {"prediction_sql": 'SELECT "c1", "c2" FROM "t1"', "source": "m_valid"},
                {"prediction_sql": 'SELECT "c1", "c2" FROM "t1" ORDER BY "c1"', "source": "m_order"},
                {"prediction_sql": 'SELECT "c1", "c2" FROM "t1" LIMIT 5', "source": "m_limit"}
            ]
        }

        res_pred, stats_pred, _, elim_records2 = process_item(
            dict(item_pred_order), schemas_data
        )
        surviving = res_pred.get("predictions", [])
        self.assertEqual(len(surviving), 3)
        self.assertNotIn("Prediction query contains ORDER BY or LIMIT clause", stats_pred)

    def test_largejoin_benchmark_schema_and_queries(self):
        """Verify LargeJoin benchmark schema parsing, sample data foreign key consistency, and query processing."""
        import sqlite3
        from evaluate_xdata import get_sample_data_path

        largejoin_dir = os.path.join(EXP_DIR, "originals", "xdatapublic", "benchmarks", "LargeJoin")
        if not os.path.exists(largejoin_dir):
            largejoin_dir = os.path.join(EXP_DIR, "xdatapublic", "benchmarks", "LargeJoin")
        ddl_path = os.path.join(largejoin_dir, "DDL.sql")
        sample_path = os.path.join(largejoin_dir, "SampleData.sql")
        queries_path = os.path.join(largejoin_dir, "queries.txt")
        mutants_path = os.path.join(largejoin_dir, "mutants.txt")

        self.assertTrue(os.path.exists(ddl_path), "LargeJoin DDL.sql must exist")
        self.assertTrue(os.path.exists(sample_path), "LargeJoin SampleData.sql must exist")
        self.assertTrue(os.path.exists(queries_path), "LargeJoin queries.txt must exist")
        self.assertTrue(os.path.exists(mutants_path), "LargeJoin mutants.txt must exist")

        with open(ddl_path, "r", encoding="utf-8") as f:
            ddl_text = f.read()

        poly_schema = parse_ddl_to_polygon(ddl_text, "largejoin")
        self.assertEqual(len(poly_schema["Tables"]), 10)

        # Verify sample data executes without FK violations
        with open(sample_path, "r", encoding="utf-8") as f:
            sample_sql = f.read()

        conn = sqlite3.connect(":memory:")
        conn.execute("PRAGMA foreign_keys = ON;")
        conn.executescript(ddl_text)
        conn.executescript(sample_sql)

        # Check that RA has rows and join2 query produces non-empty result
        cur = conn.cursor()
        cur.execute("SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) GROUP BY RA.B HAVING count(RA.B) > 3;")
        rows = cur.fetchall()
        self.assertGreater(len(rows), 0, "join2 should return non-empty result on sample data")

        # Verify evaluate_xdata finds sample data for largejoin
        resolved_sample = get_sample_data_path("largejoin", "largejoin")
        self.assertIsNotNone(resolved_sample)
        self.assertTrue(os.path.exists(resolved_sample))

if __name__ == "__main__":
    unittest.main()


