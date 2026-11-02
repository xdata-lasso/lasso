"""
ConditionalFunctionAttackStrategy Module

Target semantic bug:
Mutants that alter conditional expression logic in CASE ... WHEN or IF statements (e.g., swapped THEN/ELSE branches, inverted WHEN predicates, or omitted condition branches).

Algorithm & Dataset Design:
1. Parse the AST to locate CASE or IF/IIF conditional expressions.
2. For each WHEN branch (including compound AND/OR predicates across multiple attributes) and the optional ELSE branch, construct value injections on table attributes that force the condition to evaluate to true or false for that specific branch.
3. Generate distinct datasets for each branch path to ensure complete decision branch coverage.
4. Generate a mixed-branch dataset with an asymmetric, non-power-of-two row count (e.g., 1 WHEN row + 2 ELSE rows = 3 rows, varying individual conjuncts across ELSE rows for multi-column AND branches) and distinct power-of-two measure weights so that branch cardinalities are unequal, omitted conjuncts/disjuncts diverge, and COUNT/AVG/SUM ratio denominators are non-dyadic (exposing floating-point order-of-operations and integer division differences).
5. If a mutant incorrectly alters condition evaluations, swaps branch return expressions, or changes arithmetic evaluation order over conditional aggregates, executing the original vs mutant query across these datasets will produce conflicting results.
"""

from datetime import timedelta
import re
from typing import Any
import copy
from dateutil.parser import parse as dateutil_parse
import sqlglot

import sqlglot.expressions as exp
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator.constraints import _coerce_temporal
from dataset_generator.value_generator import (
    coerce_literal_for_column,
    generate_unique_value_for_column,
    value_matching_like_pattern,
)
from dataset_generator import (
    compute_self_offset_values,
    extract_self_offset_patterns,
    generate_base_dataset,
    next_distinct_value,
    resolve_query_column,
)
from parser import _extract_substring_meta, _extract_temporal_meta

class ConditionalFunctionAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Wrong logic in CASE WHEN or IF statements.
    Generates datasets covering each branch (each THEN block and the ELSE block)
    to ensure the mutant logic isn't equivalent to the original query.
    """

    def is_applicable(self, schema: Schema, parsed_query: dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return False
            
        for node in parsed.find_all((exp.Case, exp.If)):
            return True
        return False

    def generate(self, schema: Schema, parsed_query: dict[str, Any]) -> list[Dataset]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        datasets = []
        
        def resolve_col(col_name: str, given_table: str) -> tuple[str, str] | None:
            resolved = resolve_query_column(schema, parsed_query, given_table, col_name)
            if resolved:
                return resolved
            tables_in_query = parsed_query.get("tables", [])
            if given_table:
                for t in tables_in_query:
                    alias = t.get("alias")
                    name = t.get("name")
                    if (alias and alias.lower() == given_table.lower()) or (name and name.lower() == given_table.lower()):
                        st = schema.find_table(t["name"])
                        if st:
                            sc = schema.find_column(st, col_name)
                            if sc:
                                return st, sc.name
                st = schema.find_table(given_table)
                if st:
                    sc = schema.find_column(st, col_name)
                    if sc:
                        return st, sc.name
            for t in tables_in_query:
                st = schema.find_table(t["name"])
                if st:
                    sc = schema.find_column(st, col_name)
                    if sc:
                        return st, sc.name
            return None

        def _unwrap_col_node(node: exp.Expression | None) -> exp.Column | None:
            curr = node
            while isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren, exp.Max, exp.Min, exp.Avg)):
                curr = curr.this
            return curr if isinstance(curr, exp.Column) else None

        def _extract_num_lit(node: exp.Expression | None) -> int | float | None:
            if isinstance(node, exp.Literal):
                s = str(node.name).strip()
                if s.lstrip("-").replace(".", "", 1).isdigit():
                    return float(s) if "." in s else int(s)
            elif isinstance(node, exp.Neg) and isinstance(node.this, exp.Literal):
                s = str(node.this.name).strip()
                if s.replace(".", "", 1).isdigit():
                    return -float(s) if "." in s else -int(s)
            return None

        query_branch_viol_values: dict[tuple[str, str], list[Any]] = {}

        def _record_viol(t_n: str, c_n: str, v_val: Any, allow_none: bool = False) -> None:
            if v_val is None and not allow_none:
                return
            v_list = query_branch_viol_values.setdefault((t_n, c_n), [])
            if v_val not in v_list:
                v_list.append(v_val)

        def _extract_branch_col_and_val(
            cond_expr: exp.Expression | None, case_operand: exp.Expression | None = None
        ) -> tuple[str, str, Any, str | None] | None:
            if isinstance(case_operand, exp.Column) and isinstance(cond_expr, exp.Literal):
                res = resolve_col(case_operand.name, case_operand.table)
                if res:
                    t_n, c_n = res
                    col_def = schema.find_column(t_n, c_n)
                    sat_v = coerce_literal_for_column(col_def, cond_expr.name) if col_def else cond_expr.name
                    return t_n, c_n, sat_v, None
            if cond_expr is None:
                return None

            curr = cond_expr
            is_neg = False
            while isinstance(curr, (exp.Paren, exp.Not)):
                if isinstance(curr, exp.Not):
                    is_neg = not is_neg
                curr = curr.this
            if curr is None:
                return None
            if bool(curr.args.get("negate")):
                is_neg = not is_neg

            if isinstance(curr, (exp.EQ, exp.NEQ)) and not (isinstance(curr, exp.EQ) and is_neg) and not (isinstance(curr, exp.NEQ) and not is_neg):
                l_col = _unwrap_col_node(curr.left)
                r_col = _unwrap_col_node(curr.right)
                col_node = l_col if (l_col and isinstance(curr.right, exp.Literal)) else (r_col if (r_col and isinstance(curr.left, exp.Literal)) else None)
                lit_node = curr.right if col_node is l_col else (curr.left if col_node is r_col else None)
                if col_node is not None and isinstance(lit_node, exp.Literal):
                    res = resolve_col(col_node.name, col_node.table)
                    if res:
                        t_n, c_n = res
                        col_def = schema.find_column(t_n, c_n)
                        sat_v = coerce_literal_for_column(col_def, lit_node.name) if col_def else lit_node.name
                        return t_n, c_n, sat_v, None
                expr_side = curr.left if isinstance(curr.right, exp.Literal) else (curr.right if isinstance(curr.left, exp.Literal) else None)
                lit_side = curr.right if expr_side is curr.left else (curr.left if expr_side is curr.right else None)
                if expr_side is not None and isinstance(lit_side, exp.Literal):
                    cols_in_expr = list(expr_side.find_all(exp.Column))
                    if len(cols_in_expr) == 1:
                        res = resolve_col(cols_in_expr[0].name, cols_in_expr[0].table)
                        if res:
                            t_n, c_n = res
                            col_def = schema.find_column(t_n, c_n)
                            temp_meta = _extract_temporal_meta(expr_side)
                            sub_meta = _extract_substring_meta(expr_side)
                            if temp_meta:
                                fmt = temp_meta.get("strftime_format")
                                sat_v = _coerce_temporal(lit_side.name, "EQ", fmt)
                                pat = f"{lit_side.name}-%" if fmt == "%Y-%m" else None
                                return t_n, c_n, sat_v, pat
                            elif sub_meta and sub_meta[0] == 1:
                                s_lit = str(lit_side.name).strip()
                                pat = f"{s_lit}-%" if re.match(r"^\d{4}-\d{2}$", s_lit) else f"{s_lit}%"
                                sat_v = (
                                    value_matching_like_pattern(col_def, pat)
                                    if col_def is not None
                                    else s_lit
                                )
                                return t_n, c_n, sat_v, pat
            elif isinstance(curr, (exp.GT, exp.GTE, exp.LT, exp.LTE)):
                l_col = _unwrap_col_node(curr.left)
                r_col = _unwrap_col_node(curr.right)
                r_num = _extract_num_lit(curr.right)
                l_num = _extract_num_lit(curr.left)
                col_node = None
                num_bound = None
                col_on_left = True
                if l_col is not None and r_num is not None:
                    col_node, num_bound, col_on_left = l_col, r_num, True
                elif r_col is not None and l_num is not None:
                    col_node, num_bound, col_on_left = r_col, l_num, False
                if col_node is not None and num_bound is not None:
                    res = resolve_col(col_node.name, col_node.table)
                    if res:
                        t_n, c_n = res
                        eff_op = curr.__class__.__name__.upper()
                        if not col_on_left:
                            flip_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE"}
                            eff_op = flip_map.get(eff_op, eff_op)
                        if is_neg:
                            neg_map = {"GT": "LTE", "GTE": "LT", "LT": "GTE", "LTE": "GT"}
                            eff_op = neg_map.get(eff_op, eff_op)
                        step = 1.0 if isinstance(num_bound, float) else 1
                        if eff_op in ("GT", "GTE"):
                            sat_v = num_bound + step
                            viol_v = num_bound if eff_op == "GT" else (num_bound - step)
                        else:
                            sat_v = num_bound - step
                            viol_v = num_bound if eff_op == "LT" else (num_bound + step)
                        _record_viol(t_n, c_n, viol_v)
                        return t_n, c_n, sat_v, None
            elif isinstance(curr, exp.Between) and not is_neg:
                b_col = _unwrap_col_node(curr.this)
                low_num = _extract_num_lit(curr.args.get("low"))
                high_num = _extract_num_lit(curr.args.get("high"))
                if b_col is not None and low_num is not None and high_num is not None and low_num <= high_num:
                    res = resolve_col(b_col.name, b_col.table)
                    if res:
                        t_n, c_n = res
                        mid = (low_num + high_num) / 2
                        sat_v = int(mid) if isinstance(low_num, int) and isinstance(high_num, int) else mid
                        step = 1.0 if isinstance(high_num, float) else 1
                        _record_viol(t_n, c_n, high_num + step)
                        return t_n, c_n, sat_v, None
            elif isinstance(curr, exp.And) and not is_neg:
                bounds_by_col: dict[tuple[str, str], dict[str, Any]] = {}
                for sub_comp in curr.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE)):
                    if sub_comp.find_ancestor(exp.Or) is not None:
                        continue
                    sub_not = 0
                    p_curr = sub_comp.parent
                    while p_curr and p_curr is not curr.parent:
                        if isinstance(p_curr, exp.Not):
                            sub_not += 1
                        p_curr = p_curr.parent
                    sub_neg = (sub_not % 2 == 1) ^ bool(sub_comp.args.get("negate"))
                    l_col = _unwrap_col_node(sub_comp.left)
                    r_col = _unwrap_col_node(sub_comp.right)
                    r_num = _extract_num_lit(sub_comp.right)
                    l_num = _extract_num_lit(sub_comp.left)
                    col_node = None
                    num_bound = None
                    col_on_left = True
                    if l_col is not None and r_num is not None:
                        col_node, num_bound, col_on_left = l_col, r_num, True
                    elif r_col is not None and l_num is not None:
                        col_node, num_bound, col_on_left = r_col, l_num, False
                    if col_node is not None and num_bound is not None:
                        res = resolve_col(col_node.name, col_node.table)
                        if res:
                            eff_op = sub_comp.__class__.__name__.upper()
                            if not col_on_left:
                                flip_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE"}
                                eff_op = flip_map.get(eff_op, eff_op)
                            if sub_neg:
                                neg_map = {"GT": "LTE", "GTE": "LT", "LT": "GTE", "LTE": "GT"}
                                eff_op = neg_map.get(eff_op, eff_op)
                            entry = bounds_by_col.setdefault(res, {})
                            if eff_op in ("GT", "GTE"):
                                if "low" not in entry or num_bound > entry["low"]:
                                    entry["low"] = num_bound
                                    entry["low_op"] = eff_op
                            else:
                                if "high" not in entry or num_bound < entry["high"]:
                                    entry["high"] = num_bound
                                    entry["high_op"] = eff_op
                for (t_n, c_n), b_dict in bounds_by_col.items():
                    if "low" in b_dict and "high" in b_dict and b_dict["low"] < b_dict["high"]:
                        low_v, high_v = b_dict["low"], b_dict["high"]
                        mid = (low_v + high_v) / 2
                        sat_v = int(mid) if isinstance(low_v, int) and isinstance(high_v, int) else mid
                        viol_v = low_v if b_dict.get("low_op") == "GT" else (high_v + (1.0 if isinstance(high_v, float) else 1))
                        _record_viol(t_n, c_n, viol_v)
                        return t_n, c_n, sat_v, None
            elif isinstance(curr, (exp.Like, exp.ILike)) and not is_neg:
                l_col = _unwrap_col_node(curr.left)
                if l_col is not None and isinstance(curr.right, exp.Literal):
                    res = resolve_col(l_col.name, l_col.table)
                    if res:
                        t_n, c_n = res
                        col_def = schema.find_column(t_n, c_n)
                        pat = str(curr.right.name)
                        sat_v = (
                            value_matching_like_pattern(col_def, pat)
                            if col_def is not None
                            else pat.replace("%", "").replace("_", "")
                        )
                        return t_n, c_n, sat_v, pat
            elif isinstance(curr, exp.In) and not is_neg:
                l_col = _unwrap_col_node(curr.this)
                if l_col is not None:
                    res = resolve_col(l_col.name, l_col.table)
                    if res:
                        t_n, c_n = res
                        col_def = schema.find_column(t_n, c_n)
                        for item in curr.expressions or []:
                            if isinstance(item, exp.Literal):
                                sat_v = coerce_literal_for_column(col_def, item.name) if col_def else item.name
                                return t_n, c_n, sat_v, None
            elif isinstance(curr, exp.Is) and isinstance(curr.expression, exp.Null):
                l_col = _unwrap_col_node(curr.this)
                if l_col is not None:
                    res = resolve_col(l_col.name, l_col.table)
                    if res:
                        t_n, c_n = res
                        col_def = schema.find_column(t_n, c_n)
                        if is_neg:
                            sat_v = (
                                generate_unique_value_for_column(col_def)
                                if col_def is not None
                                else 1
                            )
                            _record_viol(t_n, c_n, None, allow_none=True)
                            return t_n, c_n, sat_v, None
                        else:
                            viol_1 = (
                                generate_unique_value_for_column(col_def)
                                if col_def is not None
                                else 1
                            )
                            viol_2 = (
                                next_distinct_value(col_def, viol_1)
                                if col_def is not None
                                else 2
                            )
                            _record_viol(t_n, c_n, viol_1)
                            _record_viol(t_n, c_n, viol_2)
                            return t_n, c_n, None, None
            return None

        def _resolve_truthy_expr_columns(
            expr_node: exp.Expression, visited_aliases: set[str] | None = None
        ) -> list[tuple[str, str]]:
            if visited_aliases is None:
                visited_aliases = set()
            resolved_cols: list[tuple[str, str]] = []
            seen_pairs: set[tuple[str, str]] = set()
            col_nodes = [expr_node] if isinstance(expr_node, exp.Column) else list(expr_node.find_all(exp.Column))
            for col_node in col_nodes:
                c_name = col_node.name
                c_tbl = col_node.table or ""
                if not c_name:
                    continue
                direct_in_schema = False
                if c_tbl:
                    for t_info in parsed_query.get("tables", []):
                        alias = t_info.get("alias") or ""
                        name = t_info.get("name") or ""
                        if alias.lower() == c_tbl.lower() or name.lower() == c_tbl.lower():
                            st = schema.find_table(name)
                            if st and schema.find_column(st, c_name):
                                direct_in_schema = True
                                break
                    if not direct_in_schema:
                        st = schema.find_table(c_tbl)
                        if st and schema.find_column(st, c_name):
                            direct_in_schema = True
                else:
                    for t_info in parsed_query.get("tables", []):
                        st = schema.find_table(t_info.get("name", ""))
                        if st and schema.find_column(st, c_name):
                            direct_in_schema = True
                            break

                expanded_from_alias = False
                if not direct_in_schema and c_name.upper() not in visited_aliases:
                    next_visited = visited_aliases | {c_name.upper()}
                    for sel_node in parsed.find_all(exp.Select):
                        for sel_expr in sel_node.expressions or []:
                            if (
                                isinstance(sel_expr, exp.Alias)
                                and (sel_expr.alias or "").upper() == c_name.upper()
                                and sel_expr.this is not None
                            ):
                                for sub_t, sub_c in _resolve_truthy_expr_columns(sel_expr.this, next_visited):
                                    pair_key = (sub_t.upper(), sub_c.upper())
                                    if pair_key not in seen_pairs:
                                        seen_pairs.add(pair_key)
                                        resolved_cols.append((sub_t, sub_c))
                                    expanded_from_alias = True

                if not expanded_from_alias:
                    res = resolve_col(c_name, c_tbl)
                    if res:
                        pair_key = (res[0].upper(), res[1].upper())
                        if pair_key not in seen_pairs:
                            seen_pairs.add(pair_key)
                            resolved_cols.append(res)
            return resolved_cols

        # Pre-collect all branch satisfying values and LIKE patterns across the entire query per (table, col)
        def _extract_branch_atoms(
            cond_expr: exp.Expression | None, case_operand: exp.Expression | None = None
        ) -> list[tuple[str, str, Any, str | None]]:
            single = _extract_branch_col_and_val(cond_expr, case_operand)
            if single is not None:
                return [single]
            curr = cond_expr
            is_neg = False
            while isinstance(curr, (exp.Paren, exp.Not)):
                if isinstance(curr, exp.Not):
                    is_neg = not is_neg
                curr = curr.this
            if curr is None:
                return []
            if not is_neg and isinstance(curr, (exp.And, exp.Or)):
                atoms: list[tuple[str, str, Any, str | None]] = []
                seen_atoms: set[tuple[str, str, str]] = set()
                for side in (curr.left, curr.right):
                    for item in _extract_branch_atoms(side, case_operand):
                        sig = (item[0].upper(), item[1].upper(), str(item[2]))
                        if sig not in seen_atoms:
                            seen_atoms.add(sig)
                            atoms.append(item)
                return atoms

            if case_operand is None and not isinstance(
                curr,
                (
                    exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE,
                    exp.Between, exp.Like, exp.ILike, exp.In, exp.Is,
                    exp.And, exp.Or, exp.Exists,
                ),
            ):
                truthy_atoms: list[tuple[str, str, Any, str | None]] = []
                for t_n, c_n in _resolve_truthy_expr_columns(curr):
                    col_def = schema.find_column(t_n, c_n)
                    if col_def is None or col_def.is_primary_key or col_def.is_unique:
                        continue
                    dt_low = (col_def.data_type or "").lower()
                    if not any(k in dt_low for k in ("int", "real", "floa", "doub", "num", "dec", "bool")):
                        continue
                    is_float = any(k in dt_low for k in ("real", "floa", "doub"))
                    truthy_val: int | float = 1.0 if is_float else 1
                    falsy_val: int | float = 0.0 if is_float else 0
                    sat_v = falsy_val if is_neg else truthy_val
                    viol_v = truthy_val if is_neg else falsy_val
                    _record_viol(t_n, c_n, viol_v)
                    truthy_atoms.append((t_n, c_n, sat_v, None))
                return truthy_atoms

            return []

        cond_nodes: list[tuple[exp.Expression, exp.Expression | None, list[exp.Expression]]] = []
        for c_node in parsed.find_all(exp.Case):
            cond_nodes.append((c_node, c_node.this, list(c_node.args.get("ifs", []))))
        for if_node in parsed.find_all(exp.If):
            if not isinstance(if_node.parent, exp.Case):
                cond_nodes.append((if_node, None, [if_node]))

        query_branch_values: dict[tuple[str, str], list[Any]] = {}
        query_like_patterns: dict[tuple[str, str], list[str]] = {}
        for _, c_op, c_ifs in cond_nodes:
            for if_b in c_ifs:
                for b_t, b_c, b_val, b_pat in _extract_branch_atoms(if_b.this, c_op):
                    key = (b_t, b_c)
                    v_list = query_branch_values.setdefault(key, [])
                    if b_val not in v_list:
                        v_list.append(b_val)
                    if b_pat is not None:
                        p_list = query_like_patterns.setdefault(key, [])
                        if b_pat not in p_list:
                            p_list.append(b_pat)

        where_constrained_cols: set[tuple[str, str]] = set()
        for wl in parsed_query.get("where_literals", []):
            res_wl = resolve_col(wl.get("column", ""), wl.get("table", ""))
            if res_wl:
                where_constrained_cols.add((res_wl[0].upper(), res_wl[1].upper()))

        def _compute_col_fallbacks(
            col_t: str, col_c: str, col_first_val: Any
        ) -> tuple[Any, Any, Any] | None:
            col_def = schema.find_column(col_t, col_c)
            if col_def is None:
                return None
            branch_values = list(query_branch_values.get((col_t, col_c), [col_first_val]))
            like_patterns = list(query_like_patterns.get((col_t, col_c), []))
            like_regexes = [
                re.compile(
                    "^" + "".join(".*" if ch == "%" else ("." if ch == "_" else re.escape(ch)) for ch in pat) + "$",
                    re.IGNORECASE,
                )
                for pat in like_patterns
            ]

            def _matches_branch(cand: Any) -> bool:
                if cand in branch_values:
                    return True
                s_cand = str(cand)
                return any(rx.match(s_cand) for rx in like_regexes)

            expl_viols = query_branch_viol_values.get((col_t, col_c), [])
            if expl_viols:
                fb_1 = expl_viols[0]
            else:
                fb_1 = next_distinct_value(
                    col_def,
                    branch_values[0] if branch_values else None,
                )
                attempts = 0
                while _matches_branch(fb_1) and attempts < 50:
                    attempts += 1
                    if (col_def.is_temporal or like_patterns) and isinstance(fb_1, str) and re.match(r"^\d{4}-\d{2}-\d{2}", fb_1):
                        try:
                            dt = dateutil_parse(fb_1)
                            step_days = 366 if attempts <= 5 else 32
                            fb_1 = (dt + timedelta(days=step_days)).strftime("%Y-%m-%d")
                            continue
                        except Exception:
                            pass
                    fb_1 = next_distinct_value(col_def, fb_1)

            if expl_viols:
                fb_2 = expl_viols[1] if len(expl_viols) > 1 else fb_1
            else:
                fb_2 = next_distinct_value(col_def, fb_1)
                attempts_2 = 0
                while (_matches_branch(fb_2) or fb_2 == fb_1) and attempts_2 < 50:
                    attempts_2 += 1
                    if (col_def.is_temporal or like_patterns) and isinstance(fb_2, str) and re.match(r"^\d{4}-\d{2}-\d{2}", fb_2):
                        try:
                            dt = dateutil_parse(fb_2)
                            step_days = 366 if attempts_2 <= 5 else 32
                            fb_2 = (dt + timedelta(days=step_days)).strftime("%Y-%m-%d")
                            continue
                        except Exception:
                            pass
                    fb_2 = next_distinct_value(col_def, fb_2)

            primary_val = branch_values[0] if branch_values else col_first_val
            return primary_val, fb_1, fb_2

        seen_single_branch: set[Any] = set()
        seen_else_cols: set[Any] = set()

        for _, case_operand, ifs in cond_nodes:
            for branch_idx, if_node in enumerate(ifs):
                b_atoms = _extract_branch_atoms(if_node.this, case_operand)
                if b_atoms:
                    if len(b_atoms) == 1:
                        t, canonical_col, val, _ = b_atoms[0]
                        branch_sig: Any = (t.upper(), canonical_col.upper(), str(val))
                        v_inj: dict[tuple[str, str], Any] = {(t, canonical_col): val}
                    else:
                        branch_sig = tuple((bt.upper(), bc.upper(), str(bv)) for bt, bc, bv, _ in b_atoms)
                        v_inj = {}
                        for bt, bc, bv, _ in b_atoms:
                            v_inj.setdefault((bt, bc), bv)
                    if branch_sig in seen_single_branch:
                        continue
                    seen_single_branch.add(branch_sig)

                    ds_data = generate_base_dataset(schema, parsed_query, value_injections=v_inj)

                    # Append unmatched parent row to parent tables to catch outer join mutations
                    for p_table in schema.tables.values():
                        if any(fk.reference_table == p_table.name for t_obj in schema.tables.values() for fk in t_obj.foreign_keys):
                            if p_table.name in ds_data and ds_data[p_table.name]:
                                unique_cols = [c for c in p_table.columns if c.is_primary_key or c.is_unique]
                                if unique_cols:
                                    new_r = copy.deepcopy(ds_data[p_table.name][-1])
                                    for u_col in unique_cols:
                                        new_r[u_col.name] = generate_unique_value_for_column(u_col)
                                    ds_data[p_table.name].append(new_r)

                    datasets.append(Dataset(
                        strategy_name=f"{self.__class__.__name__}_branch_{branch_idx}",
                        data=ds_data,
                        tags=["conditional_function_attack"],
                        description=f"Targets Conditional Function bugs. Dataset sets condition values specifically to trigger CASE WHEN branch {branch_idx}. This explicitly verifies the outcome of this specific branch by ensuring all preceding branches evaluate to false, and differentiating it from other branches. Mutants mutating this branch will produce an incorrect output."
                    ))
                else:
                    offset_pats = extract_self_offset_patterns(schema, parsed_query, if_node.this)
                    if offset_pats:
                        pat = offset_pats[0]
                        t, canonical_col = pat["table"], pat["column"]
                        offset_vals = compute_self_offset_values(
                            schema, t, canonical_col, pat["offset"], pat["date_func"]
                        )
                        v_inj = {(t, canonical_col): offset_vals["satisfying_pair"]}
                        datasets.append(Dataset(
                            strategy_name=f"{self.__class__.__name__}_branch_{branch_idx}",
                            data=generate_base_dataset(schema, parsed_query, value_injections=v_inj),
                            tags=["conditional_function_attack"],
                            description=f"Targets Conditional Function bugs on self-offset predicate. Dataset injects paired values for `{t}.{canonical_col}` to satisfy CASE WHEN branch {branch_idx}."
                        ))


            # Generate a dataset hitting the ELSE branch
            if ifs:
                first_atoms = _extract_branch_atoms(ifs[0].this, case_operand)
                unique_col_atoms: list[tuple[str, str, Any]] = []
                seen_atom_cols: set[tuple[str, str]] = set()
                for bt, bc, bv, _ in first_atoms:
                    ck = (bt.upper(), bc.upper())
                    if ck not in seen_atom_cols:
                        seen_atom_cols.add(ck)
                        unique_col_atoms.append((bt, bc, bv))

                first_info = first_atoms[0] if len(unique_col_atoms) == 1 else None
                if not first_atoms:
                    offset_pats = extract_self_offset_patterns(schema, parsed_query, ifs[0].this)
                    if offset_pats:
                        pat = offset_pats[0]
                        t, canonical_col = pat["table"], pat["column"]
                        offset_vals = compute_self_offset_values(
                            schema, t, canonical_col, pat["offset"], pat["date_func"]
                        )
                        datasets.append(Dataset(
                            strategy_name=f"{self.__class__.__name__}_branch_else",
                            data=generate_base_dataset(
                                schema, parsed_query, value_injections={(t, canonical_col): offset_vals["non_matching_pair"]}
                            ),
                            tags=["conditional_function_attack"],
                            description=f"Targets Conditional Function bugs on self-offset predicate. Dataset sets non-matching offset values for `{t}.{canonical_col}` to force execution of the CASE ELSE branch."
                        ))
                        datasets.append(Dataset(
                            strategy_name=f"{self.__class__.__name__}_mixed_branches",
                            data=generate_base_dataset(
                                schema, parsed_query, value_injections={(t, canonical_col): offset_vals["mixed_triple"]}
                            ),
                            tags=["conditional_function_attack"],
                            description=f"Targets Conditional Function bugs with mixed branch execution across rows for `{t}.{canonical_col}`, pairing matching and non-matching offset rows within the same group."
                        ))
                elif len(unique_col_atoms) > 1:
                    multi_sig = tuple((bt.upper(), bc.upper()) for bt, bc, _ in unique_col_atoms)
                    if multi_sig in seen_else_cols:
                        continue
                    seen_else_cols.add(multi_sig)

                    col_fb_map: dict[tuple[str, str], tuple[Any, Any, Any]] = {}
                    for bt, bc, bv in unique_col_atoms:
                        fb_res = _compute_col_fallbacks(bt, bc, bv)
                        if fb_res is not None:
                            col_fb_map[(bt, bc)] = fb_res
                    if len(col_fb_map) < len(unique_col_atoms):
                        continue

                    has_or = ifs[0].this is not None and ifs[0].this.find(exp.Or) is not None
                    unconstrained_atoms = [
                        (bt, bc)
                        for bt, bc, _ in unique_col_atoms
                        if (bt.upper(), bc.upper()) not in where_constrained_cols
                    ]
                    vary_cols = (
                        unconstrained_atoms
                        if (unconstrained_atoms and not has_or)
                        else [(bt, bc) for bt, bc, _ in unique_col_atoms]
                    )
                    vary_set = {(bt.upper(), bc.upper()) for bt, bc in vary_cols}

                    v_inj_else: dict[tuple[str, str], Any] = {}
                    for bt, bc, _ in unique_col_atoms:
                        p_val, fb_1, _ = col_fb_map[(bt, bc)]
                        v_inj_else[(bt, bc)] = fb_1 if (bt.upper(), bc.upper()) in vary_set else p_val

                    datasets.append(Dataset(
                        strategy_name=f"{self.__class__.__name__}_branch_else",
                        data=generate_base_dataset(schema, parsed_query, value_injections=v_inj_else),
                        tags=["conditional_function_attack"],
                        description="Targets Conditional Function bugs. Dataset sets condition values such that ALL explicitly defined WHEN branches evaluate to FALSE. This strictly forces the execution of the CASE ELSE branch, ensuring that a mutant mutating or removing the ELSE branch will fail."
                    ))

                    v_inj_mixed: dict[tuple[str, str], Any] = {}
                    if not has_or and len(vary_cols) >= 2:
                        num_rows = 1 + len(vary_cols)
                        add_extra_false_row = (num_rows & (num_rows - 1)) == 0
                        if add_extra_false_row:
                            num_rows += 1
                        for bt, bc, _ in unique_col_atoms:
                            p_val, fb_1, fb_2 = col_fb_map[(bt, bc)]
                            col_def = schema.find_column(bt, bc)
                            is_u = bool(col_def and (col_def.is_primary_key or col_def.is_unique))
                            if (bt.upper(), bc.upper()) not in vary_set:
                                v_inj_mixed[(bt, bc)] = [p_val] * num_rows
                            elif is_u:
                                vals_u = [p_val, fb_1, fb_2]
                                while len(vals_u) < num_rows:
                                    vals_u.append(next_distinct_value(col_def, vals_u[-1]))
                                v_inj_mixed[(bt, bc)] = vals_u[:num_rows]
                            else:
                                target_false_row = 1 + (len(vary_cols) - 1 - vary_cols.index((bt, bc)))
                                row_vals = [
                                    fb_1 if r_idx == target_false_row else p_val
                                    for r_idx in range(1 + len(vary_cols))
                                ]
                                if add_extra_false_row:
                                    row_vals.append(fb_2)
                                v_inj_mixed[(bt, bc)] = row_vals
                    else:
                        num_rows = 3
                        for idx_c, (bt, bc, _) in enumerate(unique_col_atoms):
                            p_val, fb_1, fb_2 = col_fb_map[(bt, bc)]
                            if (bt.upper(), bc.upper()) not in vary_set:
                                v_inj_mixed[(bt, bc)] = [p_val, p_val, p_val]
                            elif has_or and idx_c > 0:
                                v_inj_mixed[(bt, bc)] = [fb_1, fb_1, fb_2]
                            else:
                                v_inj_mixed[(bt, bc)] = [p_val, fb_1, fb_2]

                    for c_node, _, _ in cond_nodes:
                        for col_node in c_node.find_all(exp.Column):
                            c_res = resolve_col(col_node.name, col_node.table)
                            if c_res:
                                c_table, c_col_name = c_res
                                col_obj = schema.find_column(c_table, c_col_name)
                                if (
                                    col_obj
                                    and (c_table.upper(), col_obj.name.upper()) not in seen_atom_cols
                                    and (c_table, col_obj.name) not in query_branch_values
                                    and any(t_type in col_obj.data_type.lower() for t_type in ("int", "real", "float", "double", "numeric", "decimal"))
                                ):
                                    if not col_obj.is_primary_key and not col_obj.is_unique:
                                        v_inj_mixed[(c_table, col_obj.name)] = [2 ** idx for idx in range(num_rows)]

                    datasets.append(Dataset(
                        strategy_name=f"{self.__class__.__name__}_mixed_branches",
                        data=generate_base_dataset(schema, parsed_query, value_injections=v_inj_mixed),
                        tags=["conditional_function_attack"],
                        description="Targets Conditional Function bugs with mixed branch execution across rows. Dataset forces some rows to satisfy the WHEN branch condition and other rows to satisfy the ELSE branch condition. This catches non-associativity, percentage/ratio scaling, and partial aggregation non-equivalence."
                    ))
                if first_info is not None:
                    t, canonical_col, first_val, _ = first_info
                    col_key_up = (t.upper(), canonical_col.upper())
                    if col_key_up in seen_else_cols:
                        continue
                    seen_else_cols.add(col_key_up)

                    col_def = schema.find_column(t, canonical_col)
                    if col_def is None:
                        continue

                    branch_values = list(query_branch_values.get((t, canonical_col), [first_val]))
                    like_patterns = list(query_like_patterns.get((t, canonical_col), []))
                    like_regexes = [
                        re.compile(
                            "^" + "".join(".*" if ch == "%" else ("." if ch == "_" else re.escape(ch)) for ch in pat) + "$",
                            re.IGNORECASE,
                        )
                        for pat in like_patterns
                    ]

                    def _matches_branch(cand: Any) -> bool:
                        if cand in branch_values:
                            return True
                        s_cand = str(cand)
                        return any(rx.match(s_cand) for rx in like_regexes)

                    expl_viols = query_branch_viol_values.get((t, canonical_col), [])
                    if expl_viols:
                        fallback_val = expl_viols[0]
                    else:
                        fallback_val = next_distinct_value(
                            col_def,
                            branch_values[0] if branch_values else None,
                        )
                        attempts = 0
                        while _matches_branch(fallback_val) and attempts < 50:
                            attempts += 1
                            if (col_def.is_temporal or like_patterns) and isinstance(fallback_val, str) and re.match(r"^\d{4}-\d{2}-\d{2}", fallback_val):
                                try:
                                    dt = dateutil_parse(fallback_val)
                                    step_days = 366 if attempts <= 5 else 32
                                    fallback_val = (dt + timedelta(days=step_days)).strftime("%Y-%m-%d")
                                    continue
                                except Exception:
                                    pass
                            fallback_val = next_distinct_value(
                                col_def, fallback_val
                            )

                    v_inj = {(t, canonical_col): fallback_val}
                    datasets.append(Dataset(
                        strategy_name=f"{self.__class__.__name__}_branch_else",
                        data=generate_base_dataset(schema, parsed_query, value_injections=v_inj),
                        tags=["conditional_function_attack"],
                        description="Targets Conditional Function bugs. Dataset sets condition values such that ALL explicitly defined WHEN branches evaluate to FALSE. This strictly forces the execution of the CASE ELSE branch, ensuring that a mutant mutating or removing the ELSE branch will fail."
                    ))

                    if expl_viols:
                        fallback_val_2 = expl_viols[1] if len(expl_viols) > 1 else fallback_val
                    else:
                        fallback_val_2 = next_distinct_value(col_def, fallback_val)
                        attempts_2 = 0
                        while (_matches_branch(fallback_val_2) or fallback_val_2 == fallback_val) and attempts_2 < 50:
                            attempts_2 += 1
                            if (col_def.is_temporal or like_patterns) and isinstance(fallback_val_2, str) and re.match(r"^\d{4}-\d{2}-\d{2}", fallback_val_2):
                                try:
                                    dt = dateutil_parse(fallback_val_2)
                                    step_days = 366 if attempts_2 <= 5 else 32
                                    fallback_val_2 = (dt + timedelta(days=step_days)).strftime("%Y-%m-%d")
                                    continue
                                except Exception:
                                    pass
                            fallback_val_2 = next_distinct_value(
                                col_def, fallback_val_2
                            )

                    # Generate a mixed-branch dataset (rows matching each WHEN branch plus ELSE).
                    # Ensure an asymmetric, non-power-of-two row count (e.g. 1 WHEN + 2 ELSE = 3 rows)
                    # so branch cardinalities are unequal and COUNT/AVG denominators are non-dyadic.
                    primary_branch_val = branch_values[0] if branch_values else first_val
                    mixed_cond_vals = list(branch_values) + [fallback_val] if branch_values else [primary_branch_val, fallback_val]
                    if (len(mixed_cond_vals) & (len(mixed_cond_vals) - 1)) == 0:
                        mixed_cond_vals.append(fallback_val_2)
                    v_inj_mixed: dict[tuple[str, str], Any] = {(t, canonical_col): mixed_cond_vals}
                    nullable_measure_cols = []
                    for c_node in parsed.find_all(exp.Case):
                        for col_node in c_node.find_all(exp.Column):
                            c_res = resolve_col(col_node.name, col_node.table)
                            if c_res:
                                c_table, c_col_name = c_res
                                col_obj = schema.find_column(c_table, c_col_name)
                                if (
                                    col_obj
                                    and (c_table.upper(), col_obj.name.upper()) != (t.upper(), canonical_col.upper())
                                    and (c_table, col_obj.name) not in query_branch_values
                                    and any(t_type in col_obj.data_type.lower() for t_type in ("int", "real", "float", "double", "numeric", "decimal"))
                                ):
                                    if not col_obj.is_primary_key and not col_obj.is_unique:
                                        v_inj_mixed[(c_table, col_obj.name)] = [2 ** idx for idx in range(len(mixed_cond_vals))]
                                if (
                                    col_obj
                                    and (c_table.upper(), col_obj.name.upper()) != (t.upper(), canonical_col.upper())
                                    and col_obj.is_nullable
                                    and not getattr(col_obj, "explicit_not_null", False)
                                    and not col_obj.is_primary_key
                                ):
                                    if (c_table, col_obj) not in nullable_measure_cols:
                                        nullable_measure_cols.append((c_table, col_obj))

                    datasets.append(Dataset(
                        strategy_name=f"{self.__class__.__name__}_mixed_branches",
                        data=generate_base_dataset(schema, parsed_query, value_injections=v_inj_mixed),
                        tags=["conditional_function_attack"],
                        description="Targets Conditional Function bugs with mixed branch execution across rows. Dataset forces some rows to satisfy the WHEN branch condition and other rows to satisfy the ELSE branch condition. This catches non-associativity, percentage/ratio scaling, and partial aggregation non-equivalence."
                    ))

                    for c_table, col_obj in nullable_measure_cols:
                        non_null_seed = 2 if any(t_type in col_obj.data_type.lower() for t_type in ("int", "real", "float", "double", "numeric", "decimal")) else generate_unique_value_for_column(col_obj)
                        v_inj_null = {
                            (t, canonical_col): [primary_branch_val, fallback_val],
                            (c_table, col_obj.name): [None, non_null_seed],
                        }
                        datasets.append(Dataset(
                            strategy_name=f"{self.__class__.__name__}_mixed_branches_null",
                            data=generate_base_dataset(schema, parsed_query, value_injections=v_inj_null),
                            tags=["conditional_function_attack", "null_attack"],
                            description=f"Targets Conditional Function and Conditional Aggregate NULL handling bugs. Dataset pairs a row satisfying the WHEN branch where `{c_table}.{col_obj.name}` is NULL with a row satisfying the ELSE branch where `{c_table}.{col_obj.name}` is non-NULL under the same group."
                        ))

        return datasets

