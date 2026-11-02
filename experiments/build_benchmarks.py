import os
import sys
import json
import glob
import re
import csv
import logging
import sqlite3
import argparse
import concurrent.futures
import multiprocessing
from collections import Counter
from tqdm import tqdm

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'src')))
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'sql-execution-tester')))
poly_testing = os.path.join(os.path.dirname(__file__), 'originals', 'polygon-artifact-evaluation-extracted', 'sql_testing')
if not os.path.exists(poly_testing):
    poly_testing = os.path.join(os.path.dirname(__file__), 'polygon-artifact-evaluation-extracted', 'sql_testing')
sys.path.append(os.path.abspath(poly_testing))

import sqlglot
from sqlglot.errors import ParseError, SqlglotError
from sqlglot.optimizer import optimize
from sqlglot.schema import MappingSchema

from query_normalizer import normalize_sql
from schema_fixer import ensure_foreign_key_constraints
import schema_translator

try:
    from constraint_parser import ConstraintParser
except ImportError:
    ConstraintParser = None

DATE_SHIFT_PATTERN = re.compile(r"([+-])\s*(\d+)\s*(DAY|DAYS|WEEK|WEEKS|MONTH|MONTHS|YEAR|YEARS)", re.IGNORECASE)

def clean_up_spotit_sql(generated_sql: str) -> str:
    if not generated_sql:
        return ""
    def transform_backtick_content(match):
        content = match.group(1)
        content = content.upper().replace(' ', '_')
        content = re.sub(r'(\d+)-(\d+)', r'\1_\2', content)
        content = re.sub(r'([A-Z]+)-(\d+)', r'\1\2', content)
        content = content.replace('-', '_')
        content = re.sub(r'[^A-Z0-9_]', '', content)
        content = re.sub(r'_+', '_', content).strip('_')
        return f'"{content}"'

    pattern = r'`([^`]+)`'
    generated_sql = re.sub(pattern, transform_backtick_content, generated_sql)
    pattern = r'"([^"]+)"'
    generated_sql = re.sub(pattern, transform_backtick_content, generated_sql)
    return generated_sql

def prepare_postgres_ddl(sqlite_ddl: str) -> str:
    if not sqlite_ddl:
        return ""

    stmts = [stmt.strip() for stmt in sqlite_ddl.split(";") if stmt.strip()]
    table_stmts = {}
    deps = {}
    
    for stmt in stmts:
        m = re.search(r"CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?([\"\`\w]+)", stmt, re.I)
        if m:
            tname = m.group(1).replace('"', '').replace('`', '').lower()
            table_stmts[tname] = stmt
            ref_matches = re.findall(r"REFERENCES\s+([\"\`\w]+)", stmt, re.I)
            deps[tname] = set(r.replace('"', '').replace('`', '').lower() for r in ref_matches if r.replace('"', '').replace('`', '').lower() != tname)

    ordered = []
    visited = set()
    visiting = set()
    
    def visit(t):
        if t in visiting:
            return
        if t not in visited:
            visiting.add(t)
            for p in deps.get(t, []):
                if p in table_stmts:
                    visit(p)
            visiting.remove(t)
            visited.add(t)
            ordered.append(t)

    for t in table_stmts:
        visit(t)

    ordered_ddl = ";\n".join(table_stmts[t] for t in ordered if t in table_stmts) + ";"
    ordered_ddl = re.sub(r'(?i)\bCHARACTER\s+VARCHAR\b', 'VARCHAR', ordered_ddl)
    ordered_ddl = re.sub(r'\bTEXT\s*\(\s*(\d+)\s*\)', r'VARCHAR(\1)', ordered_ddl, flags=re.I)
    ordered_ddl = re.sub(r'\b(?:FLOAT|REAL)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)', r'NUMERIC(\1, \2)', ordered_ddl, flags=re.I)
    ordered_ddl = re.sub(r'\b(?:FLOAT|REAL)\s*\(\s*(\d+)\s*\)', r'NUMERIC(\1)', ordered_ddl, flags=re.I)
    try:
        parsed = sqlglot.parse(ordered_ddl, read="sqlite")
        pg_stmts = []
        for stmt in parsed:
            for node in stmt.walk():
                if isinstance(node, sqlglot.exp.Identifier):
                    node.set("this", node.this.lower())
            pg_stmts.append(stmt.sql(dialect="postgres"))
        return ";\n".join(pg_stmts) + ";"
    except Exception:
        return ordered_ddl

def transform_ddl_for_spotit(uir) -> str:
    return schema_translator.transform_ddl_for_spotit(uir)

def sanitize_polygon_schema(polygon_schema_data):
    """
    Ensures that all foreign keys in polygon_schema point to valid table indices
    and columns that actually exist in the referenced parent table.
    Drops dangling or malformed foreign keys so Polygon's Z3 formula generator does not crash.
    """
    if not polygon_schema_data or not isinstance(polygon_schema_data, dict):
        return polygon_schema_data
    tables = polygon_schema_data.get("Tables", [])
    for table in tables:
        valid_fks = []
        for fk in table.get("FKeys", []):
            try:
                pidx = int(fk.get("PTable"))
                pname = str(fk.get("PName", "")).lower()
                if 0 <= pidx < len(tables):
                    target_table = tables[pidx]
                    target_cols = {
                        str(c.get("Name", "")).lower()
                        for c in target_table.get("PKeys", []) + target_table.get("Others", [])
                    }
                    for pfk in target_table.get("FKeys", []):
                        target_cols.add(str(pfk.get("FName", "")).lower())
                    if pname in target_cols:
                        valid_fks.append(fk)
                    else:
                        logger.warning(
                            f"Dropping dangling FK in polygon schema table '{table.get('TableName')}': "
                            f"column '{pname}' does not exist in target table '{target_table.get('TableName')}'"
                        )
                else:
                    logger.warning(
                        f"Dropping out-of-bounds FK in polygon schema table '{table.get('TableName')}': "
                        f"PTable index {pidx} out of range"
                    )
            except (ValueError, TypeError) as e:
                logger.warning(f"Dropping malformed FK in polygon schema: {fk} ({e})")
        table["FKeys"] = valid_fks
    return polygon_schema_data
def has_order_by_or_limit(sql_str: str, dialect: str = None) -> bool:
    """
    Checks if a SQL query contains an ORDER BY, LIMIT, OFFSET, or FETCH clause.
    Uses SQLGlot AST inspection with fallback to regex if parsing fails.
    """
    if not sql_str or not sql_str.strip():
        return False
    try:
        ast = sqlglot.parse_one(sql_str, read=dialect)
    except Exception:
        try:
            ast = sqlglot.parse_one(sql_str)
        except Exception:
            u = sql_str.upper()
            return bool(re.search(r'\b(ORDER\s+BY|LIMIT|FETCH)\b', u))
    return bool(
        ast.find(sqlglot.exp.Order)
        or ast.find(sqlglot.exp.Limit)
        or ast.find(sqlglot.exp.Fetch)
        or ast.find(sqlglot.exp.Offset)
    )

logger = logging.getLogger(__name__)

def create_sqlite_connection(schema_ddl: str) -> sqlite3.Connection | None:
    if not schema_ddl:
        return None
    try:
        conn = sqlite3.connect(":memory:")
        conn.execute("PRAGMA foreign_keys = OFF;")
        conn.executescript(schema_ddl)
        conn.execute("PRAGMA foreign_keys = ON;")
        return conn
    except Exception as e:
        logger.warning(f"Could not initialize SQLite schema in memory: {e}")
        return None

def check_sqlite_query_validity(schema_ddl: str, query_sql: str, conn: sqlite3.Connection = None) -> tuple[bool, str | None]:
    if not query_sql or not query_sql.strip():
        return False, "EmptyQuery"
    clean_sql = query_sql.split('\t-----')[0].strip().rstrip(';')
    try:
        # Step 1: Check pure AST parsing
        sqlglot.parse_one(clean_sql, read='sqlite')
        
        # Step 2: Check SQLite compilation using EXPLAIN
        own_conn = False
        if conn is None:
            own_conn = True
            conn = create_sqlite_connection(schema_ddl)
            if conn is None:
                return True, None
            
        cur = conn.cursor()
        cur.execute(f"EXPLAIN {clean_sql}")
        if own_conn:
            conn.close()
        return True, None
    except (ParseError, SqlglotError) as e:
        return False, f"{type(e).__name__}: {str(e).strip()}"
    except Exception as e:
        return False, f"{type(e).__name__}: {str(e).strip()}"

def normalize_name(name):
    return "".join(c for c in name.lower() if c.isalnum() or c == "_")

def normalize_type(t):
    t = str(t).lower().strip()
    if t.startswith('enum'):
        return 'enum'
    t = re.sub(r'\(.*?\)', '', t).strip()
    mapping = {
        'integer': 'int',
        'real': 'float',
        'double': 'float',
        'double precision': 'float',
        'numeric': 'float',
        'decimal': 'float',
        'character varying': 'varchar',
        'character': 'char',
        'text': 'varchar',
        'string': 'varchar',
        'datetime': 'timestamp',
    }
    return mapping.get(t, t)

def get_query_output_column_count(ast, schema_dict=None) -> int | None:
    """
    Accurately determines the number of output columns in a query AST.
    Returns None if arity cannot be deterministically inferred (e.g. unexpanded star).
    """
    if not ast or not hasattr(ast, 'selects'):
        return None
    
    count = 0
    for s in ast.selects:
        if isinstance(s, sqlglot.exp.Star):
            if schema_dict:
                tables = [t.name.lower() for t in ast.find_all(sqlglot.exp.Table)]
                if len(tables) == 1 and tables[0] in schema_dict:
                    count += len(schema_dict[tables[0]])
                    continue
            return None
        count += 1
    return count

def parse_ddl_to_polygon(ddl_text, schema_id):
    tables = []
    for stmt in sqlglot.parse(ddl_text, read='sqlite'):
        if stmt and stmt.key == 'create':
            schema_obj = stmt.this
            if schema_obj and schema_obj.key == 'schema':
                table_name = schema_obj.this.name
                pkeys = []
                fkeys = []
                others = []
                table_pkeys = set()
                table_fkeys = []
                
                for expr in schema_obj.expressions:
                    if expr.key == 'primarykey':
                        for col in expr.expressions:
                            table_pkeys.add(col.name)
                    elif expr.key == 'foreignkey':
                        fnames = [col.name for col in expr.expressions]
                        ref = expr.args.get('reference')
                        if ref:
                            if ref.this.key == 'schema':
                                ptable = ref.this.this.name
                                pnames = [col.name for col in ref.this.expressions] if ref.this.expressions else []
                            else:
                                ptable = ref.this.name
                                pnames = [col.name for col in ref.expressions] if ref.expressions else []
                            
                            if len(pnames) == len(fnames):
                                for fname, pname in zip(fnames, pnames):
                                    table_fkeys.append({"FName": fname, "PName": pname, "PTable": ptable})
                            elif len(pnames) == 1 and len(fnames) == 1:
                                table_fkeys.append({"FName": fnames[0], "PName": pnames[0], "PTable": ptable})
                            elif not pnames:
                                for fname in fnames:
                                    table_fkeys.append({"FName": fname, "PName": "", "PTable": ptable})
                            else:
                                for i, fname in enumerate(fnames):
                                    pname = pnames[i] if i < len(pnames) else (pnames[0] if pnames else "")
                                    table_fkeys.append({"FName": fname, "PName": pname, "PTable": ptable})
                                
                for col_def in schema_obj.expressions:
                    if col_def.key == 'columndef':
                        col_name = col_def.name
                        kind = col_def.args.get('kind')
                        t = kind.this.name if kind and hasattr(kind, 'this') and hasattr(kind.this, 'name') else 'TEXT'
                        
                        is_pk = col_name in table_pkeys
                        for constraint in col_def.args.get('constraints', []):
                            if constraint.kind.key == 'primarykeycolumnconstraint':
                                is_pk = True
                            if constraint.kind.key == 'reference':
                                ref_kind = constraint.kind
                                if ref_kind.this.key == 'schema':
                                    ptable = ref_kind.this.this.name
                                    pname = ref_kind.this.expressions[0].name if ref_kind.this.expressions else col_name
                                else:
                                    ptable = ref_kind.this.name
                                    pname = ref_kind.expressions[0].name if ref_kind.expressions else col_name
                                table_fkeys.append({"FName": col_name, "PName": pname, "PTable": ptable})
                                
                        if is_pk:
                            pkeys.append({"Name": col_name, "Type": normalize_type(t)})
                        else:
                            others.append({"Name": col_name, "Type": normalize_type(t)})
                            
                tables.append({"TableName": table_name, "PKeys": pkeys, "FKeys": table_fkeys, "Others": others})
                
    # Second pass: map PTable string names to string array indices
    table_name_to_idx = {t["TableName"].lower(): str(idx) for idx, t in enumerate(tables)}
    for t in tables:
        resolved_fkeys = []
        for fk in t["FKeys"]:
            ptable_name = str(fk["PTable"]).lower()
            if ptable_name in table_name_to_idx:
                fk["PTable"] = table_name_to_idx[ptable_name]
                # Resolve implicit primary key reference if PName was empty
                if not fk.get("PName"):
                    target_table = tables[int(fk["PTable"])]
                    if target_table.get("PKeys"):
                        fk["PName"] = target_table["PKeys"][0]["Name"]
                resolved_fkeys.append(fk)
            else:
                # Omit unresolved foreign key rather than arbitrarily binding to table "0"
                pass
        t["FKeys"] = resolved_fkeys
                
    return {"Problem Number": schema_id, "Tables": tables, "Tuples": []}

def parse_polygon_constraints(ddl_text, schema_id="unknown"):
    from sqlglot import exp
    constraints = []
    
    def process_check_expr(expr, table_name):
        if isinstance(expr, exp.And):
            res_left = process_check_expr(expr.left, table_name)
            res_right = process_check_expr(expr.right, table_name)
            res = []
            if res_left:
                res.extend(res_left if isinstance(res_left, list) else [res_left])
            if res_right:
                res.extend(res_right if isinstance(res_right, list) else [res_right])
            return res if res else None

        op_map = {
            exp.GT: 'gt', exp.GTE: 'gte', exp.LT: 'lt', exp.LTE: 'lte', exp.NEQ: 'neq', exp.EQ: 'eq'
        }
        inv_map = {
            exp.GT: 'lt', exp.GTE: 'lte', exp.LT: 'gt', exp.LTE: 'gte', exp.NEQ: 'neq', exp.EQ: 'eq'
        }
        
        if type(expr) in op_map:
            left = expr.left
            right = expr.right
            op = op_map[type(expr)]
            
            # If left is literal/value and right is column, invert
            if not isinstance(left, exp.Column) and isinstance(right, exp.Column):
                left, right = right, left
                op = inv_map[type(expr)]
                
            if not isinstance(left, exp.Column):
                return None
            left_str = f"{table_name}.{left.name.lower()}"
            
            if isinstance(right, exp.Column):
                right_val = f"{table_name}.{right.name.lower()}"
            elif isinstance(right, exp.Neg) and isinstance(right.this, exp.Literal):
                raw = right.this.this
                right_val = -int(raw) if right.this.is_int else -float(raw)
            elif isinstance(right, exp.Literal):
                right_val = right.this
                if right.is_int: right_val = int(right_val)
                elif right.is_number: right_val = float(right_val)
            else:
                return None
                
            return {op: [left_str, right_val]}
        return None

    try:
        for stmt in sqlglot.parse(ddl_text, read='sqlite'):
            if stmt and stmt.key == 'create':
                schema_obj = stmt.this
                if schema_obj and schema_obj.key == 'schema':
                    table_name = schema_obj.this.name.lower()
                    
                    for expr in schema_obj.expressions:
                        if expr.key == 'uniquecolumnconstraint':
                            if isinstance(expr.this, exp.Schema):
                                cols = [f"{table_name}.{c.name.lower()}" for c in expr.this.expressions]
                                constraints.append({'distinct': cols})
                        elif expr.key == 'unique':
                            cols = [f"{table_name}.{c.name.lower()}" for c in expr.expressions]
                            constraints.append({'distinct': cols})
                        elif expr.key == 'checkcolumnconstraint':
                            parsed = process_check_expr(expr.this, table_name)
                            if parsed:
                                if isinstance(parsed, list):
                                    constraints.extend(parsed)
                                else:
                                    constraints.append(parsed)
                            
                    for col_def in schema_obj.expressions:
                        if col_def.key == 'columndef':
                            col_name = col_def.name.lower()
                            for constraint in col_def.args.get('constraints', []):
                                if constraint.kind.key == 'uniquecolumnconstraint':
                                    constraints.append({'distinct': [f"{table_name}.{col_name}"]})
                                elif constraint.kind.key == 'notnullcolumnconstraint':
                                    if not constraint.kind.args.get('allow_null'):
                                        constraints.append({'not_null': f"{table_name}.{col_name}"})
                                elif constraint.kind.key == 'checkcolumnconstraint':
                                    parsed = process_check_expr(constraint.kind.this, table_name)
                                    if parsed:
                                        if isinstance(parsed, list):
                                            constraints.extend(parsed)
                                        else:
                                            constraints.append(parsed)
    except Exception as e:
        logger.warning(f"Error parsing constraints for Polygon (Schema: {schema_id}): {e}")
    return constraints

def fix_sql_operators(sql):
    pattern = re.compile(
        r"""(
            '(?:''|[^'])*'  |
            "(?:""|[^"])*"  |
            `(?:``|[^`])*`  |
            /\*.*?\*/       |
            --.*?$
        ) | (>\s*=) | (<\s*=) | (!\s*=) | (&AMP;&AMP;)""", 
        re.DOTALL | re.MULTILINE | re.IGNORECASE | re.VERBOSE
    )

    def replacer(match):
        if match.group(1) is not None:
            return match.group(1)
        elif match.group(2) is not None:
            return ">="
        elif match.group(3) is not None:
            return "<="
        elif match.group(4) is not None:
            return "!="
        elif match.group(5) is not None:
            return "&&"
        return match.group(0)

    return pattern.sub(replacer, sql)

class WarningCounter(logging.Handler):
    def __init__(self):
        super().__init__()
        self.warnings = Counter()

    def emit(self, record):
        msg = record.getMessage()
        self.warnings[msg] += 1

sqlglot_logger = logging.getLogger("sqlglot")
sqlglot_logger.setLevel(logging.WARNING)
warning_counter = WarningCounter()
sqlglot_logger.addHandler(warning_counter)
sqlglot_logger.propagate = False  # Suppress from printing to stdout/stderr

BASE_DIR = os.path.dirname(__file__) or '.'

def get_original_path(rel_path: str) -> str:
    cand = os.path.join(BASE_DIR, 'originals', rel_path)
    if os.path.exists(cand):
        return cand
    return os.path.join(BASE_DIR, rel_path)

def generate_ddl_from_raw(schema_json_path, constraint_yml_path=None):
    if not os.path.exists(schema_json_path):
        return None
        
    with open(schema_json_path, 'r') as f:
        schema_data = json.load(f)
        
    tables = schema_data.get("Tables", [])
    if not tables:
        return None
        
    # Build a lookup for table index to table name (for FKeys PTable mapping)
    table_names = [t.get("TableName") for t in tables]
    
    not_nulls = {}
    unique_constraints = {}
    check_constraints = {}
    fk_constraints = {}

    if constraint_yml_path and os.path.exists(constraint_yml_path):
        # 1. Regex fallback for NOT NULL
        try:
            with open(constraint_yml_path, 'r') as f:
                content = f.read()
                matches = re.findall(r'(\w+)\.(\w+)\s*!=\s*NULL', content, flags=re.IGNORECASE)
                for t_name, c_name in matches:
                    not_nulls.setdefault(t_name.lower(), set()).add(c_name.lower())
        except Exception:
            pass

        # 2. Structured parsing with ConstraintParser
        if ConstraintParser:
            try:
                cp = ConstraintParser()
                raw_constraints = cp.parse_from_file(constraint_yml_path)
                for c in raw_constraints:
                    if 'not_null' in c:
                        attr = c['not_null']
                        if isinstance(attr, str) and '.' in attr:
                            t, col = attr.split('.', 1)
                            not_nulls.setdefault(t.lower(), set()).add(col.lower())
                    elif 'distinct' in c:
                        cols = c['distinct']
                        tbl_cols = {}
                        for attr in cols:
                            if isinstance(attr, str) and '.' in attr:
                                t, col = attr.split('.', 1)
                                tbl_cols.setdefault(t.lower(), []).append(col)
                        for t, cols_list in tbl_cols.items():
                            unique_constraints.setdefault(t.lower(), []).append(cols_list)
                    elif 'eq' in c:
                        pair = c['eq']
                        if len(pair) == 2 and isinstance(pair[0], str) and isinstance(pair[1], str) and '.' in pair[0] and '.' in pair[1]:
                            t1, c1 = pair[0].split('.', 1)
                            t2, c2 = pair[1].split('.', 1)
                            fk_constraints.setdefault(t1.lower(), []).append((c1, t2, c2))
                    elif any(op in c for op in ('gt', 'gte', 'lt', 'lte', 'neq')):
                        for op, op_sql in [('gt', '>'), ('gte', '>='), ('lt', '<'), ('lte', '<='), ('neq', '!=')]:
                            if op in c:
                                pair = c[op]
                                if len(pair) == 2:
                                    left, right = pair[0], pair[1]
                                    if isinstance(left, str) and '.' in left:
                                        t, col = left.split('.', 1)
                                        right_str = f"'{right}'" if isinstance(right, str) else str(right)
                                        check_constraints.setdefault(t.lower(), []).append(f'"{col}" {op_sql} {right_str}')
            except Exception as e:
                logger.warning(f"Error parsing constraints YAML {constraint_yml_path}: {e}")
                
    statements = []
    
    for idx, table in enumerate(tables):
        t_name = table.get("TableName")
        if not t_name or t_name.lower() == "sqlite_sequence": continue
        t_lower = t_name.lower()
        
        lines = []
        # Gather all columns (PKeys, FKeys, Others)
        cols = {}
        # 1. PKeys
        for pk in table.get("PKeys", []):
            if "Name" in pk and "Type" in pk:
                cols[pk["Name"]] = pk["Type"]
        
        # 2. FKeys (sometimes they just declare foreign relationship)
        for fk in table.get("FKeys", []):
            fname = fk.get("FName")
            if fname and fname not in cols:
                cols[fname] = "int" # Fallback type for FK if not defined
                
        # 3. Others
        for col in table.get("Others", []):
            if "Name" in col and "Type" in col:
                cols[col["Name"]] = col["Type"]
                
        # Write column definitions
        for c_name, c_type in cols.items():
            ctype_str = str(c_type).upper()
            if ctype_str.startswith('CHARACTER VARCHAR'):
                ctype_str = re.sub(r'^CHARACTER\s+VARCHAR', 'VARCHAR', ctype_str)
            if ctype_str in ('NONE', 'NULL', ''):
                ctype_str = 'VARCHAR(255)'
            elif ctype_str == 'VARCHAR':
                ctype_str = 'VARCHAR(255)'
            elif ctype_str == '0':
                ctype_str = 'INT'
            elif ctype_str.startswith('ENUM'):
                ctype_str = 'VARCHAR(255)'
                
            line = f'"{c_name}" {ctype_str}'
            if c_name.lower() in not_nulls.get(t_lower, set()):
                line += " NOT NULL"
            lines.append(line)
            
        # PKeys constraint
        pks = [pk["Name"] for pk in table.get("PKeys", []) if "Name" in pk]
        if pks:
            quoted_pks = [f'"{pk}"' for pk in pks]
            lines.append(f"PRIMARY KEY ({', '.join(quoted_pks)})")
            
        # FKeys constraint
        existing_fks = set()
        for fk in table.get("FKeys", []):
            fname = fk.get("FName")
            pname = fk.get("PName")
            ptable_idx = fk.get("PTable")
            
            if fname and pname and ptable_idx is not None:
                try:
                    ptable_idx = int(ptable_idx)
                    if 0 <= ptable_idx < len(table_names):
                        ptable_name = table_names[ptable_idx]
                        lines.append(f'FOREIGN KEY ("{fname}") REFERENCES "{ptable_name}"("{pname}")')
                        existing_fks.add((fname.lower(), ptable_name.lower(), pname.lower()))
                except ValueError:
                    # if ptable is a string name instead of an index
                    lines.append(f'FOREIGN KEY ("{fname}") REFERENCES "{ptable_idx}"("{pname}")')
                    existing_fks.add((fname.lower(), str(ptable_idx).lower(), pname.lower()))

        # Additional FKs from YAML constraints
        for fname, ptable_name, pname in fk_constraints.get(t_lower, []):
            fk_key = (fname.lower(), ptable_name.lower(), pname.lower())
            if fk_key not in existing_fks:
                lines.append(f'FOREIGN KEY ("{fname}") REFERENCES "{ptable_name}"("{pname}")')
                existing_fks.add(fk_key)

        # UNIQUE constraints from YAML
        for u_cols in unique_constraints.get(t_lower, []):
            if set(c.lower() for c in u_cols) != set(pk.lower() for pk in pks):
                quoted_ucols = [f'"{c}"' for c in u_cols]
                lines.append(f"UNIQUE ({', '.join(quoted_ucols)})")

        # CHECK constraints from YAML
        for chk in check_constraints.get(t_lower, []):
            lines.append(f"CHECK ({chk})")
                    
        ddl = f'CREATE TABLE "{t_name}" (\n    ' + ",\n    ".join(lines) + "\n);"
        statements.append(ddl)
        
    return "\n".join(statements)

def process_item_wrapper(args):
    i, item, schemas_data = args[:3]
    try:
        res, elim_stats, pair_warnings, elim_records = process_item(item, schemas_data)
        return i, res, elim_stats, pair_warnings, elim_records
    except Exception as e:
        print(f"Error on index {i}: {e}")
        return i, item, Counter(), Counter(), []

def process_item(item, schemas_data):
    # Attach local warning counter
    local_warning_counter = WarningCounter()
    sqlglot_logger = logging.getLogger("sqlglot")
    # Remove existing handlers to avoid duplicates in worker
    sqlglot_logger.handlers = []
    sqlglot_logger.addHandler(local_warning_counter)
    
    dialect = item.get('dialect')
    if not dialect:
        raise Exception("Default dialect not found")

    gold_sql = fix_sql_operators(item['gold_sql'])
    db_id = item.get('schema_id')
    item_id = item.get('id')
    schema_dict = schemas_data.get(db_id, {}).get("sqlglot_schema", {})
    schema = MappingSchema(schema_dict)
    ddl_text = schemas_data.get(db_id, {}).get("ddl", "")

    elimination_stats = Counter()
    pair_warnings = Counter()
    eliminated_dict = {}

    def record_elimination(reason, key_sql, orig_pred_sql, sources, display_reason=None):
        rec_reason = display_reason or reason
        k = (reason, key_sql)
        if k not in eliminated_dict:
            eliminated_dict[k] = {
                "schema_id": db_id,
                "id": item_id,
                "gold_sql": gold_sql,
                "prediction_sql": orig_pred_sql,
                "reason": rec_reason,
                "sources": list(sources)
            }
        else:
            for s in sources:
                if s not in eliminated_dict[k]["sources"]:
                    eliminated_dict[k]["sources"].append(s)

    # 1. Gold query DML check
    if gold_sql.strip().upper().startswith(('UPDATE', 'INSERT', 'DELETE', 'DROP', 'ALTER')):
        reason = "Gold Query is DML"
        preds = item.get('predictions', [])
        elimination_stats[reason] += len(preds)
        for pred in preds:
            s = pred.get('source', [])
            sources = s if isinstance(s, list) else [s]
            record_elimination(reason, pred.get('prediction_sql', ''), pred.get('prediction_sql', ''), sources)
        item['predictions'] = []
        return item, elimination_stats, pair_warnings, list(eliminated_dict.values())


    # 2. Normalize gold_sql
    for sqlglot_dialect in ['sqlite', 'mysql', 'postgres']:
        output_dialect = 'postgresql' if sqlglot_dialect == 'postgres' else sqlglot_dialect
        if dialect in ('postgres', 'postgresql') and output_dialect == 'postgresql':
            item[f"gold_sql_{output_dialect}"] = gold_sql
        else:
            try:
                item[f"gold_sql_{output_dialect}"] = normalize_sql(gold_sql, schema=ddl_text, dialect=dialect, write_dialect=sqlglot_dialect, mock_time=True, augment_order=True)
            except Exception as e:
                item.setdefault("errors", []).append({"type": "normalize_error", "message": str(e), "target": f"gold_sql_{output_dialect}"})
                item[f"gold_sql_{output_dialect}"] = gold_sql

    # Precompute sanitized gold_sql for SpotIt
    item["gold_sql_spotit"] = clean_up_spotit_sql(item.get("gold_sql_sqlite", gold_sql))

    # 3. Create SQLite connection for schema validation
    sqlite_conn = create_sqlite_connection(ddl_text) if ddl_text else None

    # Check SQLite validity of gold
    gold_sqlite = item.get("gold_sql_sqlite", gold_sql)
    if sqlite_conn:
        is_valid, err_msg = check_sqlite_query_validity(ddl_text, gold_sqlite, conn=sqlite_conn)
        if not is_valid:
            stat_reason = "Gold Query Invalid for SQLite"
            rec_reason = f"Gold Query Invalid for SQLite ({err_msg})" if err_msg else stat_reason
            preds = item.get('predictions', [])
            elimination_stats[stat_reason] += len(preds)
            for pred in preds:
                s = pred.get('source', [])
                sources = s if isinstance(s, list) else [s]
                record_elimination(stat_reason, pred.get('prediction_sql', ''), pred.get('prediction_sql', ''), sources, display_reason=rec_reason)
            sqlite_conn.close()
            item['predictions'] = []
            return item, elimination_stats, pair_warnings, list(eliminated_dict.values())

    # 4. AST Optimization and column count for gold
    gold_col_count = None
    gold_equiv_key = item.get("gold_sql_sqlite", gold_sql)
    try:
        ast = sqlglot.parse_one(gold_equiv_key, read='sqlite')
        opt_ast = optimize(ast, schema=schema)
        gold_equiv_key = opt_ast.sql(dialect='sqlite')
        gold_col_count = get_query_output_column_count(opt_ast, schema_dict)
    except Exception:
        try:
            ast = sqlglot.parse_one(gold_equiv_key, read='sqlite')
            gold_col_count = get_query_output_column_count(ast, schema_dict)
        except Exception:
            pass

    unique_preds = {}
    
    for pred in item.get('predictions', []):
        pred_sql = fix_sql_operators(pred['prediction_sql'])
        sources = pred['source']
        if not isinstance(sources, list):
            sources = [sources]

        # 5. Prediction DML check
        if pred_sql.strip().upper().startswith(('UPDATE', 'INSERT', 'DELETE', 'DROP', 'ALTER')):
            reason = "Prediction is DML"
            elimination_stats[reason] += 1
            record_elimination(reason, pred_sql, pred_sql, sources)
            continue

            
        pred_col_count = None
        norm_pred = None
        try:
            norm_pred = normalize_sql(pred_sql, schema=ddl_text, dialect=dialect, write_dialect='sqlite', mock_time=True, augment_order=True)
            ast = sqlglot.parse_one(norm_pred, read='sqlite')
            opt_ast = optimize(ast, schema=schema)
            equiv_key = opt_ast.sql(dialect='sqlite')
            pred_col_count = get_query_output_column_count(opt_ast, schema_dict)
        except Exception as e:
            pred.setdefault("errors", []).append({"type": "normalize_error", "message": str(e), "target": "prediction_sql"})
            equiv_key = pred_sql
            try:
                ast = sqlglot.parse_one(equiv_key, read='sqlite')
                pred_col_count = get_query_output_column_count(ast, schema_dict)
            except Exception:
                pass
            
        # 6. AST Equivalence to Gold
        if equiv_key == gold_equiv_key:
            reason = "Equal to Gold"
            elimination_stats[reason] += 1
            record_elimination(reason, equiv_key, pred_sql, sources)
            continue

        # 7. Check SQLite validity of prediction query
        if sqlite_conn and norm_pred:
            is_valid, err_msg = check_sqlite_query_validity(ddl_text, norm_pred, conn=sqlite_conn)
            if not is_valid:
                stat_reason = "Prediction Invalid for SQLite"
                rec_reason = f"Prediction Invalid for SQLite ({err_msg})" if err_msg else stat_reason
                elimination_stats[stat_reason] += 1
                record_elimination(stat_reason, equiv_key, pred_sql, sources, display_reason=rec_reason)
                continue
            
        # 8. Check column count (fewer columns than gold is eliminated, extra columns is preserved)
        if gold_col_count is not None and pred_col_count is not None and pred_col_count < gold_col_count:
            reason = "Prediction query SELECT clause has fewer output columns than Gold query"
            elimination_stats[reason] += 1
            record_elimination(reason, equiv_key, pred_sql, sources)
            continue
            
        # 9. Deduplicate predictions
        if equiv_key not in unique_preds:
            local_warning_counter.warnings.clear()
            pred['prediction_sql_sqlite'] = norm_pred if norm_pred else pred_sql
            
            # normalize for mysql and postgres (avoid re-normalizing sqlite)
            for sqlglot_dialect in ['mysql', 'postgres']:
                output_dialect = 'postgresql' if sqlglot_dialect == 'postgres' else sqlglot_dialect
                if dialect in ('postgres', 'postgresql') and output_dialect == 'postgresql':
                    pred[f"prediction_sql_{output_dialect}"] = pred_sql
                else:
                    try:
                        pred[f"prediction_sql_{output_dialect}"] = normalize_sql(pred_sql, schema=ddl_text, dialect=dialect, write_dialect=sqlglot_dialect, mock_time=True, augment_order=True)
                    except Exception as e:
                        pred.setdefault("errors", []).append({"type": "normalize_error", "message": str(e), "target": f"prediction_sql_{output_dialect}"})
                        pred[f"prediction_sql_{output_dialect}"] = pred_sql
                    
            pred['source'] = sources

            # Precompute sanitized prediction_sql and SMT theory config for SpotIt
            pred_spotit = clean_up_spotit_sql(pred.get("prediction_sql_sqlite", pred_sql))
            pred["prediction_sql_spotit"] = pred_spotit
            gold_spotit = item.get("gold_sql_spotit", "")
            full_text = f"{gold_spotit} {pred_spotit}".upper()
            needs_date = any(k in full_text for k in ["STRFTIME", "JULIANDAY"]) or bool(re.search(DATE_SHIFT_PATTERN, full_text))
            needs_str = any(k in full_text for k in [" LIKE ", "SUBSTR", "||"]) or needs_date
            pred["spotit_config"] = {
                "encode_date": bool(needs_date),
                "encode_string": bool(needs_str)
            }

            unique_preds[equiv_key] = pred
            
            # Count each unique warning that occurred for this pair exactly once
            for w in local_warning_counter.warnings.keys():
                pair_warnings[w] += 1
        else:
            reason = "Duplicate Prediction"
            elimination_stats[reason] += 1
            record_elimination(reason, equiv_key, pred_sql, sources)
            for s in sources:
                if s not in unique_preds[equiv_key]['source']:
                    unique_preds[equiv_key]['source'].append(s)
                    
    if sqlite_conn:
        sqlite_conn.close()

    item['predictions'] = list(unique_preds.values())
    eliminated_records = list(eliminated_dict.values())
    return item, elimination_stats, pair_warnings, eliminated_records

def build_lasso_bm_schemas(enrich: bool = True):
    """
    Extracts schemas for LASSO-BM from test_cases/ directory.
    Enriches them with Polygon, SpotIt, and PostgreSQL representations if enrich=True.
    """
    schemas = {}
    test_cases_dir = os.path.abspath(os.path.join(BASE_DIR, '..', 'test_cases'))
    if not os.path.exists(test_cases_dir):
        logger.warning(f"test_cases directory not found: {test_cases_dir}")
        return schemas

    for tf in sorted(glob.glob(os.path.join(test_cases_dir, '**', '*.json'), recursive=True)):
        try:
            with open(tf, 'r', encoding='utf-8') as f:
                data = json.load(f)
            rel = os.path.relpath(tf, test_cases_dir)
            base_no_ext = os.path.splitext(rel)[0].replace('/', '_').replace('-', '_').replace('.', '_')
            schema_id = f"lasso_{base_no_ext}"

            schema_ddl = data.get('schema', '')
            if isinstance(schema_ddl, list):
                schema_ddl = '\n'.join(schema_ddl)
            if schema_ddl and not schema_ddl.strip().endswith(';'):
                schema_ddl += ';'
            if not schema_ddl.strip():
                continue

            schema_ddl = ensure_foreign_key_constraints(schema_ddl)
            poly_schema = parse_ddl_to_polygon(schema_ddl, schema_id)
            poly_constraints = parse_polygon_constraints(schema_ddl, schema_id)

            schema_entry = {
                "source": "lasso-bm",
                "ddl": schema_ddl,
                "polygon_schema": poly_schema,
                "polygon_constraints": poly_constraints
            }

            if enrich:
                schema_entry["ddl_postgres"] = prepare_postgres_ddl(schema_ddl)
                try:
                    uir = schema_translator.parse_ddl_to_uir(schema_ddl)
                    spotit_s, spotit_c = schema_translator.uir_to_spotit_format(uir)
                    schema_entry["spotit_schema"] = spotit_s
                    schema_entry["spotit_constraints"] = spotit_c
                    schema_entry["spotit_ddl"] = transform_ddl_for_spotit(uir)
                except Exception as e:
                    schema_entry["spotit_schema"] = {}
                    schema_entry["spotit_constraints"] = []
                    schema_entry["spotit_ddl"] = ""

            schemas[schema_id] = schema_entry
        except Exception as e:
            logger.warning(f"Error processing lasso schema from {tf}: {e}")

    return schemas

def build_lasso_bm_queries(schemas_data):
    """
    Extracts raw query items for LASSO-BM from test_cases/ directory.
    """
    queries = []
    test_cases_dir = os.path.abspath(os.path.join(BASE_DIR, '..', 'test_cases'))
    if not os.path.exists(test_cases_dir):
        return queries

    for tf in sorted(glob.glob(os.path.join(test_cases_dir, '**', '*.json'), recursive=True)):
        try:
            with open(tf, 'r', encoding='utf-8') as f:
                data = json.load(f)
            rel = os.path.relpath(tf, test_cases_dir)
            base_no_ext = os.path.splitext(rel)[0].replace('/', '_').replace('-', '_').replace('.', '_')
            schema_id = f"lasso_{base_no_ext}"
            gold_sql = data.get('correct_query', '').strip()
            if not gold_sql:
                continue

            mutants = []
            if 'expected_semantic_errors_to_be_caught' in data:
                mutants = data['expected_semantic_errors_to_be_caught']
            elif 'expected_mutants_to_kill' in data:
                mutants = data['expected_mutants_to_kill']
            elif 'predict_query' in data:
                mutants = [{'id': 'pred', 'query': data['predict_query']}]

            preds = []
            for m_idx, m in enumerate(mutants):
                pred_sql = (m.get('query') or m.get('mutant_query') or '').strip()
                m_id = m.get('id') or m.get('type') or f"mutant_{m_idx}"
                if pred_sql:
                    preds.append({
                        'prediction_sql': pred_sql,
                        'source': [str(m_id)]
                    })

            if preds:
                queries.append({
                    'id': f"lasso_{base_no_ext}",
                    'source': 'lasso-bm',
                    'dialect': data.get('dialect', 'sqlite'),
                    'schema_id': schema_id,
                    'gold_sql': gold_sql,
                    'predictions': preds
                })
        except Exception as e:
            logger.warning(f"Error loading lasso query from {tf}: {e}")

    return queries

def build_schemas():
    schemas = {}
    
    # Process BIRD schemas
    print("Processing BIRD schemas from DDL source...")
    bird_schema_path = get_original_path('ParSEval/data/sqlite/schema.json')
    if os.path.exists(bird_schema_path):
        with open(bird_schema_path, 'r') as f:
            bird_ddls = json.load(f)
            
        for db_id, ddl_list in bird_ddls.items():
            ddl_text = ";\n".join(ddl_list) + ";"
            ddl_text = re.sub(r'\bVARCHAR\b(?!\s*\()', 'VARCHAR(255)', ddl_text, flags=re.IGNORECASE)
            ddl_text = ensure_foreign_key_constraints(ddl_text)
            
            schemas[db_id] = {
                "source": "bird",
                "ddl": ddl_text,
                "polygon_schema": parse_ddl_to_polygon(ddl_text, db_id),
                "polygon_constraints": parse_polygon_constraints(ddl_text, db_id)
            }
            
    # Process XData-BM schema
    print("Processing XData-BM schema...")
    xdata_ddl_path = get_original_path('xdatapublic/benchmarks/XData-BM/DDL.sql')
    if os.path.exists(xdata_ddl_path):
        with open(xdata_ddl_path, 'r') as f:
            raw_pg_ddl = f.read()
        ddl_text = ensure_foreign_key_constraints(raw_pg_ddl)
        schemas["xdata_bm"] = {
            "source": "xdata",
            "ddl": ddl_text,
            "ddl_postgres": raw_pg_ddl,
            "polygon_schema": parse_ddl_to_polygon(ddl_text, "xdata_bm"),
            "polygon_constraints": parse_polygon_constraints(ddl_text, "xdata_bm")
        }

    # Process TPCH schema
    print("Processing TPCH schema...")
    tpch_ddl_path = get_original_path('xdatapublic/benchmarks/TPCH/DDL.sql')
    if os.path.exists(tpch_ddl_path):
        with open(tpch_ddl_path, 'r') as f:
            raw_pg_ddl = f.read()
        ddl_text = ensure_foreign_key_constraints(raw_pg_ddl)
        schemas["tpch"] = {
            "source": "tpch",
            "ddl": ddl_text,
            "ddl_postgres": raw_pg_ddl,
            "polygon_schema": parse_ddl_to_polygon(ddl_text, "tpch"),
            "polygon_constraints": parse_polygon_constraints(ddl_text, "tpch")
        }

    # Process LargeJoin schema
    print("Processing LargeJoin schema...")
    largejoin_ddl_path = get_original_path('xdatapublic/benchmarks/LargeJoin/DDL.sql')
    if os.path.exists(largejoin_ddl_path):
        with open(largejoin_ddl_path, 'r') as f:
            raw_pg_ddl = f.read()
        ddl_text = ensure_foreign_key_constraints(raw_pg_ddl)
        schemas["largejoin"] = {
            "source": "largejoin",
            "ddl": ddl_text,
            "ddl_postgres": raw_pg_ddl,
            "polygon_schema": parse_ddl_to_polygon(ddl_text, "largejoin"),
            "polygon_constraints": parse_polygon_constraints(ddl_text, "largejoin")
        }
            
    # Process Polygon schemas dynamically based on queries
    print("Discovering Polygon schemas based on queries...")
    polygon_base = get_original_path('polygon-artifact-evaluation-extracted/benchmarks')
    
    schema_refs = set()
    
    # 1. Calcite
    calcite_jl = os.path.join(polygon_base, 'calcite/calcite2.jsonlines')
    if os.path.exists(calcite_jl):
        with open(calcite_jl, 'r') as f:
            if any(line.strip() for line in f):
                schema_refs.add(('calcite', 'calcite/schema.json', 'calcite/constraints.yml'))
                
    # 2. Literature
    literature_jl = os.path.join(polygon_base, 'literature/literature-rewrite.jsonlines')
    if os.path.exists(literature_jl):
        with open(literature_jl, 'r') as f:
            for line in f:
                if not line.strip(): continue
                data = json.loads(line)
                bench = data.get('benchmark')
                if bench:
                    schema_refs.add(('literature', f'literature/schemas/{bench}.json', None))
                    
    # 3. Cubes
    cubes_jl = os.path.join(polygon_base, 'cubes/all.jsonlines')
    if os.path.exists(cubes_jl):
        with open(cubes_jl, 'r') as f:
            for line in f:
                if not line.strip(): continue
                data = json.loads(line)
                sch = data.get('schema')
                if sch:
                    schema_refs.add(('cubes', f'cubes/schema/{sch}', None))
                    
    # 4. LeetCode
    leetcode_gt = os.path.join(polygon_base, 'leetcode/groundtruths')
    if os.path.exists(leetcode_gt):
        for csv_file in glob.glob(os.path.join(leetcode_gt, '*.csv')):
            problem_id = os.path.basename(csv_file).replace('.csv', '')
            schema_refs.add(('leetcode', f'leetcode/schemas/{problem_id}.json', f'leetcode/constraints/{problem_id}.yml'))
            
    print(f"Found {len(schema_refs)} unique schema references used by queries.")
    
    for source, schema_rel, constraint_rel in schema_refs:
        schema_path = os.path.join(polygon_base, schema_rel)
        constraint_path = os.path.join(polygon_base, constraint_rel) if constraint_rel else None
        
        schema_id = f"PL/{schema_rel}"
        
        if not os.path.exists(schema_path) and '/spider/' in schema_path:
            bak_path = schema_path.replace('/spider/', '/spider_bak/')
            if os.path.exists(bak_path):
                schema_path = bak_path

        if not os.path.exists(schema_path):
            logger.warning(f"Raw schema file not found: {schema_path} (referenced by {source})")
            continue
            
        ddl_text = generate_ddl_from_raw(schema_path, constraint_path)
        if ddl_text:
            ddl_text = ensure_foreign_key_constraints(ddl_text)
            with open(schema_path, 'r') as f:
                polygon_schema_data = json.load(f)
            polygon_schema_data = sanitize_polygon_schema(polygon_schema_data)
                
            poly_constraints = []
            if constraint_path and os.path.exists(constraint_path) and ConstraintParser:
                try:
                    poly_constraints = ConstraintParser().parse_from_file(constraint_path)
                except Exception as e:
                    logger.warning(f"Error parsing polygon constraints for {schema_id}: {e}")
                    poly_constraints = []
            if not poly_constraints:
                poly_constraints = parse_polygon_constraints(ddl_text, schema_id)
                    
            schemas[schema_id] = {
                "source": source,
                "ddl": ddl_text,
                "polygon_schema": polygon_schema_data,
                "polygon_constraints": poly_constraints
            }

    # Process MM-BM and its obfuscated variants (MMO-BM, MMRO-BM)
    mm_suites_info = [
        ("mm-bm", "schema.sql"),
        ("mmo-bm", "schema_mmo.sql"),
        ("mmro-bm", "schema_mmro.sql")
    ]
    for b_source, schema_filename in mm_suites_info:
        print(f"Processing {b_source.upper()} schema...")
        s_path = get_original_path(f'MM-BM/{schema_filename}')
        if not os.path.exists(s_path) and b_source == "mm-bm":
            s_path = get_original_path('ManyMutantsBM/schema.sql')
        if not os.path.exists(s_path):
            gen_script = get_original_path('MM-BM/generate_variants.py')
            if os.path.exists(gen_script):
                import subprocess
                subprocess.run([sys.executable, gen_script], check=False)
        if os.path.exists(s_path):
            with open(s_path, 'r', encoding='utf-8') as f:
                ddl_text = f.read()
            ddl_text = ensure_foreign_key_constraints(ddl_text)
            schemas[b_source] = {
                "source": b_source,
                "ddl": ddl_text,
                "polygon_schema": parse_ddl_to_polygon(ddl_text, b_source),
                "polygon_constraints": parse_polygon_constraints(ddl_text, b_source)
            }

    # Process LASSO-BM schemas from test_cases/
    print("Discovering LASSO-BM schemas from test_cases/...")
    lasso_schemas = build_lasso_bm_schemas(enrich=False)
    schemas.update(lasso_schemas)
    print(f"Added {len(lasso_schemas)} schemas for lasso-bm.")
            
    print("Enriching schemas with PostgreSQL DDL and SpotIt schemas/constraints...")
    for schema_id, schema_data in schemas.items():
        ddl_text = schema_data.get("ddl", "")
        if ddl_text:
            if not schema_data.get("ddl_postgres"):
                schema_data["ddl_postgres"] = prepare_postgres_ddl(ddl_text)
            try:
                uir = schema_translator.parse_ddl_to_uir(ddl_text)
                spotit_s, spotit_c = schema_translator.uir_to_spotit_format(uir)
                schema_data["spotit_schema"] = spotit_s
                schema_data["spotit_constraints"] = spotit_c
                schema_data["spotit_ddl"] = transform_ddl_for_spotit(uir)
            except Exception as e:
                logger.warning(f"Failed to generate spotit schema/constraints for {schema_id}: {e}")
                schema_data["spotit_schema"] = {}
                schema_data["spotit_constraints"] = []
                schema_data["spotit_ddl"] = ""
        else:
            schema_data["ddl_postgres"] = ""
            schema_data["spotit_schema"] = {}
            schema_data["spotit_constraints"] = []
            schema_data["spotit_ddl"] = ""

    # Save unified schemas
    out_path = os.path.join(BASE_DIR, 'schemas.json')
    with open(out_path, 'w') as f:
        json.dump(schemas, f, indent=2, default=str)
        
    print(f"Successfully generated schemas.json with {len(schemas)} total schemas.")
    return schemas

def build_queries(schemas_data):
    print("Pre-parsing schemas for SQLGlot...")
    for db_id, data in schemas_data.items():
        ddl = data.get("ddl", "")
        schema_dict = {}
        try:
            for stmt in sqlglot.parse(ddl, read='sqlite'):
                if stmt and stmt.key == 'create':
                    schema_obj = stmt.this
                    if schema_obj and schema_obj.key == 'schema':
                        table_name = normalize_name(schema_obj.this.name)
                        columns = {}
                        for col_def in schema_obj.expressions:
                            if col_def.key == 'columndef':
                                kind = col_def.args.get('kind')
                                t = kind.this.name if kind and hasattr(kind, 'this') and hasattr(kind.this, 'name') else 'TEXT'
                                col_name = normalize_name(col_def.name)
                                columns[col_name] = t
                        schema_dict[table_name] = columns
        except Exception:
            pass
        data["sqlglot_schema"] = schema_dict

    queries_dict = {}

    # 1. BIRD Queries
    bird_dev_path = get_original_path('ParSEval/data/sqlite/dev.json')
    if os.path.exists(bird_dev_path):
        with open(bird_dev_path, 'r') as f:
            bird_dev = json.load(f)
            
        for item in bird_dev:
            q_id = item['question_id']
            schema_id = item['db_id']
            gold_sql = item['SQL']
            k = (schema_id, gold_sql)
            if k not in queries_dict:
                queries_dict[k] = {
                    'id': f"bird_{q_id}",
                    'source': 'bird',
                    'dialect': 'sqlite',
                    'schema_id': schema_id,
                    'gold_sql': gold_sql,
                    'predictions': []
                }
                
        # DAIL predictions
        dail_path = get_original_path('ParSEval/data/sqlite/dail.txt')
        if os.path.exists(dail_path):
            with open(dail_path, 'r') as f:
                dail_preds = [line.strip() for line in f]
                for i, item in enumerate(bird_dev):
                    if i < len(dail_preds):
                        k = (item['db_id'], item['SQL'])
                        queries_dict[k]['predictions'].append({
                            'prediction_sql': dail_preds[i],
                            'source': ['dail']
                        })
                        
        # SpotIt-plus predictions
        pred_dir = get_original_path('SpotIt-plus/verieql/predictions')
        if os.path.exists(pred_dir):
            for pred_file in glob.glob(os.path.join(pred_dir, '*.json')):
                model_name = os.path.basename(pred_file).replace('_sql.json', '')
                with open(pred_file, 'r') as f:
                    preds = json.load(f)
                    for q_id_str, sql in preds.items():
                        q_id = int(q_id_str)
                        if q_id < len(bird_dev):
                            item = bird_dev[q_id]
                            k = (item['db_id'], item['SQL'])
                            clean_sql = sql.split('\t-----')[0].strip() if sql else ""
                            if clean_sql:
                                queries_dict[k]['predictions'].append({
                                    'prediction_sql': clean_sql,
                                    'source': [model_name]
                                })
                            
    # 2. Polygon Queries
    polygon_base = get_original_path('polygon-artifact-evaluation-extracted/benchmarks')
    
    # 2.a Calcite
    calcite_jl = os.path.join(polygon_base, 'calcite/calcite2.jsonlines')
    if os.path.exists(calcite_jl):
        schema_id = "PL/calcite/schema.json"
        with open(calcite_jl, 'r') as f:
            for idx, line in enumerate(f):
                if not line.strip(): continue
                data = json.loads(line)
                gold_sql = data.get('pair', ['', ''])[0]
                pred_sql = data.get('pair', ['', ''])[1]
                if not gold_sql: continue
                
                k = (schema_id, gold_sql)
                if k not in queries_dict:
                    queries_dict[k] = {
                        'id': f"calcite_{idx}",
                        'source': 'calcite',
                        'dialect': 'mysql',
                        'schema_id': schema_id,
                        'gold_sql': gold_sql,
                        'predictions': []
                    }
                if pred_sql:
                    queries_dict[k]['predictions'].append({'prediction_sql': pred_sql, 'source': ['calcite']})
                    
    # 2.b Literature
    literature_jl = os.path.join(polygon_base, 'literature/literature-rewrite.jsonlines')
    if os.path.exists(literature_jl):
        with open(literature_jl, 'r') as f:
            for idx, line in enumerate(f):
                if not line.strip(): continue
                data = json.loads(line)
                bench = data.get('benchmark')
                if not bench: continue
                schema_id = f"PL/literature/schemas/{bench}.json"
                gold_sql = data.get('pair', ['', ''])[0]
                pred_sql = data.get('pair', ['', ''])[1]
                if not gold_sql: continue
                
                k = (schema_id, gold_sql)
                if k not in queries_dict:
                    queries_dict[k] = {
                        'id': f"literature_{idx}",
                        'source': 'literature',
                        'dialect': 'mysql',
                        'schema_id': schema_id,
                        'gold_sql': gold_sql,
                        'predictions': []
                    }
                if pred_sql:
                    queries_dict[k]['predictions'].append({'prediction_sql': pred_sql, 'source': ['literature']})
                    
    # 2.c Cubes
    cubes_jl = os.path.join(polygon_base, 'cubes/all.jsonlines')
    if os.path.exists(cubes_jl):
        with open(cubes_jl, 'r') as f:
            for idx, line in enumerate(f):
                if not line.strip(): continue
                data = json.loads(line)
                sch = data.get('schema')
                if not sch: continue
                schema_id = f"PL/cubes/schema/{sch}"
                gold_sql = data.get('sql1')
                pred_sql = data.get('sql2')
                if not gold_sql: continue
                
                k = (schema_id, gold_sql)
                if k not in queries_dict:
                    queries_dict[k] = {
                        'id': f"cubes_{idx}",
                        'source': 'cubes',
                        'dialect': 'mysql',
                        'schema_id': schema_id,
                        'gold_sql': gold_sql,
                        'predictions': []
                    }
                if pred_sql:
                    queries_dict[k]['predictions'].append({'prediction_sql': pred_sql, 'source': ['cubes']})
                    
    # 2.d LeetCode
    leetcode_gt = os.path.join(polygon_base, 'leetcode/groundtruths')
    leetcode_pred = os.path.join(polygon_base, 'leetcode/verieql_queries')
    if os.path.exists(leetcode_gt):
        for csv_file in glob.glob(os.path.join(leetcode_gt, '*.csv')):
            problem_id = os.path.basename(csv_file).replace('.csv', '')
            schema_id = f"PL/leetcode/schemas/{problem_id}.json"
            
            gold_sqls = []
            with open(csv_file, 'r') as f:
                reader = csv.reader(f)
                header = next(reader, None)
                for row in reader:
                    if row and len(row) >= 2 and row[1].strip():
                        gold_sqls.append(row[1].strip())
            if not gold_sqls: continue
            
            pred_file = os.path.join(leetcode_pred, f"{problem_id}.csv")
            preds = []
            if os.path.exists(pred_file):
                with open(pred_file, 'r') as f:
                    reader = csv.reader(f)
                    header = next(reader, None)
                    for row in reader:
                        if row and len(row) >= 4 and row[3].strip():
                            preds.append(row[3].strip())
            
            for g_idx, gold_sql in enumerate(gold_sqls):
                k = (schema_id, gold_sql)
                q_id = f"leetcode_{problem_id}" if len(gold_sqls) == 1 else f"leetcode_{problem_id}_g{g_idx}"
                if k not in queries_dict:
                    queries_dict[k] = {
                        'id': q_id,
                        'source': 'leetcode',
                        'dialect': 'mysql',
                        'schema_id': schema_id,
                        'gold_sql': gold_sql,
                        'predictions': []
                    }
                for pred_sql in preds:
                    queries_dict[k]['predictions'].append({'prediction_sql': pred_sql, 'source': ['leetcode_verieql']})
                                
    # 7. XData-BM
    print("Processing XData-BM...")
    xdata_queries_file = get_original_path('xdatapublic/benchmarks/XData-BM/queries.txt')
    xdata_mutants_file = get_original_path('xdatapublic/benchmarks/XData-BM/mutants.txt')
    
    xdata_dict = {}
    if os.path.exists(xdata_queries_file):
        with open(xdata_queries_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    gold_sql = parts[2].strip()
                    k = ("xdata_bm", gold_sql)
                    if k not in queries_dict:
                        queries_dict[k] = {
                            'id': f"xdata_{q_id}",
                            'source': 'xdata',
                            'dialect': 'postgresql',
                            'schema_id': 'xdata_bm',
                            'gold_sql': gold_sql,
                            'predictions': []
                        }
                    xdata_dict[q_id] = k

    if os.path.exists(xdata_mutants_file):
        with open(xdata_mutants_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    mutant_type = parts[1].strip()
                    pred_sql = parts[2].strip()
                    if q_id in xdata_dict:
                        k = xdata_dict[q_id]
                        queries_dict[k]['predictions'].append({
                            'prediction_sql': pred_sql,
                            'source': [f"xdata_{mutant_type}"]
                        })

    # 8. TPCH
    print("Processing TPCH...")
    tpch_queries_file = get_original_path('xdatapublic/benchmarks/TPCH/queries.txt')
    tpch_mutants_file = get_original_path('xdatapublic/benchmarks/TPCH/mutants.txt')

    tpch_dict = {}
    if os.path.exists(tpch_queries_file):
        with open(tpch_queries_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('--') or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    gold_sql = parts[2].strip()
                    k = ("tpch", gold_sql)
                    if k not in queries_dict:
                        queries_dict[k] = {
                            'id': f"tpch_{q_id}",
                            'source': 'tpch',
                            'dialect': 'postgres',
                            'schema_id': 'tpch',
                            'gold_sql': gold_sql,
                            'predictions': []
                        }
                    tpch_dict[q_id] = k

    if os.path.exists(tpch_mutants_file):
        with open(tpch_mutants_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('--') or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    mutant_type = parts[1].strip()
                    pred_sql = parts[2].strip()
                    if q_id in tpch_dict:
                        k = tpch_dict[q_id]
                        queries_dict[k]['predictions'].append({
                            'prediction_sql': pred_sql,
                            'source': [f"tpch_{mutant_type}"]
                        })
                    
    # 9. LargeJoin
    print("Processing LargeJoin...")
    largejoin_queries_file = get_original_path('xdatapublic/benchmarks/LargeJoin/queries.txt')
    largejoin_mutants_file = get_original_path('xdatapublic/benchmarks/LargeJoin/mutants.txt')

    largejoin_dict = {}
    if os.path.exists(largejoin_queries_file):
        with open(largejoin_queries_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('--') or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    gold_sql = parts[2].strip()
                    k = ("largejoin", gold_sql)
                    if k not in queries_dict:
                        queries_dict[k] = {
                            'id': f"largejoin_{q_id}",
                            'source': 'largejoin',
                            'dialect': 'postgres',
                            'schema_id': 'largejoin',
                            'gold_sql': gold_sql,
                            'predictions': []
                        }
                    largejoin_dict[q_id] = k

    if os.path.exists(largejoin_mutants_file):
        with open(largejoin_mutants_file, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('--') or line.startswith('='):
                    continue
                parts = line.split('|', 2)
                if len(parts) == 3:
                    q_id = parts[0].strip()
                    mutant_type = parts[1].strip()
                    pred_sql = parts[2].strip()
                    if q_id in largejoin_dict:
                        k = largejoin_dict[q_id]
                        queries_dict[k]['predictions'].append({
                            'prediction_sql': pred_sql,
                            'source': [f"largejoin_{mutant_type}"]
                        })

    # 10. LASSO-BM
    print("Processing LASSO-BM from test_cases/...")
    lasso_raw_queries = build_lasso_bm_queries(schemas_data)
    for item in lasso_raw_queries:
        k = (item['schema_id'], item['gold_sql'])
        if k not in queries_dict:
            queries_dict[k] = item
        else:
            queries_dict[k]['predictions'].extend(item['predictions'])

    # 11. MM-BM and its obfuscated variants (MMO-BM, MMRO-BM)
    mm_suites_config = [
        ("mm-bm", "queries.txt", "mutants.txt", "mm"),
        ("mmo-bm", "queries_mmo.txt", "mutants_mmo.txt", "mmo"),
        ("mmro-bm", "queries_mmro.txt", "mutants_mmro.txt", "mmro")
    ]
    for b_source, q_file, m_file, id_pfx in mm_suites_config:
        print(f"Processing {b_source.upper()} from originals/MM-BM...")
        suite_queries_file = get_original_path(f'MM-BM/{q_file}')
        if not os.path.exists(suite_queries_file) and b_source == "mm-bm":
            suite_queries_file = get_original_path('ManyMutantsBM/queries.txt')
        suite_mutants_file = get_original_path(f'MM-BM/{m_file}')
        if not os.path.exists(suite_mutants_file) and b_source == "mm-bm":
            suite_mutants_file = get_original_path('ManyMutantsBM/mutants.txt')

        if not os.path.exists(suite_queries_file):
            gen_script = get_original_path('MM-BM/generate_variants.py')
            if os.path.exists(gen_script):
                import subprocess
                subprocess.run([sys.executable, gen_script], check=False)

        suite_dict = {}
        if os.path.exists(suite_queries_file):
            with open(suite_queries_file, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if not line or line.startswith('#') or line.startswith('='):
                        continue
                    parts = line.split('|', 2)
                    if len(parts) >= 2:
                        q_id = parts[0].strip()
                        gold_sql = parts[-1].strip()
                        k = (b_source, gold_sql)
                        if k not in queries_dict:
                            queries_dict[k] = {
                                'id': f"{id_pfx}_{q_id}",
                                'source': b_source,
                                'dialect': 'sqlite',
                                'schema_id': b_source,
                                'gold_sql': gold_sql,
                                'predictions': []
                            }
                        suite_dict[q_id] = k

        if os.path.exists(suite_mutants_file):
            with open(suite_mutants_file, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if not line or line.startswith('#') or line.startswith('='):
                        continue
                    parts = line.split('|', 2)
                    if len(parts) == 3:
                        q_id = parts[0].strip()
                        mutant_tag = parts[1].strip()
                        pred_sql = parts[2].strip()
                        if q_id in suite_dict:
                            k = suite_dict[q_id]
                            queries_dict[k]['predictions'].append({
                                'prediction_sql': pred_sql,
                                'source': [mutant_tag]
                            })

    queries = list(queries_dict.values())
    
    print("\nBenchmark statistics:")
    stats = {}
    for item in queries:
        src = item.get('source', 'unknown')
        if src not in stats:
            stats[src] = {'gold': 0, 'pairs': 0}
        stats[src]['gold'] += 1
        stats[src]['pairs'] += len(item.get('predictions', []))
        
    for src, counts in stats.items():
        print(f"  {src}: {counts['gold']} gold queries, {counts['pairs']} pairs")
    print("")
    
    total_elimination_stats = Counter()
    results = [None] * len(queries)
    global_pair_warnings = Counter()
    all_eliminated_map = {}

    def add_eliminated_record(rec):
        key = (rec["schema_id"], rec["id"], rec["prediction_sql"], rec["reason"])
        if key not in all_eliminated_map:
            all_eliminated_map[key] = {
                "schema_id": rec["schema_id"],
                "id": rec["id"],
                "gold_sql": rec["gold_sql"],
                "prediction_sql": rec["prediction_sql"],
                "reason": rec["reason"],
                "sources": list(rec.get("sources", []))
            }
        else:
            for s in rec.get("sources", []):
                if s not in all_eliminated_map[key]["sources"]:
                    all_eliminated_map[key]["sources"].append(s)

    total_pairs_initial = sum(len(item.get('predictions', [])) for item in queries)
    
    max_workers = max(1, multiprocessing.cpu_count() - 2)
    print(f"Processing {total_pairs_initial} query pairs with {max_workers} workers...")
    
    with tqdm(total=total_pairs_initial, desc="Processing Query Pairs") as pbar:
        with concurrent.futures.ProcessPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(process_item_wrapper, (i, item, schemas_data)) for i, item in enumerate(queries)]
            for future in concurrent.futures.as_completed(futures):
                i, res, elim_stats, pair_warnings, elim_records = future.result()
                results[i] = res
                for k, v in elim_stats.items():
                    total_elimination_stats[k] += v
                for w, c in pair_warnings.items():
                    global_pair_warnings[w] += c
                for rec in elim_records:
                    add_eliminated_record(rec)
                pbar.update(len(queries[i].get('predictions', [])))
                
    # Finalize predictions and assign prediction_id
    final_results = []
    for item in results:
        if not item:
            continue
        item_id = item.get('id')
        valid_preds = []
        for idx, pred in enumerate(item.get('predictions', [])):
            pred['prediction_id'] = f"{item_id}_pred_{idx}"
            valid_preds.append(pred)
        if valid_preds:
            item['predictions'] = valid_preds
            final_results.append(item)
            
    results = final_results
    all_eliminated_records = list(all_eliminated_map.values())
    
    queries_path = os.path.join(BASE_DIR, 'queries.json')
    with open(queries_path, 'w') as f:
        json.dump(results, f, indent=4, default=str)
        
    eliminated_json_path = os.path.join(BASE_DIR, 'eliminated_pairs.json')
    with open(eliminated_json_path, 'w') as f:
        json.dump(all_eliminated_records, f, indent=4, default=str)
        
    eliminated_log_path = os.path.join(BASE_DIR, 'eliminated_pairs.log')
    with open(eliminated_log_path, 'w') as f:
        f.write(f"=== Eliminated Query Pairs ({len(all_eliminated_records)} unique eliminated prediction groups) ===\n\n")
        for rec in all_eliminated_records:
            f.write(f"Schema ID      : {rec['schema_id']}\n")
            f.write(f"Query ID       : {rec['id']}\n")
            f.write(f"Reason         : {rec['reason']}\n")
            f.write(f"Sources        : {', '.join(rec.get('sources', []))}\n")
            f.write(f"Gold SQL       : {rec['gold_sql']}\n")
            f.write(f"Prediction SQL : {rec['prediction_sql']}\n")
            f.write("-" * 80 + "\n")
        
    total_instances = len(results)
    total_pairs = sum(len(item.get('predictions', [])) for item in results)
    
    print("queries.json successfully rebuilt.")
    print(f"Total instances: {len(final_results)}")
    print(f"Total pairs remaining: {sum(len(item.get('predictions', [])) for item in final_results)}")
    
    print("\nElimination Statistics:")
    for reason, count in total_elimination_stats.items():
        print(f"  {reason}: {count}")
    print(f"  Total Eliminated: {sum(total_elimination_stats.values())}")
    
    if global_pair_warnings:
        print("\n--- SQLGlot Transpilation Warnings (Affected Query Pairs) ---")
        for msg, count in global_pair_warnings.most_common():
            print(f"[{count} query pairs affected] {msg}")
            
    optimize_errors = 0
    transpile_errors = 0
    for item in results:
        for err in item.get('errors', []):
            if err['type'] == 'optimize_error':
                optimize_errors += 1
            elif err['type'] == 'transpile_error':
                transpile_errors += 1
        for pred in item.get('predictions', []):
            for err in pred.get('errors', []):
                if err['type'] == 'optimize_error':
                    optimize_errors += 1
                elif err['type'] == 'transpile_error':
                    transpile_errors += 1
                    
    print(f"\n--- Errors ---")
    print(f"Optimize errors: {optimize_errors}")
    print(f"Transpile errors: {transpile_errors}")

    export_benchmarks(final_results, schemas_data, BASE_DIR)
    return final_results

def export_benchmarks(all_queries, schemas_data, base_dir):
    import shutil
    benchmarks_dir = os.path.join(base_dir, 'benchmarks')
    os.makedirs(benchmarks_dir, exist_ok=True)

    queries_by_source = {}
    for item in all_queries:
        src = item.get('source', 'unknown')
        queries_by_source.setdefault(src, []).append(item)

    all_sources = set(queries_by_source.keys())
    for s_info in schemas_data.values():
        src = s_info.get('source')
        if src:
            all_sources.add(src)

    legacy_sample_data_dir = os.path.join(base_dir, 'originals', 'XData-DataGen', 'sample_data')
    if not os.path.exists(legacy_sample_data_dir):
        legacy_sample_data_dir = os.path.join(base_dir, 'sample_data')

    print(f"\nExporting {len(all_sources)} benchmarks into {benchmarks_dir}...")
    for bench in sorted(all_sources):
        bench_dir = os.path.join(benchmarks_dir, bench)
        os.makedirs(bench_dir, exist_ok=True)

        # 1. queries.json
        bench_queries = queries_by_source.get(bench, [])
        with open(os.path.join(bench_dir, 'queries.json'), 'w', encoding='utf-8') as f:
            json.dump(bench_queries, f, indent=4, default=str)

        # 2. schemas.json
        bench_schema_ids = set(it['schema_id'] for it in bench_queries if 'schema_id' in it)
        bench_schemas = {
            sid: sdata for sid, sdata in schemas_data.items()
            if sid in bench_schema_ids or sdata.get('source') == bench
        }
        with open(os.path.join(bench_dir, 'schemas.json'), 'w', encoding='utf-8') as f:
            json.dump(bench_schemas, f, indent=2, default=str)

        # 3. sample_data/
        bench_sample_dir = os.path.join(bench_dir, 'sample_data')
        os.makedirs(bench_sample_dir, exist_ok=True)

        if os.path.exists(legacy_sample_data_dir):
            if bench == 'bird':
                for f in glob.glob(os.path.join(legacy_sample_data_dir, '*.sql')):
                    fname = os.path.basename(f)
                    if fname not in ['calcite.sql', 'tpch.sql', 'largejoin.sql', 'university.sql', 'xdata_bm.sql', 'xdata.sql']:
                        shutil.copy2(f, os.path.join(bench_sample_dir, fname))
            elif bench == 'calcite':
                f = os.path.join(legacy_sample_data_dir, 'calcite.sql')
                if os.path.exists(f):
                    shutil.copy2(f, os.path.join(bench_sample_dir, 'calcite.sql'))
            elif bench == 'tpch':
                f = os.path.join(legacy_sample_data_dir, 'tpch.sql')
                if os.path.exists(f):
                    shutil.copy2(f, os.path.join(bench_sample_dir, 'tpch.sql'))
            elif bench == 'largejoin':
                f = os.path.join(legacy_sample_data_dir, 'largejoin.sql')
                if os.path.exists(f):
                    shutil.copy2(f, os.path.join(bench_sample_dir, 'largejoin.sql'))
            elif bench == 'xdata':
                for fname in ['xdata_bm.sql', 'xdata.sql', 'university.sql']:
                    f = os.path.join(legacy_sample_data_dir, fname)
                    if os.path.exists(f):
                        shutil.copy2(f, os.path.join(bench_sample_dir, fname))

        print(f"  Benchmark '{bench}': {len(bench_queries)} queries, {len(bench_schemas)} schemas -> {bench_dir}")

def process_query_items(queries, schemas_data):
    total_pairs_initial = sum(len(item.get('predictions', [])) for item in queries)
    max_workers = min(max(1, multiprocessing.cpu_count() - 2), len(queries)) if queries else 1
    results = [None] * len(queries)
    elim_stats_total = Counter()
    pair_warnings_total = Counter()
    elim_records_all = []

    with tqdm(total=total_pairs_initial, desc="Processing Query Items") as pbar:
        with concurrent.futures.ProcessPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(process_item_wrapper, (i, item, schemas_data)) for i, item in enumerate(queries)]
            for future in concurrent.futures.as_completed(futures):
                i, res, elim_stats, pair_warnings, elim_records = future.result()
                results[i] = res
                for k, v in elim_stats.items():
                    elim_stats_total[k] += v
                for w, c in pair_warnings.items():
                    pair_warnings_total[w] += c
                elim_records_all.extend(elim_records)
                pbar.update(len(queries[i].get('predictions', [])))

    final_results = []
    for item in results:
        if not item:
            continue
        item_id = item.get('id')
        valid_preds = []
        for idx, pred in enumerate(item.get('predictions', [])):
            pred['prediction_id'] = f"{item_id}_pred_{idx}"
            valid_preds.append(pred)
        if valid_preds:
            item['predictions'] = valid_preds
            final_results.append(item)

    return final_results, elim_stats_total, pair_warnings_total, elim_records_all

def main():
    parser = argparse.ArgumentParser(description="Build and Package Unified LASSO Benchmarks")
    parser.add_argument('--benchmark', type=str, default='all', help="Specific benchmark to build/update, e.g. 'lasso-bm' or 'all'")
    parser.add_argument('--rebuild-all', action='store_true', help="Force full rebuild of all benchmarks from raw original sources")
    args = parser.parse_args()

    schemas_file = os.path.join(BASE_DIR, 'schemas.json')
    queries_file = os.path.join(BASE_DIR, 'queries.json')

    if os.path.exists(schemas_file) and os.path.exists(queries_file) and not args.rebuild_all:
        print(f"Loading existing schemas from {schemas_file} and queries from {queries_file}...")
        with open(schemas_file, 'r', encoding='utf-8') as f:
            schemas_data = json.load(f)
        with open(queries_file, 'r', encoding='utf-8') as f:
            all_queries = json.load(f)

        for db_id, data in schemas_data.items():
            ddl = data.get("ddl", "")
            schema_dict = {}
            try:
                for stmt in sqlglot.parse(ddl, read='sqlite'):
                    if stmt and stmt.key == 'create':
                        schema_obj = stmt.this
                        if schema_obj and schema_obj.key == 'schema':
                            table_name = normalize_name(schema_obj.this.name)
                            columns = {}
                            for col_def in schema_obj.expressions:
                                if col_def.key == 'columndef':
                                    kind = col_def.args.get('kind')
                                    t = kind.this.name if kind and hasattr(kind, 'this') and hasattr(kind.this, 'name') else 'TEXT'
                                    col_name = normalize_name(col_def.name)
                                    columns[col_name] = t
                            schema_dict[table_name] = columns
            except Exception:
                pass
            data["sqlglot_schema"] = schema_dict

        # Ensure xdata benchmarks retain raw original PostgreSQL DDL and queries without lossy conversions
        for sid, rel_p in [("xdata_bm", "xdatapublic/benchmarks/XData-BM/DDL.sql"),
                           ("tpch", "xdatapublic/benchmarks/TPCH/DDL.sql"),
                           ("largejoin", "xdatapublic/benchmarks/LargeJoin/DDL.sql")]:
            full_p = get_original_path(rel_p)
            if os.path.exists(full_p) and sid in schemas_data:
                with open(full_p, 'r', encoding='utf-8') as f:
                    schemas_data[sid]["ddl_postgres"] = f.read()

        for q in all_queries:
            if q.get('source') in ('xdata', 'tpch', 'largejoin') or q.get('dialect') in ('postgres', 'postgresql'):
                q['gold_sql_postgresql'] = q.get('gold_sql', '')
                for p in q.get('predictions', []):
                    p['prediction_sql_postgresql'] = p.get('prediction_sql', '')

        print("\nBuilding LASSO-BM from test_cases/...")
        lasso_schemas = build_lasso_bm_schemas(enrich=True)
        schemas_data.update(lasso_schemas)

        all_queries = [q for q in all_queries if q.get('source') != 'lasso-bm']

        lasso_raw_queries = build_lasso_bm_queries(schemas_data)
        print(f"Loaded {len(lasso_raw_queries)} LASSO-BM query instances with {sum(len(q['predictions']) for q in lasso_raw_queries)} prediction pairs.")

        lasso_processed, elim_stats, pair_warns, elim_recs = process_query_items(lasso_raw_queries, schemas_data)
        print(f"Processed LASSO-BM: {len(lasso_processed)} instances, {sum(len(q['predictions']) for q in lasso_processed)} valid pairs remaining.")

        all_queries.extend(lasso_processed)

        # Remove legacy manymutantsbm if present
        all_queries = [q for q in all_queries if q.get('source') not in ('manymutantsbm', 'mm-bm', 'mmo-bm', 'mmro-bm')]
        for s_key in ['manymutantsbm', 'mm-bm', 'mmo-bm', 'mmro-bm']:
            if s_key in schemas_data:
                del schemas_data[s_key]

        # Build MM-BM and its obfuscated variants (MMO-BM, MMRO-BM) from originals/MM-BM
        mm_suites_config = [
            ("mm-bm", "schema.sql", "queries.txt", "mutants.txt", "mm"),
            ("mmo-bm", "schema_mmo.sql", "queries_mmo.txt", "mutants_mmo.txt", "mmo"),
            ("mmro-bm", "schema_mmro.sql", "queries_mmro.txt", "mutants_mmro.txt", "mmro")
        ]
        for b_source, s_file, q_file, m_file, id_pfx in mm_suites_config:
            mm_ddl_path = get_original_path(f'MM-BM/{s_file}')
            if not os.path.exists(mm_ddl_path) and b_source == "mm-bm":
                mm_ddl_path = get_original_path('ManyMutantsBM/schema.sql')
            mm_queries_file = get_original_path(f'MM-BM/{q_file}')
            if not os.path.exists(mm_queries_file) and b_source == "mm-bm":
                mm_queries_file = get_original_path('ManyMutantsBM/queries.txt')
            mm_mutants_file = get_original_path(f'MM-BM/{m_file}')
            if not os.path.exists(mm_mutants_file) and b_source == "mm-bm":
                mm_mutants_file = get_original_path('ManyMutantsBM/mutants.txt')

            if not os.path.exists(mm_ddl_path) or not os.path.exists(mm_queries_file):
                gen_script = get_original_path('MM-BM/generate_variants.py')
                if os.path.exists(gen_script):
                    import subprocess
                    subprocess.run([sys.executable, gen_script], check=False)

            if os.path.exists(mm_ddl_path) and os.path.exists(mm_queries_file):
                print(f"\nBuilding {b_source.upper()} from originals/MM-BM ({s_file})...")
                with open(mm_ddl_path, 'r', encoding='utf-8') as f:
                    mm_ddl = f.read()
                mm_ddl = ensure_foreign_key_constraints(mm_ddl)
                mm_schema_entry = {
                    "source": b_source,
                    "ddl": mm_ddl,
                    "polygon_schema": parse_ddl_to_polygon(mm_ddl, b_source),
                    "polygon_constraints": parse_polygon_constraints(mm_ddl, b_source),
                    "ddl_postgres": prepare_postgres_ddl(mm_ddl)
                }
                try:
                    uir = schema_translator.parse_ddl_to_uir(mm_ddl)
                    spotit_s, spotit_c = schema_translator.uir_to_spotit_format(uir)
                    mm_schema_entry["spotit_schema"] = spotit_s
                    mm_schema_entry["spotit_constraints"] = spotit_c
                    mm_schema_entry["spotit_ddl"] = transform_ddl_for_spotit(uir)
                except Exception as e:
                    logger.warning(f"Failed to generate spotit schema/constraints for {b_source}: {e}")
                    mm_schema_entry["spotit_schema"] = {}
                    mm_schema_entry["spotit_constraints"] = []
                    mm_schema_entry["spotit_ddl"] = ""

                schemas_data[b_source] = mm_schema_entry

                mm_dict_schema = {}
                try:
                    for stmt in sqlglot.parse(mm_ddl, read='sqlite'):
                        if stmt and stmt.key == 'create':
                            schema_obj = stmt.this
                            if schema_obj and schema_obj.key == 'schema':
                                table_name = normalize_name(schema_obj.this.name)
                                cols = {}
                                for col_def in schema_obj.expressions:
                                    if col_def.key == 'columndef':
                                        kind = col_def.args.get('kind')
                                        t = kind.this.name if kind and hasattr(kind, 'this') and hasattr(kind.this, 'name') else 'TEXT'
                                        col_name = normalize_name(col_def.name)
                                        cols[col_name] = t
                                mm_dict_schema[table_name] = cols
                except Exception:
                    pass
                schemas_data[b_source]["sqlglot_schema"] = mm_dict_schema

                # Load queries and mutants
                mm_items_dict = {}
                with open(mm_queries_file, 'r', encoding='utf-8') as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith('#') or line.startswith('='):
                            continue
                        parts = line.split('|', 2)
                        if len(parts) >= 2:
                            q_id = parts[0].strip()
                            gold_sql = parts[-1].strip()
                            mm_items_dict[q_id] = {
                                'id': f"{id_pfx}_{q_id}",
                                'source': b_source,
                                'dialect': 'sqlite',
                                'schema_id': b_source,
                                'gold_sql': gold_sql,
                                'predictions': []
                            }

                if os.path.exists(mm_mutants_file):
                    with open(mm_mutants_file, 'r', encoding='utf-8') as f:
                        for line in f:
                            line = line.strip()
                            if not line or line.startswith('#') or line.startswith('='):
                                continue
                            parts = line.split('|', 2)
                            if len(parts) == 3:
                                q_id = parts[0].strip()
                                mutant_tag = parts[1].strip()
                                pred_sql = parts[2].strip()
                                if q_id in mm_items_dict:
                                    mm_items_dict[q_id]['predictions'].append({
                                        'prediction_sql': pred_sql,
                                        'source': [mutant_tag]
                                    })

                mm_raw_queries = list(mm_items_dict.values())
                print(f"Loaded {len(mm_raw_queries)} {b_source.upper()} query instances with {sum(len(q.get('predictions', [])) for q in mm_raw_queries)} prediction pairs.")
                mm_processed, elim_stats, pair_warns, elim_recs = process_query_items(mm_raw_queries, schemas_data)
                print(f"Processed {b_source.upper()}: {len(mm_processed)} instances, {sum(len(q['predictions']) for q in mm_processed)} valid pairs remaining.")
                all_queries.extend(mm_processed)

        print("\nUpdating global schemas.json and queries.json...")
        with open(schemas_file, 'w', encoding='utf-8') as f:
            json.dump(schemas_data, f, indent=2, default=str)
        with open(queries_file, 'w', encoding='utf-8') as f:
            json.dump(all_queries, f, indent=4, default=str)

        export_benchmarks(all_queries, schemas_data, BASE_DIR)
        print("\nBenchmark construction complete!")
        return

    print("Performing full rebuild of all benchmarks from raw data sources...")
    schemas_data = build_schemas()
    build_queries(schemas_data)

if __name__ == '__main__':
    main()

