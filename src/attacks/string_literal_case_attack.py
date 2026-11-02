"""
StringLiteralCaseAttackStrategy Module

Target semantic bugs: Incorrect string casing or accidental case-insensitive comparisons.
Algorithm & Dataset Design:
Inverts string literal casing (e.g., 'report' -> 'REPORT') to populate targeted test rows.
Ensures case-sensitive SQL predicates reject mismatched casing while case-insensitive mutants incorrectly match them.
"""

from typing import Any, Dict, List, Tuple

from models import Schema, Dataset
from dataset_generator.value_generator import (
    DataFactory,
    generate_unique_value_for_column,
    value_matching_like_pattern,
)
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column

class StringLiteralCaseAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Incorrect string casing or accidental case-insensitive comparisons.
    
    Dataset Design & Algorithm:
    String literal casing differences can lead to semantic mismatches (e.g., 'report' vs 'REPORT').
    If a mutant uses `UPPER(col) = 'REPORT'` or `col LIKE 'report'` instead of `col = 'report'`,
    or simply uses the wrong casing in a case-sensitive comparison, it might falsely pass if we
    only insert the exact Gold query literal.
    To explicitly catch these mutations, we extract string literals containing cased characters from
    the query, invert their case (via `.swapcase()`), and inject the inverted string into the target
    column while preserving all other required string literals on the same or other columns.
    """
    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for literal in parsed_query.get("where_literals", []):
            if literal.get("is_length_expr"):
                continue
            val = literal.get("value")
            if isinstance(val, str) and val != "NULL" and val.swapcase() != val:
                resolved = resolve_query_column(schema, parsed_query, literal.get("table", ""), literal.get("column", ""))
                if resolved:
                    t_name, c_name = resolved
                    if t_name in schema.tables:
                        for col in schema.tables[t_name].columns:
                            if col.name == c_name:
                                dt = col.data_type.lower()
                                if "char" in dt or "text" in dt or "clob" in dt or "string" in dt:
                                    return True
                                break
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        where_literals = parsed_query.get("where_literals", [])
        
        string_literals = []
        for lit in where_literals:
            if lit.get("is_length_expr"):
                continue
            val = lit.get("value")
            if isinstance(val, str) and val != "NULL":
                resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
                if resolved:
                    t_name, c_name = resolved
                    if t_name in schema.tables:
                        for col in schema.tables[t_name].columns:
                            if col.name == c_name:
                                dt = col.data_type.lower()
                                if "char" in dt or "text" in dt or "clob" in dt or "string" in dt:
                                    string_literals.append(lit)
                                break
                
        if not string_literals:
            return []
            
        shared_injections = {}
        for join in parsed_query.get("joins", []):
            if join.get("type") in ("IN_SUBQUERY", "EQ_SUBQUERY"):
                for pair in join.get("on_pairs", []):
                    left_table = pair["left"]["table"]
                    left_col = pair["left"]["column"]
                    right_table = pair["right"]["table"]
                    right_col = pair["right"]["column"]
                    
                    resolved_left = resolve_query_column(schema, parsed_query, left_table, left_col)
                    resolved_right = resolve_query_column(schema, parsed_query, right_table, right_col)
                    
                    if resolved_left and resolved_right:
                        t1, c1 = resolved_left
                        t2, c2 = resolved_right
                        
                        col_obj = None
                        if t1 in schema.tables:
                            for c in schema.tables[t1].columns:
                                if c.name == c1:
                                    col_obj = c
                                    break
                                    
                        val = generate_unique_value_for_column(col_obj) if col_obj else DataFactory.get_instance().increment_pk()
                        shared_injections[(t1, c1)] = val
                        shared_injections[(t2, c2)] = val

        seen_targets = set()
        for target_index, target_literal in enumerate(string_literals):
            val = target_literal["value"]
            resolved_target = resolve_query_column(schema, parsed_query, target_literal["table"], target_literal["column"])
            if not resolved_target:
                continue

            col_obj = schema.find_column(resolved_target[0], resolved_target[1])
            if target_literal.get("operator", "").upper() in ("LIKE", "ILIKE") and ("%" in val or "_" in val) and col_obj:
                base_val = value_matching_like_pattern(col_obj, val)
            else:
                base_val = val

            inverted_val = base_val.swapcase()
            if inverted_val == base_val:
                continue

            target_key = (resolved_target, inverted_val)
            if target_key in seen_targets:
                continue
            seen_targets.add(target_key)

            inj = shared_injections.copy()
            col_values: Dict[Tuple[str, str], List[Any]] = {}
            for other_idx, other_lit in enumerate(string_literals):
                resolved_other = resolve_query_column(schema, parsed_query, other_lit["table"], other_lit["column"])
                if not resolved_other or resolved_other in shared_injections:
                    continue
                if other_idx == target_index:
                    v_to_add = inverted_val
                else:
                    other_val = other_lit["value"]
                    other_col = schema.find_column(resolved_other[0], resolved_other[1])
                    if other_lit.get("operator", "").upper() in ("LIKE", "ILIKE") and ("%" in other_val or "_" in other_val) and other_col:
                        v_to_add = value_matching_like_pattern(other_col, other_val)
                    else:
                        v_to_add = other_val
                vals_list = col_values.setdefault(resolved_other, [])
                if v_to_add not in vals_list:
                    vals_list.append(v_to_add)

            for col_pair, vals_list in col_values.items():
                inj[col_pair] = vals_list[0] if len(vals_list) == 1 else vals_list

            data = generate_base_dataset(schema, parsed_query, value_injections=inj, cache_key_salt=f"str_lit_case_{target_index}")

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{resolved_target[1]}_{target_index}",
                    data=data,
                    tags=["string_literal_case_attack"],
                    description=f"Targets Case Sensitivity bugs. Dataset assigns the value `'{inverted_val}'` (inverted case) into `{resolved_target[0]}.{resolved_target[1]}`. This explicitly tests whether string comparisons are strictly case-sensitive, detecting imprecise mutations (like switching to `LOWER(col) = lower_val`) or incorrect string literal casing."
                )
            )
            
        return datasets
