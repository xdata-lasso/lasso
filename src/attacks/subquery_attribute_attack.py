"""
SubqueryAttributeAttackStrategy Module

Target semantic bug: Subquery Attribute Selection Mismatch
(subquery or outer query using wrong column, dropping tuple-IN components, or swapping columns
in IN / NOT IN / EQ_SUBQUERY predicates).

Algorithm & Relational Semantics:
1. For queries containing subquery comparisons (`col_outer IN (SELECT col_inner ...)` or
   `(c1, ..., cm) IN (SELECT ic1, ..., icm ...)`):
2. We resolve all pairs in `join["on_pairs"]` between outer table T_out and inner table T_in.
3. Multi-column tuple comparisons (`len(pairs) > 1`):
   - Mutants often drop a component (e.g. `(c2, ..., cm) IN (...)`) or substitute a component.
   - Dataset Design:
     a. Full Match Dataset: all components match between outer row R_out and inner row R_in.
        Gold evaluates to TRUE (returns row).
     b. Partial Match Datasets: for each component pair k in [0..m-1]:
        Components i != k match between R_out and R_in, while component k is deliberately
        differentiated (satisfying column CHECK constraints).
        - Gold requires all m components to match: component k differs -> Gold evaluates to FALSE (0 rows).
        - Any mutant dropping component k requires only the other components: all match -> Mutant evaluates to TRUE (>= 1 row).
        This deterministically refutes any dropped or substituted component in tuple-IN predicates!
4. Single-column comparisons (`len(pairs) == 1`):
   - Sets up key cross-matching between 2 outer rows and 1 inner row:
     Outer row 2 matches inner row on the target key.
     Outer row 1 has a distinct key value.
     Candidate alternative columns are differentiated between outer rows and aligned with inner row.
     Gold returns R_out_2, while mutants referencing alternative columns return R_out_1 or empty.
5. All datasets ensure primary key / unique integrity via `ensure_dataset_uniqueness` and foreign key
   validity via `repair_orphan_rows`, with strict CHECK constraint adherence.
"""

import copy
from typing import Any, Dict, List, Optional
import sqlglot
import sqlglot.expressions as exp

from faker import Faker
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column, next_distinct_value
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.uniqueness import ensure_dataset_uniqueness
from dataset_generator.value_generator import (
    generate_unique_id_for_column,
    generate_unique_string_for_column,
    generate_unique_value_for_column,
)
from dataset_generator.augmentation import repair_orphan_rows
from parser import parse_sql_to_ast

fake = Faker()


class SubqueryAttributeAttackStrategy(AttackStrategy):
    """
    Targets Subquery Attribute Selection Mismatch bugs in subquery predicates.
    Generates datasets with structured key cross-matching between outer and inner tables
    to guarantee non-empty results on Gold query while refuting erroneous subquery attribute references.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return any(j.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY") for j in parsed_query.get("joins", []))

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        raw_query = parsed_query.get("raw_query", "")

        for join in parsed_query.get("joins", []):
            if join.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                continue

            resolved_pairs = []
            for pair in join.get("on_pairs", []):
                outer_table_raw = pair["left"]["table"]
                outer_col_raw = pair["left"]["column"]
                inner_table_raw = pair["right"]["table"]
                inner_col_raw = pair["right"]["column"]

                resolved_outer = resolve_query_column(schema, parsed_query, outer_table_raw, outer_col_raw)
                resolved_inner = resolve_query_column(schema, parsed_query, inner_table_raw, inner_col_raw)

                if resolved_outer and resolved_inner:
                    if resolved_outer[0] in schema.tables and resolved_inner[0] in schema.tables:
                        resolved_pairs.append((resolved_outer, resolved_inner))

            if not resolved_pairs:
                continue

            outer_table = resolved_pairs[0][0][0]
            inner_table = resolved_pairs[0][1][0]

            # Find subquery AST to generate satisfying inner row
            subq_ast = None
            if raw_query:
                try:
                    ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
                    for in_node in ast.find_all((exp.In, exp.EQ)):
                        subq = in_node.args.get("query") or (in_node.right if isinstance(in_node.right, exp.Subquery) else None)
                        if subq:
                            select_node = subq.this if isinstance(subq, exp.Subquery) else subq
                            s_ast = parse_sql_to_ast(select_node.sql())
                            if any(t.get("name") == inner_table or t.get("alias") == inner_table for t in s_ast.get("tables", [])):
                                subq_ast = s_ast
                                break
                            elif not subq_ast:
                                subq_ast = s_ast
                except Exception:
                    pass

            inner_data = (
                generate_base_dataset(schema, subq_ast, cache_key_salt="subq_attr_inner")
                if subq_ast else generate_base_dataset(schema, parsed_query, cache_key_salt="subq_attr_inner")
            )
            data_outer_1 = generate_base_dataset(schema, parsed_query, cache_key_salt="subq_attr_outer1")
            data_outer_2 = generate_base_dataset(schema, parsed_query, cache_key_salt="subq_attr_outer2")

            if (
                not inner_data.get(inner_table)
                or not data_outer_1.get(outer_table)
                or not data_outer_2.get(outer_table)
            ):
                continue

            constrained_inner_cols = set()
            if subq_ast:
                for lit in subq_ast.get("where_literals", []):
                    col_name = lit.get("column")
                    if col_name:
                        constrained_inner_cols.add(col_name.upper())

            constrained_outer_cols = set()
            for lit in parsed_query.get("where_literals", []):
                col_name = lit.get("column")
                if col_name:
                    constrained_outer_cols.add(col_name.upper())

            def build_combined_dataset(
                r_out1: Optional[Dict[str, Any]],
                r_out2: Dict[str, Any],
                r_in: Dict[str, Any],
                strat_name: str,
                desc: str
            ) -> Dataset:
                combined_data: Dict[str, List[Dict[str, Any]]] = {t: [] for t in schema.tables}
                if outer_table == inner_table:
                    rows = [r_out1, r_out2, r_in] if r_out1 else [r_out2, r_in]
                    combined_data[outer_table] = rows
                else:
                    combined_data[outer_table] = [r_out1, r_out2] if r_out1 else [r_out2]
                    combined_data[inner_table] = [r_in]

                for t in schema.tables:
                    if t not in (outer_table, inner_table):
                        for ds in (data_outer_2, inner_data):
                            for r in ds.get(t, []):
                                if r not in combined_data[t]:
                                    combined_data[t].append(copy.deepcopy(r))

                combined_data = ensure_dataset_uniqueness(schema, combined_data)
                repair_orphan_rows(schema, combined_data)
                fake.unique.clear()
                return Dataset(
                    strategy_name=strat_name,
                    data=combined_data,
                    tags=["subquery_attack", "attribute_attack"],
                    description=desc
                )

            # --- Multi-column tuple comparisons ---
            if len(resolved_pairs) > 1:
                # 1. Full Match Dataset
                r_out2 = copy.deepcopy(data_outer_2[outer_table][0])
                r_in = copy.deepcopy(inner_data[inner_table][0])
                for (_, out_c), (_, in_c) in resolved_pairs:
                    if in_c.upper() in constrained_inner_cols:
                        r_out2[out_c] = r_in[in_c]
                    else:
                        r_in[in_c] = r_out2[out_c]

                datasets.append(
                    build_combined_dataset(
                        None,
                        r_out2,
                        r_in,
                        f"{self.__class__.__name__}_tuple_full_match",
                        f"Targets tuple-IN subquery predicate by providing a complete match between `{outer_table}` and `{inner_table}` on all tuple components."
                    )
                )

                # 2. Partial Match Datasets (one for each component k)
                for k, ((out_tk, out_ck), (in_tk, in_ck)) in enumerate(resolved_pairs):
                    r_out2_k = copy.deepcopy(data_outer_2[outer_table][0])
                    r_in_k = copy.deepcopy(inner_data[inner_table][0])

                    # Match all pairs except k
                    for i, ((_, out_ci), (_, in_ci)) in enumerate(resolved_pairs):
                        if i != k:
                            if in_ci.upper() in constrained_inner_cols:
                                r_out2_k[out_ci] = r_in_k[in_ci]
                            else:
                                r_in_k[in_ci] = r_out2_k[out_ci]

                    # For pair k, deliberately differentiate
                    if in_ck.upper() not in constrained_inner_cols:
                        col_obj = next((c for c in schema.tables[inner_table].columns if c.name.upper() == in_ck.upper()), None)
                        diff_val = next_distinct_value(col_obj, r_out2_k[out_ck]) if col_obj else generate_unique_value_for_column(col_obj)
                        diff_val = solve_check_constraint_value(schema, inner_table, in_ck, col_obj, diff_val, row_context=r_in_k)
                        if diff_val == r_out2_k[out_ck] or diff_val is None:
                            diff_val = generate_unique_value_for_column(col_obj)
                            diff_val = solve_check_constraint_value(schema, inner_table, in_ck, col_obj, diff_val, row_context=r_in_k)
                        r_in_k[in_ck] = diff_val
                    elif out_ck.upper() not in constrained_outer_cols:
                        col_obj = next((c for c in schema.tables[outer_table].columns if c.name.upper() == out_ck.upper()), None)
                        diff_val = next_distinct_value(col_obj, r_in_k[in_ck]) if col_obj else generate_unique_value_for_column(col_obj)
                        diff_val = solve_check_constraint_value(schema, outer_table, out_ck, col_obj, diff_val, row_context=r_out2_k)
                        if diff_val == r_in_k[in_ck] or diff_val is None:
                            diff_val = generate_unique_value_for_column(col_obj)
                            diff_val = solve_check_constraint_value(schema, outer_table, out_ck, col_obj, diff_val, row_context=r_out2_k)
                        r_out2_k[out_ck] = diff_val

                    datasets.append(
                        build_combined_dataset(
                            None,
                            r_out2_k,
                            r_in_k,
                            f"{self.__class__.__name__}_tuple_diff_{out_ck}_{in_ck}",
                            f"Targets dropped or mismatched component `{out_ck}` vs `{in_ck}` in tuple-IN subquery. All components except `{out_ck}` match, causing Gold to evaluate to FALSE while mutants omitting `{out_ck}` evaluate to TRUE."
                        )
                    )

            # --- Single-column comparisons ---
            else:
                (_, outer_col), (_, inner_col) = resolved_pairs[0]
                row_outer_1 = copy.deepcopy(data_outer_1[outer_table][0])
                row_outer_2 = copy.deepcopy(data_outer_2[outer_table][0])

                v1 = row_outer_1.get(outer_col)
                v2 = row_outer_2.get(outer_col)

                if v1 is None or v2 is None:
                    continue

                outer_col_obj = next((c for c in schema.tables[outer_table].columns if c.name.upper() == outer_col.upper()), None)
                if v1 == v2:
                    v2 = next_distinct_value(outer_col_obj, v1) if outer_col_obj else generate_unique_value_for_column(outer_col_obj)
                    v2 = solve_check_constraint_value(schema, outer_table, outer_col, outer_col_obj, v2, row_context=row_outer_2)
                    row_outer_2[outer_col] = v2

                candidate_inner_alts = [
                    c for c in schema.tables[inner_table].columns
                    if c.name.upper() != inner_col.upper() and c.name.upper() not in constrained_inner_cols and not c.is_primary_key and not c.is_unique
                ]
                candidate_outer_alts = [
                    c for c in schema.tables[outer_table].columns
                    if c.name.upper() != outer_col.upper() and not c.is_primary_key and not c.is_unique
                ]

                selected_pair = None
                for in_c in candidate_inner_alts:
                    in_type_is_text = "char" in (in_c.data_type or "").lower() or "text" in (in_c.data_type or "").lower()
                    for out_c in candidate_outer_alts:
                        out_type_is_text = "char" in (out_c.data_type or "").lower() or "text" in (out_c.data_type or "").lower()
                        if in_type_is_text == out_type_is_text:
                            if in_c.name.upper() == out_c.name.upper():
                                selected_pair = (out_c.name, in_c.name)
                                break
                            elif not selected_pair:
                                selected_pair = (out_c.name, in_c.name)
                    if selected_pair and selected_pair[0].upper() == selected_pair[1].upper():
                        break

                row_inner = copy.deepcopy(inner_data[inner_table][0])
                row_inner[inner_col] = v2

                if selected_pair:
                    out_alt_col, in_alt_col = selected_pair
                    if out_alt_col in row_outer_1 and in_alt_col in row_inner:
                        alt1 = row_outer_1[out_alt_col]
                        out_alt_obj = next((c for c in schema.tables[outer_table].columns if c.name.upper() == out_alt_col.upper()), None)
                        alt2 = next_distinct_value(out_alt_obj, alt1) if out_alt_obj else generate_unique_value_for_column(out_alt_obj)
                        alt2 = solve_check_constraint_value(schema, outer_table, out_alt_col, out_alt_obj, alt2, row_context=row_outer_2)
                        row_outer_2[out_alt_col] = alt2
                        row_inner[in_alt_col] = alt1

                datasets.append(
                    build_combined_dataset(
                        row_outer_1,
                        row_outer_2,
                        row_inner,
                        f"{self.__class__.__name__}_{outer_col}_{inner_col}",
                        f"Targets Subquery Attribute Selection bugs on `{outer_table}.{outer_col}` vs `{inner_table}.{inner_col}`. Dataset sets up key cross-matching between 2 outer rows and 1 inner row to ensure non-empty results on Gold query while refuting subquery column mismatches."
                    )
                )

        return datasets
