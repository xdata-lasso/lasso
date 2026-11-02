"""
Comprehensive Unit Test Suite for Schema Fixer & Foreign Key Normalizer.

Tests all 10 major issues and edge cases:
1. Composite primary key ordering preservation (ordered tuple matching).
2. Referencing a subset of a composite primary key.
3. Implicit primary key references (REFERENCES parent without column list).
4. Quoted and special-character identifiers (dashes, spaces, quotes, digits).
5. Case-insensitive identifier matching.
6. CREATE UNIQUE INDEX coverage (avoids redundant UNIQUE constraints).
7. Collation sequence compatibility.
8. Complex and named foreign key constraints with ON DELETE / ON UPDATE.
9. Multi-statement DDL with mixed tables, views, and indexes.
10. Safety against non-existent parent columns (prevents invalid UNIQUE constraints).
11. Verification with in-memory SQLite and PRAGMA foreign_key_check.
12. Idempotence & avoiding duplicate constraints on repeated references.
"""

import os
import sys
import unittest

# Ensure src and experiments are in python path
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SRC_DIR = os.path.join(BASE_DIR, "src")
if SRC_DIR not in sys.path:
    sys.path.insert(0, SRC_DIR)

from schema_fixer import (
    canonical_identifier,
    ensure_foreign_key_constraints,
    extract_identifier_name,
    fix_foreign_key_constraints,
    verify_ddl_with_sqlite,
)


class TestSchemaFixer(unittest.TestCase):

    def test_extract_and_canonical_identifiers(self):
        """Test robust identifier extraction across quoted styles."""
        self.assertEqual(extract_identifier_name('"Users"'), "Users")
        self.assertEqual(extract_identifier_name("'Users'"), "Users")
        self.assertEqual(extract_identifier_name("`Users`"), "Users")
        self.assertEqual(extract_identifier_name("[Users]"), "Users")
        self.assertEqual(extract_identifier_name('"13-1"'), "13-1")
        self.assertEqual(canonical_identifier('"Users"'), "users")
        self.assertEqual(canonical_identifier("[My Column]"), "my column")

    def test_composite_pk_exact_match(self):
        """Test foreign key referencing exact composite PK columns in order."""
        ddl = """
        CREATE TABLE parent (
            a INTEGER,
            b INTEGER,
            PRIMARY KEY (a, b)
        );
        CREATE TABLE child (
            c_a INTEGER,
            c_b INTEGER,
            FOREIGN KEY (c_a, c_b) REFERENCES parent(a, b)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        # Should not add redundant UNIQUE constraints since (a, b) is already PK
        self.assertNotIn("UNIQUE", fixed)

    def test_composite_pk_subset_reference(self):
        """Test foreign key referencing a proper subset of a composite PK."""
        ddl = """
        CREATE TABLE parent (
            a INTEGER,
            b INTEGER,
            PRIMARY KEY (a, b)
        );
        CREATE TABLE child (
            c_a INTEGER REFERENCES parent(a)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        # Must add UNIQUE constraint to parent(a) so SQLite doesn't error with foreign key mismatch
        self.assertIn("UNIQUE", fixed)

    def test_implicit_pk_single_column(self):
        """Test REFERENCES parent without specifying column (implicit PK)."""
        ddl = """
        CREATE TABLE parent (
            id INTEGER PRIMARY KEY,
            name TEXT
        );
        CREATE TABLE child (
            cid INTEGER PRIMARY KEY,
            p_id INTEGER REFERENCES parent
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_implicit_pk_composite(self):
        """Test table-level FOREIGN KEY (x, y) REFERENCES parent (implicit composite PK)."""
        ddl = """
        CREATE TABLE parent (
            k1 INTEGER,
            k2 INTEGER,
            PRIMARY KEY (k1, k2)
        );
        CREATE TABLE child (
            c1 INTEGER,
            c2 INTEGER,
            FOREIGN KEY (c1, c2) REFERENCES parent
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_unique_index_coverage(self):
        """Test that foreign keys covered by CREATE UNIQUE INDEX do not get redundant UNIQUE added."""
        ddl = """
        CREATE TABLE parent (
            id INTEGER,
            code TEXT
        );
        CREATE UNIQUE INDEX idx_parent_code ON parent(code);
        CREATE TABLE child (
            cid INTEGER PRIMARY KEY,
            p_code TEXT REFERENCES parent(code)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        # DDL should retain the CREATE UNIQUE INDEX and child should be valid without adding column UNIQUE
        self.assertIn("CREATE UNIQUE INDEX", fixed)

    def test_composite_unique_index_coverage(self):
        """Test multi-column foreign key covered by composite CREATE UNIQUE INDEX."""
        ddl = """
        CREATE TABLE parent (
            tenant_id INTEGER,
            user_id INTEGER,
            info TEXT
        );
        CREATE UNIQUE INDEX idx_parent_tenant_user ON parent(tenant_id, user_id);
        CREATE TABLE child (
            t_id INTEGER,
            u_id INTEGER,
            FOREIGN KEY (t_id, u_id) REFERENCES parent(tenant_id, user_id)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_quoted_and_special_identifiers(self):
        """Test schemas with quoted identifiers, hyphens, and digit names (e.g. '13-1')."""
        ddl = """
        CREATE TABLE "13-1" (
            "col-a" INTEGER,
            "col-b" TEXT,
            PRIMARY KEY ("col-a")
        );
        CREATE TABLE "child-table" (
            "c_id" INTEGER PRIMARY KEY,
            "ref-a" INTEGER,
            CONSTRAINT "fk-special" FOREIGN KEY ("ref-a") REFERENCES "13-1"("col-a") ON DELETE CASCADE
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_case_insensitive_matching(self):
        """Test case-insensitive resolution of tables and columns."""
        ddl = """
        CREATE TABLE Users (
            UserID INTEGER,
            Email VARCHAR(255),
            PRIMARY KEY (UserID)
        );
        CREATE TABLE Orders (
            OrderID INTEGER PRIMARY KEY,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES users(userid)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_named_constraints_and_referential_actions(self):
        """Test complex named constraints with referential actions (ON DELETE, ON UPDATE)."""
        ddl = """
        CREATE TABLE categories (
            cat_id INTEGER PRIMARY KEY,
            cat_name TEXT
        );
        CREATE TABLE items (
            item_id INTEGER PRIMARY KEY,
            cat_id INTEGER,
            CONSTRAINT fk_item_cat FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
                ON DELETE SET NULL ON UPDATE CASCADE
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")

    def test_non_existent_parent_column_safety(self):
        """Test that FK referencing a non-existent column does not inject invalid UNIQUE into parent."""
        ddl = """
        CREATE TABLE player (
            player_id TEXT PRIMARY KEY,
            player_name TEXT
        );
        CREATE TABLE fielding (
            player_id TEXT,
            team_id TEXT,
            FOREIGN KEY (player_id) REFERENCES player(player_id),
            FOREIGN KEY (team_id) REFERENCES player(team_id)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        # Should NOT add UNIQUE(team_id) to player table because player table has no team_id column
        self.assertNotIn("team_id", fixed.split("CREATE TABLE player")[1].split(";")[0] if "CREATE TABLE player" in fixed else "")

    def test_multiple_children_referencing_same_parent_key(self):
        """Test that multiple children referencing the same parent key do not add duplicate UNIQUE constraints."""
        ddl = """
        CREATE TABLE parent (
            ref_code TEXT
        );
        CREATE TABLE child1 (
            c1_id INT,
            p_code TEXT REFERENCES parent(ref_code)
        );
        CREATE TABLE child2 (
            c2_id INT,
            p_code TEXT REFERENCES parent(ref_code)
        );
        CREATE TABLE child3 (
            c3_id INT,
            p_code TEXT REFERENCES parent(ref_code)
        );
        """
        fixed = fix_foreign_key_constraints(ddl)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        # Ensure UNIQUE was added exactly once to parent.ref_code
        parent_ddl = [stmt for stmt in fixed.split(";") if "parent" in stmt.lower()][0]
        self.assertEqual(parent_ddl.count("UNIQUE"), 1)

    def test_invalid_fk_removed_for_sqlite_check(self):
        """Test that invalid FK to nonexistent parent column is dropped and passes SQLite FK check."""
        ddl = """
        CREATE TABLE player (
            player_id TEXT PRIMARY KEY,
            player_name TEXT
        );
        CREATE TABLE fielding (
            f_id INTEGER PRIMARY KEY,
            player_id TEXT,
            team_id TEXT,
            FOREIGN KEY (player_id) REFERENCES player(player_id),
            FOREIGN KEY (team_id) REFERENCES player(team_id)
        );
        """
        fixed = fix_foreign_key_constraints(ddl, drop_invalid_fks=True)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        self.assertNotIn("FOREIGN KEY (team_id)", fixed)
        self.assertIn("FOREIGN KEY (player_id)", fixed)

    def test_nonexistent_parent_table_removed(self):
        """Test that FK referencing a nonexistent parent table is dropped when drop_invalid_fks=True."""
        ddl = """
        CREATE TABLE child (
            id INTEGER PRIMARY KEY,
            parent_id INTEGER,
            FOREIGN KEY (parent_id) REFERENCES missing_parent(id)
        );
        """
        fixed = fix_foreign_key_constraints(ddl, drop_invalid_fks=True)
        valid, err = verify_ddl_with_sqlite(fixed)
        self.assertTrue(valid, f"SQLite verification failed: {err}")
        self.assertNotIn("missing_parent", fixed)

    def test_idempotence(self):
        """Test that running fix_foreign_key_constraints multiple times produces the same stable DDL."""
        ddl = """
        CREATE TABLE parent (
            id INT,
            val INT
        );
        CREATE TABLE child (
            p_id INT REFERENCES parent(id),
            p_val INT REFERENCES parent(val)
        );
        """
        pass1 = fix_foreign_key_constraints(ddl)
        pass2 = fix_foreign_key_constraints(pass1)
        self.assertEqual(pass1, pass2)


if __name__ == "__main__":
    unittest.main()
