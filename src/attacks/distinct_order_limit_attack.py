"""
DistinctOrderLimitAttackStrategy Module

Target semantic bug:
Mutants that inappropriately insert or drop DISTINCT in queries combining ORDER BY and LIMIT with JOIN clauses.

Algorithm & Dataset Design:
1. Target queries containing JOINs, ORDER BY, and LIMIT, but lacking DISTINCT.
2. Construct multiple row groups matching WHERE conditions where duplicate tuples would be generated across JOINs with identical ordering keys.
3. Verify whether adding or dropping DISTINCT alters the cardinality and returned set of top-K rows under LIMIT constraints.
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

class DistinctOrderLimitAttackStrategy(AttackStrategy):
    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        if parsed_query.get("has_distinct") or not parsed_query.get("has_order_by") or not parsed_query.get("has_limit") or not parsed_query.get("joins"):
            return False
            
        return True

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        order_bys = parsed_query.get("order_by", [])
        if not order_bys:
            return []
            
        order_col_info = order_bys[0]
        order_t_name = order_col_info.get("table")
        order_c_name = order_col_info.get("column")
        desc = order_col_info.get("desc", False)
        
        if not order_t_name or not order_c_name:
            return []
            
        resolved_order = resolve_query_column(schema, parsed_query, order_t_name, order_c_name)
        if not resolved_order:
            return []
        target_t, target_c = resolved_order
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        
        # Generate 3 independent single-tuple groups
        group1_a = {k: v[:1] for k, v in generate_base_dataset(schema, parsed_query, cache_key_salt="dol_g1a").items() if v}
        
        # Another row matching the where clause (Group 1 - Row B)
        group1_b = {k: v[:1] for k, v in generate_base_dataset(schema, parsed_query, cache_key_salt="dol_g1b").items() if v}
        group2 = {k: v[:1] for k, v in generate_base_dataset(schema, parsed_query, cache_key_salt="dol_g2").items() if v}
        
        select_cols = parsed_query.get("selects", []) or parsed_query.get("select", [])
        for sel in select_cols:
            t_alias = sel.get("table")
            c_name = sel.get("column")
            if not t_alias or not c_name: continue
            resolved_sel = resolve_query_column(schema, parsed_query, t_alias, c_name)
            if not resolved_sel: continue
            sel_t, sel_c = resolved_sel
            
            # Find matching table key in group1_a and group1_b
            g1a_tkey = next((k for k in group1_a if k.upper() == sel_t.upper()), None)
            g1b_tkey = next((k for k in group1_b if k.upper() == sel_t.upper()), None)
            if g1a_tkey and g1b_tkey and group1_a[g1a_tkey] and group1_b[g1b_tkey]:
                val = group1_a[g1a_tkey][0][sel_c]
                group1_b[g1b_tkey][0][sel_c] = val
                for child_t_name, child_t in schema.tables.items():
                    for fk in child_t.foreign_keys:
                        if fk.reference_table.upper() == sel_t.upper() and fk.reference_column.upper() == sel_c.upper():
                            child_g1b_key = next((k for k in group1_b if k.upper() == child_t_name.upper()), None)
                            if child_g1b_key and group1_b[child_g1b_key]:
                                for r in group1_b[child_g1b_key]:
                                    r[fk.column_name] = val

                # If sel_t != target_t and sel_c is PK/UNIQUE, group1_b must share the same parent row in sel_t
                # and propagate sel_t's join/FK equivalence-class values to child tables in group1_b.
                sel_col_obj = schema.find_column(sel_t, sel_c)
                if sel_t.upper() != target_t.upper() and sel_col_obj and (sel_col_obj.is_primary_key or sel_col_obj.is_unique):
                    sel_table_obj = schema.tables.get(sel_t)
                    if sel_table_obj:
                        for c_obj in sel_table_obj.columns:
                            c_val = group1_a[g1a_tkey][0].get(c_obj.name)
                            group1_b[g1b_tkey][0][c_obj.name] = c_val
                            c_root = equiv.find(col_key(sel_t, c_obj.name))
                            for other_t_name, other_rows in group1_b.items():
                                if not other_rows or other_t_name not in schema.tables:
                                    continue
                                for other_col in schema.tables[other_t_name].columns:
                                    if equiv.find(col_key(other_t_name, other_col.name)) == c_root:
                                        for r in other_rows:
                                            r[other_col.name] = c_val
            
        g1a_target_k = next((k for k in group1_a if k.upper() == target_t.upper()), target_t)
        g1b_target_k = next((k for k in group1_b if k.upper() == target_t.upper()), target_t)
        g2_target_k = next((k for k in group2 if k.upper() == target_t.upper()), target_t)

        target_col_obj = schema.find_column(target_t, target_c)
        if target_col_obj and not target_col_obj.is_numeric:
            v1 = group1_a.get(g1a_target_k, [{}])[0].get(target_c)
            v2 = group1_b.get(g1b_target_k, [{}])[0].get(target_c)
            v3 = group2.get(g2_target_k, [{}])[0].get(target_c)
            if v1 is None:
                v1 = "1970-01-01" if target_col_obj.is_temporal else "val_a"
            if v2 is None or v2 == v1:
                v2 = next_distinct_value(target_col_obj, v1, schema=schema, table_name=target_t)
            if v3 is None or v3 in (v1, v2):
                v3 = next_distinct_value(target_col_obj, v2, schema=schema, table_name=target_t)
                if v3 in (v1, v2):
                    v3 = next_distinct_value(target_col_obj, v3, schema=schema, table_name=target_t)
            low, mid, high = sorted([v1, v2, v3], key=str)
        else:
            # Set ORDER BY values: LOW, MID, HIGH
            low, mid, high = 10, 50, 100

        if desc:
            group1_a[g1a_target_k][0][target_c] = low
            group1_b[g1b_target_k][0][target_c] = high
            group2[g2_target_k][0][target_c] = mid
        else:
            group1_a[g1a_target_k][0][target_c] = high
            group1_b[g1b_target_k][0][target_c] = low
            group2[g2_target_k][0][target_c] = mid
            
        # Combine all rows into one dataset. 
        # Merge group1_a and group1_b safely
        group1 = merge_datasets(schema, group1_a, group1_b)
        # Merge the competing group (group2) safely
        merged_data = merge_datasets(schema, group1, group2)
        
        return [
            Dataset(
                strategy_name=f"{self.__class__.__name__}_{target_t}_{target_c}",
                data=merged_data,
                tags=["distinct_order_limit"],
                description="Targets Redundant DISTINCT with ORDER BY and LIMIT. Creates two independent rows with identical SELECT columns but different ORDER BY scores. DISTINCT merges them and arbitrarily picks the first (losing) score, causing the mutant to return the wrong row."
            )
        ]
