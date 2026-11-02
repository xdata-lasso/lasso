"""
OrderingAttackStrategy Module

Target semantic bug: Wrong ORDER BY direction or wrong concrete ORDER BY column.
Algorithm & Dataset Design:
Creates ordered datasets where rows have distinct comparable values on the target ORDER BY column.
Enforces that reversing order direction (ASC vs DESC) or replacing order columns flips the expected
tuple output ordering. Also constructs multi-tuple datasets to catch spurious GROUP BY additions.
"""

import importlib
from typing import Any, Dict, List

import sqlglot
import sqlglot.expressions as exp

import dataset_generator.constraints as _dg_constraints
import dataset_generator.pipeline as _dg_pipeline
import dataset_generator.resolver as _dg_resolver
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    generate_base_dataset,
    merge_datasets,
    next_distinct_query_value,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value

importlib.reload(_dg_constraints)
importlib.reload(_dg_resolver)
_dg_pipeline.analyze_constraints_and_cardinality = _dg_constraints.analyze_constraints_and_cardinality
_dg_pipeline.prepare_table_value_lists = _dg_resolver.prepare_table_value_lists


class OrderingAttackStrategy(AttackStrategy):
    """
    Target semantic bug: wrong ORDER BY direction or wrong concrete ORDER BY column.

    Algorithm & Dataset Design:
    The strategy only applies when the correct query has ORDER BY terms that resolve
    to real columns in the query tables. It creates two joined base tuples, then
    forces the ordered columns to have opposite comparable values. The selected
    columns remain distinct because base generation already assigns unique values.
    Therefore ASC vs DESC (or using a different concrete order column) changes the
    observable ordered tuple sequence. It deliberately does not try to catch missing
    or redundant ORDER BY clauses, because unordered SQL result order is not a
    relational property and any kill would depend on engine insertion behavior.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query) or self._agg_order_targets( parsed_query))

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str, bool]]:
        targets = []
        for term in parsed_query.get("order_by", []):
            resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if resolved:
                targets.append((resolved[0], resolved[1], term.get("desc", False)))
        return targets

    def _extract_select_agg_nodes(self, parsed_query: Dict[str, Any]) -> Dict[str, tuple[str, List[exp.AggFunc]]]:
        ast = parsed_query.get("ast")
        if not ast:
            return {}
        select_agg_info: Dict[str, tuple[str, List[exp.AggFunc]]] = {}
        select_nodes = list(ast.find_all(exp.Select))
        if isinstance(ast, exp.Select) and ast not in select_nodes:
            select_nodes.insert(0, ast)

        changed = True
        while changed:
            changed = False
            for sel_node in select_nodes:
                for sel_expr in getattr(sel_node, "expressions", []):
                    if isinstance(sel_expr, exp.Alias) and sel_expr.alias:
                        alias_key = sel_expr.alias.upper()
                        if alias_key in select_agg_info:
                            continue
                        inner = sel_expr.this
                        direct_aggs: List[exp.AggFunc] = []
                        if isinstance(inner, exp.AggFunc):
                            direct_aggs.append(inner)
                        elif hasattr(inner, "find_all") and inner.find(exp.AggFunc) is not None:
                            direct_aggs.extend(list(inner.find_all(exp.AggFunc)))
                        if direct_aggs:
                            select_agg_info[alias_key] = (sel_expr.alias, direct_aggs)
                            changed = True
                            continue
                        if inner is not None:
                            cols = [inner] if isinstance(inner, exp.Column) else list(inner.find_all(exp.Column))
                            inherited_aggs: List[exp.AggFunc] = []
                            for c in cols:
                                if c.name and c.name.upper() in select_agg_info:
                                    inherited_aggs.extend(select_agg_info[c.name.upper()][1])
                            if inherited_aggs:
                                select_agg_info[alias_key] = (sel_expr.alias, inherited_aggs)
                                changed = True
        return select_agg_info

    def _agg_order_target_details(self, parsed_query: Dict[str, Any]) -> list[tuple[str, bool, List[exp.AggFunc]]]:
        if not parsed_query.get("has_group_by") and not parsed_query.get("group_by"):
            return []
        ast = parsed_query.get("ast")
        if not ast:
            return []
        select_agg_info = self._extract_select_agg_nodes(parsed_query)

        agg_targets: list[tuple[str, bool, List[exp.AggFunc]]] = []
        for order_node in ast.find_all(exp.Order):
            for ordered in order_node.expressions:
                expr = ordered.this
                is_desc = bool(ordered.args.get("desc"))
                if isinstance(expr, exp.AggFunc):
                    agg_targets.append((expr.key.upper(), is_desc, [expr]))
                elif hasattr(expr, "find") and expr.find(exp.AggFunc) is not None:
                    first_agg = expr.find(exp.AggFunc)
                    all_aggs = list(expr.find_all(exp.AggFunc)) if hasattr(expr, "find_all") else [first_agg]
                    agg_targets.append((first_agg.key.upper(), is_desc, all_aggs))
                elif isinstance(expr, exp.Column) and expr.name.upper() in select_agg_info:
                    label, nodes = select_agg_info[expr.name.upper()]
                    agg_targets.append((label, is_desc, nodes))
                elif hasattr(expr, "find"):
                    for col in expr.find_all(exp.Column):
                        if col.name and col.name.upper() in select_agg_info:
                            label, nodes = select_agg_info[col.name.upper()]
                            agg_targets.append((label, is_desc, nodes))
                            break
        return agg_targets

    def _agg_order_targets(self, parsed_query: Dict[str, Any]) -> list[tuple[str, bool]]:
        return [(label, is_desc) for label, is_desc, _ in self._agg_order_target_details(parsed_query)]

    def _preceding_agg_order_columns(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        target_table: str,
        target_col: str,
    ) -> list[tuple[str, str]]:
        ast = parsed_query.get("ast")
        if not ast:
            return []
        select_agg_info = self._extract_select_agg_nodes(parsed_query)
        select_expr_info: Dict[str, exp.Expression] = {}
        for sel_node in ast.find_all(exp.Select):
            for sel_expr in getattr(sel_node, "expressions", []):
                if isinstance(sel_expr, exp.Alias) and sel_expr.alias and sel_expr.this is not None:
                    if not isinstance(sel_expr.this, exp.Column):
                        select_expr_info.setdefault(sel_expr.alias.upper(), sel_expr.this)

        preceding_cols: list[tuple[str, str]] = []
        for order_node in ast.find_all(exp.Order):
            for ordered in order_node.expressions:
                expr = ordered.this
                unwrapped = expr
                while isinstance(unwrapped, (exp.Paren, exp.Cast, exp.TryCast)):
                    unwrapped = unwrapped.this
                if isinstance(unwrapped, exp.Column):
                    res = resolve_query_column(schema, parsed_query, unwrapped.table, unwrapped.name)
                    if res and (res[0].upper(), res[1].upper()) == (target_table.upper(), target_col.upper()):
                        break
                agg_nodes: List[exp.AggFunc] = []
                if isinstance(expr, exp.AggFunc):
                    agg_nodes.append(expr)
                elif hasattr(expr, "find_all") and expr.find(exp.AggFunc) is not None:
                    agg_nodes.extend(list(expr.find_all(exp.AggFunc)))
                elif isinstance(expr, exp.Column) and expr.name.upper() in select_agg_info:
                    agg_nodes.extend(select_agg_info[expr.name.upper()][1])
                elif hasattr(expr, "find_all"):
                    for col in expr.find_all(exp.Column):
                        if col.name and col.name.upper() in select_agg_info:
                            agg_nodes.extend(select_agg_info[col.name.upper()][1])
                for agg_node in agg_nodes:
                    for c_node in agg_node.find_all(exp.Column):
                        res_c = resolve_query_column(schema, parsed_query, c_node.table, c_node.name)
                        if res_c and res_c not in preceding_cols:
                            preceding_cols.append(res_c)

                if not agg_nodes:
                    expr_cols: List[exp.Column] = []
                    if not isinstance(unwrapped, exp.Column) and hasattr(expr, "find_all"):
                        expr_cols.extend(list(expr.find_all(exp.Column)))
                    elif isinstance(unwrapped, exp.Column) and not unwrapped.table and unwrapped.name.upper() in select_expr_info:
                        aliased_expr = select_expr_info[unwrapped.name.upper()]
                        expr_cols.extend(list(aliased_expr.find_all(exp.Column)))
                    for c_node in expr_cols:
                        res_c = resolve_query_column(schema, parsed_query, c_node.table, c_node.name)
                        if res_c and res_c not in preceding_cols:
                            preceding_cols.append(res_c)
                        elif not c_node.table and c_node.name and c_node.name.upper() in select_expr_info:
                            for sub_c in select_expr_info[c_node.name.upper()].find_all(exp.Column):
                                res_sub = resolve_query_column(schema, parsed_query, sub_c.table, sub_c.name)
                                if res_sub and res_sub not in preceding_cols:
                                    preceding_cols.append(res_sub)
        return preceding_cols

    def _set_equiv_column_value(
        self,
        schema: Schema,
        equiv: Any,
        group_data: dict[str, list[dict[str, Any]]],
        table_name: str,
        column_name: str,
        new_val: Any,
    ) -> None:
        if not group_data.get(table_name):
            return
        old_val = group_data[table_name][0].get(column_name)
        group_data[table_name][0][column_name] = new_val

        target_root = equiv.find(col_key(table_name, column_name))
        for t_name, rows in group_data.items():
            if not rows or t_name not in schema.tables:
                continue
            t_obj = schema.tables[t_name]
            pk_cols = [c for c in t_obj.columns if c.is_primary_key]
            for col in t_obj.columns:
                if equiv.find(col_key(t_name, col.name)) != target_root:
                    continue
                is_single_unique = (col.is_primary_key and len(pk_cols) == 1) or (
                    col.is_unique and not col.is_primary_key
                )
                if is_single_unique:
                    if rows[0].get(col.name) == old_val or len(rows) == 1:
                        rows[0][col.name] = new_val
                else:
                    matched_any = False
                    for row in rows:
                        if row.get(col.name) == old_val:
                            row[col.name] = new_val
                            matched_any = True
                    if not matched_any:
                        rows[0][col.name] = new_val

    def _query_equated_group_columns(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        gb_cols: list[tuple[str, str]],
    ) -> set[tuple[str, str]]:
        equated = {(t.upper(), c.upper()) for t, c in gb_cols}
        pairs: list[tuple[tuple[str, str], tuple[str, str]]] = []

        for join in parsed_query.get("joins", []):
            for pair in join.get("on_pairs", []):
                l_res = resolve_query_column(schema, parsed_query, pair["left"].get("table", ""), pair["left"].get("column", ""))
                r_res = resolve_query_column(schema, parsed_query, pair["right"].get("table", ""), pair["right"].get("column", ""))
                if l_res and r_res:
                    pairs.append(((l_res[0].upper(), l_res[1].upper()), (r_res[0].upper(), r_res[1].upper())))

        for pair in parsed_query.get("where_joins", []):
            l_res = resolve_query_column(schema, parsed_query, pair["left"].get("table", ""), pair["left"].get("column", ""))
            r_res = resolve_query_column(schema, parsed_query, pair["right"].get("table", ""), pair["right"].get("column", ""))
            if l_res and r_res:
                pairs.append(((l_res[0].upper(), l_res[1].upper()), (r_res[0].upper(), r_res[1].upper())))

        ast = parsed_query.get("ast")
        if ast:
            for eq_node in ast.find_all(exp.EQ):
                if isinstance(eq_node.left, exp.Column) and isinstance(eq_node.right, exp.Column):
                    l_res = resolve_query_column(schema, parsed_query, eq_node.left.table, eq_node.left.name)
                    r_res = resolve_query_column(schema, parsed_query, eq_node.right.table, eq_node.right.name)
                    if l_res and r_res:
                        pairs.append(((l_res[0].upper(), l_res[1].upper()), (r_res[0].upper(), r_res[1].upper())))

        changed = True
        while changed:
            changed = False
            for left_col, right_col in pairs:
                if left_col in equated and right_col not in equated:
                    equated.add(right_col)
                    changed = True
                elif right_col in equated and left_col not in equated:
                    equated.add(left_col)
                    changed = True
        return equated

    def _aggregate_order_by_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        is_desc: bool,
        agg_nodes: List[exp.AggFunc] | None = None,
    ) -> dict[str, list[dict[str, Any]]] | None:
        gb_cols = []
        for term in parsed_query.get("group_by", []):
            res = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if res and res not in gb_cols:
                gb_cols.append(res)
        ast = parsed_query.get("ast")
        if ast:
            for group in ast.find_all(exp.Group):
                curr_anc = group.parent
                in_pred_subq = False
                while curr_anc:
                    if isinstance(curr_anc, exp.Subquery) and not isinstance(curr_anc.parent, (exp.From, exp.Join)):
                        in_pred_subq = True
                        break
                    if isinstance(curr_anc, exp.Exists):
                        in_pred_subq = True
                        break
                    curr_anc = curr_anc.parent
                if in_pred_subq:
                    continue
                for g_expr in group.expressions:
                    for col_node in g_expr.find_all(exp.Column):
                        res = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                        if res and res not in gb_cols:
                            gb_cols.append(res)
        if not gb_cols:
            return None

        where_eq_cols = set()
        for lit in parsed_query.get("where_literals", []):
            if lit.get("substr_start") is not None or lit.get("strftime_format"):
                continue
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                where_eq_cols.add((res[0].upper(), res[1].upper()))

        preceding_order_cols = set()
        if ast:
            for order_node in ast.find_all(exp.Order):
                for ordered in order_node.expressions:
                    expr = ordered.this
                    if isinstance(expr, exp.AggFunc) or (hasattr(expr, "find") and expr.find(exp.AggFunc) is not None):
                        break
                    if isinstance(expr, exp.Column):
                        res = resolve_query_column(schema, parsed_query, expr.table, expr.name)
                        if res:
                            preceding_order_cols.add((res[0].upper(), res[1].upper()))
                        else:
                            break

        target_gb = next(
            (
                gb for gb in gb_cols
                if (gb[0].upper(), gb[1].upper()) not in where_eq_cols
                and (gb[0].upper(), gb[1].upper()) not in preceding_order_cols
            ),
            next(
                (gb for gb in gb_cols if (gb[0].upper(), gb[1].upper()) not in where_eq_cols),
                gb_cols[-1],
            ),
        )
        gb_table, gb_col = target_gb
        gb_col_obj = schema.find_column(gb_table, gb_col)
        if not gb_col_obj:
            return None

        g1_a = generate_base_dataset(schema, parsed_query, cache_key_salt="ord_agg_1a")
        g1_b = generate_base_dataset(schema, parsed_query, cache_key_salt="ord_agg_1b")
        g2 = generate_base_dataset(schema, parsed_query, cache_key_salt="ord_agg_2")
        if not g1_a.get(gb_table) or not g1_b.get(gb_table) or not g2.get(gb_table):
            return None

        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        for other_t, other_c in gb_cols:
            if (other_t, other_c) == (gb_table, gb_col):
                continue
            if g1_a.get(other_t) and g1_b.get(other_t) and g2.get(other_t):
                shared_val = g1_a[other_t][0].get(other_c)
                self._set_equiv_column_value(schema, equiv, g1_b, other_t, other_c, shared_val)
                self._set_equiv_column_value(schema, equiv, g2, other_t, other_c, shared_val)

        v1 = g1_a[gb_table][0].get(gb_col)
        v2 = next_distinct_query_value(schema, parsed_query, gb_table, gb_col_obj, v1)
        try:
            low_val, high_val = sorted([v1, v2])
        except TypeError:
            low_val, high_val = sorted([v1, v2], key=str)

        if is_desc:
            # Natural group order (low_val, high_val) gets counts (1, 2); ORDER BY agg DESC flips to (2, 1)
            self._set_equiv_column_value(schema, equiv, g1_a, gb_table, gb_col, low_val)
            self._set_equiv_column_value(schema, equiv, g1_b, gb_table, gb_col, high_val)
            self._set_equiv_column_value(schema, equiv, g2, gb_table, gb_col, high_val)
        else:
            # Natural group order (low_val, high_val) gets counts (2, 1); ORDER BY agg ASC flips to (1, 2)
            self._set_equiv_column_value(schema, equiv, g1_a, gb_table, gb_col, low_val)
            self._set_equiv_column_value(schema, equiv, g1_b, gb_table, gb_col, low_val)
            self._set_equiv_column_value(schema, equiv, g2, gb_table, gb_col, high_val)

        # Ensure the second row of the 2-tuple group (`g1_b`) does not collapse into the
        # partner row (`g2` if is_desc else `g1_a`) on composite primary/unique keys when
        # multiple columns of the composite key belong to `target_root` (e.g., two FKs referencing
        # the same parent PK). Assign `alt_group_val` (already present in the parent table via the
        # opposite group) to the non-grouping composite key column.
        target_root = equiv.find(col_key(gb_table, gb_col))
        partner_group = g2 if is_desc else g1_a
        alt_group_val = low_val if is_desc else high_val
        query_group_cols = self._query_equated_group_columns(schema, parsed_query, gb_cols)
        for t_name, rows in g1_b.items():
            if not rows or t_name not in schema.tables or not partner_group.get(t_name):
                continue
            t_obj = schema.tables[t_name]
            pk_cols = [c for c in t_obj.columns if c.is_primary_key]
            composite_keys: list[list[Any]] = []
            if len(pk_cols) > 1:
                composite_keys.append(pk_cols)
            for uc in getattr(t_obj, "unique_constraints", []):
                uc_set = {u.upper() for u in uc}
                uc_cols = [c for c in t_obj.columns if c.name.upper() in uc_set]
                if len(uc_cols) > 1:
                    composite_keys.append(uc_cols)

            for key_cols in composite_keys:
                if tuple(rows[0].get(c.name) for c in key_cols) != tuple(
                    partner_group[t_name][0].get(c.name) for c in key_cols
                ):
                    continue
                equiv_vary_col = next(
                    (
                        c for c in key_cols
                        if (t_name.upper(), c.name.upper()) not in query_group_cols
                        and (t_name.upper(), c.name.upper()) not in where_eq_cols
                        and equiv.find(col_key(t_name, c.name)) == target_root
                    ),
                    None,
                )
                if equiv_vary_col is not None:
                    rows[0][equiv_vary_col.name] = alt_group_val
                    continue
                fk_names = {fk.column_name.upper() for fk in t_obj.foreign_keys}
                non_fk_vary_col = next(
                    (
                        c for c in key_cols
                        if (t_name.upper(), c.name.upper()) not in query_group_cols
                        and (t_name.upper(), c.name.upper()) not in where_eq_cols
                        and c.name.upper() not in fk_names
                    ),
                    None,
                )
                if non_fk_vary_col is not None:
                    rows[0][non_fk_vary_col.name] = next_distinct_value(
                        non_fk_vary_col, rows[0].get(non_fk_vary_col.name), schema=schema, table_name=t_name
                    )

        if agg_nodes:
            gb_roots = {equiv.find(col_key(t, c)) for t, c in gb_cols}
            seen_agg_cols = set()
            for agg_node in agg_nodes:
                for col_node in agg_node.find_all(exp.Column):
                    res_col = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                    if not res_col or res_col in seen_agg_cols:
                        continue
                    seen_agg_cols.add(res_col)
                    agg_t, agg_c = res_col
                    if (agg_t.upper(), agg_c.upper()) in where_eq_cols:
                        continue
                    if equiv.find(col_key(agg_t, agg_c)) in gb_roots:
                        continue
                    agg_t_obj = schema.tables.get(agg_t)
                    agg_col_obj = schema.find_column(agg_t, agg_c)
                    if not agg_t_obj or not agg_col_obj:
                        continue
                    if agg_col_obj.is_primary_key or agg_col_obj.is_unique:
                        continue
                    if any(fk.column_name.upper() == agg_c.upper() for fk in agg_t_obj.foreign_keys):
                        continue
                    if not g1_a.get(agg_t) or not g1_b.get(agg_t) or not g2.get(agg_t):
                        continue
                    val_1a = g1_a[agg_t][0].get(agg_c)
                    val_1b = g1_b[agg_t][0].get(agg_c)
                    val_2 = g2[agg_t][0].get(agg_c)
                    if val_1a is None or val_1b is None or val_2 is None:
                        continue
                    if len({val_1a, val_1b, val_2}) < 3:
                        val_1b = next_distinct_value(agg_col_obj, val_1a, schema=schema, table_name=agg_t)
                        val_2 = next_distinct_value(agg_col_obj, val_1b, schema=schema, table_name=agg_t)
                    try:
                        c_low, c_mid, c_high = sorted([val_1a, val_1b, val_2])
                    except TypeError:
                        c_low, c_mid, c_high = sorted([val_1a, val_1b, val_2], key=str)

                    has_sum = any(isinstance(a, exp.Sum) for a in agg_nodes)
                    if (
                        has_sum
                        and isinstance(c_low, (int, float))
                        and not isinstance(c_low, bool)
                        and isinstance(c_mid, (int, float))
                        and isinstance(c_high, (int, float))
                    ):
                        if c_low + c_mid <= c_high:
                            cand_triple = (10.0, 12.0, 15.0) if isinstance(c_low, float) else (10, 12, 15)
                            if all(
                                solve_check_constraint_value(schema, agg_t, agg_c, agg_col_obj, cv) == cv
                                for cv in cand_triple
                            ):
                                c_low, c_mid, c_high = cand_triple

                    if (
                        has_sum
                        and isinstance(c_low, (int, float))
                        and not isinstance(c_low, bool)
                        and isinstance(c_mid, (int, float))
                        and isinstance(c_high, (int, float))
                        and c_low + c_mid > c_high
                    ):
                        if is_desc:
                            # 2-unit group (high_val: g1_b, g2) has sum (c_low + c_mid) > c_high,
                            # while 1-unit group (low_val: g1_a) has max/avg/min c_high > c_mid > c_low.
                            v_g1a, v_g1b, v_g2 = c_high, c_low, c_mid
                        else:
                            # 1-unit group (high_val: g2) has sum c_high < (c_low + c_mid),
                            # while 2-unit group (low_val: g1_a, g1_b) has min/avg/max < c_high.
                            v_g1a, v_g1b, v_g2 = c_low, c_mid, c_high
                    else:
                        if is_desc:
                            v_g1a, v_g1b, v_g2 = c_low, c_mid, c_high
                        else:
                            v_g1a, v_g1b, v_g2 = c_mid, c_high, c_low

                    for grp, assigned_v in ((g1_a, v_g1a), (g1_b, v_g1b), (g2, v_g2)):
                        for r in grp.get(agg_t, [])[1:]:
                            r[agg_c] = assigned_v
                        self._set_equiv_column_value(schema, equiv, grp, agg_t, agg_c, assigned_v)

        m1 = merge_datasets(schema, g1_a, g1_b)
        return merge_datasets(schema, m1, g2)

    def _forces_unique_tie_conflict(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        equiv: Any,
        table_name: str,
        column_name: str,
        target_table_at_idx: str,
    ) -> bool:
        term_root = equiv.find(col_key(table_name, column_name))
        target_t_obj = schema.tables.get(target_table_at_idx)
        target_pk_cols = [c for c in target_t_obj.columns if c.is_primary_key] if target_t_obj else []
        target_unique_cols = [c for c in target_t_obj.columns if c.is_unique and not c.is_primary_key] if target_t_obj else []

        if (len(target_pk_cols) == 1 and equiv.find(col_key(target_table_at_idx, target_pk_cols[0].name)) == term_root) or any(
            equiv.find(col_key(target_table_at_idx, uc.name)) == term_root for uc in target_unique_cols
        ):
            return True

        curr_t_obj = schema.tables.get(table_name)
        if not curr_t_obj:
            return False
        curr_pk_cols = [c for c in curr_t_obj.columns if c.is_primary_key]
        curr_unique_cols = [c for c in curr_t_obj.columns if c.is_unique and not c.is_primary_key]
        is_curr_unique = (len(curr_pk_cols) == 1 and equiv.find(col_key(table_name, curr_pk_cols[0].name)) == term_root) or any(
            equiv.find(col_key(table_name, uc.name)) == term_root for uc in curr_unique_cols
        )
        if not is_curr_unique:
            return False

        target_refs_curr = bool(
            target_t_obj and any(fk.reference_table.upper() == table_name.upper() for fk in target_t_obj.foreign_keys)
        )
        select_tables = set()
        for sel in parsed_query.get("selects", []):
            res_s = resolve_query_column(schema, parsed_query, sel.get("table", ""), sel.get("column", ""))
            if res_s:
                select_tables.add(res_s[0].upper())
        projects_other_table = not select_tables or any(st != table_name.upper() for st in select_tables)
        return not (target_refs_curr and projects_other_table)

    def _assign_distinct_group_order(
        self,
        schema: Schema,
        equiv: Any,
        first_group: dict[str, list[dict[str, Any]]],
        second_group: dict[str, list[dict[str, Any]]],
        table_name: str,
        column_name: str,
        column: Any,
        left_value: Any,
        right_value: Any,
        is_desc: bool,
        prefer_second_group: bool,
        has_intra_group_variation: bool,
    ) -> None:
        winner_group = second_group if prefer_second_group else first_group
        loser_group = first_group if prefer_second_group else second_group

        if (column.is_primary_key or column.is_unique) and (
            len(first_group.get(table_name, [])) > 1 or len(second_group.get(table_name, [])) > 1
        ):
            total_rows = len(first_group.get(table_name, [])) + len(second_group.get(table_name, []))
            distinct_vals = []
            for r in first_group.get(table_name, []) + second_group.get(table_name, []):
                v = r.get(column_name)
                if v is not None and v not in distinct_vals:
                    distinct_vals.append(v)
            if right_value is not None and right_value not in distinct_vals:
                distinct_vals.append(right_value)
            while len(distinct_vals) < total_rows:
                seed_val = distinct_vals[-1] if distinct_vals else left_value
                cand = next_distinct_value(column, seed_val, schema=schema, table_name=table_name)
                if cand is None or cand in distinct_vals:
                    break
                distinct_vals.append(cand)
            try:
                sorted_all = sorted(distinct_vals)
            except TypeError:
                sorted_all = sorted(distinct_vals, key=str)
            if len(sorted_all) >= total_rows and total_rows >= 2:
                sorted_all = sorted_all[:total_rows]
                if is_desc:
                    winner_val = sorted_all[-1]
                    loser_val = sorted_all[-2]
                    inferior_vals = list(reversed(sorted_all[:-2]))
                else:
                    winner_val = sorted_all[0]
                    loser_val = sorted_all[1]
                    inferior_vals = list(sorted_all[2:])
                self._set_equiv_column_value(schema, equiv, loser_group, table_name, column_name, loser_val)
                self._set_equiv_column_value(schema, equiv, winner_group, table_name, column_name, winner_val)
                inf_idx = 0
                for grp in (first_group, second_group):
                    for r in grp.get(table_name, [])[1:]:
                        if inf_idx < len(inferior_vals):
                            r[column_name] = inferior_vals[inf_idx]
                            inf_idx += 1
                return

        try:
            low, high = sorted([left_value, right_value])
        except TypeError:
            low, high = sorted([left_value, right_value], key=str)

        if not column.is_primary_key and not column.is_unique and has_intra_group_variation:
            all_vals = [
                r.get(column_name)
                for r in first_group[table_name] + second_group[table_name]
                if r.get(column_name) is not None
            ]
            if right_value is not None:
                all_vals.append(right_value)
            try:
                sorted_all = sorted(set(all_vals))
            except TypeError:
                sorted_all = sorted(set(all_vals), key=str)
            if len(sorted_all) >= 2:
                if is_desc:
                    low, high = sorted_all[-2], sorted_all[-1]
                    fallback_val = sorted_all[0]
                else:
                    low, high = sorted_all[0], sorted_all[1]
                    fallback_val = sorted_all[-1]
                for grp in (first_group, second_group):
                    for r in grp.get(table_name, [])[1:]:
                        if r.get(column_name) in (low, high):
                            r[column_name] = fallback_val

        self._set_equiv_column_value(schema, equiv, loser_group, table_name, column_name, low if is_desc else high)
        self._set_equiv_column_value(schema, equiv, winner_group, table_name, column_name, high if is_desc else low)

    def _two_tuple_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        targets: list[tuple[str, str, bool]],
        target_index: int,
        use_zero_boundary: bool = False
    ) -> dict[str, list[dict[str, Any]]]:
        first_group = generate_base_dataset(schema, parsed_query, cache_key_salt=f"ord_first_{use_zero_boundary}")
        second_group = generate_base_dataset(schema, parsed_query, cache_key_salt=f"ord_second_{use_zero_boundary}")
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        where_lit_roots = set()
        for lit in parsed_query.get("where_literals", []):
            if lit.get("substr_start") is not None or lit.get("strftime_format"):
                continue
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                where_lit_roots.add(equiv.find(col_key(res[0], res[1])))

        target_table_at_idx, target_col_at_idx, _ = targets[target_index]
        target_t_obj = schema.tables.get(target_table_at_idx)
        target_pk_cols = [c for c in target_t_obj.columns if c.is_primary_key] if target_t_obj else []
        target_unique_cols = [c for c in target_t_obj.columns if c.is_unique and not c.is_primary_key] if target_t_obj else []

        preceding_agg_cols = self._preceding_agg_order_columns(
            schema, parsed_query, target_table_at_idx, target_col_at_idx
        )
        has_gb = bool(parsed_query.get("has_group_by") or parsed_query.get("group_by"))
        for agg_t, agg_c in preceding_agg_cols:
            if (agg_t.upper(), agg_c.upper()) == (target_table_at_idx.upper(), target_col_at_idx.upper()):
                continue
            if not first_group.get(agg_t) or not second_group.get(agg_t):
                continue
            agg_t_obj = schema.tables.get(agg_t)
            agg_col_obj = next((c for c in agg_t_obj.columns if c.name == agg_c), None) if agg_t_obj else None
            agg_pk_cols = [c for c in agg_t_obj.columns if c.is_primary_key] if agg_t_obj else []
            agg_unique_cols = [c for c in agg_t_obj.columns if c.is_unique and not c.is_primary_key] if agg_t_obj else []
            term_root = equiv.find(col_key(agg_t, agg_c))
            forces_unique_row = (
                (len(target_pk_cols) == 1 and equiv.find(col_key(target_table_at_idx, target_pk_cols[0].name)) == term_root)
                or any(equiv.find(col_key(target_table_at_idx, uc.name)) == term_root for uc in target_unique_cols)
                or (len(agg_pk_cols) == 1 and equiv.find(col_key(agg_t, agg_pk_cols[0].name)) == term_root)
                or any(equiv.find(col_key(agg_t, uc.name)) == term_root for uc in agg_unique_cols)
            )
            if not forces_unique_row:
                left_agg_val = first_group[agg_t][0].get(agg_c)
                if not has_gb and agg_col_obj and not agg_col_obj.is_primary_key and not agg_col_obj.is_unique:
                    for grp in (first_group, second_group):
                        for r in grp.get(agg_t, [])[1:]:
                            r[agg_c] = left_agg_val
                self._set_equiv_column_value(schema, equiv, first_group, agg_t, agg_c, left_agg_val)
                self._set_equiv_column_value(schema, equiv, second_group, agg_t, agg_c, left_agg_val)

        earlier_and_target_roots = (
            {equiv.find(col_key(t[0], t[1])) for t in targets[: target_index + 1]}
            | {equiv.find(col_key(agg_t, agg_c)) for agg_t, agg_c in preceding_agg_cols}
            | where_lit_roots
        )

        for index, (table_name, column_name, is_desc) in enumerate(targets):
            table = schema.tables[table_name]
            column = next(c for c in table.columns if c.name == column_name)
            if not first_group.get(table_name) or not second_group.get(table_name):
                continue

            left_value = first_group[table_name][0][column_name]
            second_value = second_group[table_name][0].get(column_name)
            rest_values = {
                r.get(column_name)
                for r in first_group[table_name][1:] + second_group[table_name][1:]
                if r.get(column_name) is not None
            }
            has_intra_group_variation = any(
                r.get(column_name) != left_value for r in first_group[table_name][1:]
            ) or any(
                r.get(column_name) != second_value for r in second_group[table_name][1:]
            )
            cand_right = next_distinct_query_value(
                schema, parsed_query, table_name, column, left_value, disallowed_values={left_value}
            )
            if (
                (column.is_primary_key or column.is_unique or (has_intra_group_variation and cand_right in rest_values))
                and second_value is not None
                and second_value != left_value
                and (not has_intra_group_variation or second_value not in rest_values)
            ):
                right_value = second_value
            else:
                right_value = cand_right

            if index < target_index:
                forces_unique_target_row = self._forces_unique_tie_conflict(
                    schema, parsed_query, equiv, table_name, column_name, target_table_at_idx
                )
                if not forces_unique_target_row:
                    tie_value = left_value
                    if not column.is_primary_key and not column.is_unique and has_intra_group_variation:
                        all_vals = [
                            r.get(column_name)
                            for r in first_group[table_name] + second_group[table_name]
                            if r.get(column_name) is not None
                        ]
                        try:
                            sorted_all = sorted(set(all_vals))
                        except TypeError:
                            sorted_all = sorted(set(all_vals), key=str)
                        if len(sorted_all) > 1:
                            tie_value = sorted_all[-1] if is_desc else sorted_all[0]
                            fallback_val = sorted_all[0] if is_desc else sorted_all[-1]
                            for grp in (first_group, second_group):
                                for r in grp.get(table_name, [])[1:]:
                                    if r.get(column_name) == tie_value:
                                        r[column_name] = fallback_val
                    self._set_equiv_column_value(schema, equiv, first_group, table_name, column_name, tie_value)
                    self._set_equiv_column_value(schema, equiv, second_group, table_name, column_name, tie_value)
                else:
                    self._assign_distinct_group_order(
                        schema, equiv, first_group, second_group,
                        table_name, column_name, column,
                        left_value, right_value, is_desc,
                        prefer_second_group=False,
                        has_intra_group_variation=has_intra_group_variation,
                    )
                continue

            if index > target_index:
                term_root = equiv.find(col_key(table_name, column_name))
                if term_root not in earlier_and_target_roots:
                    self._assign_distinct_group_order(
                        schema, equiv, first_group, second_group,
                        table_name, column_name, column,
                        left_value, right_value, is_desc,
                        prefer_second_group=False,
                        has_intra_group_variation=has_intra_group_variation,
                    )
                continue

            if use_zero_boundary and isinstance(left_value, (int, float)) and not isinstance(left_value, bool):
                low, high = -1, 0
                if not column.is_primary_key and not column.is_unique and has_intra_group_variation:
                    for r in first_group[table_name][1:]:
                        r[column_name] = low if is_desc else high
                    for r in second_group[table_name][1:]:
                        r[column_name] = high if is_desc else low
                self._set_equiv_column_value(schema, equiv, first_group, table_name, column_name, low if is_desc else high)
                self._set_equiv_column_value(schema, equiv, second_group, table_name, column_name, high if is_desc else low)
            else:
                self._assign_distinct_group_order(
                    schema, equiv, first_group, second_group,
                    table_name, column_name, column,
                    left_value, right_value, is_desc,
                    prefer_second_group=True,
                    has_intra_group_variation=has_intra_group_variation,
                )

            # Also assign contrasting (opposite polarity) values for other numeric/comparable
            # non-target columns in the table so that if a mutant orders by a completely different
            # column (not in target ORDER BY), it picks the opposite row, refuting the mutant.
            target_col_names = {t[1] for t in targets if t[0] == table_name} | {
                agg_c for agg_t, agg_c in preceding_agg_cols if agg_t == table_name
            }
            target_roots = {equiv.find(col_key(t[0], t[1])) for t in targets} | {
                equiv.find(col_key(agg_t, agg_c)) for agg_t, agg_c in preceding_agg_cols
            }
            fk_col_names = {fk.column_name.upper() for fk in table.foreign_keys}
            check_col_names = set()
            for cc in getattr(table, "check_constraints", []):
                expr = cc.get("expression")
                if expr:
                    for c_node in expr.find_all(exp.Column):
                        check_col_names.add(c_node.name.upper())
            for other_col in table.columns:
                other_root = equiv.find(col_key(table_name, other_col.name))
                if (
                    other_col.name not in target_col_names
                    and other_root not in target_roots
                    and other_col.name.upper() not in fk_col_names
                    and other_root not in where_lit_roots
                    and other_col.name.upper() not in check_col_names
                ):
                    if (
                        not other_col.is_primary_key
                        and not other_col.is_unique
                        and other_col.data_type.upper() in ("INT", "INTEGER", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL")
                    ):
                        other_left = first_group[table_name][0].get(other_col.name)
                        if isinstance(other_left, (int, float)) and not isinstance(other_left, bool):
                            other_right = next_distinct_value(other_col, other_left, schema=schema, table_name=table_name)
                            try:
                                o_low, o_high = sorted([other_left, other_right])
                            except TypeError:
                                o_low, o_high = sorted([other_left, other_right], key=str)
                            # Opposite assignment to target_column
                            self._set_equiv_column_value(schema, equiv, first_group, table_name, other_col.name, o_high if is_desc else o_low)
                            self._set_equiv_column_value(schema, equiv, second_group, table_name, other_col.name, o_low if is_desc else o_high)
                    else:
                        other_left = first_group[table_name][0].get(other_col.name)
                        other_right = second_group[table_name][0].get(other_col.name)
                        if other_left is not None and other_right == other_left:
                            other_right = next_distinct_query_value(
                                schema,
                                parsed_query,
                                table_name,
                                other_col,
                                other_left,
                                disallowed_values={other_left},
                            )
                        first_rest = {r.get(other_col.name) for r in first_group[table_name][1:]}
                        second_rest = {r.get(other_col.name) for r in second_group[table_name][1:]}
                        if (
                            other_left is not None
                            and other_right is not None
                            and other_left != other_right
                            and other_left not in second_rest
                            and other_right not in first_rest
                        ):
                            try:
                                o_low, o_high = sorted([other_left, other_right])
                            except TypeError:
                                o_low, o_high = sorted([other_left, other_right], key=str)
                            self._set_equiv_column_value(schema, equiv, first_group, table_name, other_col.name, o_high if is_desc else o_low)
                            self._set_equiv_column_value(schema, equiv, second_group, table_name, other_col.name, o_low if is_desc else o_high)

        # Ensure columns filtered or joined by subquery aggregates (MAX, MIN, AVG, etc.)
        # share the same value across groups so both groups survive into the query output to expose ORDER BY bugs.
        ast = parsed_query.get("ast")
        if not ast and parsed_query.get("raw_query"):
            try:
                ast = sqlglot.parse_one(parsed_query.get("raw_query"))
            except Exception:
                ast = None

        if ast:
            subq_agg_cols = set()
            for eq in ast.find_all(exp.EQ):
                l, r = eq.left, eq.right
                subq = r if isinstance(r, (exp.Subquery, exp.Select)) else (l if isinstance(l, (exp.Subquery, exp.Select)) else None)
                other = l if subq is r else r
                if subq and subq.find((exp.Max, exp.Min, exp.Avg, exp.Sum, exp.Count)):
                    for c in other.find_all(exp.Column):
                        subq_agg_cols.add(c.name.lower())

            for join in ast.find_all(exp.Join):
                this = join.this
                if isinstance(this, (exp.Subquery, exp.Select)) and this.find((exp.Max, exp.Min, exp.Avg, exp.Sum, exp.Count)):
                    on_clause = join.args.get("on")
                    if on_clause:
                        for eq in on_clause.find_all(exp.EQ):
                            for c in eq.find_all(exp.Column):
                                subq_agg_cols.add(c.name.lower())

            if subq_agg_cols:
                for t_name, rows in second_group.items():
                    if t_name in first_group and first_group[t_name]:
                        for row_idx, row in enumerate(rows):
                            if row_idx < len(first_group[t_name]):
                                for c_name in row:
                                    if c_name.lower() in subq_agg_cols:
                                        row[c_name] = first_group[t_name][row_idx].get(c_name, row[c_name])

        mock_data = merge_datasets(schema, first_group, second_group)
        return mock_data

    def _spurious_group_by_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        ord_table: str,
        ord_col: str,
        is_desc: bool
    ) -> dict[str, list[dict[str, Any]]]:
        
        # Find a categorical projected column (either bare column or inside a non-aggregate SELECT expression)
        cat_table, cat_col = None, None
        candidate_select_cols: list[tuple[str, str]] = []
        for sel in parsed_query.get("selects", []):
            resolved = resolve_query_column(schema, parsed_query, sel.get("table", ""), sel["column"])
            if resolved and resolved not in candidate_select_cols:
                candidate_select_cols.append(resolved)

        ast = parsed_query.get("ast")
        if not candidate_select_cols and isinstance(ast, exp.Select):
            for sel_expr in ast.expressions or []:
                if list(sel_expr.find_all(exp.AggFunc)):
                    continue
                for col_node in sel_expr.find_all(exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                    if resolved and resolved not in candidate_select_cols:
                        candidate_select_cols.append(resolved)

        for res_t, res_c in candidate_select_cols:
            t_obj = schema.tables.get(res_t)
            if not t_obj:
                continue
            pk_cols = [c for c in t_obj.columns if c.is_primary_key]
            c_obj = next((c for c in t_obj.columns if c.name == res_c), None)
            is_single_pk = bool(c_obj and c_obj.is_primary_key and len(pk_cols) == 1)
            if (
                c_obj
                and not is_single_pk
                and not c_obj.is_unique
                and (res_t, c_obj.name) != (ord_table, ord_col)
            ):
                cat_table, cat_col = res_t, res_c
                break
        
        if not cat_table or not cat_col:
            return None

        cat_col_obj = next(c for c in schema.tables[cat_table].columns if c.name == cat_col)

        b1 = generate_base_dataset(schema, parsed_query, cache_key_salt="sp_gb_1")
        b2 = generate_base_dataset(schema, parsed_query, cache_key_salt="sp_gb_2")
        b3 = generate_base_dataset(schema, parsed_query, cache_key_salt="sp_gb_3")

        if not b1.get(cat_table) or not b2.get(cat_table) or not b3.get(cat_table):
            return None

        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        val1 = b1[cat_table][0][cat_col]
        val2 = next_distinct_query_value(schema, parsed_query, cat_table, cat_col_obj, val1)

        self._set_equiv_column_value(schema, equiv, b1, cat_table, cat_col, val1)
        self._set_equiv_column_value(schema, equiv, b2, cat_table, cat_col, val1)
        self._set_equiv_column_value(schema, equiv, b3, cat_table, cat_col, val2)

        if b1.get(ord_table) and b2.get(ord_table) and b3.get(ord_table):
            ord_col_obj = next((c for c in schema.tables[ord_table].columns if c.name == ord_col), None)
            if ord_col_obj and ord_col_obj.data_type.upper() in ("INT", "INTEGER", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL"):
                ord_root = equiv.find(col_key(ord_table, ord_col))

                def _satisfies_equiv_checks(val: Any) -> bool:
                    if solve_check_constraint_value(schema, ord_table, ord_col, ord_col_obj, val) != val:
                        return False
                    for t_name, t_obj in schema.tables.items():
                        for c_obj in t_obj.columns:
                            if equiv.find(col_key(t_name, c_obj.name)) == ord_root:
                                if solve_check_constraint_value(schema, t_name, c_obj.name, c_obj, val) != val:
                                    return False
                    return True

                has_where_lit = any(
                    (resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", "")) or ("", ""))
                    == (ord_table, ord_col)
                    for lit in parsed_query.get("where_literals", [])
                )
                can_neg = _satisfies_equiv_checks(-50) and not has_where_lit
                can_zero = _satisfies_equiv_checks(0)
                if can_zero:
                    high_val = 100 if is_desc else 0
                    low_val = (-50 if can_neg else 0) if is_desc else (150 if can_neg else 100)
                    mid_val = 80 if is_desc else 20
                else:
                    min_valid = solve_check_constraint_value(schema, ord_table, ord_col, ord_col_obj, 10)
                    base_low = min_valid if isinstance(min_valid, (int, float)) and min_valid > 0 else 10
                    c_low = base_low
                    c_mid = base_low + (70 if is_desc else 10)
                    c_high = base_low + 90
                    high_val = c_high if is_desc else c_low
                    low_val = c_low if is_desc else c_high
                    mid_val = c_mid
            else:
                o1 = b1[ord_table][0].get(ord_col)
                o2 = (
                    next_distinct_query_value(schema, parsed_query, ord_table, ord_col_obj, o1)
                    if ord_col_obj
                    else b2[ord_table][0].get(ord_col)
                )
                o3 = (
                    next_distinct_query_value(
                        schema, parsed_query, ord_table, ord_col_obj, o2, disallowed_values={o1, o2}
                    )
                    if ord_col_obj
                    else b3[ord_table][0].get(ord_col)
                )
                try:
                    c_low, c_mid, c_high = sorted([o1, o2, o3])
                except TypeError:
                    c_low, c_mid, c_high = sorted([o1, o2, o3], key=str)
                high_val = c_high if is_desc else c_low
                low_val = c_low if is_desc else c_high
                mid_val = c_mid
            if ord_col_obj and not ord_col_obj.is_primary_key and not ord_col_obj.is_unique:
                for grp, assigned_ord in ((b1, high_val), (b2, low_val), (b3, mid_val)):
                    for r in grp.get(ord_table, [])[1:]:
                        r[ord_col] = assigned_ord
            self._set_equiv_column_value(schema, equiv, b1, ord_table, ord_col, high_val)
            self._set_equiv_column_value(schema, equiv, b2, ord_table, ord_col, low_val)
            self._set_equiv_column_value(schema, equiv, b3, ord_table, ord_col, mid_val)

        m1 = merge_datasets(schema, b1, b2)
        return merge_datasets(schema, m1, b3)

    def _target_nulls_first(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[bool]:
        res = []
        for term in parsed_query.get("order_by", []):
            resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if resolved:
                is_desc = bool(term.get("desc", False))
                nf = term.get("nulls_first")
                res.append((not is_desc) if nf is None else bool(nf))
        return res

    def _can_null_order_column(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        table = schema.tables.get(table_name)
        if not table:
            return False
        col_obj = next((c for c in table.columns if c.name == column_name), None)
        if not col_obj or not col_obj.is_nullable or col_obj.is_primary_key:
            return False

        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                    return False

        for cc in getattr(table, "check_constraints", []):
            expr = cc.get("expression")
            if expr and any(c.name.upper() == column_name.upper() for c in expr.find_all(exp.Column)):
                return False

        for lit in parsed_query.get("where_literals", []):
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
                return False
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
            for pair in j.get("on_pairs", []):
                for side in ("left", "right"):
                    info = pair.get(side, {})
                    res = resolve_query_column(schema, parsed_query, info.get("table", ""), info.get("column", ""))
                    if res and (res[0].upper(), res[1].upper()) == (table_name.upper(), column_name.upper()):
                        return False

        ast = parsed_query.get("ast")
        if ast:
            for clause in ast.find_all((exp.Where, exp.Having, exp.Join, exp.AggFunc)):
                if isinstance(clause, exp.Join):
                    on_expr = clause.args.get("on")
                    if on_expr and any((c.name or "").upper() == column_name.upper() for c in on_expr.find_all(exp.Column)):
                        return False
                    using_expr = clause.args.get("using")
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
                else:
                    if any((c.name or "").upper() == column_name.upper() for c in clause.find_all(exp.Column)):
                        return False

        return True

    def _null_order_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        targets: list[tuple[str, str, bool]],
        target_index: int,
        nulls_first: bool,
    ) -> dict[str, list[dict[str, Any]]] | None:
        table_name, column_name, _ = targets[target_index]
        if not self._can_null_order_column(schema, parsed_query, table_name, column_name):
            return None

        first_group = generate_base_dataset(schema, parsed_query, cache_key_salt=f"ord_null_1_{target_index}")
        second_group = generate_base_dataset(schema, parsed_query, cache_key_salt=f"ord_null_2_{target_index}")
        if not first_group.get(table_name) or not second_group.get(table_name):
            return None

        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        target_t_obj = schema.tables.get(table_name)
        target_pk_cols = [c for c in target_t_obj.columns if c.is_primary_key] if target_t_obj else []
        target_unique_cols = [c for c in target_t_obj.columns if c.is_unique and not c.is_primary_key] if target_t_obj else []

        preceding_agg_cols = self._preceding_agg_order_columns(
            schema, parsed_query, table_name, column_name
        )
        for agg_t, agg_c in preceding_agg_cols:
            if (agg_t.upper(), agg_c.upper()) == (table_name.upper(), column_name.upper()):
                continue
            if not first_group.get(agg_t) or not second_group.get(agg_t):
                continue
            agg_t_obj = schema.tables.get(agg_t)
            agg_pk_cols = [c for c in agg_t_obj.columns if c.is_primary_key] if agg_t_obj else []
            agg_unique_cols = [c for c in agg_t_obj.columns if c.is_unique and not c.is_primary_key] if agg_t_obj else []
            term_root = equiv.find(col_key(agg_t, agg_c))
            forces_unique_row = (
                (len(target_pk_cols) == 1 and equiv.find(col_key(table_name, target_pk_cols[0].name)) == term_root)
                or any(equiv.find(col_key(table_name, uc.name)) == term_root for uc in target_unique_cols)
                or (len(agg_pk_cols) == 1 and equiv.find(col_key(agg_t, agg_pk_cols[0].name)) == term_root)
                or any(equiv.find(col_key(agg_t, uc.name)) == term_root for uc in agg_unique_cols)
            )
            if not forces_unique_row:
                left_agg_val = first_group[agg_t][0].get(agg_c)
                self._set_equiv_column_value(schema, equiv, second_group, agg_t, agg_c, left_agg_val)

        for index, (t_name, c_name, _) in enumerate(targets):
            if index >= target_index:
                break
            if not first_group.get(t_name) or not second_group.get(t_name):
                continue
            left_value = first_group[t_name][0].get(c_name)
            term_root = equiv.find(col_key(t_name, c_name))
            forces_unique_target_row = (
                (len(target_pk_cols) == 1 and equiv.find(col_key(table_name, target_pk_cols[0].name)) == term_root)
                or any(equiv.find(col_key(table_name, uc.name)) == term_root for uc in target_unique_cols)
            )
            if not forces_unique_target_row:
                self._set_equiv_column_value(schema, equiv, second_group, t_name, c_name, left_value)

        target_null_group = second_group if nulls_first else first_group
        old_null_col_val = target_null_group[table_name][0].get(column_name)
        for row in target_null_group[table_name]:
            if row.get(column_name) == old_null_col_val:
                row[column_name] = None

        return merge_datasets(schema, first_group, second_group)

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        targets = self._targets(schema, parsed_query)
        nulls_first_list = self._target_nulls_first(schema, parsed_query)
        agg_target_details = self._agg_order_target_details(parsed_query)
        if not targets and not agg_target_details:
            return []

        datasets = []
        for agg_label, is_desc, agg_nodes in agg_target_details:
            agg_data = self._aggregate_order_by_dataset(schema, parsed_query, is_desc, agg_nodes=agg_nodes)
            if agg_data:
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_agg_order_{agg_label}",
                        data=agg_data,
                        tags=["ordering_attack", "aggregate_order"],
                        description=(
                            f"Targets ORDER BY Aggregate Alias bugs on `{agg_label}`. Generates two groups with "
                            f"unequal row multiplicities (2 vs 1) ordered opposite to the natural grouping key order."
                        ),
                    )
                )

        for index, (table_name, column_name, is_desc) in enumerate(targets):
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{column_name}_{index}",
                    data=self._two_tuple_dataset(schema, parsed_query, targets, index),
                    tags=["ordering_attack"],
                    description=f"Targets Ordering bugs. Dataset deliberately ties the values of the first {index} ORDER BY terms, and assigns different values for the sorting term {index + 1} (`{column_name}`). This explicitly tests multi-level sorting, ensuring a mutant that skips or alters the {index + 1}th order term will return results in the wrong order."
                )
            )

            nulls_first = nulls_first_list[index] if index < len(nulls_first_list) else (not is_desc)
            null_ord_data = self._null_order_dataset(schema, parsed_query, targets, index, nulls_first)
            if null_ord_data:
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_nulls_{column_name}_{index}",
                        data=null_ord_data,
                        tags=["ordering_attack", "null_attack"],
                        description=(
                            f"Targets NULLS FIRST / NULLS LAST ordering bugs on `{column_name}`. "
                            f"Assigns NULL to one tuple/group and a non-NULL value to the other while tying preceding ORDER BY terms."
                        ),
                    )
                )

            # If column is numeric and schema CHECK constraints permit -1 and 0, add zero boundary dataset to catch spurious positive-only filters (e.g. col > 0)
            table = schema.tables.get(table_name)
            if table:
                col_obj = next((c for c in table.columns if c.name == column_name), None)
                if (
                    col_obj
                    and col_obj.data_type.upper() in ("INT", "INTEGER", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL")
                    and solve_check_constraint_value(schema, table_name, column_name, col_obj, -1) == -1
                    and solve_check_constraint_value(schema, table_name, column_name, col_obj, 0) == 0
                ):
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_zero_boundary_{column_name}_{index}",
                            data=self._two_tuple_dataset(schema, parsed_query, targets, index, use_zero_boundary=True),
                            tags=["ordering_attack", "boundary_attack"],
                            description=f"Targets Spurious Filter / Non-positive ORDER BY bugs. Dataset assigns non-positive values (0 and -1) to sorting term `{column_name}` to verify correct ordering without filtering out zero/negative values."
                        )
                    )

            # If correct query does NOT have GROUP BY, add spurious GROUP BY attack dataset
            if not parsed_query.get("has_group_by") and not parsed_query.get("group_by"):
                sp_data = self._spurious_group_by_dataset(schema, parsed_query, table_name, column_name, is_desc)
                if sp_data:
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_spurious_group_by_{column_name}_{index}",
                            data=sp_data,
                            tags=["ordering_attack", "group_by_attack"],
                            description="Targets Spurious GROUP BY bugs in ORDER BY queries. Dataset creates a group with mixed order values (max=1000, min=0, avg=500) and a second group with medium order value (800). A correct non-grouped query selects max (1000), while a mutant that erroneously adds GROUP BY with AVG selects the second group."
                        )
                    )

        return datasets


