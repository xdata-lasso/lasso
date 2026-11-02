"""
LikeVsEqualAttackStrategy Module

Target semantic bug: Substituting LIKE pattern matching with exact equality (`=`) or vice versa.
Algorithm & Dataset Design:
Injects string values that satisfy LIKE predicates (either via wildcard expansion when `%` or `_` is present,
or via case-inverted ASCII characters under SQLite's case-insensitive LIKE semantics when no wildcards are present)
while failing exact case-sensitive string equality (`=`).
"""

from typing import Any, Dict, List
import copy

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator.value_generator import value_matching_like_pattern
from dataset_generator import generate_base_dataset, resolve_query_column, deduplicate_mock_data

class LikeVsEqualAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Using EQUAL (=) instead of LIKE, or vice versa.

    Algorithm & Dataset Design:
    This strategy finds all string literals used with the LIKE / ILIKE operator in the query.
    For each such literal pattern:
      1. If the pattern contains wildcards ('%' or '_'), it generates a string that satisfies
         the wildcard pattern but is not equal to the raw pattern literal (e.g. 'Appa' for 'App%').
      2. If the pattern contains no wildcards but has cased characters (e.g. 'Emil Blonsky'),
         it inverts the character casing ('eMIL bLONSKY'), which satisfies SQLite's case-insensitive
         LIKE operator while failing case-sensitive equality (=).
    In both cases, all other predicates and joins in the query are preserved so that a query
    using LIKE matches the row while a mutant substituting = fails to match.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for literal in parsed_query.get("where_literals", []):
            if literal.get("operator", "").upper() in ("LIKE", "ILIKE") and isinstance(literal.get("value"), str):
                val = literal.get("value")
                if "%" in val or "_" in val or val.swapcase() != val:
                    return True
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        where_literals = parsed_query.get("where_literals", [])
        
        target_literals = []
        for lit_idx, lit in enumerate(where_literals):
            if lit.get("operator", "").upper() in ("LIKE", "ILIKE") and isinstance(lit.get("value"), str):
                val = lit.get("value")
                if "%" in val or "_" in val or val.swapcase() != val:
                    target_literals.append((lit_idx, lit))
                    
        if not target_literals:
            return []

        for target_index, (lit_idx, target_literal) in enumerate(target_literals):
            resolved_target = resolve_query_column(schema, parsed_query, target_literal.get("table", ""), target_literal.get("column", ""))
            if not resolved_target:
                continue
                
            t_name, c_name = resolved_target
            col_obj = None
            if t_name in schema.tables:
                for c in schema.tables[t_name].columns:
                    if c.name == c_name:
                        col_obj = c
                        break
                        
            if not col_obj:
                continue

            pattern = target_literal["value"]
            if "%" in pattern or "_" in pattern:
                matching_val = value_matching_like_pattern(col_obj, pattern)
                if matching_val == pattern and pattern.endswith("%"):
                    matching_val = pattern[:-1] + "a"
            else:
                matching_val = pattern.swapcase()

            if matching_val == pattern:
                continue
                
            # Modify only the targeted LIKE literal to force generation of this specific matching value
            # while preserving all other query literals on the same or other columns.
            modified_query = copy.deepcopy(parsed_query)
            mod_lits = modified_query.get("where_literals", [])
            if lit_idx < len(mod_lits):
                mod_lits[lit_idx]["value"] = matching_val
                mod_lits[lit_idx]["operator"] = "EQ"

            violating_data = deduplicate_mock_data(
                schema,
                generate_base_dataset(schema, modified_query, cache_key_salt=f"like_{target_index}")
            )
            
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{c_name}_{target_index}",
                    data=violating_data,
                    tags=["like_vs_equal_attack"],
                    description=f"Targets LIKE vs EQUAL operator bugs. Dataset assigns the value `'{matching_val}'` to `{t_name}.{c_name}` which satisfies the LIKE pattern `'{pattern}'` but is not equal to the literal string under `=`. A query using LIKE will match, whereas a mutant using = will not."
                )
            )

        return datasets
