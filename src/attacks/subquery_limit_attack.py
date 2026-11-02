"""
SubqueryLimitAttackStrategy Module

Target semantic bug: Subquery LIMIT applied after JOIN, outer filter, or improperly scoped.
Algorithm & Dataset Design:
1. WHERE Subqueries with ORDER BY + LIMIT (`IN_SUBQUERY` and `EQ_SUBQUERY`):
   - Outer Duplication (`outer_dup`): Makes the top-ranked inner subquery row match multiple outer rows
     so that an uncorrelated subquery returning all matching outer rows yields M > N rows whereas a
     mutant rewriting the subquery into `JOIN ... LIMIT N` truncates to N rows.
   - Unmatched Top Inner Row (`unmatched_top`): Injects a strictly top-ranked inner row whose subquery
     projection column is unmatched by the outer table (setting it to NULL when the column is a nullable
     foreign key so referential integrity holds without orphan-parent synthesis, or a distinct non-matching
     value otherwise), while keeping a lower-ranked inner row that matches the outer table. The subquery
     truncates to the unmatched top row (yielding 0 outer rows), whereas a mutant `INNER JOIN ... LIMIT`
     filters out the unmatched/NULL inner row prior to `LIMIT` and returns the lower-ranked matching row.
2. Derived Table Subqueries with ORDER BY + LIMIT:
   - Populates N top-ranked rows violating the outer predicate and 1 lower-ranked row satisfying it,
     verifying that subquery truncation occurs prior to outer filtering.
"""

from typing import Any, Dict, List
import copy
from datetime import timedelta
from dateutil.parser import parse as parse_date
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator.value_generator import DataFactory, generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator import generate_base_dataset, next_distinct_value, resolve_query_column


class SubqueryLimitAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Subquery LIMIT applied after JOIN, outer filter, or improperly scoped.
    """

    def _compute_extreme_order_val(self, all_vals: List[Any], is_desc: bool, order_col_def: Any, offset: float = 10.0) -> Any:
        if not all_vals:
            return None
        # Check if numeric
        if all(isinstance(v, (int, float)) and not isinstance(v, bool) for v in all_vals):
            is_int_col = bool(order_col_def and "int" in (order_col_def.data_type or "").lower())
            if is_desc:
                max_v = max(all_vals)
                res = max_v + offset
                return int(round(res)) if (is_int_col or not isinstance(max_v, float)) else res
            else:
                min_v = min(all_vals)
                res = min_v - offset
                return int(round(res)) if (is_int_col or not isinstance(min_v, float)) else res

        # Check if date/temporal
        try:
            parsed_dates = [parse_date(str(v)) for v in all_vals]
            if is_desc:
                max_d = max(parsed_dates)
                return (max_d + timedelta(days=365)).strftime("%Y-%m-%d")
            else:
                min_d = min(parsed_dates)
                return (min_d - timedelta(days=365)).strftime("%Y-%m-%d")
        except Exception:
            pass

        # String / text
        str_vals = [str(v) for v in all_vals]
        if is_desc:
            max_s = max(str_vals)
            max_len = getattr(order_col_def, "max_length", None) or 255
            if len(max_s) < max_len:
                return max_s + "z"
            else:
                return max_s[:-1] + "z"
        else:
            min_s = min(str_vals)
            if len(min_s) > 0 and ord(min_s[0]) > 33:
                return chr(max(33, ord(min_s[0]) - 1)) + min_s[1:]
            return "!" + min_s

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for join in parsed_query.get("joins", []):
            if join.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY") and join.get("order_by") and (join.get("has_limit") or join.get("limit")):
                return True
        ast = parsed_query.get("ast")
        if ast:
            for subq in ast.find_all(exp.Select):
                if subq != ast and subq.find(exp.Limit):
                    return True
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []

        # 1. WHERE Subquery with ORDER BY + LIMIT
        for join in parsed_query.get("joins", []):
            if join.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY") and join.get("order_by") and (join.get("has_limit") or join.get("limit")):
                raw_inner_table = join.get("table", "")
                if not join.get("on_pairs"):
                    continue
                on_pair = join["on_pairs"][0]
                left_res = resolve_query_column(
                    schema, parsed_query, on_pair["left"].get("table", ""), on_pair["left"]["column"]
                )
                right_res = resolve_query_column(
                    schema,
                    parsed_query,
                    on_pair["right"].get("table") or raw_inner_table,
                    on_pair["right"]["column"],
                )
                if left_res:
                    outer_table, outer_column = left_res
                else:
                    outer_table = schema.find_table(on_pair["left"].get("table", "")) or on_pair["left"].get("table", "")
                    outer_col_obj = schema.find_column(outer_table, on_pair["left"]["column"]) if outer_table in schema.tables else None
                    outer_column = outer_col_obj.name if outer_col_obj else on_pair["left"]["column"]

                if right_res:
                    inner_table, inner_column = right_res
                else:
                    inner_table = schema.find_table(on_pair["right"].get("table") or raw_inner_table) or raw_inner_table
                    inner_col_obj = schema.find_column(inner_table, on_pair["right"]["column"]) if inner_table in schema.tables else None
                    inner_column = inner_col_obj.name if inner_col_obj else on_pair["right"]["column"]

                order_col_info = join["order_by"][0]
                order_col_name = order_col_info["column"]
                is_desc = order_col_info["desc"]

                # --- Dataset 1: Outer Duplication (M matching outer rows > LIMIT N) ---
                ds_data_a = generate_base_dataset(schema, parsed_query, cache_key_salt=f"subq_lim_dup_{inner_table}")
                if inner_table in schema.tables and outer_table in schema.tables and ds_data_a.get(inner_table) and ds_data_a.get(outer_table):
                    inner_tbl_obj = schema.tables[inner_table]
                    order_col_def = schema.find_column(inner_table, order_col_name)
                    inner_col_def_a = schema.find_column(inner_table, inner_column)
                    inner_col_key_a = inner_col_def_a.name if inner_col_def_a else inner_column
                    outer_col_def_a = schema.find_column(outer_table, outer_column)
                    outer_col_key_a = outer_col_def_a.name if outer_col_def_a else outer_column

                    # Make row 0 of inner_table strictly top-ranked relative to all rows in inner_table
                    top_inner_row = ds_data_a[inner_table][0]
                    if order_col_def:
                        all_vals = [r[order_col_def.name] for r in ds_data_a[inner_table] if r.get(order_col_def.name) is not None]
                        if all_vals:
                            extreme_v = self._compute_extreme_order_val(all_vals, is_desc, order_col_def, offset=10.0)
                            if extreme_v is not None:
                                extreme_v = solve_check_constraint_value(
                                    schema, inner_table, order_col_def.name, order_col_def, extreme_v, row_context=top_inner_row
                                )
                                top_inner_row[order_col_def.name] = extreme_v

                    target_val = top_inner_row.get(inner_col_key_a)

                    # Find or set outer_table row matching target_val
                    outer_tbl_obj = schema.tables[outer_table]
                    matching_outer = ds_data_a[outer_table][0]
                    matching_outer[outer_col_key_a] = target_val

                    # Create duplicate matching outer row
                    dup_outer = copy.deepcopy(matching_outer)
                    for col in outer_tbl_obj.columns:
                        if (col.is_primary_key or col.is_unique) and col.name.upper() != outer_col_key_a.upper():
                            dup_outer[col.name] = generate_unique_value_for_column(col)

                    ds_data_a[outer_table].append(dup_outer)
                    DataFactory().clear_uniqueness()

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_outer_dup_{inner_table}",
                            data=ds_data_a,
                            tags=["subquery_limit_attack", "subquery"],
                            description=f"Targets Subquery Limit vs Join Limit bugs. Dataset makes inner top-ranked subquery row match multiple outer rows in `{outer_table}`. A correct query returning all outer matches yields M rows, whereas a mutant transforming subquery into JOIN ... LIMIT N truncates to N rows."
                        )
                    )

                # --- Dataset 2: Unmatched Top Inner Row ---
                ds_data_b = generate_base_dataset(schema, parsed_query, cache_key_salt=f"subq_lim_unmatched_{inner_table}")
                if inner_table in schema.tables and ds_data_b.get(inner_table):
                    inner_tbl_obj = schema.tables[inner_table]
                    order_col_def = schema.find_column(inner_table, order_col_name)
                    inner_col_def = schema.find_column(inner_table, inner_column)
                    inner_col_key = inner_col_def.name if inner_col_def else inner_column
                    outer_col_def = schema.find_column(outer_table, outer_column) if outer_table in schema.tables else None
                    outer_col_key = outer_col_def.name if outer_col_def else outer_column

                    unmatched_inner = copy.deepcopy(ds_data_b[inner_table][0])

                    is_inner_col_fk = any(
                        fk.column_name.upper() == inner_col_key.upper()
                        for fk in inner_tbl_obj.foreign_keys
                    )
                    subq_filters_inner_col = any(
                        lit.get("is_subquery")
                        and resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", "")) == (inner_table, inner_col_key)
                        for lit in parsed_query.get("where_literals", [])
                    )

                    # Force inner_column to be unmatched by outer_table.
                    # When inner_column is a nullable foreign key without an inner filter on it,
                    # setting it to NULL satisfies the foreign key constraint without triggering
                    # orphan parent row synthesis in repair_orphan_rows, causing the subquery's
                    # top-ranked row to evaluate to NULL (unmatched in outer WHERE = / IN)
                    # while an INNER JOIN filters out the NULL row before LIMIT.
                    if is_inner_col_fk and inner_col_def and inner_col_def.is_nullable and not subq_filters_inner_col:
                        unmatched_inner[inner_col_key] = None
                    elif inner_col_def:
                        curr_inner_val = ds_data_b[inner_table][0].get(inner_col_key)
                        cand_val = next_distinct_value(inner_col_def, curr_inner_val, schema=schema, table_name=inner_table)
                        existing_outer_vals = {
                            r.get(outer_col_key)
                            for r in ds_data_b.get(outer_table, [])
                            if r.get(outer_col_key) is not None
                        }
                        attempts = 0
                        while cand_val in existing_outer_vals and attempts < 20:
                            attempts += 1
                            cand_val = next_distinct_value(inner_col_def, cand_val, schema=schema, table_name=inner_table)
                        unmatched_inner[inner_col_key] = cand_val
                    else:
                        unmatched_inner[inner_col_key] = generate_unique_value_for_column(inner_tbl_obj.columns[0])

                    # Force order_col_name to be strictly top-ranked relative to all inner rows
                    if order_col_def:
                        all_vals = [r[order_col_def.name] for r in ds_data_b[inner_table] if r.get(order_col_def.name) is not None]
                        if all_vals:
                            extreme_v = self._compute_extreme_order_val(all_vals, is_desc, order_col_def, offset=50.0)
                            if extreme_v is not None:
                                extreme_v = solve_check_constraint_value(
                                    schema, inner_table, order_col_def.name, order_col_def, extreme_v, row_context=unmatched_inner
                                )
                                unmatched_inner[order_col_def.name] = extreme_v

                    # Regenerate PK/unique columns
                    for col in inner_tbl_obj.columns:
                        if (col.is_primary_key or col.is_unique) and col.name.upper() not in (inner_col_key.upper(), order_col_name.upper()):
                            unmatched_inner[col.name] = generate_unique_value_for_column(col)

                    ds_data_b[inner_table].append(unmatched_inner)
                    DataFactory().clear_uniqueness()

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_unmatched_top_{inner_table}",
                            data=ds_data_b,
                            tags=["subquery_limit_attack", "subquery"],
                            description=f"Targets Subquery Limit bugs. Dataset injects an unmatched top-ranked inner row into `{inner_table}`. An uncorrelated subquery with LIMIT truncates to this top row and outer filter returns 0 rows, whereas a mutant JOIN ignores subquery LIMIT and matches lower-ranked rows."
                        )
                    )


        # 2. Derived table subquery handling (skip WHERE subqueries handled in part 1)
        ast = parsed_query.get("ast")
        if ast:
            for subq in ast.find_all(exp.Select):
                if subq == ast or subq.find_ancestor(exp.Where):
                    continue
                limit_node = subq.find(exp.Limit)
                if not limit_node:
                    continue
                
                # Extract limit N
                limit_val = 1
                if isinstance(limit_node.expression, exp.Literal):
                    try:
                        limit_val = int(limit_node.expression.this)
                    except (ValueError, TypeError):
                        limit_val = 1

                # Extract table
                table_node = subq.find(exp.Table)
                table_name = schema.find_table(table_node.name) if table_node else None
                if not table_name or table_name not in schema.tables:
                    continue
                table_obj = schema.tables[table_name]

                # Extract order column and direction
                order_node = subq.find(exp.Order)
                order_col_name = None
                is_desc = True
                if order_node:
                    for ordered in order_node.expressions:
                        col_expr = ordered.this
                        if isinstance(col_expr, exp.Column):
                            ord_col_obj = schema.find_column(table_name, col_expr.name)
                            order_col_name = ord_col_obj.name if ord_col_obj else col_expr.name
                            is_desc = bool(ordered.args.get("desc"))
                            break

                # Extract filter column and match value from outer or subquery predicate
                match_col_name = None
                match_val = None
                
                for lit in parsed_query.get("where_literals", []):
                    col_nm = lit.get("column")
                    found_col = schema.find_column(table_name, col_nm) if col_nm else None
                    if found_col:
                        match_col_name = found_col.name
                        match_val = lit.get("value")
                        break

                if not match_col_name:
                    # Fallback to any non-PK column
                    for col in table_obj.columns:
                        if not col.is_primary_key and col.name != order_col_name:
                            match_col_name = col.name
                            match_val = generate_unique_value_for_column(col)
                            break

                # Generate Dataset: Top N non-matching rows + 1 matching lower row
                ds_data = generate_base_dataset(schema, parsed_query)
                table_rows = []
                
                match_col_def = next((c for c in table_obj.columns if c.name == match_col_name), table_obj.columns[0] if table_obj.columns else None)
                if not match_col_def:
                    continue
                non_match_val = next_distinct_value(match_col_def, match_val)

                # N top-ranking non-matching rows
                for i in range(limit_val):
                    row = {}
                    for col in table_obj.columns:
                        if col.name == match_col_name:
                            row[col.name] = f"{non_match_val}_{i}" if col.is_text else non_match_val
                        elif col.name == order_col_name:
                            row[col.name] = (200 - i) if is_desc else (i + 1)
                        else:
                            row[col.name] = generate_unique_value_for_column(col)
                    table_rows.append(row)

                # 1 lower-ranking matching row
                low_row = {}
                for col in table_obj.columns:
                    if col.name == match_col_name:
                        low_row[col.name] = match_val
                    elif col.name == order_col_name:
                        low_row[col.name] = 0 if is_desc else (limit_val + 10)
                    else:
                        low_row[col.name] = generate_unique_value_for_column(col)
                table_rows.append(low_row)

                ds_data[table_name] = table_rows

                datasets.append(
                    Dataset(
                        strategy_name=self.__class__.__name__,
                        data=ds_data,
                        tags=["subquery_limit_attack", "subquery"],
                        description=f"Targets Derived Table Subquery LIMIT bugs. Dataset populates {limit_val} top-ranked rows violating outer predicate and 1 lower-ranked row satisfying it. This tests whether subquery LIMIT correctly truncates rows before outer filtering."
                    )
                )

        return datasets

