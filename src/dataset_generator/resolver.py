"""
Phase 2: Value Resolution
===========================

For each ColumnSpec (one per equivalence class), produces a concrete list
of values satisfying all accumulated constraints.

This module is **column-centric**: it operates on one equivalence class at
a time with no awareness of other columns, rows, or tables.  Cross-column
concerns (like CHECK constraints referencing multiple columns) are handled
in Phase 3 (row_assembly).
"""

from datetime import timedelta
import re
from typing import Any, Dict, List, Optional, Set, Tuple

from dateutil.parser import parse as dateutil_parse
import sqlglot.expressions as exp

from dataset_generator.value_generator import (
    DataFactory,
    deterministic_date_from_index,
    generate_unique_value_for_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value, _eval_sqlglot_ast_python
from dataset_generator.constraints import (
    _extract_having_row_count,
    _get_reaggregated_inner_group_cols,
    _is_singleton_having_group,
    get_singleton_having_group_cols,
)
from dataset_generator.types import ColumnSpec, UnionFind, col_key
from models import Column, Schema, Table


def _extract_effective_where_exprs(ast: exp.Expression, table_name: Optional[str] = None) -> List[exp.Expression]:
    """
    Collect WHERE expressions from the top-level Select and any non-union
    derived-table (FROM / JOIN Subquery) or CTE Selects that reference `table_name`.
    """
    exprs: List[exp.Expression] = []
    t_up = table_name.upper() if table_name else None
    if isinstance(ast, exp.Select):
        w = ast.args.get("where")
        if w and w.this:
            exprs.append(w.this)
        for sq in ast.find_all((exp.Subquery, exp.CTE)):
            if isinstance(sq, exp.Subquery) and not isinstance(sq.parent, (exp.From, exp.Join)):
                continue
            if sq.find_ancestor((exp.Union, exp.Intersect, exp.Except)):
                continue
            sub_sel = sq.this if isinstance(sq.this, exp.Select) else sq.find(exp.Select)
            if sub_sel and not isinstance(sq.this, (exp.Union, exp.Intersect, exp.Except)):
                if t_up:
                    sub_tables = {t.name.upper() for t in sub_sel.find_all(exp.Table) if t.name}
                    if sub_tables and t_up not in sub_tables:
                        continue
                sw = sub_sel.args.get("where")
                if sw and sw.this and sw.this not in exprs:
                    exprs.append(sw.this)
    return exprs


def _align_table_value_lists_with_where(
    table: Table,
    alias: str,
    equiv: UnionFind,
    specs: Dict[Tuple[str, str], ColumnSpec],
    table_value_lists: Dict[str, List[Any]],
    table_row_count: int,
    parsed_query: Optional[Dict[str, Any]],
) -> None:
    """
    Align column value lists across multi-column disjunctive/derived-table WHERE
    predicates so that each assembled row satisfies the effective WHERE conjunction
    when a valid pairing exists in the resolved value lists.
    """
    if not parsed_query or not parsed_query.get("ast") or table_row_count <= 1:
        return
    where_exprs = _extract_effective_where_exprs(parsed_query["ast"], table.name)
    if not where_exprs:
        return

    effective_where = where_exprs[0]
    for we in where_exprs[1:]:
        effective_where = exp.And(this=effective_where, expression=we)

    referenced_col_names = {c.name.upper() for c in effective_where.find_all(exp.Column)}
    pred_cols = [
        col.name for col in table.columns
        if col.name.upper() in referenced_col_names
        and len(table_value_lists.get(col.name, [])) > 1
    ]
    if not pred_cols:
        return

    for i in range(table_row_count):
        row_i = {c: vals[i % len(vals)] for c, vals in table_value_lists.items() if vals}
        try:
            res = _eval_sqlglot_ast_python(effective_where, None, "", row_i)
        except Exception:
            res = None
        if res is not False:
            continue

        swapped = False
        for only_multi_req in (True, False):
            for col_c in pred_cols:
                root = equiv.find(col_key(alias, col_c))
                spec = specs.get(root)
                has_multi_seeds = bool(
                    spec and (len(spec.required) > 1 or spec.lower is not None or spec.upper is not None)
                )
                if only_multi_req and not has_multi_seeds:
                    continue
                vals = table_value_lists[col_c]
                for j in range(i + 1, len(vals)):
                    if vals[j] == vals[i % len(vals)]:
                        continue
                    test_row = dict(row_i)
                    test_row[col_c] = vals[j]
                    try:
                        if _eval_sqlglot_ast_python(effective_where, None, "", test_row) is True:
                            idx_i = i % len(vals)
                            vals[idx_i], vals[j] = vals[j], vals[idx_i]
                            swapped = True
                            break
                    except Exception:
                        pass
                if swapped:
                    break
            if swapped:
                break


def _find_null_group_unique_cols(
    table: Table,
    alias: str,
    equiv: UnionFind,
    specs: Dict[Tuple[str, str], ColumnSpec],
    table_row_count: int,
    parsed_query: Optional[Dict[str, Any]],
) -> Set[str]:
    """
    Identify standalone UNIQUE (but SQLite-nullable) GROUP BY columns in a single-table
    SELECT scope that requires group cardinality > 1 (e.g. HAVING COUNT(*) > 1).

    In SQL/SQLite relational semantics, a column with a standalone UNIQUE constraint
    cannot repeat any non-NULL value across rows of the same table. When a single-table
    query groups by such a column and filters for group cardinality >= 2, every non-NULL
    group has size 1 and is filtered out; only the NULL group (since UNIQUE permits
    multiple NULLs while GROUP BY groups NULLs together) can achieve cardinality >= 2.
    """
    if table_row_count <= 1 or not parsed_query or not parsed_query.get("ast"):
        return set()
    if _extract_having_row_count(parsed_query) <= 1:
        return set()

    ast = parsed_query["ast"]
    pk_cols = [c for c in table.columns if c.is_primary_key]
    has_composite_pk = len(pk_cols) > 1

    single_table_group_cols: Set[str] = set()
    for group_node in ast.find_all(exp.Group):
        if _is_singleton_having_group(group_node, ast):
            continue
        select_scope = group_node.find_ancestor(exp.Select)
        if not select_scope:
            continue
        scope_tables = [
            t for t in select_scope.find_all(exp.Table)
            if t.find_ancestor(exp.Select) is select_scope
            and (t.name or "").upper() not in ("DUAL", "")
        ]
        if len(scope_tables) != 1:
            continue
        only_t = scope_tables[0]
        eff_alias = (only_t.alias or only_t.name or "").upper()
        t_name_up = (only_t.name or "").upper()
        if eff_alias != alias.upper() and t_name_up != table.name.upper():
            continue
        for c in group_node.find_all(exp.Column):
            c_tbl = (c.table or "").upper()
            if not c_tbl or c_tbl == eff_alias or c_tbl == t_name_up or c_tbl == alias.upper():
                single_table_group_cols.add(c.name.upper())

    if not single_table_group_cols:
        return set()

    counted_having_cols: Set[str] = set()
    for having_node in ast.find_all(exp.Having):
        for count_node in having_node.find_all(exp.Count):
            for c in count_node.find_all(exp.Column):
                counted_having_cols.add(c.name.upper())

    null_group_cols: Set[str] = set()
    for col in table.columns:
        if col.name.upper() not in single_table_group_cols:
            continue
        if col.name.upper() in counted_having_cols:
            continue
        is_single_pk = col.is_primary_key and not has_composite_pk
        can_be_null = not getattr(col, "explicit_not_null", False) and not is_single_pk
        if not (col.is_unique and can_be_null):
            continue
        root = equiv.find(col_key(alias, col.name))
        spec = specs.get(root)
        if spec:
            if any(v is not None for v in spec.required):
                continue
            if spec.lower is not None or spec.upper is not None:
                continue
            if None in spec.disallowed:
                continue
        null_group_cols.add(col.name)

    if len(table.columns) > 1 and len(null_group_cols) == len(table.columns):
        col_names = [c.name for c in table.columns]
        null_group_cols.remove(col_names[-1])

    return null_group_cols


def prepare_table_value_lists(
    table: Table, alias: str, equiv: UnionFind,
    specs: Dict[Tuple[str, str], ColumnSpec],
    value_lists: Dict[Tuple[str, str], List[Any]],
    table_row_count: int,
    parsed_query: Optional[Dict[str, Any]] = None,
    cache_key_salt: Optional[str] = None,
) -> Dict[str, List[Any]]:
    """
    Format and repeat resolved value lists for a specific table's columns.

    For FK columns in child tables and GROUP BY key columns, all rows within
    this table should reference the SAME parent row / group key (repeating
    the first value for the full row count). PK/UNIQUE columns keep their
    distinct pre-resolved value lists.
    When multiple columns in the same table reference the same parent column
    (e.g. composite foreign keys like Friend(student_id, friend_id)), only the
    group-key / primary join column is repeated; other columns draw distinct
    or offset values from the parent domain so composite PK constraints and
    distinct relationship semantics are preserved.
    """
    table_value_lists: Dict[str, List[Any]] = {}
    pk_cols = [c for c in table.columns if c.is_primary_key]
    has_composite_pk = len(pk_cols) > 1

    repeated_cols: Set[str] = set()
    root_to_cols: Dict[Tuple[str, str], List[str]] = {}
    for col in table.columns:
        root = equiv.find(col_key(alias, col.name))
        root_to_cols.setdefault(root, []).append(col.name)

    # Find columns explicitly in GROUP BY for this alias / table
    explicit_group_cols = set()
    if parsed_query and parsed_query.get("ast") and (parsed_query.get("group_by") or parsed_query.get("has_group_by")):
        reagg_inner = _get_reaggregated_inner_group_cols(parsed_query["ast"])
        singleton_gb = get_singleton_having_group_cols(parsed_query["ast"])
        excluded_gb = reagg_inner | singleton_gb
        for group_node in parsed_query["ast"].find_all(exp.Group):
            if _is_singleton_having_group(group_node, parsed_query["ast"]):
                continue
            for c in group_node.find_all(exp.Column):
                if c.name and c.name.upper() in excluded_gb:
                    continue
                c_tbl = (c.table or "").upper()
                if not c_tbl or c_tbl == alias.upper() or c_tbl == table.name.upper():
                    explicit_group_cols.add(c.name.upper())

    for col in table.columns:
        root = equiv.find(col_key(alias, col.name))
        spec = specs.get(root)
        is_single_pk = col.is_primary_key and not has_composite_pk
        is_table_unique = is_single_pk or col.is_unique
        is_fk = any(fk.column_name.upper() == col.name.upper() for fk in table.foreign_keys)

        if not is_table_unique:
            if spec and spec.is_group_key:
                if len(root_to_cols[root]) > 1:
                    if explicit_group_cols:
                        if col.name.upper() in explicit_group_cols and not any(other.upper() in explicit_group_cols for other in repeated_cols if other in root_to_cols[root]):
                            repeated_cols.add(col.name)
                    else:
                        if col.name == root_to_cols[root][0]:
                            repeated_cols.add(col.name)
                else:
                    repeated_cols.add(col.name)
            elif is_fk and len(root_to_cols[root]) == 1 and not has_composite_pk:
                ref_tables = {
                    fk.reference_table.upper()
                    for fk in table.foreign_keys
                    if fk.column_name.upper() == col.name.upper()
                }
                parent_has_multi_required = (
                    (not parsed_query or _extract_having_row_count(parsed_query) <= 1)
                    and any(
                        len(other_spec.required) > 1
                        and not other_spec.is_group_key
                        and (
                            other_root == root
                            or (other_spec.table_name and other_spec.table_name.upper() in ref_tables)
                            or other_root[0].upper() in ref_tables
                        )
                        for other_root, other_spec in specs.items()
                    )
                )
                if not parent_has_multi_required:
                    repeated_cols.add(col.name)

    if has_composite_pk and not any(c in repeated_cols for c in [pk.name for pk in pk_cols]):
        candidate_fk_pks = [
            pk for pk in pk_cols
            if not pk.is_unique and any(fk.column_name.upper() == pk.name.upper() for fk in table.foreign_keys)
        ]
        if candidate_fk_pks:
            chosen_pk = next(
                (
                    pk for pk in candidate_fk_pks
                    if specs.get(equiv.find(col_key(alias, pk.name)))
                    and specs[equiv.find(col_key(alias, pk.name))].required
                ),
                candidate_fk_pks[0],
            )
            repeated_cols.add(chosen_pk.name)

    if has_composite_pk and len(pk_cols) > 1:
        # Guarantee that not all PK columns are repeated/constant; at least one PK column must vary
        pk_repeated = [pk.name for pk in pk_cols if pk.name in repeated_cols]
        all_pk_constant = table_row_count > 1 and all(
            pk.name in repeated_cols
            or len({str(v) for v in value_lists.get(equiv.find(col_key(alias, pk.name)), [])}) <= 1
            for pk in pk_cols
        )
        if pk_repeated and (len(pk_repeated) == len(pk_cols) or all_pk_constant):
            vary_candidates = (
                [
                    c for c in reversed(pk_repeated)
                    if len({str(v) for v in value_lists.get(equiv.find(col_key(alias, c)), [])}) > 1
                    and c.upper() not in explicit_group_cols
                ]
                or [c for c in reversed(pk_repeated) if c.upper() not in explicit_group_cols]
                or [pk_repeated[-1]]
            )
            repeated_cols.remove(vary_candidates[0])

    for uc_cols in getattr(table, "unique_constraints", []):
        if len(uc_cols) > 1:
            uc_repeated = [c for c in uc_cols if c in repeated_cols]
            if len(uc_repeated) == len(uc_cols):
                to_remove = next((c for c in reversed(uc_repeated) if c.upper() not in explicit_group_cols), uc_repeated[-1])
                repeated_cols.remove(to_remove)

    all_cols_constant = (
        len(repeated_cols) == len(table.columns)
        or (
            table_row_count > 1
            and bool(repeated_cols)
            and all(
                c.name in repeated_cols
                or len({str(v) for v in value_lists.get(equiv.find(col_key(alias, c.name)), [])}) <= 1
                for c in table.columns
            )
        )
    )
    if len(table.columns) > 1 and all_cols_constant:
        # Guarantee that not all columns of a keyless table are constant/repeated;
        # otherwise all generated rows are identical and get deduplicated to 1 row.
        col_names = [c.name for c in table.columns if c.name in repeated_cols]
        to_remove = next(
            (
                c for c in reversed(col_names)
                if c.upper() not in explicit_group_cols
                and not (specs.get(equiv.find(col_key(alias, c))) and specs[equiv.find(col_key(alias, c))].is_group_key)
            ),
            next((c for c in reversed(col_names) if c.upper() not in explicit_group_cols), col_names[-1]) if len(repeated_cols) == len(table.columns) else None,
        )
        if to_remove is not None:
            repeated_cols.remove(to_remove)

    needs_multiple_groups = bool(
        parsed_query
        and not parsed_query.get("has_having")
        and (parsed_query.get("has_offset") or (parsed_query.get("limit_val") or 0) > 1)
    )
    null_group_cols = _find_null_group_unique_cols(
        table, alias, equiv, specs, table_row_count, parsed_query
    )

    for col in table.columns:
        if col.name in null_group_cols:
            table_value_lists[col.name] = [None] * table_row_count
            continue
        root = equiv.find(col_key(alias, col.name))
        vals = value_lists.get(root, [])
        if not vals:
            table_value_lists[col.name] = []
            continue

        if col.name in repeated_cols and not needs_multiple_groups:
            table_value_lists[col.name] = [vals[0]] * table_row_count
        else:
            sibling_repeated = any(other != col.name and other in repeated_cols for other in root_to_cols.get(root, []))
            if sibling_repeated and len(vals) > 1:
                table_value_lists[col.name] = [vals[(i + 1) % len(vals)] for i in range(table_row_count)]
            else:
                table_value_lists[col.name] = list(vals)

    if not (cache_key_salt and (cache_key_salt.startswith("violating_") or cache_key_salt.startswith("subq_viol_"))):
        _align_table_value_lists_with_where(
            table, alias, equiv, specs, table_value_lists, table_row_count, parsed_query
        )

    return table_value_lists


def resolve_values(spec: ColumnSpec, count: int, col_idx: int = 0) -> List[Any]:
    """
    Phase 2 core: Produce exactly ``count`` values satisfying all constraints
    in a ColumnSpec.

    This is THE single value-generation function. Every SQL feature ultimately
    flows through here — there are no feature-specific value generators
    scattered elsewhere.

    Algorithm:
      Step 1 — Seed selection (via ``_resolve_seeds``):
        Priority order:
          1. force_null       → [None] * count  (short-circuit)
          2. required values  → use them directly
          3. range bounds     → pick a satisfying value
          4. disallowed set   → pick a value not in the set
          5. no constraints   → generate a type-appropriate default

      Step 2 — CHECK constraint application:
        Apply single-column CHECK constraints to each seed value.

      Step 3 — Padding (if len(seeds) < count):
        Strategy depends on ColumnSpec flags:
          - must_be_unique   → generate distinct values
          - is_group_key     → repeat first value (to form groups)
          - required exists  → cycle through required values
          - range exists     → step within bounds
          - else             → generate distinct values

      Step 4 — Uniqueness enforcement:
        If must_be_unique, deduplicate and re-pad.

    Args:
        spec:    ColumnSpec with all constraints for this equivalence class.
        count:   Number of values to produce.
        col_idx: Column index within the table (used as salt for distinct generation).

    Returns:
        A list of exactly ``count`` values.
    """
    if spec.force_null:
        return [None] * count

    # Step 1: Determine seed values
    seeds = _resolve_seeds(spec)

    # Step 2: Apply single-column CHECK constraints to seeds
    seeds = [_apply_single_column_checks(v, spec) for v in seeds]

    # Step 3: Pad to `count`
    values = list(seeds)
    while len(values) < count:
        if spec.must_be_unique:
            values.append(generate_distinct(spec, values, col_idx=col_idx))
        elif spec.required:
            values.append(spec.required[len(values) % len(spec.required)])
        elif spec.lower is not None or spec.upper is not None:
            values.append(_step_within_bounds(spec, values))
        elif spec.is_group_key:
            values.append(values[0])
        else:
            # Unconstrained or non-group key: distinct to differentiate rows and vary aggregate/join expressions
            values.append(generate_distinct(spec, values, col_idx=col_idx))

    # Step 4: Enforce uniqueness for PK/UNIQUE columns
    if spec.must_be_unique:
        values = _ensure_unique(values, spec, count, col_idx=col_idx)

    if spec.is_avg_subquery_col and len(values) >= 3 and not spec.must_be_unique and not spec.is_group_key:
        if all(isinstance(v, (int, float)) for v in values):
            center = values[1]
            step = 2.0 if any(isinstance(v, float) for v in values) else 2
            if spec.lower is not None and center - step < spec.lower:
                step = (center - spec.lower) / 2 if isinstance(center, float) else max(1, (center - spec.lower) // 2)
                center = spec.lower + 2 * step
            if spec.upper is not None and center + step > spec.upper:
                step = (spec.upper - center) / 2 if isinstance(center, float) else max(1, (spec.upper - center) // 2)
                center = spec.upper - 2 * step
            values[0] = center - step
            values[1] = center
            values[2] = center + step
    elif spec.is_avg_subquery_col and len(values) > 1 and not spec.must_be_unique and not spec.is_group_key:
        if all(isinstance(v, (int, float)) for v in values):
            idx = 1 if len(values) > 1 else 0
            max_other = max(values[i] for i in range(len(values)) if i != idx)
            values[idx] = max_other + 10

    return values[:count]


# ════════════════════════════════════════════════════════════════
# Seed selection
# ════════════════════════════════════════════════════════════════

def _val_in_bounds(v: Any, lower: Any, upper: Any) -> bool:
    """Check if `v` satisfies [lower, upper] bounds."""
    try:
        if lower is not None and v < lower:
            return False
        if upper is not None and v > upper:
            return False
        return True
    except TypeError:
        return True


def _resolve_seeds(spec: ColumnSpec) -> List[Any]:
    """
    Pick initial seed value(s) from the ColumnSpec constraints.

    Priority:
      1. spec.required  → return them directly (plus bound seed if disjoint bounds exist)
      2. Both bounds    → pick midpoint
      3. Lower only     → step above lower
      4. Upper only     → step below upper
      5. Disallowed set → generate value avoiding the set
      6. No constraints → generate a fresh type-appropriate value

    Always returns at least 1 value.
    """
    if spec.required:
        seeds = list(spec.required)
        if (spec.lower is not None or spec.upper is not None) and spec.is_valid_range():
            if not any(_val_in_bounds(v, spec.lower, spec.upper) for v in seeds if v is not None):
                if spec.lower is not None and spec.upper is not None:
                    bound_seed = _pick_in_range(spec.lower, spec.upper, spec.data_type, spec.column, spec.is_temporal)
                elif spec.lower is not None:
                    bound_seed = _step_above(spec.lower, spec.data_type, spec.column, spec.is_temporal)
                else:
                    bound_seed = _step_below(spec.upper, spec.data_type, spec.column, spec.is_temporal)
                if bound_seed not in seeds:
                    seeds.append(bound_seed)
        return seeds

    if spec.lower is not None and spec.upper is not None:
        return [_pick_in_range(spec.lower, spec.upper, spec.data_type, spec.column, spec.is_temporal)]

    if spec.lower is not None:
        return [_step_above(spec.lower, spec.data_type, spec.column, spec.is_temporal)]

    if spec.upper is not None:
        return [_step_below(spec.upper, spec.data_type, spec.column, spec.is_temporal)]

    if spec.disallowed:
        if spec.is_temporal and not (spec.column and spec.column.is_temporal):
            candidate = deterministic_date_from_index(DataFactory.get_instance().increment_date())
            attempts = 0
            while candidate in spec.disallowed and attempts < 50:
                candidate = _step_above(candidate, spec.data_type, spec.column, is_temporal=True)
                attempts += 1
            return [candidate]
        candidate = generate_unique_value_for_column(spec.column) if spec.column else "default"
        if spec.column and spec.table_name:
            candidate = solve_check_constraint_value(
                Schema(tables={}),
                spec.table_name, spec.column.name, spec.column,
                candidate, disallowed_values=spec.disallowed,
            )
        else:
            while candidate in spec.disallowed:
                candidate = str(candidate) + "_new"
        return [candidate]

    # No constraints: generate fresh value
    if spec.is_temporal and not (spec.column and spec.column.is_temporal):
        return [deterministic_date_from_index(DataFactory.get_instance().increment_date())]
    return [generate_unique_value_for_column(spec.column, override_limit=spec.char_limit) if spec.column
            else 1]


# ════════════════════════════════════════════════════════════════
# Bound helpers
# ════════════════════════════════════════════════════════════════

_ISO_DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}(?:[ T]\d{2}:\d{2}(?::\d{2})?)?$")


def _is_iso_date_str(val: Any) -> bool:
    return isinstance(val, str) and bool(_ISO_DATE_RE.match(val.strip()))


def _is_temporal_context(
    val: Any, data_type: str, column: Optional[Column], is_temporal: bool = False
) -> bool:
    if is_temporal or (column and column.is_temporal):
        return True
    if any(t in str(data_type).lower() for t in ("date", "time", "timestamp")):
        return True
    return _is_iso_date_str(val)


def _pick_in_range(
    lower: Any, upper: Any, data_type: str, column: Optional[Column] = None, is_temporal: bool = False
) -> Any:
    """Pick a value between lower and upper bounds."""
    if isinstance(lower, (int, float)) and isinstance(upper, (int, float)):
        val = (lower + upper) / 2
        if isinstance(lower, int) and isinstance(upper, int):
            val = int(val)
        return val

    if _is_temporal_context(lower, data_type, column, is_temporal) or _is_temporal_context(upper, data_type, column, is_temporal):
        try:
            d_low = dateutil_parse(str(lower))
            d_up = dateutil_parse(str(upper))
            if d_low < d_up:
                mid = d_low + (d_up - d_low) // 2
                if mid == d_low:
                    mid = d_low + timedelta(days=1)
                fmt = "%Y-%m-%d" if ":" not in str(lower) and ":" not in str(upper) else "%Y-%m-%d %H:%M:%S"
                return mid.strftime(fmt)
            return str(lower)
        except Exception:
            pass

    s_low = str(lower)
    s_up = str(upper)
    if s_low.lstrip('-').replace('.', '', 1).isdigit() and s_up.lstrip('-').replace('.', '', 1).isdigit():
        try:
            n_low = float(s_low)
            n_up = float(s_up)
            mid = (n_low + n_up) / 2
            if n_low.is_integer() and n_up.is_integer():
                return int(mid)
            return mid
        except Exception:
            pass

    return lower


def _step_above(
    lower: Any, data_type: str, column: Optional[Column], is_temporal: bool = False
) -> Any:
    """
    Generate a value strictly above ``lower``.

    Handles numeric (+1), temporal (+1 day), numeric-looking strings (+20),
    and text (generate a unique string).
    """
    if isinstance(lower, (int, float)):
        return lower + 1.0 if isinstance(lower, float) else lower + 1
    if _is_temporal_context(lower, data_type, column, is_temporal):
        try:
            dt = dateutil_parse(str(lower))
            return (dt + timedelta(days=1)).strftime("%Y-%m-%d")
        except Exception:
            return str(lower) + "1"
    s = str(lower)
    if s.lstrip('-').replace('.', '', 1).isdigit():
        f_val = float(s)
        num = f_val + 20
        res = int(num) if f_val.is_integer() else num
        if str(res) <= s and f_val > 0:
            if f_val.is_integer():
                n = int(f_val)
                res = n * 10 + 1
                dt_str = (data_type or (column.data_type if column else "")).lower()
                m = re.search(r'(?:(?:var)?char|character\s+varying)\s*\((\d+)\)', dt_str)
                limit = int(m.group(1)) if m else None
                if limit is not None and len(str(res)) > limit and str(n + 1) > s and len(str(n + 1)) <= limit:
                    res = n + 1
            elif '.' in s:
                int_part, dec_part = s.split('.', 1)
                if int_part.isdigit() and int(int_part) > 0:
                    res = float(f"{int(int_part) * 10 + 1}.{dec_part}")
        return res
    return generate_unique_value_for_column(column) if column else s + "_"


def _step_below(
    upper: Any, data_type: str, column: Optional[Column], is_temporal: bool = False
) -> Any:
    """
    Generate a value strictly below ``upper``.

    Handles numeric (-1), temporal (-1 day), numeric-looking strings (-10),
    and text (generate a unique string or truncate).
    """
    if isinstance(upper, (int, float)):
        return upper - 1.0 if isinstance(upper, float) else upper - 1
    if _is_temporal_context(upper, data_type, column, is_temporal):
        try:
            dt = dateutil_parse(str(upper))
            return (dt - timedelta(days=1)).strftime("%Y-%m-%d")
        except Exception:
            return str(upper)
    s = str(upper)
    if s.lstrip('-').replace('.', '', 1).isdigit():
        f_val = float(s)
        num = f_val - 10
        res = int(num) if f_val.is_integer() else num
        if str(res) >= s and f_val > 0:
            cand = int(f_val) - 1 if f_val.is_integer() else f_val - 1.0
            if str(cand) < s:
                res = cand
            else:
                res = 0 if f_val.is_integer() else 0.0
        return res
    return generate_unique_value_for_column(column) if column else (s[:-1] if len(s) > 1 else s + "x")


def _step_within_bounds(spec: ColumnSpec, values: List[Any]) -> Any:
    """
    Generate a next value by incrementing the last value in ``values``,
    staying within spec.lower / spec.upper bounds.

    For numeric types, increments by 1 (or decrements by 1 when only an
    upper bound is present). For temporal types, increments by one day.
    Wraps around to values[0] if the upper bound is exceeded.
    """
    last_val = values[-1]
    if isinstance(last_val, (int, float)):
        if spec.lower is None and spec.upper is not None:
            return last_val - 1.0 if isinstance(last_val, float) else last_val - 1
        next_val = last_val + 1.0 if isinstance(last_val, float) else last_val + 1
        if spec.upper is not None and isinstance(spec.upper, (int, float)) and next_val > spec.upper:
            return values[0]
        return next_val
    if _is_temporal_context(last_val, spec.data_type, spec.column, spec.is_temporal):
        try:
            dt = dateutil_parse(str(last_val))
            next_dt = (dt + timedelta(days=1)).strftime("%Y-%m-%d")
            if spec.upper is not None and str(next_dt) > str(spec.upper):
                return values[0]
            return next_dt
        except Exception:
            return values[0]
    return values[0]


# ════════════════════════════════════════════════════════════════
# CHECK constraint helpers
# ════════════════════════════════════════════════════════════════

def _apply_single_column_checks(val: Any, spec: ColumnSpec) -> Any:
    """
    Apply CHECK constraints that reference only this single column.

    Unlike cross-column CHECK repair (done in Phase 3 with row context),
    single-column checks can be applied immediately during value resolution.
    Currently a no-op placeholder; complex single-column CHECKs are handled
    by solve_check_constraint_value in Phase 3.
    """
    if not spec.check_exprs or val is None:
        return val
    return val


# ════════════════════════════════════════════════════════════════
# Distinct value generation and uniqueness enforcement
# ════════════════════════════════════════════════════════════════

def generate_distinct(spec: ColumnSpec, existing: List[Any], col_idx: int = 0) -> Any:
    """
    Generate a value distinct from all values in ``existing``.

    For numeric non-PK/non-unique columns, adds a deterministic offset based
    on the row index and column index to ensure distinction both within a
    column and across columns of the same table.

    Note: This function is public (not prefixed with _) because it is also
    used by row_assembly.py (Phase 4) for generating unmatched row values.
    """
    if not spec.column:
        base = max((v for v in existing if isinstance(v, (int, float))), default=0)
        return int(base) + 1 if isinstance(base, int) else base + 1.0

    is_temp = bool(
        spec.is_temporal
        or spec.column.is_temporal
        or (existing and _is_iso_date_str(existing[-1]))
    )
    if is_temp:
        val = (
            generate_unique_value_for_column(spec.column, override_limit=spec.char_limit)
            if spec.column.is_temporal
            else deterministic_date_from_index(DataFactory.get_instance().increment_date())
        )
        if existing:
            cand = existing[-1] if existing[-1] is not None else val
            attempts = 0
            while (cand in existing or (spec.disallowed and cand in spec.disallowed)) and attempts < 50:
                cand = _step_above(cand, spec.data_type, spec.column, is_temporal=True)
                attempts += 1
            val = cand
        return val

    val = generate_unique_value_for_column(spec.column, override_limit=spec.char_limit)

    # For numeric non-PK/non-unique columns, add offset to ensure distinction across rows and columns
    if (isinstance(val, (int, float)) and not isinstance(val, bool)
            and not spec.must_be_unique):
        idx = len(existing)
        val = val + idx * (col_idx + 1) * 2.0

    return val


def _ensure_unique(values: List[Any], spec: ColumnSpec, count: int, col_idx: int = 0) -> List[Any]:
    """
    Deduplicate ``values`` and pad back to ``count`` with distinct values.

    Used as a final pass for PK/UNIQUE columns to guarantee the uniqueness
    invariant even if earlier steps introduced duplicates.
    """
    seen = set()
    deduped = []
    for v in values:
        hashable_v = v if not isinstance(v, list) else tuple(v)
        if hashable_v not in seen:
            seen.add(hashable_v)
            deduped.append(v)
    while len(deduped) < count:
        deduped.append(generate_distinct(spec, deduped, col_idx=col_idx))
    return deduped[:count]
