"""
DistinctAttackStrategy Module

Target semantic bug: Missing, misplaced, or over-extended DISTINCT modifier in SELECT queries.
Algorithm & Dataset Design:
1. Row-level duplication: Creates duplicate joined rows in the dataset where non-distinct
   projected values duplicate each other while non-projected PK/UNIQUE columns and
   inequality-constrained non-projected WHERE columns vary to distinct satisfying values.
   When ORDER BY (with or without LIMIT/OFFSET) is present, selects the top-ranked joined
   tuple according to the ORDER BY specification so the duplicated projection appears within
   the top-K LIMIT window.
2. Non-functional-dependency (non-FD) and multi-column projection duplication: When SELECT
   DISTINCT projects an anchored single-column PK/UNIQUE table alongside non-key columns of a
   many-side joined table, or projects multiple non-equivalent columns/aliases (E_1, E_2, ...),
   constructs a companion dataset where the first/anchored projected column remains constant
   across the duplicate tuple while trailing projected non-key columns vary to distinct
   satisfying values, separating `SELECT DISTINCT E_1` from `SELECT DISTINCT E_1, E_2`.
3. Partial GROUP BY group duplication: When the query groups by columns G (at the top level
   or in a derived table) and projects a strict subset P (so G \\ P is non-empty), constructs
   two distinct satisfying groups that share identical projected column values P, differ on
   the unprojected grouping columns G \\ P, and yield distinct group cardinalities/aggregate
   values (N vs N + 1). Top-level DISTINCT collapses both groups into 1 row, while mutants
   omitting outer DISTINCT or applying DISTINCT inside a subquery over (P, agg) return 2 rows.
"""

from datetime import timedelta
import functools
import re
from typing import Any, Dict, List, Set, Tuple
import copy

from dateutil.parser import parse as dateutil_parse
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator.value_generator import DataFactory, generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    generate_base_dataset,
    merge_datasets,
    next_distinct_value,
    resolve_query_column,
    UnionFind,
)


def _is_in_predicate_subquery(node: exp.Expression) -> bool:
    curr = node.parent
    while curr:
        if isinstance(curr, exp.Subquery) and not isinstance(curr.parent, (exp.From, exp.Join)):
            return True
        if isinstance(curr, exp.Exists):
            return True
        curr = curr.parent
    return False


def _has_agg_upper_or_eq_bound(ast: exp.Expression | None) -> bool:
    if not ast:
        return False
    agg_aliases: Set[str] = set()
    for sel in ast.find_all(exp.Select):
        for expr in sel.expressions:
            if isinstance(expr, exp.Alias) and expr.alias and expr.find(exp.AggFunc):
                agg_aliases.add(expr.alias.upper())

    def _is_agg_operand(node: exp.Expression | None) -> bool:
        if not node:
            return False
        if isinstance(node, exp.AggFunc) or node.find(exp.AggFunc):
            return True
        if agg_aliases:
            for col in node.find_all(exp.Column):
                if (col.name or "").upper() in agg_aliases:
                    return True
        return False

    for between in ast.find_all(exp.Between):
        if _is_agg_operand(between.this):
            return True

    for comp in ast.find_all((exp.EQ, exp.LT, exp.LTE, exp.GT, exp.GTE)):
        left_agg = _is_agg_operand(comp.left)
        right_agg = _is_agg_operand(comp.right)
        if not left_agg and not right_agg:
            continue
        if isinstance(comp, exp.EQ):
            return True
        if left_agg and isinstance(comp, (exp.LT, exp.LTE)):
            return True
        if right_agg and isinstance(comp, (exp.GT, exp.GTE)):
            return True
    return False


def get_partial_group_by_targets(
    schema: Schema, parsed_query: Dict[str, Any]
) -> Tuple[List[Tuple[str, str]], List[Tuple[str, str]], List[Tuple[str, str]]] | None:
    """
    Identify queries that group by a set of columns G (at top level or in a derived table)
    and project a subset of columns P at the top level such that G \\ P is non-empty.
    """
    ast = parsed_query.get("ast")
    if ast:
        non_pred_groups = [
            g for g in ast.find_all(exp.Group) if not _is_in_predicate_subquery(g)
        ]
        if not non_pred_groups:
            return None

    top_projected: List[Tuple[str, str]] = []
    for s in parsed_query.get("selects", []):
        res = resolve_query_column(schema, parsed_query, s.get("table", ""), s["column"])
        if res and res not in top_projected:
            top_projected.append(res)

    if isinstance(ast, exp.Select):
        for expr in ast.expressions:
            if list(expr.find_all(exp.AggFunc)):
                continue
            for col in expr.find_all(exp.Column):
                res = resolve_query_column(schema, parsed_query, col.table, col.name)
                if res and res not in top_projected:
                    top_projected.append(res)

    if not top_projected:
        return None

    group_by_cols: List[Tuple[str, str]] = []
    for gb in parsed_query.get("group_by", []):
        res = resolve_query_column(schema, parsed_query, gb.get("table", ""), gb["column"])
        if res and res not in group_by_cols:
            group_by_cols.append(res)

    if not group_by_cols:
        return None

    top_projected_upper = {(t.upper(), c.upper()) for t, c in top_projected}
    equiv, _, _ = build_equivalence_classes(schema, parsed_query)
    projected_roots = {equiv.find(col_key(t, c)) for t, c in top_projected}

    eq_locked_roots = set()
    for lit in parsed_query.get("where_literals", []):
        if (lit.get("operator") or "").upper() == "EQ":
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                eq_locked_roots.add(equiv.find(col_key(res[0], res[1])))

    valid_unprojected_gb_cols: List[Tuple[str, str]] = []
    for t_u, c_u in group_by_cols:
        if (t_u.upper(), c_u.upper()) in top_projected_upper:
            continue
        root = equiv.find(col_key(t_u, c_u))
        if root in projected_roots or root in eq_locked_roots:
            continue
        table_u = schema.tables.get(t_u)
        if not table_u:
            continue
        pk_cols_u = [col for col in table_u.columns if col.is_primary_key]
        blocked = False
        for col in table_u.columns:
            if col.is_unique or (col.is_primary_key and len(pk_cols_u) == 1):
                if equiv.find(col_key(t_u, col.name)) in projected_roots:
                    blocked = True
                    break
        if not blocked:
            valid_unprojected_gb_cols.append((t_u, c_u))

    if not valid_unprojected_gb_cols:
        return None

    return top_projected, group_by_cols, valid_unprojected_gb_cols


def build_partial_group_by_distinct_dataset(
    schema: Schema,
    parsed_query: Dict[str, Any],
    strategy_name: str,
    tags: List[str],
    description: str,
) -> Dataset | None:
    """
    Construct a two-group dataset for queries where GROUP BY contains unprojected
    columns (G \\ P != empty). Both groups share identical projected column values P,
    differ on unprojected grouping columns G \\ P, satisfy all WHERE/HAVING predicates,
    and have distinct group cardinalities / aggregate values (N vs N + 1 when no upper
    or equality aggregate bound forbids it) so that inner DISTINCT over (P, agg) does
    not collapse them.
    """
    targets_info = get_partial_group_by_targets(schema, parsed_query)
    if not targets_info:
        return None

    top_projected, group_by_cols, valid_unprojected_gb_cols = targets_info
    equiv, _, _ = build_equivalence_classes(schema, parsed_query)
    projected_roots = {equiv.find(col_key(t, c)) for t, c in top_projected}
    group_by_roots = {equiv.find(col_key(t, c)) for t, c in group_by_cols}

    eq_locked_roots = set()
    for lit in parsed_query.get("where_literals", []):
        if (lit.get("operator") or "").upper() == "EQ":
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                eq_locked_roots.add(equiv.find(col_key(res[0], res[1])))

    DataFactory.get_instance().clear_uniqueness()
    group1 = generate_base_dataset(
        schema, parsed_query, cache_key_salt="dist_partial_gb_1", include_limit_padding=False
    )

    value_injections: Dict[Tuple[str, str], Any] = {}
    for t_p, c_p in top_projected:
        if group1.get(t_p) and group1[t_p]:
            val_p = group1[t_p][0].get(c_p)
            if val_p is not None:
                value_injections[(t_p, c_p)] = val_p

    for t_g, c_g in group_by_cols:
        if equiv.find(col_key(t_g, c_g)) in projected_roots:
            if group1.get(t_g) and group1[t_g]:
                val_g = group1[t_g][0].get(c_g)
                if val_g is not None:
                    value_injections[(t_g, c_g)] = val_g

    unproj_new_vals: Dict[Tuple[str, str], Any] = {}
    for t_u, c_u in valid_unprojected_gb_cols:
        if not group1.get(t_u) or not group1[t_u]:
            continue
        existing_u = group1[t_u][0].get(c_u)
        col_u = schema.find_column(t_u, c_u)
        if col_u is not None:
            new_u = next_distinct_value(col_u, existing_u, schema=schema, table_name=t_u)
            new_u = solve_check_constraint_value(
                schema, t_u, c_u, col_u, new_u,
                disallowed_values={existing_u}, row_context=group1[t_u][0]
            )
            value_injections[(t_u, c_u)] = new_u
            unproj_new_vals[equiv.find(col_key(t_u, c_u))] = new_u

    if not unproj_new_vals:
        return None

    DataFactory.get_instance().clear_uniqueness()
    group2 = generate_base_dataset(
        schema,
        parsed_query,
        value_injections=value_injections,
        cache_key_salt="dist_partial_gb_2",
        include_limit_padding=False,
    )

    for t_name, rows in group2.items():
        if not rows or t_name not in schema.tables:
            continue
        for col in schema.tables[t_name].columns:
            root = equiv.find(col_key(t_name, col.name))
            if root in unproj_new_vals:
                for r in rows:
                    r[col.name] = unproj_new_vals[root]

    ast = parsed_query.get("ast")
    if not _has_agg_upper_or_eq_bound(ast):
        agg_cols_by_table: Dict[str, Set[str]] = {}
        if ast:
            for agg_node in ast.find_all(exp.AggFunc):
                if _is_in_predicate_subquery(agg_node):
                    continue
                for col_node in agg_node.find_all(exp.Column):
                    res = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                    if res:
                        agg_cols_by_table.setdefault(res[0], set()).add(res[1])

        target_tables = list(agg_cols_by_table.keys()) if agg_cols_by_table else list({t for t, _ in valid_unprojected_gb_cols})
        fixed_roots = projected_roots | group_by_roots | eq_locked_roots

        for t_name in target_tables:
            if not group2.get(t_name) or t_name not in schema.tables:
                continue
            table = schema.tables[t_name]
            last_row = group2[t_name][-1]
            extra_row = copy.deepcopy(last_row)
            fk_col_names = {fk.column_name.upper() for fk in table.foreign_keys}
            agg_cols = agg_cols_by_table.get(t_name, set())
            varied_any = False

            for col in table.columns:
                root = equiv.find(col_key(t_name, col.name))
                if root in fixed_roots or col.name.upper() in fk_col_names:
                    continue
                if col.is_primary_key or col.is_unique:
                    cand = generate_unique_value_for_column(col)
                    cand = solve_check_constraint_value(schema, t_name, col.name, col, cand, row_context=extra_row)
                    extra_row[col.name] = cand
                    varied_any = True
                elif col.name in agg_cols:
                    existing_vals = {
                        r.get(col.name) for r in (group1.get(t_name, []) + group2.get(t_name, []))
                    }
                    curr_val = last_row.get(col.name)
                    cand = next_distinct_value(col, curr_val, schema=schema, table_name=t_name)
                    cand = solve_check_constraint_value(
                        schema, t_name, col.name, col, cand,
                        disallowed_values=existing_vals, row_context=extra_row
                    )
                    extra_row[col.name] = cand
                    varied_any = True

            if not varied_any:
                for col in table.columns:
                    root = equiv.find(col_key(t_name, col.name))
                    if root in fixed_roots or col.name.upper() in fk_col_names:
                        continue
                    existing_vals = {
                        r.get(col.name) for r in (group1.get(t_name, []) + group2.get(t_name, []))
                    }
                    curr_val = last_row.get(col.name)
                    cand = next_distinct_value(col, curr_val, schema=schema, table_name=t_name)
                    cand = solve_check_constraint_value(
                        schema, t_name, col.name, col, cand,
                        disallowed_values=existing_vals, row_context=extra_row
                    )
                    extra_row[col.name] = cand
                    break

            group2[t_name].append(extra_row)

    merged_data = merge_datasets(schema, group1, group2)
    return Dataset(
        strategy_name=strategy_name,
        data=merged_data,
        tags=tags,
        description=description,
    )


def can_null_column_for_duplicate(
    schema: Schema,
    parsed_query: Dict[str, Any],
    table_name: str,
    column_name: str,
    allow_in_group_by: bool = False,
) -> bool:
    """
    Determine whether `(table_name, column_name)` can be set to NULL in duplicate
    rows to bypass composite PRIMARY KEY / UNIQUE constraints under SQLite semantics
    (where NULLs are distinct in UNIQUE/PK indexes) while preserving row survival and
    causing SELECT DISTINCT / GROUP BY (where NULL = NULL) to collapse the rows.

    Allows columns that participate on the preserved (left) side of a LEFT JOIN when
    the right-hand table of that LEFT JOIN has no WHERE/HAVING predicates.
    """
    table = schema.tables.get(table_name)
    if not table:
        return False
    col_obj = next((c for c in table.columns if c.name == column_name), None)
    if not col_obj or getattr(col_obj, "explicit_not_null", False) or col_obj.is_unique:
        return False
    pk_cols = [c for c in table.columns if c.is_primary_key]
    if col_obj.is_primary_key and len(pk_cols) == 1:
        return False
    if any(fk.column_name.upper() == column_name.upper() for fk in table.foreign_keys):
        return False
    for t_obj in schema.tables.values():
        for fk in t_obj.foreign_keys:
            if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                return False
    for cc in getattr(table, "check_constraints", []):
        expr = cc.get("expression")
        if expr and any((c.name or "").upper() == column_name.upper() for c in expr.find_all(exp.Column)):
            return False

    where_tables_upper: Set[str] = set()
    for lit in parsed_query.get("where_literals", []):
        res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
        if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
            return False

    ast = parsed_query.get("ast")
    if ast:
        forbidden_clauses = (
            (exp.Where, exp.Having, exp.AggFunc)
            if allow_in_group_by
            else (exp.Where, exp.Having, exp.Group, exp.AggFunc)
        )
        for clause in ast.find_all(forbidden_clauses):
            for c in clause.find_all(exp.Column):
                res = resolve_query_column(schema, parsed_query, c.table, c.name)
                if res:
                    if isinstance(clause, (exp.Where, exp.Having)):
                        where_tables_upper.add(res[0].upper())
                    if (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
                        return False
                elif (c.name or "").upper() == column_name.upper():
                    return False
    else:
        for wj in parsed_query.get("where_joins", []):
            for side in ("left", "right"):
                info = wj.get(side, {})
                res = resolve_query_column(schema, parsed_query, info.get("table", ""), info.get("column", ""))
                if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
                    return False

    for j in parsed_query.get("joins", []):
        if j.get("is_natural"):
            return False
        for u_col in j.get("using_cols", []):
            if str(u_col).upper() == column_name.upper():
                return False
        j_type = (j.get("type") or "INNER").upper()
        is_pure_left_join = ("LEFT" in j_type) and not any(
            k in j_type for k in ("RIGHT", "FULL", "INNER", "CROSS", "SUBQUERY")
        )
        j_right_alias = (j.get("alias") or j.get("table") or "").upper()
        j_right_table_raw = j.get("table") or ""
        j_right_table = (schema.find_table(j_right_table_raw) or j_right_table_raw).upper()

        for pair in j.get("on_pairs", []):
            for side in ("left", "right"):
                info = pair.get(side, {})
                res = resolve_query_column(schema, parsed_query, info.get("table", ""), info.get("column", ""))
                if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
                    if not is_pure_left_join:
                        return False
                    ref_qual = (info.get("table") or "").upper()
                    if ref_qual and ref_qual == j_right_alias:
                        return False
                    if not ref_qual and j_right_table == table_name.upper():
                        return False
                    if j_right_table in where_tables_upper:
                        return False

    if ast:
        for join_node in ast.find_all(exp.Join):
            using_expr = join_node.args.get("using")
            if using_expr:
                using_items = (
                    using_expr
                    if isinstance(using_expr, list)
                    else list(using_expr.find_all((exp.Identifier, exp.Column)))
                )
                if any(
                    ((u.name if isinstance(u, (exp.Identifier, exp.Column)) else str(u)) or "").upper()
                    == column_name.upper()
                    for u in using_items
                ):
                    return False
            on_expr = join_node.args.get("on")
            if on_expr:
                side_str = str(join_node.args.get("side") or "").upper()
                kind_str = str(join_node.args.get("kind") or "").upper()
                method_str = str(join_node.args.get("method") or "").upper()
                is_ast_left_join = (side_str == "LEFT") and (kind_str in ("", "OUTER")) and not method_str
                right_this = join_node.this
                right_alias_up = (
                    (right_this.alias or right_this.name) if isinstance(right_this, exp.Table) else ""
                ).upper()
                right_name_raw = (right_this.name if isinstance(right_this, exp.Table) else "") or ""
                right_table_up = (schema.find_table(right_name_raw) or right_name_raw).upper()

                for c in on_expr.find_all(exp.Column):
                    res = resolve_query_column(schema, parsed_query, c.table, c.name)
                    matches = (
                        res is not None
                        and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper())
                    ) or (res is None and (c.name or "").upper() == column_name.upper())
                    if matches:
                        if not is_ast_left_join:
                            return False
                        c_qual = (c.table or "").upper()
                        if c_qual and c_qual == right_alias_up:
                            return False
                        if not c_qual and right_table_up == table_name.upper():
                            return False
                        if right_table_up in where_tables_upper:
                            return False

    return True


_ISO_DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}(?:[ T]\d{2}:\d{2}(?::\d{2})?)?$")


def _extract_numeric_literal(node: exp.Expression | None) -> float | None:
    curr = node
    while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
        curr = curr.this
    if isinstance(curr, exp.Neg) and isinstance(curr.this, exp.Literal):
        try:
            return -float(curr.this.name)
        except (ValueError, TypeError):
            return None
    if isinstance(curr, exp.Literal):
        try:
            return float(curr.name)
        except (ValueError, TypeError):
            return None
    return None


def _extract_string_literal(node: exp.Expression | None) -> str | None:
    curr = node
    while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
        curr = curr.this
    if isinstance(curr, exp.Literal) and curr.name is not None:
        return str(curr.name)
    return None


def _extract_int_literal(node: exp.Expression | None) -> int | None:
    if node is None:
        return None
    v = _extract_numeric_literal(node)
    if v is not None and float(v).is_integer():
        return int(v)
    return None


def _unwrap_where_column_expr(
    c_node: exp.Column,
) -> Tuple[exp.Expression, str | None, bool, Tuple[int, int | None] | None]:
    expr_node: exp.Expression = c_node
    strftime_fmt: str | None = None
    cast_as_num: bool = False
    substr_meta: Tuple[int, int | None] | None = None
    while expr_node.parent is not None:
        parent = expr_node.parent
        if isinstance(parent, exp.Paren):
            expr_node = parent
        elif isinstance(parent, (exp.Cast, exp.TryCast)) and parent.this is expr_node:
            to_type = (parent.to.sql() if parent.to else "").upper()
            if any(k in to_type for k in ("INT", "REAL", "FLOA", "DOUB", "NUM", "DEC")):
                cast_as_num = True
            expr_node = parent
        elif isinstance(parent, exp.Substring) and parent.this is expr_node and substr_meta is None:
            st_val = _extract_int_literal(parent.args.get("start"))
            ln_val = _extract_int_literal(parent.args.get("length"))
            if st_val is not None and st_val >= 1 and (ln_val is not None or st_val > 1):
                substr_meta = (st_val, ln_val)
                expr_node = parent
            else:
                break
        elif isinstance(parent, exp.Anonymous):
            fn_name = (parent.name or "").lower()
            exprs = parent.expressions or []
            if (
                fn_name == "strftime"
                and len(exprs) >= 2
                and exprs[1] is expr_node
                and isinstance(exprs[0], exp.Literal)
                and strftime_fmt is None
            ):
                strftime_fmt = str(exprs[0].name)
                expr_node = parent
            elif (
                fn_name in ("year", "month", "day")
                and len(exprs) == 1
                and exprs[0] is expr_node
                and strftime_fmt is None
            ):
                strftime_fmt = {"year": "%Y", "month": "%m", "day": "%d"}[fn_name]
                expr_node = parent
            elif (
                fn_name in ("date", "datetime")
                and len(exprs) == 1
                and exprs[0] is expr_node
                and strftime_fmt is None
            ):
                strftime_fmt = "%Y-%m-%d" if fn_name == "date" else "%Y-%m-%d %H:%M:%S"
                expr_node = parent
            elif (
                fn_name in ("substr", "substring")
                and len(exprs) >= 2
                and exprs[0] is expr_node
                and substr_meta is None
            ):
                st_val = _extract_int_literal(exprs[1])
                ln_val = _extract_int_literal(exprs[2]) if len(exprs) >= 3 else None
                if st_val is not None and st_val >= 1 and (ln_val is not None or st_val > 1):
                    substr_meta = (st_val, ln_val)
                    expr_node = parent
                else:
                    break
            else:
                break
        elif isinstance(parent, exp.TimeToStr) and parent.this is expr_node and strftime_fmt is None:
            fmt_node = parent.args.get("format")
            if isinstance(fmt_node, exp.Literal):
                strftime_fmt = str(fmt_node.name)
                expr_node = parent
            else:
                break
        elif isinstance(parent, exp.Extract) and parent.expression is expr_node and strftime_fmt is None:
            part = (parent.name or "").upper()
            part_map = {"YEAR": "%Y", "MONTH": "%m", "DAY": "%d", "HOUR": "%H", "MINUTE": "%M", "SECOND": "%S"}
            if part in part_map:
                strftime_fmt = part_map[part]
                expr_node = parent
            else:
                break
        elif isinstance(parent, (exp.Date, exp.TsOrDsToDate)) and parent.this is expr_node and strftime_fmt is None:
            strftime_fmt = "%Y-%m-%d"
            expr_node = parent
        else:
            break
    return expr_node, strftime_fmt, cast_as_num, substr_meta


def distinct_satisfying_where_value(
    schema: Schema,
    parsed_query: Dict[str, Any],
    table_name: str,
    col: Any,
    original_row: Dict[str, Any],
    duplicate_row: Dict[str, Any],
    allow_in_select: bool = False,
    disallowed_values: Set[Any] | None = None,
) -> Any:
    """
    Produce a value for `col` distinct from `original_row[col.name]` (and any
    `disallowed_values`) that still satisfies WHERE range/inequality/set-membership/
    date-part/substring/LIKE constraints and schema CHECK constraints on `(table_name, col.name)`.
    """
    orig_val = original_row.get(col.name)
    if orig_val is None or isinstance(orig_val, bool) or not isinstance(orig_val, (int, float, str)):
        return None
    forbidden: Set[Any] = {orig_val}
    if disallowed_values:
        forbidden.update(disallowed_values)

    table = schema.tables.get(table_name)
    if not table:
        return None
    if any(fk.column_name.upper() == col.name.upper() for fk in table.foreign_keys):
        return None
    for t_obj in schema.tables.values():
        for fk in t_obj.foreign_keys:
            if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == col.name.upper():
                return None

    ast = parsed_query.get("ast")
    if not ast:
        return None
    if not allow_in_select:
        for sel in ast.find_all(exp.Select):
            for e in sel.expressions or []:
                if isinstance(e, exp.Star) or (isinstance(e, exp.Column) and isinstance(e.this, exp.Star)):
                    return None

    matching_col_nodes: List[exp.Column] = []
    for c_node in ast.find_all(exp.Column):
        res = resolve_query_column(schema, parsed_query, c_node.table, c_node.name)
        if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), col.name.upper()):
            matching_col_nodes.append(c_node)
        elif not res and (c_node.name or "").upper() == col.name.upper():
            matching_col_nodes.append(c_node)

    if not matching_col_nodes:
        return None

    is_num = isinstance(orig_val, (int, float))
    bounds: List[Tuple[str, Any, str | None, bool, Tuple[int, int | None] | None]] = []

    def _extract_bound_lit(
        node: exp.Expression | None,
        strftime_fmt: str | None,
        cast_as_num: bool,
        substr_meta: Tuple[int, int | None] | None,
    ) -> Tuple[Any, bool]:
        if substr_meta is not None:
            if cast_as_num:
                return _extract_numeric_literal(node), True
            return _extract_string_literal(node), False
        if strftime_fmt is not None:
            if cast_as_num:
                return _extract_numeric_literal(node), True
            curr = node
            while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
                curr = curr.this
            if isinstance(curr, (exp.Literal, exp.Neg)) and not getattr(curr, "is_string", False):
                num_v = _extract_numeric_literal(node)
                if num_v is not None:
                    return num_v, True
            return _extract_string_literal(node), False
        if is_num or cast_as_num:
            return _extract_numeric_literal(node), True
        return _extract_string_literal(node), False

    for c_node in matching_col_nodes:
        if c_node.find_ancestor((exp.Group, exp.Order, exp.Having, exp.Window, exp.Exists)) is not None:
            return None
        if c_node.find_ancestor(exp.AggFunc) is not None:
            return None
        if _is_in_predicate_subquery(c_node):
            return None
        if not allow_in_select and c_node.find_ancestor((exp.Subquery, exp.CTE)) is not None:
            return None
        join_anc = c_node.find_ancestor(exp.Join)
        if join_anc is not None:
            enclosing_sel = c_node.find_ancestor(exp.Select)
            if enclosing_sel is None or not enclosing_sel.find_ancestor(exp.Subquery):
                return None
            if join_anc.find_ancestor(exp.Select) is enclosing_sel:
                return None
        if c_node.find_ancestor(exp.Where) is None:
            if allow_in_select and c_node.find_ancestor(exp.Select) is not None:
                continue
            return None

        expr_node, strftime_fmt, cast_as_num, substr_meta = _unwrap_where_column_expr(c_node)
        parent = expr_node.parent
        if parent is None:
            return None

        not_cnt = 0
        curr: exp.Expression | None = parent
        while curr:
            if isinstance(curr, exp.Not):
                not_cnt += 1
            curr = curr.parent
        if parent.find_ancestor((exp.Case, exp.If)) is not None:
            return None

        if not_cnt % 2 == 1:
            if (
                isinstance(parent, exp.In)
                and parent.this is expr_node
                and not parent.args.get("query")
                and parent.expressions
            ):
                for item in parent.expressions:
                    item_val, b_num = _extract_bound_lit(item, strftime_fmt, cast_as_num, substr_meta)
                    if item_val is None:
                        return None
                    bounds.append(("NEQ", item_val, strftime_fmt, b_num, substr_meta))
                continue
            if isinstance(parent, (exp.Like, exp.ILike)) and parent.this is expr_node:
                pat_val = _extract_string_literal(parent.expression)
                if pat_val is None:
                    return None
                bounds.append(("NOT_LIKE", pat_val, strftime_fmt, False, substr_meta))
                continue
            return None

        allowed_comp_types = (
            (exp.EQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)
            if (strftime_fmt is not None or substr_meta is not None)
            else (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)
        )
        if isinstance(parent, allowed_comp_types):
            if parent.left is expr_node:
                other = parent.right
                col_on_left = True
            elif parent.right is expr_node:
                other = parent.left
                col_on_left = False
            else:
                return None
            lit_val, b_num = _extract_bound_lit(other, strftime_fmt, cast_as_num, substr_meta)
            if lit_val is None:
                return None
            raw_op = parent.__class__.__name__.upper()
            if not col_on_left:
                flip_map = {"EQ": "EQ", "GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "NEQ": "NEQ"}
                eff_op = flip_map[raw_op]
            else:
                eff_op = raw_op
            bounds.append((eff_op, lit_val, strftime_fmt, b_num, substr_meta))
        elif isinstance(parent, exp.Between) and parent.this is expr_node:
            low_val, b_num_low = _extract_bound_lit(parent.args.get("low"), strftime_fmt, cast_as_num, substr_meta)
            high_val, b_num_high = _extract_bound_lit(parent.args.get("high"), strftime_fmt, cast_as_num, substr_meta)
            if low_val is None or high_val is None:
                return None
            bounds.append(("GTE", low_val, strftime_fmt, b_num_low, substr_meta))
            bounds.append(("LTE", high_val, strftime_fmt, b_num_high, substr_meta))
        elif (
            isinstance(parent, exp.In)
            and parent.this is expr_node
            and not parent.args.get("query")
            and parent.expressions
        ):
            in_vals = []
            b_num_in = False
            for item in parent.expressions:
                item_val, b_num_item = _extract_bound_lit(item, strftime_fmt, cast_as_num, substr_meta)
                if item_val is None:
                    return None
                b_num_in = b_num_item
                in_vals.append(item_val)
            bounds.append(("IN", in_vals, strftime_fmt, b_num_in, substr_meta))
        elif isinstance(parent, (exp.Like, exp.ILike)) and parent.this is expr_node:
            pat_val = _extract_string_literal(parent.expression)
            if pat_val is None or ("%" not in pat_val and "_" not in pat_val and substr_meta is None):
                return None
            bounds.append(("LIKE", pat_val, strftime_fmt, False, substr_meta))
        else:
            return None

    if not bounds:
        return None

    def _like_matches(val_s: str, pat_s: str) -> bool:
        parts = ["^"]
        for ch in pat_s:
            if ch == "%":
                parts.append(".*")
            elif ch == "_":
                parts.append(".")
            else:
                parts.append(re.escape(ch))
        parts.append("$")
        return bool(re.match("".join(parts), val_s, flags=re.IGNORECASE | re.DOTALL))

    def _satisfies_bounds(v: Any) -> bool:
        for op, lit, fmt, b_num, s_meta in bounds:
            work_v: Any = v
            if s_meta is not None:
                st_pos, ln_val = s_meta
                s_str = str(work_v)
                work_v = s_str[st_pos - 1 : st_pos - 1 + ln_val] if ln_val is not None else s_str[st_pos - 1 :]
            if fmt is not None:
                if not isinstance(work_v, str):
                    return False
                try:
                    dt_v = dateutil_parse(work_v)
                    eval_v: Any = dt_v.strftime(fmt)
                except Exception:
                    return False
                if b_num:
                    try:
                        eval_v = float(eval_v)
                    except (ValueError, TypeError):
                        return False
            else:
                if b_num:
                    try:
                        eval_v = float(work_v)
                    except (ValueError, TypeError):
                        return False
                else:
                    eval_v = str(work_v) if s_meta is not None else work_v

            if op == "EQ" and not (eval_v == lit):
                return False
            elif op == "GT" and not (eval_v > lit):
                return False
            elif op == "GTE" and not (eval_v >= lit):
                return False
            elif op == "LT" and not (eval_v < lit):
                return False
            elif op == "LTE" and not (eval_v <= lit):
                return False
            elif op == "NEQ" and not (eval_v != lit):
                return False
            elif op == "IN" and eval_v not in lit:
                return False
            elif op == "LIKE" and not _like_matches(str(eval_v), str(lit)):
                return False
            elif op == "NOT_LIKE" and _like_matches(str(eval_v), str(lit)):
                return False
        return True

    if is_num:
        candidates: List[Any] = []
        for op, lit, _, _, _ in bounds:
            if op == "IN":
                for v in lit:
                    candidates.append(int(v) if isinstance(orig_val, int) and float(v).is_integer() else float(v))
        if isinstance(orig_val, int):
            candidates.extend([orig_val + 1, orig_val - 1, orig_val + 2, orig_val - 2])
        else:
            candidates.extend([orig_val + 1.0, orig_val - 1.0, orig_val + 0.5, orig_val - 0.5, orig_val + 2.0, orig_val - 2.0])

        for cand in candidates:
            if cand not in forbidden and _satisfies_bounds(cand):
                checked = solve_check_constraint_value(
                    schema, table_name, col.name, col, cand,
                    disallowed_values=forbidden, row_context=duplicate_row
                )
                if (
                    checked not in forbidden
                    and isinstance(checked, (int, float))
                    and not isinstance(checked, bool)
                    and _satisfies_bounds(checked)
                ):
                    return checked
        return None

    str_candidates: List[str] = []
    for op, lit, fmt, _, s_meta in bounds:
        if op == "IN" and fmt is None and s_meta is None:
            str_candidates.extend(str(v) for v in lit)
        if s_meta is not None:
            st_pos, ln_val = s_meta
            if ln_val is not None and len(orig_val) >= st_pos - 1 + ln_val:
                end_idx = st_pos - 1 + ln_val
                for ch in ("1", "2", "3", "a", "b"):
                    str_candidates.append(orig_val + ch)
                    if len(orig_val) > end_idx:
                        str_candidates.append(orig_val[:end_idx] + ch + orig_val[end_idx + 1 :])
            if st_pos > 1 and len(orig_val) >= st_pos - 1:
                for ch in ("1", "2", "3", "a", "b"):
                    str_candidates.append(ch + orig_val[1:])
        if op == "LIKE" and isinstance(lit, str):
            for ch in ("1", "2", "3", "a", "b"):
                str_candidates.append(lit.replace("%", ch).replace("_", ch))
                if lit.endswith("%"):
                    str_candidates.append(orig_val + ch)
                if lit.startswith("%"):
                    str_candidates.append(ch + orig_val)

    is_temp = bool(
        getattr(col, "is_temporal", False)
        or _ISO_DATE_RE.match(orig_val.strip())
        or any(fmt is not None for _, _, fmt, _, _ in bounds)
    )
    if is_temp:
        fmt = "%Y-%m-%d %H:%M:%S" if ":" in orig_val else "%Y-%m-%d"
        try:
            base_dt = dateutil_parse(orig_val)
            for delta in [1, -1, 2, -2, 7, -7, 30, -30, 365, -365]:
                str_candidates.append((base_dt + timedelta(days=delta)).strftime(fmt))
            if ":" in orig_val:
                str_candidates.append((base_dt + timedelta(hours=1)).strftime(fmt))
                str_candidates.append((base_dt - timedelta(hours=1)).strftime(fmt))
        except Exception:
            pass
        for op, lit, b_fmt, _, _ in bounds:
            if b_fmt is None and isinstance(lit, str) and _ISO_DATE_RE.match(lit.strip()):
                try:
                    lit_dt = dateutil_parse(lit)
                    str_candidates.append(lit)
                    str_candidates.append((lit_dt + timedelta(days=1)).strftime(fmt))
                    str_candidates.append((lit_dt - timedelta(days=1)).strftime(fmt))
                except Exception:
                    pass
    else:
        nxt = next_distinct_value(col, orig_val, schema=schema, table_name=table_name)
        if isinstance(nxt, str):
            str_candidates.append(nxt)

    seen_cands: Set[str] = set()
    for cand in str_candidates:
        if cand in seen_cands or cand in forbidden:
            continue
        seen_cands.add(cand)
        if _satisfies_bounds(cand):
            checked = solve_check_constraint_value(
                schema, table_name, col.name, col, cand,
                disallowed_values=forbidden, row_context=duplicate_row
            )
            if isinstance(checked, str) and checked not in forbidden and _satisfies_bounds(checked):
                return checked
    return None


def distinct_satisfying_disjunctive_row_overrides(
    schema: Schema,
    parsed_query: Dict[str, Any],
    table_name: str,
    original_row: Dict[str, Any],
    fixed_cols_upper: Set[str] | None = None,
) -> Dict[str, Any] | None:
    """
    When `table_name` has primary-key or unique columns constrained by a disjunctive
    WHERE predicate (e.g. `(col1 = 'A' AND col2 = 'B') OR (col1 = 'B' AND col2 = 'A')`),
    find an alternative disjunct branch assignment for `table_name` that preserves
    `fixed_cols_upper` (such as join columns) while yielding a distinct PK/unique tuple
    from `original_row`.
    """
    table = schema.tables.get(table_name)
    ast = parsed_query.get("ast")
    if not table or not ast:
        return None

    pk_cols = [c for c in table.columns if c.is_primary_key]
    unique_cols = [c for c in table.columns if c.is_unique and not c.is_primary_key]
    if not pk_cols and not unique_cols:
        return None

    fixed_up = fixed_cols_upper or set()
    orig_pk = tuple(original_row.get(c.name) for c in pk_cols) if pk_cols else None

    def _flatten_or_branches(node: exp.Expression) -> List[exp.Expression]:
        curr = node
        while isinstance(curr, exp.Paren):
            curr = curr.this
        if isinstance(curr, exp.Or):
            return _flatten_or_branches(curr.left) + _flatten_or_branches(curr.right)
        return [curr] if curr is not None else []

    for w_node in ast.find_all(exp.Where):
        for or_node in w_node.find_all(exp.Or):
            p = or_node.parent
            while isinstance(p, exp.Paren):
                p = p.parent
            if isinstance(p, exp.Or):
                continue
            not_cnt = 0
            curr_p = or_node.parent
            while curr_p and curr_p is not w_node:
                if isinstance(curr_p, exp.Not):
                    not_cnt += 1
                curr_p = curr_p.parent
            if not_cnt % 2 == 1:
                continue

            for branch in _flatten_or_branches(or_node):
                eq_nodes = ([branch] if isinstance(branch, exp.EQ) else []) + [
                    n for n in branch.find_all(exp.EQ) if n is not branch
                ]
                branch_overrides: Dict[str, Any] = {}
                valid_branch = True
                for eq in eq_nodes:
                    p_eq = eq.parent
                    eq_neg = False
                    while p_eq and p_eq is not branch.parent:
                        if isinstance(p_eq, exp.Not):
                            eq_neg = not eq_neg
                        p_eq = p_eq.parent
                    if eq_neg or bool(eq.args.get("negate")):
                        valid_branch = False
                        break
                    col_side = eq.left if isinstance(eq.left, exp.Column) else (eq.right if isinstance(eq.right, exp.Column) else None)
                    lit_side = eq.right if col_side is eq.left else (eq.left if col_side is eq.right else None)
                    if col_side is None or not isinstance(lit_side, exp.Literal):
                        continue
                    res = resolve_query_column(schema, parsed_query, col_side.table, col_side.name)
                    if not res:
                        col_obj = schema.find_column(table_name, col_side.name)
                        if col_obj:
                            res = (table_name, col_obj.name)
                    if not res or res[0].upper() != table_name.upper():
                        continue
                    c_name = res[1]
                    if c_name.upper() in fixed_up:
                        valid_branch = False
                        break
                    col_obj = schema.find_column(table_name, c_name)
                    if lit_side.is_string:
                        val: Any = str(lit_side.name)
                    else:
                        num_v = _extract_numeric_literal(lit_side)
                        val = int(num_v) if (num_v is not None and float(num_v).is_integer() and col_obj and "int" in (col_obj.data_type or "").lower()) else (num_v if num_v is not None else lit_side.name)
                    branch_overrides[c_name] = val

                if not valid_branch or not branch_overrides:
                    continue

                cand_row = {**original_row, **branch_overrides}
                if pk_cols:
                    cand_pk = tuple(cand_row.get(c.name) for c in pk_cols)
                    if None in cand_pk or cand_pk == orig_pk:
                        continue
                if any(
                    cand_row.get(uc.name) is not None and cand_row.get(uc.name) == original_row.get(uc.name)
                    for uc in unique_cols
                ):
                    continue
                return branch_overrides

    return None


class DistinctAttackStrategy(AttackStrategy):
    """
    Target semantic bug: missing DISTINCT in the correct query.

    Algorithm & Dataset Design:
    The strategy applies when the correct query contains either top-level
    SELECT DISTINCT or DISTINCT inside an aggregate such as COUNT(DISTINCT col).
    It creates duplicate execution paths yielding identical projected values by
    duplicating rows in referenced tables. Projected columns (referenced in the
    SELECT clause or aggregate arguments) preserve their original values so that
    the query outputs duplicate tuples. Non-projected primary keys / unique
    constraints are reassigned unique values (or single-column PK tables are kept
    at 1 row while child join tables duplicate the join key) to remain valid under
    schema constraints. A query missing DISTINCT will incorrectly return duplicate
    rows or incorrect aggregate counts.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return parsed_query.get("has_distinct", False) or self._has_aggregate_distinct(parsed_query)

    def _has_aggregate_distinct(self, parsed_query: Dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            return False
        return any(isinstance(node.this, exp.Distinct) for node in ast.find_all(exp.AggFunc))

    def _get_projected_columns(self, schema: Schema, parsed_query: Dict[str, Any]) -> Set[Tuple[str, str]]:
        projected = set()
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            ast = None

        if ast:
            for sel in ast.find_all(exp.Select):
                for expr in sel.expressions:
                    for col in expr.find_all(exp.Column):
                        res = resolve_query_column(schema, parsed_query, col.table, col.name)
                        if res:
                            projected.add(res)

        for s in parsed_query.get("selects", []):
            res = resolve_query_column(schema, parsed_query, s.get("table", ""), s["column"])
            if res:
                projected.add(res)

        return projected

    def _can_null_column_for_duplicate(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        return can_null_column_for_duplicate(schema, parsed_query, table_name, column_name)

    def _build_join_classes(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        alias_to_table: Dict[str, str],
    ) -> Tuple[UnionFind, Set[Tuple[str, str]]]:
        uf = UnionFind()
        join_cols: Set[Tuple[str, str]] = set()
        alias_lookup = {a.upper(): a for a in alias_to_table}

        def _norm_side(info: Dict[str, str]) -> Tuple[str, str] | None:
            raw_t = info.get("table", "")
            raw_c = info.get("column", "")
            if not raw_c:
                return None
            if raw_t and raw_t.upper() in alias_lookup:
                return (raw_t.upper(), raw_c.upper())
            resolved = resolve_query_column(schema, parsed_query, raw_t, raw_c)
            if resolved:
                t_name, c_name = resolved
                for a, tn in alias_to_table.items():
                    if tn.upper() == t_name.upper():
                        return (a.upper(), c_name.upper())
            return (raw_t.upper(), raw_c.upper()) if raw_t else None

        for join in parsed_query.get("joins", []):
            j_type = (join.get("type") or "").upper()
            if j_type == "EQ_SUBQUERY":
                continue
            if j_type == "IN_SUBQUERY" and (
                join.get("agg_func")
                or join.get("agg_pairs")
                or join.get("has_group_by")
                or join.get("has_limit")
            ):
                continue
            for pair in join.get("on_pairs", []):
                left = _norm_side(pair.get("left", {}))
                right = _norm_side(pair.get("right", {}))
                if left and right and left != right:
                    if j_type == "IN_SUBQUERY":
                        l_tbl = alias_to_table.get(alias_lookup.get(left[0], ""), left[0])
                        r_tbl = alias_to_table.get(alias_lookup.get(right[0], ""), right[0])
                        if l_tbl.upper() == r_tbl.upper():
                            continue
                    uf.union(left, right)
                    join_cols.add(left)
                    join_cols.add(right)

        for pair in parsed_query.get("where_joins", []):
            left = _norm_side(pair.get("left", {}))
            right = _norm_side(pair.get("right", {}))
            if left and right and left != right:
                uf.union(left, right)
                join_cols.add(left)
                join_cols.add(right)

        return uf, join_cols

    def _select_row_index(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        rows: List[Dict[str, Any]],
        alias_idx: int,
        alias_count: int,
        all_table_rows: Dict[str, List[Dict[str, Any]]] | None = None,
    ) -> int | None:
        n = len(rows)
        if alias_idx >= n or n == 0:
            return None
        if n >= alias_count and alias_count > 0:
            chunk = max(1, n // alias_count)
            start_idx = alias_idx * chunk
            end_idx = n if alias_idx == alias_count - 1 else (alias_idx + 1) * chunk
        else:
            start_idx = alias_idx
            end_idx = alias_idx + 1

        if end_idx - start_idx <= 1:
            return start_idx

        ast = parsed_query.get("ast")
        if ast:
            for agg_node in ast.find_all((exp.Max, exp.Min)):
                col_node = agg_node.find(exp.Column)
                if not col_node:
                    continue
                res = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                if not res or res[0].upper() != table_name.upper():
                    continue
                target_col = res[1]
                want_max = isinstance(agg_node, exp.Max)
                subq = agg_node.find_ancestor(exp.Subquery)
                if subq and subq.parent:
                    parent = subq.parent
                    if isinstance(parent, exp.NEQ) or (
                        isinstance(parent, exp.In) and isinstance(parent.parent, exp.Not)
                    ):
                        want_max = not want_max
                    elif isinstance(parent, exp.LT) and parent.expression is subq:
                        want_max = False
                    elif isinstance(parent, exp.GT) and parent.expression is subq:
                        want_max = True
                valid_indices = [
                    i for i in range(start_idx, end_idx)
                    if rows[i].get(target_col) is not None
                ]
                if valid_indices:
                    def _sqlite_sort_key(idx: int) -> Tuple[int, Any]:
                        val = rows[idx][target_col]
                        if isinstance(val, (int, float)) and not isinstance(val, bool):
                            return (0, float(val))
                        return (1, str(val))

                    if want_max:
                        return max(valid_indices, key=_sqlite_sort_key)
                    return min(valid_indices, key=_sqlite_sort_key)

        order_bys = parsed_query.get("order_by") or []
        if order_bys:
            resolved_terms: List[Tuple[List[Dict[str, Any]], str, bool, bool]] = []
            for term in order_bys:
                col_name = term.get("column", "")
                if not col_name:
                    continue
                res = resolve_query_column(schema, parsed_query, term.get("table", ""), col_name)
                if not res:
                    continue
                ord_t, ord_c = res
                t_rows = None
                if ord_t.upper() == table_name.upper():
                    t_rows = rows
                elif alias_count == 1 and all_table_rows:
                    cand_rows = all_table_rows.get(ord_t)
                    if cand_rows is not None and len(cand_rows) == n:
                        t_rows = cand_rows
                if t_rows is not None and len(t_rows) >= end_idx:
                    is_desc = bool(term.get("desc", False))
                    nf = term.get("nulls_first")
                    nulls_first = (not is_desc) if nf is None else bool(nf)
                    resolved_terms.append((t_rows, ord_c, is_desc, nulls_first))

            if resolved_terms:
                def _cmp_order(idx_a: int, idx_b: int) -> int:
                    for t_rows, ord_c, is_desc, nulls_first in resolved_terms:
                        va = t_rows[idx_a].get(ord_c)
                        vb = t_rows[idx_b].get(ord_c)
                        if va is None and vb is None:
                            continue
                        if va is None:
                            return -1 if nulls_first else 1
                        if vb is None:
                            return 1 if nulls_first else -1
                        ka = (0, float(va)) if isinstance(va, (int, float)) and not isinstance(va, bool) else (1, str(va))
                        kb = (0, float(vb)) if isinstance(vb, (int, float)) and not isinstance(vb, bool) else (1, str(vb))
                        if ka == kb:
                            continue
                        cmp_val = -1 if ka < kb else 1
                        return -cmp_val if is_desc else cmp_val
                    return idx_a - idx_b

                sorted_indices = sorted(range(start_idx, end_idx), key=functools.cmp_to_key(_cmp_order))
                off_val = parsed_query.get("offset_val")
                if isinstance(off_val, int) and 0 <= off_val < len(sorted_indices):
                    return sorted_indices[off_val]
                return sorted_indices[0]

        return start_idx

    def _can_vary_keyless_column(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        table = schema.tables.get(table_name)
        if not table:
            return False
        if any(fk.column_name.upper() == column_name.upper() for fk in table.foreign_keys):
            return False
        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                    return False
        ast = parsed_query.get("ast")
        if ast:
            for c in ast.find_all(exp.Column):
                if (c.name or "").upper() != column_name.upper():
                    continue
                count_anc = c.find_ancestor(exp.Count)
                if count_anc is not None:
                    continue
                return False
        return True

    def _distinct_satisfying_where_value(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        col: Any,
        original_row: Dict[str, Any],
        duplicate_row: Dict[str, Any],
        allow_in_select: bool = False,
    ) -> Any:
        return distinct_satisfying_where_value(
            schema, parsed_query, table_name, col, original_row, duplicate_row, allow_in_select=allow_in_select
        )

    def _can_vary_projected_non_fd_column(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        table = schema.tables.get(table_name)
        if not table:
            return False
        if any(fk.column_name.upper() == column_name.upper() for fk in table.foreign_keys):
            return False
        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                    return False
        ast = parsed_query.get("ast")
        if not ast:
            return False
        for c_node in ast.find_all(exp.Column):
            res = resolve_query_column(schema, parsed_query, c_node.table, c_node.name)
            matches = (
                res is not None and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper())
            ) or (res is None and (c_node.name or "").upper() == column_name.upper())
            if not matches:
                continue
            if c_node.find_ancestor((exp.Where, exp.Group, exp.Order, exp.Having, exp.Join, exp.Window, exp.Subquery, exp.Exists, exp.CTE, exp.AggFunc)) is not None:
                return False
        return True

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        base_data = generate_base_dataset(schema, parsed_query, include_limit_padding=False)
        mock_data = {t_name: [] for t_name in schema.tables}

        # 1. Map aliases to table names and resolve projected columns
        alias_to_table = self.get_alias_to_table(schema, parsed_query)
        alias_to_table_upper = {a.upper(): t.upper() for a, t in alias_to_table.items()}
        projected_cols = self._get_projected_columns(schema, parsed_query)
        projected_cols_upper = {(t.upper(), c.upper()) for t, c in projected_cols}

        # 2. Build UnionFind for joins and collect join columns
        uf, join_cols = self._build_join_classes(schema, parsed_query, alias_to_table)

        first_selected = None
        first_selected_alias_col: Tuple[str, str] | None = None
        projected_alias_cols: List[Tuple[str, str]] = []
        for select in parsed_query.get("selects", []):
            raw_t = select.get("table", "")
            raw_c = select["column"]
            resolved = resolve_query_column(schema, parsed_query, raw_t, raw_c)
            if resolved:
                if first_selected is None:
                    first_selected = resolved
                t_name_res, c_name_res = resolved
                if raw_t and raw_t.upper() in alias_to_table_upper:
                    sel_alias_up = raw_t.upper()
                else:
                    sel_alias_up = next(
                        (a.upper() for a, tn in alias_to_table.items() if tn.upper() == t_name_res.upper()),
                        t_name_res.upper(),
                    )
                pair_ac = (sel_alias_up, c_name_res.upper())
                if first_selected_alias_col is None:
                    first_selected_alias_col = pair_ac
                if pair_ac not in projected_alias_cols:
                    projected_alias_cols.append(pair_ac)
        projected_alias_cols_set = set(projected_alias_cols)

        where_constrained_cols: Set[Tuple[str, str]] = set()
        for lit in parsed_query.get("where_literals", []):
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                where_constrained_cols.add((res[0].upper(), res[1].upper()))

        # First add all original rows from the base dataset
        for t_name, rows in base_data.items():
            mock_data[t_name].extend(copy.deepcopy(rows))

        # Identify aliases whose table has a single-column PK/UNIQUE that is projected
        # or joined to a projected column. These tables cannot duplicate their row with
        # the same value without violating the single-column PK/UNIQUE constraint.
        single_pk_projected_aliases: Set[str] = set()
        for alias, table_name in alias_to_table.items():
            if table_name in schema.tables:
                table = schema.tables[table_name]
                pk_cols = [c for c in table.columns if c.is_primary_key]
                for col in table.columns:
                    if col.is_unique or (col.is_primary_key and len(pk_cols) <= 1):
                        key_up = (alias.upper(), col.name.upper())
                        is_proj_col = (table_name.upper(), col.name.upper()) in projected_cols_upper
                        is_joined_to_proj = False
                        if key_up in join_cols:
                            root = uf.find(key_up)
                            root_members = [k for k in join_cols if uf.find(k) == root]
                            is_joined_to_proj = any(
                                (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                                for k in root_members
                            )
                        if is_proj_col or is_joined_to_proj:
                            single_pk_projected_aliases.add(alias.upper())
                            break

        duplicate_rows_by_table = {t_name: [] for t_name in schema.tables}
        non_fd_proj_overrides: List[Tuple[str, int, str, Any]] = []
        root_to_new_value = {}
        table_row_index = {t_name: 0 for t_name in schema.tables}
        alias_counts_by_table: Dict[str, int] = {}
        for _, t_name in alias_to_table.items():
            alias_counts_by_table[t_name] = alias_counts_by_table.get(t_name, 0) + 1

        for alias, table_name in alias_to_table.items():
            if table_name not in schema.tables:
                continue
            if alias.upper() in single_pk_projected_aliases:
                continue

            table = schema.tables[table_name]
            alias_idx = table_row_index[table_name]
            table_row_index[table_name] += 1
            idx = self._select_row_index(
                schema,
                parsed_query,
                table_name,
                mock_data[table_name],
                alias_idx,
                alias_counts_by_table.get(table_name, 1),
                all_table_rows=mock_data,
            )
            if idx is None:
                continue
            original_row = mock_data[table_name][idx]

            pk_cols = [c for c in table.columns if c.is_primary_key]
            has_any_unique = bool(pk_cols) or any(c.is_unique for c in table.columns) or bool(getattr(table, "unique_constraints", []))
            all_pk_projected = len(pk_cols) > 1 and all((table_name.upper(), c.name.upper()) in projected_cols_upper for c in pk_cols)
            null_pk_col_name = None
            if all_pk_projected:
                eligible_null_pks = [
                    c for c in pk_cols
                    if not c.is_unique
                    and (alias.upper(), c.name.upper()) not in join_cols
                    and self._can_null_column_for_duplicate(schema, parsed_query, table_name, c.name)
                ]
                if not eligible_null_pks:
                    eligible_null_pks = [
                        c for c in pk_cols
                        if not c.is_unique
                        and self._can_null_column_for_duplicate(schema, parsed_query, table_name, c.name)
                    ]
                if eligible_null_pks:
                    chosen_pk = next(
                        (c for c in eligible_null_pks if (table_name, c.name) != first_selected),
                        eligible_null_pks[0],
                    )
                    null_pk_col_name = chosen_pk.name
                    if (alias.upper(), null_pk_col_name.upper()) in join_cols:
                        null_companion_row = copy.deepcopy(original_row)
                        null_companion_row[null_pk_col_name] = None
                        duplicate_rows_by_table[table_name].append(null_companion_row)
                    else:
                        original_row[null_pk_col_name] = None

            duplicate_row = {}
            varied_keyless = False
            dup_idx = len(duplicate_rows_by_table[table_name])
            for col in table.columns:
                key = (alias.upper(), col.name.upper())
                is_join = key in join_cols
                is_proj = (table_name.upper(), col.name.upper()) in projected_cols_upper

                if null_pk_col_name is not None and col.name == null_pk_col_name:
                    duplicate_row[col.name] = None
                elif is_proj:
                    duplicate_row[col.name] = original_row[col.name]
                    is_trailing_multi_proj = (
                        len(projected_alias_cols) >= 2
                        and key in projected_alias_cols_set
                        and key != first_selected_alias_col
                    )
                    if (
                        parsed_query.get("has_distinct", False)
                        and (single_pk_projected_aliases or is_trailing_multi_proj)
                        and not is_join
                        and not col.is_primary_key
                        and not col.is_unique
                    ):
                        alt_val = None
                        if (table_name.upper(), col.name.upper()) in where_constrained_cols:
                            alt_val = self._distinct_satisfying_where_value(
                                schema, parsed_query, table_name, col, original_row, duplicate_row, allow_in_select=True
                            )
                        elif self._can_vary_projected_non_fd_column(schema, parsed_query, table_name, col.name):
                            orig_v = original_row.get(col.name)
                            if orig_v is not None:
                                cand_v = next_distinct_value(col, orig_v, schema=schema, table_name=table_name)
                                alt_val = solve_check_constraint_value(
                                    schema, table_name, col.name, col, cand_v,
                                    disallowed_values={orig_v}, row_context=duplicate_row
                                )
                        if alt_val is not None and alt_val != original_row.get(col.name):
                            non_fd_proj_overrides.append((table_name, dup_idx, col.name, alt_val))
                elif is_join:
                    root = uf.find(key)
                    root_members = [k for k in join_cols if uf.find(k) == root]
                    joins_to_anchored = any(
                        k[0] in single_pk_projected_aliases
                        or (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                        for k in root_members
                    )
                    if joins_to_anchored:
                        duplicate_row[col.name] = original_row[col.name]
                    else:
                        if root not in root_to_new_value:
                            cand_val = generate_unique_value_for_column(col)
                            cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                            root_to_new_value[root] = cand_val
                        duplicate_row[col.name] = root_to_new_value[root]
                elif col.is_primary_key or col.is_unique:
                    distinct_where_val = None
                    if (table_name.upper(), col.name.upper()) in where_constrained_cols:
                        distinct_where_val = self._distinct_satisfying_where_value(
                            schema, parsed_query, table_name, col, original_row, duplicate_row
                        )
                    if distinct_where_val is not None:
                        duplicate_row[col.name] = distinct_where_val
                    elif (
                        col.is_primary_key
                        and not col.is_unique
                        and len(pk_cols) > 1
                        and (table_name.upper(), col.name.upper()) in where_constrained_cols
                        and any(
                            other_pk.name != col.name
                            and (table_name.upper(), other_pk.name.upper()) not in projected_cols_upper
                            and (
                                (
                                    (alias.upper(), other_pk.name.upper()) in join_cols
                                    and not any(
                                        k[0] in single_pk_projected_aliases
                                        or (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                                        for k in join_cols
                                        if uf.find(k) == uf.find((alias.upper(), other_pk.name.upper()))
                                    )
                                )
                                or (
                                    (alias.upper(), other_pk.name.upper()) not in join_cols
                                    and (
                                        (table_name.upper(), other_pk.name.upper()) not in where_constrained_cols
                                        or self._distinct_satisfying_where_value(
                                            schema, parsed_query, table_name, other_pk, original_row, duplicate_row
                                        ) is not None
                                    )
                                )
                            )
                            for other_pk in pk_cols
                        )
                    ):
                        duplicate_row[col.name] = original_row[col.name]
                    else:
                        cand_val = generate_unique_value_for_column(col)
                        cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                        duplicate_row[col.name] = cand_val
                elif (
                    all_pk_projected
                    and null_pk_col_name is not None
                    and (table_name.upper(), col.name.upper()) not in where_constrained_cols
                    and not any(fk.column_name.upper() == col.name.upper() for fk in table.foreign_keys)
                ):
                    cand_val = generate_unique_value_for_column(col)
                    cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                    duplicate_row[col.name] = cand_val
                elif (
                    not has_any_unique
                    and not varied_keyless
                    and (table_name.upper(), col.name.upper()) not in where_constrained_cols
                    and self._can_vary_keyless_column(schema, parsed_query, table_name, col.name)
                ):
                    cand_val = generate_unique_value_for_column(col)
                    cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                    duplicate_row[col.name] = cand_val
                    varied_keyless = True
                elif (table_name.upper(), col.name.upper()) in where_constrained_cols:
                    distinct_where_val = self._distinct_satisfying_where_value(
                        schema, parsed_query, table_name, col, original_row, duplicate_row
                    )
                    if distinct_where_val is not None:
                        duplicate_row[col.name] = distinct_where_val
                    else:
                        duplicate_row[col.name] = original_row[col.name]
                else:
                    duplicate_row[col.name] = original_row[col.name]

            duplicate_rows_by_table[table_name].append(duplicate_row)

        for t_name, rows in duplicate_rows_by_table.items():
            mock_data[t_name].extend(rows)

        datasets = [
            Dataset(
                strategy_name=self.__class__.__name__,
                data=mock_data,
                tags=["distinct_attack"],
                description="Targets Missing DISTINCT bugs. Dataset generates two completely identical projected values by duplicating rows and adjusting non-projected columns to be unique. A query missing the required DISTINCT keyword will incorrectly return duplicates instead of a single unique row."
            )
        ]

        if non_fd_proj_overrides:
            non_fd_dups = copy.deepcopy(duplicate_rows_by_table)
            for t_name, d_idx, c_name, alt_val in non_fd_proj_overrides:
                if d_idx < len(non_fd_dups.get(t_name, [])):
                    non_fd_dups[t_name][d_idx][c_name] = alt_val
            non_fd_data = {t_name: copy.deepcopy(base_data.get(t_name, [])) for t_name in schema.tables}
            for t_name, rows in non_fd_dups.items():
                non_fd_data[t_name].extend(rows)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_non_fd_projection",
                    data=non_fd_data,
                    tags=["distinct_attack"],
                    description="Targets Over-Extended DISTINCT projections over 1-to-many joins. Dataset varies projected non-key child attributes across two qualifying child rows for the same parent key, separating parent-key deduplication from child-level deduplication."
                )
            )

        if parsed_query.get("has_distinct", False):
            partial_gb_ds = build_partial_group_by_distinct_dataset(
                schema,
                parsed_query,
                strategy_name=f"{self.__class__.__name__}_partial_group_by",
                tags=["distinct_attack", "group_by_attack"],
                description="Targets Missing or Misplaced DISTINCT over partial GROUP BY projections. Dataset constructs two distinct groups that share identical projected column values, differ on unprojected GROUP BY columns, satisfy all HAVING/WHERE predicates, and yield distinct group cardinalities/aggregate values.",
            )
            if partial_gb_ds is not None:
                datasets.append(partial_gb_ds)

        return datasets

