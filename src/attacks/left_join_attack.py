"""
JoinTypeAttackStrategy Module

Target semantic bug: Incorrect join type (e.g. INNER JOIN instead of LEFT OUTER JOIN).
Algorithm & Dataset Design:
Injects left-table rows with no matching right-table rows. LEFT JOIN retains the unmatched left row with NULLs,
whereas INNER JOIN drops the unmatched left row, catching join type mutations.
"""

from typing import Any, Dict, List
import copy

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, deduplicate_mock_data

class JoinTypeAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Incorrect join type (e.g., using INNER JOIN instead of LEFT JOIN).

    Algorithm & Dataset Design:
    This strategy identifies LEFT JOIN clauses in the gold query.
    For each LEFT JOIN, it generates a dataset containing:
    1. A base row that perfectly satisfies the join condition (INNER JOIN match).
    2. A violating row where the join condition is intentionally broken by generating
       disjoint values for the join keys (by temporarily removing the ON clause).
    The correct LEFT JOIN query will return both rows (with NULLs for the right table in the second row),
    whereas a mutant INNER JOIN query will filter out the second row, resulting in a difference.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return any(join.get("type", "").upper() == "LEFT" for join in parsed_query.get("joins", []))

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        joins = parsed_query.get("joins", [])
        
        for idx, join in enumerate(joins):
            if join.get("type", "").upper() != "LEFT":
                continue
                
            if not join.get("on_pairs"):
                continue
                
            modified_query = copy.deepcopy(parsed_query)
            # Remove the ON condition to force disjoint values
            modified_query["joins"][idx]["on_pairs"] = []
            
            base_data = generate_base_dataset(schema, parsed_query, cache_key_salt=f"base_left_{idx}")
            violating_data = generate_base_dataset(schema, modified_query, cache_key_salt=f"violating_left_{idx}")
            
            merged_data = {t_name: [] for t_name in schema.tables}
            for t_name in merged_data:
                if t_name in base_data:
                    merged_data[t_name].extend(copy.deepcopy(base_data[t_name]))
                if t_name in violating_data:
                    merged_data[t_name].extend(copy.deepcopy(violating_data[t_name]))
                    
            merged_data = deduplicate_mock_data(schema, merged_data)
            
            table_name = join.get("table", "unknown")
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{idx}",
                    data=merged_data,
                    tags=["left_join_attack"],
                    description=f"Targets Join Type bugs (LEFT vs INNER). Dataset includes a matching row and an unmatched left row for the LEFT JOIN on `{table_name}`. A correct LEFT JOIN returns the unmatched row with NULLs, whereas an INNER JOIN drops it."
                )
            )
            
        return datasets
