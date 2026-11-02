"""
AggregateDistinctColumnAttackStrategy Module

Target semantic bug: Incorrect column referenced inside COUNT(DISTINCT col).
Algorithm & Dataset Design:
Populates distinct values across multiple columns so that applying COUNT(DISTINCT col1) vs COUNT(DISTINCT col2)
produces different scalar counts.
"""

from typing import Any, Dict, List
import copy

import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column


class AggregateDistinctColumnAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Mismatched column inside an aggregate DISTINCT (e.g., COUNT(DISTINCT A) mutated to COUNT(DISTINCT B)).

    Algorithm & Dataset Design:
    This strategy identifies aggregate calls in the correct query AST that contain a DISTINCT column.
    For each target, it generates two groups of rows that satisfy the query constraints, but explicitly
    forces the targeted column to have the SAME value in both groups. All other non-targeted columns
    will receive independent, unique values across the two groups.
    As a result, COUNT(DISTINCT target) will evaluate to 1, while COUNT(DISTINCT other_column) will
    evaluate to 2, effectively catching mutants that aggregate over the wrong column.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query))

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query, read="sqlite")
        except Exception:
            return []

        targets = []
        for node in ast.find_all(exp.AggFunc):
            arg = node.this
            if not arg or not isinstance(arg, exp.Distinct):
                continue
            
            arg_distinct = arg.this
            col_node = None
            if isinstance(arg_distinct, exp.Column):
                col_node = arg_distinct
            elif hasattr(arg, "expressions") and arg.expressions:
                first_expr = arg.expressions[0]
                if isinstance(first_expr, exp.Column):
                    col_node = first_expr

            if not col_node:
                continue

            resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if not resolved:
                continue
            
            table_name, column_name = resolved
            table = schema.tables.get(table_name)
            if not table:
                continue
            
            column = next((c for c in table.columns if c.name == column_name), None)
            if column and not (column.is_primary_key or column.is_unique):
                target = (table_name, column_name)
                if target not in targets:
                    targets.append(target)
        return targets

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        for table_name, column_name in self._targets(schema, parsed_query):
            
            # Check if this column is part of the GROUP BY clause
            is_group_by = False
            for term in parsed_query.get("group_by", []):
                resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
                if resolved and resolved == (table_name, column_name):
                    is_group_by = True
                    break

            if is_group_by:
                continue

            # Group 1
            group1 = generate_base_dataset(schema, parsed_query)
            if not group1.get(table_name):
                continue
                
            val = group1[table_name][0][column_name]
            
            # Group 2 with the same value for the target column
            group2 = generate_base_dataset(schema, parsed_query, value_injections={(table_name, column_name): val})
            
            mock_data = {t_name: [] for t_name in schema.tables}
            for g in [group1, group2]:
                for t_name in mock_data:
                    if t_name in g:
                        mock_data[t_name].extend(copy.deepcopy(g[t_name]))

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}",
                    data=mock_data,
                    tags=["aggregate_attack", "distinct_attack"],
                    description=f"Targets Wrong Aggregate Distinct bugs. Dataset includes two groups of rows. In both groups, the targeted column `{table_name}.{column_name}` is assigned the identical value. The other non-targeted columns are assigned unique values. A mutant that applies DISTINCT to `{table_name}.{column_name}` will correctly count 1 for this column in each group, but if it incorrectly applies DISTINCT to another column, it will count 2. This catches bugs where the column inside the DISTINCT aggregation is mistakenly modified to a different column."
                )
            )
            
        return datasets
