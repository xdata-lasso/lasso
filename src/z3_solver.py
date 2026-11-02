"""
Z3 Constraint Solver Module

Algorithm for Semantic Test Data Generation (Z3 Fallback):
1. AST Translation: Traverses the `WHERE` and `HAVING` ASTs of the given parsed SQL query.
2. Z3 Variable Mapping: Maps each SQL column reference to an equivalent Z3 variable based on its underlying schema data type (Int, Real, or String).
3. Expression Translation: Recursively translates SQL logical and arithmetic expressions (e.g. `exp.EQ`, `exp.Add`, `exp.And`, `exp.Count`) into their corresponding Z3 constraints.
4. Bound Resolution: Feeds the constraints to a bounded Z3 solver to find a satisfying assignment that respects the SQL semantics without relying on random fuzzing.
5. Extraction: Extracts the computed model into literal values that are passed back to the heuristic dataset generator to generate exact matching rows.
"""

import z3
import sqlglot.expressions as exp
import logging
import copy
import threading

logger = logging.getLogger(__name__)

def _is_numeric_type(data_type: str) -> bool:
    dt = data_type.lower()
    return any(t in dt for t in ('int', 'numeric', 'decimal', 'real', 'float', 'double', 'number'))

def _is_real_type(data_type: str) -> bool:
    dt = data_type.lower()
    return any(t in dt for t in ('real', 'float', 'double', 'decimal'))

_Z3_CACHE = {}
_Z3_CACHE_LOCK = threading.Lock()

def clear_z3_cache():
    with _Z3_CACHE_LOCK:
        _Z3_CACHE.clear()

def solve_query_constraints(schema, parsed_query, alias_to_table):
    """
    Attempts to find a satisfying assignment for the query's WHERE and HAVING clauses using Z3.
    Returns a dict mapping tuple (alias, column) -> value, or None if UNSAT.
    """
    where_sql = parsed_query.get("where_ast").sql() if parsed_query.get("where_ast") else ""
    having_sql = parsed_query.get("having_ast").sql() if parsed_query.get("having_ast") else ""
    join_sql = " ".join(j.sql() for j in (parsed_query.get("ast").find_all(exp.Join) if parsed_query.get("ast") else []))
    
    cache_key = (where_sql, having_sql, join_sql, tuple(sorted(alias_to_table.items())))
    
    with _Z3_CACHE_LOCK:
        if cache_key in _Z3_CACHE:
            return copy.deepcopy(_Z3_CACHE[cache_key])

    solver = z3.Solver()
    try:
        z3.set_param("parallel.enable", False)
    except Exception:
        pass
    solver.set('timeout', 1500) # 1.5 seconds

    var_map = {}
    
    # Pre-create variables for all known columns to enforce types
    for alias, table_name in alias_to_table.items():
        table_upper = table_name.upper()
        resolved_t_name = next((t for t in schema.tables if t.upper() == table_upper), None)
        if not resolved_t_name:
            continue
        for col in schema.tables[resolved_t_name].columns:
            key = (alias.upper(), col.name.upper())
            if _is_numeric_type(col.data_type):
                if _is_real_type(col.data_type):
                    var_map[key] = z3.Real(f"{key[0]}_{key[1]}")
                else:
                    var_map[key] = z3.Int(f"{key[0]}_{key[1]}")
            else:
                var_map[key] = z3.String(f"{key[0]}_{key[1]}")

    select_alias_map = {}
    ast = parsed_query.get("ast")
    if ast and hasattr(ast, "selects"):
        for sel_expr in ast.selects:
            if sel_expr.alias:
                select_alias_map[sel_expr.alias.upper()] = sel_expr.this

    def trace_col_alias(expr):
        # Traces column to (alias, col_name)
        if isinstance(expr, exp.Column):
            t = expr.table
            col_name = expr.name
            if not t or (t.upper(), col_name.upper()) not in var_map:
                for a, t_name in alias_to_table.items():
                    st = schema.find_table(t_name)
                    if st and schema.find_column(st, col_name):
                        t = a
                        break
            if not t and len(alias_to_table) == 1:
                t = list(alias_to_table.keys())[0]
            return (t.upper() if t else ""), col_name.upper()
        return None, None

    def translate(node):
        if node is None:
            return None
            
        if isinstance(node, (exp.Where, exp.Having)):
            return translate(node.this)
            
        if isinstance(node, exp.Column):
            key = trace_col_alias(node)
            col_name_upper = key[1]
            if col_name_upper in select_alias_map and key not in var_map:
                return translate(select_alias_map[col_name_upper])
            if key not in var_map:
                # Default to Real if unknown
                var_map[key] = z3.Real(f"{key[0]}_{key[1]}")
            return var_map[key]
            
        if isinstance(node, exp.Literal):
            val = node.this
            if node.is_string:
                return z3.StringVal(val)
            if "." in val:
                return z3.RealVal(float(val))
            return z3.IntVal(int(val))
            
        if isinstance(node, exp.Neg):
            inner = translate(node.this)
            return -inner if inner is not None else None
            
        if isinstance(node, exp.Add):
            l, r = translate(node.left), translate(node.right)
            return l + r if l is not None and r is not None else None
            
        if isinstance(node, exp.Sub):
            l, r = translate(node.left), translate(node.right)
            return l - r if l is not None and r is not None else None
            
        if isinstance(node, exp.Mul):
            l, r = translate(node.left), translate(node.right)
            return l * r if l is not None and r is not None else None
            
        if isinstance(node, exp.Div):
            l, r = translate(node.left), translate(node.right)
            if l is not None and r is not None:
                solver.add(r != 0)
                solver.add(r > 0)
                solver.add(l > 0)
                return l / r
            return None
            
        if isinstance(node, exp.And):
            l, r = translate(node.left), translate(node.right)
            if l is None and r is None: return None
            if l is None: return r
            if r is None: return l
            return z3.And(l, r)
            
        if isinstance(node, exp.Or):
            l, r = translate(node.left), translate(node.right)
            if l is None and r is None: return None
            if l is None: return r
            if r is None: return l
            return z3.Or(l, r)
            
        if isinstance(node, exp.Not):
            inner = translate(node.this)
            return z3.Not(inner) if inner is not None else None
            
        if isinstance(node, exp.Paren):
            return translate(node.this)
            
        if isinstance(node, exp.In):
            l = translate(node.this)
            if l is None: return None
            opts = [translate(e) for e in node.expressions]
            opts = [o for o in opts if o is not None]
            if not opts: return None
            return z3.Or(*[l == opt for opt in opts])
            
        if isinstance(node, (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
            l, r = translate(node.left), translate(node.right)
            if l is None or r is None: return None
            try:
                if (l.sort() == z3.StringSort()) != (r.sort() == z3.StringSort()):
                    return None
                if isinstance(node, (exp.GT, exp.GTE, exp.LT, exp.LTE)):
                    # Avoid hanging in Z3 for lexicographical string range comparisons
                    if l.sort() == z3.StringSort() or r.sort() == z3.StringSort():
                        return None
            except Exception:
                return None
            if isinstance(node, exp.GT): return l > r
            if isinstance(node, exp.GTE): return l >= r
            if isinstance(node, exp.LT): return l < r
            if isinstance(node, exp.LTE): return l <= r
            if isinstance(node, exp.EQ): return l == r
            if isinstance(node, exp.NEQ): return l != r
            
        if isinstance(node, exp.Between):
            l = translate(node.this)
            low = translate(node.args.get("low"))
            high = translate(node.args.get("high"))
            if l is None or low is None or high is None: return None
            try:
                if l.sort() == z3.StringSort():
                    return None
            except Exception:
                pass
            return z3.And(l >= low, l <= high)
            
        # Aggregates for HAVING
        if isinstance(node, exp.Count):
            # Hack for COUNT(x): just return a constant row multiplier.
            # We assume at least 1 row exists.
            if "ROW_COUNT" not in var_map:
                var_map["ROW_COUNT"] = z3.Int("ROW_COUNT")
                solver.add(var_map["ROW_COUNT"] >= 1)
            return var_map["ROW_COUNT"]
            
        if isinstance(node, (exp.Sum, exp.Avg, exp.Min, exp.Max)):
            inner = translate(node.this)
            if inner is None: return None
            if isinstance(node, exp.Sum):
                if "ROW_COUNT" not in var_map:
                    var_map["ROW_COUNT"] = z3.Int("ROW_COUNT")
                    solver.add(var_map["ROW_COUNT"] >= 1)
                return inner * z3.ToReal(var_map["ROW_COUNT"]) if inner.sort() != z3.IntSort() else inner * var_map["ROW_COUNT"]
            return inner

        if isinstance(node, exp.Subquery):
            sub_select = node.this if isinstance(node.this, exp.Select) else node.find(exp.Select)
            if sub_select and hasattr(sub_select, "expressions") and len(sub_select.expressions) == 1:
                if sub_select.args.get("where"):
                    inner_cond = translate(sub_select.args["where"])
                    if inner_cond is not None:
                        solver.add(inner_cond)
                return translate(sub_select.expressions[0])
            return None

        return None

    constraints_to_add = []

    where_ast = parsed_query.get("where_ast")
    if where_ast:
        try:
            cond = translate(where_ast)
            if cond is not None:
                constraints_to_add.append(cond)
        except Exception as e:
            logger.debug(f"Failed to translate WHERE: {e}")

    having_ast = parsed_query.get("having_ast")
    if having_ast:
        try:
            cond = translate(having_ast)
            if cond is not None:
                constraints_to_add.append(cond)
        except Exception as e:
            logger.debug(f"Failed to translate HAVING: {e}")

    ast = parsed_query.get("ast")
    if ast:
        for join_node in ast.find_all(exp.Join):
            on_cond = join_node.args.get("on")
            if on_cond and bool(list(on_cond.find_all((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)))):
                try:
                    cond = translate(on_cond)
                    if cond is not None:
                        constraints_to_add.append(cond)
                except Exception as e:
                    logger.debug(f"Failed to translate JOIN ON: {e}")

    if constraints_to_add:
        solver.add(z3.And(*constraints_to_add) if len(constraints_to_add) > 1 else constraints_to_add[0])

    # Don't solve if no constraints were actually added
    if not solver.assertions():
        return None

    if "ROW_COUNT" in var_map:
        for upper_limit in [2, 3, 5, 10, 20]:
            solver.push()
            solver.add(var_map["ROW_COUNT"] <= upper_limit)
            if solver.check() == z3.sat:
                break
            solver.pop()

    if solver.check() == z3.sat:
        m = solver.model()
        result = {}
        for key, z3_var in var_map.items():
            if key == "ROW_COUNT":
                continue
            val = m[z3_var]
            if val is not None:
                if z3.is_real(val):
                    result[key] = float(val.as_decimal(6).rstrip('?'))
                elif z3.is_int(val):
                    result[key] = val.as_long()
                else:
                    val_str = val.as_string()
                    # Z3 returns strings wrapped in quotes
                    if val_str == '""' or val_str == "":
                        # Check if empty string is forced
                        solver.push()
                        solver.add(var_map[key] != z3.StringVal(""))
                        if solver.check() == z3.sat:
                            solver.pop()
                            continue # Let dataset_generator create a valid random string
                        solver.pop()
                        result[key] = ""
                    else:
                        if val_str.startswith('"') and val_str.endswith('"'):
                            val_str = val_str[1:-1]
                        result[key] = val_str
                    
        # Also return row count if it was constrained
        if "ROW_COUNT" in var_map:
            val = m[var_map["ROW_COUNT"]]
            if val is not None:
                result["ROW_COUNT"] = val.as_long()
                
        with _Z3_CACHE_LOCK:
            _Z3_CACHE[cache_key] = result
        return result
        
    return None
