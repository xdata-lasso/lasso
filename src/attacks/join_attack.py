"""
JoinAttackStrategy Module

Target semantic bugs: Join Condition Mismatch, Join Type Mismatch, Unmatched Join Tables.
Algorithm & Dataset Design:
Generates datasets with matching join rows alongside omitted table datasets.
INNER JOINs fail when any table row is missing (yielding 0 rows), exposing join condition/type mutations.
"""

from typing import Any, Dict, List
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, build_alias_to_table

class JoinAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Join Condition Mismatch, Join Type Mismatch.
    Generates perfectly matching base rows (which kills condition mismatch because non-equated columns are distinct).
    Then generates datasets with exactly one table's row omitted. The omitted rows will break the join for that
    table, which perfectly distinguishes INNER vs OUTER joins.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        alias_to_table = build_alias_to_table(parsed_query)
        has_joins = any(j.get("type") not in ("IN_SUBQUERY", "EQ_SUBQUERY") for j in parsed_query.get("joins", []))
        return has_joins and len(alias_to_table) > 1

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []

        # Omitted-alias datasets to test JOIN TYPE mismatch
        alias_to_table = build_alias_to_table(parsed_query)
        if len(alias_to_table) > 1:
            for alias in alias_to_table.keys():
                # We can skip generating an omitted dataset if it's the ONLY table in the query,
                # but we already check len > 1.
                omitted_data = generate_base_dataset(schema, parsed_query, omit_aliases=[alias])
                
                # Check if omitted_data is completely empty for all tables
                # This could happen if there was only 1 alias and we omitted it, 
                # but len > 1 guarantees at least one other table remains.
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_omit_{alias}",
                        data=omitted_data,
                        tags=["join_attack", "join_type"],
                        description=f"Targets Join Type bugs. Dataset deliberately omits any matching rows for alias `{alias}`. This ensures that an OUTER JOIN behaves correctly by producing a NULL-extended row, whereas an incorrect INNER JOIN mutant will eliminate the row entirely, directly testing the specific JOIN type semantics."
                    )
                )

        return datasets
