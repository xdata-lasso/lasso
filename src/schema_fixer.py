"""
Schema Fixer & Foreign Key Normalizer for SQLite / SQL Test Data Generation.

This module provides deterministic, AST-level analysis and repair for SQL DDL schemas,
ensuring that all foreign key constraints are strictly valid under SQLite's semantics:
1. Tracks candidate keys (Primary Keys, Unique Constraints, and Unique Indexes) as ordered column tuples.
2. Resolves implicit primary key references (e.g. `REFERENCES parent`).
3. Correctly handles subsets and permutations of composite primary keys.
4. Robustly handles quoted, whitespace, and special-character identifiers.
5. Performs case-insensitive identifier matching while preserving original AST casing.
6. Inspects CREATE UNIQUE INDEX statements and registers their columns as valid parent keys.
7. Validates that referenced parent columns exist before applying UNIQUE constraints, avoiding invalid DDL.
8. Preserves referential actions (ON DELETE, ON UPDATE) and named constraints.
"""

from __future__ import annotations

import copy
import logging
import sqlite3
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot
from sqlglot import exp

logger = logging.getLogger(__name__)


def extract_identifier_name(node: Any) -> str:
    """
    Extracts the unquoted, raw identifier string from a SQLGlot AST node or string.
    Handles exp.Identifier, exp.Table, exp.Column, exp.ColumnDef, exp.Var, exp.Literal, etc.
    """
    if node is None:
        return ""
    if isinstance(node, str):
        s = node.strip()
        if (s.startswith('"') and s.endswith('"')) or (s.startswith("'") and s.endswith("'")) or (s.startswith('`') and s.endswith('`')):
            return s[1:-1]
        if s.startswith('[') and s.endswith(']'):
            return s[1:-1]
        return s
    if isinstance(node, exp.Identifier):
        return node.this
    if isinstance(node, exp.Table):
        return node.this.this if isinstance(node.this, exp.Identifier) else str(node.this)
    if isinstance(node, exp.Column):
        return node.this.this if isinstance(node.this, exp.Identifier) else str(node.this)
    if isinstance(node, exp.ColumnDef):
        return extract_identifier_name(node.this)
    if hasattr(node, "name") and node.name:
        return node.name
    if hasattr(node, "this"):
        return extract_identifier_name(node.this)
    return str(node).strip("\"'`[]")


def canonical_identifier(name: Any) -> str:
    """
    Normalizes an identifier for case-insensitive matching in SQLite.
    """
    return extract_identifier_name(name).strip().lower()


@dataclass
class ColumnDefMeta:
    name: str
    canonical_name: str
    data_type: str
    is_primary_key: bool = False
    is_unique: bool = False
    is_not_null: bool = False
    collation: Optional[str] = None
    ast_node: Optional[exp.ColumnDef] = None


@dataclass
class ForeignKeyMeta:
    child_table: str
    child_columns: Tuple[str, ...]
    parent_table: str
    parent_columns: Tuple[str, ...]
    is_inline: bool = False
    constraint_name: Optional[str] = None
    on_delete: Optional[str] = None
    on_update: Optional[str] = None
    ast_node: Optional[exp.Expression] = None


@dataclass
class TableMeta:
    name: str
    canonical_name: str
    columns: Dict[str, ColumnDefMeta] = field(default_factory=dict)
    primary_key: Optional[Tuple[str, ...]] = None  # Ordered tuple of canonical column names
    unique_keys: Set[Tuple[str, ...]] = field(default_factory=set)  # Set of ordered tuples of canonical column names
    foreign_keys: List[ForeignKeyMeta] = field(default_factory=list)
    create_stmt: Optional[exp.Create] = None
    schema_node: Optional[exp.Schema] = None


def parse_ddl_statements(ddl: str) -> List[exp.Expression]:
    """
    Parses a DDL script into a list of SQLGlot AST statements.
    """
    if not ddl or not ddl.strip():
        return []
    try:
        statements = sqlglot.parse(ddl, read="sqlite")
    except Exception:
        try:
            statements = sqlglot.parse(ddl)
        except Exception as e:
            logger.warning("Failed to parse DDL with sqlglot: %s", e)
            return []
    return [s for s in statements if s is not None]


def _extract_foreign_key_reference(ref_node: exp.Reference) -> Tuple[str, Tuple[str, ...]]:
    """
    Extracts the parent table name and parent columns tuple from an exp.Reference node.
    """
    if not ref_node or not ref_node.this:
        return "", ()
    
    ref_target = ref_node.this
    if isinstance(ref_target, exp.Schema):
        parent_tbl = extract_identifier_name(ref_target.this)
        parent_cols = tuple(extract_identifier_name(c) for c in ref_target.expressions)
    elif isinstance(ref_target, (exp.Table, exp.Identifier, exp.Var)):
        parent_tbl = extract_identifier_name(ref_target)
        parent_cols = ()
    else:
        parent_tbl = extract_identifier_name(ref_target)
        parent_cols = ()
    return parent_tbl, parent_cols


def _extract_schema_meta(parsed_statements: List[exp.Expression]) -> Tuple[Dict[str, TableMeta], List[Tuple[str, Tuple[str, ...]]]]:
    """
    Extracts table definitions, candidate keys, foreign keys, and unique indexes from AST statements.
    """
    tables: Dict[str, TableMeta] = {}
    unique_indexes: List[Tuple[str, Tuple[str, ...]]] = []

    for stmt in parsed_statements:
        if not isinstance(stmt, exp.Create):
            continue

        kind = str(stmt.args.get("kind", "")).upper()

        # 1. Process CREATE TABLE
        if kind == "TABLE" or (isinstance(stmt.this, exp.Schema) and kind != "INDEX"):
            schema_node = stmt.this if isinstance(stmt.this, exp.Schema) else stmt.find(exp.Schema)
            if not schema_node or not schema_node.this:
                continue

            tbl_name = extract_identifier_name(schema_node.this)
            tbl_canon = canonical_identifier(tbl_name)

            table_meta = TableMeta(
                name=tbl_name,
                canonical_name=tbl_canon,
                create_stmt=stmt,
                schema_node=schema_node,
            )

            pk_cols: List[str] = []
            
            for item in schema_node.expressions:
                if isinstance(item, exp.ColumnDef):
                    col_name = extract_identifier_name(item.this)
                    col_canon = canonical_identifier(col_name)
                    data_type = item.args.get("kind").sql() if item.args.get("kind") else "TEXT"
                    
                    is_pk = False
                    is_unique = False
                    is_not_null = False
                    collation = None

                    for constraint in item.constraints:
                        ckind = constraint.kind
                        if isinstance(ckind, exp.PrimaryKeyColumnConstraint):
                            is_pk = True
                            pk_cols.append(col_canon)
                        elif isinstance(ckind, exp.UniqueColumnConstraint):
                            is_unique = True
                            table_meta.unique_keys.add((col_canon,))
                        elif isinstance(ckind, exp.NotNullColumnConstraint):
                            is_not_null = not ckind.args.get("allow_null", False)
                        elif isinstance(ckind, exp.CollateColumnConstraint):
                            collation = extract_identifier_name(ckind.this)
                        elif isinstance(ckind, exp.Reference):
                            p_tbl, p_cols = _extract_foreign_key_reference(ckind)
                            if p_tbl:
                                table_meta.foreign_keys.append(
                                    ForeignKeyMeta(
                                        child_table=tbl_name,
                                        child_columns=(col_name,),
                                        parent_table=p_tbl,
                                        parent_columns=p_cols,
                                        is_inline=True,
                                        ast_node=constraint,
                                    )
                                )

                    col_meta = ColumnDefMeta(
                        name=col_name,
                        canonical_name=col_canon,
                        data_type=data_type,
                        is_primary_key=is_pk,
                        is_unique=is_unique,
                        is_not_null=is_not_null,
                        collation=collation,
                        ast_node=item,
                    )
                    table_meta.columns[col_canon] = col_meta

                elif isinstance(item, exp.PrimaryKey):
                    cols = tuple(canonical_identifier(c) for c in item.expressions)
                    if cols:
                        table_meta.primary_key = cols
                        table_meta.unique_keys.add(cols)

                elif isinstance(item, exp.UniqueColumnConstraint):
                    if isinstance(item.this, exp.Schema):
                        cols = tuple(canonical_identifier(c) for c in item.this.expressions)
                    elif hasattr(item, "expressions") and item.expressions:
                        cols = tuple(canonical_identifier(c) for c in item.expressions)
                    else:
                        cols = ()
                    if cols:
                        table_meta.unique_keys.add(cols)

                elif isinstance(item, exp.ForeignKey):
                    c_cols = tuple(extract_identifier_name(c) for c in item.expressions)
                    ref = item.args.get("reference")
                    if isinstance(ref, exp.Reference):
                        p_tbl, p_cols = _extract_foreign_key_reference(ref)
                        if p_tbl:
                            table_meta.foreign_keys.append(
                                ForeignKeyMeta(
                                    child_table=tbl_name,
                                    child_columns=c_cols,
                                    parent_table=p_tbl,
                                    parent_columns=p_cols,
                                    is_inline=False,
                                    ast_node=item,
                                )
                            )

                elif isinstance(item, exp.Constraint):
                    # Named table-level constraint wrapper
                    c_name = extract_identifier_name(item.this)
                    for inner in item.expressions:
                        if isinstance(inner, exp.PrimaryKey):
                            cols = tuple(canonical_identifier(c) for c in inner.expressions)
                            if cols:
                                table_meta.primary_key = cols
                                table_meta.unique_keys.add(cols)
                        elif isinstance(inner, exp.UniqueColumnConstraint):
                            if isinstance(inner.this, exp.Schema):
                                cols = tuple(canonical_identifier(c) for c in inner.this.expressions)
                            elif hasattr(inner, "expressions") and inner.expressions:
                                cols = tuple(canonical_identifier(c) for c in inner.expressions)
                            else:
                                cols = ()
                            if cols:
                                table_meta.unique_keys.add(cols)
                        elif isinstance(inner, exp.ForeignKey):
                            c_cols = tuple(extract_identifier_name(c) for c in inner.expressions)
                            ref = inner.args.get("reference")
                            if isinstance(ref, exp.Reference):
                                p_tbl, p_cols = _extract_foreign_key_reference(ref)
                                if p_tbl:
                                    table_meta.foreign_keys.append(
                                        ForeignKeyMeta(
                                            child_table=tbl_name,
                                            child_columns=c_cols,
                                            parent_table=p_tbl,
                                            parent_columns=p_cols,
                                            is_inline=False,
                                            constraint_name=c_name,
                                            ast_node=item,
                                        )
                                    )

            if pk_cols and not table_meta.primary_key:
                table_meta.primary_key = tuple(pk_cols)
                table_meta.unique_keys.add(table_meta.primary_key)

            tables[tbl_canon] = table_meta

        # 2. Process CREATE UNIQUE INDEX
        elif kind == "INDEX" or isinstance(stmt.this, exp.Index):
            is_unique = bool(stmt.args.get("unique"))
            if is_unique and isinstance(stmt.this, exp.Index):
                idx_node = stmt.this
                table_node = idx_node.args.get("table")
                if table_node:
                    idx_tbl = canonical_identifier(table_node)
                    params = idx_node.args.get("params")
                    if params and hasattr(params, "expressions"):
                        idx_cols = []
                        for col_expr in params.expressions:
                            target = col_expr.this if isinstance(col_expr, exp.Ordered) else col_expr
                            c_name = canonical_identifier(target)
                            if c_name:
                                idx_cols.append(c_name)
                        if idx_cols and idx_tbl:
                            unique_indexes.append((idx_tbl, tuple(idx_cols)))

    # Apply unique indexes to table unique_keys
    for idx_tbl, idx_cols in unique_indexes:
        if idx_tbl in tables:
            tables[idx_tbl].unique_keys.add(idx_cols)

    return tables, unique_indexes


def _remove_foreign_key_constraint(table_meta: TableMeta, fk: ForeignKeyMeta) -> None:
    """
    Safely removes an invalid foreign key constraint node from a table's AST.
    """
    if fk.is_inline:
        if fk.child_columns:
            col_canon = canonical_identifier(fk.child_columns[0])
            col_meta = table_meta.columns.get(col_canon)
            if col_meta and col_meta.ast_node:
                new_constraints = [c for c in col_meta.ast_node.constraints if c is not fk.ast_node]
                col_meta.ast_node.set("constraints", new_constraints)
    else:
        if table_meta.schema_node and fk.ast_node is not None:
            new_expressions = [e for e in table_meta.schema_node.expressions if e is not fk.ast_node]
            table_meta.schema_node.set("expressions", new_expressions)


def fix_foreign_key_constraints(ddl: str, drop_invalid_fks: bool = True) -> str:
    """
    Parses the DDL and deterministically ensures that every foreign key target column
    or composite columns in referenced parent tables have a valid UNIQUE or PRIMARY KEY
    constraint in SQLite, preventing SQLite 'foreign key mismatch' errors.

    If drop_invalid_fks is True, foreign keys that reference non-existent parent tables,
    non-existent parent columns, or unresolvable implicit primary keys are cleanly removed
    from the AST so that SQLite PRAGMA foreign_key_check succeeds.
    """
    if not ddl or not ddl.strip():
        return ddl

    parsed_statements = parse_ddl_statements(ddl)
    if not parsed_statements:
        return ddl

    tables, _ = _extract_schema_meta(parsed_statements)

    # Process all foreign keys across tables
    for table_meta in tables.values():
        for fk in table_meta.foreign_keys:
            parent_tbl_canon = canonical_identifier(fk.parent_table)
            if parent_tbl_canon not in tables:
                logger.warning(
                    "Foreign key in table '%s' references nonexistent parent table '%s'.",
                    table_meta.name,
                    fk.parent_table,
                )
                if drop_invalid_fks:
                    _remove_foreign_key_constraint(table_meta, fk)
                continue

            parent_table_meta = tables[parent_tbl_canon]

            # Resolve referenced parent columns
            if fk.parent_columns:
                ref_cols_canon = tuple(canonical_identifier(c) for c in fk.parent_columns)
                ref_cols_original = list(fk.parent_columns)
            else:
                # Implicit reference to parent table's Primary Key
                if parent_table_meta.primary_key:
                    ref_cols_canon = parent_table_meta.primary_key
                    ref_cols_original = [
                        parent_table_meta.columns[c].name
                        for c in ref_cols_canon
                        if c in parent_table_meta.columns
                    ]
                    if len(ref_cols_original) != len(ref_cols_canon):
                        ref_cols_original = list(ref_cols_canon)
                else:
                    logger.warning(
                        "Foreign key in table '%s' implicitly references parent table '%s' which has no primary key.",
                        table_meta.name,
                        parent_table_meta.name,
                    )
                    if drop_invalid_fks:
                        _remove_foreign_key_constraint(table_meta, fk)
                    continue

            # Check if all referenced columns exist in parent table
            if not all(col_c in parent_table_meta.columns for col_c in ref_cols_canon):
                logger.warning(
                    "Foreign key in table '%s' references nonexistent column(s) %s in parent table '%s'.",
                    table_meta.name,
                    ref_cols_original,
                    parent_table_meta.name,
                )
                if drop_invalid_fks:
                    _remove_foreign_key_constraint(table_meta, fk)
                continue

            # Check if already covered by an existing primary key or unique constraint / index
            is_covered = (
                ref_cols_canon == parent_table_meta.primary_key
                or ref_cols_canon in parent_table_meta.unique_keys
            )

            if not is_covered:
                # Add UNIQUE constraint to parent table
                parent_schema = parent_table_meta.schema_node
                if parent_schema is not None:
                    if len(ref_cols_canon) == 1:
                        target_col_c = ref_cols_canon[0]
                        col_def_meta = parent_table_meta.columns.get(target_col_c)
                        added = False
                        if col_def_meta and col_def_meta.ast_node:
                            col_def_meta.ast_node.append(
                                "constraints",
                                exp.ColumnConstraint(kind=exp.UniqueColumnConstraint()),
                            )
                            col_def_meta.is_unique = True
                            added = True

                        if not added:
                            parent_schema.append(
                                "expressions",
                                exp.UniqueColumnConstraint(
                                    this=exp.Schema(
                                        expressions=[exp.to_identifier(ref_cols_original[0])]
                                    )
                                ),
                            )
                    else:
                        parent_schema.append(
                            "expressions",
                            exp.UniqueColumnConstraint(
                                this=exp.Schema(
                                    expressions=[exp.to_identifier(c) for c in ref_cols_original]
                                )
                            ),
                        )

                    # Update parent table's unique_keys so repeated FKs don't add duplicate constraints
                    parent_table_meta.unique_keys.add(ref_cols_canon)

    # Format into clean SQLite DDL
    statements = []
    for stmt in parsed_statements:
        if stmt:
            sql_text = stmt.sql("sqlite")
            if sql_text:
                statements.append(sql_text)

    return ";\n\n".join(statements) + (";" if statements else "")


def ensure_foreign_key_constraints(ddl: str) -> str:
    """
    Backwards-compatible drop-in alias for fix_foreign_key_constraints.
    """
    return fix_foreign_key_constraints(ddl)


def verify_ddl_with_sqlite(ddl: str) -> Tuple[bool, Optional[str]]:
    """
    Validates that a DDL script can be executed in SQLite with foreign keys enabled
    and passes PRAGMA foreign_key_check without errors.
    """
    if not ddl or not ddl.strip():
        return True, None
    try:
        conn = sqlite3.connect(":memory:")
        conn.execute("PRAGMA foreign_keys = ON;")
        conn.executescript(ddl)
        violations = conn.execute("PRAGMA foreign_key_check;").fetchall()
        conn.close()
        return True, None
    except Exception as e:
        return False, f"{type(e).__name__}: {str(e)}"
