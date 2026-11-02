"""
This strategy targets semantic errors where a standard JOIN's cardinality (one-to-many relationship)
is incorrectly modified by replacing the JOIN with a semi-join (IN/EXISTS subquery), or by adding
redundant DISTINCT clauses or aggregate DISTINCT modifiers (e.g. COUNT(DISTINCT col)).

Algorithm & Dataset Design:
1. It identifies all standard (non-subquery) joins in the correct query.
2. For each join, it maps the tables and aliases involved via on-pairs.
3. For each side (Left and Right) of the join, it determines the join columns.
4. It checks whether the join columns on that side are NOT part of any primary key or unique constraint.
5. If the join column(s) on a table can be duplicated without violating UNIQUE/PK constraints:
   a. It generates a base dataset where all join conditions and filters are satisfied.
   b. It replicates the row corresponding to the targeted alias in that table.
   c. In the duplicated row, it generates new unique values for all primary key and unique columns,
      while preserving the join columns and other non-unique attributes.
   d. It appends the duplicated row to that table, creating a one-to-many join relationship instance.
6. The resulting dataset guarantees that:
   - The correct query (which performs the full JOIN and respects duplicates) will produce a larger result cardinality or count.
   - The mutant query (which collapses duplicates using IN, DISTINCT, etc.) will produce a smaller result cardinality or count.
"""

from datetime import timedelta
from typing import Any, Dict, List
import copy
from dateutil.parser import parse as dateutil_parse
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import (
    distinct_satisfying_disjunctive_row_overrides,
    distinct_satisfying_where_value,
)
from dataset_generator.utils import is_unique_column_set, resolve_query_column
from dataset_generator import (
    build_equivalence_classes,
    differentiate_conditional_aggregates_across_groups,
    generate_base_dataset,
    merge_datasets,
)

class JoinCardinalityAttackStrategy(AttackStrategy):
    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        # Applicable if the correct query contains any standard (non-subquery) joins or where joins.
        has_explicit_join = any(j.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY") for j in parsed_query.get("joins", []))
        has_where_join = len(parsed_query.get("where_joins", [])) > 0
        return has_explicit_join or has_where_join

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        
        # 1. Build alias-to-table mapping
        alias_to_table = self.get_alias_to_table(schema, parsed_query)

        # 2. Iterate through joins to identify target tables to duplicate
        all_on_pairs = []
        for join in parsed_query.get("joins", []):
            if join.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                continue
            all_on_pairs.extend(join.get("on_pairs", []))
            
        for wj in parsed_query.get("where_joins", []):
            all_on_pairs.append(wj)

        if all_on_pairs:
            # Collect join columns for each table/alias involved in this join
            # We map: alias -> set of column names
            alias_to_join_cols = {}
            for pair in all_on_pairs:
                for side in ["left", "right"]:
                    alias = pair[side]["table"]
                    col = pair[side]["column"]
                    if not alias or alias not in alias_to_table:
                        resolved = resolve_query_column(schema, parsed_query, alias, col)
                        if resolved:
                            t_name, col = resolved
                            matching = [a for a, t in alias_to_table.items() if t == t_name]
                            alias = matching[0] if matching else t_name
                    if alias not in alias_to_join_cols:
                        alias_to_join_cols[alias] = set()
                    alias_to_join_cols[alias].add(col)
                    
            # For each alias involved, see if we can duplicate it
            for alias, join_cols in alias_to_join_cols.items():
                raw_table_name = alias_to_table.get(alias)
                if not raw_table_name:
                    continue
                canon_name = schema.find_table(raw_table_name)
                if not canon_name:
                    continue
                table_name = canon_name
                table = schema.tables[table_name]
                
                # Check if join columns form a unique key for this table
                actual_join_cols = []
                for col in table.columns:
                    if col.name.upper() in [jc.upper() for jc in join_cols]:
                        actual_join_cols.append(col.name)
                        
                if is_unique_column_set(schema, table_name, actual_join_cols):
                    # If join columns form a unique key for this table, we cannot duplicate
                    # rows in this table without violating unique/PK constraints or join semantics
                    continue
                    
                # Generate base dataset (Group 1 - Row A)
                base_data = generate_base_dataset(
                    schema, parsed_query, cache_key_salt="join_group_1_a", include_limit_padding=False
                )
                if table_name not in base_data or not base_data[table_name]:
                    continue
                    
                # Generate a second independent dataset (Group 1 - Row B)
                group1_b_data = generate_base_dataset(
                    schema, parsed_query, cache_key_salt="join_group_1_b", include_limit_padding=False
                )
                
                # Generate a third independent dataset (Group 2)
                group2_data = generate_base_dataset(
                    schema, parsed_query, cache_key_salt="join_group_2", include_limit_padding=False
                )
                equiv, _, _ = build_equivalence_classes(schema, parsed_query)
                differentiate_conditional_aggregates_across_groups(
                    schema, parsed_query, equiv, set(), base_data, group2_data
                )
                differentiate_conditional_aggregates_across_groups(
                    schema, parsed_query, equiv, set(), group1_b_data, group2_data
                )
                    
                # Find the row index corresponding to this alias
                aliases_for_table = [a for a, t in alias_to_table.items() if schema.find_table(t) == table_name]
                if alias not in aliases_for_table:
                    continue
                target_idx = aliases_for_table.index(alias)
                if target_idx >= len(base_data[table_name]) or target_idx >= len(group1_b_data[table_name]):
                    continue
                    
                # The original row (Row A)
                original_row = base_data[table_name][target_idx]
                
                # The duplicate row (Row B) from the second dataset
                duplicate_row = copy.deepcopy(group1_b_data[table_name][target_idx])
                
                if is_unique_column_set(schema, table_name, actual_join_cols):
                    continue

                # Force the duplicate row to join with the original group by copying join columns
                for col_name in actual_join_cols:
                    duplicate_row[col_name] = original_row[col_name]

                pk_cols = [c for c in table.columns if c.is_primary_key]
                if pk_cols:
                    pk_orig = tuple(original_row.get(c.name) for c in pk_cols)
                    pk_dup = tuple(duplicate_row.get(c.name) for c in pk_cols)
                    if None not in pk_orig and pk_orig == pk_dup:
                        join_cols_upper = {jc.upper() for jc in actual_join_cols}
                        disj_overrides = distinct_satisfying_disjunctive_row_overrides(
                            schema, parsed_query, table_name, original_row, join_cols_upper
                        )
                        if disj_overrides:
                            duplicate_row.update(disj_overrides)
                        else:
                            for pk_col in pk_cols:
                                if pk_col.name.upper() in join_cols_upper:
                                    continue
                                alt_pk_val = distinct_satisfying_where_value(
                                    schema, parsed_query, table_name, pk_col, original_row, duplicate_row, allow_in_select=True
                                )
                                if alt_pk_val is not None and alt_pk_val != original_row.get(pk_col.name):
                                    duplicate_row[pk_col.name] = alt_pk_val
                                    break

                ast = parsed_query.get("ast")
                if ast:
                    range_col_names = set()
                    for comp in ast.find_all((exp.Between, exp.GT, exp.GTE, exp.LT, exp.LTE)):
                        for c_node in comp.find_all(exp.Column):
                            res_c = resolve_query_column(schema, parsed_query, c_node.table or "", c_node.name)
                            if res_c and res_c[0] == table_name:
                                range_col_names.add(res_c[1])
                    for rc in range_col_names:
                        rc_obj = schema.find_column(table_name, rc)
                        if rc_obj and not rc_obj.is_primary_key and not rc_obj.is_unique and rc in original_row:
                            duplicate_row[rc] = original_row[rc]

                # If duplicate_row is still identical to original_row, vary an unconstrained non-join, non-FK, non-PK column
                if duplicate_row == original_row:
                    for col in table.columns:
                        if col.name.upper() not in [jc.upper() for jc in actual_join_cols] and not col.is_primary_key and not col.is_unique:
                            is_fk = any(fk.column_name.upper() == col.name.upper() for fk in table.foreign_keys)
                            if not is_fk and col.name in duplicate_row and col.name in original_row:
                                if col.is_temporal:
                                    try:
                                        d = dateutil_parse(str(original_row[col.name])) + timedelta(days=1)
                                        duplicate_row[col.name] = d.strftime('%Y-%m-%d')
                                    except Exception:
                                        pass
                            
                # Append duplicate row safely
                duplicate_dataset = {table_name: [duplicate_row]}
                base_data = merge_datasets(schema, base_data, duplicate_dataset)
                
                # Append Group 2 data safely
                base_data = merge_datasets(schema, base_data, group2_data)
                
                # Append dataset
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_{table_name}_{alias}",
                        data=base_data,
                        tags=["join_cardinality_attack"],
                        description=f"Targets Join Cardinality bugs. Dataset introduces an extra, duplicate matching row for `{table_name}` (alias `{alias}`) and a second disjoint group. By explicitly causing a one-to-many join explosion with distinct non-join values, it ensures the correct query's aggregation or deduplication handles the multiplied rows properly, catching redundant DISTINCTs even with ORDER BY and LIMIT."
                    )
                )
                
        return datasets
