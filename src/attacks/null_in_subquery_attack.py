"""
NullInSubqueryAttackStrategy Module

Target semantic bug: Mismatched semantics of NOT IN when subquery contains NULL.
If a query has `WHERE col NOT IN (SELECT inner_col FROM inner_table WHERE cond)`,
and `inner_col` can be NULL, we generate a dataset where `inner_col = NULL` in `inner_table`.
SQL semantics dictate `col NOT IN (..., NULL)` evaluates to UNKNOWN (i.e. FALSE in WHERE), filtering out outer rows.
"""

from typing import Any, Dict, List
from datetime import date, timedelta
import copy
import traceback
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset
from parser import parse_sql_to_ast

class NullInSubqueryAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Mismatched semantics of NOT IN when subquery contains NULL.
    
    Algorithm & Dataset Design:
    If a query has `WHERE col NOT IN (SELECT inner_col FROM inner_table WHERE cond)`,
    and `inner_col` can be NULL, we generate:
    - An outer row that satisfies the outer query constraints.
    - A row in `inner_table` satisfying `cond` but with `inner_col = NULL`.
    Because `col NOT IN (NULL, ...)` evaluates to UNKNOWN (i.e. FALSE in WHERE), 
    the correct query will exclude the outer row.
    Mutants (like JOIN with HAVING SUM(...) = 0) will often ignore the NULL key and INCLUDE the outer row.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        # We need to parse raw_query to find NOT IN (Subquery) since parsed_query flattens them
        raw_query = parsed_query.get("raw_query", "")
        if not raw_query:
            return False
        
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
            for not_node in parsed.find_all(exp.Not):
                if isinstance(not_node.this, exp.In) and not_node.this.args.get("query"):
                    return True
        except Exception:
            pass
            
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        raw_query = parsed_query.get("raw_query", "")
        if not raw_query:
            return []
            
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
            
            # Find all NOT IN (Subquery)
            for not_node in parsed.find_all(exp.Not):
                if isinstance(not_node.this, exp.In) and not_node.this.args.get("query"):
                    in_node = not_node.this
                    subquery = in_node.args.get("query")
                    
                    # Find the first column selected in the subquery
                    select_node = subquery.this if isinstance(subquery, exp.Subquery) else subquery
                    inner_col_node = None
                    if hasattr(select_node, "expressions"):
                        for expr in select_node.expressions:
                            if isinstance(expr, exp.Column):
                                inner_col_node = expr
                                break
                                
                    if not inner_col_node:
                        continue
                        
                    # Find the table for inner_col
                    inner_table_name = inner_col_node.table
                    if not inner_table_name:
                        # Try to extract the first table from the FROM clause of subquery
                        for t in select_node.find_all(exp.Table):
                            inner_table_name = t.alias or t.name
                            break
                            
                    if not inner_table_name:
                        continue
                        
                    # Resolve alias if necessary
                    resolved_table = None
                    inner_table_upper = inner_table_name.upper() if inner_table_name else ""
                    for t in select_node.find_all(exp.Table):
                        t_alias_upper = (t.alias or "").upper()
                        t_name_upper = t.name.upper()
                        if (t_alias_upper == inner_table_upper or t_name_upper == inner_table_upper):
                            # Find the matching schema table (case-insensitive)
                            for st_name in schema.tables:
                                if st_name.upper() == t_name_upper:
                                    resolved_table = st_name
                                    break
                            if resolved_table:
                                break
                    if not resolved_table:
                        # Direct schema lookup (case-insensitive)
                        for st_name in schema.tables:
                            if st_name.upper() == inner_table_upper:
                                resolved_table = st_name
                                break
                    if not resolved_table:
                        # Try to find a table containing the column in the subquery's FROM clause tables
                        inner_col_upper = inner_col_node.name.upper()
                        for t in select_node.find_all(exp.Table):
                            for st_name in schema.tables:
                                if st_name.upper() == t.name.upper():
                                    if any(c.name.upper() == inner_col_upper for c in schema.tables[st_name].columns):
                                        resolved_table = st_name
                                        break
                            if resolved_table:
                                break
                    if not resolved_table:
                        continue
                        
                    # Check if the column is nullable (case-insensitive lookup)
                    inner_col_name = inner_col_node.name
                    table_obj = schema.tables[resolved_table]
                    col_obj = next((c for c in table_obj.columns if c.name.upper() == inner_col_name.upper()), None)
                    
                    if not col_obj:
                        continue
                        
                    # If it's a primary key, part of unique constraint, or NOT NULL, it cannot be NULL
                    if col_obj.is_primary_key or col_obj.is_unique or not col_obj.is_nullable:
                        continue
                        
                    # It's nullable! Now let's generate the dataset.
                    # 1. Base dataset for outer query
                    outer_parsed_query = copy.deepcopy(parsed_query)
                    subq_sql = select_node.sql()
                    parsed_subquery = parse_sql_to_ast(subq_sql)
                    
                    subq_literals = [(l.get("table"), l.get("column"), l.get("value"), l.get("operator")) for l in parsed_subquery.get("where_literals", [])]
                    filtered_literals = []
                    for l in outer_parsed_query.get("where_literals", []):
                        sig = (l.get("table"), l.get("column"), l.get("value"), l.get("operator"))
                        if sig not in subq_literals:
                            filtered_literals.append(l)
                    outer_parsed_query["where_literals"] = filtered_literals
                    
                    outer_data = generate_base_dataset(schema, outer_parsed_query)
                    combined_data = copy.deepcopy(outer_data)
                    
                    # Try to find the outer column value in the generated outer_data
                    outer_col_node = in_node.this
                    outer_val = None
                    if isinstance(outer_col_node, exp.Column):
                        outer_table = outer_col_node.table
                        if not outer_table and parsed_query.get("tables"):
                            outer_table = parsed_query["tables"][0]["alias"]
                        
                        # resolve alias (case-insensitive)
                        resolved_outer = None
                        outer_table_upper = outer_table.upper() if outer_table else ""
                        for t in parsed_query.get("tables", []):
                            if t["alias"].upper() == outer_table_upper:
                                resolved_outer = t["name"]
                                break
                        if not resolved_outer: resolved_outer = outer_table
                        
                        # Case-insensitive data lookup
                        data_table = None
                        for dt_name in combined_data:
                            if dt_name.upper() == resolved_outer.upper():
                                data_table = dt_name
                                break
                        if data_table and combined_data[data_table]:
                            # Case-insensitive column lookup in row dict
                            col_upper = outer_col_node.name.upper()
                            for k, v in combined_data[data_table][0].items():
                                if k.upper() == col_upper:
                                    outer_val = v
                                    break
                    
                    # Generate data for all positive IN subqueries to ensure the outer row satisfies them
                    for other_in in parsed.find_all(exp.In):
                        if not isinstance(other_in.parent, exp.Not) and other_in.args.get("query"):
                            pos_subq = other_in.args.get("query")
                            pos_select = pos_subq.this if isinstance(pos_subq, exp.Subquery) else pos_subq
                            
                            pos_inner_col = None
                            if hasattr(pos_select, "expressions"):
                                for expr in pos_select.expressions:
                                    if isinstance(expr, exp.Column):
                                        pos_inner_col = expr
                                        break
                            if not pos_inner_col: continue
                            
                            pos_inner_table = pos_inner_col.table
                            if not pos_inner_table:
                                for t in pos_select.find_all(exp.Table):
                                    pos_inner_table = t.alias or t.name
                                    break
                            
                            res_pos_table = None
                            pos_table_upper = pos_inner_table.upper() if pos_inner_table else ""
                            for t in pos_select.find_all(exp.Table):
                                t_alias_upper = (t.alias or "").upper()
                                t_name_upper = t.name.upper()
                                if (t_alias_upper == pos_table_upper or t_name_upper == pos_table_upper):
                                    for st_name in schema.tables:
                                        if st_name.upper() == t_name_upper:
                                            res_pos_table = st_name
                                            break
                                    if res_pos_table:
                                        break
                            if not res_pos_table:
                                for st_name in schema.tables:
                                    if st_name.upper() == pos_table_upper:
                                        res_pos_table = st_name
                                        break
                            if not res_pos_table: continue
                            
                            pos_sql = pos_select.sql()
                            pos_parsed = parse_sql_to_ast(pos_sql)
                            
                            pos_injections = {}
                            if outer_val is not None:
                                # Use schema column name for injection
                                pos_col_name = pos_inner_col.name
                                pos_table_obj = schema.tables[res_pos_table]
                                pos_col_obj = next((c for c in pos_table_obj.columns if c.name.upper() == pos_col_name.upper()), None)
                                if pos_col_obj:
                                    pos_injections[(res_pos_table, pos_col_obj.name)] = outer_val
                                
                            pos_data = generate_base_dataset(schema, pos_parsed, value_injections=pos_injections)
                            for table, rows in pos_data.items():
                                if table not in combined_data: combined_data[table] = []
                                combined_data[table].extend(rows)
                    
                    # 2. Parse the NOT IN subquery to generate matching rows but with injected NULL
                    subq_sql = select_node.sql()
                    parsed_subquery = parse_sql_to_ast(subq_sql)
                    
                    injections = {(table_obj.name, col_obj.name): None}
                    
                    # Analyze subquery WHERE literals to fix OR-style disjunctions.
                    # generate_base_dataset treats all literals as AND, which fails for
                    # `col < A OR col > B` patterns (contradictory ranges). We inject
                    # a satisfying value for one branch of the disjunction.
                    subq_col_ranges = {}  # col_name -> {lt_vals: [], gt_vals: []}
                    for lit in parsed_subquery.get("where_literals", []):
                        lit_col = lit.get("column", "")
                        lit_op = lit.get("operator", "").upper()
                        lit_val = lit.get("value")
                        if lit_val is None or lit_val == "NULL":
                            continue
                        key = lit_col.upper()
                        if key not in subq_col_ranges:
                            subq_col_ranges[key] = {"lt_vals": [], "gt_vals": []}
                        if lit_op in ("LT", "LTE", "BETWEENUPPER"):
                            subq_col_ranges[key]["lt_vals"].append((lit_val, lit_op))
                        elif lit_op in ("GT", "GTE", "BETWEENLOWER"):
                            subq_col_ranges[key]["gt_vals"].append((lit_val, lit_op))
                    
                    for col_key, ranges in subq_col_ranges.items():
                        if ranges["gt_vals"] and ranges["lt_vals"]:
                            # This looks like an OR disjunction (col < A OR col > B)
                            # Pick a value satisfying the GT side: value > max(gt_vals)
                            gt_val, gt_op = max(ranges["gt_vals"], key=lambda x: x[0])
                            # Find the schema column for this literal
                            for sc in table_obj.columns:
                                if sc.name.upper() == col_key:
                                    if sc.is_temporal:
                                        try:
                                            d = date.fromisoformat(str(gt_val))
                                            satisfying_date = (d + timedelta(days=1)).isoformat()
                                        except (ValueError, TypeError):
                                            satisfying_date = str(gt_val)
                                        injections[(table_obj.name, sc.name)] = satisfying_date
                                    elif isinstance(gt_val, (int, float)) or (isinstance(gt_val, str) and gt_val.lstrip('-').replace('.', '', 1).isdigit()):
                                        num_val = float(gt_val) if isinstance(gt_val, str) and '.' in gt_val else int(gt_val) if isinstance(gt_val, str) else gt_val
                                        injections[(table_obj.name, sc.name)] = num_val + 1
                                    break
                    
                    subq_data = generate_base_dataset(schema, parsed_subquery, value_injections=injections)
                    
                    # Combine subq_data
                    for table, rows in subq_data.items():
                        if table not in combined_data:
                            combined_data[table] = []
                        combined_data[table].extend(rows)
                        
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{inner_col_name}",
                            data=combined_data,
                            tags=["null_attack", "subquery_attack"],
                            description=f"Targets Null in Subquery bug. Dataset explicitly injects a NULL value into the inner subquery for column `{inner_col_name}`. Because of SQL semantics, `NOT IN (..., NULL)` evaluates to UNKNOWN, causing the predicate to filter out all outer rows. A mutant that uses a different subquery operator (like NOT EXISTS) or modifies the inner column will incorrectly return rows."
                        )
                    )
        except Exception:
            traceback.print_exc()

        return datasets
