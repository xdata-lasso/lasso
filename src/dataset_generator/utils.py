"""
General-Purpose Utilities
===========================

Helper functions for alias resolution, column lookup, and generating
distinct values.  These are used by attack strategies and are not tied
to any specific pipeline phase.
"""

from datetime import datetime, timedelta
from fractions import Fraction
import math
import re
import sqlite3
from typing import Any, Dict, List, Optional, Set, Tuple

from dateutil.parser import parse as parse_date
import sqlglot.expressions as exp

from dataset_generator.value_generator import (
    coerce_literal_for_column,
    generate_unique_value_for_column,
    generate_unique_string_for_column,
    generate_unique_id_for_column,
    synthesize_string_of_length,
    value_matching_like_pattern,
)
from dataset_generator.constraint_solver import (
    solve_check_constraint_value,
)
from dataset_generator.types import SymbolTable, UnionFind, col_key
from models import Column, Schema
from parser import _extract_substring_meta


def build_alias_to_table(parsed_query: Dict[str, Any]) -> Dict[str, str]:
    """Build a mapping of table aliases to actual table names from parsed query."""
    alias_to_table: Dict[str, str] = {}
    for table in parsed_query.get("tables", []):
        if table.get("alias"):
            alias_to_table[table["alias"].upper()] = table["name"]
        if table.get("name"):
            alias_to_table[table["name"].upper()] = table["name"]
    return alias_to_table


def safe_min(a, b):
    if type(a) == type(b): return min(a, b)
    try:
        return min(float(a), float(b))
    except (ValueError, TypeError):
        return min(str(a), str(b))

def safe_max(a, b):
    if type(a) == type(b): return max(a, b)
    try:
        return max(float(a), float(b))
    except (ValueError, TypeError):
        return max(str(a), str(b))


def find_column_equivalence_roots(
    ast_node: Optional[exp.Expression],
    equiv: UnionFind,
    alias_to_table: Dict[str, str],
) -> List[Tuple[str, str]]:
    """
    Find all column references under `ast_node` and resolve their UnionFind roots.

    For each exp.Column found in ast_node, checks table_alias (or all query aliases)
    and collects unique equivalence class roots.
    """
    roots: List[Tuple[str, str]] = []
    seen: Set[Tuple[str, str]] = set()
    if not ast_node:
        return roots
    for node in ast_node.walk():
        actual = node[0] if isinstance(node, tuple) else node
        if isinstance(actual, exp.Column):
            t_alias = actual.table
            col_name = actual.name
            tables_to_check = (
                [t_alias]
                if (t_alias and t_alias.upper() in alias_to_table)
                else list(alias_to_table.keys())
            )
            for t in tables_to_check:
                root = equiv.find(col_key(t, col_name))
                if root not in seen:
                    seen.add(root)
                    roots.append(root)
    return roots


def _find_projected_value_column(select_expr: exp.Expression) -> Optional[exp.Column]:
    """
    Find the underlying value column projected by `select_expr`, ignoring columns
    that only appear inside conditional predicates (`CASE WHEN cond`, `IIF(cond, ...)`,
    or boolean comparisons like `SUM(col = 'A')`).
    """
    pred_types = (
        exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE,
        exp.In, exp.Between, exp.Like, exp.ILike, exp.Is,
    )
    for col in select_expr.find_all(exp.Column):
        in_condition = False
        curr: Optional[exp.Expression] = col
        while curr and curr is not select_expr:
            p = curr.parent
            if not p:
                break
            if isinstance(p, (exp.When, exp.If)) and p.this is curr:
                in_condition = True
                break
            if isinstance(p, pred_types):
                in_condition = True
                break
            curr = p
        if not in_condition:
            return col
    return None


def resolve_query_column(
    schema: Schema, parsed_query: Dict[str, Any],
    table_or_alias: str, column_name: str,
    visited: Optional[Set[Tuple[str, str]]] = None,
    symbol_table: Optional[SymbolTable] = None,
) -> Optional[Tuple[str, str]]:
    """
    Resolve a (table_or_alias, column_name) reference to a concrete
    (schema_table_name, column_name) pair.

    Handles:
      - Fast O(1) lookup via pre-computed SymbolTable
      - Direct alias → table mapping
      - Subquery / CTE alias tracing (follows projection aliases down
        to the base column)
      - Unqualified column names (searches all query tables)

    Uses ``visited`` to prevent infinite loops in recursive CTE resolution.

    Returns:
        (schema_table_name, column_name) or None if unresolvable.
    """
    key = col_key(table_or_alias, column_name)
    if symbol_table:
        cached = symbol_table.get(key)
        if cached:
            return cached

    if visited is None:
        visited = set()
    if key in visited:
        return None
    visited.add(key)

    a2t = build_alias_to_table(parsed_query)
    if table_or_alias:
        table_name = a2t.get(table_or_alias.upper(), table_or_alias)
        st = schema.find_table(table_name)
        if st:
            col = schema.find_column(st, column_name)
            if col:
                return st, col.name

        # Trace subquery or CTE aliases
        ast = parsed_query.get("ast")
        if ast:
            for sq in ast.find_all((exp.Subquery, exp.CTE, exp.Table)):
                sq_alias = sq.alias or (
                    sq.this.alias if hasattr(sq, "this") and hasattr(sq.this, "alias") else None
                )
                if sq_alias and sq_alias.upper() in (table_or_alias.upper(), table_name.upper()):
                    sub_select = sq.this if isinstance(sq.this, exp.Select) else sq.find(exp.Select)
                    if sub_select:
                        for select_expr in sub_select.selects:
                            proj_alias = select_expr.alias_or_name
                            if proj_alias.upper() == column_name.upper():
                                base_col = _find_projected_value_column(select_expr)
                                if base_col:
                                    sub_tbl = base_col.table or ""
                                    if not sub_tbl:
                                        sub_tables = [t.alias or t.name for t in sub_select.find_all(exp.Table)]
                                        if sub_tables:
                                            sub_tbl = sub_tables[0]
                                    return resolve_query_column(
                                        schema, parsed_query, sub_tbl, base_col.name, visited
                                    )
                        if any(
                            isinstance(e, exp.Star) or (isinstance(e, exp.Column) and isinstance(e.this, exp.Star))
                            for e in sub_select.selects
                        ):
                            for t in sub_select.find_all(exp.Table):
                                sub_tbl = t.alias or t.name
                                res = resolve_query_column(schema, parsed_query, sub_tbl, column_name, visited)
                                if res:
                                    return res
        return None

    # No table specified: search all query tables
    matches = []
    query_tables = [t["name"] for t in parsed_query.get("tables", [])]
    for t_name in query_tables:
        st = schema.find_table(t_name)
        if st:
            col = schema.find_column(st, column_name)
            if col:
                matches.append((st, col.name))
    if matches:
        return matches[0]

    # No table specified and not found in base tables: check SELECT/subquery/CTE projection aliases
    for s in parsed_query.get("selects", []):
        if s.get("alias") and s["alias"].upper() == column_name.upper() and s.get("column"):
            res = resolve_query_column(schema, parsed_query, s.get("table", ""), s["column"], visited)
            if res:
                return res

    ast = parsed_query.get("ast")
    if ast:
        for sq in ast.find_all((exp.Subquery, exp.CTE)):
            sub_select = sq.this if isinstance(sq.this, exp.Select) else sq.find(exp.Select)
            if sub_select:
                for select_expr in sub_select.selects:
                    proj_alias = select_expr.alias_or_name
                    if proj_alias and proj_alias.upper() == column_name.upper():
                        base_col = _find_projected_value_column(select_expr)
                        if base_col:
                            sub_tbl = base_col.table or ""
                            if not sub_tbl:
                                sub_tables = [t.alias or t.name for t in sub_select.find_all(exp.Table)]
                                if sub_tables:
                                    sub_tbl = sub_tables[0]
                            res = resolve_query_column(schema, parsed_query, sub_tbl, base_col.name, visited)
                            if res:
                                return res

    return None


def next_distinct_value(
    column: Column, existing_value: Any,
    schema: Schema = None, table_name: str = None,
) -> Any:
    """
    Generate a single value that is distinct from ``existing_value``.

    Dispatches on column type: text → unique string, temporal → unique date,
    float → +0.05 or +1.0, int → +1, other → unique ID.

    If schema and table_name are provided, the result is further refined
    via ``solve_check_constraint_value`` to satisfy CHECK constraints.
    """
    candidate = None
    if column.is_text:
        candidate = generate_unique_string_for_column(column)
        while candidate == existing_value:
            candidate = generate_unique_string_for_column(column)
    elif column.is_temporal:
        try:
            if existing_value is not None:
                d = parse_date(str(existing_value))
                candidate = (d + timedelta(days=1)).strftime("%Y-%m-%d")
            else:
                candidate = "0001-01-01"
        except Exception:
            candidate = "0001-01-02" if str(existing_value) == "0001-01-01" else "0001-01-01"
    elif isinstance(existing_value, float):
        if 0.0 < existing_value < 1.0:
            candidate = round(existing_value + 0.05, 2)
        else:
            candidate = existing_value + 1.0
    elif isinstance(existing_value, int):
        candidate = existing_value + 1
    else:
        candidate = generate_unique_id_for_column(column)

    if schema and table_name:
        candidate = solve_check_constraint_value(
            schema, table_name, column.name, column,
            candidate, disallowed_values={existing_value},
        )
    return candidate


def next_distinct_query_value(
    schema: Schema,
    parsed_query: Optional[Dict[str, Any]],
    table_name: str,
    column: Column,
    existing_value: Any,
    disallowed_values: Optional[Set[Any]] = None,
) -> Any:
    """
    Generate a value distinct from `existing_value` (and `disallowed_values`) that
    respects query-level `SUBSTRING` / `STRFTIME` / `LIKE` / range constraints on
    `(table_name, column.name)` while varying any unconstrained character slices or
    date components referenced in `SELECT`, `GROUP BY`, or `ORDER BY`.
    """
    forbidden: Set[Any] = {existing_value}
    if disallowed_values:
        forbidden.update(disallowed_values)

    if parsed_query:
        target_pair = (table_name.upper(), column.name.upper())
        col_lits: List[dict] = []
        for lit in parsed_query.get("where_literals", []):
            res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res_lit and (res_lit[0].upper(), res_lit[1].upper()) == target_pair:
                col_lits.append(lit)

        substr_eq_lits = [
            lit for lit in col_lits
            if lit.get("substr_start") is not None
            and int(lit["substr_start"]) >= 1
            and (lit.get("operator") or "EQ").upper() in ("EQ", "IN")
            and lit.get("value") != "NULL"
        ]
        if substr_eq_lits:
            fixed_cmap: Dict[int, str] = {}
            for lit in substr_eq_lits:
                st_p = int(lit["substr_start"])
                ln_p = lit.get("substr_length")
                sv = str(lit["value"])
                if ln_p is not None and int(ln_p) >= 0:
                    sv = sv[: int(ln_p)]
                for idx_c, ch in enumerate(sv):
                    fixed_cmap[(st_p - 1) + idx_c] = ch

            free_blocks: List[List[int]] = []
            ast = parsed_query.get("ast")
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
                    res_sub = resolve_query_column(
                        schema, parsed_query, cols_in_sub[0].table, cols_in_sub[0].name
                    )
                    if not res_sub or (res_sub[0].upper(), res_sub[1].upper()) != target_pair:
                        continue
                    s_pos, s_len = int(sub_meta[0]), sub_meta[1]
                    eff_len = int(s_len) if (s_len is not None and int(s_len) > 0) else 2
                    block = [p for p in range(s_pos - 1, s_pos - 1 + eff_len) if p not in fixed_cmap]
                    if block and block not in free_blocks:
                        free_blocks.append(block)

            if not free_blocks and fixed_cmap:
                max_fixed = max(fixed_cmap.keys())
                free_blocks.append([max_fixed + 1, max_fixed + 2])

            if free_blocks:
                dt_str = (column.data_type or "").lower()
                m_lim = re.search(r"(?:(?:var)?char|character\s+varying|text)\s*\((\d+)\)", dt_str)
                char_limit = int(m_lim.group(1)) if m_lim else None
                orig_str = str(existing_value) if existing_value is not None else ""

                for k in range(1, 50):
                    cmap_k = dict(fixed_cmap)
                    for block in free_blocks:
                        b_len = len(block)
                        tok = f"{k:0{b_len}d}"[-b_len:]
                        for idx_p, pos in enumerate(block):
                            cmap_k[pos] = tok[idx_p]
                    max_idx = max(cmap_k.keys())
                    cand = "".join(cmap_k.get(i, "_") for i in range(max_idx + 1))
                    if char_limit is not None and len(cand) > char_limit:
                        cand = cand[:char_limit]
                    if cand in forbidden:
                        continue
                    if orig_str and any(
                        "".join(cand[p] if p < len(cand) else "" for p in block)
                        == "".join(orig_str[p] if p < len(orig_str) else "" for p in block)
                        for block in free_blocks
                    ):
                        continue
                    checked = solve_check_constraint_value(
                        schema, table_name, column.name, column, cand, disallowed_values=forbidden
                    )
                    if checked not in forbidden:
                        return checked

        strftime_eq_lits = [
            lit for lit in col_lits
            if lit.get("strftime_format")
            and (lit.get("operator") or "EQ").upper() in ("EQ", "IN")
            and lit.get("value") != "NULL"
        ]
        if strftime_eq_lits:
            fmt = strftime_eq_lits[0]["strftime_format"]
            base_dt = _try_parse_iso_datetime(str(existing_value)) or datetime(2020, 1, 1)
            out_fmt = "%Y-%m-%d %H:%M:%S" if ":" in str(existing_value) else "%Y-%m-%d"
            for step in range(1, 25):
                if fmt == "%Y":
                    new_m = ((base_dt.month - 1 + step) % 12) + 1
                    new_d = ((base_dt.day - 1 + step) % 28) + 1
                    cand_dt = base_dt.replace(month=new_m, day=new_d)
                elif fmt == "%m":
                    new_d = ((base_dt.day - 1 + step) % 28) + 1
                    cand_dt = _safe_replace_year(base_dt, base_dt.year + step).replace(day=new_d)
                elif fmt == "%d":
                    new_m = ((base_dt.month - 1 + step) % 12) + 1
                    cand_dt = _safe_replace_year(base_dt, base_dt.year + step).replace(month=new_m)
                elif fmt == "%Y-%m":
                    new_d = ((base_dt.day - 1 + step) % 28) + 1
                    cand_dt = base_dt.replace(day=new_d)
                else:
                    break
                cand_str = cand_dt.strftime(out_fmt)
                if cand_str not in forbidden:
                    return cand_str

        like_lits = [
            lit for lit in col_lits
            if (lit.get("operator") or "").upper() in ("LIKE", "ILIKE")
            and isinstance(lit.get("value"), str)
            and ("%" in lit["value"] or "_" in lit["value"])
        ]
        if like_lits:
            pat = str(like_lits[0]["value"])
            for k in range(1, 30):
                cand_like = pat.replace("%", f"{k:02d}").replace("_", str(k % 9 + 1))
                if cand_like not in forbidden:
                    return cand_like

        length_lits = [
            lit for lit in col_lits
            if lit.get("is_length_expr") and lit.get("value") not in (None, "NULL")
        ]
        if length_lits:
            base_len = len(str(existing_value)) if existing_value is not None else 0
            if base_len <= 0:
                try:
                    raw_n = int(float(length_lits[0]["value"]))
                    offset = int(length_lits[0].get("length_offset") or 0)
                    op_up = (length_lits[0].get("operator") or "EQ").upper()
                    base_len = max(1, (raw_n + 1 if op_up == "GT" else raw_n) + offset)
                except (ValueError, TypeError):
                    base_len = 5
            for _ in range(25):
                cand_len_str = synthesize_string_of_length(column, base_len)
                checked = solve_check_constraint_value(
                    schema, table_name, column.name, column, cand_len_str, disallowed_values=forbidden
                )
                if checked not in forbidden:
                    return checked

    cand = next_distinct_value(column, existing_value, schema=schema, table_name=table_name)
    attempts = 0
    while cand in forbidden and attempts < 20:
        attempts += 1
        cand = next_distinct_value(column, cand, schema=schema, table_name=table_name)
    return cand


def is_unique_column_set(schema: Schema, table_name: str, col_names: List[str]) -> bool:
    """
    Determines whether a set of column names `col_names` forms a unique key (superkey)
    for `table_name` in `schema`.
    
    A column set `J` forms a unique key IF AND ONLY IF:
    1. The table has a Primary Key `PK`, and ALL columns of `PK` are present in `J`.
       (If `PK` is composite, e.g. (ID, Date), `J` must contain all composite columns).
    2. OR, `J` contains any column that has a standalone UNIQUE constraint (`c.is_unique`).
    """
    table = schema.tables.get(table_name)
    if not table:
        return False
        
    cols_upper = {c.upper() for c in col_names}
    if not cols_upper:
        return False
        
    pk_cols = [c.name.upper() for c in table.columns if c.is_primary_key]
    if pk_cols and set(pk_cols).issubset(cols_upper):
        return True
        
    for c in table.columns:
        if c.is_unique and c.name.upper() in cols_upper:
            return True
            
    return False


def extract_self_offset_patterns(
    schema: Schema,
    parsed_query: Dict[str, Any],
    scope_node: Optional[exp.Expression] = None,
) -> List[Dict[str, Any]]:
    """
    Identify relational self-offset comparisons where two references to the same
    base column `(table_name, col_name)` (either via self-join aliases or derived-table /
    subquery aggregate projections such as `MIN(col)` / `MAX(col)`) are equated with a
    non-zero arithmetic offset `c`:
      - `(col_A ± c) = col_B` or `col_B = (col_A ± c)`
      - `col_A - col_B = c`
      - `DATE(col_A ± c) = col_B` / `DATETIME(col_A ± c) = col_B`
      - `(..., col_B, ...) IN (SELECT ..., [DATE](agg(col_A) ± c), ...)`

    Returns a list of dicts with keys:
      `table`, `column`, `offset` (float), `date_func` (Optional[str]), `node`.
    """
    root_node = scope_node if scope_node is not None else parsed_query.get("ast")
    if root_node is None:
        return []

    def _unwrap_expr(node: Optional[exp.Expression]) -> Optional[exp.Expression]:
        curr = node
        while isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast)):
            curr = curr.this
        return curr

    def _extract_numeric_lit(node: Optional[exp.Expression]) -> Optional[float]:
        curr = _unwrap_expr(node)
        if isinstance(curr, exp.Neg) and isinstance(curr.this, exp.Literal) and not curr.this.is_string:
            try:
                return -float(curr.this.name)
            except (ValueError, TypeError):
                return None
        if isinstance(curr, exp.Literal) and not curr.is_string:
            try:
                return float(curr.name)
            except (ValueError, TypeError):
                return None
        return None

    def _extract_base_col(node: Optional[exp.Expression]) -> Optional[Tuple[str, str]]:
        curr = _unwrap_expr(node)
        while isinstance(curr, (exp.Min, exp.Max, exp.Paren, exp.Cast, exp.TryCast)):
            curr = curr.this
        if isinstance(curr, exp.Column):
            return resolve_query_column(schema, parsed_query, curr.table, curr.name)
        return None

    def _parse_offset_operand(node: Optional[exp.Expression]) -> Optional[Dict[str, Any]]:
        curr = _unwrap_expr(node)
        if curr is None:
            return None

        date_func: Optional[str] = None
        if isinstance(curr, (exp.Date, exp.Datetime, exp.TsOrDsToDate, exp.TsOrDsToTimestamp)) and not curr.expressions:
            date_func = "DATETIME" if isinstance(curr, (exp.Datetime, exp.TsOrDsToTimestamp)) else "DATE"
            curr = _unwrap_expr(curr.this)
        elif (
            isinstance(curr, exp.Anonymous)
            and (curr.name or "").lower() in ("date", "datetime")
            and len(curr.expressions or []) == 1
        ):
            date_func = curr.name.upper()
            curr = _unwrap_expr(curr.expressions[0])

        if curr is None:
            return None

        if isinstance(curr, exp.Add):
            col_l, lit_r = _extract_base_col(curr.left), _extract_numeric_lit(curr.right)
            if col_l and lit_r is not None:
                return {
                    "table": col_l[0],
                    "column": col_l[1],
                    "offset": lit_r,
                    "date_func": date_func,
                    "is_offset": True,
                }
            col_r, lit_l = _extract_base_col(curr.right), _extract_numeric_lit(curr.left)
            if col_r and lit_l is not None:
                return {
                    "table": col_r[0],
                    "column": col_r[1],
                    "offset": lit_l,
                    "date_func": date_func,
                    "is_offset": True,
                }
        elif isinstance(curr, exp.Sub):
            col_l, lit_r = _extract_base_col(curr.left), _extract_numeric_lit(curr.right)
            if col_l and lit_r is not None:
                return {
                    "table": col_l[0],
                    "column": col_l[1],
                    "offset": -lit_r,
                    "date_func": date_func,
                    "is_offset": True,
                }

        if date_func is None:
            col_base = _extract_base_col(curr)
            if col_base:
                return {
                    "table": col_base[0],
                    "column": col_base[1],
                    "offset": 0.0,
                    "date_func": None,
                    "is_offset": False,
                }
        return None

    patterns: List[Dict[str, Any]] = []
    seen_keys: Set[Tuple[str, str, float, Optional[str]]] = set()

    def _record_pattern(table_name: str, col_name: str, offset: float, date_func: Optional[str], node: exp.Expression) -> None:
        if offset == 0:
            return
        key = (table_name.upper(), col_name.upper(), float(offset), date_func)
        if key not in seen_keys:
            seen_keys.add(key)
            patterns.append({
                "table": table_name,
                "column": col_name,
                "offset": float(offset),
                "date_func": date_func,
                "node": node,
            })

    def _check_pair(left_expr: Optional[exp.Expression], right_expr: Optional[exp.Expression], ctx_node: exp.Expression) -> None:
        info_l = _parse_offset_operand(left_expr)
        info_r = _parse_offset_operand(right_expr)
        if info_l and info_r:
            if (
                info_l["table"].upper() == info_r["table"].upper()
                and info_l["column"].upper() == info_r["column"].upper()
                and info_l["is_offset"] != info_r["is_offset"]
            ):
                off_info = info_l if info_l["is_offset"] else info_r
                _record_pattern(
                    off_info["table"],
                    off_info["column"],
                    off_info["offset"],
                    off_info["date_func"],
                    ctx_node,
                )
                return

        # Also check `col_1 - col_2 = c` and `ABS(col_1 - col_2) = c`
        for sub_side, lit_side in ((left_expr, right_expr), (right_expr, left_expr)):
            unwrapped_sub = _unwrap_expr(sub_side)
            lit_val = _extract_numeric_lit(lit_side)
            if isinstance(unwrapped_sub, exp.Abs) and lit_val is not None and lit_val > 0:
                unwrapped_sub = _unwrap_expr(unwrapped_sub.this)
            elif (
                isinstance(unwrapped_sub, exp.Anonymous)
                and (unwrapped_sub.name or "").lower() == "abs"
                and len(unwrapped_sub.expressions or []) == 1
                and lit_val is not None
                and lit_val > 0
            ):
                unwrapped_sub = _unwrap_expr(unwrapped_sub.expressions[0])
            if isinstance(unwrapped_sub, exp.Sub) and lit_val is not None and lit_val != 0:
                c1 = _extract_base_col(unwrapped_sub.left)
                c2 = _extract_base_col(unwrapped_sub.right)
                if c1 and c2 and c1[0].upper() == c2[0].upper() and c1[1].upper() == c2[1].upper():
                    _record_pattern(c1[0], c1[1], lit_val, None, ctx_node)
                    return

    eq_nodes = ([root_node] if isinstance(root_node, exp.EQ) else []) + [
        n for n in root_node.find_all(exp.EQ) if n is not root_node
    ]
    for eq in eq_nodes:
        _check_pair(eq.left, eq.right, eq)

    in_nodes = ([root_node] if isinstance(root_node, exp.In) else []) + [
        n for n in root_node.find_all(exp.In) if n is not root_node
    ]
    for in_node in in_nodes:
        subq = in_node.args.get("query")
        if not subq:
            continue
        left_exprs = (
            list(in_node.this.expressions)
            if isinstance(in_node.this, exp.Tuple)
            else [in_node.this]
        )
        sel = subq.this if isinstance(subq, exp.Subquery) else subq
        right_exprs = list(sel.expressions) if hasattr(sel, "expressions") else []
        if len(left_exprs) == len(right_exprs):
            for l_e, r_e in zip(left_exprs, right_exprs):
                _check_pair(l_e, r_e, in_node)

    return patterns


def compute_self_offset_values(
    schema: Schema,
    table_name: str,
    col_name: str,
    offset: float,
    date_func: Optional[str] = None,
) -> Dict[str, Any]:
    """
    Compute deterministic multi-row values for a self-offset column `(table_name, col_name)`:
      - `numeric_pair`: `[base_num, base_num + |offset|]` satisfying raw numeric `col_A ± offset = col_B`
        in SQLite while algebraically distinguishing `+` from `-`, `*`, `/`, `%`, and `DATE(...)`.
      - `non_matching_pair`: `[base_num, base_num + |offset| + 1]` falsifying the equality branch.
      - `mixed_triple`: `[base_num, base_num + |offset|, base_num + |offset| + 2]` exercising both
        matching and non-matching branches within the same group.
      - `julian_date_pair`: `[base_jd, DATE(base_jd + offset)]` satisfying `DATE(MIN(col) + offset) = col`
        in SQLite (where `INTEGER < TEXT` ensures `MIN(col) = base_jd` and `DATE(base_jd + offset)`
        produces the matching ISO date string).
      - `satisfying_pair`: `julian_date_pair` when `date_func` is set, else `numeric_pair`.
    """
    step = abs(offset)
    step_val: int | float = int(round(step)) if float(step).is_integer() else float(step)
    base_num: int | float = 10 if isinstance(step_val, int) else 10.0
    if base_num == step_val:
        base_num = base_num + (2 if isinstance(step_val, int) else 2.0)

    col_obj = schema.find_column(table_name, col_name)
    if col_obj:
        solved = solve_check_constraint_value(schema, table_name, col_name, col_obj, base_num)
        if isinstance(solved, (int, float)) and not isinstance(solved, bool):
            base_num = int(solved) if isinstance(step_val, int) and float(solved).is_integer() else solved

    unit: int | float = 1 if isinstance(step_val, int) else 1.0
    numeric_pair = [base_num, base_num + step_val]
    non_matching_pair = [base_num, base_num + step_val + unit]
    mixed_triple = [base_num, base_num + step_val, base_num + step_val + 2 * unit]

    julian_date_pair: Optional[List[Any]] = None
    if date_func:
        base_jd = 2451545  # Julian day integer for 2000-01-01 12:00:00
        jd_arg = base_jd + (int(round(offset)) if float(offset).is_integer() else float(offset))
        fn = "DATETIME" if "DATETIME" in date_func.upper() else "DATE"
        conn = sqlite3.connect(":memory:")
        try:
            row = conn.execute(f"SELECT {fn}({jd_arg});").fetchone()
            if row and isinstance(row[0], str):
                julian_date_pair = [base_jd, row[0]]
        except Exception:
            pass
        finally:
            conn.close()

    satisfying_pair = julian_date_pair if julian_date_pair is not None else numeric_pair
    return {
        "numeric_pair": numeric_pair,
        "non_matching_pair": non_matching_pair,
        "mixed_triple": mixed_triple,
        "julian_date_pair": julian_date_pair,
        "satisfying_pair": satisfying_pair,
    }


def extract_additive_sum_patterns(
    schema: Schema,
    parsed_query: Dict[str, Any],
    scope_node: Optional[exp.Expression] = None,
) -> List[Dict[str, Any]]:
    """
    Identify additive sum equality comparisons `col_1 + col_2 = C` (or `C = col_1 + col_2`)
    where two numeric column references (either on self-join aliases of the same base column
    or across two distinct columns) are summed and equated to a numeric constant `C`.

    Returns a list of dicts with keys:
      `left_table`, `left_column`, `right_table`, `right_column`,
      `is_self_sum` (bool), `sum_val` (float), `node`.
    """
    root_node = scope_node if scope_node is not None else parsed_query.get("ast")
    if root_node is None:
        return []

    def _unwrap_expr(node: Optional[exp.Expression]) -> Optional[exp.Expression]:
        curr = node
        while isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast)):
            curr = curr.this
        return curr

    def _extract_numeric_lit(node: Optional[exp.Expression]) -> Optional[float]:
        curr = _unwrap_expr(node)
        if isinstance(curr, exp.Neg) and isinstance(curr.this, exp.Literal) and not curr.this.is_string:
            try:
                return -float(curr.this.name)
            except (ValueError, TypeError):
                return None
        if isinstance(curr, exp.Literal) and not curr.is_string:
            try:
                return float(curr.name)
            except (ValueError, TypeError):
                return None
        return None

    def _extract_base_col(node: Optional[exp.Expression]) -> Optional[Tuple[str, str]]:
        curr = _unwrap_expr(node)
        if isinstance(curr, exp.Column):
            return resolve_query_column(schema, parsed_query, curr.table, curr.name)
        return None

    patterns: List[Dict[str, Any]] = []
    seen_keys: Set[Tuple[str, str, str, str, float]] = set()

    eq_nodes = ([root_node] if isinstance(root_node, exp.EQ) else []) + [
        n for n in root_node.find_all(exp.EQ) if n is not root_node
    ]
    for eq in eq_nodes:
        not_cnt = 0
        curr_p = eq.parent
        while curr_p:
            if isinstance(curr_p, exp.Not):
                not_cnt += 1
            curr_p = curr_p.parent
        if (not_cnt % 2 == 1) or bool(eq.args.get("negate")):
            continue

        for add_side, lit_side in ((eq.left, eq.right), (eq.right, eq.left)):
            unwrapped_add = _unwrap_expr(add_side)
            lit_val = _extract_numeric_lit(lit_side)
            if isinstance(unwrapped_add, exp.Add) and lit_val is not None:
                c1 = _extract_base_col(unwrapped_add.left)
                c2 = _extract_base_col(unwrapped_add.right)
                if not c1 or not c2:
                    continue
                col1_obj = schema.find_column(c1[0], c1[1])
                col2_obj = schema.find_column(c2[0], c2[1])
                if not col1_obj or not col2_obj or not col1_obj.is_numeric or not col2_obj.is_numeric:
                    continue
                if col1_obj.is_primary_key and col2_obj.is_primary_key and c1 == c2:
                    continue
                key = (c1[0].upper(), c1[1].upper(), c2[0].upper(), c2[1].upper(), float(lit_val))
                if key not in seen_keys:
                    seen_keys.add(key)
                    patterns.append({
                        "left_table": c1[0],
                        "left_column": c1[1],
                        "right_table": c2[0],
                        "right_column": c2[1],
                        "is_self_sum": (c1[0].upper() == c2[0].upper() and c1[1].upper() == c2[1].upper()),
                        "sum_val": float(lit_val),
                        "node": eq,
                        "add_node": unwrapped_add,
                    })
                break

    return patterns


def compute_additive_sum_values(
    schema: Schema,
    pat: Dict[str, Any],
) -> Dict[str, Any]:
    """
    Compute deterministic asymmetric summand pairs `[v_1, v_2]` satisfying `v_1 + v_2 = sum_val`
    with `v_1 != v_2` (and avoiding the symmetric midpoint `sum_val / 2` that would conflate
    `col_1 + col_2 = C` with `col_1 = C/2 AND col_2 = C/2`).
    """
    sum_f = float(pat["sum_val"])
    is_int = sum_f.is_integer()
    c_val: int | float = int(round(sum_f)) if is_int else sum_f
    unit: int | float = 1 if is_int else 1.0

    col_l = schema.find_column(pat["left_table"], pat["left_column"])
    col_r = schema.find_column(pat["right_table"], pat["right_column"])

    candidates: List[Tuple[int | float, int | float]] = []
    if c_val != 0:
        candidates.append((c_val, 0 if is_int else 0.0))
    candidates.append((c_val + unit, -unit))
    if c_val - unit != unit:
        candidates.append((c_val - unit, unit))
    candidates.append((c_val + 2 * unit, -2 * unit))

    valid_pairs: List[List[int | float]] = []
    for v1, v2 in candidates:
        if v1 == v2:
            continue
        ok1 = True
        ok2 = True
        if col_l:
            solved1 = solve_check_constraint_value(schema, pat["left_table"], pat["left_column"], col_l, v1)
            ok1 = (solved1 == v1)
        if col_r:
            solved2 = solve_check_constraint_value(schema, pat["right_table"], pat["right_column"], col_r, v2)
            ok2 = (solved2 == v2)
        if ok1 and ok2 and [v1, v2] not in valid_pairs:
            valid_pairs.append([v1, v2])

    if not valid_pairs:
        fallback = [c_val, 0 if is_int else 0.0] if c_val != 0 else [unit, -unit]
        valid_pairs.append(fallback)

    primary_pair = valid_pairs[0]
    secondary_pair = valid_pairs[1] if len(valid_pairs) > 1 else [primary_pair[1], primary_pair[0]]
    return {
        "primary_pair": primary_pair,
        "secondary_pair": secondary_pair,
    }


def _try_parse_iso_datetime(val_str: Optional[str]) -> Optional[datetime]:
    """Parse an ISO date or datetime string into a Python `datetime` object."""
    if not val_str or not isinstance(val_str, str):
        return None
    s = val_str.strip()
    clean_s = s.split("+")[0].split(".")[0].strip()
    for fmt in (
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%dT%H:%M:%S",
        "%Y-%m-%d %H:%M",
        "%Y-%m-%d",
    ):
        try:
            return datetime.strptime(clean_s, fmt)
        except ValueError:
            pass
    match = re.search(r"\b(\d{4})-(\d{2})-(\d{2})\b", s)
    if match:
        try:
            return datetime(int(match.group(1)), int(match.group(2)), int(match.group(3)))
        except ValueError:
            pass
    return None


def _safe_replace_year(dt: datetime, new_year: int) -> datetime:
    """Replace `dt.year` with `new_year`, clamping Feb 29 to Feb 28 on non-leap years."""
    clamped_year = max(1, min(9999, new_year))
    try:
        return dt.replace(year=clamped_year)
    except ValueError:
        return dt.replace(year=clamped_year, day=28)


def extract_temporal_diff_patterns(
    schema: Schema,
    parsed_query: Dict[str, Any],
    scope_node: Optional[exp.Expression] = None,
) -> List[Dict[str, Any]]:
    """
    Identify temporal difference / duration / age expressions comparing the elapsed
    time between a column `C` and a reference date/timestamp `D_ref` against a numeric
    threshold `V` (or projected directly in SELECT):
      - Day-count / epoch differences:
          `(JULIANDAY(D_ref) - JULIANDAY(C)) / k >= V`
          `CAST((JULIANDAY(D_ref) - JULIANDAY(C)) AS REAL) / 365 >= V`
          `(UNIXEPOCH(D_ref) - UNIXEPOCH(C)) / 86400 >= V`
      - Calendar-component differences (with or without month-day adjustment):
          `STRFTIME('%Y', D_ref) - STRFTIME('%Y', C) - (STRFTIME('%m-%d', D_ref) < STRFTIME('%m-%d', C)) >= V`
          `STRFTIME('%Y', D_ref) - STRFTIME('%Y', C) >= V`
          `YEAR(D_ref) - YEAR(C) >= V`
          `2025 - CAST(STRFTIME('%Y', C) AS INT) >= V`

    Returns a list of dicts with keys:
      `table`, `column`, `kind`, `direction` ('past' | 'future'), `op`,
      `threshold` (float), `scale_divisor` (float), `ref_dt` (datetime),
      `has_md_adjustment` (bool), `from_comparison` (bool), `node`.
    """
    root_node = scope_node if scope_node is not None else parsed_query.get("ast")
    if root_node is None:
        return []

    def _unwrap_expr(node: Optional[exp.Expression]) -> Optional[exp.Expression]:
        curr = node
        while isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast)):
            curr = curr.this
        return curr

    def _extract_numeric_lit(node: Optional[exp.Expression]) -> Optional[float]:
        curr = _unwrap_expr(node)
        if isinstance(curr, exp.Neg) and isinstance(curr.this, exp.Literal) and not curr.this.is_string:
            try:
                return -float(curr.this.name)
            except (ValueError, TypeError):
                return None
        if isinstance(curr, exp.Literal) and not curr.is_string:
            try:
                return float(curr.name)
            except (ValueError, TypeError):
                return None
        return None

    def _eval_ref_datetime(arg_nodes: List[exp.Expression]) -> Optional[datetime]:
        if not arg_nodes:
            return None
        first_unwrapped = _unwrap_expr(arg_nodes[0])
        while isinstance(first_unwrapped, (exp.TsOrDsToTimestamp, exp.TsOrDsToDate)):
            first_unwrapped = _unwrap_expr(first_unwrapped.this)
        if (
            len(arg_nodes) == 1
            and isinstance(first_unwrapped, exp.Literal)
            and first_unwrapped.is_string
            and (first_unwrapped.name or "").strip().lower() != "now"
        ):
            parsed_dt = _try_parse_iso_datetime(first_unwrapped.name)
            if parsed_dt is not None:
                return parsed_dt

        args_sql = ", ".join(a.sql(dialect="sqlite") for a in arg_nodes)
        conn = sqlite3.connect(":memory:")
        try:
            row = conn.execute(f"SELECT DATETIME({args_sql});").fetchone()
            if row and isinstance(row[0], str):
                parsed_dt = _try_parse_iso_datetime(row[0])
                if parsed_dt is not None:
                    return parsed_dt
            if len(arg_nodes) == 1:
                raw_sql = arg_nodes[0].sql(dialect="sqlite")
                row2 = conn.execute(f"SELECT {raw_sql};").fetchone()
                if row2 and isinstance(row2[0], str):
                    return _try_parse_iso_datetime(row2[0])
        except Exception:
            pass
        finally:
            conn.close()
        return None

    def _parse_temporal_operand(node: Optional[exp.Expression]) -> Optional[Dict[str, Any]]:
        curr = _unwrap_expr(node)
        while isinstance(curr, (exp.TsOrDsToTimestamp, exp.TsOrDsToDate)):
            curr = _unwrap_expr(curr.this)
        if curr is None:
            return None

        kind: Optional[str] = None
        arg_nodes: List[exp.Expression] = []

        if isinstance(curr, exp.Anonymous):
            fn = (curr.name or "").lower()
            args = list(curr.expressions or [])
            if fn == "julianday" and len(args) >= 1:
                kind = "julianday"
                arg_nodes = args
            elif fn == "unixepoch" and len(args) >= 1:
                kind = "unixepoch"
                arg_nodes = args
            elif fn == "strftime" and len(args) >= 2 and isinstance(args[0], exp.Literal):
                fmt = args[0].name
                arg_nodes = args[1:]
                if fmt == "%Y":
                    kind = "year"
                elif fmt == "%s":
                    kind = "unixepoch"
                elif fmt == "%m":
                    kind = "month"
                elif fmt in ("%d", "%j"):
                    kind = "day"
            elif fn in ("year", "month", "day") and len(args) >= 1:
                kind = fn
                arg_nodes = args
            elif fn in ("date", "datetime") and len(args) >= 1:
                kind = "day"
                arg_nodes = args
        elif isinstance(curr, exp.TimeToStr):
            fmt_node = curr.args.get("format")
            fmt = fmt_node.name if isinstance(fmt_node, exp.Literal) else ""
            if curr.this is not None:
                arg_nodes = [curr.this]
            if fmt == "%Y":
                kind = "year"
            elif fmt == "%s":
                kind = "unixepoch"
            elif fmt == "%m":
                kind = "month"
            elif fmt in ("%d", "%j"):
                kind = "day"
        elif isinstance(curr, (exp.Year, exp.Month, exp.Day)):
            kind = curr.__class__.__name__.lower()
            if curr.this is not None:
                arg_nodes = [curr.this]
        elif isinstance(curr, exp.Extract):
            part = (curr.name or "").upper()
            if part in ("YEAR", "MONTH", "DAY") and curr.expression is not None:
                kind = part.lower()
                arg_nodes = [curr.expression]
        elif isinstance(curr, (exp.Date, exp.Datetime, exp.CurrentDate, exp.CurrentTimestamp)):
            kind = "day"
            arg_nodes = [curr]
        elif isinstance(curr, exp.Literal):
            s_lit = (curr.name or "").strip()
            if s_lit.isdigit() and 1000 <= int(s_lit) <= 9999:
                return {
                    "kind": "year_literal",
                    "is_column": False,
                    "ref_dt": datetime(int(s_lit), 1, 1, 0, 0, 0),
                }
        elif isinstance(curr, exp.Column):
            resolved = resolve_query_column(schema, parsed_query, curr.table, curr.name)
            if resolved:
                col_obj = schema.find_column(resolved[0], resolved[1])
                if col_obj and col_obj.is_temporal:
                    return {
                        "kind": "year",
                        "is_column": True,
                        "table": resolved[0],
                        "column": resolved[1],
                        "alias": (curr.table or "").upper(),
                    }
            return None

        if not kind or not arg_nodes:
            return None

        cols = [c for a in arg_nodes for c in ([a] if isinstance(a, exp.Column) else list(a.find_all(exp.Column)))]
        if cols:
            col_node = cols[0]
            resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if resolved:
                return {
                    "kind": kind,
                    "is_column": True,
                    "table": resolved[0],
                    "column": resolved[1],
                    "alias": (col_node.table or "").upper(),
                }
            return None

        ref_dt = _eval_ref_datetime(arg_nodes)
        if ref_dt is not None:
            return {
                "kind": kind,
                "is_column": False,
                "ref_dt": ref_dt,
            }
        return None

    def _find_column_literal_datetime(t_name: str, c_name: str) -> Optional[datetime]:
        for lit in parsed_query.get("where_literals", []):
            val = lit.get("value")
            if val in (None, "NULL"):
                continue
            resolved = resolve_query_column(
                schema, parsed_query, lit.get("table", ""), lit.get("column", "")
            )
            if not resolved:
                continue
            if resolved[0].upper() != t_name.upper() or resolved[1].upper() != c_name.upper():
                continue
            val_str = str(val).strip()
            parsed_dt = _try_parse_iso_datetime(val_str)
            if parsed_dt is not None:
                return parsed_dt
            if val_str.isdigit() and 1000 <= int(val_str) <= 9999:
                return datetime(int(val_str), 1, 15, 0, 0, 0)
        return None

    def _decompose_diff_expr(expr: Optional[exp.Expression]) -> Optional[Dict[str, Any]]:
        curr = expr
        scale_divisor = 1.0
        while curr is not None:
            if isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast)):
                curr = curr.this
            elif isinstance(curr, (exp.Round, exp.Floor, exp.Ceil)):
                curr = curr.this
            elif isinstance(curr, exp.Anonymous) and (curr.name or "").lower() in (
                "round", "floor", "ceil", "ceiling", "trunc"
            ):
                exprs = curr.expressions or []
                curr = exprs[0] if exprs else None
            elif isinstance(curr, exp.Div):
                d_val = _extract_numeric_lit(curr.right)
                if d_val is not None and d_val > 0:
                    scale_divisor *= d_val
                    curr = curr.left
                else:
                    break
            elif isinstance(curr, exp.Mul):
                m_r = _extract_numeric_lit(curr.right)
                m_l = _extract_numeric_lit(curr.left)
                if m_r is not None and m_r > 0:
                    scale_divisor /= m_r
                    curr = curr.left
                elif m_l is not None and m_l > 0:
                    scale_divisor /= m_l
                    curr = curr.right
                else:
                    break
            else:
                break

        if curr is None:
            return None

        has_md_adjustment = False
        adj_node: Optional[exp.Expression] = None
        if isinstance(curr, (exp.Sub, exp.Add)):
            inner_l = _unwrap_expr(curr.left)
            inner_r = _unwrap_expr(curr.right)
            if isinstance(inner_l, exp.Sub) and isinstance(
                inner_r, (exp.LT, exp.LTE, exp.GT, exp.GTE, exp.EQ, exp.NEQ, exp.Case, exp.If)
            ):
                has_md_adjustment = True
                adj_node = inner_r
                curr = inner_l

        if not isinstance(curr, exp.Sub):
            return None

        info_l = _parse_temporal_operand(curr.left)
        info_r = _parse_temporal_operand(curr.right)
        if not info_l or not info_r:
            return None
        if not info_l["is_column"] and not info_r["is_column"]:
            return None

        if info_l["is_column"] and info_r["is_column"]:
            if (
                info_l["table"].upper() == info_r["table"].upper()
                and info_l["column"].upper() == info_r["column"].upper()
                and info_l.get("alias", "") == info_r.get("alias", "")
            ):
                return None
            if info_l["kind"] != info_r["kind"]:
                return None

            dt_l = _find_column_literal_datetime(info_l["table"], info_l["column"])
            dt_r = _find_column_literal_datetime(info_r["table"], info_r["column"])
            if dt_l is not None and dt_r is None:
                direction = "past"
                ref_info, col_info = info_l, info_r
                ref_dt = dt_l
            else:
                direction = "future"
                ref_info, col_info = info_r, info_l
                ref_dt = dt_r if dt_r is not None else datetime(2020, 1, 15, 0, 0, 0)

            return {
                "table": col_info["table"],
                "column": col_info["column"],
                "alias": col_info.get("alias", ""),
                "ref_table": ref_info["table"],
                "ref_column": ref_info["column"],
                "ref_alias": ref_info.get("alias", ""),
                "kind": col_info["kind"],
                "direction": direction,
                "scale_divisor": float(scale_divisor),
                "ref_dt": ref_dt,
                "has_md_adjustment": has_md_adjustment,
            }

        if not info_l["is_column"] and info_r["is_column"]:
            direction = "past"
            ref_info, col_info = info_l, info_r
        else:
            direction = "future"
            ref_info, col_info = info_r, info_l

        col_kind = col_info["kind"]
        ref_kind = ref_info["kind"]
        if col_kind != ref_kind and not (col_kind == "year" and ref_kind == "year_literal"):
            return None

        ref_dt: datetime = ref_info["ref_dt"]
        if ref_kind == "year_literal" and adj_node is not None:
            for lit in adj_node.find_all(exp.Literal):
                if lit.is_string:
                    dt_cand = _try_parse_iso_datetime(lit.name)
                    if dt_cand is not None:
                        ref_dt = dt_cand
                        break
                    md_match = re.match(r"^(\d{2})-(\d{2})$", (lit.name or "").strip())
                    if md_match:
                        try:
                            ref_dt = datetime(ref_dt.year, int(md_match.group(1)), int(md_match.group(2)))
                            break
                        except ValueError:
                            pass

        return {
            "table": col_info["table"],
            "column": col_info["column"],
            "kind": col_kind,
            "direction": direction,
            "scale_divisor": float(scale_divisor),
            "ref_dt": ref_dt,
            "has_md_adjustment": has_md_adjustment,
        }

    # Build alias map for SELECT projection expressions so outer comparisons on aliases resolve
    alias_expr_map: Dict[str, exp.Expression] = {}
    full_ast = parsed_query.get("ast") or root_node
    if full_ast:
        for sel in full_ast.find_all(exp.Select):
            for expr in sel.expressions or []:
                if isinstance(expr, exp.Alias) and expr.alias and expr.this is not None:
                    alias_expr_map.setdefault(expr.alias.upper(), expr.this)

    def _resolve_diff_candidate(side: Optional[exp.Expression]) -> Optional[exp.Expression]:
        unwrapped = _unwrap_expr(side)
        if isinstance(unwrapped, exp.Column) and unwrapped.name.upper() in alias_expr_map:
            return alias_expr_map[unwrapped.name.upper()]
        return side

    patterns: List[Dict[str, Any]] = []
    seen_keys: Set[Tuple[str, str, str, float]] = set()

    comp_types = (exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between)
    comp_nodes = ([root_node] if isinstance(root_node, comp_types) else []) + [
        n for n in root_node.find_all(comp_types) if n is not root_node
    ]
    matched_sub_ids: Set[int] = set()

    for comp in comp_nodes:
        arith_anc = comp.find_ancestor((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod))
        if (
            arith_anc is not None
            and arith_anc.find_ancestor(comp_types) is not None
            and comp.find_ancestor(exp.AggFunc) is None
        ):
            continue

        not_cnt = 0
        curr_p = comp.parent
        while curr_p:
            if isinstance(curr_p, exp.Not):
                not_cnt += 1
            curr_p = curr_p.parent
        is_neg = (not_cnt % 2 == 1) or bool(comp.args.get("negate"))

        diff_side: Optional[exp.Expression] = None
        threshold: Optional[float] = None
        op_name: str = "GTE"

        if isinstance(comp, exp.Between):
            low_v = _extract_numeric_lit(comp.args.get("low"))
            high_v = _extract_numeric_lit(comp.args.get("high"))
            if low_v is None or high_v is None:
                continue
            diff_side = _resolve_diff_candidate(comp.this)
            if is_neg:
                op_name = "LT"
                threshold = min(low_v, high_v)
            else:
                op_name = "BETWEEN"
                threshold = (low_v + high_v) / 2.0
        else:
            lit_r = _extract_numeric_lit(comp.right)
            lit_l = _extract_numeric_lit(comp.left)
            if lit_r is not None:
                diff_side = _resolve_diff_candidate(comp.left)
                threshold = lit_r
                op_name = comp.__class__.__name__.upper()
            elif lit_l is not None:
                diff_side = _resolve_diff_candidate(comp.right)
                threshold = lit_l
                flip_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "EQ": "EQ", "NEQ": "NEQ"}
                op_name = flip_map.get(comp.__class__.__name__.upper(), "EQ")
            else:
                continue

            if is_neg:
                neg_map = {"GT": "LTE", "GTE": "LT", "LT": "GTE", "LTE": "GT", "EQ": "NEQ", "NEQ": "EQ"}
                op_name = neg_map.get(op_name, op_name)

        info = _decompose_diff_expr(diff_side)
        if not info or threshold is None:
            continue

        if diff_side is not None:
            if isinstance(diff_side, exp.Sub):
                matched_sub_ids.add(id(diff_side))
            for sub_n in diff_side.find_all(exp.Sub):
                matched_sub_ids.add(id(sub_n))

        key = (info["table"].upper(), info["column"].upper(), op_name, float(threshold))
        if key not in seen_keys:
            seen_keys.add(key)
            patterns.append({
                **info,
                "op": op_name,
                "threshold": float(threshold),
                "from_comparison": True,
                "node": comp,
            })

    # Also extract standalone temporal difference expressions (e.g. projected in SELECT)
    sub_nodes = ([root_node] if isinstance(root_node, exp.Sub) else []) + [
        n for n in root_node.find_all(exp.Sub) if n is not root_node
    ]
    for sub_node in sub_nodes:
        if id(sub_node) in matched_sub_ids:
            continue

        outer_expr: exp.Expression = sub_node
        while outer_expr is not root_node and outer_expr.parent is not None:
            p = outer_expr.parent
            if isinstance(p, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast, exp.Round, exp.Floor, exp.Ceil)):
                outer_expr = p
            elif isinstance(p, exp.Anonymous) and (p.name or "").lower() in (
                "round", "floor", "ceil", "ceiling", "trunc"
            ):
                outer_expr = p
            elif isinstance(p, exp.Div) and p.left is outer_expr and _extract_numeric_lit(p.right) is not None:
                outer_expr = p
            elif isinstance(p, exp.Mul) and (
                _extract_numeric_lit(p.left) is not None or _extract_numeric_lit(p.right) is not None
            ):
                outer_expr = p
            elif (
                isinstance(p, (exp.Sub, exp.Add))
                and p.left is outer_expr
                and isinstance(
                    _unwrap_expr(p.right),
                    (exp.LT, exp.LTE, exp.GT, exp.GTE, exp.EQ, exp.NEQ, exp.Case, exp.If),
                )
            ):
                outer_expr = p
            else:
                break

        info = _decompose_diff_expr(outer_expr)
        if not info:
            continue

        if isinstance(outer_expr, exp.Sub):
            matched_sub_ids.add(id(outer_expr))
        for sub_n in outer_expr.find_all(exp.Sub):
            matched_sub_ids.add(id(sub_n))

        key = (info["table"].upper(), info["column"].upper(), "PROJ", 0.0)
        if key not in seen_keys:
            seen_keys.add(key)
            patterns.append({
                **info,
                "op": "GTE",
                "threshold": 0.0,
                "from_comparison": False,
                "node": outer_expr,
            })

    return patterns


def compute_temporal_diff_values(
    schema: Schema,
    pat: Dict[str, Any],
) -> Dict[str, Any]:
    """
    Compute a baseline satisfying date (`satisfying_date`) and 5 boundary-sensitive
    attack candidate dates (`attack_candidates`) for a temporal difference pattern `pat`:
      1. `day_count_boundary`: exact `D_ref ± (threshold * k_days)` day-count boundary,
         where `(JULIANDAY(D_ref) - JULIANDAY(col)) / 365 == threshold` holds exactly
         while calendar age (`STRFTIME('%Y')` with `%m-%d` adjustment) is `threshold - 1`
         due to leap years across the span.
      2. `calendar_anniversary_step`: 1 day inside the calendar anniversary toward `D_ref`
         (`D_cal - s * 1 day`), where month-day adjusted calendar age drops to `threshold - 1`
         while `JULIANDAY / 365` (for spans with >= 1 leap year) and unadjusted year
         difference still evaluate to `>= threshold`.
      3. `calendar_anniversary_midday`: exact calendar anniversary at noon (`D_cal 12:00:00`),
         distinguishing date/year extraction (which ignores time-of-day) from fractional
         `JULIANDAY` differences and testing `>= threshold` vs `> threshold` on calendar age.
      4. `year_end_unadjusted`: far post-anniversary date within the same calendar year
         (`Y_cal-12-31` or `Y_cal-01-01`), distinguishing naive year subtraction
         `STRFTIME('%Y', D_ref) - STRFTIME('%Y', col)` from both `%m-%d`-adjusted calendar
         age and `JULIANDAY / 365`.
      5. `day_count_strict_step`: 1 day beyond the day-count boundary away from `D_ref`
         (`D_day + s * 1 day`), satisfying strict inequality `> threshold` under `JULIANDAY / 365`
         while remaining below `threshold` under calendar age.
    """
    ref_dt: datetime = pat["ref_dt"]
    direction: str = pat["direction"]
    op: str = pat.get("op", "GTE").upper()
    threshold: float = float(pat["threshold"])
    scale_divisor: float = float(pat.get("scale_divisor", 1.0))
    kind: str = pat["kind"]

    s = -1 if direction == "past" else 1

    if not pat.get("from_comparison", True):
        d_420 = ref_dt + timedelta(days=s * 420)
        d_1460 = ref_dt + timedelta(days=s * 1460)
        d_unadj = _safe_replace_year(ref_dt, ref_dt.year + s * 2) - timedelta(days=s * 10)
        d_45 = ref_dt + timedelta(days=s * 45)
        d_viol = ref_dt - timedelta(days=s * 420)

        cand_1 = d_420.strftime("%Y-%m-%d")
        cand_2 = d_1460.strftime("%Y-%m-%d")
        cand_3 = f"{d_420.strftime('%Y-%m-%d')} 18:00:00"
        cand_4 = d_unadj.strftime("%Y-%m-%d")
        cand_5 = d_45.strftime("%Y-%m-%d")

        return {
            "satisfying_date": cand_1,
            "violating_date": d_viol.strftime("%Y-%m-%d"),
            "day_count_boundary": cand_1,
            "calendar_anniversary_step": cand_2,
            "calendar_anniversary_midday": cand_3,
            "year_end_unadjusted": cand_4,
            "day_count_strict_step": cand_5,
            "attack_candidates": [cand_1, cand_2, cand_3, cand_4, cand_5],
        }

    if kind == "julianday":
        k_days = scale_divisor
    elif kind == "unixepoch":
        k_days = scale_divisor / 86400.0
    elif kind == "year":
        k_days = 365.0 * scale_divisor
    elif kind == "month":
        k_days = 30.0 * scale_divisor
    else:
        k_days = scale_divisor

    is_year_unit = bool(
        kind == "year"
        or (360.0 <= k_days <= 366.5)
        or (k_days == 1.0 and threshold >= 365.0 and abs(threshold % 365.0) < 1e-6)
    )

    delta_days = threshold * k_days
    d_day = ref_dt + timedelta(days=s * delta_days)

    if is_year_unit:
        if kind == "year" or (360.0 <= k_days <= 366.5):
            years_int = int(round(threshold * (scale_divisor if kind == "year" else 1.0)))
        else:
            years_int = int(round(delta_days / 365.0))
        d_cal = _safe_replace_year(ref_dt, ref_dt.year + s * years_int)
    else:
        d_cal = d_day

    d_far = min(d_day, d_cal) if s == -1 else max(d_day, d_cal)
    d_near = max(d_day, d_cal) if s == -1 else min(d_day, d_cal)
    margin = max(10, int(abs(k_days)) + 2)

    if op in ("GT", "GTE"):
        d_sat = _safe_replace_year(d_far, d_far.year + s * 2) if is_year_unit else (d_far + timedelta(days=s * margin))
        d_viol = _safe_replace_year(d_near, d_near.year - s * 2) if is_year_unit else (d_near - timedelta(days=s * margin))
    elif op == "NEQ":
        d_sat = _safe_replace_year(d_far, d_far.year + s * 2) if is_year_unit else (d_far + timedelta(days=s * margin))
        d_viol = d_day if kind in ("julianday", "unixepoch") else d_cal
    elif op in ("LT", "LTE"):
        d_sat = _safe_replace_year(d_near, d_near.year - s * 2) if is_year_unit else (d_near - timedelta(days=s * margin))
        d_viol = _safe_replace_year(d_far, d_far.year + s * 2) if is_year_unit else (d_far + timedelta(days=s * margin))
    elif op == "EQ":
        d_sat = d_day if kind in ("julianday", "unixepoch") else d_cal
        d_viol = _safe_replace_year(d_far, d_far.year + s * 2) if is_year_unit else (d_far + timedelta(days=s * margin))
    else:
        d_sat = d_cal
        d_viol = _safe_replace_year(d_far, d_far.year + s * 2) if is_year_unit else (d_far + timedelta(days=s * margin))

    satisfying_date = d_sat.strftime("%Y-%m-%d")
    violating_date = d_viol.strftime("%Y-%m-%d")

    cand_1 = (
        d_day.strftime("%Y-%m-%d %H:%M:%S")
        if (d_day.hour != 0 or d_day.minute != 0 or d_day.second != 0)
        else d_day.strftime("%Y-%m-%d")
    )
    cand_2 = (d_cal - timedelta(days=s)).strftime("%Y-%m-%d")
    cand_3 = f"{d_cal.strftime('%Y-%m-%d')} 12:00:00"
    if is_year_unit:
        cand_4 = f"{d_cal.year:04d}-12-31" if s == -1 else f"{d_cal.year:04d}-01-01"
        if cand_4 == d_cal.strftime("%Y-%m-%d"):
            cand_4 = (d_day - timedelta(days=s * 2)).strftime("%Y-%m-%d")
    else:
        cand_4 = (d_day - timedelta(days=s)).strftime("%Y-%m-%d")
    cand_5 = (d_day + timedelta(days=s)).strftime("%Y-%m-%d")

    return {
        "satisfying_date": satisfying_date,
        "violating_date": violating_date,
        "day_count_boundary": cand_1,
        "calendar_anniversary_step": cand_2,
        "calendar_anniversary_midday": cand_3,
        "year_end_unadjusted": cand_4,
        "day_count_strict_step": cand_5,
        "attack_candidates": [cand_1, cand_2, cand_3, cand_4, cand_5],
    }


def extract_ratio_comparison_patterns(
    schema: Schema,
    parsed_query: Dict[str, Any],
    scope_node: Optional[exp.Expression] = None,
) -> List[Dict[str, Any]]:
    """
    Identify scaled/shifted division and ratio comparison predicates in WHERE,
    HAVING, or JOIN ON clauses (including expressions wrapped in CAST, TRY_CAST,
    ROUND, or parentheses):
      - `CAST(x AS REAL) * 100 / y < 0.18`
      - `(x * 100 / y) < 0.18`
      - `CAST(x AS REAL) / y > 0.3`
      - `(x - y) / y > 0.1`
      - `x / (x + y) >= 0.5`

    Returns a list of dicts with keys:
      `num_table`, `num_column`, `num_alias`, `denom_table`, `denom_column`,
      `denom_alias`, `ratio` (Fraction), `total_scale` (Fraction), `op` (str),
      `mode` ('direct' | 'share_add'), `node`.
    """
    root_node = scope_node if scope_node is not None else parsed_query.get("ast")
    if root_node is None:
        return []

    flip_op_map = {
        "GT": "LT",
        "GTE": "LTE",
        "LT": "GT",
        "LTE": "GTE",
        "EQ": "EQ",
        "NEQ": "NEQ",
        "BETWEEN": "BETWEEN",
    }

    def _extract_numeric_fraction(node: Optional[exp.Expression]) -> Optional[Fraction]:
        curr = node
        sign = 1
        while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast, exp.Neg)):
            if isinstance(curr, exp.Neg):
                sign *= -1
            curr = curr.this
        if isinstance(curr, exp.Literal) and not curr.is_string:
            s = str(curr.name).strip()
            try:
                return sign * Fraction(s)
            except (ValueError, ZeroDivisionError):
                return None
        return None

    def _unwrap_scaled_expr(
        node: Optional[exp.Expression],
    ) -> Tuple[Optional[exp.Expression], Fraction]:
        curr = node
        factor = Fraction(1)
        while curr is not None:
            if isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast, exp.Round)):
                curr = curr.this
                continue
            if (
                isinstance(curr, exp.Anonymous)
                and (curr.name or "").lower() == "round"
                and (curr.expressions or [])
            ):
                curr = curr.expressions[0]
                continue
            if isinstance(curr, exp.Mul):
                l_frac = _extract_numeric_fraction(curr.left)
                r_frac = _extract_numeric_fraction(curr.right)
                if l_frac is not None and l_frac != 0:
                    factor *= l_frac
                    curr = curr.right
                    continue
                if r_frac is not None and r_frac != 0:
                    factor *= r_frac
                    curr = curr.left
                    continue
            if isinstance(curr, exp.Div):
                r_frac = _extract_numeric_fraction(curr.expression)
                if r_frac is not None and r_frac != 0 and not (curr.this and curr.this.find(exp.Div)):
                    cols = list(curr.this.find_all(exp.Column)) if curr.this else []
                    if len(cols) == 1:
                        factor /= r_frac
                        curr = curr.this
                        continue
            break
        return curr, factor

    def _decompose_ratio_expr(
        expr: exp.Expression,
        bound_frac: Fraction,
        op_name: str,
    ) -> Optional[Dict[str, Any]]:
        curr: Optional[exp.Expression] = expr
        target = bound_frac
        outer_scale = Fraction(1)
        eff_op = op_name

        while curr is not None:
            if isinstance(curr, (exp.Alias, exp.Paren, exp.Cast, exp.TryCast, exp.Round)):
                curr = curr.this
                continue
            if (
                isinstance(curr, exp.Anonymous)
                and (curr.name or "").lower() == "round"
                and (curr.expressions or [])
            ):
                curr = curr.expressions[0]
                continue
            if isinstance(curr, exp.Add):
                l_frac = _extract_numeric_fraction(curr.left)
                r_frac = _extract_numeric_fraction(curr.right)
                if l_frac is not None:
                    target -= l_frac
                    curr = curr.right
                    continue
                if r_frac is not None:
                    target -= r_frac
                    curr = curr.left
                    continue
            if isinstance(curr, exp.Sub):
                l_frac = _extract_numeric_fraction(curr.left)
                r_frac = _extract_numeric_fraction(curr.right)
                if r_frac is not None:
                    target += r_frac
                    curr = curr.left
                    continue
                if l_frac is not None:
                    target = l_frac - target
                    eff_op = flip_op_map.get(eff_op, eff_op)
                    curr = curr.right
                    continue
            if isinstance(curr, exp.Mul):
                l_frac = _extract_numeric_fraction(curr.left)
                r_frac = _extract_numeric_fraction(curr.right)
                if l_frac is not None and l_frac != 0:
                    target /= l_frac
                    outer_scale *= abs(l_frac)
                    if l_frac < 0:
                        eff_op = flip_op_map.get(eff_op, eff_op)
                    curr = curr.right
                    continue
                if r_frac is not None and r_frac != 0:
                    target /= r_frac
                    outer_scale *= abs(r_frac)
                    if r_frac < 0:
                        eff_op = flip_op_map.get(eff_op, eff_op)
                    curr = curr.left
                    continue
            if isinstance(curr, exp.Div) and curr.this and curr.this.find(exp.Div):
                r_frac = _extract_numeric_fraction(curr.expression)
                if r_frac is not None and r_frac != 0:
                    target *= r_frac
                    if r_frac < 0:
                        eff_op = flip_op_map.get(eff_op, eff_op)
                    curr = curr.this
                    continue
            break

        if not isinstance(curr, exp.Div) or curr.this is None or curr.expression is None:
            return None

        num_core, num_factor = _unwrap_scaled_expr(curr.this)
        denom_core, denom_factor = _unwrap_scaled_expr(curr.expression)
        if num_core is None or denom_core is None or num_factor == 0 or denom_factor == 0:
            return None

        scale_ratio = denom_factor / num_factor
        if scale_ratio < 0:
            eff_op = flip_op_map.get(eff_op, eff_op)
        ratio = target * scale_ratio
        total_scale = abs(outer_scale * num_factor)

        if isinstance(num_core, exp.Column) and isinstance(denom_core, exp.Column):
            res_num = resolve_query_column(schema, parsed_query, num_core.table, num_core.name)
            res_denom = resolve_query_column(schema, parsed_query, denom_core.table, denom_core.name)
            if res_num and res_denom and res_num != res_denom:
                return {
                    "num_table": res_num[0],
                    "num_column": res_num[1],
                    "num_alias": (num_core.table or "").upper(),
                    "denom_table": res_denom[0],
                    "denom_column": res_denom[1],
                    "denom_alias": (denom_core.table or "").upper(),
                    "ratio": ratio,
                    "total_scale": total_scale,
                    "op": eff_op,
                    "mode": "direct",
                }

        if isinstance(num_core, (exp.Sub, exp.Add)) and isinstance(denom_core, exp.Column):
            res_denom = resolve_query_column(schema, parsed_query, denom_core.table, denom_core.name)
            l_col, _ = _unwrap_scaled_expr(num_core.left)
            r_col, _ = _unwrap_scaled_expr(num_core.right)
            if res_denom and isinstance(l_col, exp.Column) and isinstance(r_col, exp.Column):
                res_l = resolve_query_column(schema, parsed_query, l_col.table, l_col.name)
                res_r = resolve_query_column(schema, parsed_query, r_col.table, r_col.name)
                if res_l and res_r == res_denom and res_l != res_denom:
                    shifted_ratio = ratio + 1 if isinstance(num_core, exp.Sub) else ratio - 1
                    return {
                        "num_table": res_l[0],
                        "num_column": res_l[1],
                        "num_alias": (l_col.table or "").upper(),
                        "denom_table": res_denom[0],
                        "denom_column": res_denom[1],
                        "denom_alias": (denom_core.table or "").upper(),
                        "ratio": shifted_ratio,
                        "total_scale": total_scale,
                        "op": eff_op,
                        "mode": "direct",
                    }
                if isinstance(num_core, exp.Sub) and res_r and res_l == res_denom and res_r != res_denom:
                    shifted_ratio = 1 - ratio
                    flipped_op = flip_op_map.get(eff_op, eff_op)
                    return {
                        "num_table": res_r[0],
                        "num_column": res_r[1],
                        "num_alias": (r_col.table or "").upper(),
                        "denom_table": res_denom[0],
                        "denom_column": res_denom[1],
                        "denom_alias": (denom_core.table or "").upper(),
                        "ratio": shifted_ratio,
                        "total_scale": total_scale,
                        "op": flipped_op,
                        "mode": "direct",
                    }

        if isinstance(num_core, exp.Column) and isinstance(denom_core, exp.Add):
            res_num = resolve_query_column(schema, parsed_query, num_core.table, num_core.name)
            l_col, _ = _unwrap_scaled_expr(denom_core.left)
            r_col, _ = _unwrap_scaled_expr(denom_core.right)
            if res_num and isinstance(l_col, exp.Column) and isinstance(r_col, exp.Column):
                res_l = resolve_query_column(schema, parsed_query, l_col.table, l_col.name)
                res_r = resolve_query_column(schema, parsed_query, r_col.table, r_col.name)
                if res_l == res_num and res_r and res_r != res_num:
                    return {
                        "num_table": res_num[0],
                        "num_column": res_num[1],
                        "num_alias": (num_core.table or "").upper(),
                        "denom_table": res_r[0],
                        "denom_column": res_r[1],
                        "denom_alias": (r_col.table or "").upper(),
                        "ratio": ratio,
                        "total_scale": total_scale,
                        "op": eff_op,
                        "mode": "share_add",
                    }
                if res_r == res_num and res_l and res_l != res_num:
                    return {
                        "num_table": res_num[0],
                        "num_column": res_num[1],
                        "num_alias": (num_core.table or "").upper(),
                        "denom_table": res_l[0],
                        "denom_column": res_l[1],
                        "denom_alias": (l_col.table or "").upper(),
                        "ratio": ratio,
                        "total_scale": total_scale,
                        "op": eff_op,
                        "mode": "share_add",
                    }

        return None

    patterns: List[Dict[str, Any]] = []
    seen_keys: Set[Tuple[str, str, str, str, str, Fraction, str]] = set()
    comp_types = (exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between)
    comp_nodes = ([root_node] if isinstance(root_node, comp_types) else []) + [
        n for n in root_node.find_all(comp_types) if n is not root_node
    ]

    for comp in comp_nodes:
        if comp.find_ancestor((exp.Where, exp.Having, exp.Join)) is None:
            continue
        if comp.find_ancestor((exp.AggFunc, exp.Case)) is not None:
            continue

        curr_p = comp.parent
        not_cnt = 0
        is_not_exists = False
        while curr_p:
            if isinstance(curr_p, exp.Not):
                not_cnt += 1
            if isinstance(curr_p, exp.Exists) and curr_p.parent and isinstance(curr_p.parent, exp.Not):
                is_not_exists = True
                break
            curr_p = curr_p.parent
        if is_not_exists:
            continue
        is_neg = (not_cnt % 2 == 1) ^ bool(comp.args.get("negate"))

        expr_side: Optional[exp.Expression] = None
        bound_f: Optional[Fraction] = None
        op_name: str = "EQ"

        if isinstance(comp, exp.Between):
            low_f = _extract_numeric_fraction(comp.args.get("low"))
            high_f = _extract_numeric_fraction(comp.args.get("high"))
            if low_f is None or high_f is None or comp.this is None or not comp.this.find(exp.Div):
                continue
            expr_side = comp.this
            if is_neg:
                op_name = "LT"
                bound_f = min(low_f, high_f)
            else:
                op_name = "BETWEEN"
                bound_f = (low_f + high_f) / 2
        elif hasattr(comp, "left") and hasattr(comp, "right"):
            l_f = _extract_numeric_fraction(comp.left)
            r_f = _extract_numeric_fraction(comp.right)
            if r_f is not None and comp.left is not None and comp.left.find(exp.Div):
                expr_side = comp.left
                bound_f = r_f
                op_name = comp.__class__.__name__.upper()
            elif l_f is not None and comp.right is not None and comp.right.find(exp.Div):
                expr_side = comp.right
                bound_f = l_f
                op_name = flip_op_map.get(comp.__class__.__name__.upper(), "EQ")
            else:
                continue

            if is_neg:
                neg_map = {
                    "GT": "LTE",
                    "GTE": "LT",
                    "LT": "GTE",
                    "LTE": "GT",
                    "EQ": "NEQ",
                    "NEQ": "EQ",
                }
                op_name = neg_map.get(op_name, op_name)
        else:
            continue

        if expr_side is None or bound_f is None:
            continue

        decomposed = _decompose_ratio_expr(expr_side, bound_f, op_name)
        if decomposed is None:
            continue

        key = (
            decomposed["num_table"].upper(),
            decomposed["num_column"].upper(),
            decomposed["denom_table"].upper(),
            decomposed["denom_column"].upper(),
            decomposed["op"],
            decomposed["ratio"],
            decomposed["mode"],
        )
        if key not in seen_keys:
            seen_keys.add(key)
            patterns.append({
                **decomposed,
                "node": comp,
            })

    return patterns


def compute_ratio_comparison_values(
    schema: Schema,
    pat: Dict[str, Any],
) -> Dict[str, Any]:
    """
    Compute deterministic satisfying `(num_val, denom_val)` values for a ratio
    comparison pattern `pat` (`num / denom OP ratio` or `num / (num + denom) OP ratio`).

    Choosing `d_scaled >= 2 * q` with `n_scaled = p * (d_scaled // q)` guarantees:
      - For `LT` / `LTE`: `(n_scaled - 1, d_scaled)` is strictly positive (`>= 1`)
        whenever `ratio > 0` and strictly less than `p / q` under both floating-point
        and truncating integer division.
      - For `GT` / `GTE` / `NEQ`: `(n_scaled + step, d_scaled)` with
        `step = ceil(d_scaled / total_scale)` is strictly greater than `p / q` under
        both floating-point and truncating integer division.
      - For `EQ` / `BETWEEN`: `(p, q)` equals `p / q` exactly.
    """
    ratio: Fraction = pat["ratio"]
    total_scale: Fraction = pat.get("total_scale", Fraction(1))
    op: str = pat.get("op", "EQ").upper()
    mode: str = pat.get("mode", "direct")

    p = ratio.numerator
    q = ratio.denominator
    scale_int = min(100000, max(1000, int(math.ceil(float(total_scale))) * 10))
    d_scaled = math.lcm(q, scale_int)
    if d_scaled > 1000000:
        d_scaled = q * max(2, 1000 // q)
    if d_scaled < 2 * q:
        d_scaled = 2 * q
    n_scaled = p * (d_scaled // q)
    step = max(1, int(math.ceil(float(d_scaled) / float(max(Fraction(1), total_scale)))))

    if mode == "share_add":
        if op in ("EQ", "BETWEEN"):
            raw_num, raw_denom = p, max(1, q - p)
        elif op in ("LT", "LTE"):
            raw_num = n_scaled - 1
            raw_denom = max(1, d_scaled - raw_num)
        else:
            cand_num = min(d_scaled - 1, n_scaled + step) if d_scaled > n_scaled + 1 else n_scaled + 1
            raw_num = cand_num
            raw_denom = max(1, d_scaled - cand_num)
    else:
        if op in ("EQ", "BETWEEN"):
            raw_num, raw_denom = p, q
        elif op in ("LT", "LTE"):
            raw_num, raw_denom = n_scaled - 1, d_scaled
        else:
            raw_num, raw_denom = n_scaled + step, d_scaled
            if raw_num <= 0:
                raw_num, raw_denom = 1, 1

    num_col = schema.find_column(pat["num_table"], pat["num_column"])
    denom_col = schema.find_column(pat["denom_table"], pat["denom_column"])

    def _format_for_col(val: int, col: Optional[Column]) -> int | float:
        if col and any(t in (col.data_type or "").lower() for t in ("real", "float", "double", "decimal")):
            return float(val)
        return int(val)

    return {
        "num_val": _format_for_col(raw_num, num_col),
        "denom_val": _format_for_col(raw_denom, denom_col),
    }


def differentiate_conditional_aggregates_across_groups(
    schema: Schema,
    parsed_query: Dict[str, Any],
    equiv: UnionFind,
    group_targets: Set[Tuple[str, str]],
    group1: Dict[str, List[Dict[str, Any]]],
    group2: Dict[str, List[Dict[str, Any]]],
    extra_locked: Optional[Set[Tuple[str, str]]] = None,
) -> None:
    """
    Populate contrasting satisfying vs. non-matching values across `group1` and `group2`
    for columns referenced in conditional aggregate expressions (`SUM(col = lit)`,
    `AGG(CASE WHEN cond ...)`, `AGG(IIF(cond, ...))`, `AGG(...) FILTER (WHERE cond)`).

    Ensures that merging `group1` and `group2` into a single group yields a different
    conditional aggregate value (or ratio/percentage) than evaluating `group1` and `group2`
    as separate groups.
    """
    ast = parsed_query.get("ast")
    if not ast:
        return

    protected_roots: Set[Tuple[str, str]] = set()
    for t_name, c_name in group_targets:
        protected_roots.add(equiv.find(col_key(t_name, c_name)))
    if extra_locked:
        for t_name, c_name in extra_locked:
            protected_roots.add(equiv.find(col_key(t_name, c_name)))

    for lit in parsed_query.get("where_literals", []):
        col_name = lit.get("column", "")
        if col_name:
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), col_name)
            if res:
                protected_roots.add(equiv.find(col_key(res[0], res[1])))

    for pair in parsed_query.get("where_joins", []):
        for side in ("left", "right"):
            s = pair.get(side, {})
            res = resolve_query_column(schema, parsed_query, s.get("table", ""), s.get("column", ""))
            if res:
                protected_roots.add(equiv.find(col_key(res[0], res[1])))

    for join in parsed_query.get("joins", []):
        for pair in join.get("on_pairs", []):
            for side in ("left", "right"):
                s = pair.get(side, {})
                res = resolve_query_column(schema, parsed_query, s.get("table", ""), s.get("column", ""))
                if res:
                    protected_roots.add(equiv.find(col_key(res[0], res[1])))

    referenced_fk_targets: Set[Tuple[str, str]] = set()
    for other_t in schema.tables.values():
        for fk in other_t.foreign_keys:
            referenced_fk_targets.add((fk.reference_table.upper(), fk.reference_column.upper()))

    def _unwrap_col(node: Optional[exp.Expression]) -> Optional[exp.Column]:
        curr = node
        while isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren)):
            curr = curr.this
        return curr if isinstance(curr, exp.Column) else None

    comp_types = (
        exp.EQ, exp.NEQ, exp.In, exp.GT, exp.GTE,
        exp.LT, exp.LTE, exp.Like, exp.ILike,
    )

    col_sat_vals: Dict[Tuple[str, str], List[Any]] = {}
    col_explicit_viol: Dict[Tuple[str, str], List[Any]] = {}
    col_disallowed: Dict[Tuple[str, str], Set[Any]] = {}
    col_is_ratio: Dict[Tuple[str, str], bool] = {}

    for agg_node in ast.find_all((exp.AggFunc, exp.Filter)):
        if agg_node.find_ancestor((exp.Where, exp.Having)) is not None:
            continue
        if isinstance(agg_node, exp.AggFunc) and isinstance(agg_node.parent, exp.Filter):
            continue

        enclosing_sel = agg_node.find_ancestor(exp.Select)
        is_ratio_or_avg = (
            isinstance(agg_node, exp.Avg)
            or (isinstance(agg_node, exp.Filter) and isinstance(agg_node.this, exp.Avg))
            or (agg_node.find_ancestor((exp.Div, exp.Avg)) is not None)
        )

        candidate_comps: List[Tuple[exp.Expression, bool]] = []
        for case_node in agg_node.find_all(exp.Case):
            if case_node.find_ancestor(exp.Select) is not enclosing_sel:
                continue
            case_op = _unwrap_col(case_node.this)
            if case_op is not None:
                for if_b in case_node.args.get("ifs") or []:
                    if isinstance(if_b.this, exp.Literal):
                        syn_eq = exp.EQ(this=case_op.copy(), expression=if_b.this.copy())
                        candidate_comps.append((syn_eq, False))

        for comp in agg_node.find_all(comp_types):
            if comp.find_ancestor(exp.Select) is not enclosing_sel:
                continue
            not_cnt = 0
            curr_p = comp.parent
            while curr_p and curr_p is not agg_node.parent:
                if isinstance(curr_p, exp.Not):
                    not_cnt += 1
                curr_p = curr_p.parent
            is_neg = (not_cnt % 2 == 1) ^ bool(comp.args.get("negate"))
            candidate_comps.append((comp, is_neg))

        for comp, is_neg in candidate_comps:
            col_node: Optional[exp.Column] = None
            lit_node: Optional[exp.Literal] = None
            col_on_left = True

            if isinstance(comp, exp.In):
                col_node = _unwrap_col(comp.this)
            else:
                l_col = _unwrap_col(comp.left)
                r_col = _unwrap_col(comp.right)
                if l_col is not None and isinstance(comp.right, exp.Literal):
                    col_node = l_col
                    lit_node = comp.right
                    col_on_left = True
                elif r_col is not None and isinstance(comp.left, exp.Literal):
                    col_node = r_col
                    lit_node = comp.left
                    col_on_left = False

            if col_node is None:
                continue

            resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if not resolved:
                continue
            t_name, c_name = resolved
            if equiv.find(col_key(t_name, c_name)) in protected_roots:
                continue

            t_obj = schema.tables.get(t_name)
            col_obj = schema.find_column(t_name, c_name)
            if not t_obj or not col_obj or col_obj.is_primary_key or col_obj.is_unique:
                continue
            if any(fk.column_name.upper() == c_name.upper() for fk in t_obj.foreign_keys):
                continue
            if (t_name.upper(), c_name.upper()) in referenced_fk_targets:
                continue

            sat_v: Any = None
            viol_v: Any = None
            dis_set: Set[Any] = set()

            if isinstance(comp, (exp.EQ, exp.NEQ)) and lit_node is not None:
                eff_eq = isinstance(comp, exp.EQ) ^ is_neg
                coerced = coerce_literal_for_column(col_obj, lit_node.name)
                if eff_eq:
                    sat_v = coerced
                    dis_set.add(coerced)
                else:
                    viol_v = coerced
                    dis_set.add(coerced)
                    sat_v = next_distinct_value(col_obj, coerced, schema=schema, table_name=t_name)
            elif isinstance(comp, exp.In):
                in_vals = [
                    coerce_literal_for_column(col_obj, e.name)
                    for e in (comp.expressions or [])
                    if isinstance(e, exp.Literal)
                ]
                if not in_vals:
                    continue
                dis_set.update(in_vals)
                if not is_neg:
                    sat_v = in_vals[0]
                else:
                    viol_v = in_vals[0]
                    sat_v = next_distinct_value(col_obj, viol_v, schema=schema, table_name=t_name)
                    attempts = 0
                    while sat_v in dis_set and attempts < 20:
                        sat_v = next_distinct_value(col_obj, sat_v, schema=schema, table_name=t_name)
                        attempts += 1
            elif isinstance(comp, (exp.GT, exp.GTE, exp.LT, exp.LTE)) and lit_node is not None:
                bound_val = coerce_literal_for_column(col_obj, lit_node.name)
                if not isinstance(bound_val, (int, float)) or isinstance(bound_val, bool):
                    continue
                wants_gt = isinstance(comp, (exp.GT, exp.GTE))
                if not col_on_left:
                    wants_gt = not wants_gt
                if is_neg:
                    wants_gt = not wants_gt
                step = 1.0 if isinstance(bound_val, float) else 1
                if wants_gt:
                    sat_v = bound_val + step
                    viol_v = bound_val - step
                else:
                    sat_v = bound_val - step
                    viol_v = bound_val + step
                dis_set.add(sat_v)
            elif isinstance(comp, (exp.Like, exp.ILike)) and lit_node is not None:
                pat_val = value_matching_like_pattern(col_obj, lit_node.name)
                dis_set.add(pat_val)
                if not is_neg:
                    sat_v = pat_val
                else:
                    viol_v = pat_val
                    sat_v = next_distinct_value(col_obj, pat_val, schema=schema, table_name=t_name)

            if sat_v is None:
                continue

            key = (t_name, c_name)
            s_list = col_sat_vals.setdefault(key, [])
            if sat_v not in s_list:
                s_list.append(sat_v)
            if viol_v is not None:
                v_list = col_explicit_viol.setdefault(key, [])
                if viol_v not in v_list:
                    v_list.append(viol_v)
            col_disallowed.setdefault(key, set()).update(dis_set)
            col_is_ratio[key] = col_is_ratio.get(key, False) or is_ratio_or_avg

    for (t_name, c_name), sat_vals in col_sat_vals.items():
        rows1 = group1.get(t_name)
        rows2 = group2.get(t_name)
        if not rows1 or not rows2:
            continue
        col_obj = schema.find_column(t_name, c_name)
        if not col_obj:
            continue

        if len(sat_vals) >= 2:
            if len(rows1) >= 3:
                tail_vals = sat_vals[1:]
                split_idx = max(1, len(rows1) - len(tail_vals))
                for i in range(split_idx):
                    rows1[i][c_name] = sat_vals[0]
                for i in range(split_idx, len(rows1)):
                    rows1[i][c_name] = tail_vals[(i - split_idx) % len(tail_vals)]
            else:
                for r in rows1:
                    r[c_name] = sat_vals[0]

            if len(rows2) >= 2:
                rows2[0][c_name] = sat_vals[0]
                tail_vals = sat_vals[1:]
                for i in range(1, len(rows2)):
                    rows2[i][c_name] = tail_vals[(i - 1) % len(tail_vals)]
            else:
                rows2[0][c_name] = sat_vals[1]
        else:
            v_sat = sat_vals[0]
            expl_v = col_explicit_viol.get((t_name, c_name), [])
            dis_v = col_disallowed.get((t_name, c_name), {v_sat})
            if expl_v:
                v_viol = expl_v[0]
            else:
                v_viol = next_distinct_value(col_obj, v_sat, schema=schema, table_name=t_name)
                attempts = 0
                while v_viol in dis_v and attempts < 20:
                    v_viol = next_distinct_value(col_obj, v_viol, schema=schema, table_name=t_name)
                    attempts += 1

            for r in rows1:
                r[c_name] = v_sat

            if col_is_ratio.get((t_name, c_name), False) or len(rows2) < 2:
                for r in rows2:
                    r[c_name] = v_viol
            else:
                rows2[0][c_name] = v_sat
                for r in rows2[1:]:
                    r[c_name] = v_viol

