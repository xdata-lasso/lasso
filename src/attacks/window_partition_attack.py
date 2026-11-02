"""
WindowPartitionAttackStrategy Module

Target semantic bug:
Missing PARTITION BY in a window function.

Algorithm & Dataset Design:
The strategy finds window functions with concrete PARTITION BY columns in the
correct query. It generates two rows with different partition-key values and
ordered, distinct measure values. With PARTITION BY present, each partition's
window state starts independently; without it, the second row observes state
from the first partition. This makes missing partition semantics observable
for row-number style and cumulative aggregate windows without inspecting the
mutant query.
"""

from typing import Any, Dict, List

import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, next_distinct_value, resolve_query_column, merge_datasets


class WindowPartitionAttackStrategy(AttackStrategy):

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._windows(schema, parsed_query))

    def _windows(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[dict[str, Any]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        windows = []
        for window in ast.find_all(exp.Window):
            partitions = []
            for expr in window.args.get("partition_by") or []:
                if isinstance(expr, exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, expr.table, expr.name)
                    if resolved:
                        partitions.append(resolved)
            order_bys = []
            order_spec = window.args.get("order")
            if order_spec:
                for expr in order_spec.find_all(exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, expr.table, expr.name)
                    if resolved:
                        order_bys.append(resolved)
            if partitions or order_bys:
                windows.append({"partition_by": partitions, "order_by": order_bys, "function": window.this})
        return windows

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        for window_index, window in enumerate(self._windows(schema, parsed_query)):
            first_group = generate_base_dataset(schema, parsed_query, cache_key_salt="win_first")
            second_group = generate_base_dataset(schema, parsed_query, cache_key_salt="win_second")

            for table_name, column_name in window["partition_by"]:
                if not first_group.get(table_name) or not second_group.get(table_name):
                    continue
                column = next(c for c in schema.tables[table_name].columns if c.name == column_name)
                first_value = first_group[table_name][0][column_name]
                second_group[table_name][0][column_name] = next_distinct_value(column, first_value)

            function = window["function"]
            if isinstance(function, exp.Sum) and isinstance(function.this, exp.Column):
                resolved = resolve_query_column(schema, parsed_query, function.this.table, function.this.name)
                if resolved:
                    table_name, column_name = resolved
                    if first_group.get(table_name) and second_group.get(table_name):
                        first_group[table_name][0][column_name] = 2
                        second_group[table_name][0][column_name] = 5

            mock_data = merge_datasets(schema, first_group, second_group)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{window_index}",
                    data=mock_data,
                    tags=["window_partition_attack"],
                    description="Targets Missing PARTITION BY bugs. Dataset generates rows precisely divided into two distinct window partitions based on the partitioning keys. If a mutant incorrectly omits the PARTITION BY clause, the window function will erroneously aggregate over all rows as a single group, producing mismatched window calculation results."
                )
            )

        return datasets
