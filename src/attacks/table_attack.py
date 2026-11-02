"""
TableAttackStrategy Module

Target semantic bugs: Table Mismatch, Table Missing, Spurious Outer/Parent JOINs.
Algorithm & Dataset Design:
Populates all tables in schema with distinct, globally unique values and injects unmatched parent rows.
Any mutant that queries a wrong table, omits a table, or adds unneeded outer joins will produce altered data.
"""

import copy
from typing import Any, Dict, List
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator import generate_base_dataset

from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.uniqueness import ensure_dataset_uniqueness

class TableAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Table Mismatch, Table Missing, Spurious Outer/Parent JOINs.
    By populating all tables with distinct, globally unique values and injecting unmatched
    parent rows for schema parent tables, any query that accesses a different table,
    omits a table, or adds an unneeded outer join to a parent table will return fundamentally
    different data.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for t_obj in schema.tables.values():
            if t_obj.foreign_keys:
                return True
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []

        # Unmatched parent table attack dataset
        parent_tables = set()
        for t_name, t_obj in schema.tables.items():
            for fk in t_obj.foreign_keys:
                parent_tables.add(fk.reference_table)

        if parent_tables:
            unmatched_data = generate_base_dataset(schema, parsed_query, cache_key_salt="table_unmatched_parent")
            has_added = False
            for p_name in parent_tables:
                if p_name in unmatched_data and unmatched_data[p_name]:
                    p_obj = schema.tables.get(p_name)
                    if not p_obj:
                        continue
                    unique_cols = [c for c in p_obj.columns if c.is_primary_key or c.is_unique]
                    if unique_cols:
                        new_row = copy.deepcopy(unmatched_data[p_name][-1])
                        for u_col in unique_cols:
                            val = generate_unique_value_for_column(u_col)
                            val = solve_check_constraint_value(schema, p_name, u_col.name, u_col, val, row_context=new_row)
                            new_row[u_col.name] = val
                        for col in p_obj.columns:
                            if col not in unique_cols:
                                new_row[col.name] = solve_check_constraint_value(
                                    schema, p_name, col.name, col, new_row[col.name], row_context=new_row
                                )
                        unmatched_data[p_name].append(new_row)
                        has_added = True

            if has_added:
                unmatched_data = ensure_dataset_uniqueness(schema, unmatched_data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_unmatched_parent",
                        data=unmatched_data,
                        tags=["table_attack", "unmatched_parent"],
                        description="Targets Spurious Parent Table / Outer Join bugs. Dataset injects unmatched parent rows into parent tables. A correct query referencing child tables or inner joins ignores these rows, whereas a mutant that improperly adds a LEFT JOIN or extra parent table reference includes them."
                    )
                )

        return datasets

