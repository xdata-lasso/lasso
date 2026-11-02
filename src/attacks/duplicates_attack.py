"""
DuplicatesAttackStrategy Module

Target semantic bug: Missing GROUP BY.
Algorithm & Dataset Design:
Builds two base joined tuples and forces their group-key values to be distinct. A correct grouped
aggregate returns one result per group, while a mutant that removes GROUP BY collapses those groups into one.
"""

from typing import Any, Dict, List

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


class DuplicatesAttackStrategy(AttackStrategy):
    """
    Target semantic bug: missing GROUP BY.

    Algorithm & Dataset Design:
    For each concrete GROUP BY column in the correct query, this strategy builds
    two base joined tuples and forces their group-key values to be distinct. A
    correct grouped aggregate can therefore return one result per group, while a
    mutant that removes GROUP BY collapses those groups into one aggregate result
    or raises an execution error. The strategy no longer targets DISTINCT; that
    responsibility belongs only to DistinctAttackStrategy.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._group_targets(schema, parsed_query))

    def _group_targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        targets = []
        for term in parsed_query.get("group_by", []):
            resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if resolved:
                targets.append(resolved)
        return targets

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        targets = self._group_targets(schema, parsed_query)
        if not targets:
            return []

        first_group = generate_base_dataset(schema, parsed_query, cache_key_salt="dup_first")
        second_group = generate_base_dataset(schema, parsed_query, cache_key_salt="dup_second")
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        for table_name, column_name in targets:
            table = schema.tables[table_name]
            column = next(c for c in table.columns if c.name == column_name)
            if not first_group.get(table_name) or not second_group.get(table_name):
                continue
            existing = first_group[table_name][0][column_name]
            old_second = second_group[table_name][0].get(column_name)
            if old_second == existing:
                new_val = next_distinct_value(column, existing, schema=schema, table_name=table_name)
                target_root = equiv.find(col_key(table_name, column_name))
                for t_name, rows in second_group.items():
                    if not rows or t_name not in schema.tables:
                        continue
                    for col in schema.tables[t_name].columns:
                        if equiv.find(col_key(t_name, col.name)) == target_root:
                            for r in rows:
                                if r.get(col.name) == old_second:
                                    r[col.name] = new_val

        mock_data = merge_datasets(schema, first_group, second_group)

        return [
            Dataset(
                strategy_name=self.__class__.__name__,
                data=mock_data,
                tags=["duplicates_attack"],
                description="Targets Group Collapse bugs. Dataset injects two completely distinct sets of GROUP BY keys (two different groups). A correct query will output two aggregated rows, whereas a mutant that incorrectly removes the GROUP BY clause (or aggregates the whole table) will collapse them into a single row."
            )
        ]
