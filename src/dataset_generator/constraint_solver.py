"""
Constraint Solver Module
========================

Solves CHECK constraints and attribute bounds defined in schema metadata to produce
concrete values that satisfy schema invariants during dataset generation.
"""

from typing import Any
import sqlglot.expressions as exp
from dateutil.parser import parse as dateutil_parse
from datetime import timedelta, date

from models import Schema, Column

def get_check_constraints_for_column(schema: Schema, table_name: str, column_name: str, visited: set = None) -> list[dict]:
    """Return all CHECK constraints from `schema` that reference `column_name` in `table_name`."""
    if visited is None:
        visited = set()
    key = (table_name.upper(), column_name.upper())
    if key in visited:
        return []
    visited.add(key)
    
    table = schema.tables.get(table_name)
    if not table:
        return []
    col_upper = column_name.upper()
    result = []
    
    # Check local constraints
    for cc in table.check_constraints:
        # Column-level CHECK: tagged with the column name
        if cc.get('column') and cc['column'].upper() == col_upper:
            result.append(cc)
        # Table-level CHECK (column=None): check if expression references this column
        elif cc.get('column') is None:
            referenced = [c.name.upper() for c in cc['expression'].find_all(exp.Column)]
            if col_upper in referenced:
                result.append(cc)
                
    # Recursively check referenced columns via foreign keys
    for fk in table.foreign_keys:
        if fk.column_name.upper() == col_upper:
            result.extend(get_check_constraints_for_column(schema, fk.reference_table, fk.reference_column, visited))
            
    return result

def _extract_enum_values(check_expr):
    """
    If the CHECK expression is of the form `col IN ('a', 'b', ...)`,
    return the list of literal values. Otherwise return None.
    """
    if isinstance(check_expr, exp.In):
        values = []
        for literal in check_expr.expressions:
            if isinstance(literal, exp.Literal):
                if literal.is_string:
                    values.append(literal.this)
                else:
                    val_str = literal.this
                    values.append(int(val_str) if val_str.isdigit() else float(val_str))
        if values:
            return values
    return None

def _eval_sqlglot_ast_python(node, val: Any, target_column_name: str, row_context: dict = None) -> Any:
    """
    Programmatically evaluate a sqlglot expression AST against a candidate value
    for target_column_name and row_context without calling Z3.
    """
    if node is None:
        return True
    if isinstance(node, exp.Column):
        if node.name.upper() == target_column_name.upper():
            return val
        if row_context:
            rc_upper = {k.upper(): v for k, v in row_context.items()}
            if node.name.upper() in rc_upper:
                return rc_upper[node.name.upper()]
        return "non_null_val"
    if isinstance(node, exp.Literal):
        if node.is_string:
            return node.this
        v_str = node.this
        if '.' in v_str:
            return float(v_str)
        return int(v_str) if v_str.lstrip('-').isdigit() else v_str
    if isinstance(node, exp.Boolean):
        return node.this
    if isinstance(node, exp.Neg):
        v = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        return -v if v is not None else None
    if isinstance(node, exp.In):
        target = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if target is None:
            return None
        opts = [_eval_sqlglot_ast_python(e, val, target_column_name, row_context) for e in node.expressions]
        if target in opts:
            return True
        if any(e is None for e in opts):
            return None
        return False
    if isinstance(node, exp.And):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        if l is False or r is False:
            return False
        if l is None or r is None:
            return None
        return bool(l and r)
    if isinstance(node, exp.Or):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        if l is True or r is True:
            return True
        if l is None or r is None:
            return None
        return bool(l or r)
    if isinstance(node, exp.Not):
        inner = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if inner is None:
            return None
        return not bool(inner)
    if isinstance(node, exp.Paren):
        return _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
    if isinstance(node, (exp.Cast, exp.TryCast)):
        inner = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if inner is None:
            return None
        to_type = (node.to.sql() if node.to else "").upper()
        try:
            if any(t in to_type for t in ("REAL", "FLOAT", "DOUBLE", "DECIMAL", "NUMERIC")):
                return float(inner)
            if "INT" in to_type:
                return int(float(inner))
            if any(t in to_type for t in ("CHAR", "TEXT", "VARCHAR", "CLOB")):
                return str(inner)
        except (ValueError, TypeError):
            return inner
        return inner
    if isinstance(node, exp.Add):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        return l + r if l is not None and r is not None else None
    if isinstance(node, exp.Sub):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        return l - r if l is not None and r is not None else None
    if isinstance(node, exp.Mul):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        return l * r if l is not None and r is not None else None
    if isinstance(node, exp.Div):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        return l / r if l is not None and r is not None and r != 0 else None
    if isinstance(node, exp.Mod):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        return l % r if l is not None and r is not None and r != 0 else None
    if isinstance(node, exp.Substring):
        base_val = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if base_val is None:
            return None
        s = str(base_val)
        start_val = _eval_sqlglot_ast_python(node.args.get("start"), val, target_column_name, row_context)
        len_val = _eval_sqlglot_ast_python(node.args.get("length"), val, target_column_name, row_context) if node.args.get("length") is not None else None
        if isinstance(start_val, int):
            start_idx = max(0, start_val - 1) if start_val >= 0 else max(0, len(s) + start_val)
            if isinstance(len_val, int) and len_val >= 0:
                if start_val == 0:
                    return s[:max(0, len_val - 1)]
                return s[start_idx:start_idx + len_val]
            return s[start_idx:]
        return s
    if isinstance(node, exp.Trim):
        inner = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if inner is None:
            return None
        pos = (str(node.args.get("position") or "").upper())
        if pos == "LEADING":
            return str(inner).lstrip()
        if pos == "TRAILING":
            return str(inner).rstrip()
        return str(inner).strip()
    if isinstance(node, exp.Anonymous) and getattr(node, "name", "").upper() in ("TRIM", "LTRIM", "RTRIM"):
        expr_to_eval = node.expressions[0] if getattr(node, "expressions", None) else node.this
        inner = _eval_sqlglot_ast_python(expr_to_eval, val, target_column_name, row_context)
        if inner is None:
            return None
        fn_up = getattr(node, "name", "").upper()
        if fn_up == "LTRIM":
            return str(inner).lstrip()
        if fn_up == "RTRIM":
            return str(inner).rstrip()
        return str(inner).strip()
    if isinstance(node, (exp.Length, exp.Anonymous)) and getattr(node, 'name', '').upper() in (
        'LENGTH', 'CHAR_LENGTH', 'CHARACTER_LENGTH', 'LEN', 'OCTET_LENGTH', ''
    ):
        expr_to_eval = node.expressions[0] if hasattr(node, 'expressions') and node.expressions else node.this
        inner = _eval_sqlglot_ast_python(expr_to_eval, val, target_column_name, row_context)
        return len(str(inner)) if inner is not None else 0
    if isinstance(node, (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
        l = _eval_sqlglot_ast_python(node.left, val, target_column_name, row_context)
        r = _eval_sqlglot_ast_python(node.right, val, target_column_name, row_context)
        if l is None or r is None:
            return None
        if isinstance(node, exp.GT): return l > r
        if isinstance(node, exp.GTE): return l >= r
        if isinstance(node, exp.LT): return l < r
        if isinstance(node, exp.LTE): return l <= r
        if isinstance(node, exp.EQ): return l == r
        if isinstance(node, exp.NEQ): return l != r
    if isinstance(node, exp.Between):
        c = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        low = _eval_sqlglot_ast_python(node.args['low'], val, target_column_name, row_context)
        high = _eval_sqlglot_ast_python(node.args['high'], val, target_column_name, row_context)
        if c is None or low is None or high is None:
            return None
        return low <= c <= high
    if isinstance(node, exp.Case):
        for w in node.args.get('whens', []):
            cond = _eval_sqlglot_ast_python(w.this, val, target_column_name, row_context)
            if cond:
                return _eval_sqlglot_ast_python(w.expression, val, target_column_name, row_context)
        if node.args.get('default'):
            return _eval_sqlglot_ast_python(node.args['default'], val, target_column_name, row_context)
        return True
    if isinstance(node, exp.Is):
        c = _eval_sqlglot_ast_python(node.this, val, target_column_name, row_context)
        if isinstance(node.expression, exp.Null):
            return c is None
    return True

_NO_CANDIDATE = object()

def solve_check_constraint_value(
    schema: Schema,
    table_name: str,
    column_name: str,
    column: Column,
    candidate_value: Any = _NO_CANDIDATE,
    disallowed_values: set = None,
    row_context: dict = None,
    extra_checks: list = None
) -> Any:
    """
    Produce a value for `column` that satisfies all CHECK constraints on it.
    Programmatic implementation without Z3 solver dependencies.
    """
    checks = list(get_check_constraints_for_column(schema, table_name, column_name))
    if extra_checks:
        for ec in extra_checks:
            ec_col = ec.get("column")
            if ec_col and ec_col.upper() == column_name.upper():
                if ec not in checks:
                    checks.append(ec)
            elif ec_col is None and "expression" in ec:
                referenced = [c.name.upper() for c in ec["expression"].find_all(exp.Column)]
                if column_name.upper() in referenced and ec not in checks:
                    checks.append(ec)
    if not checks:
        return candidate_value if candidate_value is not _NO_CANDIDATE else None

    def _satisfies(val):
        if disallowed_values and val in disallowed_values:
            return False
        if val is None:
            if column and (not column.is_nullable or column.is_primary_key):
                return False
        for cc in checks:
            try:
                res = _eval_sqlglot_ast_python(cc['expression'], val, column_name, row_context)
                if res is False:
                    return False
            except Exception:
                pass
        return True

    # 1. Fast path: candidate_value passes all constraints directly
    if candidate_value is not _NO_CANDIDATE and _satisfies(candidate_value):
        return candidate_value

    # 2. ENUM (IN) constraint fast path
    for cc in checks:
        enum_vals = _extract_enum_values(cc['expression'])
        if enum_vals is not None:
            for val in enum_vals:
                if _satisfies(val):
                    return val

    # 3. Numeric / Temporal / String programmatic domain search
    is_numeric = column.is_numeric
    is_temporal = column.is_temporal
    if is_numeric:
        base_val = candidate_value if isinstance(candidate_value, (int, float)) else 0
        step = 1.0 if isinstance(base_val, float) else 1
        # Try stepping around base_val
        for delta in [0, 1, -1, 5, -5, 10, -10, 50, -50, 100, 500, 1000]:
            try_val = base_val + delta * step
            if isinstance(base_val, int):
                try_val = int(try_val)
            if _satisfies(try_val):
                return try_val

        # Search for explicit literals in check expressions
        for cc in checks:
            for lit in cc['expression'].find_all(exp.Literal):
                if not lit.is_string:
                    try:
                        lit_v = float(lit.this) if '.' in lit.this else int(lit.this)
                        for offset in [0, 1, -1]:
                            test_v = lit_v + offset
                            if isinstance(base_val, int):
                                test_v = int(test_v)
                            if _satisfies(test_v):
                                return test_v
                    except ValueError:
                        pass
    elif is_temporal:
        try:
            base_dt = dateutil_parse(str(candidate_value)) if candidate_value is not None else date(1970, 1, 1)
            for delta in [0, 1, -1, 5, -5, 10, -10, 30, -30, 365, -365]:
                try_date = (base_dt + timedelta(days=delta)).strftime("%Y-%m-%d")
                if _satisfies(try_date):
                    return try_date
        except Exception:
            pass
        if row_context:
            for rc_k, rc_v in row_context.items():
                if isinstance(rc_v, str) and "-" in rc_v:
                    try:
                        rc_dt = dateutil_parse(rc_v)
                        for delta in [0, 1, -1, 5, -5, 10, -10]:
                            try_date = (rc_dt + timedelta(days=delta)).strftime("%Y-%m-%d")
                            if _satisfies(try_date):
                                return try_date
                    except Exception:
                        pass
    else:
        # String length search
        base_str = str(candidate_value) if candidate_value is not None else (column.name if column and getattr(column, "name", None) else "v")
        if _satisfies(base_str):
            return base_str
        # Try padding or truncating string to satisfy length constraints
        for length in [1, 5, 10, 20, 50]:
            try_str = (base_str * (length // len(base_str) + 1))[:length]
            if _satisfies(try_str):
                return try_str

    # 4. Context-derived values (e.g., column-to-column comparison constraints like start_date <= end_date)
    if row_context:
        for rc_k, rc_v in row_context.items():
            if rc_v is not None:
                rc_is_num = isinstance(rc_v, (int, float)) and not isinstance(rc_v, bool)
                if is_numeric == rc_is_num:
                    if _satisfies(rc_v):
                        return rc_v
                    if is_numeric:
                        for delta in [1, -1, 5, -5]:
                            if _satisfies(rc_v + delta):
                                return rc_v + delta
                    else:
                        if isinstance(rc_v, str):
                            try:
                                dt = dateutil_parse(rc_v)
                                for days in [0, 1, -1, 30, -30]:
                                    cand_dt = (dt + timedelta(days=days)).strftime("%Y-%m-%d")
                                    if _satisfies(cand_dt):
                                        return cand_dt
                            except Exception:
                                if _satisfies(rc_v + "Z"):
                                    return rc_v + "Z"

    # Fallback: return candidate unchanged
    return candidate_value
