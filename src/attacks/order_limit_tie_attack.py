"""
OrderLimitTieAttackStrategy Module

Target semantic bug:
Mutants that replace ORDER BY ... LIMIT with aggregate MAX/MIN filtering (e.g. WHERE col = (SELECT MAX(col)...)),
RANK() without truncation, or mutants that fail to handle duplicate sorting values (ties) in ORDER BY ... LIMIT queries.

Algorithm & Dataset Design:
1. Target: Queries containing ORDER BY and LIMIT clauses.
2. Dataset Generation:
   - Construct two independent valid join row groups (`group_a` and `group_b`).
   - For each ORDER BY column, determine whether ASC or DESC sorting is requested.
   - If the ORDER BY column is a primary key or unique constraint, skip setting tied values (to preserve primary key uniqueness and foreign key integrity).
   - Assign identical top-ranked values (e.g., maximum for DESC, minimum for ASC) to row 0 in both `group_a`
     and `group_b`, while assigning strictly inferior values to all other rows in both groups.
   - Keep non-ORDER BY attributes (and primary keys) distinct between `group_a` and `group_b`, and assign
     inversely ordered values to unconstrained non-key attributes (higher in `group_a`, lower in `group_b`)
     so that primary-key / scan-order tie-breaking and GROUP BY / projection-attribute tie-breaking select
     distinct winning tuples.
   - Merging these two tied groups into a single dataset ensures that ORDER BY ... LIMIT 1 returns
     exactly 1 row (cardinality = 1), whereas aggregate subqueries (WHERE col = MAX(col)) or RANK() return
     all 2 tied rows (cardinality = 2), refuting non-equivalence.
   - Additionally, when the table of an ORDER BY column participates in joins with other tables, constructs
     an unjoined extremum dataset by injecting a row into the ordered table with a strictly more extreme
     sorting value whose join keys are disconnected from the remaining joined tables (cloning parent FK rows
     where needed to preserve referential integrity). A query that joins before ordering and limiting
     excludes the unjoined row and returns the top joined tuple, whereas a mutant that filters via an
     uncorrelated global extremum subquery (e.g. WHERE col = (SELECT MAX(col) FROM T)) selects only the
     unjoined extremum row and fails the join.
"""

import copy
from typing import Any, Dict, List, Set
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    generate_base_dataset,
    merge_datasets,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.resolver import _is_iso_date_str, _step_above, _step_below
from dataset_generator.value_generator import (
    DataFactory,
    generate_unique_string_for_column,
    generate_unique_value_for_column,
)


class OrderLimitTieAttackStrategy(AttackStrategy):
    """
    Targets ORDER BY + LIMIT queries where mutants substitute aggregate MAX/MIN filter subqueries
    or improperly handle duplicate maximum/minimum values (ties).
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        order_bys = parsed_query.get("order_by", [])
        if not order_bys:
            return False
        ast = parsed_query.get("ast")
        has_limit = bool(parsed_query.get("has_limit") or parsed_query.get("limit") or (ast and ast.find(exp.Limit)))
        return has_limit

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        order_bys = parsed_query.get("order_by", [])
        if not order_bys:
            return []

        # Generate two independent base dataset groups
        group_a = generate_base_dataset(schema, parsed_query, cache_key_salt="olt_g1")
        group_b = generate_base_dataset(schema, parsed_query, cache_key_salt="olt_g2")
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        order_cols_by_table: Dict[str, set[str]] = {}
        order_roots = set()
        for order_term in order_bys:
            t_name = order_term.get("table", "")
            c_name = order_term.get("column", "")
            if not c_name:
                continue
            resolved = resolve_query_column(schema, parsed_query, t_name, c_name)
            if resolved:
                order_cols_by_table.setdefault(resolved[0].upper(), set()).add(resolved[1].upper())
                order_roots.add(equiv.find(col_key(resolved[0], resolved[1])))

        where_lit_roots = set()
        for lit in parsed_query.get("where_literals", []):
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                where_lit_roots.add(equiv.find(col_key(res[0], res[1])))

        fk_referenced_cols = {
            (fk.reference_table.upper(), fk.reference_column.upper())
            for t_obj in schema.tables.values()
            for fk in t_obj.foreign_keys
        }

        for term_idx, order_term in enumerate(order_bys):
            t_name = order_term.get("table", "")
            c_name = order_term.get("column", "")
            is_desc = order_term.get("desc", False)
            if not c_name:
                continue

            resolved = resolve_query_column(schema, parsed_query, t_name, c_name)
            if not resolved:
                continue
            target_t, target_c = resolved

            col_def = next((c for c in schema.tables[target_t].columns if c.name.upper() == target_c.upper()), None)
            if col_def and (col_def.is_primary_key or col_def.is_unique):
                continue

            g1a_key = next((k for k in group_a if k.upper() == target_t.upper()), None)
            g1b_key = next((k for k in group_b if k.upper() == target_t.upper()), None)

            if g1a_key and g1b_key and group_a[g1a_key] and group_b[g1b_key]:
                data_type = col_def.data_type.upper() if col_def else ""
                base_type = data_type.split("(")[0].strip()

                if (col_def and col_def.is_numeric) or base_type in (
                    "INT", "INTEGER", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL"
                ):
                    existing_vals = []
                    for r in group_a[g1a_key] + group_b[g1b_key]:
                        v = r.get(target_c)
                        if isinstance(v, (int, float)):
                            existing_vals.append(float(v))
                    base_val = max(existing_vals) if existing_vals else 100.0
                    top_val_a = (base_val + 1000.0) if is_desc else (base_val - 1000.0)
                    top_val_b = top_val_a if term_idx == 0 else (top_val_a + (100.0 if is_desc else -100.0))
                    step = -10.0 if is_desc else 10.0

                    for idx, r in enumerate(group_a[g1a_key]):
                        r[target_c] = top_val_a if idx == 0 else (top_val_a + (idx + 1) * step)
                    for idx, r in enumerate(group_b[g1b_key]):
                        r[target_c] = top_val_b if idx == 0 else (top_val_b + (idx + 10) * step)

                elif (col_def and col_def.is_temporal) or base_type in ("DATE", "DATETIME", "TIMESTAMP"):
                    existing_dates = [r.get(target_c) for r in group_a[g1a_key] + group_b[g1b_key] if r.get(target_c)]
                    base_date = str(existing_dates[0]) if existing_dates else "2020-01-01"
                    top_val_a = base_date
                    top_val_b = base_date if term_idx == 0 else "2021-01-01"
                    low_val = "2000-01-01" if is_desc else "2099-12-31"
                    for idx, r in enumerate(group_a[g1a_key]):
                        r[target_c] = top_val_a if idx == 0 else low_val
                    for idx, r in enumerate(group_b[g1b_key]):
                        r[target_c] = top_val_b if idx == 0 else low_val

                else:
                    if col_def:
                        val1 = generate_unique_string_for_column(col_def)
                        val2 = generate_unique_string_for_column(col_def)
                    else:
                        val1, val2 = "A_ORDER_VAL", "Z_ORDER_VAL"
                    sorted_pair = sorted([str(val1), str(val2)])
                    top_val_a = sorted_pair[1] if is_desc else sorted_pair[0]
                    top_val_b = top_val_a if term_idx == 0 else (sorted_pair[0] if is_desc else sorted_pair[1])
                    low_val = sorted_pair[0] if is_desc else sorted_pair[1]

                    for idx, r in enumerate(group_a[g1a_key]):
                        r[target_c] = top_val_a if idx == 0 else low_val
                    for idx, r in enumerate(group_b[g1b_key]):
                        r[target_c] = top_val_b if idx == 0 else low_val

        # Assign inversely ordered values to non-ORDER BY attributes across group_a and group_b
        # so that primary-key / scan-order tie-breaking (which favors group_a[0]) and
        # GROUP BY / projection-attribute tie-breaking (which favors the smaller attribute value in group_b[0])
        # select distinct winning tuples when the primary ORDER BY key is tied.
        for target_t_up, ord_cols in order_cols_by_table.items():
            t_key = schema.find_table(target_t_up)
            if not t_key:
                continue
            table_obj = schema.tables[t_key]
            g1a_key = next((k for k in group_a if k.upper() == target_t_up), None)
            g1b_key = next((k for k in group_b if k.upper() == target_t_up), None)
            if not g1a_key or not g1b_key or not group_a[g1a_key] or not group_b[g1b_key]:
                continue
            fk_col_names = {fk.column_name.upper() for fk in table_obj.foreign_keys}
            check_col_names = {
                c_node.name.upper()
                for cc in getattr(table_obj, "check_constraints", [])
                if cc.get("expression")
                for c_node in cc["expression"].find_all(exp.Column)
            }
            for other_col in table_obj.columns:
                other_root = equiv.find(col_key(t_key, other_col.name))
                if (
                    other_col.is_primary_key
                    or other_col.is_unique
                    or other_col.name.upper() in ord_cols
                    or other_root in order_roots
                    or other_col.name.upper() in fk_col_names
                    or (t_key.upper(), other_col.name.upper()) in fk_referenced_cols
                    or other_root in where_lit_roots
                    or other_col.name.upper() in check_col_names
                ):
                    continue
                val_a = group_a[g1a_key][0].get(other_col.name)
                val_b = group_b[g1b_key][0].get(other_col.name)
                if val_a is None or val_b is None or val_a == val_b:
                    continue
                try:
                    o_low, o_high = sorted([val_a, val_b])
                except TypeError:
                    o_low, o_high = sorted([val_a, val_b], key=str)
                for r in group_a[g1a_key]:
                    if r.get(other_col.name) == val_a:
                        r[other_col.name] = o_high
                for r in group_b[g1b_key]:
                    if r.get(other_col.name) == val_b:
                        r[other_col.name] = o_low

        merged_data = merge_datasets(schema, group_a, group_b)

        datasets = [
            Dataset(
                strategy_name=f"{self.__class__.__name__}",
                data=merged_data,
                tags=["order_limit_tie"],
                description="Targets ORDER BY + LIMIT queries. Generates two valid join tuples with identical winning values for all ORDER BY columns (a tie). ORDER BY ... LIMIT 1 returns 1 row, whereas aggregate subqueries (WHERE col = MAX(col)) or RANK() without limit return all tied rows."
            )
        ]

        unjoined_ds = self._generate_unjoined_extremum_dataset(schema, parsed_query, order_bys)
        if unjoined_ds is not None:
            datasets.append(unjoined_ds)

        return datasets

    def _collect_query_join_cols(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> Dict[str, Set[str]]:
        join_cols_by_table: Dict[str, Set[str]] = {}
        for join in parsed_query.get("joins", []):
            if join.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                continue
            for pair in join.get("on_pairs", []):
                l_tbl_raw = pair["left"].get("table", "")
                l_col_raw = pair["left"].get("column", "")
                r_tbl_raw = pair["right"].get("table", "")
                r_col_raw = pair["right"].get("column", "")
                l_res = resolve_query_column(schema, parsed_query, l_tbl_raw, l_col_raw)
                r_res = resolve_query_column(schema, parsed_query, r_tbl_raw, r_col_raw)
                if l_res and r_res and (
                    l_res[0].upper() != r_res[0].upper()
                    or l_tbl_raw.upper() != r_tbl_raw.upper()
                ):
                    join_cols_by_table.setdefault(l_res[0].upper(), set()).add(l_res[1].upper())
                    join_cols_by_table.setdefault(r_res[0].upper(), set()).add(r_res[1].upper())

        for pair in parsed_query.get("where_joins", []):
            l_tbl_raw = pair["left"].get("table", "")
            l_col_raw = pair["left"].get("column", "")
            r_tbl_raw = pair["right"].get("table", "")
            r_col_raw = pair["right"].get("column", "")
            l_res = resolve_query_column(schema, parsed_query, l_tbl_raw, l_col_raw)
            r_res = resolve_query_column(schema, parsed_query, r_tbl_raw, r_col_raw)
            if l_res and r_res and (
                l_res[0].upper() != r_res[0].upper()
                or l_tbl_raw.upper() != r_tbl_raw.upper()
            ):
                join_cols_by_table.setdefault(l_res[0].upper(), set()).add(l_res[1].upper())
                join_cols_by_table.setdefault(r_res[0].upper(), set()).add(r_res[1].upper())

        return join_cols_by_table

    def _compute_extreme_order_value(
        self,
        schema: Schema,
        table_name: str,
        col_name: str,
        col_def: Any,
        all_vals: List[Any],
        is_desc: bool,
        row_context: Dict[str, Any],
    ) -> Any:
        disallowed = set(all_vals)
        num_vals = [
            v for v in all_vals if isinstance(v, (int, float)) and not isinstance(v, bool)
        ]
        if num_vals:
            is_int_col = bool(col_def and "int" in (col_def.data_type or "").lower())
            has_float = any(isinstance(v, float) for v in num_vals) and not is_int_col
            if is_desc:
                max_v = max(num_vals)
                cand = (float(max_v) + 100.0) if has_float else (int(round(max_v)) + 100)
            else:
                min_v = min(num_vals)
                if min_v > 1:
                    cand = (float(min_v) / 2.0) if has_float else max(1, int(round(min_v)) // 2)
                else:
                    cand = (float(min_v) - 10.0) if has_float else (int(round(min_v)) - 10)
            if col_def:
                cand = solve_check_constraint_value(
                    schema, table_name, col_name, col_def, cand,
                    disallowed_values=disallowed, row_context=row_context,
                )
            return cand

        str_vals = [str(v) for v in all_vals if v is not None]
        if str_vals:
            ref_val = max(str_vals) if is_desc else min(str_vals)
            is_temp = _is_iso_date_str(ref_val) or bool(col_def and col_def.is_temporal)
            if is_temp:
                dt_str = col_def.data_type if col_def else "DATE"
                cand = (
                    _step_above(ref_val, dt_str, col_def, is_temporal=True)
                    if is_desc
                    else _step_below(ref_val, dt_str, col_def, is_temporal=True)
                )
            elif is_desc:
                cand = ref_val + "_z"
            else:
                if len(ref_val) > 0 and ord(ref_val[0]) > 33:
                    cand = chr(ord(ref_val[0]) - 1) + ref_val[1:]
                else:
                    cand = ""
            if col_def:
                cand = solve_check_constraint_value(
                    schema, table_name, col_name, col_def, cand,
                    disallowed_values=disallowed, row_context=row_context,
                )
            return cand

        if col_def:
            return generate_unique_value_for_column(col_def)
        return None

    def _clone_and_disconnect_parent_fk(
        self,
        schema: Schema,
        fk_obj: Any,
        data_dict: Dict[str, List[Dict[str, Any]]],
        join_cols_by_table: Dict[str, Set[str]],
        visited_tables: Set[str],
    ) -> Any:
        ref_tbl = schema.find_table(fk_obj.reference_table) or fk_obj.reference_table
        if (
            ref_tbl not in schema.tables
            or not data_dict.get(ref_tbl)
            or ref_tbl.upper() in visited_tables
        ):
            return None
        ref_col_obj = schema.find_column(ref_tbl, fk_obj.reference_column)
        actual_ref_col = ref_col_obj.name if ref_col_obj else fk_obj.reference_column
        parent_row = copy.deepcopy(data_dict[ref_tbl][0])
        existing_ref_vals = {r.get(actual_ref_col) for r in data_dict[ref_tbl]}
        new_pk = (
            generate_unique_value_for_column(ref_col_obj)
            if ref_col_obj
            else DataFactory.get_instance().increment_pk()
        )
        if ref_col_obj:
            new_pk = solve_check_constraint_value(
                schema, ref_tbl, actual_ref_col, ref_col_obj, new_pk,
                disallowed_values=existing_ref_vals, row_context=parent_row,
            )
            while new_pk in existing_ref_vals:
                new_pk = next_distinct_value(ref_col_obj, new_pk, schema=schema, table_name=ref_tbl)
        parent_row[actual_ref_col] = new_pk

        self._disconnect_row_joins(
            schema,
            data_dict,
            ref_tbl,
            parent_row,
            join_cols_by_table,
            visited_tables | {ref_tbl.upper()},
            protected_col=actual_ref_col,
        )
        data_dict[ref_tbl].append(parent_row)
        return new_pk

    def _disconnect_row_joins(
        self,
        schema: Schema,
        data_dict: Dict[str, List[Dict[str, Any]]],
        table_name: str,
        row: Dict[str, Any],
        join_cols_by_table: Dict[str, Set[str]],
        visited_tables: Set[str],
        protected_col: str | None = None,
    ) -> None:
        table_obj = schema.tables.get(table_name)
        if not table_obj:
            return
        orig_row = data_dict[table_name][0] if data_dict.get(table_name) else {}
        fk_by_col_upper = {fk.column_name.upper(): fk for fk in table_obj.foreign_keys}
        join_cols_upper = join_cols_by_table.get(table_name.upper(), set())
        prot_upper = (protected_col or "").upper()

        for col in table_obj.columns:
            if col.name.upper() not in join_cols_upper or col.name.upper() == prot_upper:
                continue
            fk_obj = fk_by_col_upper.get(col.name.upper())
            if fk_obj is not None:
                new_fk = self._clone_and_disconnect_parent_fk(
                    schema, fk_obj, data_dict, join_cols_by_table, visited_tables | {table_name.upper()}
                )
                if new_fk is not None:
                    row[col.name] = new_fk
                    continue
            existing_vals = {r.get(col.name) for r in data_dict.get(table_name, [])}
            new_val = generate_unique_value_for_column(col)
            new_val = solve_check_constraint_value(
                schema, table_name, col.name, col, new_val,
                disallowed_values=existing_vals, row_context=row,
            )
            while new_val in existing_vals:
                new_val = next_distinct_value(col, new_val, schema=schema, table_name=table_name)
            row[col.name] = new_val

        pk_cols = [c for c in table_obj.columns if c.is_primary_key]
        pk_updated = any(
            row.get(c.name) != orig_row.get(c.name)
            and (c.name.upper() not in fk_by_col_upper or c.name.upper() in join_cols_upper or c.name.upper() == prot_upper)
            for c in pk_cols
        )
        if not pk_updated and pk_cols:
            modifiable_pks = [c for c in pk_cols if c.name.upper() != prot_upper]
            modifiable_pks.sort(key=lambda c: c.name.upper() in fk_by_col_upper)
            if modifiable_pks:
                chosen_pk = modifiable_pks[0]
                fk_obj = fk_by_col_upper.get(chosen_pk.name.upper())
                if fk_obj is not None:
                    new_pk = self._clone_and_disconnect_parent_fk(
                        schema, fk_obj, data_dict, join_cols_by_table, visited_tables | {table_name.upper()}
                    )
                    if new_pk is not None:
                        row[chosen_pk.name] = new_pk
                        pk_updated = True
                if not pk_updated:
                    existing_pks = {r.get(chosen_pk.name) for r in data_dict.get(table_name, [])}
                    new_pk = generate_unique_value_for_column(chosen_pk)
                    new_pk = solve_check_constraint_value(
                        schema, table_name, chosen_pk.name, chosen_pk, new_pk,
                        disallowed_values=existing_pks, row_context=row,
                    )
                    while new_pk in existing_pks:
                        new_pk = next_distinct_value(chosen_pk, new_pk, schema=schema, table_name=table_name)
                    row[chosen_pk.name] = new_pk

        for col in table_obj.columns:
            if (
                col.is_unique
                and not col.is_primary_key
                and col.name.upper() != prot_upper
                and row.get(col.name) == orig_row.get(col.name)
            ):
                fk_obj = fk_by_col_upper.get(col.name.upper())
                if fk_obj is not None:
                    new_u = self._clone_and_disconnect_parent_fk(
                        schema, fk_obj, data_dict, join_cols_by_table, visited_tables | {table_name.upper()}
                    )
                    if new_u is not None:
                        row[col.name] = new_u
                        continue
                existing_u = {r.get(col.name) for r in data_dict.get(table_name, [])}
                new_u = generate_unique_value_for_column(col)
                new_u = solve_check_constraint_value(
                    schema, table_name, col.name, col, new_u,
                    disallowed_values=existing_u, row_context=row,
                )
                while new_u in existing_u:
                    new_u = next_distinct_value(col, new_u, schema=schema, table_name=table_name)
                row[col.name] = new_u

    def _generate_unjoined_extremum_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        order_bys: List[Dict[str, Any]],
    ) -> Dataset | None:
        join_cols_by_table = self._collect_query_join_cols(schema, parsed_query)
        if not join_cols_by_table:
            return None

        target_t, target_c, is_desc = None, None, False
        for order_term in order_bys:
            t_name = order_term.get("table", "")
            c_name = order_term.get("column", "")
            if not c_name:
                continue
            resolved = resolve_query_column(schema, parsed_query, t_name, c_name)
            if resolved and resolved[0].upper() in join_cols_by_table:
                target_t, target_c = resolved
                is_desc = bool(order_term.get("desc", False))
                break

        if not target_t or not target_c or target_t not in schema.tables:
            return None

        unjoined_data = generate_base_dataset(schema, parsed_query, cache_key_salt="olt_unjoined")
        if not unjoined_data.get(target_t):
            return None

        col_def = schema.find_column(target_t, target_c)
        all_vals = [r.get(target_c) for r in unjoined_data[target_t] if r.get(target_c) is not None]
        if not all_vals:
            return None

        unjoined_row = copy.deepcopy(unjoined_data[target_t][0])
        extreme_val = self._compute_extreme_order_value(
            schema, target_t, target_c, col_def, all_vals, is_desc, unjoined_row
        )
        if extreme_val is None:
            return None

        unjoined_row[target_c] = extreme_val
        self._disconnect_row_joins(
            schema,
            unjoined_data,
            target_t,
            unjoined_row,
            join_cols_by_table,
            {target_t.upper()},
            protected_col=target_c,
        )
        unjoined_data[target_t].append(unjoined_row)

        return Dataset(
            strategy_name=f"{self.__class__.__name__}_unjoined_extremum_{target_c}",
            data=unjoined_data,
            tags=["order_limit_tie", "subquery_attack"],
            description=(
                f"Targets ORDER BY + LIMIT over JOIN vs global extremum subquery bugs. "
                f"Injects an unjoined row into `{target_t}` with a strictly more extreme `{target_c}` value "
                f"(`{extreme_val}`) whose join keys are disconnected from the remaining joined tables. "
                f"A query that orders and limits after joining excludes the unjoined row, whereas a mutant "
                f"that filters by an unfiltered subquery extremum on `{target_t}.{target_c}` matches only "
                f"the unjoined row and fails the join."
            ),
        )
