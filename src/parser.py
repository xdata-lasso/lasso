"""
SQL DDL and AST Parser Module
=============================

Parses relational schema DDL definitions into Schema models and SQL queries into structured AST metadata
(tables, joins, predicates, projections, group-by, order-by, and aggregate functions) using SqlGlot.
"""

import re
import sqlite3
from typing import Any
from models import Schema, Table, Column, ForeignKey

import sqlglot
import sqlglot.expressions as exp
import functools
import copy

def _unwrap_join_column(node: exp.Expression | None) -> exp.Column | None:
    curr = node
    while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
        curr = curr.this
    if isinstance(curr, exp.Column):
        return curr
    if isinstance(curr, exp.Coalesce) or (
        isinstance(curr, exp.Anonymous) and (curr.name or "").upper() in ("IFNULL", "NVL", "COALESCE")
    ):
        cols = list(curr.find_all(exp.Column))
        if len(cols) == 1:
            return cols[0]
    return None


def _extract_tables_and_joins(parsed: exp.Expression) -> tuple[list[dict], dict[str, str], list[dict]]:
    tables = []
    aliases = {}
    joins = []
    
    # Extract FROM and JOIN tables
    for table in parsed.find_all(exp.Table):
        name = table.name
        alias = table.alias or name
        if {"name": name, "alias": alias} not in tables:
            tables.append({"name": name, "alias": alias})
        aliases[alias] = name
        
    # Extract JOINs
    for join in parsed.find_all(exp.Join):
        side = join.args.get("side")
        kind = join.args.get("kind")
        method = join.args.get("method")
        
        # Determine join type
        join_parts = []
        if method: join_parts.append(str(method))
        if side: join_parts.append(str(side))
        if kind: join_parts.append(str(kind))
        
        join_type = " ".join(join_parts).upper() if join_parts else "INNER"
        
        on_cond = join.args.get("on")
        # Extract pairs from ON condition (simple equalities and column-list IN joins)
        on_pairs = []
        if on_cond:
            for eq in on_cond.find_all(exp.EQ):
                left = _unwrap_join_column(eq.left)
                right = _unwrap_join_column(eq.right)
                if left is not None and right is not None:
                    on_pairs.append({
                        "left": {"table": left.table, "column": left.name},
                        "right": {"table": right.table, "column": right.name}
                    })
            for in_node in on_cond.find_all(exp.In):
                if (
                    not in_node.args.get("query")
                    and _count_not_parents(in_node) % 2 == 0
                    and not bool(in_node.args.get("negate"))
                    and isinstance(in_node.this, exp.Column)
                ):
                    left = in_node.this
                    for expr in in_node.expressions or []:
                        if isinstance(expr, exp.Column):
                            on_pairs.append({
                                "left": {"table": left.table, "column": left.name},
                                "right": {"table": expr.table, "column": expr.name}
                            })
                            break

        using_cols = []
        if join.args.get("using"):
            for u in join.args["using"]:
                col_name = u.name if isinstance(u, (exp.Identifier, exp.Column)) else str(u)
                using_cols.append(col_name)
        
        this = join.this
        table_name = this.name if isinstance(this, exp.Table) else None
        alias = this.alias if isinstance(this, exp.Table) and this.alias else table_name
        
        joins.append({
            "table": table_name,
            "alias": alias,
            "type": join_type,
            "is_natural": bool(method and str(method).upper() == "NATURAL"),
            "using_cols": using_cols,
            "on_pairs": on_pairs
        })
        
    return tables, aliases, joins

def _extract_int_from_limit_expr(expr: Any) -> int | None:
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

def _extract_subquery_joins(parsed: exp.Expression, tables: list[dict], joins: list[dict]):
    # Extract IN subqueries as pseudo-joins
    for in_expr in parsed.find_all(exp.In):
        subq = in_expr.args.get("query")
        if subq:
            left_exprs = []
            if isinstance(in_expr.this, exp.Column):
                left_exprs = [in_expr.this]
            elif isinstance(in_expr.this, exp.Tuple):
                left_exprs = list(in_expr.this.expressions)

            select_node = subq.this if isinstance(subq, exp.Subquery) else subq
            right_exprs = []
            if hasattr(select_node, "expressions"):
                right_exprs = list(select_node.expressions)

            if len(left_exprs) == len(right_exprs) and len(left_exprs) > 0:
                on_pairs = []
                agg_pairs = []
                in_agg_func = None
                for l_node, r_node in zip(left_exprs, right_exprs):
                    l_col = l_node if isinstance(l_node, exp.Column) else l_node.find(exp.Column)
                    if not l_col:
                        continue
                    l_table = l_col.table or (tables[0]["alias"] if tables else "")

                    r_unwrapped = r_node.this if isinstance(r_node, exp.Alias) else r_node
                    if isinstance(r_unwrapped, exp.Column):
                        r_table = r_unwrapped.table
                        if not r_table:
                            for t in select_node.find_all(exp.Table):
                                r_table = t.alias or t.name
                                break
                        on_pairs.append({
                            "left": {"table": l_table, "column": l_col.name},
                            "right": {"table": r_table, "column": r_unwrapped.name}
                        })
                    elif isinstance(r_unwrapped, exp.AggFunc) or (hasattr(r_unwrapped, "find") and r_unwrapped.find(exp.AggFunc)):
                        agg_node = r_unwrapped if isinstance(r_unwrapped, exp.AggFunc) else r_unwrapped.find(exp.AggFunc)
                        agg_func = agg_node.key.upper()
                        r_col = agg_node.find(exp.Column)
                        r_table = (r_col.table if r_col else None)
                        if not r_table:
                            for t in select_node.find_all(exp.Table):
                                r_table = t.alias or t.name
                                break
                        if agg_func in ("MIN", "MAX") and r_col:
                            if in_agg_func is None:
                                in_agg_func = agg_func
                            on_pairs.append({
                                "left": {"table": l_table, "column": l_col.name},
                                "right": {"table": r_table, "column": r_col.name}
                            })
                        else:
                            agg_pairs.append({
                                "left": {"table": l_table, "column": l_col.name},
                                "right_table": r_table,
                                "agg_func": agg_func,
                            })

                if on_pairs or agg_pairs:
                    right_table = None
                    if on_pairs:
                        right_table = on_pairs[0]["right"]["table"]
                    elif agg_pairs:
                        right_table = agg_pairs[0]["right_table"]
                    if not right_table:
                        for t in select_node.find_all(exp.Table):
                            right_table = t.alias or t.name
                            break
                    order_by_info = []
                    order = subq.args.get("order") or (select_node.args.get("order") if hasattr(select_node, "args") else None)
                    if order:
                        for ordered in order.expressions:
                            expr = ordered.this
                            if isinstance(expr, exp.Column):
                                order_by_info.append({
                                    "table": expr.table or right_table,
                                    "column": expr.name,
                                    "desc": bool(ordered.args.get("desc"))
                                })

                    limit = subq.args.get("limit") or (select_node.args.get("limit") if hasattr(select_node, "args") else None)
                    has_limit = bool(limit)
                    limit_val = _extract_int_from_limit_expr(limit)
                    if limit_val is not None and limit_val < 0:
                        limit_val = None

                    joins.append({
                        "table": right_table,
                        "alias": right_table,
                        "type": "IN_SUBQUERY",
                        "agg_func": in_agg_func,
                        "on_pairs": on_pairs,
                        "agg_pairs": agg_pairs,
                        "has_group_by": bool(select_node.find(exp.Group)),
                        "order_by": order_by_info,
                        "has_limit": has_limit,
                        "limit": limit_val,
                    })

        
    # Extract EQ subqueries as pseudo-joins
    for eq_expr in parsed.find_all(exp.EQ):
        subq = None
        col_side = None
        if isinstance(eq_expr.right, exp.Subquery) or isinstance(getattr(eq_expr.right, "this", None), exp.Subquery):
            subq = eq_expr.right if isinstance(eq_expr.right, exp.Subquery) else eq_expr.right.this
            col_side = eq_expr.left
        elif isinstance(eq_expr.left, exp.Subquery) or isinstance(getattr(eq_expr.left, "this", None), exp.Subquery):
            subq = eq_expr.left if isinstance(eq_expr.left, exp.Subquery) else eq_expr.left.this
            col_side = eq_expr.right

        if subq and col_side:
            left_col = col_side if isinstance(col_side, exp.Column) else col_side.find(exp.Column)
            if left_col:
                right_col = None
                agg_func = None
                select_node = subq.this if isinstance(subq, exp.Subquery) else subq
                if hasattr(select_node, "expressions"):
                    for expr in select_node.expressions:
                        c = expr if isinstance(expr, exp.Column) else expr.find(exp.Column)
                        if c:
                            right_col = c
                            if isinstance(expr, exp.Min):
                                agg_func = "MIN"
                            elif isinstance(expr, exp.Max):
                                agg_func = "MAX"
                            elif isinstance(expr, exp.AggFunc):
                                agg_func = expr.key.upper()
                            break
                if right_col:
                    left_table = left_col.table or ""
                    right_table = right_col.table
                    if not right_table:
                        for t in select_node.find_all(exp.Table):
                            right_table = t.alias or t.name
                            break
                    order_by_info = []
                    order = subq.args.get("order") or select_node.args.get("order")
                    if order:
                        for ordered in order.expressions:
                            expr = ordered.this
                            if isinstance(expr, exp.Column):
                                order_by_info.append({
                                    "table": expr.table,
                                    "column": expr.name,
                                    "desc": bool(ordered.args.get("desc"))
                                })
                    
                    limit = subq.args.get("limit") or select_node.args.get("limit")
                    joins.append({
                        "table": right_table,
                        "alias": right_table,
                        "type": "EQ_SUBQUERY",
                        "agg_func": agg_func,
                        "has_order": order is not None,
                        "has_limit": limit is not None,
                        "order_by": order_by_info,
                        "on_pairs": [{
                            "left": {"table": left_table, "column": left_col.name},
                            "right": {"table": right_table, "column": right_col.name}
                        }]
                    })

def _resolve_local_select_alias(select_node: exp.Select | None, col_name: str) -> tuple[str, str] | None:
    if not select_node or not hasattr(select_node, "expressions"):
        return None
    col_upper = (col_name or "").upper()
    for sel_expr in select_node.expressions:
        if isinstance(sel_expr, exp.Alias) and (sel_expr.alias or "").upper() == col_upper:
            inner = sel_expr.this
            while isinstance(inner, (exp.Alias, exp.Cast, exp.TryCast, exp.Paren)):
                inner = inner.this
            if isinstance(inner, exp.Column):
                return inner.table, inner.name
    return None


def _expand_ordinal_group_and_order(parsed: exp.Expression) -> None:
    """
    Replace 1-based integer ordinal literals in GROUP BY and ORDER BY clauses
    (e.g. `GROUP BY 1, 2`, `ORDER BY 1 ASC`) with the corresponding SELECT expressions.
    """
    def _resolve_ordinal_target(
        select_exprs: list[exp.Expression], pos: int, for_order: bool = False
    ) -> exp.Expression | None:
        if pos < 1 or pos > len(select_exprs):
            return None
        for e in select_exprs[:pos]:
            if isinstance(e, exp.Star) or (isinstance(e, exp.Column) and isinstance(e.this, exp.Star)):
                return None
        sel_expr = select_exprs[pos - 1]
        if isinstance(sel_expr, exp.Alias):
            inner = sel_expr.this
            while isinstance(inner, (exp.Paren, exp.Cast, exp.TryCast)):
                inner = inner.this
            if isinstance(inner, exp.Column):
                return inner.copy()
            if for_order and sel_expr.alias:
                return exp.Column(this=exp.Identifier(this=sel_expr.alias))
            return sel_expr.this.copy()
        inner = sel_expr
        while isinstance(inner, (exp.Paren, exp.Cast, exp.TryCast)):
            inner = inner.this
        if isinstance(inner, exp.Column):
            return inner.copy()
        return sel_expr.copy()

    for select_node in parsed.find_all(exp.Select):
        select_exprs = list(select_node.expressions or [])
        if not select_exprs:
            continue

        group_node = select_node.args.get("group")
        if group_node and group_node.expressions:
            new_group_exprs = list(group_node.expressions)
            changed = False
            for idx, g_expr in enumerate(new_group_exprs):
                if isinstance(g_expr, exp.Literal) and g_expr.is_int:
                    try:
                        pos = int(g_expr.this)
                    except (ValueError, TypeError):
                        continue
                    resolved = _resolve_ordinal_target(select_exprs, pos, for_order=False)
                    if resolved is not None:
                        new_group_exprs[idx] = resolved
                        changed = True
            if changed:
                group_node.set("expressions", new_group_exprs)

        order_node = select_node.args.get("order")
        if order_node and order_node.expressions:
            for o_expr in order_node.expressions:
                inner_o = o_expr.this if isinstance(o_expr, exp.Ordered) else o_expr
                if isinstance(inner_o, exp.Literal) and inner_o.is_int:
                    try:
                        pos = int(inner_o.this)
                    except (ValueError, TypeError):
                        continue
                    resolved = _resolve_ordinal_target(select_exprs, pos, for_order=True)
                    if resolved is not None:
                        if isinstance(o_expr, exp.Ordered):
                            o_expr.set("this", resolved)


def _extract_selects_and_grouping(parsed: exp.Expression) -> tuple[list[dict], list[dict], list[dict]]:
    # Extract SELECT columns
    selects = []
    if hasattr(parsed, "expressions"):
        for select in parsed.expressions:
            if isinstance(select, exp.Column):
                selects.append({"table": select.table, "column": select.name, "alias": None})
            elif isinstance(select, exp.Alias):
                col = select.this
                while isinstance(col, (exp.Paren, exp.Cast, exp.TryCast)):
                    col = col.this
                if isinstance(col, exp.Column):
                    selects.append({"table": col.table, "column": col.name, "alias": select.alias})
                
    # Extract GROUP BY columns from all group clauses
    group_by = []
    for node in parsed.find_all(exp.Group):
        enclosing_select = node.find_ancestor(exp.Select) or (parsed if isinstance(parsed, exp.Select) else None)
        for expr in node.expressions:
            if isinstance(expr, exp.Column):
                col_t, col_c = expr.table, expr.name
                if not col_t:
                    aliased = _resolve_local_select_alias(enclosing_select, col_c)
                    if aliased:
                        col_t, col_c = aliased
                group_by.append({"table": col_t, "column": col_c})

    # Extract ORDER BY columns from all order clauses
    order_by = []
    for node in parsed.find_all(exp.Order):
        enclosing_select = node.find_ancestor(exp.Select) or (parsed if isinstance(parsed, exp.Select) else None)
        for ordered in node.expressions:
            expr = ordered.this
            if isinstance(expr, exp.Column):
                col_t, col_c = expr.table, expr.name
                if not col_t:
                    aliased = _resolve_local_select_alias(enclosing_select, col_c)
                    if aliased:
                        col_t, col_c = aliased
                is_desc = bool(ordered.args.get("desc"))
                nf = ordered.args.get("nulls_first")
                order_by.append({
                    "table": col_t,
                    "column": col_c,
                    "desc": is_desc,
                    "nulls_first": (not is_desc) if nf is None else bool(nf),
                })
                
    return selects, group_by, order_by

def _is_numeric_literal_val(node: exp.Expression | None, target: float) -> bool:
    if not isinstance(node, exp.Literal) or node.is_string:
        return False
    try:
        return float(node.name) == target
    except (ValueError, TypeError):
        return False


def _unwrap_identity_arith(node: exp.Expression | None) -> exp.Expression | None:
    if isinstance(node, exp.Add):
        if _is_numeric_literal_val(node.right, 0.0):
            return node.left
        if _is_numeric_literal_val(node.left, 0.0):
            return node.right
    elif isinstance(node, exp.Sub):
        if _is_numeric_literal_val(node.right, 0.0):
            return node.left
    elif isinstance(node, exp.Mul):
        if _is_numeric_literal_val(node.right, 1.0):
            return node.left
        if _is_numeric_literal_val(node.left, 1.0):
            return node.right
    elif isinstance(node, exp.Div):
        if _is_numeric_literal_val(node.right, 1.0):
            return node.left
    return None


def _is_safe_wrapper(expr: exp.Expression) -> bool:
    if not expr: return False
    if isinstance(expr, exp.Column): return True
    for unsafe in expr.find_all((exp.Count, exp.If, exp.Case, exp.Add, exp.Sub, exp.Mul, exp.Div, exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.In, exp.Between, exp.Like, exp.ILike, exp.Is)):
        if isinstance(unsafe, (exp.Add, exp.Sub, exp.Mul, exp.Div)) and _unwrap_identity_arith(unsafe) is not None:
            continue
        return False
    return True
    
def _is_negated_in_case_or_aggregate(comp: exp.Expression) -> bool:
    when_node = None
    case_node = None
    
    curr = comp
    while curr and curr.parent:
        p = curr.parent
        if isinstance(p, exp.When) and p.this == curr:
            when_node = p
            case_node = p.parent if isinstance(p.parent, exp.Case) else None
            break
        elif isinstance(p, exp.If) and p.this == curr:
            case_node = p
            break
        elif isinstance(p, (exp.Sum, exp.Avg, exp.Max, exp.Min, exp.Count)):
            case_node = p
            break
        curr = p
        
    if not case_node:
        return False
        
    then_val = 1.0
    else_val = 0.0
    
    if when_node:
        then_expr = when_node.expression
        if isinstance(then_expr, exp.Literal):
            try: then_val = float(then_expr.name)
            except ValueError: pass
        default_expr = case_node.args.get("default")
        if isinstance(default_expr, exp.Literal):
            try: else_val = float(default_expr.name)
            except ValueError: pass
    elif isinstance(case_node, exp.If):
        true_expr = case_node.args.get("true")
        if isinstance(true_expr, exp.Literal):
            try: then_val = float(true_expr.name)
            except ValueError: pass
        false_expr = case_node.args.get("false")
        if isinstance(false_expr, exp.Literal):
            try: else_val = float(false_expr.name)
            except ValueError: pass

    outer_comp = None
    curr = case_node
    while curr and curr.parent:
        p = curr.parent
        if isinstance(p, (exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE)):
            outer_comp = p
            break
        curr = p
        
    if not outer_comp:
        return False
        
    target_val = None
    if isinstance(outer_comp.right, exp.Literal):
        try: target_val = float(outer_comp.right.name)
        except ValueError: pass
    elif isinstance(outer_comp.left, exp.Literal):
        try: target_val = float(outer_comp.left.name)
        except ValueError: pass
        
    if target_val is None:
        return False

    op = outer_comp.__class__.__name__.upper()
    
    if then_val > else_val:
        if op == "EQ" and target_val == 0:
            return True
        if op in ("LTE", "LT") and target_val <= 0:
            return True
        if op == "LT" and target_val <= 1:
            return True
    elif then_val < else_val:
        if op in ("GT", "GTE") and target_val >= 0:
            return True

    return False

def _count_not_parents(node: exp.Expression) -> int:
    cnt = 0
    parent = node.parent
    while parent:
        if isinstance(parent, exp.Not):
            cnt += 1
        parent = parent.parent
    return cnt

def _extract_substring_meta(expr: exp.Expression) -> tuple[int, int | None] | None:
    if not expr:
        return None
    curr = expr
    while curr is not None:
        if isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren)):
            curr = curr.this
            continue
        unwrapped = _unwrap_identity_arith(curr)
        if unwrapped is not None:
            curr = unwrapped
            continue
        break
    if isinstance(curr, exp.Substring):
        start_val = _extract_int_from_limit_expr(curr.args.get("start"))
        len_val = _extract_int_from_limit_expr(curr.args.get("length"))
        if start_val is not None:
            return start_val, len_val
    elif isinstance(curr, exp.Anonymous) and (curr.name or "").lower() in ("substr", "substring"):
        exprs = curr.expressions or []
        if len(exprs) >= 2:
            start_val = _extract_int_from_limit_expr(exprs[1])
            len_val = _extract_int_from_limit_expr(exprs[2]) if len(exprs) >= 3 else None
            if start_val is not None:
                return start_val, len_val
    return None


def _is_length_func(node: exp.Expression | None) -> bool:
    if isinstance(node, exp.Length):
        return True
    if isinstance(node, exp.Anonymous):
        return (node.name or "").lower() in (
            "length", "char_length", "character_length", "len", "octet_length"
        )
    return False


def _extract_length_meta(expr: exp.Expression | None) -> dict[str, Any]:
    if not expr:
        return {}
    curr = expr
    while curr is not None:
        if isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren)):
            curr = curr.this
            continue
        unwrapped = _unwrap_identity_arith(curr)
        if unwrapped is not None:
            curr = unwrapped
            continue
        break
    if not _is_length_func(curr):
        return {}
    arg = (
        curr.this
        if isinstance(curr, exp.Length)
        else (curr.expressions[0] if getattr(curr, "expressions", None) else None)
    )
    sub_meta = _extract_substring_meta(arg) if arg is not None else None
    length_offset = (int(sub_meta[0]) - 1) if (sub_meta and sub_meta[0] is not None and int(sub_meta[0]) >= 1) else 0
    return {"is_length_expr": True, "length_offset": length_offset}


def _extract_temporal_meta(expr: exp.Expression) -> dict[str, Any]:
    if not expr:
        return {}
    curr = expr
    while curr is not None:
        if isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren)):
            curr = curr.this
            continue
        unwrapped = _unwrap_identity_arith(curr)
        if unwrapped is not None:
            curr = unwrapped
            continue
        break
    if isinstance(curr, exp.Anonymous):
        fn_name = (curr.name or "").lower()
        exprs = curr.expressions or []
        if fn_name == "strftime" and len(exprs) >= 2 and isinstance(exprs[0], exp.Literal):
            return {"is_temporal_expr": True, "strftime_format": exprs[0].name}
        if fn_name in ("date", "datetime", "time", "julianday", "unixepoch"):
            return {"is_temporal_expr": True}
        if fn_name == "year":
            return {"is_temporal_expr": True, "strftime_format": "%Y"}
        if fn_name == "month":
            return {"is_temporal_expr": True, "strftime_format": "%m"}
        if fn_name == "day":
            return {"is_temporal_expr": True, "strftime_format": "%d"}
    elif isinstance(curr, exp.TimeToStr):
        fmt_node = curr.args.get("format")
        if isinstance(fmt_node, exp.Literal):
            return {"is_temporal_expr": True, "strftime_format": fmt_node.name}
        return {"is_temporal_expr": True}
    elif isinstance(curr, (exp.Date, exp.Datetime, exp.Time, exp.TsOrDsToDate, exp.TsOrDsToTimestamp)):
        return {"is_temporal_expr": True}
    elif isinstance(curr, exp.Extract):
        part = (curr.name or "").upper()
        part_map = {"YEAR": "%Y", "MONTH": "%m", "DAY": "%d", "HOUR": "%H", "MINUTE": "%M", "SECOND": "%S"}
        if part in part_map:
            return {"is_temporal_expr": True, "strftime_format": part_map[part]}
        return {"is_temporal_expr": True}
    return {}

def _build_conditional_alias_map(
    parsed: exp.Expression, enclosing_sel: exp.Select | None
) -> dict[tuple[str, str], exp.Expression]:
    """
    Build a lookup map of `(source_alias_upper, col_alias_upper) -> expr` for
    SELECT projection aliases in `enclosing_sel` or its immediate derived-table / CTE
    sources that wrap conditional expressions (`CASE`, `IF`/`IIF`, or boolean
    comparisons inside aggregates).
    """
    cond_map: dict[tuple[str, str], exp.Expression] = {}
    if not enclosing_sel:
        return cond_map

    cte_by_alias: dict[str, exp.Select] = {}
    for cte in parsed.find_all(exp.CTE):
        if cte.alias:
            cte_sel = cte.this if isinstance(cte.this, exp.Select) else cte.find(exp.Select)
            if cte_sel:
                cte_by_alias[cte.alias.upper()] = cte_sel

    cond_node_types = (
        exp.Case, exp.If, exp.EQ, exp.NEQ, exp.GT, exp.GTE,
        exp.LT, exp.LTE, exp.In, exp.Between, exp.Like, exp.ILike, exp.Is,
    )
    str_len_node_types = (exp.Length, exp.Substring, exp.Trim)
    str_len_anon_names = (
        "length", "char_length", "character_length", "len", "octet_length",
        "substr", "substring", "trim", "ltrim", "rtrim", "replace",
    )

    def _collect_from_select(sel_node: exp.Select, qualifier_alias: str) -> None:
        imm_tables = [
            s for s in _get_immediate_sources(sel_node)
            if isinstance(s, exp.Table) and (s.alias or s.name)
        ]
        default_tbl = (imm_tables[0].alias or imm_tables[0].name) if len(imm_tables) == 1 else ""
        for expr in sel_node.expressions or []:
            if not isinstance(expr, exp.Alias) or not expr.alias:
                continue
            inner = expr.this
            if not inner or isinstance(inner, exp.Column):
                continue
            has_cond = inner.find(cond_node_types) is not None
            has_str_len = (
                inner.find((exp.AggFunc, exp.Window)) is None
                and (
                    inner.find(str_len_node_types) is not None
                    or any((a.name or "").lower() in str_len_anon_names for a in inner.find_all(exp.Anonymous))
                )
            )
            if not has_cond and not has_str_len:
                continue
            expanded = inner.copy()
            if default_tbl:
                for col in expanded.find_all(exp.Column):
                    if not col.table:
                        col.set("table", exp.Identifier(this=default_tbl))
            alias_up = expr.alias.upper()
            if qualifier_alias:
                cond_map[(qualifier_alias.upper(), alias_up)] = expanded
            cond_map.setdefault(("", alias_up), expanded)

    _collect_from_select(enclosing_sel, "")
    for src in _get_immediate_sources(enclosing_sel):
        if isinstance(src, exp.Subquery):
            sub_sel = src.this if isinstance(src.this, exp.Select) else src.find(exp.Select)
            if sub_sel:
                _collect_from_select(sub_sel, src.alias or "")
        elif isinstance(src, exp.Table) and (src.name or "").upper() in cte_by_alias:
            _collect_from_select(cte_by_alias[(src.name or "").upper()], src.alias or src.name or "")

    return cond_map


def _extract_where_and_having(parsed: exp.Expression) -> tuple[list[dict], list[dict]]:
    where_literals = []
    where_joins = []
    
    clauses = list(parsed.find_all((exp.Where, exp.Having)))
    for j in parsed.find_all(exp.Join):
        on_cond = j.args.get("on")
        if on_cond:
            clauses.append(on_cond)

    for clause in clauses:
        if clause:
            enclosing_sel = clause.find_ancestor(exp.Select)
            clause_is_subq = clause.find_ancestor(exp.Subquery) is not None
            scope_tables = [
                s.alias or s.name
                for s in (_get_immediate_sources(enclosing_sel) if enclosing_sel else [])
                if isinstance(s, exp.Table) and (s.alias or s.name)
            ]
            cond_alias_map = _build_conditional_alias_map(parsed, enclosing_sel)
            clause_to_scan = clause.copy() if cond_alias_map else clause
            if cond_alias_map:
                for c_node in clause_to_scan.find_all((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE)):
                    for side_attr in ("this", "expression"):
                        side = c_node.args.get(side_attr)
                        other = c_node.args.get("expression" if side_attr == "this" else "this")
                        if isinstance(side, exp.Column) and isinstance(other, exp.Literal):
                            key = ((side.table or "").upper(), (side.name or "").upper())
                            mapped = cond_alias_map.get(key) or (cond_alias_map.get(("", key[1])) if not key[0] else None)
                            if mapped is not None:
                                c_node.set(side_attr, mapped.copy())

            for comp in clause_to_scan.find_all((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Is, exp.Between, exp.In, exp.Like, exp.ILike)):
                arith_anc = comp.find_ancestor((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod))
                if (
                    arith_anc is not None
                    and arith_anc.find_ancestor((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between)) is not None
                    and comp.find_ancestor(exp.AggFunc) is None
                ):
                    continue
                not_count = _count_not_parents(comp)
                is_negated = (not_count % 2 == 1) or _is_negated_in_case_or_aggregate(comp)
                is_subq = clause_is_subq or (comp.find_ancestor(exp.Subquery) is not None)
                
                if isinstance(comp, exp.Between):
                    if _is_safe_wrapper(comp.this):
                        col = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                        if col:
                            sub_meta = _extract_substring_meta(comp.this)
                            sub_extra = {"substr_start": sub_meta[0], "substr_length": sub_meta[1]} if sub_meta else {}
                            temp_extra = _extract_temporal_meta(comp.this)
                            len_extra = _extract_length_meta(comp.this)
                            low_op = "BetweenUpper" if is_negated else "BetweenLower"
                            high_op = "BetweenLower" if is_negated else "BetweenUpper"
                            if isinstance(comp.args.get("low"), exp.Literal):
                                where_literals.append({
                                    "table": col.table,
                                    "column": col.name,
                                    "value": comp.args["low"].name,
                                    "operator": low_op,
                                    "is_subquery": is_subq,
                                    "scope_tables": scope_tables,
                                    **sub_extra,
                                    **temp_extra,
                                    **len_extra,
                                })
                            if isinstance(comp.args.get("high"), exp.Literal):
                                where_literals.append({
                                    "table": col.table,
                                    "column": col.name,
                                    "value": comp.args["high"].name,
                                    "operator": high_op,
                                    "is_subquery": is_subq,
                                    "scope_tables": scope_tables,
                                    **sub_extra,
                                    **temp_extra,
                                    **len_extra,
                                })
                elif isinstance(comp, exp.In):
                    if _is_safe_wrapper(comp.this):
                        col = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                        if col:
                            sub_meta = _extract_substring_meta(comp.this)
                            sub_extra = {"substr_start": sub_meta[0], "substr_length": sub_meta[1]} if sub_meta else {}
                            temp_extra = _extract_temporal_meta(comp.this)
                            len_extra = _extract_length_meta(comp.this)
                            op_name = "NOT IN" if is_negated else "In"
                            added_in_join = False
                            for expr in comp.expressions:
                                if isinstance(expr, exp.Literal):
                                    where_literals.append({
                                        "table": col.table,
                                        "column": col.name,
                                        "value": expr.name,
                                        "operator": op_name,
                                        "is_subquery": is_subq,
                                        "scope_tables": scope_tables,
                                        **sub_extra,
                                        **temp_extra,
                                        **len_extra,
                                    })
                                elif (
                                    not is_negated
                                    and not comp.args.get("query")
                                    and not added_in_join
                                    and _is_safe_wrapper(expr)
                                ):
                                    right_col = expr if isinstance(expr, exp.Column) else expr.find(exp.Column)
                                    if right_col:
                                        where_joins.append({
                                            "left": {"table": col.table, "column": col.name},
                                            "right": {"table": right_col.table, "column": right_col.name}
                                        })
                                        added_in_join = True
                    elif isinstance(comp.this, exp.Literal) and not comp.args.get("query"):
                        op_name = "NOT IN" if is_negated else "In"
                        for expr in comp.expressions:
                            if _is_safe_wrapper(expr):
                                r_col = expr if isinstance(expr, exp.Column) else expr.find(exp.Column)
                                if r_col:
                                    sub_meta = _extract_substring_meta(expr)
                                    sub_extra = {"substr_start": sub_meta[0], "substr_length": sub_meta[1]} if sub_meta else {}
                                    temp_extra = _extract_temporal_meta(expr)
                                    len_extra = _extract_length_meta(expr)
                                    where_literals.append({
                                        "table": r_col.table,
                                        "column": r_col.name,
                                        "value": comp.this.name,
                                        "operator": op_name,
                                        "is_subquery": is_subq,
                                        "scope_tables": scope_tables,
                                        **sub_extra,
                                        **temp_extra,
                                        **len_extra,
                                    })
                                    if not is_negated:
                                        break
                else:
                    op_name = comp.__class__.__name__
                    if is_negated or bool(comp.args.get("negate")):
                        op_upper = op_name.upper()
                        if op_upper == "LIKE": op_name = "NOT LIKE"
                        elif op_upper == "ILIKE": op_name = "NOT ILIKE"
                        elif op_upper == "IS": op_name = "IS NOT"
                        elif op_upper == "EQ": op_name = "NEQ"
                        elif op_upper == "NEQ": op_name = "EQ"
                        elif op_upper == "GT": op_name = "LTE"
                        elif op_upper == "GTE": op_name = "LT"
                        elif op_upper == "LT": op_name = "GTE"
                        elif op_upper == "LTE": op_name = "GT"
                        else: op_name = "NOT " + op_name

                    if isinstance(comp, exp.Is) and _is_safe_wrapper(comp.this) and isinstance(comp.expression, exp.Null):
                        col = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                        if col:
                            where_literals.append({
                                "table": col.table,
                                "column": col.name,
                                "value": "NULL",
                                "operator": op_name,
                                "is_subquery": is_subq,
                                "scope_tables": scope_tables,
                            })
                    elif hasattr(comp, "left") and hasattr(comp, "right") and comp.left and comp.right:
                        left_col = comp.left if isinstance(comp.left, exp.Column) else comp.left.find(exp.Column)
                        right_col = comp.right if isinstance(comp.right, exp.Column) else comp.right.find(exp.Column)
                        
                        def get_literal_value(node):
                            if not node:
                                return None
                            if isinstance(node, exp.Literal):
                                return node.name
                            if not node.find(exp.Column):
                                try:
                                    conn = sqlite3.connect(":memory:")
                                    cur = conn.cursor()
                                    res = cur.execute("SELECT " + node.sql(dialect="sqlite")).fetchone()
                                    if res and res[0] is not None:
                                        return str(res[0])
                                except Exception:
                                    pass
                            if isinstance(node, (exp.Datetime, exp.Date, exp.Time, exp.Anonymous, exp.Cast, exp.TsOrDsToTimestamp, exp.Func)):
                                if hasattr(node, "this") and isinstance(node.this, exp.Literal):
                                    return node.this.name
                                if hasattr(node, "expressions") and node.expressions and isinstance(node.expressions[0], exp.Literal):
                                    return node.expressions[0].name
                            return None

                        val_right = get_literal_value(comp.right)
                        val_left = get_literal_value(comp.left)

                        if left_col and val_right is not None and _is_safe_wrapper(comp.left):
                            sub_meta = _extract_substring_meta(comp.left)
                            sub_extra = {"substr_start": sub_meta[0], "substr_length": sub_meta[1]} if sub_meta else {}
                            temp_extra = _extract_temporal_meta(comp.left)
                            len_extra = _extract_length_meta(comp.left)
                            where_literals.append({
                                "table": left_col.table,
                                "column": left_col.name,
                                "value": val_right,
                                "operator": op_name,
                                "is_subquery": is_subq,
                                "scope_tables": scope_tables,
                                **sub_extra,
                                **temp_extra,
                                **len_extra,
                            })
                        elif right_col and val_left is not None and _is_safe_wrapper(comp.right):
                            sub_meta = _extract_substring_meta(comp.right)
                            sub_extra = {"substr_start": sub_meta[0], "substr_length": sub_meta[1]} if sub_meta else {}
                            temp_extra = _extract_temporal_meta(comp.right)
                            len_extra = _extract_length_meta(comp.right)
                            eff_op = op_name
                            if len_extra:
                                flip_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE"}
                                eff_op = flip_map.get(op_name.upper(), op_name)
                            where_literals.append({
                                "table": right_col.table,
                                "column": right_col.name,
                                "value": val_left,
                                "operator": eff_op,
                                "is_subquery": is_subq,
                                "scope_tables": scope_tables,
                                **sub_extra,
                                **temp_extra,
                                **len_extra,
                            })
                        elif left_col and right_col and not isinstance(comp.right, exp.Literal) and not isinstance(comp.left, exp.Literal):
                            if _is_safe_wrapper(comp.left) and _is_safe_wrapper(comp.right) and isinstance(comp, exp.EQ):
                                where_joins.append({
                                    "left": {"table": left_col.table, "column": left_col.name},
                                    "right": {"table": right_col.table, "column": right_col.name}
                                })
                                
    return where_literals, where_joins

def _is_in_predicate_subquery(node: exp.Expression) -> bool:
    curr = node.parent
    while curr:
        if isinstance(curr, exp.Subquery) and not isinstance(curr.parent, (exp.From, exp.Join)):
            return True
        if isinstance(curr, exp.Exists):
            return True
        curr = curr.parent
    return False


def _top_select_branch(node: exp.Expression) -> exp.Expression | None:
    curr = node
    top_sel = None
    while curr:
        if isinstance(curr, exp.Select):
            top_sel = curr
        elif isinstance(curr, (exp.Union, exp.Intersect, exp.Except)):
            break
        curr = curr.parent
    return top_sel


def _get_immediate_sources(select_node: exp.Select) -> list[exp.Expression]:
    sources = []
    from_clause = select_node.args.get("from_")
    if from_clause:
        if from_clause.this:
            sources.append(from_clause.this)
        for expr in from_clause.expressions:
            sources.append(expr)
    for join_node in select_node.args.get("joins") or []:
        if join_node.this:
            sources.append(join_node.this)
    return sources


def _subquery_exports_column(sq: exp.Subquery, col_name: str) -> bool:
    sel = sq.this if isinstance(sq.this, exp.Select) else sq.find(exp.Select)
    if not sel or not hasattr(sel, "expressions"):
        return False
    col_upper = col_name.upper()
    for expr in sel.expressions:
        if isinstance(expr, exp.Star) or (isinstance(expr, exp.Column) and isinstance(expr.this, exp.Star)):
            return True
        if (expr.alias_or_name or "").upper() == col_upper:
            return True
    return False


def _normalize_scoped_aliases(parsed: exp.Expression) -> None:
    """
    Lexical-scope alias normalization (alpha-renaming) for SQL ASTs.

    Disambiguates shadowed/reused table and derived-table subquery aliases across
    nested SELECT scopes and assigns synthetic aliases to anonymous derived tables
    (e.g. `FROM (SELECT ...)`), updating local column qualifiers accordingly.
    Leaves queries without alias collisions or anonymous derived tables untouched.
    """
    derived_subqueries = [
        sq for sq in parsed.find_all(exp.Subquery)
        if isinstance(sq.parent, (exp.From, exp.Join))
    ]
    all_tables = [
        t for t in parsed.find_all(exp.Table)
        if (t.name or "").upper() not in ("DUAL", "")
    ]

    alias_total_counts: dict[str, int] = {}
    table_name_counts: dict[str, int] = {}
    used_aliases: set[str] = set()

    for sq in parsed.find_all((exp.Subquery, exp.CTE)):
        if sq.alias:
            a_up = sq.alias.upper()
            used_aliases.add(a_up)
    for sq in derived_subqueries:
        if sq.alias:
            a_up = sq.alias.upper()
            alias_total_counts[a_up] = alias_total_counts.get(a_up, 0) + 1

    for t in all_tables:
        t_up = (t.name or "").upper()
        table_name_counts[t_up] = table_name_counts.get(t_up, 0) + 1
        used_aliases.add(t_up)
        eff_up = (t.alias or t.name).upper()
        used_aliases.add(eff_up)
        alias_total_counts[eff_up] = alias_total_counts.get(eff_up, 0) + 1

    needs_normalization = False
    for sq in derived_subqueries:
        if not sq.alias or alias_total_counts.get(sq.alias.upper(), 0) > 1:
            needs_normalization = True
            break

    if not needs_normalization:
        by_eff: dict[str, list[exp.Table]] = {}
        for t in all_tables:
            eff_up = (t.alias or t.name).upper()
            for prev_t in by_eff.get(eff_up, []):
                if (
                    (prev_t.name or "").upper() != (t.name or "").upper()
                    or bool(t.alias)
                    or bool(prev_t.alias)
                    or (
                        not _is_in_predicate_subquery(t)
                        and not _is_in_predicate_subquery(prev_t)
                        and _top_select_branch(t) is _top_select_branch(prev_t)
                    )
                ):
                    needs_normalization = True
                    break
            if needs_normalization:
                break
            by_eff.setdefault(eff_up, []).append(t)

    if not needs_normalization and len(all_tables) > 1:
        for sel in parsed.find_all(exp.Select):
            srcs = _get_immediate_sources(sel)
            if len(srcs) == 1 and isinstance(srcs[0], exp.Table) and not _is_in_predicate_subquery(sel):
                needs_normalization = True
                break

    if not needs_normalization:
        return

    counter = 1

    def _fresh_alias(base: str) -> str:
        nonlocal counter
        while True:
            counter += 1
            cand = f"{base}__{counter}"
            if cand.upper() not in used_aliases:
                used_aliases.add(cand.upper())
                return cand

    seen_base_table_aliases: dict[str, list[exp.Table]] = {}

    def _visit_select(select_node: exp.Select, inherited_env: dict[str, str]) -> None:
        local_env = dict(inherited_env)
        sources = _get_immediate_sources(select_node)

        for src in sources:
            if isinstance(src, exp.Table):
                t_name = src.name or ""
                if t_name.upper() in ("DUAL", ""):
                    continue
                orig_ref = src.alias or t_name
                orig_upper = orig_ref.upper()
                collides = False
                for prev_t in seen_base_table_aliases.get(orig_upper, []):
                    if (
                        (prev_t.name or "").upper() != t_name.upper()
                        or bool(src.alias)
                        or bool(prev_t.alias)
                        or (
                            not _is_in_predicate_subquery(src)
                            and not _is_in_predicate_subquery(prev_t)
                            and _top_select_branch(src) is _top_select_branch(prev_t)
                        )
                    ):
                        collides = True
                        break
                if collides:
                    new_alias = _fresh_alias(orig_ref)
                    src.set("alias", exp.TableAlias(this=exp.Identifier(this=new_alias)))
                    local_env[orig_upper] = new_alias
                    seen_base_table_aliases.setdefault(new_alias.upper(), []).append(src)
                else:
                    local_env[orig_upper] = orig_ref
                    seen_base_table_aliases.setdefault(orig_upper, []).append(src)

            elif isinstance(src, exp.Subquery):
                orig_alias = src.alias
                orig_upper = orig_alias.upper() if orig_alias else ""
                if not orig_alias or alias_total_counts.get(orig_upper, 0) > 1:
                    base_prefix = orig_alias if orig_alias else "__subq"
                    new_alias = _fresh_alias(base_prefix)
                    src.set("alias", exp.TableAlias(this=exp.Identifier(this=new_alias)))
                    if orig_upper:
                        local_env[orig_upper] = new_alias
                else:
                    local_env[orig_upper] = orig_alias

        for col in select_node.find_all(exp.Column):
            if isinstance(col.this, exp.Star):
                if col.table and col.table.upper() in local_env:
                    mapped = local_env[col.table.upper()]
                    if mapped != col.table:
                        col.set("table", exp.Identifier(this=mapped))
                continue
            if col.find_ancestor(exp.Select) is not select_node:
                continue
            if col.table:
                t_up = col.table.upper()
                if t_up in local_env:
                    mapped = local_env[t_up]
                    if mapped != col.table:
                        col.set("table", exp.Identifier(this=mapped))
            elif len(sources) == 1:
                only_src = sources[0]
                is_local_expr_alias = (
                    col.find_ancestor(exp.Order, exp.Group, exp.Having) is not None
                    and any(
                        isinstance(e, exp.Alias)
                        and (e.alias or "").upper() == col.name.upper()
                        and (
                            not isinstance(e.this, exp.Column)
                            or (e.this.name or "").upper() != (e.alias or "").upper()
                            or bool(e.this.table)
                        )
                        for e in select_node.expressions
                    )
                )
                if is_local_expr_alias:
                    continue
                if isinstance(only_src, exp.Subquery) and only_src.alias:
                    if _subquery_exports_column(only_src, col.name):
                        col.set("table", exp.Identifier(this=only_src.alias))
                elif isinstance(only_src, exp.Table):
                    eff_alias = only_src.alias or only_src.name
                    t_name_up = (only_src.name or "").upper()
                    if eff_alias and (
                        table_name_counts.get(t_name_up, 0) > 1
                        or bool(only_src.alias)
                        or (len(all_tables) > 1 and not _is_in_predicate_subquery(select_node))
                    ):
                        col.set("table", exp.Identifier(this=eff_alias))

        for child_sel in select_node.find_all(exp.Select):
            if child_sel is not select_node and child_sel.find_ancestor(exp.Select) is select_node:
                _visit_select(child_sel, local_env)

    if isinstance(parsed, exp.Select):
        _visit_select(parsed, {})
    else:
        for top_sel in parsed.find_all(exp.Select):
            if top_sel.find_ancestor(exp.Select) is None:
                _visit_select(top_sel, {})


def _trace_col(expr: exp.Expression, inner_aliases: dict[str, str]) -> tuple:
    if isinstance(expr, exp.Column):
        table = expr.table
        name = expr.name
        if not table and len(inner_aliases) == 1:
            table = list(inner_aliases.values())[0]
        base_table = inner_aliases.get(table, table)
        return base_table, name
    if isinstance(expr, (exp.Alias, exp.Cast, exp.TryCast, exp.Paren)):
        return _trace_col(expr.this, inner_aliases)
    return None, None

def _resolve_aliases(parsed: exp.Expression, joins: list[dict], selects: list[dict], 
                     where_joins: list[dict], where_literals: list[dict], 
                     group_by: list[dict], order_by: list[dict]) -> list[dict]:
    alias_mapping = {}
    agg_mapping = {}
    window_rank_aliases = set()
    star_subqueries = {}
    for subq in parsed.find_all((exp.Subquery, exp.CTE)):
        outer_alias = subq.alias
        if not outer_alias: continue
        
        inner_aliases = {}
        for table in subq.find_all(exp.Table):
            inner_aliases[table.alias or table.name] = table.alias or table.name
            
        select_node = subq.this
        if hasattr(select_node, "expressions"):
            for expr in select_node.expressions:
                if isinstance(expr, exp.Star) or (isinstance(expr, exp.Column) and isinstance(expr.this, exp.Star)):
                    star_t = expr.table if isinstance(expr, exp.Column) else None
                    if star_t and star_t in inner_aliases:
                        star_subqueries[outer_alias] = inner_aliases[star_t]
                    elif len(inner_aliases) == 1:
                        star_subqueries[outer_alias] = list(inner_aliases.values())[0]
                    elif isinstance(select_node, exp.Select):
                        imm_sources = _get_immediate_sources(select_node)
                        if len(imm_sources) == 1:
                            only_s = imm_sources[0]
                            if isinstance(only_s, (exp.Subquery, exp.Table)) and (only_s.alias or only_s.name):
                                star_subqueries[outer_alias] = only_s.alias or only_s.name
                    continue
                col_alias = expr.alias
                unwrapped = expr.this if isinstance(expr, exp.Alias) else expr
                win_node = unwrapped if isinstance(unwrapped, exp.Window) else (unwrapped.find(exp.Window) if hasattr(unwrapped, "find") else None)
                if win_node and col_alias:
                    fn = win_node.this
                    fn_name = (fn.name if isinstance(fn, exp.Anonymous) else (fn.key if fn else "")).upper()
                    if isinstance(fn, (exp.RowNumber, exp.Rank, exp.DenseRank)) or fn_name in ("RANK", "DENSE_RANK", "ROW_NUMBER"):
                        window_rank_aliases.add(f"{outer_alias}.{col_alias}")
                        continue
                base_t, base_c = _trace_col(expr, inner_aliases)
                if base_t and base_c:
                    alias_mapping[f"{outer_alias}.{col_alias or base_c}"] = (base_t, base_c)
                    alias_mapping[f"{outer_alias.upper()}.{(col_alias or base_c).upper()}"] = (base_t, base_c)
                else:
                    agg_node = unwrapped if isinstance(unwrapped, exp.AggFunc) else (unwrapped.find(exp.AggFunc) if hasattr(unwrapped, "find") else None)
                    if agg_node and col_alias:
                        agg_col = agg_node.find(exp.Column)
                        agg_t = (agg_col.table if agg_col else None) or (list(inner_aliases.values())[0] if inner_aliases else None)
                        agg_mapping[f"{outer_alias}.{col_alias}"] = {
                            "agg_func": agg_node.key.upper(),
                            "table": agg_t,
                            "column": agg_col.name if agg_col else None,
                        }

    star_subqueries_upper = {k.upper(): v for k, v in star_subqueries.items()}

    def resolve_alias(table, column):
        curr_t, curr_c = table, column
        visited = set()
        while True:
            key = f"{curr_t}.{curr_c}"
            key_upper = f"{(curr_t or '').upper()}.{(curr_c or '').upper()}"
            if key_upper in visited:
                break
            visited.add(key_upper)
            if key in alias_mapping:
                curr_t, curr_c = alias_mapping[key]
            elif key_upper in alias_mapping:
                curr_t, curr_c = alias_mapping[key_upper]
            elif curr_t in star_subqueries and curr_t != star_subqueries[curr_t]:
                curr_t = star_subqueries[curr_t]
            elif (curr_t or "").upper() in star_subqueries_upper and (curr_t or "").upper() != star_subqueries_upper[(curr_t or "").upper()].upper():
                curr_t = star_subqueries_upper[(curr_t or "").upper()]
            else:
                break
        return curr_t, curr_c

    for j in joins:
        remaining_on_pairs = []
        for pair in j.get("on_pairs", []):
            l_key = f"{pair['left']['table']}.{pair['left']['column']}"
            r_key = f"{pair['right']['table']}.{pair['right']['column']}"
            pair["left"]["table"], pair["left"]["column"] = resolve_alias(pair["left"]["table"], pair["left"]["column"])
            pair["right"]["table"], pair["right"]["column"] = resolve_alias(pair["right"]["table"], pair["right"]["column"])
            if r_key in window_rank_aliases:
                where_literals.append({
                    "table": pair["left"]["table"],
                    "column": pair["left"]["column"],
                    "value": "1",
                    "operator": "EQ",
                })
            elif l_key in window_rank_aliases:
                where_literals.append({
                    "table": pair["right"]["table"],
                    "column": pair["right"]["column"],
                    "value": "1",
                    "operator": "EQ",
                })
            else:
                remaining_on_pairs.append(pair)
        j["on_pairs"] = remaining_on_pairs
            
    for s in selects:
        s["table"], s["column"] = resolve_alias(s["table"], s["column"])
        
    agg_joins = []
    remaining_where_joins = []
    for wj in where_joins:
        l_key = f"{wj['left']['table']}.{wj['left']['column']}"
        r_key = f"{wj['right']['table']}.{wj['right']['column']}"
        if r_key in agg_mapping:
            info = agg_mapping[r_key]
            l_t, l_c = resolve_alias(wj['left']['table'], wj['left']['column'])
            agg_joins.append({
                "left": {"table": l_t, "column": l_c},
                "agg_func": info["agg_func"],
                "right_table": info["table"],
            })
        elif l_key in agg_mapping:
            info = agg_mapping[l_key]
            r_t, r_c = resolve_alias(wj['right']['table'], wj['right']['column'])
            agg_joins.append({
                "left": {"table": r_t, "column": r_c},
                "agg_func": info["agg_func"],
                "right_table": info["table"],
            })
        else:
            wj["left"]["table"], wj["left"]["column"] = resolve_alias(wj["left"]["table"], wj["left"]["column"])
            wj["right"]["table"], wj["right"]["column"] = resolve_alias(wj["right"]["table"], wj["right"]["column"])
            remaining_where_joins.append(wj)
    where_joins[:] = remaining_where_joins

    for wl in where_literals:
        wl["table"], wl["column"] = resolve_alias(wl["table"], wl["column"])
        
    for gb in group_by:
        gb["table"], gb["column"] = resolve_alias(gb["table"], gb["column"])
        
    for ob in order_by:
        ob["table"], ob["column"] = resolve_alias(ob["table"], ob["column"])

    return agg_joins


@functools.lru_cache(maxsize=128)
def _parse_sql_to_ast_internal(query: str) -> dict[str, Any]:
    """
    Parses a SQL string into an AST or dictionary format using sqlglot.
    """
    parsed = None
    last_err = None
    for dialect in [None, 'sqlite', 'mysql', 'postgres']:
        try:
            if dialect:
                parsed = sqlglot.parse_one(query, read=dialect)
            else:
                parsed = sqlglot.parse_one(query)
            if parsed:
                break
        except Exception as e:
            last_err = e
            
    if not parsed:
        return {
            "raw_query": query,
            "ast": None,
            "has_distinct": False,
            "has_order_by": False,
            "tables": [],
            "joins": [],
            "selects": [],
            "error": str(last_err)
        }
        
    _expand_ordinal_group_and_order(parsed)
    _normalize_scoped_aliases(parsed)
    tables, aliases, joins = _extract_tables_and_joins(parsed)
    _extract_subquery_joins(parsed, tables, joins)
    selects, group_by, order_by = _extract_selects_and_grouping(parsed)
    where_literals, where_joins = _extract_where_and_having(parsed)
    agg_joins = _resolve_aliases(parsed, joins, selects, where_joins, where_literals, group_by, order_by)

    lim_node = parsed.args.get("limit")
    off_node = parsed.args.get("offset")

    limit_val = _extract_int_from_limit_expr(lim_node)
    if limit_val is not None and limit_val < 0:
        limit_val = None

    offset_val = _extract_int_from_limit_expr(off_node)
    if offset_val is None and lim_node and lim_node.args.get("offset"):
        offset_val = _extract_int_from_limit_expr(lim_node.args.get("offset"))

    return {
        "raw_query": query,
        "ast": parsed,
        "where_ast": parsed.args.get("where"),
        "having_ast": parsed.args.get("having"),
        "tables": tables,
        "joins": joins,
        "where_joins": where_joins,
        "agg_joins": agg_joins,
        "selects": selects,
        "where_literals": where_literals,
        "group_by": group_by,
        "order_by": order_by,
        "has_distinct": parsed.args.get("distinct") is not None,
        "has_order_by": parsed.args.get("order") is not None,
        "has_group_by": parsed.args.get("group") is not None,
        "has_having": parsed.args.get("having") is not None,
        "has_limit": parsed.args.get("limit") is not None,
        "limit_val": limit_val,
        "offset_val": offset_val,
        "has_offset": offset_val is not None,
    }

def parse_sql_to_ast(query: str) -> dict[str, Any]:
    return copy.deepcopy(_parse_sql_to_ast_internal(query))

def _infer_faker_type(col_name: str, data_type: str):
    dt = data_type.lower()
    if not ("char" in dt or "text" in dt):
        return None
        
    # Normalize by replacing non-alphanumeric characters (like underscores) with spaces
    name = col_name.lower()
    normalized_name = re.sub(r'[^a-z0-9]', ' ', name)
    
    # Specificity matters (e.g. "company name" will hit "company" before "name")
    patterns = {
        "email": r'email|mail',
        "first_name": r'first name|firstname|fname|given name|givenname',
        "last_name": r'last name|lastname|lname|surname|family name|familyname',
        "phone_number": r'phone|tel|mobile|cell|contact',
        "address": r'address|street|location',
        "city": r'city|town',
        "country": r'country|nation',
        "company": r'company|org|employer|business',
        "job": r'job|role|title|profession|occupation',
        "url": r'url|website|link|uri',
        "zipcode": r'zip|postal|postcode',
        "state": r'state|province',
        "ipv4": r'\bip\b|ipv4',
        "uuid4": r'uuid|guid',
        "sentence": r'description|bio|summary|notes|comment',
        "name": r'name|person|user'
    }
    
    for faker_method, pattern in patterns.items():
        if re.search(pattern, normalized_name):
            return faker_method
            
    return "word"

@functools.lru_cache(maxsize=16)
def _parse_ddl_to_schema_internal(ddl: str) -> Schema:
    """
    Parses a DDL string into internal Schema representation using sqlglot.
    """
    tables = {}
    single_col_fk_targets: list[tuple[str, str]] = []
    
    try:
        parsed_statements = sqlglot.parse(ddl, read="sqlite")
    except Exception:
        try:
            parsed_statements = sqlglot.parse(ddl)
        except Exception as e:
            raise ValueError(f"Failed to parse DDL: {e}") from e

    for statement in parsed_statements:
        if not isinstance(statement, exp.Create):
            continue
        
        if statement.args.get("kind") != "TABLE":
            schema_node = statement.find(exp.Schema)
            if not schema_node:
                continue
        else:
            schema_node = statement.find(exp.Schema)
            if not schema_node:
                continue

        table_name = schema_node.this.name.strip("\"'`[]")
        
        columns = []
        col_by_name = {}
        table_pk_cols = []
        table_unique_cols = []
        table_composite_uniques = []
        foreign_keys = []
        check_constraints = []

        for item in schema_node.expressions:
            if isinstance(item, exp.ColumnDef):
                col_name = item.this.name.strip("\"'`[]")
                col_type = item.args.get("kind").sql() if item.args.get("kind") else "VARCHAR"
                
                is_pk = False
                is_unique = False
                is_nullable = True
                explicit_not_null = False
                
                for constraint in item.constraints:
                    kind = constraint.kind
                    if isinstance(kind, exp.PrimaryKeyColumnConstraint):
                        is_pk = True
                        table_pk_cols.append(col_name)
                    elif isinstance(kind, exp.UniqueColumnConstraint):
                        is_unique = True
                        table_unique_cols.append(col_name)
                    elif isinstance(kind, exp.NotNullColumnConstraint):
                        if not kind.args.get("allow_null"):
                            is_nullable = False
                            explicit_not_null = True
                        else:
                            is_nullable = True
                    elif isinstance(kind, exp.CheckColumnConstraint):
                        check_constraints.append({
                            'column': col_name,
                            'expression': kind.this
                        })
                    elif isinstance(kind, exp.Reference):
                        ref_table = kind.this.this.name.strip("\"'`[]") if isinstance(kind.this, exp.Schema) else kind.this.name.strip("\"'`[]")
                        ref_cols = [c.name.strip("\"'`[]") for c in kind.this.expressions] if isinstance(kind.this, exp.Schema) else []
                        ref_col = ref_cols[0] if ref_cols else col_name
                        foreign_keys.append(ForeignKey(
                            column_name=col_name,
                            reference_table=ref_table,
                            reference_column=ref_col
                        ))
                        single_col_fk_targets.append((ref_table, ref_col))
                
                col_obj = Column(
                    name=col_name,
                    data_type=col_type,
                    is_primary_key=is_pk,
                    is_unique=is_unique,
                    is_nullable=is_nullable,
                    explicit_not_null=explicit_not_null,
                    faker_type=_infer_faker_type(col_name, col_type)
                )
                columns.append(col_obj)
                col_by_name[col_name] = col_obj

            elif isinstance(item, exp.PrimaryKey):
                cols = [c.name.strip("\"'`[]") for c in item.expressions]
                table_pk_cols.extend(cols)

            elif isinstance(item, exp.UniqueColumnConstraint):
                if isinstance(item.this, exp.Schema):
                    cols = [c.name.strip("\"'`[]") for c in item.this.expressions]
                elif hasattr(item, "expressions"):
                    cols = [c.name.strip("\"'`[]") for c in item.expressions]
                else:
                    cols = []
                if len(cols) == 1:
                    table_unique_cols.extend(cols)
                elif len(cols) > 1:
                    table_composite_uniques.append(cols)

            elif isinstance(item, exp.ForeignKey):
                cols = [c.name.strip("\"'`[]") for c in item.expressions]
                ref = item.args.get("reference")
                if ref:
                    ref_table = ref.this.this.name.strip("\"'`[]") if isinstance(ref.this, exp.Schema) else ref.this.name.strip("\"'`[]")
                    ref_cols = [c.name.strip("\"'`[]") for c in ref.this.expressions] if isinstance(ref.this, exp.Schema) else []
                    
                    for idx, col in enumerate(cols):
                        ref_col = ref_cols[idx] if idx < len(ref_cols) else col
                        foreign_keys.append(ForeignKey(
                            column_name=col,
                            reference_table=ref_table,
                            reference_column=ref_col
                        ))
                        if len(cols) == 1:
                            single_col_fk_targets.append((ref_table, ref_col))

            elif isinstance(item, (exp.Check, exp.CheckColumnConstraint)):
                # Table-level CHECK constraint — extract referenced columns
                referenced_cols = [c.name.strip("\"'`[]") for c in item.this.find_all(exp.Column)]
                col_name_for_check = referenced_cols[0] if len(referenced_cols) == 1 else None
                check_constraints.append({
                    'column': col_name_for_check,
                    'expression': item.this
                })

        for col_name in table_pk_cols:
            if col_name in col_by_name:
                col_by_name[col_name].is_primary_key = True
                col_by_name[col_name].is_nullable = False
                
        for col_name in table_unique_cols:
            if col_name in col_by_name:
                col_by_name[col_name].is_unique = True

        tables[table_name] = Table(name=table_name, columns=columns, foreign_keys=foreign_keys, check_constraints=check_constraints, unique_constraints=table_composite_uniques)

    # Mark single-column foreign key target columns in referenced tables as UNIQUE
    for ref_tbl_name, ref_col_name in single_col_fk_targets:
        ref_tbl_canonical = None
        for t in tables:
            if t.upper() == ref_tbl_name.upper():
                ref_tbl_canonical = t
                break
        if ref_tbl_canonical:
            ref_tbl = tables[ref_tbl_canonical]
            for col in ref_tbl.columns:
                if col.name.upper() == ref_col_name.upper():
                    col.is_unique = True
                    break

    return Schema(tables=tables, raw_ddl=ddl)

def parse_ddl_to_schema(ddl: str) -> Schema:
    return copy.deepcopy(_parse_ddl_to_schema_internal(ddl))
