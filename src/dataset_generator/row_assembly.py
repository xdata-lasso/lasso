"""
Phase 3: Row Assembly
======================

Reads the resolved per-equivalence-class value lists and assembles them
into row dicts — one dict per row, keyed by column name.  Cross-column
CHECK constraints are repaired here using partial row context (the values
already assigned to earlier columns in the same row).

This phase has ZERO feature-specific special cases.  All semantic logic
(WHERE, GROUP BY, subquery, etc.) was fully resolved in Phases 1–2.
"""

from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot.expressions as exp

from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value, _eval_sqlglot_ast_python
from dataset_generator.resolver import _step_above, _step_below
from dataset_generator.types import ColumnSpec, UnionFind, col_key
from models import Column, Schema, Table



# ════════════════════════════════════════════════════════════════
# Phase 3: Row Assembly
# ════════════════════════════════════════════════════════════════

def _is_fk_to_omitted(
    col: Column,
    table: Table,
    omitted_tables: Set[str],
    specs: Optional[Dict[Tuple[str, str], ColumnSpec]] = None,
    root: Optional[Tuple[str, str]] = None,
) -> bool:
    """
    Check if ``col`` is a nullable (or SQLite-nullable composite PK) FK referencing
    a table in ``omitted_tables``.

    If so, the column should be set to NULL since there is no parent row
    to reference (the parent table was deliberately excluded). For composite FKs,
    columns that have an explicit query equality requirement keep their value as long
    as at least one sibling FK column can be set to NULL (satisfying SQL MATCH SIMPLE).
    """
    can_be_null = col.is_nullable or (
        col.is_primary_key
        and not getattr(col, "explicit_not_null", False)
        and sum(1 for c in table.columns if c.is_primary_key) > 1
    )
    if not can_be_null:
        return False
    for fk in table.foreign_keys:
        if fk.column_name.upper() == col.name.upper():
            if any(ot.upper() == fk.reference_table.upper() for ot in omitted_tables):
                if specs and root and root in specs and specs[root].required:
                    sibling_fks = [
                        f for f in table.foreign_keys
                        if f.reference_table.upper() == fk.reference_table.upper()
                        and f.column_name.upper() != col.name.upper()
                    ]
                    if sibling_fks:
                        return False
                return True
    return False


def _is_null_injected(table_name: str, col_name: str, null_injections: Optional[List[Tuple[str, str]]]) -> bool:
    """
    Check if (table_name, col_name) is in the null_injections list.

    Null injections are requested by attack strategies to force specific
    columns to NULL (e.g. to test IS NULL / IS NOT NULL mutations).
    """
    if not null_injections:
        return False
    return any(
        tn.upper() == table_name.upper() and cn.upper() == col_name.upper()
        for tn, cn in null_injections
    )


def is_duplicate_row(
    row: dict,
    existing_rows: List[dict],
    unique_cols: Optional[List[str]] = None,
    table: Optional[Table] = None,
) -> bool:
    """
    Check if ``row`` would violate PK/UNIQUE constraints against ``existing_rows``.

    If ``table`` is provided:
      - Composite or single Primary Key: all PK columns must match simultaneously.
      - Standalone UNIQUE columns: checked individually.
    If ``unique_cols`` is provided without ``table``:
      - Checks each column individually (backward-compatibility fallback).
    Otherwise falls back to full-row equality comparison.
    """
    if table is not None:
        pk_cols = [c.name for c in table.columns if c.is_primary_key]
        standalone_unique = [c.name for c in table.columns if c.is_unique and (not c.is_primary_key or len(pk_cols) > 1)]
        if pk_cols:
            for existing in existing_rows:
                if all(row.get(c) is not None and existing.get(c) == row.get(c) for c in pk_cols):
                    return True
        if standalone_unique:
            for existing in existing_rows:
                for uc in standalone_unique:
                    if row.get(uc) is not None and existing.get(uc) == row.get(uc):
                        return True
        if not pk_cols and not standalone_unique:
            return any(existing == row for existing in existing_rows)
        return False

    if unique_cols:
        for existing in existing_rows:
            for uc in unique_cols:
                if row.get(uc) is not None and existing.get(uc) == row.get(uc):
                    return True
        return False
    else:
        return any(existing == row for existing in existing_rows)


def _apply_check_with_context(
    val: Any, root: Tuple[str, str], row_context: dict,
    equiv: UnionFind, schema: Schema, table_name: str,
    disallowed: Optional[set] = None,
    specs: Optional[Dict[Tuple[str, str], ColumnSpec]] = None,
) -> Any:
    """
    Apply cross-column CHECK constraints and query intra-table comparison
    predicates using previously assigned column values as row context.
    """
    has_spec_checks = bool(specs and root in specs and specs[root].check_exprs)
    has_schema_checks = any(t.check_constraints for t in schema.tables.values())
    if not has_spec_checks and not has_schema_checks:
        return val

    rc_upper_keys = {k.upper() for k in (row_context or {})}
    ready_extra_checks = None
    if has_spec_checks:
        ready_extra_checks = []
        for cc in specs[root].check_exprs:
            expr = cc.get("expression")
            cc_col = (cc.get("column") or "").upper()
            if expr is not None:
                ref_cols = {c.name.upper() for c in expr.find_all(exp.Column) if c.name and c.name.upper() != cc_col}
                if not ref_cols.issubset(rc_upper_keys):
                    continue
            ready_extra_checks.append(cc)

    if has_schema_checks or ready_extra_checks:
        solved_any = False
        for (a_iter, c_iter) in equiv.parent.keys():
            if equiv.find((a_iter, c_iter)) == root:
                st = schema.find_table(a_iter)
                if st:
                    col = schema.find_column(st, c_iter)
                    if col:
                        val = solve_check_constraint_value(
                            schema, st, c_iter, col, val, disallowed_values=disallowed, row_context=row_context,
                            extra_checks=ready_extra_checks
                        )
                        solved_any = True
        if not solved_any and ready_extra_checks and val is not None and table_name:
            st = schema.find_table(table_name)
            col = schema.find_column(st, root[1]) if st else None
            if st and col:
                val = solve_check_constraint_value(
                    schema, st, col.name, col, val, disallowed_values=disallowed, row_context=row_context,
                    extra_checks=ready_extra_checks
                )

    if specs and root in specs:
        spec = specs[root]
        for cc in spec.check_exprs:
            expr = cc.get("expression")
            col = spec.column
            if expr and col:
                ref_cols = {c.name.upper() for c in expr.find_all(exp.Column) if c.name and c.name.upper() != col.name.upper()}
                if not ref_cols.issubset(rc_upper_keys):
                    continue
                try:
                    res = _eval_sqlglot_ast_python(expr, val, col.name, row_context)
                    if res is False:
                        is_left = hasattr(expr.left, 'name') and expr.left.name.upper() == col.name.upper()
                        other = expr.right if is_left else expr.left
                        other_val = _eval_sqlglot_ast_python(other, val, col.name, row_context)
                        if other_val is not None:
                            new_val = val
                            if (isinstance(expr, (exp.GT, exp.GTE)) and is_left) or (isinstance(expr, (exp.LT, exp.LTE)) and not is_left):
                                new_val = _step_above(other_val, col.data_type, col)
                                if spec.upper is not None and str(new_val) > str(spec.upper):
                                    new_val = val
                            elif (isinstance(expr, (exp.LT, exp.LTE)) and is_left) or (isinstance(expr, (exp.GT, exp.GTE)) and not is_left):
                                new_val = _step_below(other_val, col.data_type, col)
                                if spec.lower is not None and str(new_val) < str(spec.lower):
                                    new_val = val
                            val = new_val
                except Exception:
                    pass

    return val


def materialize_rows(
    table: Table, alias: str, equiv: UnionFind,
    value_lists: Dict[Tuple[str, str], List[Any]], row_count: int,
    schema: Schema, omitted_tables: Set[str],
    null_injections: Optional[List[Tuple[str, str]]],
    specs: Optional[Dict[Tuple[str, str], ColumnSpec]] = None,
) -> List[Dict[str, Any]]:
    """
    Phase 3: Build row dicts from the resolved value lists.

    For each row index 0..row_count-1, iterates over the table's columns
    and assigns each column's value from the pre-computed value list for
    its equivalence class root.  Special handling:
      - FK to omitted table  → NULL
      - Null injection        → NULL
      - Cross-column CHECK    → repaired using partial row context

    This function has ZERO feature-specific special cases.  All semantic
    logic (WHERE, GROUP BY, subquery, etc.) was resolved in Phases 1–2.

    Args:
        table:           The schema Table object.
        alias:           The alias used in the query for this table.
        equiv:           Union-find from Phase 0.
        value_lists:     Dict mapping equiv root → list of resolved values.
        row_count:       Number of rows to produce.
        schema:          Full schema (for CHECK constraint solving).
        omitted_tables:  Tables excluded from generation (FK → NULL).
        null_injections: Columns to force NULL.
        specs:           ColumnSpec dict (for disallowed-value context in CHECK repair).

    Returns:
        List of row dicts (column_name → value).
    """
    unique_cols = [c.name for c in table.columns if c.is_primary_key or c.is_unique]
    rows: List[Dict[str, Any]] = []
    has_any_checks = any(t.check_constraints for t in schema.tables.values()) or bool(
        specs and any(s.check_exprs for s in specs.values())
    )

    for i in range(row_count):
        row: Dict[str, Any] = {}
        for col in table.columns:
            root = equiv.find(col_key(alias, col.name))

            # FK to omitted table → NULL
            if _is_fk_to_omitted(col, table, omitted_tables, specs=specs, root=root):
                row[col.name] = None
                continue

            # Null injection → NULL
            if _is_null_injected(table.name, col.name, null_injections):
                row[col.name] = None
                continue

            # Read from resolved value list
            if col.name in value_lists:
                vl = value_lists[col.name]
                val = vl[i % len(vl)]
            elif root in value_lists:
                vl = value_lists[root]
                val = vl[i % len(vl)]
            else:
                val = generate_unique_value_for_column(col)

            # Cross-column CHECK constraint repair with row context
            if has_any_checks:
                disallowed = specs[root].disallowed if specs and root in specs else None
                val = _apply_check_with_context(val, root, row, equiv, schema, table.name, disallowed=disallowed, specs=specs)
            row[col.name] = val

        # Multi-pass repair for cross-column check constraints with forward/backward dependencies
        if has_any_checks:
            for _ in range(3):
                changed = False
                for col in table.columns:
                    if _is_null_injected(table.name, col.name, null_injections):
                        continue
                    root = equiv.find(col_key(alias, col.name))
                    disallowed = specs[root].disallowed if specs and root in specs else None
                    new_val = _apply_check_with_context(row[col.name], root, row, equiv, schema, table.name, disallowed=disallowed, specs=specs)
                    if new_val != row[col.name]:
                        row[col.name] = new_val
                        changed = True
                if not changed:
                    break

        if not is_duplicate_row(row, rows, unique_cols, table=table):
            rows.append(row)

    return rows


