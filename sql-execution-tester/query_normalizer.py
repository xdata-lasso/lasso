import sqlglot
from sqlglot import exp
from datetime import datetime


def _make_transform_time(timestamp_str: str, date_str: str, time_str: str, dialect: str):
    """Creates a transform_time function closed over the given frozen time strings."""

    def transform_time(node):
        if isinstance(node, (exp.CurrentTimestamp, exp.Localtimestamp)):
            return sqlglot.parse_one(f"'{timestamp_str}'")
        if isinstance(node, exp.CurrentDate):
            return sqlglot.parse_one(f"'{date_str}'")
        if isinstance(node, (exp.CurrentTime, exp.Localtime)):
            return sqlglot.parse_one(f"'{time_str}'")

        if isinstance(node, exp.Anonymous):
            name = node.name.upper()
            if name in ('NOW', 'SYSDATE', 'STATEMENT_TIMESTAMP', 'CLOCK_TIMESTAMP', 'TRANSACTION_TIMESTAMP'):
                return sqlglot.parse_one(f"'{timestamp_str}'")

        is_time_node = False
        if isinstance(node, exp.Anonymous) and node.name.upper() in ('DATETIME', 'TIME', 'JULIANDAY'):
            is_time_node = True
        elif isinstance(node, (exp.Date, exp.TimeToStr, exp.TsOrDsToTimestamp)):
            is_time_node = True

        if is_time_node:
            # sqlglot expressions have args
            for k, v in node.args.items():
                if isinstance(v, list):
                    for i, arg in enumerate(v):
                        if isinstance(arg, exp.Literal) and arg.this.lower() == 'now':
                            v[i] = sqlglot.parse_one(f"'{timestamp_str}'")
                        elif isinstance(arg, exp.Expression):
                            arg.transform(transform_time, copy=False)
                elif isinstance(v, exp.Literal) and v.this.lower() == 'now':
                    node.args[k] = sqlglot.parse_one(f"'{timestamp_str}'")
                elif isinstance(v, exp.Expression):
                    v.transform(transform_time, copy=False)
        return node

    return transform_time


def replace_time(query: str, frozen_time: datetime = None, dialect: str = 'sqlite') -> str:
    """
    Replaces time-based keywords and the 'now' argument with a snapshot of the current time
    for deterministic execution. Uses sqlglot for robust AST parsing.

    Args:
        query: The SQL query string to transform.
        frozen_time: An optional datetime to use as the replacement value.
                     If None, captures datetime.utcnow() at call time.
                     Pass the same frozen_time to multiple calls to ensure
                     both queries use an identical timestamp.
    """
    if frozen_time is None:
        frozen_time = datetime.utcnow()

    timestamp_str = frozen_time.strftime('%Y-%m-%d %H:%M:%S')
    date_str = frozen_time.strftime('%Y-%m-%d')
    time_str = frozen_time.strftime('%H:%M:%S')

    if dialect == 'postgresql':
        dialect = 'postgres'
    transform_time = _make_transform_time(timestamp_str, date_str, time_str, dialect)

    try:
        parsed = sqlglot.parse_one(query, read=dialect)
        if not parsed:
            return query
        transformed = parsed.transform(transform_time)
        return transformed.sql(dialect=dialect)
    except Exception:
        # If sqlglot fails to parse (e.g. invalid syntax), return original
        # to let SQLite handle the native syntax error.
        return query


import sqlite3
from typing import Dict, List

def get_table_tiebreakers(schema_sql: str, dialect: str = 'sqlite') -> Dict[str, List[str]]:
    """
    Parses the schema using sqlglot and returns a dictionary mapping table names (lowercase)
    to a list of columns to use for tie-breaking (primary keys if available, otherwise all columns).
    """
    if dialect == 'postgresql':
        dialect = 'postgres'
    tiebreakers = {}
    if not schema_sql:
        return tiebreakers
        
    try:
        # Always parse benchmark DDLs as sqlite since they contain backticks and SQLite syntax
        for statement in sqlglot.parse(schema_sql, read='sqlite'):
            if isinstance(statement, exp.Create) and statement.args.get("kind") == "TABLE":
                schema_expr = statement.args.get("this")
                if not schema_expr or not isinstance(schema_expr, exp.Schema):
                    continue
                    
                table_name = schema_expr.this.name.lower()
                    
                cols = []
                pk_cols = []
                unique_cols = []
                
                for elem in schema_expr.expressions:
                    if isinstance(elem, exp.ColumnDef):
                        col_name = elem.name.lower()
                        cols.append(col_name)
                        for constraint in elem.constraints:
                            if isinstance(constraint.kind, exp.PrimaryKeyColumnConstraint):
                                pk_cols.append(col_name)
                            elif isinstance(constraint.kind, exp.UniqueColumnConstraint) and not unique_cols:
                                unique_cols.append(col_name)
                    elif isinstance(elem, exp.PrimaryKey):
                        for expr in elem.expressions:
                            pk_cols.append(expr.name.lower())
                    elif isinstance(elem, exp.UniqueColumnConstraint) and not unique_cols:
                        if elem.this and hasattr(elem.this, 'expressions'):
                            for expr in elem.this.expressions:
                                unique_cols.append(expr.name.lower())
                
                if pk_cols:
                    tiebreakers[table_name] = pk_cols
                elif unique_cols:
                    tiebreakers[table_name] = unique_cols
                else:
                    tiebreakers[table_name] = cols
    except Exception:
        pass
    return tiebreakers

def augment_order_by(query: str, schema: str = "", dialect: str = 'sqlite') -> str:
    """
    Augments ORDER BY clauses in the query with primary keys (or all columns) from the
    tables referenced in the query to make ordering deterministic.
    Fallback: if no schema provided, falls back to appending SELECT expressions.
    """
    if dialect == 'postgresql':
        dialect = 'postgres'
    try:
        parsed = sqlglot.parse_one(query, read=dialect)
        if not parsed:
            return query
            
        tiebreakers = get_table_tiebreakers(schema, dialect=dialect)
        
        for query_node in parsed.find_all((exp.Select, exp.Union)):
            if query_node.args.get("order"):
                order = query_node.args["order"]
                
                existing_order_exprs = []
                for o_expr in order.expressions:
                    if isinstance(o_expr, exp.Ordered):
                        existing_order_exprs.append(o_expr.this)
                    else:
                        existing_order_exprs.append(o_expr)
                        
                existing_sql = [e.sql(dialect='sqlite').lower() for e in existing_order_exprs]
                
                append_exprs = []
                
                found_schema_tiebreakers = False
                if tiebreakers and not query_node.args.get("group") and not query_node.args.get("distinct"):
                    # Append schema columns if there's no GROUP BY or DISTINCT
                    # (for GROUP BY, base table columns are arbitrary, so we fallback to SELECT columns)
                    tables = []
                    if query_node.args.get("from_"):
                        this = query_node.args["from_"].this
                        if isinstance(this, exp.Table):
                            tables.append(this)
                    if query_node.args.get("joins"):
                        for join in query_node.args["joins"]:
                            if isinstance(join.this, exp.Table):
                                tables.append(join.this)
                                
                    for table in tables:
                        t_name = table.name.lower()
                        t_alias = table.alias_or_name
                        if t_name in tiebreakers:
                            found_schema_tiebreakers = True
                            for col in tiebreakers[t_name]:
                                col_expr = sqlglot.parse_one(f"{t_alias}.{col}")
                                col_sql = col_expr.sql(dialect='sqlite').lower()
                                bare_col = col.lower()
                                if col_sql not in existing_sql and bare_col not in existing_sql:
                                    append_exprs.append(col_expr)
                                    existing_sql.append(col_sql)
                                    
                if not found_schema_tiebreakers:
                    # Fallback to appending SELECT expressions
                    
                    # For Union, find the first Select node to get expressions
                    first_select = query_node
                    while hasattr(first_select, "this") and not isinstance(first_select, exp.Select):
                        first_select = first_select.this
                    
                    if isinstance(first_select, exp.Select):
                        select_exprs = [e for e in first_select.expressions if not isinstance(e, exp.Star)]
                        for s_expr in select_exprs:
                            if isinstance(s_expr, exp.Alias):
                                append_expr = sqlglot.parse_one(s_expr.alias_or_name)
                            else:
                                append_expr = s_expr.copy()
                                
                            if append_expr.sql(dialect='sqlite').lower() not in existing_sql:
                                append_exprs.append(append_expr)
                                existing_sql.append(append_expr.sql(dialect='sqlite').lower())
                                
                for expr in append_exprs:
                    # By default, add NULLS LAST for deterministic ordering. 
                    # sqlglot transpiler will handle dialect-specific conversions automatically 
                    # (e.g. Postgres removes it because it's default, MySQL translates to CASE WHEN)
                    order.append("expressions", exp.Ordered(this=expr, nulls_first=False))
                            
        return parsed.sql(dialect=dialect)
    except Exception:
        # Fallback to original query on parsing failure
        return query

def _fix_vendor_functions(node, target_dialect='sqlite'):
    if isinstance(node, exp.Anonymous):
        name = node.name.upper()
        if name == 'ISNULL':
            args = node.expressions
            if len(args) == 1:
                return exp.Is(this=args[0], expression=exp.Null())
            elif len(args) == 2:
                return exp.Coalesce(this=args[0], expressions=[args[1]])
        elif name == 'NVL':
            args = node.expressions
            if len(args) >= 2:
                return exp.Coalesce(this=args[0], expressions=args[1:])
        elif name == 'IFNULL':
            args = node.expressions
            if len(args) == 2:
                return exp.Coalesce(this=args[0], expressions=[args[1]])
    elif target_dialect == 'sqlite' and isinstance(node, exp.Extract):
        this = node.this
        expr = node.expression
        field = this.name.lower() if hasattr(this, 'name') else str(this).lower()
        if field == 'year':
            return sqlglot.parse_one(f"CAST(STRFTIME('%Y', {expr.sql(dialect='sqlite')}) AS INTEGER)", read='sqlite')
        elif field == 'month':
            return sqlglot.parse_one(f"CAST(STRFTIME('%m', {expr.sql(dialect='sqlite')}) AS INTEGER)", read='sqlite')
        elif field == 'day':
            return sqlglot.parse_one(f"CAST(STRFTIME('%d', {expr.sql(dialect='sqlite')}) AS INTEGER)", read='sqlite')
    elif target_dialect == 'sqlite' and isinstance(node, (exp.Add, exp.Sub)):
        left = node.this
        right = node.expression
        is_sub = isinstance(node, exp.Sub)

        if isinstance(right, exp.Interval):
            val_str = right.this.name if hasattr(right.this, 'name') else str(right.this)
            unit_str = right.unit.name.lower() if right.unit and hasattr(right.unit, 'name') else 'day'
            sign = '-' if is_sub else '+'
            modifier = f"{sign}{val_str} {unit_str}"

            if isinstance(left, exp.Cast):
                date_val = left.this.sql(dialect='sqlite')
            else:
                date_val = left.sql(dialect='sqlite')
            return exp.Anonymous(this="DATE", expressions=[sqlglot.parse_one(date_val, read='sqlite'), exp.Literal.string(modifier)])

        elif not is_sub and isinstance(left, exp.Interval):
            val_str = left.this.name if hasattr(left.this, 'name') else str(left.this)
            unit_str = left.unit.name.lower() if left.unit and hasattr(left.unit, 'name') else 'day'
            modifier = f"+{val_str} {unit_str}"
            if isinstance(right, exp.Cast):
                date_val = right.this.sql(dialect='sqlite')
            else:
                date_val = right.sql(dialect='sqlite')
            return exp.Anonymous(this="DATE", expressions=[sqlglot.parse_one(date_val, read='sqlite'), exp.Literal.string(modifier)])
    elif isinstance(node, exp.Subquery):
        alias_obj = node.args.get('alias')
        if alias_obj and isinstance(alias_obj, exp.TableAlias) and alias_obj.args.get('columns'):
            cols = alias_obj.args['columns']
            sub_select = node.this
            if isinstance(sub_select, exp.Select):
                for idx, col in enumerate(cols):
                    if idx < len(sub_select.expressions):
                        curr_expr = sub_select.expressions[idx]
                        if not isinstance(curr_expr, exp.Alias):
                            sub_select.expressions[idx] = exp.Alias(this=curr_expr, alias=col)
                alias_obj.args['columns'] = []
    elif isinstance(node, exp.Values):
        alias_obj = node.args.get('alias')
        if alias_obj and isinstance(alias_obj, exp.TableAlias) and alias_obj.args.get('columns'):
            cols = alias_obj.args['columns']
            t_alias = alias_obj.this

            new_values = node.copy()
            new_values.args['alias'] = exp.TableAlias(this=t_alias)

            select_exprs = []
            for idx, col in enumerate(cols, start=1):
                select_exprs.append(exp.Alias(
                    this=exp.Column(this=exp.Identifier(this=f'column{idx}', quoted=False)),
                    alias=col
                ))
            subquery = exp.Subquery(
                this=exp.Select(expressions=select_exprs).from_(new_values),
                alias=exp.TableAlias(this=t_alias)
            )
            return subquery
    return node

def normalize_sql(sql: str, schema: str = None, dialect: str = 'sqlite', write_dialect: str = None, mock_time: bool = True, augment_order: bool = True, frozen_time: datetime = None) -> str:
    """
    Transforms the query by applying time mocking and ORDER BY augmentation.
    This prepares the query for deterministic dataset generation and execution testing.
    """
    if dialect == 'postgresql':
        dialect = 'postgres'
    if write_dialect is None:
        write_dialect = dialect
    elif write_dialect == 'postgresql':
        write_dialect = 'postgres'

    try:
        parsed = sqlglot.parse_one(sql, read=dialect)
        parsed = parsed.transform(lambda n: _fix_vendor_functions(n, write_dialect))
        norm_q = parsed.sql(dialect=write_dialect)
    except Exception:
        norm_q = sql

    exec_q = norm_q

    if mock_time:
        if frozen_time is None:
            frozen_time = datetime(2025, 1, 1, 0, 0, 0)
        exec_q = replace_time(exec_q, frozen_time=frozen_time, dialect=write_dialect)

    if schema and augment_order:
        exec_q = augment_order_by(exec_q, schema, dialect=write_dialect)

    return exec_q

