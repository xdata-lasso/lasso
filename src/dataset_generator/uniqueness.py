"""
Dataset Uniqueness & Safety Net Post-Processing
=================================================

Contains dataset-level safety net utilities to enforce Primary Key (PK) and
UNIQUE constraints post-generation, as well as functions for merging and
deduplicating generated datasets.

Extracted from pipeline.py for Single Responsibility Principle (SRP) and
Separation of Concerns.
"""

import copy
from typing import Any, Dict, List, Optional, Set, Tuple

from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.utils import extract_self_offset_patterns
from models import Schema


def _norm_val(v: Any) -> str | None:
    """Normalize numeric values (e.g. 1.0 -> '1') for exact string comparison."""
    if v is None:
        return None
    if isinstance(v, float) and v.is_integer():
        return str(int(v))
    return str(v)


def ensure_dataset_uniqueness(
    schema: Schema, data: Dict[str, List[Dict[str, Any]]]
) -> Dict[str, List[Dict[str, Any]]]:
    """
    Final safety net: Guarantee every table's rows respect PK and UNIQUE constraints.

    This is a post-processing pass that catches any uniqueness violations that
    may have slipped through earlier phases (e.g. due to value_injections or
    cross-table equivalence class conflicts).

    For composite primary keys, uniqueness is checked on the full PK tuple
    (individual columns may repeat). Standalone UNIQUE columns are enforced
    individually. Conflicting values are replaced with fresh unique values
    from ``generate_unique_value_for_column``.
    """
    if not schema or not schema.tables:
        return data

    fixed_data: Dict[str, List[Dict[str, Any]]] = {}
    for t_name, rows in data.items():
        table = schema.tables.get(t_name)
        if not table or not rows:
            fixed_data[t_name] = rows
            continue

        pk_cols = [c for c in table.columns if c.is_primary_key]
        standalone_unique_cols = [c for c in table.columns if c.is_unique and (not c.is_primary_key or len(pk_cols) > 1)]
        composite_unique_constraints = getattr(table, "unique_constraints", [])
        not_null_cols = [
            c for c in table.columns
            if getattr(c, "explicit_not_null", False)
            or (c.is_primary_key and len(pk_cols) == 1 and "int" in (c.data_type or "").lower())
        ]

        if not pk_cols and not standalone_unique_cols and not composite_unique_constraints and not not_null_cols:
            fixed_data[t_name] = rows
            continue

        seen_pk_tuples: Set[Tuple[Any, ...]] = set()
        seen_unique_per_col: Dict[str, set] = {c.name: set() for c in standalone_unique_cols}
        seen_uc_tuples: Dict[Tuple[str, ...], Set[Tuple[Any, ...]]] = {tuple(uc): set() for uc in composite_unique_constraints}
        new_rows: List[Dict[str, Any]] = []

        for row in rows:
            row_copy = copy.deepcopy(row)

            # 0. Enforce NOT NULL and single-column PK non-null / integer-rowid type invariants
            for col in table.columns:
                if row_copy.get(col.name) == "NULL" and (
                    col.is_numeric or col.is_primary_key or getattr(col, "explicit_not_null", False)
                ):
                    row_copy[col.name] = None

            for col in not_null_cols:
                if row_copy.get(col.name) is None:
                    cand = generate_unique_value_for_column(col)
                    cand = solve_check_constraint_value(schema, t_name, col.name, col, cand, row_context=row_copy)
                    row_copy[col.name] = cand

            if len(pk_cols) == 1 and "int" in (pk_cols[0].data_type or "").lower():
                pk_c = pk_cols[0]
                pk_v = row_copy.get(pk_c.name)
                if isinstance(pk_v, float):
                    row_copy[pk_c.name] = int(round(pk_v))
                elif not isinstance(pk_v, int):
                    try:
                        row_copy[pk_c.name] = int(float(str(pk_v)))
                    except (ValueError, TypeError):
                        cand = generate_unique_value_for_column(pk_c)
                        row_copy[pk_c.name] = int(cand) if isinstance(cand, (int, float)) else 1

            # 1. Enforce standalone UNIQUE column uniqueness first (including on composite PK columns that have individual UNIQUE constraints)
            for col in standalone_unique_cols:
                val = row_copy.get(col.name)
                if val is not None and _norm_val(val) in seen_unique_per_col[col.name]:
                    new_val = generate_unique_value_for_column(col)
                    new_val = solve_check_constraint_value(schema, t_name, col.name, col, new_val, row_context=row_copy)
                    attempts = 0
                    while _norm_val(new_val) in seen_unique_per_col[col.name] and attempts < 20:
                        attempts += 1
                        new_val = generate_unique_value_for_column(col)
                        new_val = solve_check_constraint_value(schema, t_name, col.name, col, new_val, row_context=row_copy)
                    row_copy[col.name] = new_val
                    val = new_val
                if val is not None:
                    seen_unique_per_col[col.name].add(_norm_val(val))

            # 2. Enforce Primary Key uniqueness (composite or single)
            if pk_cols:
                pk_tuple = tuple(_norm_val(row_copy.get(c.name)) for c in pk_cols)
                if None not in pk_tuple and pk_tuple in seen_pk_tuples:
                    target_pk = next(
                        (c for c in pk_cols if not any(fk.column_name.upper() == c.name.upper() for fk in table.foreign_keys)),
                        pk_cols[0]
                    )
                    new_val = generate_unique_value_for_column(target_pk)
                    new_val = solve_check_constraint_value(schema, t_name, target_pk.name, target_pk, new_val, row_context=row_copy)
                    row_copy[target_pk.name] = new_val
                    pk_tuple = tuple(_norm_val(row_copy.get(c.name)) for c in pk_cols)
                    attempts = 0
                    while pk_tuple in seen_pk_tuples and attempts < 20:
                        attempts += 1
                        new_val = generate_unique_value_for_column(target_pk)
                        new_val = solve_check_constraint_value(schema, t_name, target_pk.name, target_pk, new_val, row_context=row_copy)
                        row_copy[target_pk.name] = new_val
                        pk_tuple = tuple(_norm_val(row_copy.get(c.name)) for c in pk_cols)
                if None not in pk_tuple:
                    seen_pk_tuples.add(pk_tuple)

            # 3. Enforce composite UNIQUE constraints
            for uc in composite_unique_constraints:
                uc_key = tuple(uc)
                uc_tuple = tuple(_norm_val(row_copy.get(c)) for c in uc)
                if None not in uc_tuple and uc_tuple in seen_uc_tuples[uc_key]:
                    target_col_name = next(
                        (c for c in reversed(uc) if not any(fk.column_name.upper() == c.upper() for fk in table.foreign_keys)),
                        uc[-1]
                    )
                    target_col = next((c for c in table.columns if c.name.upper() == target_col_name.upper()), None)
                    if target_col:
                        new_val = generate_unique_value_for_column(target_col)
                        new_val = solve_check_constraint_value(schema, t_name, target_col.name, target_col, new_val, row_context=row_copy)
                        row_copy[target_col.name] = new_val
                        uc_tuple = tuple(_norm_val(row_copy.get(c)) for c in uc)
                        attempts = 0
                        while uc_tuple in seen_uc_tuples[uc_key] and attempts < 20:
                            attempts += 1
                            new_val = generate_unique_value_for_column(target_col)
                            new_val = solve_check_constraint_value(schema, t_name, target_col.name, target_col, new_val, row_context=row_copy)
                            row_copy[target_col.name] = new_val
                            uc_tuple = tuple(_norm_val(row_copy.get(c)) for c in uc)
                if None not in uc_tuple:
                    seen_uc_tuples[uc_key].add(uc_tuple)

            new_rows.append(row_copy)
        fixed_data[t_name] = new_rows
    return fixed_data


def merge_datasets(
    schema: Schema,
    ds1: Dict[str, List[Dict[str, Any]]],
    ds2: Dict[str, List[Dict[str, Any]]],
) -> Dict[str, List[Dict[str, Any]]]:
    """
    Safely merge ``ds2`` into ``ds1`` without violating PK/UNIQUE constraints.

    Rows from ds2 are appended to ds1 only if they do not conflict with
    existing rows on any PK or standalone UNIQUE column. The merged result
    is then passed through ``ensure_dataset_uniqueness`` as a final check.

    Used by attack strategies that generate supplementary datasets and need
    to combine them with the base dataset.
    """
    merged = {t: [dict(r) for r in rows] for t, rows in ds1.items()}
    for t_name, rows in ds2.items():
        if t_name not in schema.tables:
            continue
        if t_name not in merged:
            merged[t_name] = []
        table = schema.tables[t_name]
        pk_cols = [c.name for c in table.columns if c.is_primary_key]
        standalone_unique_cols = [c.name for c in table.columns if c.is_unique and (not c.is_primary_key or len(pk_cols) > 1)]
        for row in rows:
            is_dup = False
            for existing in merged[t_name]:
                if pk_cols:
                    pk_row = tuple(row.get(c) for c in pk_cols)
                    pk_existing = tuple(existing.get(c) for c in pk_cols)
                    if None not in pk_row and pk_row == pk_existing:
                        is_dup = True
                        break
                for uc in standalone_unique_cols:
                    if row.get(uc) is not None and existing.get(uc) == row.get(uc):
                        is_dup = True
                        break
                if is_dup:
                    break
            if not is_dup:
                merged[t_name].append(dict(row))
    return ensure_dataset_uniqueness(schema, merged)


def deduplicate_dataset(
    schema: Schema, data: Dict[str, List[Dict[str, Any]]]
) -> Dict[str, List[Dict[str, Any]]]:
    """
    Deduplicate rows in a dataset based on PK/UNIQUE constraints.

    Convenience alias for ``ensure_dataset_uniqueness``.
    """
    return ensure_dataset_uniqueness(schema, data)


def merge_with_shifted_companion(
    schema: Schema,
    parsed_query: Dict[str, Any],
    base_data: Dict[str, List[Dict[str, Any]]],
    comp_data: Dict[str, List[Dict[str, Any]]],
    preserved_cols: Optional[Set[Tuple[str, str]]] = None,
) -> Dict[str, List[Dict[str, Any]]]:
    """
    Merge `comp_data` into `base_data` while translating numeric self-offset and
    colliding primary/unique key columns in `comp_data` by a constant offset Δ ≥ 100.

    By translation invariance of difference constraints ((x_i + Δ) - (x_j + Δ) = x_i - x_j),
    uniformly shifting numeric key / self-offset columns preserves intra-component offset
    relationships (e.g. `col_2 = col_1 ± c`, `ABS(col_2 - col_1) = c`) while keeping the
    companion rows disjoint from `base_data` on primary keys and preventing cross-component
    matches between `base_data` and `comp_data`.
    """
    preserved_upper = {(t.upper(), c.upper()) for t, c in (preserved_cols or set())}
    self_offset_cols = {
        (pat["table"].upper(), pat["column"].upper())
        for pat in extract_self_offset_patterns(schema, parsed_query)
    }

    shifted_comp = copy.deepcopy(comp_data)
    col_deltas: Dict[Tuple[str, str], int | float] = {}

    for t_name, table_obj in schema.tables.items():
        base_rows = base_data.get(t_name, [])
        comp_rows = shifted_comp.get(t_name, [])
        if not base_rows or not comp_rows:
            continue
        for col in table_obj.columns:
            col_key_up = (t_name.upper(), col.name.upper())
            if col_key_up in preserved_upper or not col.is_numeric:
                continue
            base_vals = [
                r.get(col.name)
                for r in base_rows
                if isinstance(r.get(col.name), (int, float)) and not isinstance(r.get(col.name), bool)
            ]
            comp_vals = [
                r.get(col.name)
                for r in comp_rows
                if isinstance(r.get(col.name), (int, float)) and not isinstance(r.get(col.name), bool)
            ]
            if not base_vals or not comp_vals:
                continue
            has_collision = bool(set(base_vals) & set(comp_vals))
            needs_shift = (col_key_up in self_offset_cols) or (
                (col.is_primary_key or col.is_unique) and has_collision
            )
            if needs_shift:
                min_comp = min(comp_vals)
                max_base = max(base_vals)
                raw_delta = 100 if min_comp + 100 > max_base + 10 else int(max_base - min_comp) + 100
                delta: int | float = (
                    float(raw_delta) if any(isinstance(v, float) for v in comp_vals) else int(raw_delta)
                )
                col_deltas[col_key_up] = delta
                for r in comp_rows:
                    v = r.get(col.name)
                    if isinstance(v, (int, float)) and not isinstance(v, bool):
                        cand = v + delta
                        r[col.name] = solve_check_constraint_value(
                            schema, t_name, col.name, col, cand, row_context=r
                        )

    for t_name, table_obj in schema.tables.items():
        comp_rows = shifted_comp.get(t_name, [])
        if not comp_rows:
            continue
        for fk in table_obj.foreign_keys:
            child_key = (t_name.upper(), fk.column_name.upper())
            parent_tbl = schema.find_table(fk.reference_table) or fk.reference_table
            parent_key = (parent_tbl.upper(), fk.reference_column.upper())
            if child_key not in col_deltas and child_key not in preserved_upper and parent_key in col_deltas:
                delta = col_deltas[parent_key]
                col_deltas[child_key] = delta
                fk_col_obj = schema.find_column(t_name, fk.column_name)
                for r in comp_rows:
                    v = r.get(fk.column_name)
                    if isinstance(v, (int, float)) and not isinstance(v, bool):
                        cand = v + delta
                        r[fk.column_name] = (
                            solve_check_constraint_value(
                                schema, t_name, fk.column_name, fk_col_obj, cand, row_context=r
                            )
                            if fk_col_obj
                            else cand
                        )

    combined: Dict[str, List[Dict[str, Any]]] = {t_name: [] for t_name in schema.tables}
    for t_name in combined:
        if t_name in base_data:
            combined[t_name].extend(copy.deepcopy(base_data[t_name]))
        if t_name in shifted_comp:
            combined[t_name].extend(copy.deepcopy(shifted_comp[t_name]))

    return ensure_dataset_uniqueness(schema, combined)
