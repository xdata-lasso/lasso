"""
AggregateMissingDistinctAttackStrategy Module
=============================================

Target semantic bug: Missing or Spurious DISTINCT modifier inside aggregate functions
(e.g. SUM(DISTINCT x) vs SUM(x), COUNT(DISTINCT x) vs COUNT(x), AVG(DISTINCT x) vs AVG(x)).

Algorithm & Dataset Design:
1. Identify all aggregate function applications (SUM, COUNT, AVG) across the query,
   including projections, HAVING clauses, and subqueries.
2. If the aggregate appears in a comparison threshold condition (e.g. `SUM(col) > C`),
   calculate an individual value `v` such that `2 * v > C` but `v <= C` (e.g., `v = 0.6 * C`).
   Injecting 2 duplicate rows with value `v` ensures that the non-DISTINCT aggregate satisfies
   the condition (2 * v > C) while the DISTINCT aggregate fails (v <= C), refuting query equivalence.
3. If the aggregate is in a projection, injecting duplicate rows ensures that `AGG(x) != AGG(DISTINCT x)`.
   For `AVG(x)` vs `AVG(DISTINCT x)`, two identical values `[v1, v1]` have the same average `v1`
   before and after deduplication, so a third row with a distinct value `v2 != v1` is also injected
   into the same group (`[v1, v1, v2]`), guaranteeing `(2 * v1 + v2) / 3 != (v1 + v2) / 2`.
4. Primary key invariants are strictly maintained: any secondary non-grouping PK columns
   (e.g., line item number) are given fresh unique values so that the multi-row dataset is schema-valid.
"""

from typing import Any, Dict, List
import copy

import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import distinct_satisfying_where_value
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    deduplicate_dataset,
    generate_base_dataset,
    get_singleton_having_group_cols,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.value_generator import generate_unique_value_for_column


class AggregateMissingDistinctAttackStrategy(AttackStrategy):
    """
    Targets Missing/Spurious DISTINCT modifier in aggregate functions.
    Injects duplicate values within the same aggregation group so that AGG(col) != AGG(DISTINCT col).
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        ast = parsed_query.get("ast")
        if not ast:
            return False

        for agg in ast.find_all(exp.AggFunc):
            if isinstance(agg, (exp.Sum, exp.Count, exp.Avg)) or isinstance(agg.this, exp.Distinct):
                return True
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        ast = parsed_query.get("ast")
        if not ast:
            return []

        # Find all aggregate targets (prioritizing occurrences that have threshold comparisons)
        targets_dict = {}
        for agg in ast.find_all(exp.AggFunc):
            threshold = None
            parent_op = None
            parent = agg.parent
            if isinstance(agg, (exp.Sum, exp.Avg)) and isinstance(parent, (exp.GT, exp.GTE, exp.LT, exp.LTE)):
                parent_op = type(parent)
                other = parent.right if parent.left == agg else parent.left
                if isinstance(other, exp.Literal) and not other.is_string:
                    try:
                        threshold = float(other.this)
                    except Exception:
                        pass

            col_node = agg.find(exp.Column)
            if col_node:
                col_tbl = col_node.table
                if not col_tbl:
                    enclosing_sel = col_node.find_ancestor(exp.Select)
                    if enclosing_sel:
                        for t_node in enclosing_sel.find_all(exp.Table):
                            if t_node.find_ancestor(exp.Select) is enclosing_sel:
                                st = schema.find_table(t_node.name)
                                if st and schema.find_column(st, col_node.name):
                                    col_tbl = t_node.alias or t_node.name
                                    break
                resolved = resolve_query_column(schema, parsed_query, col_tbl, col_node.name)
                if resolved:
                    is_avg = isinstance(agg, exp.Avg)
                    if resolved not in targets_dict:
                        targets_dict[resolved] = (threshold, parent_op, is_avg)
                    else:
                        prev_th, prev_op, prev_avg = targets_dict[resolved]
                        new_th = threshold if prev_th is None else prev_th
                        new_op = parent_op if prev_th is None else prev_op
                        targets_dict[resolved] = (new_th, new_op, prev_avg or is_avg)

        if not targets_dict:
            return []

        targets = [(res, th, op, is_avg) for res, (th, op, is_avg) in targets_dict.items()]

        # Find GROUP BY columns
        singleton_gb_cols = get_singleton_having_group_cols(ast)
        group_by_targets = []
        for term in parsed_query.get("group_by", []):
            resolved_gb = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if (
                resolved_gb
                and resolved_gb[1].upper() not in singleton_gb_cols
                and resolved_gb not in group_by_targets
            ):
                group_by_targets.append(resolved_gb)

        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        where_lit_cols = set()
        for lit in parsed_query.get("where_literals", []):
            res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res_lit:
                where_lit_cols.add((res_lit[0].upper(), res_lit[1].upper()))

        datasets = []

        for target_index, (target, threshold, parent_op, has_avg) in enumerate(targets):
            t_name, c_name = target
            if t_name not in schema.tables:
                continue

            table_obj = schema.tables[t_name]
            target_col = next((c for c in table_obj.columns if c.name == c_name), None)
            is_int_target = bool(target_col and "int" in (target_col.data_type or "").lower())

            val_inj = None
            target_key = col_key(t_name, c_name)
            if threshold is not None and threshold > 0:
                val_calc = None
                if has_avg:
                    scale = 1.0 if abs(threshold) > 5 else threshold * 0.1
                    val_calc = threshold - 5 * scale
                elif parent_op in (exp.GT, exp.GTE):
                    # 2 * val > threshold, but val <= threshold
                    val_calc = threshold * 0.6
                elif parent_op in (exp.LT, exp.LTE):
                    # val < threshold, but 2 * val >= threshold
                    val_calc = threshold * 0.7
                if val_calc is not None:
                    if is_int_target and not val_calc.is_integer():
                        cand_int = int(round(val_calc))
                        if has_avg or (
                            parent_op in (exp.GT, exp.GTE) and cand_int <= threshold < 2 * cand_int
                        ) or (
                            parent_op in (exp.LT, exp.LTE) and cand_int < threshold <= 2 * cand_int
                        ):
                            val_inj = {target_key: cand_int}
                    else:
                        val_inj = {target_key: int(val_calc) if val_calc.is_integer() else val_calc}

            data = generate_base_dataset(schema, parsed_query, value_injections=val_inj, cache_key_salt=f"amd_{target_index}")

            if not data.get(t_name) or not data[t_name]:
                continue

            # Duplicate the target row to create duplicate values in the same group
            row_dup = copy.deepcopy(data[t_name][0])
            fk_col_names = {fk.column_name.upper() for fk in table_obj.foreign_keys}
            pk_cols = [col for col in table_obj.columns if col.is_primary_key]

            modifiable_pks = [
                col for col in pk_cols
                if col.name != c_name
                and not any(gb_c == col.name for gb_t, gb_c in group_by_targets if gb_t == t_name)
            ]
            modifiable_pks.sort(
                key=lambda col: (
                    (t_name.upper(), col.name.upper()) in where_lit_cols,
                    col.name.upper() in fk_col_names,
                )
            )

            has_fixed_unique = bool(
                (target_col and target_col.is_unique and not target_col.is_primary_key)
                or any(
                    col.is_unique
                    and not col.is_primary_key
                    and any(gb_c == col.name for gb_t, gb_c in group_by_targets if gb_t == t_name)
                    for col in table_obj.columns
                )
            )
            can_dup_base = (not has_fixed_unique) and (not pk_cols or bool(modifiable_pks))

            cols_to_modify = []
            if modifiable_pks:
                cols_to_modify.append(modifiable_pks[0])
            for col in table_obj.columns:
                if col.is_unique and not col.is_primary_key and col.name != c_name:
                    if not any(gb_c == col.name for gb_t, gb_c in group_by_targets if gb_t == t_name):
                        cols_to_modify.append(col)
            for col in table_obj.columns:
                if (
                    col.name.upper() in singleton_gb_cols
                    and col.name != c_name
                    and col not in cols_to_modify
                ):
                    cols_to_modify.append(col)

            has_modified_pk = False
            modified_roots = {}
            if can_dup_base:
                for column in cols_to_modify:
                    orig_col_val = data[t_name][0].get(column.name)
                    cand = distinct_satisfying_where_value(
                        schema,
                        parsed_query,
                        t_name,
                        column,
                        data[t_name][0],
                        row_dup,
                        allow_in_select=True,
                    )
                    if cand is None or cand == orig_col_val:
                        cand = generate_unique_value_for_column(column)
                        cand = solve_check_constraint_value(schema, t_name, column.name, column, cand, row_context=row_dup)
                        if cand == orig_col_val:
                            cand = next_distinct_value(column, cand, schema=schema, table_name=t_name)
                    row_dup[column.name] = cand
                    modified_roots[equiv.find(col_key(t_name, column.name))] = cand
                    if column.is_primary_key:
                        has_modified_pk = True

            duplicated_any = False
            if can_dup_base and (has_modified_pk or not pk_cols):
                data[t_name].append(row_dup)
                duplicated_any = True
                if modified_roots:
                    for other_t, other_tbl_obj in schema.tables.items():
                        if other_t == t_name or not data.get(other_t):
                            continue
                        matching_cols = [
                            c for c in other_tbl_obj.columns
                            if equiv.find(col_key(other_t, c.name)) in modified_roots
                        ]
                        if matching_cols:
                            other_pks = [c for c in other_tbl_obj.columns if c.is_primary_key]
                            other_uniques = [
                                c for c in other_tbl_obj.columns
                                if c.is_unique and not c.is_primary_key and c not in matching_cols
                            ]
                            if any(
                                any(gb_c == uc.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                                or equiv.find(col_key(other_t, uc.name)) == equiv.find(target_key)
                                for uc in other_uniques
                            ):
                                continue
                            other_dup = copy.deepcopy(data[other_t][0])
                            for mc in matching_cols:
                                other_dup[mc.name] = modified_roots[equiv.find(col_key(other_t, mc.name))]
                            if other_pks and not any(pk in matching_cols for pk in other_pks):
                                mod_other_pks = [
                                    pk for pk in other_pks
                                    if equiv.find(col_key(other_t, pk.name)) != equiv.find(target_key)
                                    and not any(gb_c == pk.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                                ]
                                if not mod_other_pks:
                                    continue
                                pk_col = mod_other_pks[0]
                                existing_pk_vals = {r.get(pk_col.name) for r in data[other_t]}
                                new_pk_val = generate_unique_value_for_column(pk_col)
                                new_pk_val = solve_check_constraint_value(
                                    schema, other_t, pk_col.name, pk_col, new_pk_val, row_context=other_dup
                                )
                                while new_pk_val in existing_pk_vals:
                                    new_pk_val = next_distinct_value(pk_col, new_pk_val, schema=schema, table_name=other_t)
                                other_dup[pk_col.name] = new_pk_val
                            for uc in other_uniques:
                                existing_u_vals = {r.get(uc.name) for r in data[other_t]}
                                new_u_val = generate_unique_value_for_column(uc)
                                new_u_val = solve_check_constraint_value(
                                    schema, other_t, uc.name, uc, new_u_val, row_context=other_dup
                                )
                                while new_u_val in existing_u_vals:
                                    new_u_val = next_distinct_value(uc, new_u_val, schema=schema, table_name=other_t)
                                other_dup[uc.name] = new_u_val
                            data[other_t].append(other_dup)
            elif not can_dup_base:
                # Target column is a PRIMARY KEY or UNIQUE column of `t_name`.
                # Keep `t_name` unique and instead duplicate a joined child table row if one exists.
                t_roots = {equiv.find(col_key(t_name, col.name)) for col in table_obj.columns}
                for other_t, other_tbl_obj in schema.tables.items():
                    if other_t == t_name or not data.get(other_t):
                        continue
                    if not any(equiv.find(col_key(other_t, c.name)) in t_roots for c in other_tbl_obj.columns):
                        continue
                    other_pks = [c for c in other_tbl_obj.columns if c.is_primary_key]
                    mod_other_pks = [
                        pk for pk in other_pks
                        if equiv.find(col_key(other_t, pk.name)) not in t_roots
                        and not any(gb_c == pk.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                    ]
                    other_uniques = [c for c in other_tbl_obj.columns if c.is_unique and not c.is_primary_key]
                    if any(
                        equiv.find(col_key(other_t, uc.name)) in t_roots
                        or any(gb_c == uc.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                        for uc in other_uniques
                    ):
                        continue
                    if other_pks and not mod_other_pks:
                        continue
                    other_dup = copy.deepcopy(data[other_t][0])
                    for col in (mod_other_pks[:1] + other_uniques):
                        existing_vals = {r.get(col.name) for r in data[other_t]}
                        cand = distinct_satisfying_where_value(
                            schema,
                            parsed_query,
                            other_t,
                            col,
                            data[other_t][0],
                            other_dup,
                            allow_in_select=True,
                            disallowed_values=existing_vals,
                        )
                        if cand is None or cand in existing_vals:
                            cand = generate_unique_value_for_column(col)
                            cand = solve_check_constraint_value(
                                schema, other_t, col.name, col, cand, row_context=other_dup
                            )
                            while cand in existing_vals:
                                cand = next_distinct_value(col, cand, schema=schema, table_name=other_t)
                        other_dup[col.name] = cand
                    data[other_t].append(other_dup)
                    duplicated_any = True
                    break

            if duplicated_any:
                is_gb_col = any(gb_c == c_name for gb_t, gb_c in group_by_targets if gb_t == t_name)
                if can_dup_base and has_avg and target_col and not target_col.is_unique and not is_gb_col:
                    row_distinct = copy.deepcopy(data[t_name][0])
                    v1 = data[t_name][0].get(c_name)
                    v2 = None

                    if threshold is not None and threshold > 0:
                        scale = 1.0 if abs(threshold) > 5 else threshold * 0.1
                        v2_calc = threshold + 7 * scale
                        v2 = (
                            int(v2_calc)
                            if v2_calc.is_integer() and "int" in (target_col.data_type or "").lower()
                            else v2_calc
                        )
                    else:
                        if (t_name.upper(), c_name.upper()) in where_lit_cols:
                            v2 = distinct_satisfying_where_value(
                                schema,
                                parsed_query,
                                t_name,
                                target_col,
                                data[t_name][0],
                                row_distinct,
                                allow_in_select=True,
                                disallowed_values={v1},
                            )
                        if v2 is None or v2 == v1:
                            if isinstance(v1, (int, float)) and not isinstance(v1, bool):
                                use_negative_offset = False
                                for lit in parsed_query.get("where_literals", []):
                                    res_lit = resolve_query_column(
                                        schema, parsed_query, lit.get("table", ""), lit.get("column", "")
                                    )
                                    if res_lit == (t_name, c_name) and lit.get("operator", "EQ") in (
                                        "LT",
                                        "LTE",
                                        "BetweenUpper",
                                    ):
                                        use_negative_offset = True
                                step = 12.0 if isinstance(v1, float) else 12
                                v2 = (v1 - step) if use_negative_offset else (v1 + step)
                                v2 = solve_check_constraint_value(
                                    schema, t_name, c_name, target_col, v2, row_context=row_distinct
                                )
                                if v2 == v1:
                                    v2 = next_distinct_value(target_col, v1, schema=schema, table_name=t_name)
                            else:
                                v2 = generate_unique_value_for_column(target_col)
                                v2 = solve_check_constraint_value(
                                    schema, t_name, c_name, target_col, v2, row_context=row_distinct
                                )
                                if v2 == v1:
                                    v2 = next_distinct_value(target_col, v1, schema=schema, table_name=t_name)

                    row_distinct[c_name] = v2
                    c_root = equiv.find(col_key(t_name, c_name))
                    for col in table_obj.columns:
                        if col.name != c_name and equiv.find(col_key(t_name, col.name)) == c_root:
                            row_distinct[col.name] = v2

                    modified_roots_distinct = {}
                    if v2 != v1:
                        modified_roots_distinct[c_root] = v2

                    for column in cols_to_modify:
                        existing_vals = {r.get(column.name) for r in data[t_name]}
                        cand3 = distinct_satisfying_where_value(
                            schema,
                            parsed_query,
                            t_name,
                            column,
                            data[t_name][0],
                            row_distinct,
                            allow_in_select=True,
                            disallowed_values=existing_vals,
                        )
                        if cand3 is None or cand3 in existing_vals:
                            cand3 = generate_unique_value_for_column(column)
                            cand3 = solve_check_constraint_value(
                                schema, t_name, column.name, column, cand3, row_context=row_distinct
                            )
                            while cand3 in existing_vals:
                                cand3 = next_distinct_value(column, cand3, schema=schema, table_name=t_name)
                        row_distinct[column.name] = cand3
                        modified_roots_distinct[equiv.find(col_key(t_name, column.name))] = cand3

                    data[t_name].append(row_distinct)
                    if modified_roots_distinct:
                        for other_t, other_tbl_obj in schema.tables.items():
                            if other_t == t_name or not data.get(other_t):
                                continue
                            matching_cols = [
                                c for c in other_tbl_obj.columns
                                if equiv.find(col_key(other_t, c.name)) in modified_roots_distinct
                            ]
                            if matching_cols:
                                other_pks = [c for c in other_tbl_obj.columns if c.is_primary_key]
                                other_uniques = [
                                    c for c in other_tbl_obj.columns
                                    if c.is_unique and not c.is_primary_key and c not in matching_cols
                                ]
                                if any(
                                    any(gb_c == uc.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                                    or equiv.find(col_key(other_t, uc.name)) == equiv.find(target_key)
                                    for uc in other_uniques
                                ):
                                    continue
                                other_dup = copy.deepcopy(data[other_t][0])
                                for mc in matching_cols:
                                    other_dup[mc.name] = modified_roots_distinct[
                                        equiv.find(col_key(other_t, mc.name))
                                    ]
                                if other_pks and not any(pk in matching_cols for pk in other_pks):
                                    mod_other_pks = [
                                        pk for pk in other_pks
                                        if equiv.find(col_key(other_t, pk.name)) != equiv.find(target_key)
                                        and not any(gb_c == pk.name for gb_t, gb_c in group_by_targets if gb_t == other_t)
                                    ]
                                    if not mod_other_pks:
                                        continue
                                    pk_col = mod_other_pks[0]
                                    existing_pk_vals = {r.get(pk_col.name) for r in data[other_t]}
                                    new_pk_val = generate_unique_value_for_column(pk_col)
                                    new_pk_val = solve_check_constraint_value(
                                        schema, other_t, pk_col.name, pk_col, new_pk_val, row_context=other_dup
                                    )
                                    while new_pk_val in existing_pk_vals:
                                        new_pk_val = next_distinct_value(pk_col, new_pk_val, schema=schema, table_name=other_t)
                                    other_dup[pk_col.name] = new_pk_val
                                for uc in other_uniques:
                                    existing_u_vals = {r.get(uc.name) for r in data[other_t]}
                                    new_u_val = generate_unique_value_for_column(uc)
                                    new_u_val = solve_check_constraint_value(
                                        schema, other_t, uc.name, uc, new_u_val, row_context=other_dup
                                    )
                                    while new_u_val in existing_u_vals:
                                        new_u_val = next_distinct_value(uc, new_u_val, schema=schema, table_name=other_t)
                                    other_dup[uc.name] = new_u_val
                                data[other_t].append(other_dup)

                data = deduplicate_dataset(schema, data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_{c_name}_{target_index}",
                        data=data,
                        tags=["aggregate_distinct_attack"],
                        description=(
                            f"Targets Missing/Spurious DISTINCT in aggregate functions. "
                            f"Injects duplicate values for `{t_name}.{c_name}` within the same aggregation group. "
                            f"A query with DISTINCT will deduplicate these rows, while a query without DISTINCT "
                            f"will aggregate both rows."
                        ),
                    )
                )

        return datasets
