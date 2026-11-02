"""
Phase 1: Constraint Collection
================================

Walks the parsed query AST and schema DDL to populate ColumnSpec objects
— one per equivalence class — with all relevant constraints.

This module is responsible ONLY for gathering constraints. It does not
produce concrete values (Phase 2) or build rows (Phase 3).

Sub-steps:
  1. Schema constraints — PK, UNIQUE, CHECK, VARCHAR limits, data types
  2. Query predicates   — WHERE/HAVING literals (EQ, IN, range, LIKE, NEQ)
  2b. Complex predicates — Arithmetic expressions solved via Z3
  3. Query structure     — GROUP BY marking, COUNT(DISTINCT) marking
  4. Row count           — HAVING COUNT, subquery inequalities, LIMIT/OFFSET
  5. Parameter overrides — Externally injected values (from attack strategies)
"""

import logging
import re
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot
import sqlglot.expressions as exp

from dataset_generator.constraint_solver import (
    get_check_constraints_for_column,
)
from dataset_generator.value_generator import (
    coerce_literal_for_column,
    synthesize_string_of_length,
    value_matching_like_pattern,
)
from dataset_generator.utils import safe_max, safe_min

from dataset_generator.types import ColumnSpec, UnionFind, col_key
from dataset_generator.utils import (
    compute_additive_sum_values,
    compute_ratio_comparison_values,
    compute_self_offset_values,
    compute_temporal_diff_values,
    extract_additive_sum_patterns,
    extract_ratio_comparison_patterns,
    extract_self_offset_patterns,
    extract_temporal_diff_patterns,
    find_column_equivalence_roots,
    next_distinct_value,
)
from models import Schema
from parser import _extract_length_meta, _extract_substring_meta, _extract_temporal_meta
from z3_solver import solve_query_constraints

logger = logging.getLogger(__name__)


# ════════════════════════════════════════════════════════════════
# Helpers: Literal parsing and coercion
# ════════════════════════════════════════════════════════════════

def _parse_char_limit(data_type: str) -> Optional[int]:
    """Extract VARCHAR(N) / CHAR(N) limit from a data type string."""
    match = re.search(r'(?:(?:var)?char|character\s+varying)\s*\((\d+)\)', data_type.lower())
    return int(match.group(1)) if match else None


def _resolve_target_lengths(
    length_lits: List[dict],
) -> Tuple[List[int], Optional[int], Optional[int], Set[int]]:
    """
    Resolve effective character-length bounds `(target_lengths, min_len, max_len, disallowed_lens)`
    for a column from predicates over `LENGTH(col)` / `CHAR_LENGTH(col)` / `LENGTH(SUBSTRING(col, start))`.
    """
    req_lens: List[int] = []
    min_len: Optional[int] = None
    max_len: Optional[int] = None
    disallowed_lens: Set[int] = set()

    for lit in length_lits:
        raw_val = lit.get("value")
        if raw_val in (None, "NULL"):
            continue
        try:
            raw_n = int(float(raw_val))
        except (ValueError, TypeError):
            continue
        offset = int(lit.get("length_offset") or 0)
        op = (lit.get("operator") or "EQ").upper()

        if op in ("EQ", "IN"):
            if raw_n <= 0 and offset > 0:
                max_len = min(max_len, offset) if max_len is not None else offset
            else:
                eff = max(0, raw_n + offset)
                if eff not in req_lens:
                    req_lens.append(eff)
        elif op == "GT":
            expr_min = max(0, raw_n + 1)
            eff = 0 if expr_min == 0 else (expr_min + offset)
            min_len = max(min_len, eff) if min_len is not None else eff
        elif op in ("GTE", "BETWEENLOWER"):
            expr_min = max(0, raw_n)
            eff = 0 if expr_min == 0 else (expr_min + offset)
            min_len = max(min_len, eff) if min_len is not None else eff
        elif op == "LT":
            expr_max = max(0, raw_n - 1)
            eff = 0 if (raw_n - 1 <= 0 and offset == 0) else max(0, expr_max + offset)
            max_len = min(max_len, eff) if max_len is not None else eff
        elif op in ("LTE", "BETWEENUPPER"):
            expr_max = max(0, raw_n)
            eff = 0 if (raw_n <= 0 and offset == 0) else max(0, expr_max + offset)
            max_len = min(max_len, eff) if max_len is not None else eff
        elif op in ("NEQ", "NOT IN"):
            if raw_n <= 0 and offset > 0:
                eff_min = 1 + offset
                min_len = max(min_len, eff_min) if min_len is not None else eff_min
            else:
                disallowed_lens.add(max(0, raw_n + offset))

    if req_lens:
        targets = list(req_lens)
    elif min_len is not None and max_len is not None:
        cand = max(1, min_len) if (max_len >= 1 and min_len == 0) else min_len
        if cand in disallowed_lens:
            for t in range(min_len, max_len + 1):
                if t not in disallowed_lens:
                    cand = t
                    break
        targets = [cand]
    elif min_len is not None:
        cand = max(1, min_len)
        while cand in disallowed_lens:
            cand += 1
        targets = [cand]
    elif max_len is not None:
        cand = min(max_len, 5) if max_len >= 1 else 0
        while cand in disallowed_lens and cand > 0:
            cand -= 1
        targets = [cand]
    else:
        cand = 5
        while cand in disallowed_lens:
            cand += 1
        targets = [cand]

    return targets, min_len, max_len, disallowed_lens


def _apply_literal_to_spec(spec: ColumnSpec, literal: dict) -> None:
    """
    Apply a single WHERE/HAVING predicate literal to a ColumnSpec.

    Dispatches on the operator type to update the appropriate ColumnSpec field:
      EQ / IN       → spec.required   (values that must appear)
      GT / GTE      → spec.lower      (lower bound)
      LT / LTE      → spec.upper      (upper bound)
      NEQ / NOT IN  → spec.disallowed  (values to avoid)
      LIKE / ILIKE  → spec.required    (a value matching the pattern)
      IS NULL       → spec.required    (None)
      IS NOT NULL   → spec.disallowed  (None)

    Args:
        spec:    The ColumnSpec to update.
        literal: A dict with keys 'value', 'operator', and optionally 'table'/'column'.
    """
    val = literal["value"]
    op = literal.get("operator", "EQ").upper()

    # NULL handling
    if val == "NULL":
        if op in ("IS", "EQ", "IS NULL"):
            spec.required.append(None)
        elif op in ("IS NOT", "NEQ", "NOT EQ", "IS NOT NULL"):
            spec.disallowed.add(None)
        return

    if literal.get("is_length_expr"):
        targets, _, _, _ = _resolve_target_lengths([literal])
        for t_len in targets:
            syn_val = synthesize_string_of_length(spec.column, t_len, override_limit=spec.char_limit)
            if syn_val not in spec.required:
                spec.required.append(syn_val)
        return

    # Type coercion
    column = spec.column
    fmt = literal.get("strftime_format")
    is_temporal = bool(
        spec.is_temporal
        or (column and column.is_temporal)
        or literal.get("is_temporal_expr")
        or fmt
    )
    if is_temporal:
        spec.is_temporal = True
    if column:
        val = coerce_literal_for_column(column, val)
        if is_temporal:
            val = _coerce_temporal(val, op, fmt)
    else:
        if is_temporal:
            val = _coerce_temporal(val, op, fmt)
        elif isinstance(val, str) and val.lstrip('-').replace('.', '', 1).isdigit():
            val = float(val) if '.' in val else int(val)

    # Operator dispatch
    if op in ("LIKE", "ILIKE"):
        matched_val = (
            value_matching_like_pattern(column, str(val))
            if column
            else str(val).replace('%', '').replace('_', '')
        )
        if matched_val not in spec.required:
            spec.required.append(matched_val)
    elif op in ("EQ", "IN"):
        if val not in spec.required:
            spec.required.append(val)
    elif op in ("GT", "GTE", "BETWEENLOWER"):
        spec.lower = safe_max(spec.lower, val) if spec.lower is not None else val
    elif op in ("LT", "LTE", "BETWEENUPPER"):
        spec.upper = safe_min(spec.upper, val) if spec.upper is not None else val
    elif op in ("NEQ", "NOT IN"):
        spec.disallowed.add(val)
    elif op in ("NOT LIKE", "NOT ILIKE"):
        if column:
            spec.disallowed.add(value_matching_like_pattern(column, str(val)))
        spec.disallowed.add(str(val))


def _coerce_temporal(val: Any, op: str, fmt: Optional[str] = None) -> Any:
    """
    Coerce temporal literal values to valid date strings.

    Handles edge cases where the literal is a bare time ("12:30"), a year
    integer (2020), a month integer (1–12), a STRFTIME format extraction,
    or the keyword "NOW". For inequality operators (GT/LT), the value is
    shifted to ensure strict satisfaction of the bound.
    """
    if fmt == "%Y":
        s_val = str(val).strip()
        if s_val.lstrip("-").isdigit():
            y = int(s_val)
            if op == "GT":
                y += 1
            elif op == "LT":
                y -= 1
            if op in ("LTE", "BETWEENUPPER"):
                return f"{y:04d}-12-31"
            return f"{y:04d}-01-01"
    elif fmt == "%m":
        s_val = str(val).strip()
        if s_val.isdigit() and 1 <= int(s_val) <= 12:
            m = int(s_val)
            if op == "GT" and m < 12:
                m += 1
            elif op == "LT" and m > 1:
                m -= 1
            if op in ("LTE", "BETWEENUPPER"):
                return f"2023-{m:02d}-28"
            return f"2023-{m:02d}-01"
    elif fmt == "%d":
        s_val = str(val).strip()
        if s_val.isdigit() and 1 <= int(s_val) <= 31:
            d = int(s_val)
            if op == "GT" and d < 28:
                d += 1
            elif op == "LT" and d > 1:
                d -= 1
            return f"2023-01-{min(d, 28):02d}"
    elif fmt == "%Y-%m" and isinstance(val, str) and re.match(r"^\d{4}-\d{2}$", val.strip()):
        parts = val.strip().split("-")
        y, m = int(parts[0]), int(parts[1])
        if 1 <= m <= 12:
            if op == "GT":
                m += 1
                if m > 12:
                    y += 1
                    m = 1
            elif op == "LT":
                m -= 1
                if m < 1:
                    y -= 1
                    m = 12
            if op in ("LTE", "BETWEENUPPER"):
                return f"{y:04d}-{m:02d}-28"
            return f"{y:04d}-{m:02d}-01"

    if isinstance(val, str) and ":" in val and "-" not in val:
        if op in ("LT", "LTE"):
            return "0000-01-01"
        elif op in ("GT", "GTE"):
            return "9999-12-31"
    elif isinstance(val, str) and val.lower() == "now":
        if op in ("LT", "LTE"):
            return "0999-01-01"
        elif op in ("GT", "GTE"):
            return "2030-01-01"
        else:
            return "2020-01-01"
    elif isinstance(val, (int, float)) and float(val).is_integer() and len(str(abs(int(val)))) == 4:
        y = int(val)
        if op == "GT": y += 1
        elif op == "LT": y -= 1
        return f"{y:04d}-01-01"
    elif isinstance(val, str) and len(val) == 4 and val.isdigit():
        y = int(val)
        if op == "GT": y += 1
        elif op == "LT": y -= 1
        return f"{y:04d}-01-01"
    elif isinstance(val, (int, str)) and str(val).isdigit() and 1 <= int(val) <= 12:
        return f"2023-{int(val):02d}-01"
    return val


def _resolve_literal_root(
    literal: dict, equiv: UnionFind, alias_to_table: Dict[str, str], schema: Schema
) -> Tuple[str, str]:
    """
    Map a WHERE/HAVING literal to its equivalence class root.

    If the literal has no explicit table qualifier, searches the enclosing
    SELECT's immediate table sources first (lexical scope), then falls back
    to all known aliases/tables in the schema to find which table owns the column.
    Returns the union-find root for the resolved (alias, column) pair.
    """
    alias = literal["table"]
    col = literal["column"]
    if not alias:
        for scope_alias in literal.get("scope_tables") or []:
            t_name = alias_to_table.get(scope_alias.upper(), scope_alias)
            st = schema.find_table(t_name)
            if st and schema.find_column(st, col):
                alias = scope_alias
                break
    if not alias:
        for a, t_name in alias_to_table.items():
            st = schema.find_table(t_name)
            if st and schema.find_column(st, col):
                alias = a
                break
        if not alias:
            for t_name in schema.tables:
                if schema.find_column(t_name, col):
                    alias = t_name
                    break
    return equiv.find(col_key(alias, col))


# ════════════════════════════════════════════════════════════════
# Helpers: Metadata filling and subquery marking
# ════════════════════════════════════════════════════════════════

def _fill_column_metadata(
    spec: ColumnSpec, root: Tuple[str, str],
    equiv: UnionFind, alias_to_table: Dict[str, str], schema: Schema
) -> None:
    """
    Fill column/type metadata for a ColumnSpec that was created from a query
    predicate (which provides a value but not necessarily the Column object).

    Searches alias_to_table entries whose alias or table name matches the
    root's table component, then looks up the column in the schema.
    """
    _, col_upper = root
    for a, t_name in alias_to_table.items():
        if a.upper() == root[0] or t_name.upper() == root[0]:
            st = schema.find_table(t_name)
            if st:
                col = schema.find_column(st, col_upper)
                if col:
                    spec.column = col
                    spec.data_type = col.data_type
                    spec.is_temporal = spec.is_temporal or col.is_temporal
                    spec.table_name = st
                    return


def _mark_subquery_specs(
    specs: Dict[Tuple[str, str], ColumnSpec], parsed_query: Dict[str, Any],
    equiv: UnionFind, alias_to_table: Dict[str, str], schema: Schema
) -> None:
    """
    Mark specs whose constraints originate from subquery predicates.

    Two cases:
      1. WHERE literals flagged with ``is_subquery=True`` by the parser.
      2. Comparison operators (>, <, >=, <=, !=) where one operand is a
         subquery containing AVG — marks the outer column as is_avg_subquery_col
         so that value resolution can produce spread-out values.
    """
    root_literals: Dict[Tuple[str, str], List[dict]] = {}
    for literal in parsed_query.get("where_literals", []):
        root = _resolve_literal_root(literal, equiv, alias_to_table, schema)
        root_literals.setdefault(root, []).append(literal)

    for root, lits in root_literals.items():
        if any(lit.get("is_subquery") for lit in lits):
            if root in specs:
                specs[root].is_subquery = True

    ast = parsed_query.get("ast")
    if ast:
        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)):
            left = comp.left
            right = comp.right
            subq_in_right = right if isinstance(right, exp.Subquery) else (right.find(exp.Subquery) if right else None)
            subq_in_left = left if isinstance(left, exp.Subquery) else (left.find(exp.Subquery) if left else None)
            subq = subq_in_right or subq_in_left
            other = left if subq_in_right else right
            if subq and subq.find(exp.Avg):
                cols = list(other.find_all(exp.Column))
                if cols:
                    first_col = cols[0]
                    t_alias = first_col.table
                    c_name = first_col.name
                    tables_to_check = [t_alias] if t_alias else list(alias_to_table.keys())
                    for t in tables_to_check:
                        root = equiv.find(col_key(t, c_name))
                        spec = specs.setdefault(root, ColumnSpec())
                        if spec.column is None:
                            _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                        spec.is_avg_subquery_col = True

            # If outer comparison involves a subquery aggregate (MAX, MIN, AVG, etc.)
            # on the same table, ensure filtered columns in subquery have an alternative
            # value so outer rows are not all forced into the subquery's partition
            if subq and subq.find((exp.Max, exp.Min, exp.Avg, exp.Sum, exp.Count)):
                subq_tables = {t.name.upper() for t in subq.find_all(exp.Table)}
                outer_tables = {t.name.upper() for t in ast.find_all(exp.Table) if t.find_ancestor(exp.Subquery) is None}
                common_tables = subq_tables.intersection(outer_tables)
                if common_tables:
                    for w in subq.find_all(exp.Where):
                        for eq in w.find_all(exp.EQ):
                            c_node = eq.left if isinstance(eq.left, exp.Column) else (eq.right if isinstance(eq.right, exp.Column) else None)
                            lit_node = eq.right if c_node is eq.left else eq.left
                            if c_node and isinstance(lit_node, exp.Literal):
                                c_t = (c_node.table or "").upper()
                                tables_to_check = [c_t] if c_t in alias_to_table else list(alias_to_table.keys())
                                for t in tables_to_check:
                                    t_name = alias_to_table.get(t, t).upper()
                                    if t_name in common_tables:
                                        root = equiv.find(col_key(t, c_node.name))
                                        spec = specs.setdefault(root, ColumnSpec())
                                        if spec.column is None:
                                            _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                                        if spec.column and len(spec.required) <= 1:
                                            curr_req = spec.required[0] if spec.required else lit_node.name
                                            alt_val = next_distinct_value(spec.column, curr_req, schema=schema, table_name=t_name)
                                            if alt_val not in spec.required:
                                                spec.required.append(alt_val)

                    # Also mark the compared column so value resolution spreads its values
                    outer_cols = list(other.find_all(exp.Column))
                    if outer_cols:
                        first_col = outer_cols[0]
                        c_t = (first_col.table or "").upper()
                        tables_to_check = [c_t] if c_t in alias_to_table else list(alias_to_table.keys())
                        for t in tables_to_check:
                            root = equiv.find(col_key(t, first_col.name))
                            outer_spec = specs.setdefault(root, ColumnSpec())
                            if outer_spec.column is None:
                                _fill_column_metadata(outer_spec, root, equiv, alias_to_table, schema)
                            outer_spec.is_avg_subquery_col = True


# ════════════════════════════════════════════════════════════════
# Helpers: Query structure analysis
# ════════════════════════════════════════════════════════════════

def _get_reaggregated_inner_group_cols(ast: Optional[exp.Expression]) -> Set[str]:
    """
    Identify inner GROUP BY column names (G_inner \\ G_outer) that are grouped in a
    CTE or derived-table subquery `sel_inner` (without a HAVING clause or filtered
    aggregate alias) and then re-aggregated by an outer SELECT `sel_outer` over a
    strict subset of grouping keys G_outer.

    To allow `sel_inner` to emit multiple distinct groups per outer group G_outer,
    columns in G_inner \\ G_outer must vary across rows rather than repeating a
    single constant group value.
    """
    if not ast:
        return set()

    named_selects: Dict[str, exp.Select] = {}
    for sq in ast.find_all((exp.CTE, exp.Subquery)):
        if sq.alias:
            sub_sel = sq.this if isinstance(sq.this, exp.Select) else sq.find(exp.Select)
            if sub_sel:
                named_selects[sq.alias.upper()] = sub_sel
    if not named_selects:
        return set()

    compared_cols: Set[str] = {
        c.name.upper()
        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ))
        for c in comp.find_all(exp.Column)
        if c.name
    }

    reaggregated: Set[str] = set()
    for sel_outer in ast.find_all(exp.Select):
        outer_group = sel_outer.args.get("group")
        has_outer_agg = bool(outer_group) or any(
            ag.find_ancestor(exp.Select) is sel_outer
            for ag in sel_outer.find_all(exp.AggFunc)
        )
        if not has_outer_agg:
            continue

        outer_gb_cols = (
            {c.name.upper() for c in outer_group.find_all(exp.Column) if c.name}
            if outer_group else set()
        )

        inner_selects: List[exp.Select] = []
        for t_node in sel_outer.find_all(exp.Table):
            if t_node.find_ancestor(exp.Select) is sel_outer and t_node.name:
                t_up = t_node.name.upper()
                if t_up in named_selects:
                    inner_selects.append(named_selects[t_up])
        for sq_node in sel_outer.find_all(exp.Subquery):
            if isinstance(sq_node.parent, (exp.From, exp.Join)) and sq_node.find_ancestor(exp.Select) is sel_outer:
                if isinstance(sq_node.this, exp.Select):
                    inner_selects.append(sq_node.this)

        for sel_inner in inner_selects:
            inner_group = sel_inner.args.get("group")
            if not inner_group or sel_inner.args.get("having"):
                continue
            inner_where = sel_inner.args.get("where")
            if inner_where and any(
                sq.find(exp.Group) and sq.find(exp.AggFunc)
                for sq in inner_where.find_all(exp.Subquery)
            ):
                continue
            inner_agg_aliases = {
                e.alias.upper()
                for e in sel_inner.expressions
                if isinstance(e, exp.Alias) and e.alias and e.find(exp.AggFunc)
            }
            if inner_agg_aliases & compared_cols:
                continue
            inner_gb_cols = {c.name.upper() for c in inner_group.find_all(exp.Column) if c.name}
            if inner_gb_cols - outer_gb_cols:
                reaggregated.update(inner_gb_cols - outer_gb_cols)

    return reaggregated


def _is_singleton_having_group(
    group_node: exp.Group, ast: Optional[exp.Expression] = None
) -> bool:
    """
    Check if `group_node` belongs to a SELECT scope whose HAVING clause (or outer
    predicate on a projected COUNT alias) constrains the group cardinality to at
    most 1 (e.g. `HAVING COUNT(*) = 1`, `COUNT(*) <= 1`, `COUNT(*) < 2`), without
    any co-occurring multi-row lower bound (`COUNT(*) > 1`, `>= 2`).
    """
    sel = group_node.find_ancestor(exp.Select)
    if not sel:
        return False

    has_singleton_bound = False
    has_multi_bound = False

    def _eval_count_comp(
        comp: exp.Expression,
        count_on_left: bool,
        lit_node: exp.Literal,
        boundary_root: exp.Expression,
    ) -> None:
        nonlocal has_singleton_bound, has_multi_bound
        if lit_node.is_string:
            return
        try:
            val = float(lit_node.this)
        except (ValueError, TypeError):
            return

        op_cls = type(comp)
        if not count_on_left:
            flip_map = {
                exp.GT: exp.LT,
                exp.GTE: exp.LTE,
                exp.LT: exp.GT,
                exp.LTE: exp.GTE,
                exp.EQ: exp.EQ,
                exp.NEQ: exp.NEQ,
            }
            op_cls = flip_map.get(op_cls, op_cls)

        not_cnt = 0
        curr = comp.parent
        while curr and curr is not boundary_root:
            if isinstance(curr, exp.Not):
                not_cnt += 1
            curr = curr.parent
        is_neg = (not_cnt % 2 == 1) ^ bool(comp.args.get("negate"))
        if is_neg:
            neg_map = {
                exp.GT: exp.LTE,
                exp.GTE: exp.LT,
                exp.LT: exp.GTE,
                exp.LTE: exp.GT,
                exp.EQ: exp.NEQ,
                exp.NEQ: exp.EQ,
            }
            op_cls = neg_map.get(op_cls, op_cls)

        if (
            (op_cls is exp.EQ and val == 1)
            or (op_cls is exp.LTE and val == 1)
            or (op_cls is exp.LT and 1 < val <= 2)
        ):
            has_singleton_bound = True
        elif (
            (op_cls is exp.GT and val >= 1)
            or (op_cls is exp.GTE and val > 1)
            or (op_cls is exp.EQ and val > 1)
            or (op_cls is exp.NEQ and val == 1)
        ):
            has_multi_bound = True

    count_aliases = {
        expr.alias.upper()
        for expr in (sel.expressions or [])
        if isinstance(expr, exp.Alias) and expr.alias and isinstance(expr.this, exp.Count)
    }

    having = sel.args.get("having")
    if having:
        for comp in having.find_all((exp.EQ, exp.LTE, exp.LT, exp.GT, exp.GTE, exp.NEQ)):
            if comp.find_ancestor(exp.Select) is not sel:
                continue
            l, r = comp.left, comp.right
            l_is_cnt = isinstance(l, exp.Count) or (
                isinstance(l, exp.Column) and (l.name or "").upper() in count_aliases
            )
            r_is_cnt = isinstance(r, exp.Count) or (
                isinstance(r, exp.Column) and (r.name or "").upper() in count_aliases
            )
            if l_is_cnt and isinstance(r, exp.Literal):
                _eval_count_comp(comp, True, r, having)
            elif r_is_cnt and isinstance(l, exp.Literal):
                _eval_count_comp(comp, False, l, having)

    if ast and count_aliases:
        parent_alias = ""
        if isinstance(sel.parent, (exp.Subquery, exp.CTE)) and sel.parent.alias:
            parent_alias = sel.parent.alias.upper()
        for comp in ast.find_all((exp.EQ, exp.LTE, exp.LT, exp.GT, exp.GTE, exp.NEQ)):
            if comp.find_ancestor(exp.Select) is sel:
                continue
            l, r = comp.left, comp.right
            if isinstance(l, exp.Column) and (l.name or "").upper() in count_aliases and isinstance(r, exp.Literal):
                if not l.table or not parent_alias or l.table.upper() == parent_alias:
                    _eval_count_comp(comp, True, r, ast)
            elif isinstance(r, exp.Column) and (r.name or "").upper() in count_aliases and isinstance(l, exp.Literal):
                if not r.table or not parent_alias or r.table.upper() == parent_alias:
                    _eval_count_comp(comp, False, l, ast)

    return bool(has_singleton_bound and not has_multi_bound)


def get_singleton_having_group_cols(ast: Optional[exp.Expression]) -> Set[str]:
    """
    Identify GROUP BY column names (uppercase) that appear in singleton-constrained
    GROUP BY clauses (e.g. `HAVING COUNT(*) = 1`) and do not appear in any
    non-singleton GROUP BY clause in the query.
    """
    if not ast:
        return set()

    singleton_cols: Set[str] = set()
    multi_cols: Set[str] = set()

    for sub_group in ast.find_all(exp.Group):
        sel = sub_group.find_ancestor(exp.Select)
        col_names: Set[str] = set()
        for c in sub_group.find_all(exp.Column):
            if not c.name:
                continue
            col_names.add(c.name.upper())
            if not c.table and sel:
                for sel_expr in sel.expressions or []:
                    if isinstance(sel_expr, exp.Alias) and (sel_expr.alias or "").upper() == c.name.upper():
                        for inner_c in sel_expr.this.find_all(exp.Column):
                            if inner_c.name:
                                col_names.add(inner_c.name.upper())
        if _is_singleton_having_group(sub_group, ast):
            singleton_cols.update(col_names)
        else:
            multi_cols.update(col_names)

    return singleton_cols - multi_cols


def _collect_group_by_roots(
    specs: Dict[Tuple[str, str], ColumnSpec], parsed_query: Dict[str, Any],
    equiv: UnionFind, alias_to_table: Dict[str, str]
) -> None:
    """
    Mark ``is_group_key=True`` on ColumnSpecs for columns in GROUP BY.

    Group-key columns will have their values *repeated* during padding
    (Phase 2) so that multiple rows share the same group-key value,
    producing meaningful groups for aggregate functions.
    """
    ast = parsed_query.get("ast")
    if not ast and parsed_query.get("raw_query"):
        try:
            ast = sqlglot.parse_one(parsed_query.get("raw_query"))
        except Exception:
            ast = None

    if not ast:
        return

    reaggregated_inner_cols = _get_reaggregated_inner_group_cols(ast)
    singleton_only_cols = get_singleton_having_group_cols(ast)
    excluded_group_cols = reaggregated_inner_cols | singleton_only_cols

    group_ast = ast.args.get("group")
    if group_ast and not _is_singleton_having_group(group_ast, ast):
        for root in find_column_equivalence_roots(group_ast, equiv, alias_to_table):
            if root[1].upper() in excluded_group_cols:
                continue
            spec = specs.setdefault(root, ColumnSpec())
            spec.is_group_key = True

    for sub_group in ast.find_all(exp.Group):
        if _is_singleton_having_group(sub_group, ast):
            continue
        for root in find_column_equivalence_roots(sub_group, equiv, alias_to_table):
            if root[1].upper() in excluded_group_cols:
                continue
            if root in specs:
                specs[root].is_group_key = True

    for gb in parsed_query.get("group_by", []):
        t_alias = gb.get("table", "")
        c_name = gb.get("column", "")
        if c_name.upper() in excluded_group_cols:
            continue
        tables_to_check = (
            [t_alias]
            if (t_alias and t_alias.upper() in alias_to_table)
            else list(alias_to_table.keys())
        )
        for t in tables_to_check:
            root = equiv.find(col_key(t, c_name))
            if root in specs:
                specs[root].is_group_key = True

    for win_node in ast.find_all(exp.Window):
        if isinstance(win_node.this, (exp.Lead, exp.Lag)):
            for part_expr in win_node.args.get("partition_by") or []:
                for root in find_column_equivalence_roots(part_expr, equiv, alias_to_table):
                    if root[1].upper() in reaggregated_inner_cols:
                        continue
                    if root in specs:
                        specs[root].is_group_key = True


def _collect_distinct_count_roots(
    specs: Dict[Tuple[str, str], ColumnSpec], parsed_query: Dict[str, Any],
    equiv: UnionFind, alias_to_table: Dict[str, str], schema: Schema
) -> None:
    """
    Mark ``must_be_unique=True`` on ColumnSpecs for columns inside
    COUNT(DISTINCT col).

    If a column appears inside COUNT(DISTINCT ...), generating duplicate
    values would deflate the count. Marking it unique ensures every
    generated row contributes a distinct value to the aggregate.
    """
    ast = parsed_query.get("ast")
    if not ast:
        return
    for node in ast.walk():
        actual = node[0] if isinstance(node, tuple) else node
        if isinstance(actual, exp.Count) and isinstance(actual.this, exp.Distinct):
            for root in find_column_equivalence_roots(actual.this, equiv, alias_to_table):
                spec = specs.setdefault(root, ColumnSpec())
                if spec.column is None:
                    _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                spec.must_be_unique = True


# ════════════════════════════════════════════════════════════════
# Helpers: Row count extraction
# ════════════════════════════════════════════════════════════════

def _extract_count_bounds(parsed_query: Dict[str, Any]) -> Tuple[int, Set[int]]:
    """
    Extract `(min_count, forbidden_counts)` from HAVING COUNT predicates
    and outer WHERE/HAVING predicates over subquery COUNT aliases.
    """
    if "_cached_count_bounds" in parsed_query:
        return parsed_query["_cached_count_bounds"]

    min_count = 1
    forbidden_counts: Set[int] = set()
    if not parsed_query.get("has_having") and not parsed_query.get("group_by") and not parsed_query.get("has_group_by"):
        parsed_query["_cached_count_bounds"] = (min_count, forbidden_counts)
        return min_count, forbidden_counts

    ast = parsed_query.get("ast")
    if not ast and parsed_query.get("raw_query"):
        try:
            ast = sqlglot.parse_one(parsed_query.get("raw_query"))
        except Exception:
            ast = None

    def _record_comp(comp: exp.Expression, count_on_left: bool, lit_node: exp.Literal, root_scope: exp.Expression) -> None:
        nonlocal min_count
        if lit_node.is_string or not str(lit_node.this).lstrip("-").isdigit():
            return
        num = int(lit_node.this)
        op_cls = type(comp)
        if not count_on_left:
            flip_map = {
                exp.GT: exp.LT,
                exp.GTE: exp.LTE,
                exp.LT: exp.GT,
                exp.LTE: exp.GTE,
                exp.EQ: exp.EQ,
                exp.NEQ: exp.NEQ,
            }
            op_cls = flip_map.get(op_cls, op_cls)

        not_cnt = 0
        curr = comp.parent
        while curr and curr is not root_scope:
            if isinstance(curr, exp.Not):
                not_cnt += 1
            curr = curr.parent
        if (not_cnt % 2 == 1) ^ bool(comp.args.get("negate")):
            neg_map = {
                exp.GT: exp.LTE,
                exp.GTE: exp.LT,
                exp.LT: exp.GTE,
                exp.LTE: exp.GT,
                exp.EQ: exp.NEQ,
                exp.NEQ: exp.EQ,
            }
            op_cls = neg_map.get(op_cls, op_cls)

        if op_cls is exp.GT:
            min_count = max(min_count, num + 1)
        elif op_cls in (exp.GTE, exp.EQ):
            min_count = max(min_count, num)
        elif op_cls is exp.NEQ:
            if num >= 1:
                forbidden_counts.add(num)
            if num == 1:
                min_count = max(min_count, 2)

    if not ast:
        having_ast = parsed_query.get("having_ast")
        if not having_ast:
            return min_count, forbidden_counts
        for node in having_ast.walk():
            actual = node[0] if isinstance(node, tuple) else node
            if isinstance(actual, (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
                if isinstance(actual.left, exp.Count) and isinstance(actual.right, exp.Literal):
                    _record_comp(actual, True, actual.right, having_ast)
                elif isinstance(actual.right, exp.Count) and isinstance(actual.left, exp.Literal):
                    _record_comp(actual, False, actual.left, having_ast)
        return min_count, forbidden_counts

    for having_node in ast.find_all(exp.Having):
        for comp in having_node.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
            if isinstance(comp.left, exp.Count) and isinstance(comp.right, exp.Literal):
                _record_comp(comp, True, comp.right, having_node)
            elif isinstance(comp.right, exp.Count) and isinstance(comp.left, exp.Literal):
                _record_comp(comp, False, comp.left, having_node)

    count_aliases = set()
    for s in ast.find_all(exp.Select):
        for expr in s.expressions:
            if isinstance(expr, exp.Alias) and expr.find(exp.Count):
                count_aliases.add(expr.alias.upper())

    if count_aliases:
        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
            l, r = comp.left, comp.right
            if isinstance(l, exp.Column) and l.name.upper() in count_aliases and isinstance(r, exp.Literal):
                _record_comp(comp, True, r, ast)
            elif isinstance(r, exp.Column) and r.name.upper() in count_aliases and isinstance(l, exp.Literal):
                _record_comp(comp, False, l, ast)

    return min_count, forbidden_counts


def _extract_having_row_count(parsed_query: Dict[str, Any]) -> int:
    """
    Extract the minimum row count required to satisfy HAVING COUNT predicates
    and subquery COUNT predicates filtered in outer WHERE clauses.

    For example, ``HAVING COUNT(*) > 3`` requires at least 4 rows per group,
    and ``HAVING COUNT(*) >= 5`` or ``WHERE n >= 2`` (where n = COUNT(*)) requires at least 5 / 2.
    """
    min_count, _ = _extract_count_bounds(parsed_query)
    return min_count


def _has_subquery_inequality(parsed_query: Dict[str, Any]) -> bool:
    """
    Check if the WHERE or HAVING clause contains an inequality comparison
    (>, <, >=, <=, !=) against a subquery or a derived-table/window aggregate alias.

    When present, we need ≥3 rows so that aggregate subqueries or window
    aggregates (e.g. MAX, MIN, AVG) produce non-trivial results that can
    differentiate correct vs. mutant.
    """
    ast = parsed_query.get("ast")
    agg_or_win_aliases: Set[str] = set()
    if ast:
        for sel in ast.find_all(exp.Select):
            for expr in sel.expressions:
                if isinstance(expr, exp.Alias) and expr.alias:
                    if expr.find(exp.Window) or expr.find(exp.AggFunc):
                        agg_or_win_aliases.add(expr.alias.upper())
        if agg_or_win_aliases:
            changed = True
            while changed:
                changed = False
                for sel in ast.find_all(exp.Select):
                    for expr in sel.expressions:
                        if isinstance(expr, exp.Alias) and expr.alias and expr.alias.upper() not in agg_or_win_aliases:
                            if isinstance(expr.this, exp.Column) and expr.this.name.upper() in agg_or_win_aliases:
                                agg_or_win_aliases.add(expr.alias.upper())
                                changed = True

    def _check(ast_node):
        if not ast_node:
            return False
        for node in ast_node.walk():
            actual = node[0] if isinstance(node, tuple) else node
            if isinstance(actual, (exp.GT, exp.LT, exp.GTE, exp.LTE, exp.NEQ)):
                if (
                    isinstance(actual.left, exp.Subquery)
                    or isinstance(actual.right, exp.Subquery)
                    or (actual.left and actual.left.find(exp.Subquery) is not None)
                    or (actual.right and actual.right.find(exp.Subquery) is not None)
                ):
                    return True
                if agg_or_win_aliases:
                    for col in actual.find_all(exp.Column):
                        if col.name.upper() in agg_or_win_aliases:
                            return True
        return False
    return _check(parsed_query.get("where_ast")) or _check(parsed_query.get("having_ast")) or _check(ast)


def _extract_int_from_limit_expr(expr: Any) -> Optional[int]:
    """Safely extract an integer literal (including negative values) from a Limit/Offset AST node."""
    if expr is None:
        return None
    if isinstance(expr, exp.Neg):
        inner = _extract_int_from_limit_expr(expr.this)
        return -inner if inner is not None else None
    if isinstance(expr, exp.Literal):
        try:
            return int(expr.this)
        except (ValueError, TypeError):
            return None
    if hasattr(expr, "expression") and expr.expression is not None:
        return _extract_int_from_limit_expr(expr.expression)
    if hasattr(expr, "this") and expr.this is not None:
        if isinstance(expr.this, exp.Expression):
            return _extract_int_from_limit_expr(expr.this)
        try:
            return int(str(expr.this))
        except (ValueError, TypeError):
            return None
    return None


def _extract_limit_offset_row_count(
    parsed_query: Dict[str, Any],
    include_limit_padding: bool = True,
) -> int:
    """
    Extract minimum row count required for queries with LIMIT and/or OFFSET.

    Rationale:
      If OFFSET=K, a dataset with ≤K rows yields 0 result rows for *both*
      the correct and mutant query, producing a vacuous EQ_EXEC (empty-set
      comparison). To avoid this, we require at least ``offset + limit + 3``
      rows when ``include_limit_padding`` is True (the +3 margin ensures
      non-trivial result sets for LIMIT/OFFSET mutation detection). When
      ``include_limit_padding`` is False (e.g. for DISTINCT / join cardinality
      duplication attacks where extra distinct rows would saturate LIMIT K and
      push duplicate tuples outside the top-K window), only OFFSET contributes
      the minimum prefix count needed before duplication.
    """
    max_req = 1
    ast = parsed_query.get("ast")
    if not ast and parsed_query.get("raw_query"):
        try:
            ast = sqlglot.parse_one(parsed_query.get("raw_query"))
        except Exception:
            ast = None

    if not ast:
        return max_req

    for lim in ast.find_all(exp.Limit):
        lim_val = _extract_int_from_limit_expr(lim)
        if lim_val is not None and lim_val < 0:
            lim_val = None

        off_val = _extract_int_from_limit_expr(lim.args.get("offset")) if lim.args.get("offset") else None

        if off_val is None:
            select_parent = lim.find_ancestor(exp.Select)
            if select_parent and select_parent.args.get("offset"):
                off_val = _extract_int_from_limit_expr(select_parent.args.get("offset"))

        if include_limit_padding:
            if off_val is not None:
                eff_lim = min(lim_val, 10) if lim_val is not None else 2
                max_req = max(max_req, off_val + eff_lim + 3)
            elif lim_val is not None:
                eff_lim = min(lim_val, 10)
                max_req = max(max_req, eff_lim + 3)
        else:
            if off_val is not None:
                if lim_val == 1 and off_val >= 1:
                    max_req = max(max_req, off_val)
                else:
                    max_req = max(max_req, off_val + 1)

    for off in ast.find_all(exp.Offset):
        off_val = _extract_int_from_limit_expr(off)
        if off_val is not None:
            if include_limit_padding:
                max_req = max(max_req, off_val + 5)
            else:
                max_req = max(max_req, off_val + 1)

    return max_req


def _extract_window_offset_row_count(parsed_query: Dict[str, Any]) -> int:
    """
    Extract minimum row count required for offset window functions (LEAD / LAG).

    Rationale:
      In SQL window semantics, ``LEAD(expr, k)`` and ``LAG(expr, k)`` (where offset
      ``k`` defaults to 1) evaluate to NULL on every row of a partition unless the
      partition contains at least ``k + 1`` rows. Ensuring ``min_row_count >= k + 1``
      (with ``k`` capped at 10) guarantees at least one row yields a non-NULL
      lead/lag value.
    """
    max_req = 1
    ast = parsed_query.get("ast")
    if not ast and parsed_query.get("raw_query"):
        try:
            ast = sqlglot.parse_one(parsed_query.get("raw_query"))
        except Exception:
            ast = None

    if not ast:
        return max_req

    for node in ast.find_all((exp.Lead, exp.Lag)):
        off_expr = node.args.get("offset")
        off_val = _extract_int_from_limit_expr(off_expr) if off_expr is not None else 1
        if off_val is None or off_val <= 0:
            off_val = 1
        eff_off = min(off_val, 10)
        max_req = max(max_req, eff_off + 1)

    return max_req


# ════════════════════════════════════════════════════════════════
# Helpers: NOT IN root extraction
# ════════════════════════════════════════════════════════════════

def extract_not_in_roots(
    parsed_query: Dict[str, Any], equiv: UnionFind, alias_to_table: Dict[str, str]
) -> Set[Tuple[str, str]]:
    """
    Extract equivalence class roots for columns used in NOT IN (subquery).

    These roots are used in Phase 4 to generate unmatched parent rows —
    rows whose join/FK column values deliberately do NOT appear in the
    subquery result, enabling detection of NOT IN → IN mutations.
    """
    not_in_roots: Set[Tuple[str, str]] = set()
    where_ast = parsed_query.get("where_ast")
    if not where_ast:
        return not_in_roots
    for node in where_ast.walk():
        actual = node[0] if isinstance(node, tuple) else node
        if isinstance(actual, exp.Not) and isinstance(actual.this, exp.In):
            for root in find_column_equivalence_roots(actual.this.this, equiv, alias_to_table):
                not_in_roots.add(root)
    return not_in_roots


# ════════════════════════════════════════════════════════════════
# Main entry point: analyze_constraints_and_cardinality
# ════════════════════════════════════════════════════════════════

def analyze_constraints_and_cardinality(
    schema: Schema, parsed_query: Dict[str, Any],
    equiv: UnionFind, alias_to_table: Dict[str, str],
    null_injections: Optional[List[Tuple[str, str]]],
    value_injections: Optional[Dict[Tuple[str, str], Any]],
    include_limit_padding: bool = True,
) -> Tuple[Dict[Tuple[str, str], ColumnSpec], int]:
    """
    Phase 1: Perform single-pass query analysis for column specs AND cardinality.

    Performs a unified single pass over the schema DDL and parsed query AST to:
      1. Build one ColumnSpec per equivalence class root (domain constraints).
      2. Solve complex multi-variable arithmetic constraints via Z3 SMT solver.
      3. Compute minimum dataset cardinality (row count) required for HAVING COUNT,
         LIMIT/OFFSET, and aggregate subquery satisfaction.

    Args:
        schema:           Relational schema.
        parsed_query:     Parsed query dict.
        equiv:            Union-find from Phase 0.
        alias_to_table:   Alias → table name mapping from Phase 0.
        null_injections:  List of (table, column) pairs to force NULL.
        value_injections: Dict mapping (table, column) → specific value(s) to inject.

    Returns:
        specs:          Dict mapping equivalence class root → ColumnSpec.
        min_row_count:  Minimum number of rows every table should generate.
    """
    specs: Dict[Tuple[str, str], ColumnSpec] = {}

    # ── Sub-step 1: Schema constraints ──
    # For every column of every target table, create/update the ColumnSpec for
    # its equivalence class root with PK/UNIQUE, data type, VARCHAR limit,
    # and CHECK constraint expressions from the DDL.
    for alias, t_name in alias_to_table.items():
        table_key = schema.find_table(t_name)
        if not table_key:
            continue
        for col in schema.tables[table_key].columns:
            root = equiv.find(col_key(alias, col.name))
            spec = specs.setdefault(root, ColumnSpec())
            spec.must_be_unique = spec.must_be_unique or col.is_primary_key or col.is_unique
            spec.is_temporal = spec.is_temporal or col.is_temporal

            is_int_pk = col.is_primary_key and "int" in (col.data_type or "").lower()
            current_is_int_pk = (
                spec.column is not None
                and spec.column.is_primary_key
                and "int" in (spec.data_type or "").lower()
            )

            if spec.column is None or not spec.data_type:
                spec.column = col
                spec.data_type = col.data_type
                spec.table_name = table_key
            elif is_int_pk and not current_is_int_pk:
                spec.column = col
                spec.data_type = col.data_type
                spec.table_name = table_key
            elif "int" in (col.data_type or "").lower() and any(t in (spec.data_type or "").lower() for t in ("char", "text")):
                spec.column = col
                spec.data_type = col.data_type
                spec.table_name = table_key
            elif col.is_primary_key and not (spec.column and spec.column.is_primary_key):
                spec.column = col
                spec.data_type = col.data_type
                spec.table_name = table_key
            # Accumulate char limit (minimum across equivalence class)
            col_limit = _parse_char_limit(col.data_type)
            if col_limit is not None:
                spec.char_limit = min(spec.char_limit, col_limit) if spec.char_limit is not None else col_limit
            # Accumulate CHECK constraints
            checks = get_check_constraints_for_column(schema, table_key, col.name)
            for cc in checks:
                if cc not in spec.check_exprs:
                    spec.check_exprs.append(cc)
            for fk in schema.tables[table_key].foreign_keys:
                if fk.column_name.upper() == col.name.upper():
                    parent_t = schema.find_table(fk.reference_table)
                    if parent_t:
                        parent_checks = get_check_constraints_for_column(schema, parent_t, fk.reference_column)
                        for cc in parent_checks:
                            if cc not in spec.check_exprs:
                                spec.check_exprs.append(cc)

    # ── Sub-step 2: Query predicates (WHERE / HAVING literals) ──
    # Each literal is resolved to its equivalence class root, then applied
    # to the corresponding ColumnSpec via _apply_literal_to_spec.
    # For SUBSTRING/SUBSTR equality/IN predicates (with start > 1 or multiple slices
    # on the same equivalence class), compatible character-slice constraints are
    # merged into composite strings so all slice predicates are jointly satisfied.
    literals_by_root: Dict[Tuple[str, str], List[dict]] = {}
    for literal in parsed_query.get("where_literals", []):
        root = _resolve_literal_root(literal, equiv, alias_to_table, schema)
        literals_by_root.setdefault(root, []).append(literal)

    ast = parsed_query.get("ast")
    ast_substr_slices_by_root: Dict[Tuple[str, str], List[Tuple[int, Optional[int]]]] = {}
    if ast:
        for sub_node in ast.find_all((exp.Substring, exp.Anonymous)):
            sub_meta = _extract_substring_meta(sub_node)
            if not sub_meta or sub_meta[0] < 1:
                continue
            target_expr = (
                sub_node.this
                if isinstance(sub_node, exp.Substring)
                else (sub_node.expressions[0] if getattr(sub_node, "expressions", None) else None)
            )
            if target_expr is None:
                continue
            cols_in_sub = list(target_expr.find_all(exp.Column))
            if len(cols_in_sub) != 1:
                continue
            col_node = cols_in_sub[0]
            enc_sel = sub_node.find_ancestor(exp.Select)
            scope_tables = [
                t.alias or t.name
                for t in (enc_sel.find_all(exp.Table) if enc_sel else [])
                if t.find_ancestor(exp.Select) is enc_sel and (t.alias or t.name)
            ]
            sub_root = _resolve_literal_root(
                {"table": col_node.table, "column": col_node.name, "scope_tables": scope_tables},
                equiv,
                alias_to_table,
                schema,
            )
            slice_list = ast_substr_slices_by_root.setdefault(sub_root, [])
            slice_pair = (int(sub_meta[0]), int(sub_meta[1]) if sub_meta[1] is not None else None)
            if slice_pair not in slice_list:
                slice_list.append(slice_pair)

    for root, root_lits in literals_by_root.items():
        spec = specs.setdefault(root, ColumnSpec())
        if spec.column is None:
            _fill_column_metadata(spec, root, equiv, alias_to_table, schema)

        length_lits = [
            lit for lit in root_lits
            if lit.get("is_length_expr") and lit.get("value") != "NULL"
        ]
        other_lits = [lit for lit in root_lits if lit not in length_lits]

        substr_eq_lits = [
            lit for lit in other_lits
            if lit.get("substr_start") is not None
            and int(lit["substr_start"]) >= 1
            and lit.get("operator", "EQ").upper() in ("EQ", "IN")
            and lit.get("value") != "NULL"
        ]
        substr_neq_lits = [
            lit for lit in other_lits
            if lit.get("substr_start") is not None
            and int(lit["substr_start"]) > 1
            and lit.get("operator", "EQ").upper() in ("NEQ", "NOT IN", "GT", "GTE")
            and lit.get("value") != "NULL"
        ]
        ast_slices = ast_substr_slices_by_root.get(root, [])
        has_extra_ast_slice = False
        if substr_eq_lits and ast_slices:
            covered_positions: Set[int] = set()
            for lit in substr_eq_lits:
                st_p = int(lit["substr_start"])
                ln_p = lit.get("substr_length")
                sv = str(lit["value"])
                if ln_p is not None and int(ln_p) >= 0:
                    sv = sv[: int(ln_p)]
                covered_positions.update(range(st_p - 1, st_p - 1 + len(sv)))
            for s_pos, s_len in ast_slices:
                eff_len = s_len if (s_len is not None and s_len > 0) else 2
                if any(pos not in covered_positions for pos in range(s_pos - 1, s_pos - 1 + eff_len)):
                    has_extra_ast_slice = True
                    break

        use_substr_synthesis = (
            len(substr_eq_lits) > 1
            or (len(substr_eq_lits) == 1 and int(substr_eq_lits[0]["substr_start"]) > 1)
            or has_extra_ast_slice
        )

        if use_substr_synthesis:
            char_maps: List[Dict[int, str]] = []
            for lit in substr_eq_lits:
                start_pos = int(lit["substr_start"])
                sub_len = lit.get("substr_length")
                s_val = str(lit["value"])
                if sub_len is not None and int(sub_len) >= 0:
                    s_val = s_val[:int(sub_len)]
                slice_map = {(start_pos - 1) + k: ch for k, ch in enumerate(s_val)}
                if not char_maps:
                    char_maps.append(slice_map)
                else:
                    merged_any = False
                    for cmap in char_maps:
                        if all(pos not in cmap or cmap[pos] == ch for pos, ch in slice_map.items()):
                            cmap.update(slice_map)
                            merged_any = True
                    if not merged_any:
                        new_map = {
                            pos: ch for pos, ch in char_maps[0].items()
                            if pos not in slice_map
                        }
                        new_map.update(slice_map)
                        char_maps.append(new_map)

            if has_extra_ast_slice:
                for cmap in char_maps:
                    for s_pos, s_len in ast_slices:
                        eff_len = s_len if (s_len is not None and s_len > 0) else 2
                        free_pos = [pos for pos in range(s_pos - 1, s_pos - 1 + eff_len) if pos not in cmap]
                        if free_pos:
                            tok = f"{1:0{len(free_pos)}d}"[-len(free_pos):]
                            for idx_p, pos in enumerate(free_pos):
                                cmap[pos] = tok[idx_p]

            for cmap in char_maps:
                if not cmap:
                    synthesized = ""
                else:
                    max_idx = max(cmap.keys())
                    synthesized = "".join(cmap.get(i, "_") for i in range(max_idx + 1))
                if synthesized not in spec.required:
                    spec.required.append(synthesized)

            for lit in other_lits:
                if lit not in substr_eq_lits and lit not in substr_neq_lits:
                    _apply_literal_to_spec(spec, lit)
        else:
            for lit in other_lits:
                if lit not in substr_neq_lits:
                    _apply_literal_to_spec(spec, lit)

        if substr_neq_lits and not substr_eq_lits:
            for lit in substr_neq_lits:
                st_pos = int(lit["substr_start"])
                sub_len = lit.get("substr_length")
                forbid_s = str(lit["value"])
                eff_len = int(sub_len) if (sub_len is not None and int(sub_len) > 0) else max(1, len(forbid_s))
                alt_ch = "z" if (not forbid_s or forbid_s[0] != "z") else "y"
                prefix = str(synthesize_string_of_length(spec.column, st_pos - 1, override_limit=spec.char_limit))
                synthesized = prefix + (alt_ch * eff_len)
                if spec.char_limit is not None and len(synthesized) > spec.char_limit:
                    synthesized = synthesized[: spec.char_limit]
                if synthesized not in spec.required:
                    spec.required.append(synthesized)

        if length_lits:
            target_lens, min_len, _, _ = _resolve_target_lengths(length_lits)
            non_null_reqs = [rv for rv in spec.required if rv is not None]
            if non_null_reqs and min_len is not None:
                for idx_r, rv in enumerate(spec.required):
                    if isinstance(rv, str) and len(rv) < min_len:
                        pad = str(synthesize_string_of_length(spec.column, min_len - len(rv)))
                        spec.required[idx_r] = (rv + pad)[:min_len]
            elif not non_null_reqs:
                for t_len in target_lens:
                    syn_val = synthesize_string_of_length(spec.column, t_len, override_limit=spec.char_limit)
                    if syn_val not in spec.required:
                        spec.required.append(syn_val)

    # ── Sub-step 2a: Intra-table and inter-table column comparisons (e.g. colA > colB, BETWEEN) ──
    ast = parsed_query.get("ast")
    if ast:
        def _resolve_col_alias_in_scope(col_node: exp.Column) -> str:
            col_t = (col_node.table or "").upper()
            if col_t and col_t in alias_to_table:
                return col_t
            is_same_col_eq = (
                isinstance(col_node.parent, exp.EQ)
                and isinstance(col_node.parent.left, exp.Column)
                and isinstance(col_node.parent.right, exp.Column)
                and col_node.parent.left.name.upper() == col_node.parent.right.name.upper()
            )
            if col_t and not is_same_col_eq:
                for sq in ast.find_all((exp.Subquery, exp.CTE)):
                    if (sq.alias or "").upper() == col_t:
                        for t_node in sq.find_all(exp.Table):
                            eff_a = (t_node.alias or t_node.name or "").upper()
                            st = schema.find_table(t_node.name)
                            if eff_a in alias_to_table and st and schema.find_column(st, col_node.name):
                                return eff_a
                        break
                return col_t
            if not col_t:
                enc_sel = col_node.find_ancestor(exp.Select)
                if enc_sel:
                    for t_node in enc_sel.find_all(exp.Table):
                        if t_node.find_ancestor(exp.Select) is enc_sel:
                            eff_a = (t_node.alias or t_node.name or "").upper()
                            st = schema.find_table(t_node.name)
                            if eff_a in alias_to_table and st and schema.find_column(st, col_node.name):
                                return eff_a
            for a, tn in alias_to_table.items():
                st = schema.find_table(tn)
                if st and schema.find_column(st, col_node.name):
                    return a.upper()
            return col_t

        # Synthesize canonical delimiter-separated values for unconstrained TEXT columns
        # searched via INSTR / STRPOS / POSITION / CHARINDEX so delimiter searches succeed
        # (INSTR(col, delim) > 0) and delimiter-bounded SUBSTRING slices are non-empty.
        delims_by_root: Dict[Tuple[str, str], List[str]] = {}
        for pos_node in ast.find_all((exp.StrPosition, exp.Anonymous)):
            target_expr: Optional[exp.Expression] = None
            substr_expr: Optional[exp.Expression] = None
            if isinstance(pos_node, exp.StrPosition):
                target_expr = pos_node.this
                substr_expr = pos_node.args.get("substr")
            elif isinstance(pos_node, exp.Anonymous):
                fn_lower = (pos_node.name or "").lower()
                exprs = pos_node.expressions or []
                if fn_lower in ("instr", "strpos") and len(exprs) >= 2:
                    target_expr, substr_expr = exprs[0], exprs[1]
                elif fn_lower == "charindex" and len(exprs) >= 2:
                    substr_expr, target_expr = exprs[0], exprs[1]

            if target_expr is None or not isinstance(substr_expr, exp.Literal):
                continue
            delim_str = str(substr_expr.name)
            if not delim_str:
                continue
            col_node = target_expr if isinstance(target_expr, exp.Column) else target_expr.find(exp.Column)
            if col_node is None:
                continue
            col_alias = _resolve_col_alias_in_scope(col_node)
            if not col_alias or col_alias not in alias_to_table:
                continue
            root = equiv.find(col_key(col_alias, col_node.name))
            root_delims = delims_by_root.setdefault(root, [])
            if delim_str not in root_delims:
                root_delims.append(delim_str)

        for root, root_delims in delims_by_root.items():
            spec = specs.setdefault(root, ColumnSpec())
            if spec.column is None:
                _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
            if (
                spec.column is not None
                and spec.column.is_text
                and not spec.is_temporal
                and not spec.required
                and spec.lower is None
                and spec.upper is None
            ):
                token_pool = [
                    t for t in ("12", "34", "56", "78", "91", "23", "45", "67")
                    if all(d not in t and t not in d for d in root_delims)
                ]
                if len(token_pool) < len(root_delims) + 1:
                    token_pool = ["12", "34", "56", "78", "91", "23", "45", "67"]
                parts: List[str] = [token_pool[0]]
                for idx, d in enumerate(root_delims):
                    parts.append(d)
                    parts.append(token_pool[(idx + 1) % len(token_pool)])
                synthesized_delim_val = "".join(parts)
                if spec.char_limit is not None and len(synthesized_delim_val) > spec.char_limit:
                    short_parts = ["1"]
                    for idx, d in enumerate(root_delims):
                        short_parts.append(d)
                        short_parts.append(str((idx + 2) % 9 or 2))
                    synthesized_delim_val = "".join(short_parts)[: spec.char_limit]
                if synthesized_delim_val:
                    spec.required.append(synthesized_delim_val)

        col_comparisons = []
        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
            l, r = comp.left, comp.right
            if isinstance(l, exp.Column) and isinstance(r, exp.Column):
                col_comparisons.append((comp, comp, l, r))

        for btw in ast.find_all(exp.Between):
            c_node = btw.this
            while isinstance(c_node, (exp.Cast, exp.TryCast, exp.Paren)):
                c_node = c_node.this
            low_node = btw.args.get("low")
            high_node = btw.args.get("high")
            if isinstance(c_node, exp.Column):
                if isinstance(low_node, exp.Column):
                    syn_gte = exp.GTE(this=c_node.copy(), expression=low_node.copy())
                    col_comparisons.append((btw, syn_gte, c_node, low_node))
                if isinstance(high_node, exp.Column):
                    syn_lte = exp.LTE(this=c_node.copy(), expression=high_node.copy())
                    col_comparisons.append((btw, syn_lte, c_node, high_node))
                if isinstance(low_node, exp.Column) and isinstance(high_node, exp.Column):
                    syn_low_high = exp.LTE(this=low_node.copy(), expression=high_node.copy())
                    col_comparisons.append((btw, syn_low_high, low_node, high_node))

        for ctx_node, comp, l, r in col_comparisons:
            lt = _resolve_col_alias_in_scope(l)
            rt = _resolve_col_alias_in_scope(r)
            curr = ctx_node
            is_not_exists = False
            not_count = 0
            while curr.parent:
                if isinstance(curr.parent, exp.Not):
                    not_count += 1
                if isinstance(curr.parent, exp.Exists) and curr.parent.parent and isinstance(curr.parent.parent, exp.Not):
                    is_not_exists = True
                    break
                curr = curr.parent

            if lt and rt and lt == rt:
                if is_not_exists:
                    # Negate the comparison for any sibling aliases of the same table
                    neg_map = {
                        exp.GT: exp.LTE,
                        exp.GTE: exp.LT,
                        exp.LT: exp.GTE,
                        exp.LTE: exp.GT,
                        exp.EQ: exp.NEQ,
                        exp.NEQ: exp.EQ,
                    }
                    neg_cls = neg_map.get(type(comp), exp.LTE)
                    neg_expr = neg_cls(
                        this=exp.Column(this=exp.Identifier(this=l.name)),
                        expression=exp.Column(this=exp.Identifier(this=r.name)),
                    )
                    resolved_t = None
                    subq_anc = ctx_node.find_ancestor(exp.Exists, exp.Subquery, exp.Select)
                    if subq_anc:
                        for t_node in subq_anc.find_all(exp.Table):
                            if (t_node.alias or t_node.name).upper() == lt:
                                resolved_t = schema.find_table(t_node.name)
                                break
                    if resolved_t:
                        neq_excluded_aliases: Set[str] = set()
                        if subq_anc:
                            for neq_node in subq_anc.find_all(exp.NEQ):
                                if isinstance(neq_node.left, exp.Column) and isinstance(neq_node.right, exp.Column):
                                    nl_a = _resolve_col_alias_in_scope(neq_node.left)
                                    nr_a = _resolve_col_alias_in_scope(neq_node.right)
                                    if nl_a == lt and nr_a != lt:
                                        neq_excluded_aliases.add(nr_a)
                                    elif nr_a == lt and nl_a != lt:
                                        neq_excluded_aliases.add(nl_a)
                        sib_aliases = [
                            a for a, tn in alias_to_table.items()
                            if schema.find_table(tn) == resolved_t and a != lt
                        ]
                        non_excluded_sibs = [a for a in sib_aliases if a.upper() not in neq_excluded_aliases]
                        target_sibs = non_excluded_sibs if non_excluded_sibs else sib_aliases
                        for a in target_sibs:
                            for col_n in (l.name, r.name):
                                root_sib = equiv.find(col_key(a, col_n))
                                spec_sib = specs.setdefault(root_sib, ColumnSpec())
                                if spec_sib.column is None:
                                    _fill_column_metadata(spec_sib, root_sib, equiv, alias_to_table, schema)
                                cc = {"column": col_n, "expression": neg_expr}
                                if cc not in spec_sib.check_exprs:
                                    spec_sib.check_exprs.append(cc)
                elif lt in alias_to_table and (not_count % 2 == 0):
                    root_l = equiv.find(col_key(lt, l.name))
                    spec_l = specs.setdefault(root_l, ColumnSpec())
                    if spec_l.column is None:
                        _fill_column_metadata(spec_l, root_l, equiv, alias_to_table, schema)
                    root_r = equiv.find(col_key(rt, r.name))
                    spec_r = specs.setdefault(root_r, ColumnSpec())
                    if spec_r.column is None:
                        _fill_column_metadata(spec_r, root_r, equiv, alias_to_table, schema)
                    cc_l = {"column": l.name, "expression": comp}
                    if cc_l not in spec_l.check_exprs:
                        spec_l.check_exprs.append(cc_l)
                    cc_r = {"column": r.name, "expression": comp}
                    if cc_r not in spec_r.check_exprs:
                        spec_r.check_exprs.append(cc_r)
                    if isinstance(comp, (exp.LT, exp.LTE)):
                        if spec_r.upper is not None:
                            spec_l.upper = safe_min(spec_l.upper, spec_r.upper)
                        if spec_l.lower is not None:
                            spec_r.lower = safe_max(spec_r.lower, spec_l.lower)
                    elif isinstance(comp, (exp.GT, exp.GTE)):
                        if spec_r.lower is not None:
                            spec_l.lower = safe_max(spec_l.lower, spec_r.lower)
                        if spec_l.upper is not None:
                            spec_r.upper = safe_min(spec_r.upper, spec_l.upper)

            if (
                not is_not_exists
                and (not_count % 2 == 0)
                and lt in alias_to_table
                and rt in alias_to_table
                and ctx_node.find_ancestor((exp.Where, exp.Having, exp.Join)) is not None
                and ctx_node.find_ancestor(exp.Case) is None
                and isinstance(comp, (exp.LT, exp.LTE, exp.GT, exp.GTE, exp.NEQ))
            ):
                root_l = equiv.find(col_key(lt, l.name))
                root_r = equiv.find(col_key(rt, r.name))
                if root_l != root_r:
                    spec_l = specs.setdefault(root_l, ColumnSpec())
                    if spec_l.column is None:
                        _fill_column_metadata(spec_l, root_l, equiv, alias_to_table, schema)
                    spec_r = specs.setdefault(root_r, ColumnSpec())
                    if spec_r.column is None:
                        _fill_column_metadata(spec_r, root_r, equiv, alias_to_table, schema)
                    op_pair_map = {
                        exp.LT: ("LT", "GT"),
                        exp.LTE: ("LTE", "GTE"),
                        exp.GT: ("GT", "LT"),
                        exp.GTE: ("GTE", "LTE"),
                        exp.NEQ: ("NEQ", "NEQ"),
                    }
                    op_l, op_r = op_pair_map[type(comp)]
                    if (op_l, root_r) not in spec_l.col_bounds:
                        spec_l.col_bounds.append((op_l, root_r))
                    if (op_r, root_l) not in spec_r.col_bounds:
                        spec_r.col_bounds.append((op_r, root_l))

        # Transitive closure for sandwich bounds (e.g. start_date <= purchase_date <= end_date)
        for mid_root, mid_spec in list(specs.items()):
            low_bounds = [(op, r) for op, r in mid_spec.col_bounds if op in ("GT", "GTE")]
            high_bounds = [(op, r) for op, r in mid_spec.col_bounds if op in ("LT", "LTE")]
            for op_low, r_low in low_bounds:
                for op_high, r_high in high_bounds:
                    if r_low == r_high:
                        continue
                    strict = (op_low == "GT" or op_high == "LT")
                    fwd_op = "LT" if strict else "LTE"
                    rev_op = "GT" if strict else "GTE"
                    spec_low = specs.setdefault(r_low, ColumnSpec())
                    if spec_low.column is None:
                        _fill_column_metadata(spec_low, r_low, equiv, alias_to_table, schema)
                    spec_high = specs.setdefault(r_high, ColumnSpec())
                    if spec_high.column is None:
                        _fill_column_metadata(spec_high, r_high, equiv, alias_to_table, schema)
                    if (fwd_op, r_high) not in spec_low.col_bounds:
                        spec_low.col_bounds.append((fwd_op, r_high))
                    if (rev_op, r_low) not in spec_high.col_bounds:
                        spec_high.col_bounds.append((rev_op, r_low))
                    if r_low[0] == r_high[0] and spec_low.column and spec_high.column:
                        trans_cls = exp.LT if strict else exp.LTE
                        trans_expr = trans_cls(
                            this=exp.Column(this=spec_low.column.name),
                            expression=exp.Column(this=spec_high.column.name),
                        )
                        cc_low = {"column": spec_low.column.name, "expression": trans_expr}
                        if cc_low not in spec_low.check_exprs:
                            spec_low.check_exprs.append(cc_low)
                        cc_high = {"column": spec_high.column.name, "expression": trans_expr}
                        if cc_high not in spec_high.check_exprs:
                            spec_high.check_exprs.append(cc_high)

    # ── Sub-step 2c: Aggregate join constraints (columns equated to subquery COUNT) ──
    for join in parsed_query.get("joins", []):
        for pair in join.get("agg_pairs", []):
            if pair.get("agg_func") == "COUNT":
                lt = pair["left"]["table"]
                lc = pair["left"]["column"]
                root = equiv.find(col_key(lt, lc))
                spec = specs.setdefault(root, ColumnSpec())
                if spec.column is None:
                    _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                if 1 not in spec.required and not spec.required:
                    spec.required.append(1)

    for pair in parsed_query.get("agg_joins", []):
        if pair.get("agg_func") == "COUNT":
            lt = pair["left"]["table"]
            lc = pair["left"]["column"]
            root = equiv.find(col_key(lt, lc))
            spec = specs.setdefault(root, ColumnSpec())
            if spec.column is None:
                _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
            if 1 not in spec.required and not spec.required:
                spec.required.append(1)

    # ── Sub-step 2d: Conditional aggregate branch predicates (CASE WHEN / IF / FILTER) ──
    # In relational semantics, AGG(CASE WHEN cond THEN expr ELSE NULL END) or
    # AGG(...) FILTER (WHERE cond) acts as a selection operator pushed inside the aggregate.
    # Likewise, queries combining multiple conditional aggregates over distinct branch
    # literals on the same column require rows satisfying each branch condition so that
    # no conditional aggregate evaluates over an empty partition.
    cond_multi_roots: Set[Tuple[str, str]] = set()
    if ast:
        cond_lits_by_root: Dict[Tuple[str, str], List[dict]] = {}
        null_filtered_roots: Set[Tuple[str, str]] = set()

        def _extract_lit_str(node: Optional[exp.Expression]) -> Optional[str]:
            if isinstance(node, exp.Literal):
                return node.name
            if (
                isinstance(node, exp.Neg)
                and isinstance(node.this, exp.Literal)
                and not node.this.is_string
            ):
                return "-" + str(node.this.name)
            return None

        def _extract_cond_eq_lits(
            cond_expr: Optional[exp.Expression],
            is_null_filtered: bool,
            scope_tables: List[str],
        ) -> None:
            if not cond_expr:
                return
            comp_types = (
                exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE,
                exp.Between, exp.In, exp.Like, exp.ILike,
            )
            comp_nodes = ([cond_expr] if isinstance(cond_expr, comp_types) else []) + [
                n for n in cond_expr.find_all(comp_types) if n is not cond_expr
            ]
            for comp in comp_nodes:
                arith_anc = comp.find_ancestor((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod))
                if (
                    arith_anc is not None
                    and arith_anc.find_ancestor((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between)) is not None
                ):
                    continue

                not_cnt = 0
                curr_p = comp.parent
                while curr_p and curr_p is not cond_expr.parent:
                    if isinstance(curr_p, exp.Not):
                        not_cnt += 1
                    curr_p = curr_p.parent
                is_neg = (not_cnt % 2 == 1) ^ bool(comp.args.get("negate"))

                if isinstance(comp, (exp.EQ, exp.Like, exp.ILike)):
                    if is_neg:
                        continue
                    l_node, r_node = comp.left, comp.right
                    l_unwrapped = l_node
                    while isinstance(l_unwrapped, (exp.Cast, exp.TryCast, exp.Paren)):
                        l_unwrapped = l_unwrapped.this
                    r_unwrapped = r_node
                    while isinstance(r_unwrapped, (exp.Cast, exp.TryCast, exp.Paren)):
                        r_unwrapped = r_unwrapped.this

                    expr_side = None
                    lit_node = None
                    if isinstance(r_unwrapped, exp.Literal) and not isinstance(l_unwrapped, exp.Literal):
                        expr_side, lit_node = l_unwrapped, r_unwrapped
                    elif isinstance(l_unwrapped, exp.Literal) and not isinstance(r_unwrapped, exp.Literal):
                        expr_side, lit_node = r_unwrapped, l_unwrapped

                    if expr_side is not None and isinstance(lit_node, exp.Literal):
                        col_node = expr_side if isinstance(expr_side, exp.Column) else None
                        extra_meta: Dict[str, Any] = {}
                        op_str = "LIKE" if isinstance(comp, (exp.Like, exp.ILike)) else "EQ"
                        lit_val = lit_node.name

                        if col_node is None and isinstance(comp, exp.EQ):
                            cols_in_expr = list(expr_side.find_all(exp.Column))
                            if len(cols_in_expr) == 1:
                                temp_meta = _extract_temporal_meta(expr_side)
                                len_meta = _extract_length_meta(expr_side)
                                sub_meta = _extract_substring_meta(expr_side)
                                if temp_meta:
                                    col_node = cols_in_expr[0]
                                    extra_meta.update(temp_meta)
                                elif len_meta:
                                    col_node = cols_in_expr[0]
                                    extra_meta.update(len_meta)
                                elif sub_meta and sub_meta[0] == 1:
                                    col_node = cols_in_expr[0]
                                    if re.match(r"^\d{4}-\d{2}$", str(lit_val).strip()):
                                        lit_val = f"{str(lit_val).strip()}-%"
                                        op_str = "LIKE"

                        if col_node is not None:
                            lit_dict = {
                                "table": col_node.table,
                                "column": col_node.name,
                                "value": lit_val,
                                "operator": op_str,
                                "scope_tables": scope_tables,
                                **extra_meta,
                            }
                            root = _resolve_literal_root(lit_dict, equiv, alias_to_table, schema)
                            cond_lits_by_root.setdefault(root, []).append(lit_dict)
                            if is_null_filtered:
                                null_filtered_roots.add(root)
                elif isinstance(comp, (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)):
                    l_unwrapped = comp.left
                    while isinstance(l_unwrapped, (exp.Cast, exp.TryCast, exp.Paren)):
                        l_unwrapped = l_unwrapped.this
                    r_unwrapped = comp.right
                    while isinstance(r_unwrapped, (exp.Cast, exp.TryCast, exp.Paren)):
                        r_unwrapped = r_unwrapped.this

                    r_lit = _extract_lit_str(r_unwrapped)
                    l_lit = _extract_lit_str(l_unwrapped)
                    expr_side = None
                    lit_val = None
                    col_on_left = True
                    if r_lit is not None and l_lit is None:
                        expr_side, lit_val, col_on_left = l_unwrapped, r_lit, True
                    elif l_lit is not None and r_lit is None:
                        expr_side, lit_val, col_on_left = r_unwrapped, l_lit, False

                    if expr_side is not None and lit_val is not None:
                        col_node = expr_side if isinstance(expr_side, exp.Column) else None
                        extra_meta = {}
                        if col_node is None:
                            cols_in_expr = list(expr_side.find_all(exp.Column))
                            if len(cols_in_expr) == 1:
                                temp_meta = _extract_temporal_meta(expr_side)
                                len_meta = _extract_length_meta(expr_side)
                                if temp_meta:
                                    col_node = cols_in_expr[0]
                                    extra_meta.update(temp_meta)
                                elif len_meta:
                                    col_node = cols_in_expr[0]
                                    extra_meta.update(len_meta)
                        if col_node is not None:
                            op_str = comp.__class__.__name__.upper()
                            if not col_on_left:
                                flip_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "NEQ": "NEQ"}
                                op_str = flip_map.get(op_str, op_str)
                            if is_neg:
                                neg_map = {"GT": "LTE", "GTE": "LT", "LT": "GTE", "LTE": "GT", "NEQ": "EQ"}
                                op_str = neg_map.get(op_str, op_str)
                            lit_dict = {
                                "table": col_node.table,
                                "column": col_node.name,
                                "value": lit_val,
                                "operator": op_str,
                                "scope_tables": scope_tables,
                                **extra_meta,
                            }
                            root = _resolve_literal_root(lit_dict, equiv, alias_to_table, schema)
                            cond_lits_by_root.setdefault(root, []).append(lit_dict)
                            if is_null_filtered:
                                null_filtered_roots.add(root)
                elif isinstance(comp, exp.Between) and not is_neg:
                    b_this = comp.this
                    while isinstance(b_this, (exp.Cast, exp.TryCast, exp.Paren)):
                        b_this = b_this.this
                    low_lit = _extract_lit_str(comp.args.get("low"))
                    high_lit = _extract_lit_str(comp.args.get("high"))
                    if isinstance(b_this, exp.Column) and low_lit is not None and high_lit is not None:
                        for b_op, b_val in (("BETWEENLOWER", low_lit), ("BETWEENUPPER", high_lit)):
                            lit_dict = {
                                "table": b_this.table,
                                "column": b_this.name,
                                "value": b_val,
                                "operator": b_op,
                                "scope_tables": scope_tables,
                            }
                            root = _resolve_literal_root(lit_dict, equiv, alias_to_table, schema)
                            cond_lits_by_root.setdefault(root, []).append(lit_dict)
                            if is_null_filtered:
                                null_filtered_roots.add(root)
                elif isinstance(comp, exp.In) and not is_neg:
                    in_this = comp.this
                    while isinstance(in_this, (exp.Cast, exp.TryCast, exp.Paren)):
                        in_this = in_this.this
                    if isinstance(in_this, exp.Column):
                        col_node = in_this
                        for item in comp.expressions or []:
                            if isinstance(item, exp.Literal):
                                lit_dict = {
                                    "table": col_node.table,
                                    "column": col_node.name,
                                    "value": item.name,
                                    "operator": "IN",
                                    "scope_tables": scope_tables,
                                }
                                root = _resolve_literal_root(lit_dict, equiv, alias_to_table, schema)
                                cond_lits_by_root.setdefault(root, []).append(lit_dict)
                                if is_null_filtered:
                                    null_filtered_roots.add(root)

        for cond_node in ast.find_all((exp.Case, exp.If, exp.Filter)):
            if cond_node.find_ancestor((exp.Where, exp.Having)) is not None:
                continue
            if isinstance(cond_node, exp.If) and isinstance(cond_node.parent, exp.Case):
                continue
            if not isinstance(cond_node, exp.Filter) and cond_node.find_ancestor(exp.AggFunc) is None:
                continue

            enclosing_sel = cond_node.find_ancestor(exp.Select)
            scope_tables = [
                t.alias or t.name
                for t in (enclosing_sel.find_all(exp.Table) if enclosing_sel else [])
                if t.find_ancestor(exp.Select) is enclosing_sel and (t.alias or t.name)
            ]
            in_sum_avg_or_div = (
                cond_node.find_ancestor((exp.Sum, exp.Avg, exp.Div, exp.Mod)) is not None
            )

            if isinstance(cond_node, exp.Case):
                default_expr = cond_node.args.get("default")
                is_zero_default = (
                    isinstance(default_expr, exp.Literal)
                    and str(default_expr.name).strip() in ("0", "0.0")
                )
                is_null_filtered = (
                    default_expr is None
                    or isinstance(default_expr, exp.Null)
                    or (is_zero_default and in_sum_avg_or_div)
                )
                case_operand = cond_node.this
                for if_branch in cond_node.args.get("ifs", []):
                    if isinstance(case_operand, exp.Column) and isinstance(if_branch.this, exp.Literal):
                        syn_eq = exp.EQ(this=case_operand.copy(), expression=if_branch.this.copy())
                        _extract_cond_eq_lits(syn_eq, is_null_filtered, scope_tables)
                    else:
                        _extract_cond_eq_lits(if_branch.this, is_null_filtered, scope_tables)
            elif isinstance(cond_node, exp.If):
                false_expr = cond_node.args.get("false")
                is_zero_false = (
                    isinstance(false_expr, exp.Literal)
                    and str(false_expr.name).strip() in ("0", "0.0")
                )
                is_null_filtered = (
                    false_expr is None
                    or isinstance(false_expr, exp.Null)
                    or (is_zero_false and in_sum_avg_or_div)
                )
                _extract_cond_eq_lits(cond_node.this, is_null_filtered, scope_tables)
            elif isinstance(cond_node, exp.Filter):
                _extract_cond_eq_lits(cond_node.expression, True, scope_tables)

        for agg_node in ast.find_all(exp.AggFunc):
            if agg_node.find_ancestor((exp.Where, exp.Having)) is not None:
                continue
            enclosing_sel = agg_node.find_ancestor(exp.Select)
            scope_tables = [
                t.alias or t.name
                for t in (enclosing_sel.find_all(exp.Table) if enclosing_sel else [])
                if t.find_ancestor(exp.Select) is enclosing_sel and (t.alias or t.name)
            ]
            parent_case = agg_node.find_ancestor(exp.Case)
            is_null_filtered = bool(
                isinstance(agg_node, (exp.Sum, exp.Avg))
                or (
                    parent_case
                    and (
                        parent_case.args.get("default") is None
                        or isinstance(parent_case.args.get("default"), exp.Null)
                        or any(isinstance(b.args.get("true"), exp.Null) for b in parent_case.args.get("ifs", []))
                    )
                )
            )
            agg_cond_anc = agg_node.find_ancestor((exp.Case, exp.If, exp.Filter))
            for comp in agg_node.find_all((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between, exp.In, exp.Like, exp.ILike)):
                if comp.find_ancestor((exp.Case, exp.If, exp.Filter)) is agg_cond_anc:
                    if comp.find_ancestor(exp.Select) is enclosing_sel:
                        _extract_cond_eq_lits(comp, is_null_filtered, scope_tables)

        for root, lit_list in cond_lits_by_root.items():
            distinct_vals = {lit["value"] for lit in lit_list if lit.get("value") != "NULL"}
            if root not in null_filtered_roots and len(distinct_vals) <= 1:
                continue
            spec = specs.setdefault(root, ColumnSpec())
            if spec.column is None:
                _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
            if spec.required or spec.lower is not None or spec.upper is not None:
                continue
            for lit in lit_list:
                _apply_literal_to_spec(spec, lit)
            if spec.lower is not None and spec.upper is not None:
                try:
                    s_low, s_up = str(spec.lower), str(spec.upper)
                    if s_low.lstrip("-").replace(".", "", 1).isdigit() and s_up.lstrip("-").replace(".", "", 1).isdigit():
                        if float(s_low) > float(s_up):
                            spec.lower = None
                            spec.upper = None
                    elif s_low > s_up:
                        spec.lower = None
                        spec.upper = None
                except Exception:
                    pass
            if len(spec.required) > 1:
                cond_multi_roots.add(root)

        # ── Sub-step 2e: Self-offset column/aggregate comparisons (e.g. (min_col + 1) = col, DATE(min_col + 1)) ──
        for pat in extract_self_offset_patterns(schema, parsed_query, ast):
            t_name_pat = pat["table"]
            c_name_pat = pat["column"]
            offset_vals = compute_self_offset_values(
                schema, t_name_pat, c_name_pat, pat["offset"], pat["date_func"]
            )
            sat_pair = offset_vals["satisfying_pair"]
            for alias, t_name in alias_to_table.items():
                if t_name.upper() == t_name_pat.upper():
                    root = equiv.find(col_key(alias, c_name_pat))
                    spec = specs.setdefault(root, ColumnSpec())
                    if spec.column is None:
                        _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                    if not spec.required and spec.lower is None and spec.upper is None:
                        spec.required = list(sat_pair)
                        cond_multi_roots.add(root)

        # ── Sub-step 2e-bis: Additive sum equality comparisons (e.g. a.col + b.col = C) ──
        for sum_pat in extract_additive_sum_patterns(schema, parsed_query, ast):
            sum_vals = compute_additive_sum_values(schema, sum_pat)
            prim_pair = sum_vals["primary_pair"]
            if sum_pat["is_self_sum"]:
                t_name_pat = sum_pat["left_table"]
                c_name_pat = sum_pat["left_column"]
                for alias, t_name in alias_to_table.items():
                    if t_name.upper() == t_name_pat.upper():
                        root = equiv.find(col_key(alias, c_name_pat))
                        spec = specs.setdefault(root, ColumnSpec())
                        if spec.column is None:
                            _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                        if not spec.required and spec.lower is None and spec.upper is None:
                            spec.required = list(prim_pair)
                            cond_multi_roots.add(root)
            else:
                for (t_side, c_side), v_side in (
                    ((sum_pat["left_table"], sum_pat["left_column"]), prim_pair[0]),
                    ((sum_pat["right_table"], sum_pat["right_column"]), prim_pair[1]),
                ):
                    for alias, t_name in alias_to_table.items():
                        if t_name.upper() == t_side.upper():
                            root = equiv.find(col_key(alias, c_side))
                            spec = specs.setdefault(root, ColumnSpec())
                            if spec.column is None:
                                _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                            if not spec.required and spec.lower is None and spec.upper is None:
                                spec.required = [v_side]

        # ── Sub-step 2f: Temporal difference predicates (e.g. (JULIANDAY(ref) - JULIANDAY(col)) / 365 >= 35, STRFTIME('%Y', ref) - STRFTIME('%Y', col) >= 35) ──
        for pat in extract_temporal_diff_patterns(schema, parsed_query, ast):
            if not pat.get("from_comparison", True):
                continue
            t_name_pat = pat["table"]
            c_name_pat = pat["column"]
            ref_t_pat = pat.get("ref_table")
            ref_c_pat = pat.get("ref_column")
            diff_vals = compute_temporal_diff_values(schema, pat)
            sat_date = diff_vals["satisfying_date"]
            ref_date = pat["ref_dt"].strftime("%Y-%m-%d")

            if (
                ref_t_pat
                and ref_c_pat
                and ref_t_pat.upper() == t_name_pat.upper()
                and ref_c_pat.upper() == c_name_pat.upper()
            ):
                for alias, t_name in alias_to_table.items():
                    if t_name.upper() == t_name_pat.upper():
                        root = equiv.find(col_key(alias, c_name_pat))
                        spec = specs.setdefault(root, ColumnSpec())
                        if spec.column is None:
                            _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                        spec.is_temporal = True
                        if not spec.required and spec.lower is None and spec.upper is None:
                            spec.required = [ref_date, sat_date]
                            cond_multi_roots.add(root)
                continue

            if ref_t_pat and ref_c_pat:
                for alias, t_name in alias_to_table.items():
                    if t_name.upper() == ref_t_pat.upper():
                        ref_root = equiv.find(col_key(alias, ref_c_pat))
                        ref_spec = specs.setdefault(ref_root, ColumnSpec())
                        if ref_spec.column is None:
                            _fill_column_metadata(ref_spec, ref_root, equiv, alias_to_table, schema)
                        ref_spec.is_temporal = True
                        if not ref_spec.required and ref_spec.lower is None and ref_spec.upper is None:
                            ref_spec.required = [ref_date]

            for alias, t_name in alias_to_table.items():
                if t_name.upper() == t_name_pat.upper():
                    root = equiv.find(col_key(alias, c_name_pat))
                    spec = specs.setdefault(root, ColumnSpec())
                    if spec.column is None:
                        _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                    spec.is_temporal = True
                    if not spec.required and spec.lower is None and spec.upper is None:
                        spec.required = [sat_date]

        # ── Sub-step 2g: Scaled division / ratio comparison predicates (e.g. CAST(x AS REAL) * 100 / y < 0.18) ──
        ratio_pats_by_pair: Dict[Tuple[str, str, str, str, str], List[Dict[str, Any]]] = {}
        for r_pat in extract_ratio_comparison_patterns(schema, parsed_query, ast):
            pair_key = (
                r_pat["num_table"].upper(),
                r_pat["num_column"].upper(),
                r_pat["denom_table"].upper(),
                r_pat["denom_column"].upper(),
                r_pat["mode"],
            )
            ratio_pats_by_pair.setdefault(pair_key, []).append(r_pat)

        for pair_pats in ratio_pats_by_pair.values():
            eff_pat = dict(pair_pats[0])
            if len(pair_pats) > 1:
                lows = [p["ratio"] for p in pair_pats if p["op"] in ("GT", "GTE")]
                highs = [p["ratio"] for p in pair_pats if p["op"] in ("LT", "LTE")]
                if lows and highs and max(lows) < min(highs):
                    eff_pat["ratio"] = (max(lows) + min(highs)) / 2
                    eff_pat["op"] = "BETWEEN"

            ratio_vals = compute_ratio_comparison_values(schema, eff_pat)
            num_val = ratio_vals["num_val"]
            denom_val = ratio_vals["denom_val"]

            num_roots = [
                equiv.find(col_key(alias, eff_pat["num_column"]))
                for alias, t_name in alias_to_table.items()
                if t_name.upper() == eff_pat["num_table"].upper()
            ]
            denom_roots = [
                equiv.find(col_key(alias, eff_pat["denom_column"]))
                for alias, t_name in alias_to_table.items()
                if t_name.upper() == eff_pat["denom_table"].upper()
            ]
            for n_root in set(num_roots):
                n_spec = specs.setdefault(n_root, ColumnSpec())
                if n_spec.column is None:
                    _fill_column_metadata(n_spec, n_root, equiv, alias_to_table, schema)
                if not n_spec.required:
                    n_ok = True
                    try:
                        if n_spec.lower is not None and float(num_val) <= float(n_spec.lower):
                            n_ok = False
                        if n_spec.upper is not None and float(num_val) >= float(n_spec.upper):
                            n_ok = False
                    except (ValueError, TypeError):
                        pass
                    if n_ok:
                        n_spec.required = [num_val]
                        n_spec.lower = None
                        n_spec.upper = None

            for d_root in set(denom_roots):
                d_spec = specs.setdefault(d_root, ColumnSpec())
                if d_spec.column is None:
                    _fill_column_metadata(d_spec, d_root, equiv, alias_to_table, schema)
                if not d_spec.required:
                    d_ok = True
                    try:
                        if d_spec.lower is not None and float(denom_val) <= float(d_spec.lower):
                            d_ok = False
                        if d_spec.upper is not None and float(denom_val) >= float(d_spec.upper):
                            d_ok = False
                    except (ValueError, TypeError):
                        pass
                    if d_ok:
                        d_spec.required = [denom_val]
                        d_spec.lower = None
                        d_spec.upper = None

    # ── Sub-step 2b: Complex predicates (arithmetic expressions) via Z3 ──
    # If the WHERE/HAVING/JOIN-ON contains arithmetic or literal value constraints
    # (e.g. a.x + b.y > 10), invoke the Z3 solver to find satisfying assignments.
    _value_or_arith_types = (exp.Literal, exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod, exp.Neg)
    where_ast = parsed_query.get("where_ast")
    having_ast = parsed_query.get("having_ast")
    has_complex_expr = (
        bool(where_ast and list(where_ast.find_all(_value_or_arith_types))) or
        bool(having_ast and list(having_ast.find_all(_value_or_arith_types))) or
        any(
            join_node.args.get("on")
            and bool(list(join_node.args.get("on").find_all((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ))))
            and bool(list(join_node.args.get("on").find_all(_value_or_arith_types)))
            for join_node in (parsed_query.get("ast").find_all(exp.Join) if parsed_query.get("ast") else [])
        )
    )
    # ── Sub-step 4a: Compute initial min_row_count from Z3 solution ──
    min_row_count = 1
    if has_complex_expr:
        try:
            z3_solution = solve_query_constraints(schema, parsed_query, alias_to_table)
            if z3_solution:
                has_row_count = "ROW_COUNT" in z3_solution
                if has_row_count and isinstance(z3_solution["ROW_COUNT"], int):
                    min_row_count = max(min_row_count, z3_solution["ROW_COUNT"])
                for key, val in z3_solution.items():
                    if key == "ROW_COUNT" or not isinstance(key, tuple) or len(key) != 2:
                        continue
                    alias, col_name = key
                    root = equiv.find(col_key(alias, col_name))
                    spec = specs.setdefault(root, ColumnSpec())
                    if spec.column is None:
                        _fill_column_metadata(spec, root, equiv, alias_to_table, schema)
                    if val is not None and val not in spec.required:
                        bounds_ok = val not in spec.disallowed
                        if bounds_ok and not has_row_count and spec.is_valid_range():
                            if spec.lower is not None:
                                try:
                                    if float(val) < float(spec.lower):
                                        bounds_ok = False
                                except (ValueError, TypeError):
                                    if str(val) < str(spec.lower):
                                        bounds_ok = False
                            if bounds_ok and spec.upper is not None:
                                try:
                                    if float(val) > float(spec.upper):
                                        bounds_ok = False
                                except (ValueError, TypeError):
                                    if str(val) > str(spec.upper):
                                        bounds_ok = False
                        # Add solved value if no explicit requirement exists yet or for arithmetic columns
                        if bounds_ok and (not spec.required or spec.lower is not None or spec.upper is not None):
                            spec.required.append(val)
                            if has_row_count:
                                spec.lower = None
                                spec.upper = None
        except Exception as e:
            logger.debug(f"Z3 solving in build_column_specs skipped: {e}")

    # ── Mark specs that originate from subquery predicates ──
    # (influences padding strategy: subquery columns get distinct values)
    _mark_subquery_specs(specs, parsed_query, equiv, alias_to_table, schema)

    # ── Sub-step 3: Query structure flags ──
    # GROUP BY columns → is_group_key (repeat values to form groups)
    # COUNT(DISTINCT col) columns → must_be_unique (all values distinct)
    _collect_group_by_roots(specs, parsed_query, equiv, alias_to_table)
    _collect_distinct_count_roots(specs, parsed_query, equiv, alias_to_table, schema)

    # ── Sub-step 4b: Refine min_row_count from HAVING, LIMIT/OFFSET, window offsets, subqueries ──
    # HAVING COUNT(*)>=N requires at least N rows; LIMIT M OFFSET K requires
    # K+M+3 rows; LEAD/LAG(k) requires k+1 rows; subquery inequalities need ≥3 rows.
    having_min, forbidden_counts = _extract_count_bounds(parsed_query)
    min_row_count = max(min_row_count, having_min)
    min_row_count = max(
        min_row_count,
        _extract_limit_offset_row_count(parsed_query, include_limit_padding=include_limit_padding),
    )
    min_row_count = max(min_row_count, _extract_window_offset_row_count(parsed_query))
    if _has_subquery_inequality(parsed_query):
        min_row_count = max(min_row_count, 3)
    if min_row_count in forbidden_counts:
        if min_row_count > 1 and (min_row_count - 1) >= having_min and (min_row_count - 1) not in forbidden_counts:
            min_row_count -= 1
        else:
            while min_row_count in forbidden_counts:
                min_row_count += 1

    # ── Sub-step 5: Parameter overrides (attack strategy injections) ──
    # External callers can force specific values for specific columns.
    # This overrides any previously collected constraints for that class.
    # When a scalar value is injected for a table that appears under multiple
    # non-equated self-join aliases on a unique/PK or strictly unequal column,
    # apply the scalar requirement to the primary alias root and disallow the
    # duplicate value on sibling roots so self-joins do not collapse into 1 row.
    if value_injections:
        strict_ineq_root_pairs: Set[Tuple[Tuple[str, str], Tuple[str, str]]] = set()
        if ast:
            for comp in ast.find_all((exp.NEQ, exp.LT, exp.GT)):
                if isinstance(comp.left, exp.Column) and isinstance(comp.right, exp.Column):
                    lt = _resolve_col_alias_in_scope(comp.left)
                    rt = _resolve_col_alias_in_scope(comp.right)
                    if lt in alias_to_table and rt in alias_to_table:
                        rl = equiv.find(col_key(lt, comp.left.name))
                        rr = equiv.find(col_key(rt, comp.right.name))
                        if rl != rr:
                            strict_ineq_root_pairs.add((rl, rr))
                            strict_ineq_root_pairs.add((rr, rl))

        for (tbl, col_name), val in value_injections.items():
            if isinstance(val, (list, tuple)):
                min_row_count = max(min_row_count, len(val))
            distinct_roots: List[Tuple[str, str]] = []
            for alias, t_name in alias_to_table.items():
                if t_name.upper() == tbl.upper():
                    root = equiv.find(col_key(alias, col_name))
                    if root not in distinct_roots:
                        distinct_roots.append(root)

            if isinstance(val, (list, tuple)) or len(distinct_roots) <= 1:
                for root in distinct_roots:
                    spec = specs.setdefault(root, ColumnSpec())
                    if isinstance(val, (list, tuple)):
                        spec.required = list(val)
                    else:
                        spec.required = [val]
                    spec.lower = None
                    spec.upper = None
                    spec.col_bounds = []
            else:
                first_root = distinct_roots[0]
                first_spec = specs.setdefault(first_root, ColumnSpec())
                has_strict_ineq = any(
                    (r1, r2) in strict_ineq_root_pairs
                    for r1 in distinct_roots
                    for r2 in distinct_roots
                    if r1 != r2
                )
                if first_spec.must_be_unique or has_strict_ineq:
                    first_spec.required = [val]
                    first_spec.lower = None
                    first_spec.upper = None
                    first_spec.col_bounds = []
                    for other_root in distinct_roots[1:]:
                        other_spec = specs.setdefault(other_root, ColumnSpec())
                        other_spec.disallowed.add(val)
                        other_spec.required = [v for v in other_spec.required if v != val]
                else:
                    for root in distinct_roots:
                        spec = specs.setdefault(root, ColumnSpec())
                        spec.required = [val]
                        spec.lower = None
                        spec.upper = None
                        spec.col_bounds = []

    for root in cond_multi_roots:
        spec = specs.get(root)
        if spec and len(spec.required) > 1:
            min_row_count = max(min_row_count, len(spec.required))

    # When a self-joined table has a PK/UNIQUE column with a shared multi-row `required`
    # sequence across its aliases (e.g. from a self-offset comparison like `ABS(a.id - b.id) = 1`),
    # the first alias materializes all rows for those PK/UNIQUE values while subsequent aliases
    # are deduplicated on PK/UNIQUE. Synchronize any per-alias single-value `required` specs
    # on other columns of the same table into a multi-row sequence `[v_a, v_b, ...]` so each
    # materialized row receives the required value of its corresponding self-join alias.
    aliases_by_table: Dict[str, List[str]] = {}
    for alias, t_name in alias_to_table.items():
        table_key = schema.find_table(t_name)
        if table_key:
            aliases_by_table.setdefault(table_key, []).append(alias)

    for table_key, same_aliases in aliases_by_table.items():
        if len(same_aliases) <= 1:
            continue
        t_obj = schema.tables[table_key]
        unique_cols = [c for c in t_obj.columns if c.is_primary_key or c.is_unique]
        has_shared_multi_unique = False
        for u_col in unique_cols:
            u_reqs = [
                specs[equiv.find(col_key(a, u_col.name))].required
                for a in same_aliases
                if equiv.find(col_key(a, u_col.name)) in specs
            ]
            if (
                len(u_reqs) == len(same_aliases)
                and len(u_reqs[0]) >= len(same_aliases)
                and all(r == u_reqs[0] for r in u_reqs[1:])
            ):
                has_shared_multi_unique = True
                break
        if not has_shared_multi_unique:
            continue

        for col in t_obj.columns:
            if col.is_primary_key or col.is_unique:
                continue
            alias_roots = [equiv.find(col_key(a, col.name)) for a in same_aliases]
            alias_specs = [specs.get(r) for r in alias_roots]
            if all(s is not None and len(s.required) == 1 for s in alias_specs):
                per_alias_vals = [s.required[0] for s in alias_specs]
                if len({str(v) for v in per_alias_vals}) > 1:
                    for s in alias_specs:
                        s.required = list(per_alias_vals)
                    min_row_count = max(min_row_count, len(per_alias_vals))

    # Ensure sibling FK columns referencing the same parent column do not accidentally
    # receive identical values when one sibling has explicit required values and the
    # other is in a separate equivalence class.
    for alias, t_name in alias_to_table.items():
        table_key = schema.find_table(t_name)
        if not table_key:
            continue
        fks_by_target: Dict[Tuple[str, str], List[str]] = {}
        for fk in schema.tables[table_key].foreign_keys:
            ref_t = schema.find_table(fk.reference_table) or fk.reference_table
            fks_by_target.setdefault((ref_t.upper(), fk.reference_column.upper()), []).append(fk.column_name)
        for fk_cols in fks_by_target.values():
            if len(fk_cols) > 1:
                for c1 in fk_cols:
                    r1 = equiv.find(col_key(alias, c1))
                    spec1 = specs.get(r1)
                    if not spec1 or not spec1.required:
                        continue
                    for c2 in fk_cols:
                        if c1.upper() == c2.upper():
                            continue
                        r2 = equiv.find(col_key(alias, c2))
                        if r1 != r2:
                            spec2 = specs.setdefault(r2, ColumnSpec())
                            for req_v in spec1.required:
                                if req_v is not None and req_v not in spec2.required:
                                    spec2.disallowed.add(req_v)

    return specs, min_row_count


# Backward-compatibility alias
build_column_specs = analyze_constraints_and_cardinality
