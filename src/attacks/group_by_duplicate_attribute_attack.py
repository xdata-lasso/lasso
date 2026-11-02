"""
GroupByDuplicateAttributeAttackStrategy Module

Target semantic bug: Grouping by non-key or display attributes instead of primary/entity grouping keys.
Algorithm & Dataset Design:
1. Identifies GROUP BY grouping key columns and non-grouped projected/joined attributes in the query.
2. Injects duplicate values for non-grouped attributes across distinct key groups.
3. For a correct query grouping by true key(s), the distinct keys evaluate to separate groups (N rows).
4. For a mutant query erroneously grouping by non-key attribute(s), the duplicate attribute values collapse the groups into fewer rows (1 row), catching the bug.
"""

from typing import Any, Dict, List, Set, Tuple
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    differentiate_conditional_aggregates_across_groups,
    generate_base_dataset,
    resolve_query_column,
    deduplicate_mock_data,
)


class GroupByDuplicateAttributeAttackStrategy(AttackStrategy):
    """
    Targets semantic bugs where a mutant groups by non-key/display attributes instead of primary grouping keys,
    or omits grouping keys while grouping by associated non-unique columns.

    Algorithm:
    1. Parse the AST to find all GROUP BY target columns across the query (including subqueries).
    2. Parse the AST to find non-grouped projected or ordered attributes in the SELECT/ORDER BY clauses.
    3. Filter out attributes that are primary keys or unique constraints (since PKs must be unique per row).
    4. For each candidate non-grouped attribute:
       - Generate group1 base dataset with salt 'gb_attr_dup_1'.
       - Extract the non-grouped attribute's value from group1.
       - Generate group2 base dataset with salt 'gb_attr_dup_2', injecting group1's attribute value into group2.
       - Populate contrasting conditional aggregate values across group1 and group2 so merging vs. splitting
         groups yields distinct aggregate values even under ORDER BY ... LIMIT 1.
       - Merge group1 and group2 so that group1 and group2 have distinct grouping key values but identical non-grouped attribute values.
    5. Correct query outputs separate rows/aggregates for group1 and group2 (2 groups), while mutant query grouping by the attribute merges group1 and group2 into 1 group.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        has_gb = bool(parsed_query.get("group_by", []))
        if has_gb:
            return True
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
            return bool(list(ast.find_all(exp.Group)))
        except Exception:
            return False

    def _get_group_by_columns(self, schema: Schema, parsed_query: Dict[str, Any]) -> Set[Tuple[str, str]]:
        gb_cols = set()
        for term in parsed_query.get("group_by", []):
            resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if resolved:
                gb_cols.add(resolved)

        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
            for group in ast.find_all(exp.Group):
                for expr in group.expressions:
                    for col in expr.find_all(exp.Column):
                        resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                        if resolved:
                            gb_cols.add(resolved)
        except Exception:
            pass

        return gb_cols

    def _get_candidate_non_grouped_attributes(
        self, schema: Schema, parsed_query: Dict[str, Any], gb_cols: Set[Tuple[str, str]]
    ) -> List[Tuple[str, str]]:
        candidates = []
        seen = set()

        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            ast = None

        if ast:
            for sel in ast.find_all(exp.Select):
                agg_aliases = {
                    e.alias.upper()
                    for e in (sel.expressions or [])
                    if isinstance(e, exp.Alias) and e.alias and list(e.find_all(exp.AggFunc))
                }
                target_exprs = list(sel.expressions or [])
                order_node = sel.args.get("order")
                if order_node and order_node.expressions:
                    target_exprs.extend(order_node.expressions)

                for expr in target_exprs:
                    # Ignore aggregate functions (e.g. SUM(salary), AVG(salary), COUNT(*))
                    if list(expr.find_all(exp.AggFunc)):
                        continue
                    for col in expr.find_all(exp.Column):
                        if not col.table and col.name and col.name.upper() in agg_aliases:
                            continue
                        resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                        if resolved and resolved not in gb_cols and resolved not in seen:
                            seen.add(resolved)
                            t_name, c_name = resolved
                            if t_name in schema.tables:
                                table = schema.tables[t_name]
                                # Ensure it's not a primary key or unique key column
                                is_pk_or_unique = any(
                                    c.name.lower() == c_name.lower() and (c.is_primary_key or c.is_unique)
                                    for c in table.columns
                                )
                                if not is_pk_or_unique:
                                    candidates.append(resolved)

        return candidates

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        gb_cols = self._get_group_by_columns(schema, parsed_query)
        candidates = self._get_candidate_non_grouped_attributes(schema, parsed_query, gb_cols)

        if not candidates:
            return []

        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        datasets = []
        for table_name, column_name in candidates:
            group1 = generate_base_dataset(schema, parsed_query, cache_key_salt=f"gb_dup_{table_name}_{column_name}_1")

            if not group1.get(table_name) or not group1[table_name]:
                continue

            val = group1[table_name][0].get(column_name)
            if val is None:
                continue

            for r in group1[table_name]:
                r[column_name] = val

            value_injections = {(table_name, column_name): val}
            group2 = generate_base_dataset(
                schema, parsed_query, value_injections=value_injections, cache_key_salt=f"gb_dup_{table_name}_{column_name}_2"
            )

            differentiate_conditional_aggregates_across_groups(
                schema,
                parsed_query,
                equiv,
                gb_cols | {(table_name, column_name)},
                group1,
                group2,
            )

            merged_data = {t_name: [] for t_name in schema.tables}
            for g in [group1, group2]:
                for t_name in merged_data:
                    if t_name in g:
                        merged_data[t_name].extend(copy.deepcopy(g[t_name]))

            merged_data = deduplicate_mock_data(schema, merged_data)

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}",
                    data=merged_data,
                    tags=["group_by_attack", "duplicate_attribute_attack"],
                    description=(
                        f"Targets Group By non-key attribute bugs. Dataset forces identical non-grouped attribute values "
                        f"(`{table_name}.{column_name}`) across distinct grouping key groups. A correct query grouping by key "
                        f"evaluates to multiple group rows, whereas a mutant query grouping by `{table_name}.{column_name}` "
                        f"improperly collapses them into a single group row."
                    )
                )
            )

        return datasets
