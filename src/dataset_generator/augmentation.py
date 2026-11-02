"""
Phase 4: Dataset Augmentation
==============================

Appends unmatched parent rows — rows whose join/FK column values deliberately
do NOT appear in any matching row. This enables detection of LEFT→INNER join
mutations and NOT IN→IN subquery mutations.

This module owns Phase 4 of the dataset generation pipeline.
"""

from typing import Any, Dict, List, Set, Tuple

import sqlglot.expressions as exp

from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value

from dataset_generator.types import UnionFind, col_key
from models import Schema


def add_unmatched_rows(
    dataset: Dict[str, List[Dict[str, Any]]], parsed_query: Dict[str, Any],
    schema: Schema, equiv: UnionFind, not_in_roots: Set[Tuple[str, str]]
) -> None:
    """
    Phase 4: Add unmatched parent rows for LEFT JOIN and NOT IN semantics.

    For each table that participates in a LEFT JOIN or NOT IN subquery,
    appends one extra row whose join/FK column value does NOT appear in
    any matching row. This ensures:
      - LEFT JOIN queries produce NULL-extended rows (INNER JOIN would not)
      - NOT IN queries exclude these rows (IN would include them)

    The unmatched row is cloned from the last existing row, then its
    PK/UNIQUE/join columns are replaced with fresh unique values.
    """
    def _needs_unmatched(pq):
        """Check if the query has LEFT JOINs or NOT IN (subquery) predicates."""
        def _has_not_in(ast_node):
            """Walk an AST subtree looking for NOT IN with a subquery operand."""
            if not ast_node:
                return False
            for node in ast_node.walk():
                actual = node[0] if isinstance(node, tuple) else node
                if isinstance(actual, exp.Not) and isinstance(actual.this, exp.In):
                    if actual.this.args.get("query"):
                        return True
            return False
        if _has_not_in(pq.get("where_ast")) or _has_not_in(pq.get("having_ast")):
            return True
        for j in pq.get("joins", []):
            if j.get("type", "").upper() == "LEFT":
                return True
        return False

    if not _needs_unmatched(parsed_query):
        return

    # Collect LEFT JOIN column roots
    left_join_roots: Set[Tuple[str, str]] = set()
    for j in parsed_query.get("joins", []):
        if j.get("type", "").upper() == "LEFT":
            for pair in j.get("on_pairs", []):
                left_join_roots.add(equiv.find(col_key(pair["left"]["table"], pair["left"]["column"])))
                left_join_roots.add(equiv.find(col_key(pair["right"]["table"], pair["right"]["column"])))

    for st, rows in dataset.items():
        if not rows:
            continue
        table = schema.tables.get(st)
        if not table:
            continue
        unique_cols = [c for c in table.columns if c.is_primary_key or c.is_unique]
        if not unique_cols:
            continue

        new_row = rows[-1].copy()

        # Generate new PK and unique values
        for c in unique_cols:
            is_fk = any(fk.column_name.upper() == c.name.upper() for fk in table.foreign_keys)
            if not is_fk:
                new_val = generate_unique_value_for_column(c)
                new_row[c.name] = solve_check_constraint_value(
                    schema, st, c.name, c, new_val, row_context=new_row
                )

        # Handle other columns
        for c in table.columns:
            root = equiv.find(col_key(st, c.name))
            is_not_in = root in not_in_roots
            is_left_join = root in left_join_roots
            is_fk = any(fk.column_name.upper() == c.name.upper() for fk in table.foreign_keys)

            if (c.is_unique and not c.is_primary_key) or is_not_in or is_left_join:
                if is_left_join or is_not_in:
                    if c.is_nullable and not is_not_in:
                        new_row[c.name] = None
                    elif not is_fk:
                        new_val = generate_unique_value_for_column(c)
                        new_row[c.name] = solve_check_constraint_value(
                            schema, st, c.name, c, new_val, row_context=new_row
                        )
                else:
                    if c.is_nullable:
                        new_row[c.name] = None
                    else:
                        new_val = generate_unique_value_for_column(c)
                        new_row[c.name] = solve_check_constraint_value(
                            schema, st, c.name, c, new_val, row_context=new_row
                        )

        # Only add if not a PK duplicate
        pk_cols = [c for c in table.columns if c.is_primary_key]
        if not pk_cols:
            pk_cols = unique_cols
        is_dup = any(
            all(existing.get(pk.name) == new_row.get(pk.name) for pk in pk_cols)
            for existing in rows
        )
        if not is_dup:
            dataset[st].append(new_row)

def _get_row_val(row_dict: Dict[str, Any], col_name: str) -> Any:
    """Helper to look up a column in a row dict case-insensitively."""
    if col_name in row_dict:
        return row_dict[col_name]
    col_lower = col_name.lower()
    for k, v in row_dict.items():
        if k.lower() == col_lower:
            return v
    return None


def repair_orphan_rows(schema: Schema, dataset: Dict[str, List[Dict[str, Any]]]):
    """
    Scans the dataset for foreign key constraints and creates missing parent rows.
    Uses case-insensitive column lookups and a bounded loop to guarantee termination.
    """
    changed = True
    loop_count = 0
    while changed and loop_count < 20:
        changed = False
        loop_count += 1
        for table_name, rows in dataset.items():
            table = schema.tables.get(table_name)
            if not table:
                continue

            for row in list(rows):
                fks_by_ref_table = {}
                for fk in table.foreign_keys:
                    fks_by_ref_table.setdefault(fk.reference_table, []).append(fk)

                for ref_table_name, fk_list in fks_by_ref_table.items():
                    ref_table = schema.tables.get(ref_table_name)
                    if not ref_table:
                        # Try case-insensitive lookup in schema.tables
                        ref_key = schema.find_table(ref_table_name)
                        if ref_key:
                            ref_table = schema.tables[ref_key]
                            ref_table_name = ref_key
                        else:
                            continue

                    # Partition fk_list into sets where each set has distinct reference_columns
                    fk_sets = []
                    for fk in fk_list:
                        placed = False
                        for fk_set in fk_sets:
                            if not any(existing_fk.reference_column.lower() == fk.reference_column.lower() for existing_fk in fk_set):
                                fk_set.append(fk)
                                placed = True
                                break
                        if not placed:
                            fk_sets.append([fk])

                    if ref_table_name not in dataset:
                        dataset[ref_table_name] = []

                    ref_rows = dataset[ref_table_name]
                    ref_pk_cols = [c for c in ref_table.columns if c.is_primary_key]

                    for fk_set in fk_sets:
                        fk_mapping = {}
                        has_none = False
                        for fk in fk_set:
                            val = _get_row_val(row, fk.column_name)
                            ref_col_obj = next((c for c in ref_table.columns if c.name.lower() == fk.reference_column.lower()), None)
                            actual_ref_name = ref_col_obj.name if ref_col_obj else fk.reference_column
                            is_indiv_unique = bool(
                                ref_col_obj
                                and (ref_col_obj.is_unique or (ref_col_obj.is_primary_key and len(ref_pk_cols) == 1))
                            )
                            if val is None:
                                if is_indiv_unique:
                                    continue
                                has_none = True
                                break
                            if is_indiv_unique and any(
                                _get_row_val(r, actual_ref_name) == val
                                or (_get_row_val(r, actual_ref_name) is not None and str(_get_row_val(r, actual_ref_name)) == str(val))
                                for r in ref_rows
                            ):
                                continue
                            fk_mapping[actual_ref_name] = val

                        if has_none or not fk_mapping:
                            continue

                        exists = False
                        for r in ref_rows:
                            if all(
                                _get_row_val(r, ref_col) == val or 
                                (_get_row_val(r, ref_col) is not None and val is not None and str(_get_row_val(r, ref_col)) == str(val))
                                for ref_col, val in fk_mapping.items()
                            ):
                                exists = True
                                break

                        if not exists:
                            new_row = {}
                            for col in ref_table.columns:
                                fk_val = None
                                has_fk = False
                                for map_col, map_val in fk_mapping.items():
                                    if map_col.lower() == col.name.lower():
                                        fk_val = map_val
                                        has_fk = True
                                        break

                                if has_fk:
                                    val = fk_val
                                    if col.is_primary_key and "int" in (col.data_type or "").lower():
                                        try:
                                            val = int(val)
                                        except (ValueError, TypeError):
                                            val = generate_unique_value_for_column(col)
                                    valid_val = solve_check_constraint_value(
                                        schema, ref_table_name, col.name, col, val, row_context=new_row
                                    )
                                    new_row[col.name] = valid_val
                                    if valid_val != fk_val:
                                        for fk in fk_set:
                                            if fk.reference_column.lower() == col.name.lower():
                                                if fk.column_name in row:
                                                    row[fk.column_name] = valid_val
                                                else:
                                                    for k in list(row.keys()):
                                                        if k.lower() == fk.column_name.lower():
                                                            row[k] = valid_val
                                elif col.is_primary_key or not col.is_nullable:
                                    is_fk = any(f.column_name.lower() == col.name.lower() for f in ref_table.foreign_keys)
                                    if col.is_nullable and is_fk:
                                        new_row[col.name] = None
                                    else:
                                        val = generate_unique_value_for_column(col)
                                        valid_val = solve_check_constraint_value(
                                            schema, ref_table_name, col.name, col, val
                                        )
                                        if col.is_unique or col.is_primary_key:
                                            attempts = 0
                                            while attempts < 20 and any(
                                                _get_row_val(r, col.name) == valid_val
                                                or (_get_row_val(r, col.name) is not None and valid_val is not None and str(_get_row_val(r, col.name)) == str(valid_val))
                                                for r in ref_rows
                                            ):
                                                attempts += 1
                                                val = generate_unique_value_for_column(col)
                                                valid_val = solve_check_constraint_value(
                                                    schema, ref_table_name, col.name, col, val
                                                )
                                        new_row[col.name] = valid_val
                                else:
                                    new_row[col.name] = None

                            dataset[ref_table_name].append(new_row)
                            changed = True


def topological_sort_tables(schema: Schema, tables: list[str]) -> list[str]:
    dependencies = {t: set() for t in tables}
    for t in tables:
        if t in schema.tables:
            for fk in schema.tables[t].foreign_keys:
                if fk.reference_table in tables and fk.reference_table != t:
                    dependencies[t].add(fk.reference_table)
                    
    sorted_tables = []
    while dependencies:
        free_tables = [t for t, deps in dependencies.items() if not deps]
        if not free_tables:
            sorted_tables.extend(dependencies.keys())
            break
        
        # Sort alphabetically for determinism
        free_tables.sort()
        for t in free_tables:
            sorted_tables.append(t)
            del dependencies[t]
            for deps in dependencies.values():
                deps.discard(t)
                
    return sorted_tables
