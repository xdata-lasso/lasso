"""
Pipeline Orchestrator
======================

The main entry point (``generate_base_dataset``) orchestrates all four
pipeline phases. Results are memoized to avoid redundant generation when
the same (schema, query, injections) combination is requested multiple
times (common during multi-attack runs).

Also contains dataset-level utilities: ``ensure_dataset_uniqueness``,
``merge_datasets``, ``deduplicate_dataset``.
"""

import copy
from functools import wraps
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot.expressions as exp

from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.augmentation import add_unmatched_rows, topological_sort_tables
from dataset_generator.constraints import analyze_constraints_and_cardinality, extract_not_in_roots
from dataset_generator.equivalence import build_equivalence_classes
from dataset_generator.resolver import (
    _step_above,
    _step_below,
    generate_distinct,
    prepare_table_value_lists,
    resolve_values,
)
from dataset_generator.row_assembly import is_duplicate_row, materialize_rows
from dataset_generator.types import ColumnSpec, col_key
from dataset_generator.uniqueness import deduplicate_dataset, ensure_dataset_uniqueness, merge_datasets
from dataset_generator.utils import safe_max, safe_min
from models import Schema


# ════════════════════════════════════════════════════════════════
# Caching (No-op for backward compatibility)
# ════════════════════════════════════════════════════════════════

def clear_dataset_cache() -> None:
    """No-op retained for backward compatibility."""
    pass


def memoize_dataset(func):
    """No-op decorator retained for backward compatibility."""
    @wraps(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper


# ════════════════════════════════════════════════════════════════
# Main entry point
# ════════════════════════════════════════════════════════════════

def generate_base_dataset(
    schema: Schema, parsed_query: Dict[str, Any],
    null_injections: Optional[List[Tuple[str, str]]] = None,
    value_injections: Optional[Dict[Tuple[str, str], Any]] = None,
    omit_aliases: Optional[List[str]] = None,
    cache_key_salt: Optional[str] = None,
    include_limit_padding: bool = True,
) -> Dict[str, List[Dict[str, Any]]]:
    """
    Main entry point: Orchestrate the full 4-phase generation pipeline.

    Phase 0 — Build equivalence classes (union-find from JOINs, FKs, aliases)
    Phase 1 — Collect all constraints into ColumnSpec objects
    Phase 2 — Resolve concrete value lists per equivalence class
    Phase 3 — Assemble row dicts per table from value lists
    Phase 4 — Augment with unmatched parent rows (LEFT JOIN / NOT IN)

    Args:
        schema:          The relational schema with tables, columns, FKs, CHECKs.
        parsed_query:    Dict from the query parser (AST, joins, literals, etc.).
        null_injections: Columns to force NULL (for IS NULL mutation testing).
        value_injections: Columns to force specific values (from attack strategies).
        omit_aliases:    Aliases whose tables should be excluded from generation.
        cache_key_salt:  Extra string to differentiate cache entries.

    Returns:
        Dict mapping schema table name → list of row dicts.
    """

    # ── Phase 0: Equivalence classes ──
    equiv, targets, alias_to_table = build_equivalence_classes(schema, parsed_query, omit_aliases)

    # Order targets topologically so parent tables are processed before child tables
    table_keys = [schema.find_table(t_name) for _, t_name in targets]
    valid_keys = [k for k in table_keys if k]
    if valid_keys:
        topological_order = topological_sort_tables(schema, valid_keys)
        order_map = {k: i for i, k in enumerate(topological_order)}
        targets.sort(key=lambda t: order_map.get(schema.find_table(t[1]), 999))

    omitted_tables: Set[str] = set()
    if omit_aliases:
        included = {alias_to_table[a].upper() for a in alias_to_table if a not in omit_aliases}
        for a in omit_aliases:
            t = alias_to_table.get(a)
            if t and t.upper() not in included:
                omitted_tables.add(t)

    # ── Phase 1: Collect constraints & cardinality ──
    specs, min_row_count = analyze_constraints_and_cardinality(
        schema, parsed_query, equiv, alias_to_table,
        null_injections, value_injections,
        include_limit_padding=include_limit_padding,
    )

    # ── Phase 2 & 3: Resolve value lists + Assemble rows per table ──
    # value_lists is shared across tables so that equivalence classes
    # spanning multiple tables (via JOINs/FKs) get the same values.
    value_lists: Dict[Tuple[str, str], List[Any]] = {}
    dataset: Dict[str, List[Dict[str, Any]]] = {t_name: [] for t_name in schema.tables}

    for alias, table_name in targets:
        if omit_aliases and alias in omit_aliases:
            continue
        table_key = schema.find_table(table_name)
        if not table_key:
            continue
        table = schema.tables[table_key]

        # ── Determine per-table row count ──
        # Most tables get min_row_count rows. However, if min_row_count > 1
        # due to HAVING COUNT, only tables whose columns appear inside
        # COUNT(...) (or are in the same equivalence class) need the extra
        # rows. Other tables can stay at 1 row to keep datasets small.
        table_row_count = min_row_count
        if min_row_count > 1:
            ast = parsed_query.get("ast")
            # Find tables whose columns appear inside COUNT(...)
            count_tables = set()
            if ast:
                for count_node in ast.find_all(exp.Count):
                    cols = list(count_node.find_all(exp.Column))
                    if cols:
                        for c in cols:
                            c_t = (c.table or "").upper()
                            if c_t in alias_to_table:
                                count_tables.add(alias_to_table[c_t])
                            else:
                                for _, t_n in targets:
                                    st = schema.find_table(t_n)
                                    if st and schema.find_column(st, c.name):
                                        count_tables.add(t_n.upper())
                    else:
                        # For COUNT(*), scope to tables in the enclosing SELECT and prefer tables
                        # referenced in other aggregate functions, avoiding adding multiple tables
                        # that join solely via repeated non-unique group keys (which causes N x N inflation).
                        sel_scope = count_node.find_ancestor(exp.Select) or ast
                        scope_table_names = set()
                        if isinstance(sel_scope, exp.Select):
                            for t_node in sel_scope.find_all(exp.Table):
                                if t_node.find_ancestor(exp.Select) is sel_scope:
                                    st_name = schema.find_table(t_node.name)
                                    if st_name:
                                        scope_table_names.add(st_name.upper())
                        if not scope_table_names:
                            scope_table_names = {t_n.upper() for _, t_n in targets}

                        agg_col_tables = set()
                        for agg_node in sel_scope.find_all((exp.Sum, exp.Avg, exp.Min, exp.Max, exp.Count)):
                            for c in agg_node.find_all(exp.Column):
                                c_t = (c.table or "").upper()
                                if c_t in alias_to_table and alias_to_table[c_t].upper() in scope_table_names:
                                    agg_col_tables.add(alias_to_table[c_t].upper())
                                else:
                                    for _, t_n in targets:
                                        if t_n.upper() not in scope_table_names:
                                            continue
                                        st = schema.find_table(t_n)
                                        if st and schema.find_column(st, c.name):
                                            agg_col_tables.add(t_n.upper())
                        if agg_col_tables:
                            count_tables.update(agg_col_tables)
                        else:
                            scope_targets = [(a, t_n) for a, t_n in targets if t_n.upper() in scope_table_names]
                            for t_alias, t_n in scope_targets:
                                st = schema.find_table(t_n)
                                if not st:
                                    continue
                                t_obj = schema.tables[st]
                                t_pk_cols = [col for col in t_obj.columns if col.is_primary_key]
                                shares_only_repeated_group_key = False
                                if count_tables:
                                    shared_roots = []
                                    for c in t_obj.columns:
                                        root = equiv.find(col_key(t_alias, c.name))
                                        for c_tbl in count_tables:
                                            c_st = schema.find_table(c_tbl)
                                            if not c_st:
                                                continue
                                            c_tbl_obj = schema.tables[c_st]
                                            c_tbl_pks = [col for col in c_tbl_obj.columns if col.is_primary_key]
                                            for c2 in c_tbl_obj.columns:
                                                if equiv.find(col_key(c_tbl, c2.name)) == root:
                                                    c_is_unique = c.is_unique or (c.is_primary_key and len(t_pk_cols) == 1)
                                                    c2_is_unique = c2.is_unique or (c2.is_primary_key and len(c_tbl_pks) == 1)
                                                    shared_roots.append((root, c_is_unique or c2_is_unique))
                                    if shared_roots and all(
                                        (specs.get(r) and specs[r].is_group_key and not either_unique)
                                        for r, either_unique in shared_roots
                                    ):
                                        shares_only_repeated_group_key = True
                                if not shares_only_repeated_group_key:
                                    count_tables.add(t_n.upper())
            # Extend to tables joined to count_tables via equivalence classes,
            # excluding joins over non-unique group keys (which repeat a single group value
            # and would otherwise cause Cartesian N x N group inflation).
            extended_tables = set(count_tables)
            for t_alias, t_n in targets:
                st = schema.find_table(t_n)
                if st:
                    t_obj = schema.tables[st]
                    t_pk_cols = [col for col in t_obj.columns if col.is_primary_key]
                    for c in t_obj.columns:
                        root = equiv.find(col_key(t_alias, c.name))
                        spec = specs.get(root)
                        c_is_unique = c.is_unique or (c.is_primary_key and len(t_pk_cols) == 1)
                        if spec and spec.is_group_key and not c_is_unique:
                            continue
                        for c_tbl in count_tables:
                            c_st = schema.find_table(c_tbl)
                            if c_st:
                                for c2 in schema.tables[c_st].columns:
                                    if equiv.find(col_key(c_tbl, c2.name)) == root:
                                        extended_tables.add(t_n.upper())

            # If this table is not related to any COUNT expression, 1 row suffices
            if count_tables and table_name.upper() not in extended_tables:
                table_row_count = 1

        # If any column has multiple required values (e.g. IN (1,2,3)),
        # we need at least that many rows to include all of them.
        for col in table.columns:
            root = equiv.find(col_key(alias, col.name))
            spec = specs.get(root)
            if spec and spec.required and len(spec.required) > 1:
                table_row_count = max(table_row_count, len(spec.required))

        # ── Phase 2: Resolve value lists for this table's columns ──
        # Each equivalence class root gets resolved exactly once. If a root
        # was already resolved by a previous table (shared via JOIN/FK),
        # we extend its value list if the current table needs more rows.
        for col_idx, col in enumerate(table.columns):
            root = equiv.find(col_key(alias, col.name))
            if root not in value_lists:
                # First time seeing this root — resolve from its ColumnSpec
                if root in specs:
                    spec = specs[root]
                else:
                    # No spec was built (column has no query/schema constraints)
                    # → create a minimal spec with just schema metadata
                    spec = ColumnSpec(
                        column=col,
                        data_type=col.data_type,
                        table_name=table_key,
                        must_be_unique=col.is_primary_key or col.is_unique,
                    )
                if spec.col_bounds:
                    for op_str, other_root in spec.col_bounds:
                        if op_str == "NEQ":
                            other_vals = [v for v in value_lists.get(other_root, []) if v is not None]
                            for ov in other_vals:
                                spec.disallowed.add(ov)
                                if ov in spec.required:
                                    spec.required = [rv for rv in spec.required if rv != ov]
                if spec.col_bounds and not spec.required:
                    cand_lower = spec.lower
                    cand_upper = spec.upper
                    for op_str, other_root in spec.col_bounds:
                        other_vals = [v for v in value_lists.get(other_root, []) if v is not None]
                        if not other_vals:
                            continue
                        ref_val = other_vals[0]
                        if op_str == "GTE":
                            cand_lower = safe_max(cand_lower, ref_val) if cand_lower is not None else ref_val
                        elif op_str == "GT":
                            step_v = _step_above(ref_val, spec.data_type, spec.column)
                            cand_lower = safe_max(cand_lower, step_v) if cand_lower is not None else step_v
                        elif op_str == "LTE":
                            cand_upper = safe_min(cand_upper, ref_val) if cand_upper is not None else ref_val
                        elif op_str == "LT":
                            step_v = _step_below(ref_val, spec.data_type, spec.column)
                            cand_upper = safe_min(cand_upper, step_v) if cand_upper is not None else step_v
                    bounds_valid = True
                    if cand_lower is not None and cand_upper is not None:
                        try:
                            bounds_valid = cand_lower <= cand_upper
                        except TypeError:
                            bounds_valid = True
                    if bounds_valid:
                        spec.lower = cand_lower
                        spec.upper = cand_upper
                value_lists[root] = resolve_values(spec, table_row_count, col_idx=col_idx)
            elif len(value_lists[root]) < table_row_count:
                # Root was resolved by a previous table but with fewer values
                # than this table needs — extend the list.
                current = value_lists[root]
                initial_len = len(current)
                spec = specs.get(root)
                while len(current) < table_row_count:
                    if spec and (spec.must_be_unique or (spec.column and (spec.column.is_primary_key or spec.column.is_unique)) or not spec.is_group_key):
                        # Non-group columns (or PK/UNIQUE columns) get distinct extension values
                        current.append(generate_distinct(spec, current, col_idx=col_idx))
                    else:
                        # Group-key columns cycle through existing values
                        current.append(current[len(current) % initial_len])

        # ── Build table-specific value lists ──
        table_value_lists = prepare_table_value_lists(
            table, alias, equiv, specs, value_lists, table_row_count, parsed_query,
            cache_key_salt=cache_key_salt,
        )

        # ── Phase 3: Assemble row dicts for this table ──
        rows = materialize_rows(
            table, alias, equiv, table_value_lists, table_row_count,
            schema, omitted_tables, null_injections, specs,
        )

        # Merge into dataset, deduplicating against rows already present
        # (from a previous alias of the same table, or a prior generation pass)
        unique_cols = [c.name for c in table.columns if c.is_primary_key or c.is_unique]
        for row in rows:
            if not is_duplicate_row(row, dataset[table_key], unique_cols, table=table):
                dataset[table_key].append(row)

    # ── Phase 4: Augment ──
    not_in_roots = extract_not_in_roots(parsed_query, equiv, alias_to_table)
    add_unmatched_rows(dataset, parsed_query, schema, equiv, not_in_roots)

    return ensure_dataset_uniqueness(schema, dataset)


# Re-exported dataset-level utilities (moved to dataset_generator.uniqueness for SRP)
from dataset_generator.uniqueness import (
    _norm_val,
    deduplicate_dataset,
    ensure_dataset_uniqueness,
    merge_datasets,
)

