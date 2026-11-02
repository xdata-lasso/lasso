"""
MathFunctionAttackStrategy Module

Target semantic bugs:
  1. Wrong Math Function (ABS vs ROUND vs CEIL vs FLOOR) or wrong ROUND scale.
  2. ABS triangle-inequality / sign-sensitivity mutations (e.g. ABS(u - v) vs
     ABS(ABS(u) - ABS(v)), ABS(u) - ABS(v), u - v, or ABS(u + v) vs ABS(u) + ABS(v)).

Algorithm & Dataset Design:
  - Injects negative multi-digit fractional float values (e.g. -10.234 and -10.876)
    into math function argument columns. The specific fractional choices (< 0.5 and
    > 0.5 at each decimal place) guarantee that ABS, ROUND (across scales 0, 1, 2),
    CEIL, FLOOR, and unrounded expressions evaluate to strictly distinct outputs.
  - When ABS is present, generates an additional mixed-sign dataset injecting
    opposite-sign values of unequal magnitude (e.g. -10 and 25, or -10.234 and 25.111)
    across rows/columns so u * v < 0 and ||u| - |v|| < |u - v| = |u| + |v|.
"""

from typing import Any
import sqlglot
import sqlglot.expressions as exp
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column

class MathFunctionAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Wrong Math Function (e.g. ABS vs ROUND vs CEIL vs FLOOR),
    wrong ROUND scale, or ABS triangle-inequality / sign-sensitivity bugs.
    Generates datasets with negative multi-decimal floats (-10.234 and -10.876) and
    mixed-sign pairs (-10 / 25) to ensure ABS, ROUND, CEIL, FLOOR, different ROUND
    scales, and ABS(u - v) vs ABS(ABS(u) - ABS(v)) produce distinct outputs.
    """

    def is_applicable(self, schema: Schema, parsed_query: dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return False
            
        for node in parsed.find_all((exp.Abs, exp.Round, exp.Ceil, exp.Floor)):
            if node.find(exp.Column):
                return True
        return False

    def generate(self, schema: Schema, parsed_query: dict[str, Any]) -> list[Dataset]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        # Find columns used in math functions
        targets = []
        for node in parsed.find_all((exp.Abs, exp.Round, exp.Ceil, exp.Floor)):
            for col in node.find_all(exp.Column):
                resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                if resolved and resolved not in targets:
                    targets.append(resolved)
                    
        if not targets:
            return []

        datasets = []
        
        # We need two datasets to break all ties (ROUND vs CEIL, ROUND vs FLOOR, and ROUND scales)
        for fractional in [0.234, 0.876]:
            value_injections = {}
            for t_name, c_name in targets:
                table_obj = schema.tables.get(t_name)
                col_obj = next((c for c in table_obj.columns if c.name == c_name), None) if table_obj else None
                dt = (col_obj.data_type or "").upper() if col_obj else ""
                if any(k in dt for k in ("INT", "SERIAL")):
                    value_injections[(t_name, c_name)] = -10
                else:
                    value_injections[(t_name, c_name)] = -10.0 - fractional
                
            mock_data = generate_base_dataset(schema, parsed_query, value_injections=value_injections)
            datasets.append(Dataset(
                strategy_name=self.__class__.__name__ + f"_frac_{fractional}",
                data=mock_data,
                tags=["math_function_attack"],
                description=f"Targets Math Function bugs. Dataset injects a specific multi-decimal fractional value (`{-10.0 - fractional}`) for the target math function argument. This targeted fractional portion ensures that alternative mathematical functions (ROUND across scales, CEIL, FLOOR, ABS) yield strictly different results."
            ))

        if parsed.find(exp.Abs):
            mixed_injections = {}
            for idx, (t_name, c_name) in enumerate(targets):
                table_obj = schema.tables.get(t_name)
                col_obj = next((c for c in table_obj.columns if c.name == c_name), None) if table_obj else None
                dt = (col_obj.data_type or "").upper() if col_obj else ""
                if any(k in dt for k in ("INT", "SERIAL")):
                    neg_val, pos_val = -10, 25
                else:
                    neg_val, pos_val = -10.234, 25.111
                pair = [neg_val, pos_val] if idx % 2 == 0 else [pos_val, neg_val]
                mixed_injections[(t_name, c_name)] = pair

            mixed_data = generate_base_dataset(schema, parsed_query, value_injections=mixed_injections)
            datasets.append(Dataset(
                strategy_name=self.__class__.__name__ + "_abs_mixed_signs",
                data=mixed_data,
                tags=["math_function_attack", "abs_mixed_signs"],
                description=(
                    "Targets ABS Triangle-Inequality / Sign-Sensitivity bugs (e.g. ABS(u - v) vs ABS(ABS(u) - ABS(v))). "
                    "Injects opposite-sign values of distinct magnitude so u * v < 0 and ||u| - |v|| < |u - v| = |u| + |v|."
                ),
            ))

        return datasets
