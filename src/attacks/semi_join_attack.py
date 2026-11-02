"""
SemiJoinAttackStrategy Module
=============================

Target semantic bugs:
  - Incorrect Semi-Join semantics (EXISTS subqueries dropped, replaced with NOT EXISTS,
    or with corrupted correlation/filter conditions).
  - Mutated outer query predicates on queries whose output depends on satisfying an EXISTS semi-join.

Algorithm & Dataset Design:
  In relational algebra, a semi-join (R semi-join S on C, denoted R ⋉ S) preserves only those
  tuples in R for which AT LEAST ONE matching witness tuple exists in S satisfying condition C.
  Without an intentional witness generation strategy, baseline data generation often leaves
  complex correlated EXISTS subqueries unsatisfied (e.g. self-joins requiring inequality between
  sibling foreign keys like `l2.suppkey <> l1.suppkey`), causing both correct and mutant queries
  to return empty results (vacuous EQ_EXEC).

  This strategy implements two complementary relational datasets:
  1. Satisfying Dataset (Witness Synthesis):
     Identifies positive EXISTS subqueries (not enclosed by NOT). For each, it identifies outer
     correlated column references and substitutes them with concrete values from an outer tuple
     in the baseline dataset. It then synthesizes valid witness tuples for the subquery table(s)
     that satisfy all correlation conditions, internal filters, and schema foreign keys.
     Merging these witness rows ensures the semi-join evaluates to TRUE, admitting the outer tuple
     and exposing outer-clause or operator mutations.
  2. Non-Satisfying Dataset (Witness Omission / Correlation Breakage):
     Substitutes an outer correlation key with a distinct non-matching value (via next_distinct_value).
     This ensures no witness exists, forcing the semi-join to evaluate to FALSE (0 rows for the
     correct query). Mutants that drop the EXISTS clause or convert it to an outer join erroneously
     retain the outer row.
"""

from typing import Any, Dict, List
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from parser import parse_sql_to_ast
from dataset_generator import generate_base_dataset, merge_datasets
from dataset_generator.utils import next_distinct_value
from dataset_generator.value_generator import DataFactory


class SemiJoinAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Semi-Join (EXISTS) mutations.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        ast = parsed_query.get("ast")
        if not ast:
            return False

        for ex_node in ast.find_all(exp.Exists):
            p = ex_node.parent
            is_negated = False
            while p:
                if isinstance(p, exp.Not):
                    is_negated = True
                    break
                if isinstance(p, (exp.Select, exp.Subquery)):
                    break
                p = p.parent

            if not is_negated:
                return True

        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets: List[Dataset] = []
        ast = parsed_query.get("ast")
        if not ast:
            return datasets

        base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="semi_join_base")
        seen_exists = set()

        for ex_node in ast.find_all(exp.Exists):
            p = ex_node.parent
            is_negated = False
            while p:
                if isinstance(p, exp.Not):
                    is_negated = True
                    break
                if isinstance(p, (exp.Select, exp.Subquery)):
                    break
                p = p.parent

            if is_negated:
                continue

            subq_node = ex_node.this
            subq_sql_raw = subq_node.sql()
            if subq_sql_raw in seen_exists:
                continue
            seen_exists.add(subq_sql_raw)

            subq_copy = subq_node.copy()
            select_node = subq_copy.this if isinstance(subq_copy, exp.Subquery) else subq_copy

            inner_tables = {(t.alias or t.name).upper(): t.name for t in select_node.find_all(exp.Table)}
            outer_scope_tables = {
                (t.get("alias") or t.get("name", "")).upper(): t.get("name", "")
                for t in parsed_query.get("tables", [])
                if (t.get("alias") or t.get("name", "")).upper() not in inner_tables
            }

            # Substitute outer correlated column references with outer row values
            has_unresolved_outer = False
            correlated_cols = []
            for col in select_node.find_all(exp.Column):
                col_tbl = (col.table or "").upper()
                if col_tbl and col_tbl not in inner_tables:
                    if col_tbl in outer_scope_tables:
                        schema_tbl = schema.find_table(outer_scope_tables[col_tbl])
                        if schema_tbl and base_data.get(schema_tbl):
                            col_obj = schema.find_column(schema_tbl, col.name)
                            c_name = col_obj.name if col_obj else col.name
                            val = base_data[schema_tbl][0].get(c_name)
                            if val is not None:
                                correlated_cols.append((col, schema_tbl, col_obj, val))
                                if isinstance(val, str):
                                    col.replace(exp.Literal.string(val))
                                else:
                                    col.replace(exp.Literal.number(val))
                            else:
                                has_unresolved_outer = True
                        else:
                            has_unresolved_outer = True
                    else:
                        has_unresolved_outer = True

            if has_unresolved_outer:
                continue

            # ── Dataset 1: Satisfying Witness Dataset ──
            # Synthesize witness subquery rows that satisfy the EXISTS condition.
            try:
                DataFactory.get_instance().clear_uniqueness()
                subq_sql = select_node.sql()
                subq_parsed = parse_sql_to_ast(subq_sql)
                subq_data = generate_base_dataset(
                    schema, subq_parsed, cache_key_salt=f"semi_join_witness_{len(datasets)}"
                )
                merged = merge_datasets(schema, base_data, subq_data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_exists_satisfying",
                        data=merged,
                        tags=["semi_join", "exists"],
                        description=(
                            "Targets Semi-Join EXISTS bugs. Dataset synthesizes a valid matching witness tuple "
                            "for the correlated EXISTS subquery. The correct query's semi-join evaluates to TRUE, "
                            "allowing outer tuples to pass and catching mutations in outer filters or operators."
                        ),
                    )
                )
            except Exception:
                pass

            # ── Dataset 2: Non-Satisfying (Violated Correlation) Dataset ──
            # If correlation columns exist, substitute one with a distinct non-matching value.
            if correlated_cols:
                try:
                    DataFactory.get_instance().clear_uniqueness()
                    violated_select = select_node.copy()
                    # Replace the first correlated column's value with next_distinct_value
                    target_col_ast, schema_tbl, col_obj, val = correlated_cols[0]
                    diff_val = next_distinct_value(col_obj, val, schema=schema, table_name=schema_tbl)

                    subq_copy_v = subq_node.copy()
                    select_node_v = subq_copy_v.this if isinstance(subq_copy_v, exp.Subquery) else subq_copy_v
                    for col in select_node_v.find_all(exp.Column):
                        col_tbl = (col.table or "").upper()
                        if col_tbl == (target_col_ast.table or "").upper() and col.name.upper() == target_col_ast.name.upper():
                            if isinstance(diff_val, str):
                                col.replace(exp.Literal.string(diff_val))
                            else:
                                col.replace(exp.Literal.number(diff_val))
                        elif col_tbl and col_tbl not in inner_tables and col_tbl in outer_scope_tables:
                            st = schema.find_table(outer_scope_tables[col_tbl])
                            if st and base_data.get(st):
                                co = schema.find_column(st, col.name)
                                cn = co.name if co else col.name
                                v = base_data[st][0].get(cn)
                                if v is not None:
                                    if isinstance(v, str):
                                        col.replace(exp.Literal.string(v))
                                    else:
                                        col.replace(exp.Literal.number(v))

                    subq_parsed_v = parse_sql_to_ast(select_node_v.sql())
                    subq_data_v = generate_base_dataset(
                        schema, subq_parsed_v, cache_key_salt=f"semi_join_violated_{len(datasets)}"
                    )
                    # In exists_violated, we want NO matching witness for the outer row.
                    # Therefore, tables in inner_tables must take their rows from subq_data_v
                    # (which has the violated non-matching key) and NOT retain matching rows from base_data.
                    merged_v = {t_name: [] for t_name in schema.tables}
                    inner_tbl_names = {t.upper() for t in inner_tables.values()}
                    for t_name, rows in base_data.items():
                        if t_name.upper() not in inner_tbl_names:
                            merged_v[t_name].extend(copy.deepcopy(rows))
                    for t_name, rows in subq_data_v.items():
                        if t_name.upper() in inner_tbl_names:
                            merged_v[t_name].extend(copy.deepcopy(rows))
                        else:
                            for r in rows:
                                if r not in merged_v[t_name]:
                                    merged_v[t_name].append(r)
                    from dataset_generator.uniqueness import ensure_dataset_uniqueness
                    merged_v = ensure_dataset_uniqueness(schema, merged_v)
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_exists_violated",
                            data=merged_v,
                            tags=["semi_join", "exists"],
                            description=(
                                "Targets Semi-Join EXISTS omission bugs. Dataset breaks the correlation key "
                                "so no matching witness exists in the subquery. The correct query's semi-join "
                                "evaluates to FALSE (filtering outer rows out), while a mutant omitting EXISTS "
                                "erroneously admits the outer rows."
                            ),
                        )
                    )
                except Exception:
                    pass

        return datasets
