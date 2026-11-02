"""
StringLiteralAttackStrategy Module

Target semantic bugs: Missing or extra trailing spaces in string literals.
Algorithm & Dataset Design:
Ensures all string literals within the query are jointly satisfied in generated datasets.
Injects exact matching string values with controlled spacing so trailing space mismatches alter predicate evaluation.
"""

from typing import Any, Dict, List, Tuple

from models import Schema, Dataset
from dataset_generator.value_generator import DataFactory
from attacks.base import AttackStrategy
from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator import generate_base_dataset, resolve_query_column

class StringLiteralAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Missing or extra trailing spaces in string literals.
    
    Dataset Design & Algorithm:
    String literal trailing spaces can lead to subtle semantic mismatches (e.g., 'IPHONE' vs 'IPHONE ').
    To guarantee these mutants are killed, this strategy ensures that ALL literals within the query
    are jointly satisfied in the generated datasets. Because different literals might target the 
    same column in different subqueries, we collect all required values per column while overriding
    only the targeted literal with a trailing-space variant, connecting subqueries through shared
    pseudo-join keys (e.g., IN_SUBQUERY keys).
    """
    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for literal in parsed_query.get("where_literals", []):
            if literal.get("is_length_expr"):
                continue
            if isinstance(literal.get("value"), str) and literal.get("value") != "NULL":
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
            if isinstance(lit.get("value"), str) and lit.get("value") != "NULL":
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
            
        # Identify shared columns for subqueries to ensure generated datasets correctly join
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
            target_key = (resolved_target, val)
            if target_key in seen_targets:
                continue
            seen_targets.add(target_key)

            spaced_val = val + " "
            inj = shared_injections.copy()
            col_values: Dict[Tuple[str, str], List[Any]] = {}
            for other_idx, other_lit in enumerate(string_literals):
                resolved_other = resolve_query_column(schema, parsed_query, other_lit["table"], other_lit["column"])
                if not resolved_other or resolved_other in shared_injections:
                    continue
                v_to_add = spaced_val if other_idx == target_index else other_lit["value"]
                vals_list = col_values.setdefault(resolved_other, [])
                if v_to_add not in vals_list:
                    vals_list.append(v_to_add)

            for col_pair, vals_list in col_values.items():
                inj[col_pair] = vals_list[0] if len(vals_list) == 1 else vals_list

            data = generate_base_dataset(schema, parsed_query, value_injections=inj, cache_key_salt=f"str_lit_{target_index}")

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{resolved_target[1]}_{target_index}",
                    data=data,
                    tags=["string_literal_attack"],
                    description=f"Targets String Literal matching bugs. Dataset assigns the value `'{val} '` (with a deliberately injected trailing space) into `{resolved_target[0]}.{resolved_target[1]}`. This explicitly tests whether string comparisons are strictly evaluated, detecting imprecise mutations (like switching from `=` to `LIKE`) or missing `TRIM` function applications."
                )
            )
            
        return datasets
