import sqlglot
from sqlglot import exp
import re

def clean_ddl(ddl_string):
    ddl = ddl_string
    ddl = re.sub(r'(?i)\bAUTOINCREMENT\b', '', ddl)
    ddl = re.sub(r'(?i)\bAUTO_INCREMENT\b', '', ddl)
    ddl = re.sub(r'(?i)\bON\s+UPDATE\s+CASCADE\b', '', ddl)
    ddl = re.sub(r'(?i)\bON\s+DELETE\s+CASCADE\b', '', ddl)
    ddl = re.sub(r'(?i)\bON\s+UPDATE\s+SET\s+NULL\b', '', ddl)
    ddl = re.sub(r'(?i)\bON\s+DELETE\s+SET\s+NULL\b', '', ddl)
    ddl = re.sub(r'(?i)\bDEFAULT\s+NULL\b', '', ddl)
    ddl = re.sub(r'(?i)\bDEFAULT\s+\'\'\b', '', ddl)
    ddl = re.sub(r'(?i)\bDEFAULT\s+\'[^\']*\'\b', '', ddl)
    ddl = re.sub(r'(?i)\bDEFAULT\s+\d+\b', '', ddl)
    ddl = re.sub(r'(?i)\bCONSTRAINT\s+\w+\s+PRIMARY\s+KEY\b', 'PRIMARY KEY', ddl)
    ddl = re.sub(r'(?i)\bCONSTRAINT\s+\w+\s+FOREIGN\s+KEY\b', 'FOREIGN KEY', ddl)
    ddl = re.sub(r'(?i)\bCONSTRAINT\s+\w+\s+UNIQUE\b', 'UNIQUE', ddl)
    # Handle weird ENUM,A,B,C syntax from Polygon jsonlines
    ddl = re.sub(r'(?i)\bENUM,[^\n)]*', 'VARCHAR', ddl)
    ddl = re.sub(r'(?i)\bCHARACTER\s+VARCHAR\b', 'VARCHAR', ddl)
    return ddl

def parse_ddl_to_uir(ddl_string):
    """
    Parses a DDL string using sqlglot and creates a Universal Intermediate Representation (UIR).
    """
    uir = {
        "tables": [],
        "columns": [],
        "primary_keys": [],
        "foreign_keys": [],
        "check_constraints": [],
        "not_null_cols": [],
        "unique_constraints": []
    }
    
    ddl_string = clean_ddl(ddl_string)
    
    try:
        statements = sqlglot.parse(ddl_string, read='mysql')
    except Exception as e:
        print("Parse error:", e)
        return uir
    
    table_name_to_idx = {}
    
    # Pass 1: Collect tables and columns
    for stmt in statements:
        if not stmt: continue
        # Check if it's a create table. stmt.args.get("kind") could be a string or an object depending on sqlglot version/dialect
        kind = stmt.args.get("kind")
        if isinstance(stmt, exp.Create) and (kind == "TABLE" or str(kind).upper() == "TABLE"):
            schema_node = stmt.this
            if not isinstance(schema_node, exp.Schema):
                continue
                
            table_name = schema_node.this.name
            t_idx = len(uir["tables"])
            uir["tables"].append({"name": table_name})
            table_name_to_idx[table_name.upper()] = t_idx
            
            for expr in schema_node.expressions:
                if isinstance(expr, exp.ColumnDef):
                    col_name = expr.name
                    col_type = expr.args.get("kind").this.name if expr.args.get("kind") else "text"
                    
                    c_idx = len(uir["columns"])
                    uir["columns"].append({
                        "name": col_name,
                        "type": col_type,
                        "table_idx": t_idx
                    })
                    
    # Pass 2: Constraints
    for stmt in statements:
        if not stmt: continue
        kind = stmt.args.get("kind")
        if isinstance(stmt, exp.Create) and (kind == "TABLE" or str(kind).upper() == "TABLE"):
            schema_node = stmt.this
            if not isinstance(schema_node, exp.Schema):
                continue
                
            table_name = schema_node.this.name.upper()
            t_idx = table_name_to_idx[table_name]
            
            table_cols = {c["name"].upper(): i for i, c in enumerate(uir["columns"]) if c["table_idx"] == t_idx}
            
            for expr in schema_node.expressions:
                inner = expr.expressions[0] if isinstance(expr, exp.Constraint) and expr.expressions else expr
                # Inline constraints
                if isinstance(inner, exp.ColumnDef):
                    c_idx = table_cols[inner.name.upper()]
                    for constraint in inner.args.get("constraints", []):
                        kind = constraint.args.get("kind")
                        if isinstance(kind, exp.PrimaryKeyColumnConstraint):
                            uir["primary_keys"].append(c_idx)
                        elif isinstance(kind, exp.NotNullColumnConstraint):
                            if not kind.args.get("allow_null"):
                                uir["not_null_cols"].append(c_idx)
                        elif isinstance(kind, exp.UniqueColumnConstraint):
                            uir["unique_constraints"].append([c_idx])
                        elif isinstance(kind, exp.CheckColumnConstraint):
                            uir["check_constraints"].append({"table": table_name, "expr": kind.this})
                        elif isinstance(kind, exp.Reference):
                            if isinstance(kind.this, exp.Schema):
                                foreign_table = kind.this.this.name.upper()
                                foreign_col = kind.this.expressions[0].name.upper() if kind.this.expressions else None
                            else:
                                foreign_table = kind.this.name.upper()
                                foreign_col = kind.expressions[0].name.upper() if kind.expressions else None
                                
                            f_t_idx = table_name_to_idx.get(foreign_table)
                            if f_t_idx is None:
                                raise ValueError(f"Foreign key reference to unknown table: {foreign_table}")
                            if foreign_col:
                                f_c_idx = next((i for i, c in enumerate(uir["columns"]) if c["table_idx"] == f_t_idx and c["name"].upper() == foreign_col), None)
                                if f_c_idx is not None:
                                    uir["foreign_keys"].append({"local_col_idx": c_idx, "foreign_col_idx": f_c_idx})
                                
                # Table-level PK
                elif isinstance(inner, exp.PrimaryKey):
                    for col in inner.expressions:
                        if col.name.upper() in table_cols:
                            c_idx = table_cols[col.name.upper()]
                            uir["primary_keys"].append(c_idx)
                        
                # Table-level UNIQUE
                elif isinstance(inner, exp.UniqueColumnConstraint):
                    schema_or_cols = inner.this
                    if isinstance(schema_or_cols, exp.Schema):
                        uq_indices = [table_cols[c.name.upper()] for c in schema_or_cols.expressions if c.name.upper() in table_cols]
                        if uq_indices:
                            uir["unique_constraints"].append(uq_indices)
                    elif hasattr(inner, "expressions") and inner.expressions:
                        uq_indices = [table_cols[c.name.upper()] for c in inner.expressions if c.name.upper() in table_cols]
                        if uq_indices:
                            uir["unique_constraints"].append(uq_indices)

                # Table-level FK
                elif isinstance(inner, exp.ForeignKey):
                    local_col = inner.expressions[0].name.upper()
                    if local_col in table_cols:
                        c_idx = table_cols[local_col]
                        ref = inner.args.get("reference")
                        if ref:
                            if isinstance(ref.this, exp.Schema):
                                foreign_table = ref.this.this.name.upper()
                                foreign_col = ref.this.expressions[0].name.upper() if ref.this.expressions else None
                            else:
                                foreign_table = ref.this.name.upper()
                                foreign_col = ref.expressions[0].name.upper() if ref.expressions else None
                            
                            f_t_idx = table_name_to_idx.get(foreign_table)
                            if f_t_idx is None:
                                raise ValueError(f"Foreign key reference to unknown table: {foreign_table}")
                                
                            if foreign_col:
                                f_c_idx = next((i for i, c in enumerate(uir["columns"]) if c["table_idx"] == f_t_idx and c["name"].upper() == foreign_col), None)
                                if f_c_idx is not None:
                                    uir["foreign_keys"].append({"local_col_idx": c_idx, "foreign_col_idx": f_c_idx})

                # Table-level check constraint
                elif isinstance(inner, exp.CheckColumnConstraint):
                    uir["check_constraints"].append({"table": table_name, "expr": inner.this})

    # deduplicate PKs, FKs, NOT NULLs, and UNIQUEs
    uir["primary_keys"] = list(set(uir["primary_keys"]))
    uir["not_null_cols"] = list(set(uir.get("not_null_cols", [])))
    unique_fks = []
    seen = set()
    for fk in uir["foreign_keys"]:
        k = (fk["local_col_idx"], fk["foreign_col_idx"])
        if k not in seen:
            seen.add(k)
            unique_fks.append(fk)
    uir["foreign_keys"] = unique_fks

    unique_uqs = []
    seen_uq = set()
    for uq in uir.get("unique_constraints", []):
        tup = tuple(uq)
        if tup not in seen_uq:
            seen_uq.add(tup)
            unique_uqs.append(uq)
    uir["unique_constraints"] = unique_uqs

    return uir

def get_polygon_type(col_type):
    normalized = str(col_type).strip().lower()
    if normalized in {'number', 'integer', 'real', 'float', 'numeric', 'decimal', 'boolean', 'bool', 'int'}:
        return 'int'
    return 'varchar'

def clean_up_column_name(name):
    content = name.upper()
    content = content.replace(' ', '_')
    content = re.sub(r'(\d+)-(\d+)', r'\1_\2', content)
    content = re.sub(r'([A-Z]+)-(\d+)', r'\1\2', content)
    content = content.replace('-', '_')
    content = re.sub(r'[^A-Z0-9_]', '', content)
    content = re.sub(r'_+', '_', content)
    content = content.strip('_')
    return content

def uir_to_bird_format(db_id, uir):
    """
    Exports UIR to BIRD JSON format (dev_tables.json style).
    """
    bird = {
        "db_id": db_id,
        "table_names_original": [t["name"] for t in uir["tables"]],
        "table_names": [t["name"].lower() for t in uir["tables"]],
        "column_names_original": [[-1, "*"]],
        "column_names": [[-1, "*"]],
        "column_types": ["text"],
        "primary_keys": [],
        "foreign_keys": []
    }
    
    # Columns
    uir_to_bird_col_idx = {}
    for i, col in enumerate(uir["columns"]):
        bird_c_idx = len(bird["column_names_original"])
        uir_to_bird_col_idx[i] = bird_c_idx
        
        bird["column_names_original"].append([col["table_idx"], col["name"]])
        bird["column_names"].append([col["table_idx"], col["name"].lower()])
        b_type = "number" if get_polygon_type(col["type"]) == "int" else "text"
        bird["column_types"].append(b_type)
        
    # Primary Keys
    for pk_idx in uir["primary_keys"]:
        bird["primary_keys"].append(uir_to_bird_col_idx[pk_idx])
        
    # Foreign Keys
    for fk in uir["foreign_keys"]:
        bird["foreign_keys"].append([
            uir_to_bird_col_idx[fk["local_col_idx"]],
            uir_to_bird_col_idx[fk["foreign_col_idx"]]
        ])
        
    return bird

def uir_to_polygon_format(uir):
    """
    Exports UIR to Polygon JSON array format.
    """
    poly = []
    for t_idx, t in enumerate(uir["tables"]):
        poly.append({
            "TableName": t["name"],
            "PKeys": [],
            "FKeys": [],
            "Others": []
        })
        
    for i, col in enumerate(uir["columns"]):
        t_idx = col["table_idx"]
        col_name = clean_up_column_name(col["name"])
        col_type = get_polygon_type(col["type"])
        col_dict = {"Name": col_name, "Type": col_type}
        
        if i in uir["primary_keys"]:
            poly[t_idx]["PKeys"].append(col_dict)
        else:
            poly[t_idx]["Others"].append(col_dict)
            
    for fk in uir["foreign_keys"]:
        l_col = uir["columns"][fk["local_col_idx"]]
        f_col = uir["columns"][fk["foreign_col_idx"]]
        
        l_t_idx = l_col["table_idx"]
        f_t_idx = f_col["table_idx"]
        
        l_col_name = clean_up_column_name(l_col["name"])
        f_col_name = clean_up_column_name(f_col["name"])
        
        poly[l_t_idx]["FKeys"].append({
            "FName": l_col_name,
            "PName": f_col_name,
            "PTable": str(f_t_idx)
        })
        
    for t_dict in poly:
        fkey_names = [fk["FName"].lower() for fk in t_dict["FKeys"]]
        t_dict["Others"] = [c for c in t_dict["Others"] if c["Name"].lower() not in fkey_names]
        
    return poly
def sqlglot_to_spotit_ast(expr, table_name):
    if isinstance(expr, exp.GT):
        return {"gt": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.LT):
        return {"lt": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.GTE):
        return {"gte": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.LTE):
        return {"lte": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.EQ):
        return {"eq": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.NEQ):
        return {"neq": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.And):
        return {"and": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.Or):
        return {"or": [sqlglot_to_spotit_ast(expr.left, table_name), sqlglot_to_spotit_ast(expr.right, table_name)]}
    elif isinstance(expr, exp.Between):
        return {"between": [sqlglot_to_spotit_ast(expr.this, table_name), sqlglot_to_spotit_ast(expr.args.get("lower"), table_name), sqlglot_to_spotit_ast(expr.args.get("upper"), table_name)]}
    elif isinstance(expr, exp.In):
        return {"in": [sqlglot_to_spotit_ast(expr.this, table_name)] + [sqlglot_to_spotit_ast(e, table_name) for e in expr.expressions]}
    elif isinstance(expr, exp.Not):
        return {"not": [sqlglot_to_spotit_ast(expr.this, table_name)]}
    elif isinstance(expr, exp.Column):
        return f"{table_name}__{expr.this.name.upper()}"
    elif isinstance(expr, exp.Literal):
        if expr.is_string:
            return {"literal": expr.this}
        else:
            try:
                if "." in expr.this:
                    return float(expr.this)
                return int(expr.this)
            except ValueError:
                return expr.this
    elif isinstance(expr, exp.Paren):
        return sqlglot_to_spotit_ast(expr.this, table_name)
    return None

def uir_to_spotit_format(uir):
    schema = {}
    for t_idx, t in enumerate(uir["tables"]):
        t_name = clean_up_column_name(t["name"])
        schema[t_name] = {}
        for col in uir["columns"]:
            if col["table_idx"] == t_idx:
                c_name = clean_up_column_name(col["name"])
                c_type = str(col["type"]).upper()
                schema[t_name][c_name] = c_type

    constraints = []
    
    # Primary Keys (grouped by table so composite PKs are properly represented in SpotIt SMT formulas)
    pks_by_table = {}
    for pk_idx in uir["primary_keys"]:
        col = uir["columns"][pk_idx]
        t_idx = col["table_idx"]
        if t_idx not in pks_by_table:
            pks_by_table[t_idx] = []
        if col not in pks_by_table[t_idx]:
            pks_by_table[t_idx].append(col)
        
    for t_idx, cols in pks_by_table.items():
        t_name = clean_up_column_name(uir["tables"][t_idx]["name"])
        col_names = [f"{t_name}__{clean_up_column_name(c['name'])}" for c in cols]
        constraints.append({"primary": col_names})
        
    # Foreign Keys
    for fk in uir["foreign_keys"]:
        l_col = uir["columns"][fk["local_col_idx"]]
        f_col = uir["columns"][fk["foreign_col_idx"]]
        
        l_t_name = clean_up_column_name(uir["tables"][l_col["table_idx"]]["name"])
        f_t_name = clean_up_column_name(uir["tables"][f_col["table_idx"]]["name"])
        
        l_c_name = clean_up_column_name(l_col["name"])
        f_c_name = clean_up_column_name(f_col["name"])
        
        constraints.append({"foreign": [f"{l_t_name}__{l_c_name}", f"{f_t_name}__{f_c_name}"]})
        
    # Check Constraints
    for cc in uir.get("check_constraints", []):
        t_name = clean_up_column_name(cc["table"])
        ast = sqlglot_to_spotit_ast(cc["expr"], t_name)
        if ast:
            constraints.append(ast)
            
    # Not Null Constraints
    pks_set = set(uir.get("primary_keys", []))
    seen_not_null = set()
    for col_idx in uir.get("not_null_cols", []):
        if col_idx in pks_set or col_idx in seen_not_null:
            continue
        seen_not_null.add(col_idx)
        col = uir["columns"][col_idx]
        t_name = clean_up_column_name(uir["tables"][col["table_idx"]]["name"])
        c_name = clean_up_column_name(col["name"])
        constraints.append({"not_null": {"value": f"{t_name}__{c_name}"}})
            
    return schema, constraints

def transform_ddl_for_spotit(uir) -> str:
    ddl_statements = []
    for t_idx, t in enumerate(uir["tables"]):
        t_name = clean_up_column_name(t["name"])
        col_defs = []
        for c_idx, col in enumerate(uir["columns"]):
            if col["table_idx"] == t_idx:
                c_name = clean_up_column_name(col["name"])
                c_type = col["type"]
                col_str = f'"{c_name}" {c_type}'
                if c_idx in uir.get("not_null_cols", []) and c_idx not in uir.get("primary_keys", []):
                    col_str += " NOT NULL"
                col_defs.append(col_str)
                
        pk_cols = []
        for pk_idx in uir["primary_keys"]:
            col = uir["columns"][pk_idx]
            if col["table_idx"] == t_idx:
                pk_cols.append(f'"{clean_up_column_name(col["name"])}"')
        if pk_cols:
            col_defs.append(f'PRIMARY KEY ({", ".join(pk_cols)})')

        t_pk_set = {pk for pk in uir["primary_keys"] if uir["columns"][pk]["table_idx"] == t_idx}
        for uq_cols_indices in uir.get("unique_constraints", []):
            if all(uir["columns"][i]["table_idx"] == t_idx for i in uq_cols_indices):
                if set(uq_cols_indices) == t_pk_set:
                    continue
                uq_cols = [f'"{clean_up_column_name(uir["columns"][i]["name"])}"' for i in uq_cols_indices]
                if uq_cols:
                    col_defs.append(f'UNIQUE ({", ".join(uq_cols)})')
            
        for fk in uir["foreign_keys"]:
            l_col = uir["columns"][fk["local_col_idx"]]
            if l_col["table_idx"] == t_idx:
                f_col = uir["columns"][fk["foreign_col_idx"]]
                f_t_name = clean_up_column_name(uir["tables"][f_col["table_idx"]]["name"])
                f_c_name = clean_up_column_name(f_col["name"])
                l_c_name_clean = clean_up_column_name(l_col["name"])
                col_defs.append(f'FOREIGN KEY ("{l_c_name_clean}") REFERENCES "{f_t_name}"("{f_c_name}")')

        for cc in uir.get("check_constraints", []):
            if clean_up_column_name(cc["table"]) == t_name:
                expr_str = cc["expr"].sql(dialect="sqlite")
                col_defs.append(f'CHECK ({expr_str})')

        ddl_statements.append(f'CREATE TABLE "{t_name}" (\n    ' + ",\n    ".join(col_defs) + "\n);")
    return "\n".join(ddl_statements)

