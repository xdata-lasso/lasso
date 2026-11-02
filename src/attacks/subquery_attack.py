"""
SubqueryAttackStrategy Module

Target semantic bug: Incorrect IN / Subquery correlation semantics.
Algorithm & Dataset Design:
Creates datasets to test IN subqueries by breaking correlation to verify outer rejection, and by duplicating
inner matching rows to detect duplicate row inflation caused by erroneous JOIN transformations.
"""

from typing import Any, Dict, List
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import (
    distinct_satisfying_disjunctive_row_overrides,
    distinct_satisfying_where_value,
)
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    differentiate_conditional_aggregates_across_groups,
    generate_base_dataset,
    merge_datasets,
    resolve_query_column,
)
from dataset_generator.resolver import _is_iso_date_str, _step_above, _step_below
from dataset_generator.value_generator import DataFactory, generate_unique_id_for_column, generate_unique_string_for_column, generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.utils import next_distinct_value

class SubqueryAttackStrategy(AttackStrategy):
    """
    Target semantic bug: incorrect IN/EQ/Aggregate subquery semantics.

    Algorithm & Dataset Design:
    The strategy creates subquery-specific datasets from the query:
    1. Breaks subquery correlation so a row admitted by a missing/corrupted
       subquery can be rejected by the correct query.
    2. Duplicates the inner-side matching row to detect duplicate row inflation
       caused by erroneous JOIN transformations.
    3. Tests scalar extremum subqueries (MIN/MAX) by injecting a non-extremum candidate row.
    4. Violates subquery filter conditions (both standalone and accompanied by base satisfying
       rows with high/low aggregate outliers) to catch mutants that drop or add subquery filters
       in IN/EXISTS and scalar aggregate subqueries.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        has_subq_join = any(j.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY") for j in parsed_query.get("joins", []))
        has_subq_literal = any(lit.get("is_subquery") for lit in parsed_query.get("where_literals", []))
        ast = parsed_query.get("ast")
        has_agg_subq = bool(
            ast
            and parsed_query.get("where_literals")
            and any(sq.find(exp.AggFunc) is not None for sq in ast.find_all(exp.Subquery))
        )
        return has_subq_join or has_subq_literal or has_agg_subq

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        
        # We will intentionally remove the IN_SUBQUERY pseudo-joins and generate a base dataset.
        # Without these joins, the generated primary/foreign keys will be globally unique 
        # and thus WILL NOT MATCH the subquery results.
        broken_query = copy.deepcopy(parsed_query)
        
        broken_query["joins"] = [j for j in broken_query["joins"] if j.get("type") != "IN_SUBQUERY"]
        
        mock_data = generate_base_dataset(schema, broken_query)
        
        datasets.append(
            Dataset(
                strategy_name=self.__class__.__name__,
                data=mock_data,
                tags=["subquery_attack"],
                description="Targets Broken Subquery Correlation bugs. Dataset specifically modifies outer and inner correlation keys to intentionally break or manipulate subquery linkage. A correct query with proper correlation will filter rows as expected, while a mutant with missing or mismatched subquery correlations will erroneously match unrelated rows."
            )
        )

        matching_query = copy.deepcopy(parsed_query)
        for literal in matching_query.get("where_literals", []):
            value = literal["value"]
            operator = literal.get("operator", "EQ")
            is_numeric = isinstance(value, (int, float)) or (
                isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit()
            )
            if not is_numeric:
                continue
            number = float(value)
            if number.is_integer():
                number = int(number)
            if operator == "GT":
                literal["value"] = number + 1
            elif operator == "LT":
                literal["value"] = number - 1

        # Extract all equality literals from the query to ensure we hit CASE WHEN branches
        value_injections = {}
        raw_query = parsed_query.get("raw_query", "")
        if raw_query:
            try:
                parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
                
                for eq_node in parsed.find_all(exp.EQ):
                    l, r = eq_node.left, eq_node.right
                    if isinstance(l, exp.Column) and isinstance(r, exp.Literal):
                        resolved = resolve_query_column(schema, parsed_query, l.table, l.name)
                        if resolved:
                            t, _ = resolved
                            val = r.name
                            if not r.is_string:
                                val = float(val) if '.' in val else int(val)
                            value_injections[(t, l.name)] = val
            except Exception:
                pass

        # Generate first outer row with injections to likely satisfy SELECT expressions
        data1 = generate_base_dataset(schema, matching_query, value_injections=value_injections, cache_key_salt="subq_data1")
        # Generate second outer row without injections (random unique values) to ensure mixed evaluations
        data2 = generate_base_dataset(schema, matching_query, cache_key_salt="subq_data2")
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        differentiate_conditional_aggregates_across_groups(
            schema, parsed_query, equiv, set(), data1, data2
        )

        duplicate_data = merge_datasets(schema, data1, data2)

        for join in parsed_query.get("joins", []):
            if join.get("type") != "IN_SUBQUERY":
                continue
            on_pairs = join.get("on_pairs", [])
            if not on_pairs:
                continue

            inner_table = on_pairs[0]["right"]["table"]
            inner_join_cols = {pair["right"]["column"] for pair in on_pairs}
            if inner_table not in schema.tables or not data1.get(inner_table):
                continue
            # We duplicate the inner row from data1
            orig_inner_row = data1[inner_table][0]
            duplicate_row = copy.deepcopy(orig_inner_row)
            changed_primary_key = False
            inner_join_cols_upper = {jc.upper() for jc in inner_join_cols}
            disj_overrides = distinct_satisfying_disjunctive_row_overrides(
                schema, parsed_query, inner_table, orig_inner_row, inner_join_cols_upper
            )
            if disj_overrides:
                duplicate_row.update(disj_overrides)
                changed_primary_key = True
            else:
                for column in schema.tables[inner_table].columns:
                    if (column.is_primary_key or column.is_unique) and column.name.upper() not in inner_join_cols_upper:
                        alt_pk_val = distinct_satisfying_where_value(
                            schema,
                            parsed_query,
                            inner_table,
                            column,
                            orig_inner_row,
                            duplicate_row,
                            allow_in_select=True,
                        )
                        if alt_pk_val is not None and alt_pk_val != orig_inner_row.get(column.name):
                            duplicate_row[column.name] = alt_pk_val
                        else:
                            duplicate_row[column.name] = generate_unique_value_for_column(column)
                        changed_primary_key = True
            if changed_primary_key or not any(c.is_primary_key for c in schema.tables[inner_table].columns):
                duplicate_data[inner_table].append(duplicate_row)


        datasets.append(
            Dataset(
                strategy_name=f"{self.__class__.__name__}_duplicate_inner",
                data=duplicate_data,
                tags=["subquery_attack"],
                description="Targets IN vs JOIN equivalence bugs. Dataset purposefully injects duplicate matching rows into the inner subquery table. This leverages the semantic difference where an `INNER JOIN` will incorrectly multiply the outer rows, but the correct `IN` subquery will preserve the original count, thereby catching mutants that incorrectly convert `IN` to `JOIN` without deduplication."
            )
        )

        # Generate datasets targeting specific literals present in subqueries (e.g. IN / NOT IN literal sets)
        for join in parsed_query.get("joins", []):
            if join.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                continue
            for pair in join.get("on_pairs", []):
                inner_table = pair["right"]["table"]
                inner_column = pair["right"]["column"]

                resolved_inner = resolve_query_column(schema, parsed_query, inner_table, inner_column)
                if resolved_inner:
                    inner_table = resolved_inner[0]
                    inner_column = resolved_inner[1]

                if inner_table not in schema.tables or not data1.get(inner_table):
                    continue

                join_key_val = data1[inner_table][0].get(inner_column)

                for lit in parsed_query.get("where_literals", []):
                    lit_col = lit.get("column", "")
                    lit_tbl = lit.get("table", "")
                    resolved_lit = resolve_query_column(schema, parsed_query, lit_tbl, lit_col)
                    if not resolved_lit:
                        continue
                    t_name, c_name = resolved_lit
                    if t_name == inner_table and c_name != inner_column:
                        val = lit.get("value")
                        if val is None:
                            continue
                        if isinstance(val, str) and val.lstrip("-").replace(".", "", 1).isdigit():
                            num = float(val)
                            val = int(num) if num.is_integer() else num

                        lit_data = copy.deepcopy(data1)
                        new_row = copy.deepcopy(data1[inner_table][0])
                        new_row[inner_column] = join_key_val
                        new_row[c_name] = val

                        for column in schema.tables[inner_table].columns:
                            if (column.is_primary_key or column.is_unique) and column.name != inner_column and column.name != c_name:
                                if "char" in (column.data_type or "").lower() or "text" in (column.data_type or "").lower():
                                    new_row[column.name] = generate_unique_string_for_column(column)
                                else:
                                    new_row[column.name] = generate_unique_id_for_column(column)

                        lit_data[inner_table].append(new_row)

                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_literal_{c_name}_{val}",
                                data=lit_data,
                                tags=["subquery_attack"],
                                description=f"Targets subquery literal filtering bugs (e.g., extra or missing literals in subquery IN/NOT IN clauses). Injects a correlated inner row with `{c_name} = '{val}'` to test whether subquery exclusion/inclusion semantics match the target query."
                            )
                        )

        # Target subquery filter conditions (e.g. HAVING SUM(x) > C or WHERE x > C inside subquery).
        # By generating a dataset where the inner condition is violated, the subquery rejects the row.
        # A correct query with the subquery filter will exclude the outer row, while a mutant missing
        # the subquery filter will erroneously include it.
        seen_violations = set()
        for lit in parsed_query.get("where_literals", []):
            if not lit.get("is_subquery"):
                continue
            lit_col = lit.get("column", "")
            lit_tbl = lit.get("table", "")
            resolved_lit = resolve_query_column(schema, parsed_query, lit_tbl, lit_col)
            if not resolved_lit:
                continue
            t_name, c_name = resolved_lit
            op = lit.get("operator", "EQ").upper()
            val = lit.get("value")
            if val is None:
                continue

            violated_val = None
            try:
                num = float(val)
                if op in ("GT", "GTE"):
                    violated_val = max(1, int(num * 0.5)) if num > 1 else num - 1
                elif op in ("LT", "LTE"):
                    violated_val = int(num * 2) if num > 0 else num + 10
                elif op == "EQ":
                    violated_val = num + 1
            except (ValueError, TypeError):
                col_obj = schema.find_column(t_name, c_name)
                if col_obj:
                    violated_val = next_distinct_value(col_obj, val, schema=schema, table_name=t_name)

            if violated_val is not None and (t_name, c_name, violated_val) not in seen_violations:
                seen_violations.add((t_name, c_name, violated_val))
                try:
                    viol_data = generate_base_dataset(
                        schema, parsed_query,
                        value_injections={(t_name, c_name): violated_val},
                        cache_key_salt=f"subq_viol_{t_name}_{c_name}_{violated_val}"
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_violation_{c_name}",
                            data=viol_data,
                            tags=["subquery_attack"],
                            description=(
                                f"Targets Subquery Filter Dropping bugs. Dataset violates subquery filter "
                                f"`{t_name}.{c_name} {op} {val}` with `{violated_val}` so that the subquery rejects the row. "
                                f"A correct query containing the subquery will filter out the outer row, while a mutant "
                                f"missing the subquery will erroneously return it."
                            )
                        )
                    )
                except Exception:
                    pass

        # Target scalar subqueries (col = (SELECT MIN/MAX(col) FROM ...)).
        # Injects a second candidate row for the subquery table with a non-matching extremum value
        # while preserving outer correlation keys. A mutant missing the scalar subquery will erroneously
        # return both candidate rows, while the correct query will return only the extremum row.
        ast = parsed_query.get("ast")
        for join in parsed_query.get("joins", []):
            if join.get("type") not in ("EQ_SUBQUERY", "IN_SUBQUERY"):
                continue
            if join.get("type") == "IN_SUBQUERY" and not join.get("agg_func"):
                continue
            on_pairs = join.get("on_pairs", [])
            if not on_pairs:
                continue
            pair = on_pairs[0]
            r_table_raw = pair["right"]["table"]
            r_col_raw = pair["right"]["column"]
            resolved_r = resolve_query_column(schema, parsed_query, r_table_raw, r_col_raw)
            if not resolved_r or resolved_r[0] not in schema.tables:
                continue
            t_name, c_name = resolved_r
            agg_func = join.get("agg_func")

            base_for_eq = data1 if data1.get(t_name) else generate_base_dataset(schema, parsed_query)
            if not base_for_eq.get(t_name):
                continue

            eq_data = copy.deepcopy(base_for_eq)
            target_table = schema.tables[t_name]
            col_obj = schema.find_column(t_name, c_name)
            orig_row = eq_data[t_name][0]
            new_row = copy.deepcopy(orig_row)

            curr_val = new_row.get(c_name)
            if isinstance(curr_val, (int, float)) and not isinstance(curr_val, bool):
                if agg_func == "MIN":
                    new_row[c_name] = (curr_val + 50.0) if isinstance(curr_val, float) else (curr_val + 10)
                elif agg_func == "MAX":
                    new_row[c_name] = (curr_val - 50.0) if isinstance(curr_val, float) else (curr_val - 10)
                else:
                    new_row[c_name] = curr_val + 1
            elif curr_val is not None and agg_func in ("MIN", "MAX"):
                non_ext_dir = "larger" if agg_func == "MIN" else "smaller"
                new_row[c_name] = self._step_extremum_value(
                    schema, t_name, c_name, col_obj, curr_val, non_ext_dir, row_context=new_row
                )
            else:
                new_row[c_name] = next_distinct_value(col_obj, curr_val, schema=schema, table_name=t_name)

            # Find correlated/joined columns in the subquery and outer joins on target_table
            correlated_cols = set()
            if ast:
                for subq in ast.find_all(exp.Subquery):
                    subq_tables = {
                        schema.find_table(t.name)
                        for t in subq.find_all(exp.Table)
                        if schema.find_table(t.name)
                    }
                    if t_name not in subq_tables:
                        continue
                    for eq in subq.find_all(exp.EQ):
                        l = eq.left if isinstance(eq.left, exp.Column) else eq.left.find(exp.Column)
                        r = eq.right if isinstance(eq.right, exp.Column) else eq.right.find(exp.Column)
                        if l and r:
                            for col_node in (l, r):
                                res_c = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                                if res_c and res_c[0] == t_name:
                                    correlated_cols.add(res_c[1])
                                elif not col_node.table:
                                    found_c = schema.find_column(t_name, col_node.name)
                                    if found_c:
                                        correlated_cols.add(found_c.name)
                    for grp in subq.find_all(exp.Group):
                        for col_node in grp.find_all(exp.Column):
                            res_c = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                            if res_c and res_c[0] == t_name:
                                correlated_cols.add(res_c[1])
                            elif not col_node.table:
                                found_c = schema.find_column(t_name, col_node.name)
                                if found_c:
                                    correlated_cols.add(found_c.name)

            outer_join_cols_upper = set()
            for o_join in parsed_query.get("joins", []):
                if o_join.get("type") in ("EQ_SUBQUERY", "IN_SUBQUERY"):
                    continue
                for o_pair in o_join.get("on_pairs", []):
                    for side in ("left", "right"):
                        res_o = resolve_query_column(
                            schema, parsed_query, o_pair[side].get("table", ""), o_pair[side].get("column", "")
                        )
                        if res_o and res_o[0] == t_name:
                            outer_join_cols_upper.add(res_o[1].upper())
            for w_pair in parsed_query.get("where_joins", []):
                for side in ("left", "right"):
                    res_w = resolve_query_column(
                        schema, parsed_query, w_pair[side].get("table", ""), w_pair[side].get("column", "")
                    )
                    if res_w and res_w[0] == t_name:
                        outer_join_cols_upper.add(res_w[1].upper())

            correlated_cols_upper = {cc.upper() for cc in correlated_cols}
            fk_by_col_upper = {fk.column_name.upper(): fk for fk in target_table.foreign_keys}

            def _clone_parent_fk(fk_obj, data_dict: dict):
                ref_tbl = fk_obj.reference_table
                ref_col = fk_obj.reference_column
                if ref_tbl not in schema.tables or not data_dict.get(ref_tbl):
                    return None
                parent_row = copy.deepcopy(data_dict[ref_tbl][0])
                ref_col_obj = schema.find_column(ref_tbl, ref_col)
                existing_ref_vals = {r.get(ref_col) for r in data_dict[ref_tbl]}
                new_pk = (
                    generate_unique_value_for_column(ref_col_obj)
                    if ref_col_obj
                    else DataFactory.get_instance().increment_pk()
                )
                if ref_col_obj:
                    new_pk = solve_check_constraint_value(
                        schema, ref_tbl, ref_col, ref_col_obj, new_pk,
                        disallowed_values=existing_ref_vals, row_context=parent_row
                    )
                    while new_pk in existing_ref_vals:
                        new_pk = next_distinct_value(ref_col_obj, new_pk, schema=schema, table_name=ref_tbl)
                parent_row[ref_col] = new_pk
                for p_col in schema.tables[ref_tbl].columns:
                    if (p_col.is_primary_key or p_col.is_unique) and p_col.name != ref_col:
                        existing_p_vals = {r.get(p_col.name) for r in data_dict[ref_tbl]}
                        p_val = generate_unique_value_for_column(p_col)
                        p_val = solve_check_constraint_value(
                            schema, ref_tbl, p_col.name, p_col, p_val,
                            disallowed_values=existing_p_vals, row_context=parent_row
                        )
                        while p_val in existing_p_vals:
                            p_val = next_distinct_value(p_col, p_val, schema=schema, table_name=ref_tbl)
                        parent_row[p_col.name] = p_val
                data_dict[ref_tbl].append(parent_row)
                return new_pk

            # Update non-correlated PK / FK / UNIQUE columns to make row_to_update valid and distinct
            def _assign_distinct_keys(
                row_to_update: dict, data_dict: dict, disconnect_outer_joins: bool = False
            ) -> None:
                if disconnect_outer_joins:
                    for col in target_table.columns:
                        if (
                            col.name != c_name
                            and col.name.upper() in outer_join_cols_upper
                            and col.name.upper() not in correlated_cols_upper
                        ):
                            fk_obj = fk_by_col_upper.get(col.name.upper())
                            if fk_obj is not None:
                                new_fk = _clone_parent_fk(fk_obj, data_dict)
                                if new_fk is not None:
                                    row_to_update[col.name] = new_fk
                                    continue
                            existing_oj = {r.get(col.name) for r in data_dict.get(t_name, [])}
                            new_oj = generate_unique_value_for_column(col)
                            new_oj = solve_check_constraint_value(
                                schema, t_name, col.name, col, new_oj,
                                disallowed_values=existing_oj, row_context=row_to_update
                            )
                            while new_oj in existing_oj:
                                new_oj = next_distinct_value(col, new_oj, schema=schema, table_name=t_name)
                            row_to_update[col.name] = new_oj

                pk_cols = [col for col in target_table.columns if col.is_primary_key]
                modifiable_pks = [
                    col for col in pk_cols
                    if col.name != c_name and col.name.upper() not in correlated_cols_upper
                ]
                modifiable_pks.sort(
                    key=lambda col: (
                        col.name.upper() in outer_join_cols_upper,
                        col.name.upper() in fk_by_col_upper,
                    )
                )

                pk_updated = any(
                    row_to_update.get(col.name) != orig_row.get(col.name)
                    and (col.name.upper() not in fk_by_col_upper or disconnect_outer_joins)
                    for col in pk_cols
                )
                if not pk_updated and modifiable_pks:
                    chosen_pk = modifiable_pks[0]
                    fk_obj = fk_by_col_upper.get(chosen_pk.name.upper())
                    if fk_obj is not None:
                        new_pk = _clone_parent_fk(fk_obj, data_dict)
                        if new_pk is not None:
                            row_to_update[chosen_pk.name] = new_pk
                            pk_updated = True
                    if not pk_updated:
                        existing_vals = {r.get(chosen_pk.name) for r in data_dict.get(t_name, [])}
                        new_pk = generate_unique_value_for_column(chosen_pk)
                        new_pk = solve_check_constraint_value(
                            schema, t_name, chosen_pk.name, chosen_pk, new_pk,
                            disallowed_values=existing_vals, row_context=row_to_update
                        )
                        while new_pk in existing_vals:
                            new_pk = next_distinct_value(chosen_pk, new_pk, schema=schema, table_name=t_name)
                        row_to_update[chosen_pk.name] = new_pk
                        pk_updated = True

                if not pk_updated and not pk_cols:
                    for fk in target_table.foreign_keys:
                        if fk.column_name == c_name or fk.column_name.upper() in correlated_cols_upper:
                            continue
                        new_pk = _clone_parent_fk(fk, data_dict)
                        if new_pk is not None:
                            row_to_update[fk.column_name] = new_pk
                            break

                for col in target_table.columns:
                    if (
                        col.is_unique
                        and not col.is_primary_key
                        and col.name != c_name
                        and col.name.upper() not in correlated_cols_upper
                    ):
                        fk_obj = fk_by_col_upper.get(col.name.upper())
                        if fk_obj is not None:
                            new_u = _clone_parent_fk(fk_obj, data_dict)
                            if new_u is not None:
                                row_to_update[col.name] = new_u
                                continue
                        existing_u = {r.get(col.name) for r in data_dict.get(t_name, [])}
                        new_u = generate_unique_value_for_column(col)
                        new_u = solve_check_constraint_value(
                            schema, t_name, col.name, col, new_u,
                            disallowed_values=existing_u, row_context=row_to_update
                        )
                        while new_u in existing_u:
                            new_u = next_distinct_value(col, new_u, schema=schema, table_name=t_name)
                        row_to_update[col.name] = new_u

            _assign_distinct_keys(new_row, eq_data)

            eq_data[t_name].append(new_row)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_extremum_{c_name}",
                    data=eq_data,
                    tags=["subquery_attack"],
                    description=(
                        f"Targets Scalar Subquery / Extremum Dropping bugs. Injects a second candidate row for "
                        f"`{t_name}.{c_name}` with non-extremum value `{new_row[c_name]}` while preserving correlation keys. "
                        f"A mutant missing the subquery returns both candidate rows, while the correct query returns only one."
                    )
                )
            )

            # Also inject a stronger extremum usurper row (e.g. smaller value for MIN, larger value for MAX)
            # so that if the outer query also constrains `col = literal`, the scalar subquery shifts away
            # from `literal` and rejects the outer row in the gold query while a mutant that drops the
            # scalar subquery still returns it.
            if agg_func in ("MIN", "MAX", "AVG", "SUM") and curr_val is not None:
                usurp_data = copy.deepcopy(base_for_eq)
                usurp_row = copy.deepcopy(usurp_data[t_name][0])
                usurp_dir = "smaller" if agg_func == "MIN" else "larger"
                cand_val = self._step_extremum_value(
                    schema, t_name, c_name, col_obj, curr_val, usurp_dir, row_context=usurp_row
                )
                usurp_row[c_name] = cand_val
                _assign_distinct_keys(usurp_row, usurp_data, disconnect_outer_joins=True)
                usurp_data[t_name].append(usurp_row)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_extremum_usurper_{c_name}",
                        data=usurp_data,
                        tags=["subquery_attack"],
                        description=(
                            f"Targets Scalar Subquery / Extremum Dropping bugs when conjoined with equality predicates. "
                            f"Injects a stronger extremum row for `{t_name}.{c_name}` with value `{usurp_row[c_name]}` "
                            f"to shift `{agg_func}({c_name})` away from `{curr_val}`."
                        )
                    )
                )

            if (
                agg_func in ("MIN", "MAX")
                and col_obj is not None
                and not col_obj.is_primary_key
                and not col_obj.is_unique
                and data1.get(t_name)
                and data2.get(t_name)
            ):
                tie_d1 = copy.deepcopy(data1)
                tie_d2 = copy.deepcopy(data2)
                cand_vals = [
                    r.get(c_name)
                    for r in tie_d1[t_name] + tie_d2[t_name]
                    if r.get(c_name) is not None
                ]
                if cand_vals:
                    try:
                        tie_val = max(cand_vals) if agg_func == "MAX" else min(cand_vals)
                    except TypeError:
                        tie_val = max(cand_vals, key=str) if agg_func == "MAX" else min(cand_vals, key=str)
                    ext_root = equiv.find(col_key(t_name, c_name))
                    for grp in (tie_d1, tie_d2):
                        for grp_t, grp_rows in grp.items():
                            if not grp_rows or grp_t not in schema.tables:
                                continue
                            for grp_col in schema.tables[grp_t].columns:
                                if (grp_t == t_name and grp_col.name == c_name) or (
                                    equiv.find(col_key(grp_t, grp_col.name)) == ext_root
                                    and not grp_col.is_primary_key
                                    and not grp_col.is_unique
                                ):
                                    for r in grp_rows:
                                        r[grp_col.name] = tie_val
                    tie_merged = merge_datasets(schema, tie_d1, tie_d2)
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_extremum_tie_{c_name}",
                            data=tie_merged,
                            tags=["subquery_attack", "order_limit_tie"],
                            description=(
                                f"Targets Scalar Extremum Subquery vs LIMIT 1 truncation bugs on `{t_name}.{c_name}`. "
                                f"Merges two distinct outer entity groups that tie on the winning `{agg_func}({c_name})` "
                                f"value (`{tie_val}`), so queries filtering by `{c_name} = (SELECT {agg_func}({c_name}) ...)` "
                                f"return both tied groups whereas mutants adding `LIMIT 1` truncate the result."
                            ),
                        )
                    )

        datasets.extend(self._generate_agg_subquery_filter_datasets(schema, parsed_query))

        return datasets

    def _step_extremum_value(
        self,
        schema: Schema,
        t_name: str,
        c_name: str,
        col_obj: Any,
        base_val: Any,
        direction: str,
        row_context: Dict[str, Any] | None = None,
    ) -> Any:
        if isinstance(base_val, (int, float)) and not isinstance(base_val, bool):
            if direction == "smaller":
                if base_val > 1:
                    cand_val = (base_val / 2.0) if isinstance(base_val, float) else max(1, base_val // 2)
                else:
                    cand_val = (base_val - 1.0) if isinstance(base_val, float) else (base_val - 1)
            else:
                cand_val = (base_val + 10.0) if isinstance(base_val, float) else (base_val + 10)
            if col_obj:
                cand_val = solve_check_constraint_value(
                    schema, t_name, c_name, col_obj, cand_val,
                    disallowed_values={base_val}, row_context=row_context,
                )
            return cand_val

        if isinstance(base_val, str):
            is_temp = _is_iso_date_str(base_val) or bool(col_obj and col_obj.is_temporal)
            if is_temp:
                dt_str = col_obj.data_type if col_obj else "DATE"
                cand_val = (
                    _step_below(base_val, dt_str, col_obj, is_temporal=True)
                    if direction == "smaller"
                    else _step_above(base_val, dt_str, col_obj, is_temporal=True)
                )
                if cand_val != base_val:
                    if col_obj:
                        cand_val = solve_check_constraint_value(
                            schema, t_name, c_name, col_obj, cand_val,
                            disallowed_values={base_val}, row_context=row_context,
                        )
                    return cand_val

            cand_val = None
            if direction == "smaller":
                for idx in range(len(base_val) - 1, -1, -1):
                    ch = base_val[idx]
                    if ("1" <= ch <= "9") or ("b" <= ch <= "z") or ("B" <= ch <= "Z"):
                        cand_val = base_val[:idx] + chr(ord(ch) - 1) + base_val[idx + 1:]
                        break
                if cand_val is None:
                    if len(base_val) > 1:
                        cand_val = base_val[:-1]
                    elif len(base_val) == 1 and ord(base_val[0]) > 33:
                        cand_val = chr(ord(base_val[0]) - 1)
                    else:
                        cand_val = ""
            else:
                for idx in range(len(base_val) - 1, -1, -1):
                    ch = base_val[idx]
                    if ("0" <= ch <= "8") or ("a" <= ch <= "y") or ("A" <= ch <= "Y"):
                        cand_val = base_val[:idx] + chr(ord(ch) + 1) + base_val[idx + 1:]
                        break
                if cand_val is None:
                    cand_val = base_val + "_z"

            if col_obj:
                cand_val = solve_check_constraint_value(
                    schema, t_name, c_name, col_obj, cand_val,
                    disallowed_values={base_val}, row_context=row_context,
                )
            return cand_val

        if col_obj:
            return next_distinct_value(col_obj, base_val, schema=schema, table_name=t_name)
        return base_val

    def _generate_agg_subquery_filter_datasets(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Dataset]:
        """
        Target semantic bug: Missing, partially omitted, or spurious WHERE filter predicates
        in scalar/aggregate subqueries (e.g., `col > (SELECT AVG(col) FROM T WHERE P)` vs
        `col > (SELECT AVG(col) FROM T)`).

        Algorithm & Dataset Design:
        1. Identifies all subqueries containing aggregate functions (AVG, SUM, MIN, MAX, COUNT)
           and resolves their target tables and aggregated columns.
        2. Starts from a base dataset satisfying all query predicates (`base_data`).
        3. For each filter literal on a table referenced inside an aggregate subquery, clones
           a satisfying row (`base_data[t_name][0]`), preserves all other equality predicates
           and correlation/FK keys, violates only the target filter column, and assigns extreme
           high and low outlier values to the aggregated numeric column.
        4. A query whose subquery includes the filter predicate excludes the outlier row from
           aggregation, whereas a query whose subquery omits the filter includes the outlier row,
           shifting the subquery aggregate across the outer comparison threshold.
        """
        ast = parsed_query.get("ast")
        if not ast:
            return []

        subq_tables = set()
        agg_targets = []
        for subq in ast.find_all(exp.Subquery):
            agg_nodes = list(subq.find_all((exp.Avg, exp.Sum, exp.Min, exp.Max, exp.Count)))
            if not agg_nodes:
                continue
            local_tables = []
            for t in subq.find_all(exp.Table):
                st = schema.find_table(t.name)
                if st and st not in local_tables:
                    local_tables.append(st)
                    subq_tables.add(st)
            for agg_node in agg_nodes:
                agg_func = agg_node.key.upper()
                cols = list(agg_node.find_all(exp.Column))
                if cols:
                    for col in cols:
                        resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                        if not resolved or resolved[0] not in local_tables:
                            resolved = None
                            for st in local_tables:
                                c_obj = schema.find_column(st, col.name)
                                if c_obj:
                                    resolved = (st, c_obj.name)
                                    break
                        if resolved and resolved[0] in schema.tables:
                            target = (resolved[0], resolved[1], agg_func)
                            if target not in agg_targets:
                                agg_targets.append(target)
                else:
                    for st in local_tables:
                        target = (st, None, agg_func)
                        if target not in agg_targets:
                            agg_targets.append(target)

        if not agg_targets or not subq_tables:
            return []

        where_literals = parsed_query.get("where_literals", [])
        if not where_literals:
            return []

        try:
            base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="subq_agg_filter_base")
        except Exception:
            return []

        avoid_eq_vals: Dict[tuple, set] = {}
        sat_eq_val: Dict[tuple, Any] = {}
        for lit in where_literals:
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if not res:
                continue
            t_n, c_n = res
            op_up = lit.get("operator", "EQ").upper()
            v = lit.get("value")
            if v is None or v == "NULL":
                continue
            coerced_v: Any = v
            if isinstance(v, str) and v.lstrip("-").replace(".", "", 1).isdigit():
                num_v = float(v)
                coerced_v = int(num_v) if num_v.is_integer() else num_v
            if op_up in ("EQ", "IN"):
                avoid_eq_vals.setdefault((t_n, c_n), set()).add(coerced_v)
                avoid_eq_vals[(t_n, c_n)].add(str(v))
                sat_eq_val.setdefault((t_n, c_n), coerced_v)

        out_datasets: List[Dataset] = []
        seen_pred_targets = set()

        for lit in where_literals:
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if not res:
                continue
            t_name, c_name = res
            if t_name not in subq_tables or not base_data.get(t_name):
                continue

            op = lit.get("operator", "EQ").upper()
            val = lit.get("value")
            if val is None:
                continue

            pred_key = (t_name, c_name, op, str(val))
            if pred_key in seen_pred_targets:
                continue
            seen_pred_targets.add(pred_key)

            col_obj = schema.find_column(t_name, c_name)
            if not col_obj:
                continue

            avoid_set = avoid_eq_vals.get((t_name, c_name), set())
            violated_val = None
            if val == "NULL":
                if op in ("IS", "IS NULL", "EQ"):
                    cand = generate_unique_value_for_column(col_obj)
                    violated_val = solve_check_constraint_value(schema, t_name, c_name, col_obj, cand)
                else:
                    if not col_obj.is_nullable:
                        continue
                    violated_val = None
            else:
                is_num = False
                num = 0.0
                try:
                    num = float(val)
                    is_num = True
                except (ValueError, TypeError):
                    is_num = False

                if is_num and col_obj.is_numeric:
                    num_coerced = int(num) if num.is_integer() else num
                    step = 1 if isinstance(num_coerced, int) else 1.0
                    if op in ("GT", "GTE", "BETWEENLOWER"):
                        violated_val = num_coerced - step
                    elif op in ("LT", "LTE", "BETWEENUPPER"):
                        violated_val = num_coerced + step
                    elif op in ("EQ", "IN"):
                        violated_val = num_coerced + step
                        while violated_val in avoid_set or str(violated_val) in avoid_set:
                            violated_val += step
                    elif op in ("NEQ", "NOT IN"):
                        violated_val = num_coerced
                else:
                    if op in ("EQ", "IN", "LIKE", "ILIKE"):
                        violated_val = next_distinct_value(col_obj, val, schema=schema, table_name=t_name)
                        attempts = 0
                        while (
                            violated_val in avoid_set
                            or str(violated_val) in avoid_set
                            or str(violated_val) == str(val)
                        ) and attempts < 20:
                            attempts += 1
                            violated_val = next_distinct_value(col_obj, violated_val, schema=schema, table_name=t_name)
                    elif op in ("NEQ", "NOT IN", "NOT LIKE", "NOT ILIKE"):
                        violated_val = val
                    elif op in ("GT", "GTE", "BETWEENLOWER"):
                        violated_val = _step_below(val, col_obj.data_type, col_obj)
                    elif op in ("LT", "LTE", "BETWEENUPPER"):
                        violated_val = _step_above(val, col_obj.data_type, col_obj)

                if violated_val is not None:
                    violated_val = solve_check_constraint_value(
                        schema, t_name, c_name, col_obj, violated_val, disallowed_values=avoid_set
                    )

            orig_row = copy.deepcopy(base_data[t_name][0])
            for (ot, oc), sat_v in sat_eq_val.items():
                if ot == t_name and oc != c_name:
                    orig_row[oc] = sat_v

            fk_cols_upper = {fk.column_name.upper() for fk in schema.tables[t_name].foreign_keys}

            for agg_t, agg_c, agg_func in agg_targets:
                if agg_t != t_name:
                    continue
                if agg_c is not None:
                    agg_col_obj = schema.find_column(t_name, agg_c)
                    if not agg_col_obj or not agg_col_obj.is_numeric:
                        continue
                    existing_nums = [
                        abs(float(r.get(agg_c)))
                        for r in base_data[t_name]
                        if isinstance(r.get(agg_c), (int, float)) and not isinstance(r.get(agg_c), bool)
                    ]
                    max_abs = max(existing_nums + [10.0])
                    scale = (max_abs + 50.0) * 10.0
                    is_int_agg = "int" in (agg_col_obj.data_type or "").lower()
                    high_cand = int(scale) if is_int_agg else float(scale)
                    low_cand = -int(scale) if is_int_agg else -float(scale)

                    for dir_label, out_cand in (("high", high_cand), ("low", low_cand)):
                        if c_name == agg_c:
                            try:
                                num_bound = float(val)
                                if op in ("GT", "GTE", "BETWEENLOWER") and out_cand >= num_bound:
                                    continue
                                if op in ("LT", "LTE", "BETWEENUPPER") and out_cand <= num_bound:
                                    continue
                            except (ValueError, TypeError):
                                continue
                            if op in ("NEQ", "NOT IN"):
                                continue
                            if op in ("EQ", "IN") and (out_cand in avoid_set or str(out_cand) in avoid_set):
                                continue

                        cand_data = copy.deepcopy(base_data)
                        viol_row = copy.deepcopy(orig_row)
                        viol_row[c_name] = violated_val
                        out_val = solve_check_constraint_value(
                            schema, t_name, agg_c, agg_col_obj, out_cand, row_context=viol_row
                        )
                        viol_row[agg_c] = out_val

                        for u_col in schema.tables[t_name].columns:
                            if (
                                (u_col.is_primary_key or u_col.is_unique)
                                and u_col.name not in (c_name, agg_c)
                                and u_col.name.upper() not in fk_cols_upper
                            ):
                                u_cand = generate_unique_value_for_column(u_col)
                                viol_row[u_col.name] = solve_check_constraint_value(
                                    schema, t_name, u_col.name, u_col, u_cand, row_context=viol_row
                                )

                        cand_data[t_name].append(viol_row)
                        out_datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_agg_filter_{dir_label}_{c_name}",
                                data=cand_data,
                                tags=["subquery_attack", "missing_predicate_attack"],
                                description=(
                                    f"Targets Missing or Partially Omitted Subquery Filter bugs in aggregate subqueries. "
                                    f"Appends a companion row to `{t_name}` that violates `{t_name}.{c_name} {op} {val}` "
                                    f"while satisfying other predicates and setting `{t_name}.{agg_c}` to a {dir_label} "
                                    f"outlier (`{out_val}`), shifting `{agg_func}({agg_c})` when the subquery filter is omitted."
                                ),
                            )
                        )
                else:
                    cand_data = copy.deepcopy(base_data)
                    viol_row = copy.deepcopy(orig_row)
                    viol_row[c_name] = violated_val
                    for u_col in schema.tables[t_name].columns:
                        if (
                            (u_col.is_primary_key or u_col.is_unique)
                            and u_col.name != c_name
                            and u_col.name.upper() not in fk_cols_upper
                        ):
                            u_cand = generate_unique_value_for_column(u_col)
                            viol_row[u_col.name] = solve_check_constraint_value(
                                schema, t_name, u_col.name, u_col, u_cand, row_context=viol_row
                            )
                    cand_data[t_name].append(viol_row)
                    out_datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_agg_filter_count_{c_name}",
                            data=cand_data,
                            tags=["subquery_attack", "missing_predicate_attack"],
                            description=(
                                f"Targets Missing or Partially Omitted Subquery Filter bugs in COUNT subqueries. "
                                f"Appends a companion row to `{t_name}` that violates `{t_name}.{c_name} {op} {val}` "
                                f"while satisfying other predicates, inflating `COUNT` when the subquery filter is omitted."
                            ),
                        )
                    )

        return out_datasets


