"""
JoinOperatorAttackStrategy Module
=================================

Target semantic bugs:
  - Join comparison operator mutations (e.g. replacing `=` with `>=`, `<=`, `<>`, `>`, `<`
    in JOIN ON or WHERE join conditions).

Algorithm & Dataset Design:
  In relational algebra, an equi-join R |><|_(R.A = S.B) S matches only tuples where R.A == S.B.
  Baseline data generation creates matching tuples where R.A == S.B. However, on such data:
    - If the join operator is mutated to `>=` or `<=`, the condition still holds (since equality implies >= and <=).
    - If the join operator is mutated to `<>`, matching tuples fail to join, but without alternative tuples,
      both queries might diverge or fail to test boundary behavior cleanly.
  
  To kill mutants that change the join comparison operator from `=` to an inequality:
  1. It identifies all join attribute equality pairs between distinct table aliases (from JOIN ON and WHERE clauses).
  2. For each join attribute, it clones a row and injects:
     a. A strictly greater value (R.A > S.B, e.g. V + 10 or next distinct value).
        Under this dataset, mutants with `>=` or `<>` will join this extra tuple, producing excess rows,
        whereas the correct equi-join strictly excludes it.
     b. A strictly smaller value (R.A < S.B, e.g. V - 10 or previous distinct value).
        Under this dataset, mutants with `<=` or `<>` will join this extra tuple, producing excess rows,
        whereas the correct equi-join strictly excludes it.
  3. Non-join primary key and unique columns on the cloned row are given fresh unique identifiers to maintain
     referential and entity integrity.
"""

from typing import Any, Dict, List
import copy

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column, next_distinct_value
from dataset_generator.value_generator import generate_unique_value_for_column


class JoinOperatorAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Join Condition Operator mutations (= to >=, <=, <>, etc.).
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        all_pairs = []
        for j in parsed_query.get("joins", []):
            if j.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                all_pairs.extend(j.get("on_pairs", []))
        all_pairs.extend(parsed_query.get("where_joins", []))

        return len(all_pairs) > 0

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        all_pairs = []
        for j in parsed_query.get("joins", []):
            if j.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                all_pairs.extend(j.get("on_pairs", []))
        all_pairs.extend(parsed_query.get("where_joins", []))

        if not all_pairs:
            return datasets

        base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="join_op_base")

        seen_targets = set()
        for pair in all_pairs:
            l_info = pair.get("left", {})
            r_info = pair.get("right", {})
            lt_alias = l_info.get("table", "")
            rt_alias = r_info.get("table", "")
            lc_name = l_info.get("column", "")
            rc_name = r_info.get("column", "")

            resolved_l = resolve_query_column(schema, parsed_query, lt_alias, lc_name)
            resolved_r = resolve_query_column(schema, parsed_query, rt_alias, rc_name)
            if not resolved_l or not resolved_r:
                continue

            l_tbl, l_col = resolved_l
            r_tbl, r_col = resolved_r

            # Must be different tables or aliases
            if (l_tbl, l_col) == (r_tbl, r_col) and lt_alias == rt_alias:
                continue

            target_key = (l_tbl, l_col)
            if target_key in seen_targets:
                continue
            seen_targets.add(target_key)

            if l_tbl not in base_data or not base_data[l_tbl]:
                continue

            orig_row = base_data[l_tbl][0]
            curr_val = orig_row.get(l_col)
            if curr_val is None:
                continue

            col_obj = schema.find_column(l_tbl, l_col)
            table_obj = schema.tables.get(l_tbl)
            if not table_obj or not col_obj:
                continue

            # Compute strictly greater and strictly smaller values
            greater_val = None
            smaller_val = None

            if isinstance(curr_val, (int, float)):
                offset = 10 if isinstance(curr_val, int) else 10.0
                greater_val = curr_val + offset
                smaller_val = curr_val - offset
            elif isinstance(curr_val, str):
                greater_val = curr_val + "_z"
                smaller_val = curr_val[:max(1, len(curr_val) - 1)] if len(curr_val) > 1 else "A"
            else:
                greater_val = next_distinct_value(col_obj, curr_val, schema=schema, table_name=l_tbl)

            # Generate Greater dataset (catches >= and <>)
            if greater_val is not None:
                data_greater = copy.deepcopy(base_data)
                cloned_row = copy.deepcopy(orig_row)
                cloned_row[l_col] = greater_val
                for c in table_obj.columns:
                    if (c.is_primary_key or c.is_unique) and c.name != l_col:
                        cloned_row[c.name] = generate_unique_value_for_column(c)
                data_greater[l_tbl].append(cloned_row)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_greater_{l_tbl}_{l_col}",
                        data=data_greater,
                        tags=["join_operator", "greater"],
                        description=(
                            f"Targets Join Operator mutations on `{l_tbl}.{l_col}`. Dataset injects an extra row "
                            f"with a strictly greater join key value ({greater_val} > {curr_val}). A correct equi-join "
                            f"excludes this row, whereas a mutant relaxing the join operator to `>=` or `<>` "
                            f"erroneously joins it, causing cardinality/row mismatch."
                        )
                    )
                )

            # Generate Smaller dataset (catches <= and <>)
            if smaller_val is not None:
                data_smaller = copy.deepcopy(base_data)
                cloned_row = copy.deepcopy(orig_row)
                cloned_row[l_col] = smaller_val
                for c in table_obj.columns:
                    if (c.is_primary_key or c.is_unique) and c.name != l_col:
                        cloned_row[c.name] = generate_unique_value_for_column(c)
                data_smaller[l_tbl].append(cloned_row)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_smaller_{l_tbl}_{l_col}",
                        data=data_smaller,
                        tags=["join_operator", "smaller"],
                        description=(
                            f"Targets Join Operator mutations on `{l_tbl}.{l_col}`. Dataset injects an extra row "
                            f"with a strictly smaller join key value ({smaller_val} < {curr_val}). A correct equi-join "
                            f"excludes this row, whereas a mutant relaxing the join operator to `<=` or `<>` "
                            f"erroneously joins it, causing cardinality/row mismatch."
                        )
                    )
                )

        return datasets
