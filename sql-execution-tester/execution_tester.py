try:
    import pysqlite3 as sqlite3
except ImportError:
    import sqlite3
import re
from collections import Counter
import time
import threading
from datetime import datetime
from column_matcher import check_column_subset
from db_connection import DBConnection
from query_normalizer import normalize_sql


def _reset_db_random(db_context, conn):
    if db_context and hasattr(db_context, 'reset_random'):
        db_context.reset_random()


def _execute_query_with_timeout(conn, sql: str, timeout: float = 2.0) -> list:
    """Executes a SQL query with a timeout using conn.interrupt to prevent infinite recursion/hanging."""
    timer = None
    if hasattr(conn, 'interrupt'):
        timer = threading.Timer(timeout, conn.interrupt)
        timer.daemon = True
        timer.start()
    elif hasattr(conn, 'cancel'):
        timer = threading.Timer(timeout, conn.cancel)
        timer.daemon = True
        timer.start()
    try:
        cur = conn.cursor()
        cur.execute(sql)
        res = list(cur.fetchall())
        cur.close()
        return res
    finally:
        if timer is not None:
            timer.cancel()


def _make_type_aware(res: list) -> list:
    """Wraps each value in the result rows with its Python type to enforce strict equality."""
    if res is None:
        return res
    return [tuple((v, type(v)) for v in row) for row in res]

def _is_syntax_error(e: Exception) -> bool:
    err_str = str(e).lower()
    class_name = e.__class__.__name__
    
    if "syntax error" in err_str:
        return True
    if class_name == "SyntaxError":
        return True
    # MySQL error code 1064 is syntax error
    if "1064" in err_str and "syntax" in err_str:
        return True
    return False


def generate_reproducible_sql(schema: str, dataset: str, gold_sql: str, prediction_sql: str, dialect: str = "sqlite", gold_res: list = None, pred_res: list = None) -> str:
    if dialect not in ("sqlite", "postgres", "postgresql"):
        return ""
    
    sql_parts = []
    sql_parts.append("-- Schema DDL")
    if schema:
        schema = schema.strip()
        sql_parts.append(schema)
        if not schema.endswith(';'):
            sql_parts[-1] += ';'
    
    sql_parts.append("\n-- Loading data")
    if dialect == "sqlite":
        sql_parts.append("PRAGMA foreign_keys = OFF;")
    elif dialect in ("postgres", "postgresql"):
        sql_parts.append("BEGIN;")
    
    if dataset:
        dataset = dataset.strip()
        sql_parts.append(dataset)
        if not dataset.endswith(';'):
            sql_parts[-1] += ';'
    
    if dialect == "sqlite":
        sql_parts.append("PRAGMA foreign_keys = ON;")
        sql_parts.append("PRAGMA foreign_key_check;")
    elif dialect in ("postgres", "postgresql"):
        sql_parts.append("COMMIT;")
    
    sql_parts.append("\n-- Gold Query")
    if gold_sql:
        gold_sql = gold_sql.strip()
        sql_parts.append(gold_sql + (";" if not gold_sql.endswith(";") else ""))
        
    if gold_res is not None:
        sql_parts.append("\n/*\nGold Result:")
        for row in gold_res:
            sql_parts.append(str(row))
        sql_parts.append("*/")
    
    sql_parts.append("\n-- Prediction Query")
    if prediction_sql:
        prediction_sql = prediction_sql.strip()
        sql_parts.append(prediction_sql + (";" if not prediction_sql.endswith(";") else ""))
        
    if pred_res is not None:
        sql_parts.append("\n/*\nPrediction Result:")
        for row in pred_res:
            sql_parts.append(str(row))
        sql_parts.append("*/")
    
    return "\n".join(sql_parts)

def _create_response(status, reason=None, dataset=None, ddl=None, gold_res=None, pred_res=None, error_msg=None):
    return {
        "status": status,
        "reason": reason,
        "dataset": dataset,
        "ddl": ddl,
        "gold_sql_result": gold_res,
        "prediction_sql_result": pred_res,
        "error_message": error_msg
    }

def _execution_test_internal(schema: str = None, dataset: str = None, gold_sql: str = "", prediction_sql: str = "", 
                   sleep_time: float = 0.0, strict_type_checking: bool = False, 
                   ignore_order_for_order_by: bool = False, conn: sqlite3.Connection = None, 
                   strict_column_ordering: bool = True, allow_extra_columns_in_q2: bool = True, 
                   verbose: bool = False, dialect: str = 'sqlite', db_config: dict = None) -> dict:
    


    exec_q1 = gold_sql
    exec_q2 = prediction_sql

    db_context = None
    if conn is None:
        try:
            db_context = DBConnection(dialect, schema, dataset, db_config=db_config)
            conn = db_context.setup_db()
        except Exception as e:
            if db_context:
                try:
                    db_context.close()
                except Exception:
                    pass
            err_msg = str(e)
            if err_msg.startswith("SCHEMA_ERROR:"):
                return _create_response("ERROR_SCHEMA_LOADING", error_msg=err_msg, dataset=dataset, ddl=schema)
            if err_msg.startswith("DATASET_ERROR:"):
                return _create_response("ERROR_DATASET_LOADING", error_msg=err_msg, dataset=dataset, ddl=schema)
            return _create_response("ERROR_QUERY_EXECUTION", error_msg=err_msg, dataset=dataset, ddl=schema)

    gold_res = None
    err1 = None
    exc1 = None
    try:
        _reset_db_random(db_context, conn)
        gold_res = _execute_query_with_timeout(conn, exec_q1)
    except Exception as e:
        err1 = str(e)
        exc1 = e

    if sleep_time > 0:
        time.sleep(sleep_time)

    pred_res = None
    err2 = None
    exc2 = None
    try:
        _reset_db_random(db_context, conn)
        pred_res = _execute_query_with_timeout(conn, exec_q2)
    except Exception as e:
        err2 = str(e)
        exc2 = e

    if db_context:
        try:
            db_context.close()
        except Exception:
            pass

    if err1 or err2:
        if err1 and err2:
            if _is_syntax_error(exc1) and _is_syntax_error(exc2):
                return _create_response("ERROR_SYNTAX", error_msg="Both queries have syntax errors.", dataset=dataset, ddl=schema)
            return _create_response("ERROR_QUERY_EXECUTION", error_msg=f"Both failed. Gold: {err1}, Pred: {err2}", dataset=dataset, ddl=schema)
        if err1:
            if _is_syntax_error(exc1):
                return _create_response("ERROR_SYNTAX", error_msg=f"Gold syntax error: {err1}", dataset=dataset, ddl=schema)
            return _create_response("ERROR_QUERY_EXECUTION", error_msg=f"Gold execution error: {err1}", dataset=dataset, ddl=schema)
        if err2:
            if _is_syntax_error(exc2):
                return _create_response("ERROR_SYNTAX", error_msg=f"Prediction syntax error: {err2}", dataset=dataset, ddl=schema, gold_res=gold_res)
            return _create_response("ERROR_QUERY_EXECUTION", error_msg=f"Prediction execution error: {err2}", dataset=dataset, ddl=schema, gold_res=gold_res)

    if len(gold_res) != len(pred_res): # type: ignore
        return _create_response("NEQ", reason="row_count_mismatch", dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res)

    has_order1 = bool(re.search(r'\border\s+by\b', gold_sql, re.IGNORECASE))
    
    res1_cmp = _make_type_aware(gold_res) if strict_type_checking else gold_res # type: ignore
    res2_cmp = _make_type_aware(pred_res) if strict_type_checking else pred_res # type: ignore

    order_matters = has_order1 and not ignore_order_for_order_by

    def check_match(strict_ordering_flag: bool) -> bool:
        if strict_ordering_flag:
            if allow_extra_columns_in_q2:
                if not res1_cmp and not res2_cmp: return True
                if not res1_cmp or not res2_cmp: return False
                C = len(res1_cmp[0])
                K = len(res2_cmp[0])
                if K < C: return False
                
                q2_prefix = [row[:C] for row in res2_cmp]
                if order_matters:
                    return res1_cmp == q2_prefix
                else:
                    return Counter(res1_cmp) == Counter(q2_prefix) # type: ignore
            else:
                if order_matters:
                    return res1_cmp == res2_cmp
                else:
                    return Counter(res1_cmp) == Counter(res2_cmp) # type: ignore
        else:
            if allow_extra_columns_in_q2:
                return check_column_subset(res1_cmp, res2_cmp, order_matters=order_matters) # type: ignore
            else:
                if not res1_cmp and not res2_cmp: return True
                if not res1_cmp or not res2_cmp: return False
                if len(res1_cmp[0]) != len(res2_cmp[0]): return False
                return check_column_subset(res1_cmp, res2_cmp, order_matters=order_matters) # type: ignore

    match_strict = check_match(True)
    match_relaxed = check_match(False)
    
    if match_strict or (not strict_column_ordering and match_relaxed):
        return _create_response("EQ_EXEC", reason="identical", dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res)
    else:
        final_status = "NEQ_SCO" if match_relaxed else "NEQ"
        reason = "value_mismatch"
        
        c1 = Counter(res1_cmp)
        if allow_extra_columns_in_q2 and len(res2_cmp) > 0 and len(res1_cmp) > 0 and len(res2_cmp[0]) >= len(res1_cmp[0]):
            c2 = Counter([r[:len(res1_cmp[0])] for r in res2_cmp])
        else:
            c2 = Counter(res2_cmp)
            
        if c1 == c2:
            reason = "row_order_mismatch"
        elif set(c1.keys()) == set(c2.keys()):
            reason = "duplicate_count_mismatch"
        elif match_relaxed:
            reason = "column_order_mismatch"
        elif len(res1_cmp) > 0 and len(res2_cmp) > 0 and len(res1_cmp[0]) != len(res2_cmp[0]):
            reason = "column_count_mismatch"
            
        return _create_response(final_status, reason=reason, dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res)

def _execution_test_batch_internal(schema: str = None, dataset: str = None, gold_sql: str = "", prediction_sqls: list[str] = None, 
                   sleep_time: float = 0.0, strict_type_checking: bool = False, 
                   ignore_order_for_order_by: bool = False, conn: sqlite3.Connection = None, 
                   strict_column_ordering: bool = True, allow_extra_columns_in_q2: bool = True, 
                   verbose: bool = False, dialect: str = 'sqlite', db_config: dict = None) -> list[dict]:
    
    if prediction_sqls is None:
        prediction_sqls = []

    db_context = None
    if conn is None:
        try:
            db_context = DBConnection(dialect, schema, dataset, db_config=db_config)
            conn = db_context.setup_db()
        except Exception as e:
            if db_context:
                try:
                    db_context.close()
                except Exception:
                    pass
            err_msg = str(e)
            if err_msg.startswith("SCHEMA_ERROR:"):
                return [_create_response("ERROR_SCHEMA_LOADING", error_msg=err_msg, dataset=dataset, ddl=schema)] * len(prediction_sqls)
            if err_msg.startswith("DATASET_ERROR:"):
                return [_create_response("ERROR_DATASET_LOADING", error_msg=err_msg, dataset=dataset, ddl=schema)] * len(prediction_sqls)
            return [_create_response("ERROR_QUERY_EXECUTION", error_msg=err_msg, dataset=dataset, ddl=schema)] * len(prediction_sqls)

    gold_res = None
    err1 = None
    exc1 = None
    try:
        _reset_db_random(db_context, conn)
        gold_res = _execute_query_with_timeout(conn, gold_sql)
    except Exception as e:
        err1 = str(e)
        exc1 = e

    if sleep_time > 0:
        time.sleep(sleep_time)

    results = []
    
    has_order1 = bool(re.search(r'\border\s+by\b', gold_sql, re.IGNORECASE))
    order_matters = has_order1 and not ignore_order_for_order_by
    res1_cmp = _make_type_aware(gold_res) if (not err1 and strict_type_checking) else gold_res

    for exec_q2 in prediction_sqls:
        pred_res = None
        err2 = None
        exc2 = None
        try:
            _reset_db_random(db_context, conn)
            pred_res = _execute_query_with_timeout(conn, exec_q2)
        except Exception as e:
            err2 = str(e)
            exc2 = e

        if err1:
            try:
                _execute_query_with_timeout(conn, exec_q2)
            except Exception as e:
                # Both failed
                if _is_syntax_error(exc1) and _is_syntax_error(e):
                    results.append(_create_response("ERROR_SYNTAX", error_msg="Both queries have syntax errors.", dataset=dataset, ddl=schema))
                else:
                    results.append(_create_response("ERROR_QUERY_EXECUTION", error_msg=f"Both failed. Gold: {err1}, Pred: {e}", dataset=dataset, ddl=schema))
            else:
                if _is_syntax_error(exc1):
                    results.append(_create_response("ERROR_SYNTAX", error_msg=f"Gold syntax error: {err1}", dataset=dataset, ddl=schema))
                else:
                    results.append(_create_response("ERROR_QUERY_EXECUTION", error_msg=f"Gold execution failure: {err1}", dataset=dataset, ddl=schema))
            continue

        if err2:
            if _is_syntax_error(exc2):
                 results.append(_create_response("ERROR_SYNTAX", error_msg=f"Prediction syntax error: {err2}", dataset=dataset, ddl=schema, gold_res=gold_res))
            else:
                 results.append(_create_response("ERROR_QUERY_EXECUTION", error_msg=f"Prediction execution failure: {err2}", dataset=dataset, ddl=schema, gold_res=gold_res))
            continue

        if len(gold_res) != len(pred_res): # type: ignore
            results.append(_create_response("NEQ", reason="row_count_mismatch", dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res))
            continue

        res2_cmp = _make_type_aware(pred_res) if strict_type_checking else pred_res # type: ignore

        def check_match(strict_ordering_flag: bool) -> bool:
            if strict_ordering_flag:
                if allow_extra_columns_in_q2:
                    if not res1_cmp and not res2_cmp: return True
                    if not res1_cmp or not res2_cmp: return False
                    C = len(res1_cmp[0])
                    K = len(res2_cmp[0])
                    if K < C: return False
                    
                    q2_prefix = [row[:C] for row in res2_cmp]
                    if order_matters:
                        return res1_cmp == q2_prefix
                    else:
                        return Counter(res1_cmp) == Counter(q2_prefix) # type: ignore
                else:
                    if order_matters:
                        return res1_cmp == res2_cmp
                    else:
                        return Counter(res1_cmp) == Counter(res2_cmp) # type: ignore
            else:
                if allow_extra_columns_in_q2:
                    return check_column_subset(res1_cmp, res2_cmp, order_matters=order_matters) # type: ignore
                else:
                    if not res1_cmp and not res2_cmp: return True
                    if not res1_cmp or not res2_cmp: return False
                    if len(res1_cmp[0]) != len(res2_cmp[0]): return False
                    return check_column_subset(res1_cmp, res2_cmp, order_matters=order_matters) # type: ignore

        match_strict = check_match(True)
        match_relaxed = check_match(False)
        
        if match_strict or (not strict_column_ordering and match_relaxed):
            results.append(_create_response("EQ_EXEC", reason="identical", dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res))
        else:
            final_status = "NEQ_SCO" if match_relaxed else "NEQ"
            reason = "value_mismatch"
            
            c1 = Counter(res1_cmp)
            if allow_extra_columns_in_q2 and len(res2_cmp) > 0 and len(res1_cmp) > 0 and len(res2_cmp[0]) >= len(res1_cmp[0]):
                c2 = Counter([r[:len(res1_cmp[0])] for r in res2_cmp])
            else:
                c2 = Counter(res2_cmp)
                
            if c1 == c2:
                reason = "row_order_mismatch"
            elif set(c1.keys()) == set(c2.keys()):
                reason = "duplicate_count_mismatch"
            elif match_relaxed:
                reason = "column_order_mismatch"
            elif len(res1_cmp) > 0 and len(res2_cmp) > 0 and len(res1_cmp[0]) != len(res2_cmp[0]):
                reason = "column_count_mismatch"
                
            results.append(_create_response(final_status, reason=reason, dataset=dataset, ddl=schema, gold_res=gold_res, pred_res=pred_res))
            
    if db_context:
        try:
            db_context.close()
        except Exception:
            pass

    return results

def _add_reproducible_cex(res_dict: dict, gold_sql: str, prediction_sql: str, dialect: str) -> dict:
    if dialect in ("sqlite", "postgres", "postgresql") and (res_dict.get("dataset") or res_dict.get("ddl")):
        cex = generate_reproducible_sql(
            res_dict.get("ddl") or "", 
            res_dict.get("dataset") or "", 
            gold_sql, 
            prediction_sql, 
            dialect,
            res_dict.get("gold_sql_result"),
            res_dict.get("prediction_sql_result")
        )
        error_msg = res_dict.get("error_message")
        if error_msg:
            cex += "\n\n-- Execution Error:\n" + "\n".join(f"-- {line}" for line in str(error_msg).split('\n'))
        res_dict["reproducible_cex"] = cex
    else:
        res_dict["reproducible_cex"] = ""
    return res_dict

def execution_test(schema: str = None, dataset: str = None, gold_sql: str = "", prediction_sql: str = "", 
                   sleep_time: float = 0.0, strict_type_checking: bool = False, 
                   ignore_order_for_order_by: bool = False, conn: sqlite3.Connection = None, 
                   strict_column_ordering: bool = True, allow_extra_columns_in_q2: bool = True, 
                   verbose: bool = False, dialect: str = 'sqlite', db_config: dict = None) -> dict:
    res = _execution_test_internal(
        schema=schema, dataset=dataset, gold_sql=gold_sql, prediction_sql=prediction_sql, 
        sleep_time=sleep_time, strict_type_checking=strict_type_checking, 
        ignore_order_for_order_by=ignore_order_for_order_by, conn=conn, 
        strict_column_ordering=strict_column_ordering, allow_extra_columns_in_q2=allow_extra_columns_in_q2, 
        verbose=verbose, dialect=dialect, db_config=db_config
    )
    return _add_reproducible_cex(res, gold_sql, prediction_sql, dialect)

def execution_test_batch(schema: str = None, dataset: str = None, gold_sql: str = "", prediction_sqls: list[str] = None, 
                   sleep_time: float = 0.0, strict_type_checking: bool = False, 
                   ignore_order_for_order_by: bool = False, conn: sqlite3.Connection = None, 
                   strict_column_ordering: bool = True, allow_extra_columns_in_q2: bool = True, 
                   verbose: bool = False, dialect: str = 'sqlite', db_config: dict = None) -> list[dict]:
    results = _execution_test_batch_internal(
        schema=schema, dataset=dataset, gold_sql=gold_sql, prediction_sqls=prediction_sqls, 
        sleep_time=sleep_time, strict_type_checking=strict_type_checking, 
        ignore_order_for_order_by=ignore_order_for_order_by, conn=conn, 
        strict_column_ordering=strict_column_ordering, allow_extra_columns_in_q2=allow_extra_columns_in_q2, 
        verbose=verbose, dialect=dialect, db_config=db_config
    )
    if prediction_sqls is None:
        prediction_sqls = []
    
    for i, res in enumerate(results):
        pred_sql = prediction_sqls[i] if i < len(prediction_sqls) else ""
        results[i] = _add_reproducible_cex(res, gold_sql, pred_sql, dialect)
    
    return results
