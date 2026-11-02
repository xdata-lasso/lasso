import json
import argparse
import os
import sys
import time
import sqlite3
import csv
import re
import subprocess
import tempfile
from collections import Counter
from tqdm import tqdm
import sqlglot
from sqlglot import exp

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.abspath(os.path.join(script_dir, '../sql-execution-tester')))

try:
    from execution_tester import execution_test_batch
except ImportError as e:
    print(f"Error importing execution_test/query_normalizer: {e}")
    sys.exit(1)

from timeout_utils import run_with_timeout
import csv_utils
import benchmark_loader

XDATA_TOOL_NAME = os.environ.get('XDATA_TOOL_NAME', 'xdata')
TOOL_LABEL = "XData (Public)" if XDATA_TOOL_NAME == "xdatapublic" else "XData"

if os.environ.get('XDATA_ROOT'):
    XDATA_ROOT = os.environ['XDATA_ROOT']
elif os.path.exists(os.path.join(script_dir, 'originals', 'XData-DataGen')):
    XDATA_ROOT = os.path.join(script_dir, 'originals', 'XData-DataGen')
elif os.path.exists(os.path.join(script_dir, 'originals', 'xdatapublic')):
    XDATA_ROOT = os.path.join(script_dir, 'originals', 'xdatapublic')
else:
    XDATA_ROOT = os.path.join(script_dir, 'XData-DataGen')

SAMPLE_DATA_DIR = os.environ.get('XDATA_SAMPLE_DATA_DIR', os.path.join(XDATA_ROOT, 'sample_data'))
Z3_LIB_DIR = os.environ.get('XDATA_Z3_LIB_DIR', os.path.join(XDATA_ROOT, 'Z3files' if not os.path.exists(os.path.join(XDATA_ROOT, 'xdata', 'z3')) else os.path.join(XDATA_ROOT, 'xdata', 'z3')))
BIN_DIR = os.environ.get('XDATA_BIN_DIR', os.path.join(XDATA_ROOT, 'bin'))
JARS_DIR = os.environ.get('XDATA_JARS_DIR', os.path.join(XDATA_ROOT, 'XData', 'jars' if not os.path.exists(os.path.join(XDATA_ROOT, 'xdata', 'jars')) else os.path.join(XDATA_ROOT, 'xdata', 'jars')))

if os.environ.get('JAVA_CLASSPATH'):
    JAVA_CLASSPATH = os.environ['JAVA_CLASSPATH']
else:
    JAVA_CLASSPATH = ":".join([
        BIN_DIR,
        os.path.join(JARS_DIR, "postgresql-42.7.4.jar"),
        os.path.join(JARS_DIR, "jsqlparser-5.0.jar"),
        os.path.join(JARS_DIR, "sqlbuilder-3.0.2.jar"),
        os.path.join(JARS_DIR, "com.microsoft.z3.jar"),
        os.path.join(JARS_DIR, "sqlite-jdbc-3.45.2.0.jar"),
        os.path.join(JARS_DIR, "tomcat-jdbc-7.0.54.jar"),
        os.path.join(JARS_DIR, "tomcat-juli-7.0.54.jar"),
        os.path.join(JARS_DIR, "automaton.jar"),
        os.path.join(JARS_DIR, "derby-10.8.jar"),
        os.path.join(JARS_DIR, "google-collect-1.0-rc2.jar"),
        os.path.join(JARS_DIR, "gson-2.2.4.jar"),
        os.path.join(JARS_DIR, "ojdbc6-11.2.0.2.0.jar"),
        os.path.join(JARS_DIR, "uncommons-maths-1.2.jar"),
        os.path.join(JARS_DIR, "mysql-connector-java-8.0.16.jar"),
        os.path.join(JARS_DIR, "slf4j-api-2.0.9.jar")
    ])

def ensure_xdata_bridge_ready():
    """
    Ensures that testDataGen.XDataBridge is compiled and compatible with the current java runtime.
    """
    bridge_class = os.path.join(BIN_DIR, "testDataGen", "XDataBridge.class")
    need_compile = not os.path.exists(bridge_class)
    if not need_compile:
        try:
            res = subprocess.run(
                ["java", f"-Djava.library.path={Z3_LIB_DIR}", "-cp", JAVA_CLASSPATH, "testDataGen.XDataBridge"],
                stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=5
            )
            if "Usage: XDataBridge" not in (res.stderr + res.stdout):
                need_compile = True
        except Exception:
            need_compile = True

    if need_compile:
        os.makedirs(BIN_DIR, exist_ok=True)
        try:
            bridge_src = os.path.join(XDATA_ROOT, "XData", "testDataGen", "XDataBridge.java")
            if not os.path.exists(bridge_src):
                bridge_src = os.path.join(script_dir, "XData-DataGen", "XData", "testDataGen", "XDataBridge.java")
            if os.path.exists(os.path.join(JARS_DIR, "xdata.jar")):
                print(f"Compiling XDataBridge for {TOOL_LABEL}...")
                subprocess.run(["javac", "-cp", JAVA_CLASSPATH, "-d", BIN_DIR, bridge_src], check=True)
            else:
                src_dir = os.path.join(XDATA_ROOT, "XData")
                java_files = []
                for root, _, files in os.walk(src_dir):
                    for file in files:
                        if file.endswith(".java"):
                            java_files.append(os.path.join(root, file))
                if java_files:
                    print("Compiling XData-DataGen Java sources...")
                    subprocess.run(["javac", "-cp", JAVA_CLASSPATH, "-d", BIN_DIR] + java_files, check=True)

            util_bin = os.path.join(BIN_DIR, "util")
            os.makedirs(util_bin, exist_ok=True)
            prop_src = os.path.join(XDATA_ROOT, "XData", "util", "XData.properties")
            if not os.path.exists(prop_src):
                prop_src = os.path.join(script_dir, "XData-DataGen", "XData", "util", "XData.properties")
            if os.path.exists(prop_src):
                import shutil
                shutil.copy2(prop_src, os.path.join(util_bin, "XData.properties"))
        except Exception as e:
            print(f"Warning: Failed to compile XDataBridge: {e}")

schemas_data_global = benchmark_loader.get_schemas(base_dir=script_dir)

def get_ddl(database_id, dialect='sqlite'):
    if database_id in schemas_data_global:
        schema_entry = schemas_data_global[database_id]
        if dialect in ('postgres', 'postgresql'):
            return schema_entry.get("ddl_postgres") or schema_entry.get("ddl_postgresql") or schema_entry.get("ddl", "")
        return schema_entry.get("ddl", "")
    return ""

SUPPORTED_BENCHMARKS = {'calcite', 'xdata', 'tpch', 'largejoin', 'lasso-bm'}

def get_sample_data_path(database_id, source):
    return benchmark_loader.get_sample_data_path(database_id, source, base_dir=script_dir)

def prepare_postgres_ddl(sqlite_ddl):
    """
    Prepares PostgreSQL DDL from SQLite DDL:
    - Topologically sorts CREATE TABLE statements (parents before children) to satisfy FK constraints.
    - Normalizes identifiers to lowercase.
    - Normalizes SQLite types for PostgreSQL compatibility.
    - Explicitly names all check constraints as <table_name>_<col_name>_check.
    - Propagates column-level CHECK constraints across FOREIGN KEYs so child tables
      inherit domain check constraints, ensuring TableMap detects all valid domain constants.
    """
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
            return  # break cycle
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

    # Normalize SQLite types for PostgreSQL compatibility:
    ordered_ddl = re.sub(r'\bTEXT\s*\(\s*(\d+)\s*\)', r'VARCHAR(\1)', ordered_ddl, flags=re.I)
    ordered_ddl = re.sub(r'\b(?:FLOAT|REAL)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)', r'NUMERIC(\1, \2)', ordered_ddl, flags=re.I)
    ordered_ddl = re.sub(r'\b(?:FLOAT|REAL)\s*\(\s*(\d+)\s*\)', r'NUMERIC(\1)', ordered_ddl, flags=re.I)
    ordered_ddl = re.sub(r'("slacker"\s+)INT(?:EGER)?', r'\1BOOLEAN', ordered_ddl, flags=re.I)

    try:
        try:
            parsed = sqlglot.parse(ordered_ddl, read="postgres")
        except Exception:
            parsed = sqlglot.parse(ordered_ddl, read="sqlite")

        for stmt in parsed:
            for node in stmt.walk():
                if isinstance(node, exp.Identifier):
                    node.set("this", node.this.lower())

        col_checks = {}
        fk_relations = []
        create_tables = [stmt for stmt in parsed if isinstance(stmt, exp.Create) and isinstance(stmt.this, exp.Schema)]

        for create in create_tables:
            schema = create.this
            tname = (schema.this.name if hasattr(schema.this, 'name') else str(schema.this)).lower()
            for expr in schema.expressions:
                if isinstance(expr, exp.ColumnDef):
                    col_name = (expr.this.name if hasattr(expr.this, 'name') else str(expr.this)).lower()
                    for constraint in expr.find_all(exp.ColumnConstraint):
                        if isinstance(constraint.kind, (exp.CheckColumnConstraint, exp.Check)):
                            check_expr = constraint.kind.this
                            col_checks[(tname, col_name)] = check_expr.sql(dialect="postgres")
                elif isinstance(expr, exp.ForeignKey):
                    child_cols = [(c.name if hasattr(c, 'name') else str(c)).lower() for c in expr.expressions if isinstance(c, (exp.Column, exp.Identifier))]
                    ref = expr.args.get("reference") or expr.find(exp.Reference)
                    if ref:
                        schema_node = ref.this if isinstance(ref.this, exp.Schema) else ref
                        table_node = schema_node.this if isinstance(schema_node.this, exp.Table) else (schema_node.find(exp.Table) or schema_node)
                        parent_table = (table_node.name if hasattr(table_node, 'name') else str(table_node)).lower()
                        parent_cols = [(c.name if hasattr(c, 'name') else str(c)).lower() for c in schema_node.expressions if isinstance(c, (exp.Column, exp.Identifier))]
                        if len(child_cols) == len(parent_cols):
                            fk_relations.append((tname, child_cols, parent_table, parent_cols))

        # Propagate domain check constraints through FKs
        changed = True
        while changed:
            changed = False
            for (child_t, child_cols, parent_t, parent_cols) in fk_relations:
                for c_col, p_col in zip(child_cols, parent_cols):
                    if (parent_t, p_col) in col_checks and (child_t, c_col) not in col_checks:
                        parent_check_sql = col_checks[(parent_t, p_col)]
                        try:
                            p_expr = sqlglot.parse_one(parent_check_sql, read="postgres")
                            for node in p_expr.walk():
                                node_name = (node.name if hasattr(node, 'name') else str(node.this if hasattr(node, 'this') else node)).lower()
                                if isinstance(node, exp.Column) and node_name == p_col:
                                    node.set("this", exp.to_identifier(c_col))
                                elif isinstance(node, exp.Identifier) and node_name == p_col:
                                    node.set("this", c_col)
                            child_check_sql = p_expr.sql(dialect="postgres")
                            col_checks[(child_t, c_col)] = child_check_sql
                            changed = True
                        except Exception:
                            pass

        # Rewrite table definitions with explicit constraints
        for create in create_tables:
            schema = create.this
            tname = (schema.this.name if hasattr(schema.this, 'name') else str(schema.this)).lower()
            # Remove inline/unnamed checks
            for expr in list(schema.expressions):
                if isinstance(expr, exp.ColumnDef):
                    if "constraints" in expr.args:
                        expr.args["constraints"] = [
                            c for c in expr.args["constraints"]
                            if not isinstance(c.kind, (exp.CheckColumnConstraint, exp.Check))
                        ]
                elif isinstance(expr, exp.Check):
                    schema.expressions.remove(expr)
                elif isinstance(expr, exp.Constraint) and expr.find(exp.CheckColumnConstraint):
                    schema.expressions.remove(expr)

            existing_named_checks = set()
            for expr in schema.expressions:
                if isinstance(expr, exp.Constraint):
                    existing_named_checks.add(str(expr.this).lower())

            for (t, c), chk_sql in sorted(col_checks.items()):
                if t == tname:
                    expected_cname = f"{t}_{c}_check".lower()
                    if expected_cname not in existing_named_checks:
                        try:
                            chk_expr = sqlglot.parse_one(chk_sql, read="postgres")
                            table_constraint = exp.Constraint(
                                this=exp.to_identifier(expected_cname),
                                expressions=[exp.CheckColumnConstraint(this=chk_expr)]
                            )
                            schema.expressions.append(table_constraint)
                            existing_named_checks.add(expected_cname)
                        except Exception:
                            pass

        res_ddl = ";\n".join(stmt.sql(dialect="postgres") for stmt in parsed) + ";"
    except Exception:
        res_ddl = ordered_ddl

    return res_ddl

def run_xdata_bridge(pg_ddl, sample_data_path, gold_sql_pg, timeout=60):
    """
    Executes the XDataBridge Java CLI to generate test datasets.
    """
    with tempfile.NamedTemporaryFile(mode="w", suffix=".sql", delete=False) as df, \
         tempfile.NamedTemporaryFile(mode="w", suffix=".sql", delete=False) as qf, \
         tempfile.NamedTemporaryFile(mode="w", suffix=".json", delete=False) as of:
        
        df.write(pg_ddl)
        df.flush()
        qf.write(gold_sql_pg)
        qf.flush()

        ddl_path = df.name
        query_path = qf.name
        out_path = of.name

    env = os.environ.copy()
    env["LD_LIBRARY_PATH"] = f"{Z3_LIB_DIR}:" + env.get("LD_LIBRARY_PATH", "")
    env["DYLD_LIBRARY_PATH"] = f"{Z3_LIB_DIR}:" + env.get("DYLD_LIBRARY_PATH", "")

    cmd = [
        "java",
        f"-Djava.library.path={Z3_LIB_DIR}",
        "-cp",
        JAVA_CLASSPATH,
        "testDataGen.XDataBridge",
        ddl_path,
        sample_data_path,
        query_path,
        out_path,
        "1"
    ]

    proc = subprocess.Popen(cmd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, start_new_session=True)
    try:
        stdout, stderr = proc.communicate(timeout=timeout)
        if proc.returncode == 0 and os.path.exists(out_path) and os.path.getsize(out_path) > 0:
            try:
                with open(out_path, "r", encoding="utf-8") as f:
                    data = json.load(f)
                data["stdout"] = stdout
                data["stderr"] = stderr
                return data
            except Exception as je:
                err = stderr.strip() or stdout.strip() or str(je)
                return {"status": "ERROR", "datasets": [], "num_datasets": 0, "error": err, "stdout": stdout, "stderr": stderr}
        else:
            err = stderr.strip() or stdout.strip() or f"XDataBridge failed with exit code {proc.returncode}"
            return {"status": "ERROR", "datasets": [], "num_datasets": 0, "error": err, "stdout": stdout, "stderr": stderr}
    except subprocess.TimeoutExpired:
        try:
            import signal
            os.killpg(proc.pid, signal.SIGKILL)
        except Exception:
            try:
                proc.kill()
            except Exception:
                pass
        try:
            proc.wait(timeout=2)
        except Exception:
            pass
        return {"status": "TIMEOUT", "datasets": [], "num_datasets": 0, "error": f"Timeout after {timeout}s", "stdout": "", "stderr": ""}
    except Exception as e:
        try:
            import signal
            os.killpg(proc.pid, signal.SIGKILL)
        except Exception:
            try:
                proc.kill()
            except Exception:
                pass
        try:
            proc.wait(timeout=2)
        except Exception:
            pass
        return {"status": "ERROR", "datasets": [], "num_datasets": 0, "error": str(e), "stdout": "", "stderr": ""}
    finally:
        if os.path.exists(ddl_path):
            os.unlink(ddl_path)
        if os.path.exists(query_path):
            os.unlink(query_path)
        if os.path.exists(out_path):
            os.unlink(out_path)

def generate_xdata_with_timeout(pg_ddl: str, sample_data_path: str, query_sql_pg: str, timeout_sec: int):
    """
    Executes run_xdata_bridge with a per-call timeout.
    """
    start_time = time.time()
    try:
        bridge_res = run_xdata_bridge(pg_ddl, sample_data_path, query_sql_pg, timeout=timeout_sec)
        elapsed = time.time() - start_time
        status = bridge_res.get("status", "ERROR")
        stdout = bridge_res.get("stdout", "")
        stderr = bridge_res.get("stderr", "")
        if status == "TIMEOUT":
            meta = {
                "data_gen_time": float(timeout_sec),
                "num_datasets": 0,
                "error_message": f"Timeout after {timeout_sec}s",
                "stdout": stdout,
                "stderr": stderr,
            }
            return [], meta, "TIMEOUT"
        elif status != "SUCCESS":
            meta = {
                "data_gen_time": elapsed,
                "num_datasets": 0,
                "error_message": bridge_res.get("error", "Error generating data"),
                "stdout": stdout,
                "stderr": stderr,
            }
            return [], meta, status
        else:
            datasets = bridge_res.get("datasets", [])
            meta = {
                "data_gen_time": elapsed,
                "num_datasets": len(datasets),
                "error_message": "",
                "stdout": stdout,
                "stderr": stderr,
            }
            return datasets, meta, "SUCCESS"
    except Exception as e:
        elapsed = time.time() - start_time
        meta = {
            "data_gen_time": elapsed,
            "num_datasets": 0,
            "error_message": str(e),
            "stdout": "",
            "stderr": "",
        }
        return [], meta, "ERROR"

def log_datagen_start(query_label: str, query_sql: str):
    """
    Prints a concise one-line log before data generation starts.
    """
    msg = f"[DataGen] Generating for {query_label}"
    try:
        from tqdm import tqdm
        tqdm.write(msg)
    except Exception:
        print(msg, flush=True)

def xdata_worker(pg_ddl, ddl_content, sample_data_path, gold_sql_pg, gold_sql, prediction_queries_pg, prediction_queries, dialect, timeout=60, instance_id=None):
    """
    Unified Gold + Optimized N-Way Data Generation Worker for XData.
    1. Generates test datasets for Gold query with XData and tests all prediction queries on the target dialect.
    2. For any prediction query remaining unrefuted, executes optimized N-Way
       cross-mutant data generation with early termination.
    Each data generation call is bounded by `timeout` seconds.
    """
    import contextlib

    datagen_records = []
    pred_states = {}
    pids = list(prediction_queries.keys())
    unrefuted_pids = list(pids)

    for pid in pids:
        pred_states[pid] = {
            "status": "unrefuted",
            "raw_tool_status": "PENDING",
            "execution_result": None,
            "dataset_sql": "",
            "dataset_name": "",
            "dataset_source": "",
            "num_datasets": 0,
            "time_taken": 0.0,
            "timeout": False,
            "error_message": ""
        }

    # 1. GOLD QUERY DATA GENERATION
    query_label = f"{instance_id} (gold)" if instance_id else "gold"
    log_datagen_start(query_label, gold_sql_pg)
    gold_datasets, gold_meta, bridge_status = generate_xdata_with_timeout(pg_ddl, sample_data_path, gold_sql_pg, timeout)
    gold_gen_time = gold_meta["data_gen_time"]
    gold_error_str = gold_meta.get("error_message", "")
    num_gold_datasets = len(gold_datasets)

    gold_meta_rec = {
        "query_id": "gold",
        "query_type": "gold",
        "data_gen_time": gold_gen_time,
        "num_datasets": num_gold_datasets,
        "error_message": gold_error_str if bridge_status != "SUCCESS" else ""
    }
    datagen_records.append(gold_meta_rec)

    for pid in pids:
        pred_states[pid]["raw_tool_status"] = bridge_status
        pred_states[pid]["num_datasets"] = num_gold_datasets
        pred_states[pid]["time_taken"] = gold_gen_time
        if bridge_status == "TIMEOUT":
            pred_states[pid]["timeout"] = True
            pred_states[pid]["error_message"] = gold_error_str
        elif bridge_status != "SUCCESS":
            pred_states[pid]["error_message"] = gold_error_str

    # Evaluate candidate gold datasets with execution_test_batch on SQLite
    if bridge_status == "SUCCESS" and gold_datasets:
        for ds_item in gold_datasets:
            if not unrefuted_pids:
                break

            ds_sql = ds_item.get("sql", "")
            ds_name = ds_item.get("name", "")
            current_queries = [prediction_queries[pid] for pid in unrefuted_pids]

            try:
                with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                    test_results = execution_test_batch(
                        schema=ddl_content,
                        dataset=ds_sql,
                        gold_sql=gold_sql,
                        prediction_sqls=current_queries,
                        dialect=dialect
                    )

                still_unrefuted = []
                for i, res in enumerate(test_results):
                    pid = unrefuted_pids[i]
                    status = res.get("status", "")

                    if not pred_states[pid]['execution_result']:
                        pred_states[pid]['execution_result'] = res
                        pred_states[pid]['status'] = status
                        pred_states[pid]['raw_tool_status'] = bridge_status
                        pred_states[pid]['dataset_sql'] = ds_sql
                        pred_states[pid]['dataset_name'] = ds_name
                        pred_states[pid]['dataset_source'] = "gold"
                        pred_states[pid]['num_datasets'] = num_gold_datasets

                    if status.startswith("NEQ"):
                        pred_states[pid]['status'] = status
                        pred_states[pid]['raw_tool_status'] = bridge_status
                        pred_states[pid]['execution_result'] = res
                        pred_states[pid]['dataset_sql'] = ds_sql
                        pred_states[pid]['dataset_name'] = ds_name
                        pred_states[pid]['dataset_source'] = "gold"
                        pred_states[pid]['num_datasets'] = num_gold_datasets
                    else:
                        if status.startswith("ERROR") and not pred_states[pid]['status'].startswith("NEQ"):
                            pred_states[pid]['status'] = status
                            pred_states[pid]['raw_tool_status'] = bridge_status
                            pred_states[pid]['execution_result'] = res
                            pred_states[pid]['dataset_sql'] = ds_sql
                            pred_states[pid]['dataset_name'] = ds_name
                            pred_states[pid]['dataset_source'] = "gold"
                            pred_states[pid]['num_datasets'] = num_gold_datasets
                        still_unrefuted.append(pid)

                unrefuted_pids = still_unrefuted
            except Exception as ex:
                for pid in unrefuted_pids:
                    pred_states[pid]['status'] = "ERROR_QUERY_EXECUTION"
                    pred_states[pid]['execution_result'] = {"status": "ERROR_QUERY_EXECUTION", "error_message": str(ex)}

    # 2. TWO-WAY OPTIMIZED N-WAY CROSS-MUTANT REVERSE PASS (LEVEL 3)
    for pid in list(unrefuted_pids):
        if pid not in unrefuted_pids:
            continue

        pred_sql_pg = prediction_queries_pg[pid]
        query_label = pid if (instance_id and pid.startswith(str(instance_id))) else (f"{instance_id} ({pid})" if instance_id else pid)
        log_datagen_start(query_label, pred_sql_pg)

        pred_datasets, pred_meta, pred_status = generate_xdata_with_timeout(pg_ddl, sample_data_path, pred_sql_pg, timeout)
        pred_gen_time = pred_meta["data_gen_time"]
        pred_err_str = pred_meta.get("error_message", "")

        pred_meta_rec = {
            "query_id": pid,
            "query_type": "pred",
            "data_gen_time": pred_gen_time,
            "num_datasets": len(pred_datasets),
            "error_message": pred_err_str if pred_status != "SUCCESS" else ""
        }
        datagen_records.append(pred_meta_rec)

        pred_states[pid]['time_taken'] += pred_gen_time

        if pred_meta.get("error_message"):
            if pred_status == "TIMEOUT" or "Timeout after" in pred_err_str:
                pred_states[pid]["timeout"] = True
                pred_states[pid]["error_message"] = pred_err_str
                pred_states[pid]["raw_tool_status"] = "TIMEOUT"
                if pred_states[pid].get('status') not in ("NEQ", "NEQ_SCO"):
                    pred_states[pid]['execution_result'] = None
                    pred_states[pid]['status'] = "TIMEOUT"
            else:
                pred_states[pid]["error_message"] = pred_err_str
                pred_states[pid]["raw_tool_status"] = pred_status
            continue

        pred_states[pid]["timeout"] = False
        pred_states[pid]["error_message"] = ""
        pred_states[pid]['raw_tool_status'] = pred_status
        pred_states[pid]['num_datasets'] = len(pred_datasets)

        for pds in pred_datasets:
            if not unrefuted_pids:
                break

            pds_sql = pds.get("sql", "")
            pds_name = f"PRED_{pds.get('name', '')}"
            current_queries = [prediction_queries[p] for p in unrefuted_pids]

            with open(os.devnull, 'w') as devnull, contextlib.redirect_stdout(devnull):
                test_results = execution_test_batch(
                    schema=ddl_content,
                    dataset=pds_sql,
                    gold_sql=gold_sql,
                    prediction_sqls=current_queries,
                    dialect=dialect
                )

            still_unrefuted = []
            for i, res in enumerate(test_results):
                p_curr = unrefuted_pids[i]
                status_p = res.get("status", "")

                if not pred_states[p_curr]['execution_result']:
                    pred_states[p_curr]['execution_result'] = res
                    pred_states[p_curr]['status'] = status_p
                    pred_states[p_curr]['raw_tool_status'] = pred_status
                    pred_states[p_curr]['dataset_sql'] = pds_sql
                    pred_states[p_curr]['dataset_name'] = pds_name
                    pred_states[p_curr]['dataset_source'] = "pred"
                    pred_states[p_curr]['num_datasets'] = len(pred_datasets)

                if status_p.startswith("NEQ"):
                    pred_states[p_curr]['status'] = status_p
                    pred_states[p_curr]['raw_tool_status'] = pred_status
                    pred_states[p_curr]['execution_result'] = res
                    pred_states[p_curr]['dataset_sql'] = pds_sql
                    pred_states[p_curr]['dataset_name'] = pds_name
                    pred_states[p_curr]['dataset_source'] = "pred"
                    pred_states[p_curr]['num_datasets'] = len(pred_datasets)
                else:
                    if status_p.startswith("ERROR") and not pred_states[p_curr]['status'].startswith("NEQ"):
                        pred_states[p_curr]['status'] = status_p
                        pred_states[p_curr]['raw_tool_status'] = pred_status
                        pred_states[p_curr]['execution_result'] = res
                        pred_states[p_curr]['dataset_sql'] = pds_sql
                        pred_states[p_curr]['dataset_name'] = pds_name
                        pred_states[p_curr]['dataset_source'] = "pred"
                        pred_states[p_curr]['num_datasets'] = len(pred_datasets)
                    still_unrefuted.append(p_curr)

            unrefuted_pids = still_unrefuted

    return {
        "predictions": pred_states,
        "datagen_records": datagen_records,
        "gold_meta": gold_meta_rec,
        "bridge_status": bridge_status,
        "error_str": gold_error_str
    }

def process_item(item, target_dialect='native', timeout=60, results_dir=None):
    db_id = item.get('schema_id', item.get('database_id'))
    dialect = target_dialect if target_dialect != 'native' else item.get('dialect', 'sqlite')
    exec_dialect = 'postgres' if dialect in ('postgres', 'postgresql') else dialect
    source = item.get('source', '')
    instance_id = str(item.get('id') or item.get('instance_id') or db_id)
    if results_dir is None:
        results_dir = csv_utils.get_results_dir(script_dir, dialect)
    ddl_content = get_ddl(db_id, dialect=exec_dialect)
    predictions = item.get('predictions', [])

    if not ddl_content:
        out = []
        for pred in predictions:
            pred_id = pred.get('prediction_id')
            out.append({
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'SKIPPED_NO_DDL',
                'EXTEST_STATUS': 'SKIPPED_NO_DDL',
                'reproducible_cex': '',
                'time_taken': '0.000',
                'error_message': 'Missing DDL',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0
            })
        return {"eval_results": out, "datagen_records": []}

    sample_data_path = get_sample_data_path(db_id, source)
    if not sample_data_path or not os.path.exists(sample_data_path):
        out = []
        for pred in predictions:
            pred_id = pred.get('prediction_id')
            out.append({
                'instance_id': instance_id,
                'prediction_id': pred_id,
                'raw_tool_status': 'SKIPPED_NO_SAMPLE_DATA',
                'EXTEST_STATUS': 'SKIPPED_NO_SAMPLE_DATA',
                'reproducible_cex': '',
                'time_taken': '0.000',
                'error_message': f'Missing sample data for {db_id}',
                'gold_sql_result': '',
                'prediction_sql_result': '',
                'num_datasets': 0
            })
        return {"eval_results": out, "datagen_records": []}

    # Gold query for execution test
    if exec_dialect == 'postgres':
        gold_sql = item.get('gold_sql_postgresql') or item.get('gold_sql_postgres') or item.get('gold_sql')
    else:
        gold_sql = item.get('gold_sql_sqlite') or item.get('gold_sql')

    # Gold query for XData bridge (always PostgreSQL)
    gold_sql_pg = item.get('gold_sql_postgresql') or item.get('gold_sql_postgres') or item.get('gold_sql')
    if not gold_sql_pg:
        try:
            gold_sql_pg = sqlglot.transpile(item.get('gold_sql_sqlite', item.get('gold_sql', '')), read='sqlite', write='postgres')[0]
        except Exception:
            gold_sql_pg = item.get('gold_sql', '')

    prediction_queries = {}
    prediction_queries_pg = {}
    for pred in predictions:
        pred_id = pred['prediction_id']
        if exec_dialect == 'postgres':
            pred_sql = pred.get('prediction_sql_postgresql') or pred.get('prediction_sql_postgres') or pred.get('prediction_sql', '')
        else:
            pred_sql = pred.get('prediction_sql_sqlite') or pred.get('prediction_sql', '')

        pred_sql_pg = pred.get('prediction_sql_postgresql') or pred.get('prediction_sql_postgres') or pred.get('prediction_sql', '')
        if not pred_sql_pg:
            try:
                pred_sql_pg = sqlglot.transpile(pred.get('prediction_sql_sqlite', pred.get('prediction_sql', '')), read='sqlite', write='postgres')[0]
            except Exception:
                pred_sql_pg = pred.get('prediction_sql', '')

        prediction_queries[pred_id] = pred_sql
        prediction_queries_pg[pred_id] = pred_sql_pg

    raw_pg_ddl = schemas_data_global.get(db_id, {}).get("ddl_postgres") or schemas_data_global.get(db_id, {}).get("ddl_postgresql")
    if raw_pg_ddl:
        pg_ddl = prepare_postgres_ddl(raw_pg_ddl)
    else:
        pg_ddl = prepare_postgres_ddl(ddl_content)

    eval_results = {}
    datagen_records = []
    if prediction_queries:
        try:
            eval_results = xdata_worker(
                pg_ddl=pg_ddl,
                ddl_content=ddl_content,
                sample_data_path=sample_data_path,
                gold_sql_pg=gold_sql_pg,
                gold_sql=gold_sql,
                prediction_queries_pg=prediction_queries_pg,
                prediction_queries=prediction_queries,
                dialect=exec_dialect,
                timeout=timeout,
                instance_id=instance_id
            )
            datagen_records = eval_results.get("datagen_records", [])
            for rec in datagen_records:
                rec["instance_id"] = instance_id
        except Exception:
            import traceback
            err_msg = traceback.format_exc()
            eval_results = {"predictions": {}, "global_error": err_msg}
            datagen_records = [{
                "instance_id": instance_id,
                "query_id": "gold",
                "query_type": "gold",
                "data_gen_time": 0.0,
                "num_datasets": 0,
                "error_message": err_msg
            }]
    else:
        eval_results = {"predictions": {}}

    gold_meta = eval_results.get("gold_meta", {})
    gold_timed_out = bool(
        eval_results.get("bridge_status") == "TIMEOUT"
        or (gold_meta.get("error_message") and "Timeout" in gold_meta["error_message"])
    )

    safe_instance_id = instance_id.replace('/', '_').replace('\\', '_')
    bridge_status = eval_results.get("bridge_status", "SUCCESS")
    error_str = eval_results.get("error_str", "")

    out = []
    for pred in predictions:
        pred_id = pred.get('prediction_id')
        state = eval_results.get("predictions", {}).get(pred_id, {})
        exec_res = state.get('execution_result')

        status_flag = "UNKNOWN"
        cex_str = ""
        gold_sql_result = ""
        prediction_sql_result = ""
        reproducible_cex_path = ""
        num_datasets = state.get('num_datasets', 0)
        time_taken = state.get('time_taken', 0.0)

        is_timed_out = bool(
            state.get("timeout")
            or gold_timed_out
            or bridge_status == "TIMEOUT"
            or state.get("raw_tool_status") == "TIMEOUT"
            or "Timeout" in str(state.get("error_message", ""))
            or "Timeout" in str(gold_meta.get("error_message", ""))
        )

        if state:
            if exec_res:
                status_val = exec_res.get("status", "")
                if status_val in ("EXTEST_ERROR", "ERROR") or str(status_val).startswith("ERROR_"):
                    status_flag = status_val if str(status_val).startswith("ERROR_") else "EXTEST_ERROR"
                    cex_str = exec_res.get("error_message", "Unknown execution error")
                elif status_val in ("NEQ", "NEQ_SCO"):
                    status_flag = status_val
                    cex_str = state.get("dataset_sql", "")
                    gold_sql_result = str(exec_res.get("gold_sql_result", "")).replace('\n', '\\n')
                    prediction_sql_result = str(exec_res.get("prediction_sql_result", "")).replace('\n', '\\n')

                    reproducible_cex_content = exec_res.get("reproducible_cex", "")
                    if reproducible_cex_content:
                        cex_dir = os.path.join(results_dir, 'reproducible_cex', XDATA_TOOL_NAME)
                        os.makedirs(cex_dir, exist_ok=True)
                        rel_path = f"reproducible_cex/{XDATA_TOOL_NAME}/{safe_instance_id}_{pred_id}.sql"
                        with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                            rf.write(reproducible_cex_content)
                        reproducible_cex_path = rel_path
                else:
                    if is_timed_out:
                        status_flag = "TIMEOUT"
                        cex_str = state.get("error_message") or gold_meta.get("error_message") or f"Timeout after {timeout}s"
                    elif state.get("error_message"):
                        status_flag = "TOOL_ERROR"
                        cex_str = state.get("error_message")
                    elif gold_meta.get("error_message"):
                        status_flag = "TOOL_ERROR"
                        cex_str = gold_meta.get("error_message")
                    else:
                        status_flag = status_val
            else:
                if is_timed_out:
                    status_flag = "TIMEOUT"
                    cex_str = state.get("error_message") or gold_meta.get("error_message") or f"Timeout after {timeout}s"
                elif state.get("error_message"):
                    status_flag = "TOOL_ERROR"
                    cex_str = state.get("error_message")
                elif gold_meta.get("error_message"):
                    status_flag = "TOOL_ERROR"
                    cex_str = gold_meta.get("error_message")
                elif bridge_status == "NO_DATASETS" or num_datasets == 0:
                    status_flag = "NO_DATASETS"
                    cex_str = error_str or "No test datasets generated"
                elif bridge_status == "TIMEOUT" or "Timeout" in (error_str or ""):
                    status_flag = "TIMEOUT"
                    cex_str = error_str or f"Timeout after {timeout}s"
                else:
                    status_flag = "TOOL_ERROR"
                    cex_str = error_str or "XData failed to generate test datasets"
        elif "global_error" in eval_results:
            err_msg = eval_results["global_error"]
            if "timeout" in err_msg.lower():
                status_flag = "TIMEOUT"
            else:
                status_flag = "TOOL_ERROR"
            cex_str = err_msg
        else:
            status_flag = "SKIPPED"
            cex_str = "Not evaluated"

        error_msg_val = cex_str if status_flag in ['TOOL_ERROR', 'TIMEOUT', 'ERROR_QUERY_EXECUTION', 'EXTEST_ERROR'] or str(status_flag).startswith('ERROR') else ''
        error_msg_path = ""

        if error_msg_val:
            error_msg_dir = os.path.join(results_dir, 'error_msg', XDATA_TOOL_NAME)
            os.makedirs(error_msg_dir, exist_ok=True)
            rel_path = f"error_msg/{XDATA_TOOL_NAME}/{safe_instance_id}_{pred_id}.txt"
            with open(os.path.join(results_dir, rel_path), "w", encoding="utf-8") as rf:
                rf.write(error_msg_val)
            error_msg_path = rel_path

        raw_tool_status = state.get('raw_tool_status', bridge_status)
        if status_flag in ("NEQ", "NEQ_SCO") and raw_tool_status in ("NO_DATASETS", "TIMEOUT"):
            raw_tool_status = "SUCCESS"
        elif status_flag == "TIMEOUT" or is_timed_out:
            raw_tool_status = "TIMEOUT"
            status_flag = "TIMEOUT"
            num_datasets = 0
            gold_sql_result = ""
            prediction_sql_result = ""
            reproducible_cex_path = ""
        elif status_flag == "NO_DATASETS" or num_datasets == 0:
            raw_tool_status = "NO_DATASETS"

        out.append({
            'instance_id': instance_id,
            'prediction_id': pred_id,
            'raw_tool_status': raw_tool_status,
            'EXTEST_STATUS': status_flag,
            'dataset_source': state.get('dataset_source', ''),
            'reproducible_cex': reproducible_cex_path,
            'time_taken': f"{time_taken:.3f}" if isinstance(time_taken, (int, float)) else str(time_taken),
            'error_message': error_msg_path,
            'gold_sql_result': gold_sql_result,
            'prediction_sql_result': prediction_sql_result,
            'num_datasets': num_datasets
        })

    return {"eval_results": out, "datagen_records": datagen_records}

def main():
    parser = argparse.ArgumentParser(description="Evaluate XData Test Data Generator")
    parser.add_argument('--benchmark', type=str, default='all', help='Benchmark to evaluate (e.g. bird, spider, xdata)')
    parser.add_argument('--resume', action='store_true', help='Resume from last saved item in csv')
    parser.add_argument('--retry', action='store_true', help='Retry evaluation for failed/error cases in existing CSV')
    parser.add_argument('--full', action='store_true', help='Full rerun of all test cases')
    parser.add_argument('--rerun', action='store_true', help='Full rerun of all test cases')
    parser.add_argument('--target-dialect', type=str, default='native', choices=['native', 'sqlite', 'mysql', 'postgresql'], help='Target dialect to use for queries')
    parser.add_argument('--timeout', type=int, default=60, help='Timeout in seconds per data generation call (default: 60)')
    parser.add_argument('--instance-id', type=str, default=None, help='Filter evaluation to a specific instance ID')
    parser.add_argument('--prediction-id', type=str, default=None, help='Filter evaluation to a specific prediction ID')
    parser.add_argument('--input-file', type=str, default=None, help='Input JSON file')
    args = parser.parse_args()

    ensure_xdata_bridge_ready()

    results_dir = csv_utils.get_results_dir(script_dir, args.target_dialect)
    os.makedirs(results_dir, exist_ok=True)

    norm_bench = benchmark_loader.normalize_benchmark_name(args.benchmark)
    if norm_bench != 'all' and norm_bench not in SUPPORTED_BENCHMARKS and args.benchmark not in SUPPORTED_BENCHMARKS:
        print(f"Benchmark '{args.benchmark}' is not supported by XData. Supported benchmarks: {', '.join(sorted(SUPPORTED_BENCHMARKS))}")
        return

    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=norm_bench if norm_bench in SUPPORTED_BENCHMARKS else args.benchmark,
        input_file=args.input_file or os.environ.get('INPUT_FILE'),
        base_dir=script_dir
    )
    global schemas_data_global
    if loaded_schemas:
        schemas_data_global = loaded_schemas

    if isinstance(data, dict):
        data = [data]

    if args.benchmark == 'all':
        data = [d for d in data if (benchmark_loader.normalize_benchmark_name(d.get('source')) in SUPPORTED_BENCHMARKS) or (not d.get('source') and any(b in str(d.get('schema_id', '')).lower() for b in SUPPORTED_BENCHMARKS))]
    elif norm_bench in SUPPORTED_BENCHMARKS:
        data = [d for d in data if benchmark_loader.normalize_benchmark_name(d.get('source')) == norm_bench or d.get('source') == args.benchmark]

    if not data:
        print(f"No queries found to evaluate for benchmark '{args.benchmark}'.")
        return

    unique_sources = set(item.get('source', 'unknown') for item in data)

    fieldnames = ['instance_id', 'prediction_id', 'raw_tool_status', 'EXTEST_STATUS', 'dataset_source', 'reproducible_cex', 'time_taken', 'error_message', 'gold_sql_result', 'prediction_sql_result', 'num_datasets']
    datagen_fieldnames = ['instance_id', 'query_id', 'query_type', 'data_gen_time', 'num_datasets', 'error_message']

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_{src}.csv')
        mode = 'a' if ((args.resume or args.retry) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()

        datagen_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_datagen_{src}.csv')
        mode_dg = 'a' if ((args.resume or args.retry) and os.path.exists(datagen_csv)) else 'w'
        with open(datagen_csv, mode_dg, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=datagen_fieldnames)
            if mode_dg == 'w' or os.path.getsize(datagen_csv) == 0:
                writer.writeheader()

    data, total_predictions = csv_utils.filter_predictions_for_evaluation(
        data=data,
        results_dir=results_dir,
        csv_file_func=lambda src: os.path.join(results_dir, f'{XDATA_TOOL_NAME}_{src}.csv'),
        resume=args.resume,
        retry=args.retry,
        target_instance_id=args.instance_id,
        target_prediction_id=args.prediction_id,
        tool_name=TOOL_LABEL
    )
    print(f"Loaded {len(data)} items to process with {TOOL_LABEL}. Total predictions: {total_predictions}")

    status_counts = Counter()
    last_status = [None]
    with tqdm(total=total_predictions, desc=f"Evaluating Predictions with {TOOL_LABEL}") as pbar:
        for item in data:
            try:
                item_output = process_item(item, args.target_dialect, args.timeout, results_dir=results_dir)
                eval_results = item_output.get("eval_results", [])
                datagen_recs = item_output.get("datagen_records", [])

                src = item.get('source', 'unknown')
                out_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_{src}.csv')
                datagen_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_datagen_{src}.csv')

                for res in eval_results:
                    status_counts[res.get('EXTEST_STATUS', 'UNKNOWN')] += 1

                csv_utils.update_or_append_results(out_csv, fieldnames, eval_results)
                if datagen_recs:
                    csv_utils.update_or_append_results(datagen_csv, datagen_fieldnames, datagen_recs)
                csv_utils.print_status_update(pbar, status_counts, last_status)
                pbar.set_postfix_str(csv_utils.format_status_counts(status_counts))
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Saving partial results...")
                break
            except Exception as e:
                pbar.write(f"Error processing item: {e}")

            pbar.update(len(item.get('predictions', [])))

    print(f"Done. Results saved in {results_dir}")

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_{src}.csv')
        datagen_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_datagen_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        csv_utils.deduplicate_datagen_csv(datagen_csv, datagen_fieldnames)

    for src in unique_sources:
        print(f"\n--- Status Statistics for {src} ---")
        try:
            out_csv = os.path.join(results_dir, f'{XDATA_TOOL_NAME}_{src}.csv')
            with open(out_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                rows = list(reader)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in rows)
                killed_ds_counts = Counter(
                    row.get('dataset_source', '') 
                    for row in rows 
                    if row.get('EXTEST_STATUS', '').startswith('NEQ') and row.get('dataset_source')
                )
                print(f"Killed by Gold Datasets: {killed_ds_counts.get('gold', 0)}")
                print(f"Killed by Pred Datasets (TW): {killed_ds_counts.get('pred', 0)}")

            err_counts = csv_utils.get_error_histogram(out_csv, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics: {e}")

if __name__ == '__main__':
    main()
