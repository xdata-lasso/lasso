#!/usr/bin/env python3
"""
Build Benchmark Suites for Non-Empty Data Generation Experiments.

Extracts schemas and queries across repositories and stores each benchmark in:
  benchmarks/<dialect>/<benchmark_name>/
    ├── DDL.sql       (Clean, valid schema definition in target dialect)
    └── queries.txt   (Transpiled & execution-verified queries)

Supported dialects:
  - sqlite
  - postgres
  - mysql

Verification:
  - SQLite: verified via EXPLAIN and execution in an in-memory SQLite database.
  - PostgreSQL: verified via EXPLAIN on PostgreSQL instance (with sqlglot AST fallback).
  - MySQL: verified via EXPLAIN on MySQL instance (with sqlglot AST fallback).

Generates stats in:
  benchmarks/stats/
    ├── summary.json  (Consolidated machine-readable statistics)
    ├── summary.md    (Consolidated human-readable markdown table)
    ├── stats.txt     (Text summary)
    └── <bench>.json  (Detailed per-benchmark verification report)

Supported benchmarks:
  - beaver         : BeaverBench DW schema (default dialect: MySQL)
  - beaver_nova    : BeaverBench Nova schema (default dialect: MySQL)
  - beaver_neutron : BeaverBench Neutron schema (default dialect: MySQL)
  - tpch           : TPC-H standard queries (default dialect: PostgreSQL)
  - xdata_bm       : XData benchmark queries (default dialect: PostgreSQL)
  - largejoin      : Large multi-table join benchmark (default dialect: PostgreSQL)
  - many_rows_bm   : High-cardinality queries requiring many rows (default dialect: SQLite)

Usage:
  python3 build_benchmarks.py [--benchmark <name|all>] [--hf-token <token>] [--out-dir <dir>]
"""

import os
import sys
import glob
import re
import json
import time
import sqlite3
import argparse
import subprocess
from typing import List, Tuple, Dict, Optional, Any

import sqlglot

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(EXPERIMENTS_DIR, ".."))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "benchmarks")

DEFAULT_HF_TOKEN = "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"


def clean_query_to_single_line(sql_str: str) -> str:
    """Strips comments and normalizes multi-line query into a single line."""
    if not sql_str:
        return ""
    lines = []
    for line in sql_str.splitlines():
        line_clean = line.strip()
        if line_clean.startswith("--"):
            continue
        lines.append(line)
    single_line = " ".join(" ".join(lines).split())
    return single_line.rstrip(";").strip()


def get_original_path(rel_path: str) -> str:
    cand = os.path.join(EXPERIMENTS_DIR, "originals", rel_path)
    if os.path.exists(cand):
        return cand
    return os.path.join(EXPERIMENTS_DIR, rel_path)


def parquet_to_base_ddl(parquet_path: str) -> str:
    """Converts a beaver-table parquet file into clean base DDL."""
    try:
        import pandas as pd
    except ImportError:
        return ""

    df = pd.read_parquet(parquet_path)
    ddl_stmts = []
    for _, row in df.iterrows():
        tname = str(row["table_name"]).strip()
        cols = json.loads(row["column_names"])
        types = json.loads(row["column_types"])
        col_defs = []
        for c, t in zip(cols, types):
            t_clean = re.sub(r'(?i)ENUM\s*\(.*?\)', 'TEXT', str(t))
            t_clean = re.sub(r'(?i)SET\s*\(.*?\)', 'TEXT', t_clean)
            t_clean = t_clean.upper().replace('VARCHAR2', 'VARCHAR').replace('TINYINT(1)', 'INTEGER')
            col_defs.append(f'"{c.strip()}" {t_clean}')
        ddl = f'CREATE TABLE "{tname}" (\n  ' + ',\n  '.join(col_defs) + '\n);'
        ddl_stmts.append(ddl)

    return "\n\n".join(ddl_stmts)


def transpile_ddl(base_ddl: str, src_dialect: str, target_dialect: str) -> str:
    """Transpiles DDL between dialects with clean syntax adjustments."""
    if not base_ddl or not base_ddl.strip():
        return ""

    # Fix any SQLite-style single-quoted column names: 'col_name' TYPE -> "col_name" TYPE
    fixed_ddl = re.sub(r"'([a-zA-Z0-9_]+)'\s+([a-zA-Z])", r'"\1" \2', base_ddl)

    try:
        stmts = sqlglot.transpile(fixed_ddl, read="sqlite", write=target_dialect)
    except Exception:
        try:
            stmts = sqlglot.transpile(fixed_ddl, read=src_dialect, write=target_dialect)
        except Exception:
            try:
                stmts = sqlglot.transpile(fixed_ddl, read=None, write=target_dialect)
            except Exception:
                stmts = [s.strip() for s in fixed_ddl.split(";") if s.strip()]

    if target_dialect == "mysql":
        cleaned = ["SET FOREIGN_KEY_CHECKS=0"]
        for s in stmts:
            s_clean = s.strip()
            if s_clean and not s_clean.upper().startswith("SET FOREIGN_KEY_CHECKS"):
                cleaned.append(s_clean.replace('"', '`'))
        res = ";\n\n".join(cleaned)
        if not res.strip().endswith(";"):
            res += ";"
        return res

    elif target_dialect == "sqlite":
        cleaned = []
        for s in stmts:
            s_clean = s.strip()
            if not s_clean:
                continue
            s_clean = re.sub(r'(?i)\bserial\b', 'INTEGER PRIMARY KEY', s_clean)
            s_clean = re.sub(r'(?i)\bcharacter\s+varying\b', 'VARCHAR', s_clean)
            s_clean = re.sub(r'(?i)\bENGINE\s*=\s*\w+', '', s_clean)
            s_clean = re.sub(r'(?i)\bDEFAULT\s+CHARSET\s*=\s*\w+', '', s_clean)
            s_clean = re.sub(r'(?i)\bAUTO_INCREMENT\b', '', s_clean)
            cleaned.append(s_clean)
        res = ";\n\n".join(cleaned)
        if not res.strip().endswith(";"):
            res += ";"
        return res

    elif target_dialect == "postgres":
        cleaned = []
        for s in stmts:
            s_clean = s.strip()
            if not s_clean:
                continue
            s_clean = re.sub(r'(?i)\bENGINE\s*=\s*\w+', '', s_clean)
            s_clean = re.sub(r'(?i)\bDEFAULT\s+CHARSET\s*=\s*\w+', '', s_clean)
            cleaned.append(s_clean)
        res = ";\n\n".join(cleaned)
        if not res.strip().endswith(";"):
            res += ";"
        return res

    return ";\n\n".join(stmts)


def transpile_query(q_raw: str, src_dialect: str, target_dialect: str) -> Optional[str]:
    """Transpiles query to target dialect with robust fallbacks."""
    if not q_raw or not q_raw.strip():
        return None
    cleaned = clean_query_to_single_line(q_raw)
    if not cleaned:
        return None

    # Try transpiling from src_dialect, then common alternates
    read_dialects = [src_dialect]
    for alt in ["sqlite", "mysql", "postgres", None]:
        if alt not in read_dialects:
            read_dialects.append(alt)

    for rd in read_dialects:
        try:
            transpiled = sqlglot.transpile(cleaned, read=rd, write=target_dialect)[0]
            t_clean = clean_query_to_single_line(transpiled)
            if t_clean:
                return t_clean
        except Exception:
            continue

    return cleaned


class ValidationEngines:
    """Manages active database connections to SQLite, PostgreSQL, and MySQL for EXPLAIN verification."""

    def __init__(self):
        self.sqlite_conn: Optional[sqlite3.Connection] = None
        self.sqlite_cur: Optional[sqlite3.Cursor] = None

        self.pg_conn = None
        self.pg_cur = None
        self._init_postgres()

        self.my_conn = None
        self.my_cur = None
        self._init_mysql()

    def _init_postgres(self):
        try:
            import psycopg2
            for port in [54320, 5432]:
                try:
                    c = psycopg2.connect(
                        host="127.0.0.1", port=port, user="postgres",
                        password="postgres", dbname="postgres", connect_timeout=1
                    )
                    c.autocommit = True
                    self.pg_conn = c
                    self.pg_cur = c.cursor()
                    return
                except Exception:
                    pass
        except ImportError:
            pass

    def _init_mysql(self):
        try:
            import pymysql
            for port in [33061, 33060, 3306]:
                try:
                    c = pymysql.connect(
                        host="127.0.0.1", port=port, user="root",
                        password="test", connect_timeout=1
                    )
                    c.autocommit(True)
                    self.my_conn = c
                    self.my_cur = c.cursor()
                    return
                except Exception:
                    pass
        except ImportError:
            pass

    def setup_sqlite(self, schema_ddl: str) -> bool:
        if self.sqlite_conn:
            try:
                self.sqlite_conn.close()
            except Exception:
                pass
        self.sqlite_conn = sqlite3.connect(":memory:")
        self.sqlite_cur = self.sqlite_conn.cursor()
        try:
            self.sqlite_cur.executescript(schema_ddl)
            return True
        except Exception:
            return False

    def setup_postgres(self, schema_ddl: str, bench_name: str) -> bool:
        if not self.pg_cur:
            return False
        schema_name = f"val_{bench_name.replace('-', '_')}"
        try:
            self.pg_cur.execute(f"DROP SCHEMA IF EXISTS {schema_name} CASCADE;")
            self.pg_cur.execute(f"CREATE SCHEMA {schema_name};")
            self.pg_cur.execute(f"SET search_path TO {schema_name};")

            # Multi-pass creation so parent tables can be created before child tables
            pending = [s.strip() for s in schema_ddl.lower().split(";") if s.strip()]
            for _ in range(5):
                still_pending = []
                for s in pending:
                    try:
                        self.pg_cur.execute(s)
                    except Exception:
                        still_pending.append(s)
                if len(still_pending) == len(pending):
                    break
                pending = still_pending
                if not pending:
                    break
            return True
        except Exception:
            return False

    def setup_mysql(self, schema_ddl: str, bench_name: str) -> bool:
        if not self.my_cur:
            return False
        db_name = f"val_{bench_name.replace('-', '_')}"
        try:
            self.my_cur.execute(f"DROP DATABASE IF EXISTS `{db_name}`;")
            self.my_cur.execute(f"CREATE DATABASE `{db_name}`;")
            self.my_cur.execute(f"USE `{db_name}`;")
            self.my_cur.execute("SET FOREIGN_KEY_CHECKS=0;")
            ddl_fixed = re.sub(r"'([a-zA-Z0-9_]+)'\s+([a-zA-Z])", r'`\1` \2', schema_ddl)
            for stmt in ddl_fixed.split(";"):
                s = stmt.strip()
                if s and not s.upper().startswith("SET FOREIGN_KEY_CHECKS"):
                    s_m = s.replace('"', '`')
                    try:
                        self.my_cur.execute(s_m)
                    except Exception:
                        pass
            return True
        except Exception:
            return False

    def verify_sqlite(self, q_sqlite: str) -> bool:
        if not self.sqlite_cur or not q_sqlite:
            return False
        try:
            self.sqlite_cur.execute(f"EXPLAIN {q_sqlite}")
            self.sqlite_cur.execute(q_sqlite)
            return True
        except Exception:
            return False

    def verify_postgres(self, q_pg: str) -> bool:
        if not q_pg:
            return False
        if not self.pg_cur:
            try:
                sqlglot.parse_one(q_pg, read="postgres")
                return True
            except Exception:
                return False
        try:
            self.pg_cur.execute(f"EXPLAIN {q_pg}")
            return True
        except Exception:
            return False

    def verify_mysql(self, q_my: str) -> bool:
        if not q_my:
            return False
        if not self.my_cur:
            try:
                sqlglot.parse_one(q_my, read="mysql")
                return True
            except Exception:
                return False
        try:
            self.my_cur.execute(f"EXPLAIN {q_my}")
            return True
        except Exception:
            return False


def ensure_beaver_repo_cloned(hf_token: str) -> str:
    """Clones or locates the beaver-table repository."""
    beaver_data_dir = get_original_path(os.path.join("beaver_data", "beaver-table"))
    if os.path.exists(os.path.join(beaver_data_dir, "data")):
        p_check = os.path.join(beaver_data_dir, "data", "dw-00000-of-00001.parquet")
        if os.path.exists(p_check) and os.path.getsize(p_check) < 1000:
            subprocess.run(["git", "lfs", "pull", "-I", "data/*.parquet"], cwd=beaver_data_dir, check=False)
        return beaver_data_dir

    os.makedirs(os.path.dirname(beaver_data_dir), exist_ok=True)
    clone_url = f"https://oauth2:{hf_token}@huggingface.co/datasets/beaverbench/beaver-table"
    print(f"Cloning beaver-table into {beaver_data_dir}...")
    env = os.environ.copy()
    env["GIT_LFS_SKIP_SMUDGE"] = "1"
    subprocess.run(["git", "clone", clone_url, beaver_data_dir], env=env, check=True)
    subprocess.run(["git", "lfs", "pull", "-I", "data/*.parquet"], cwd=beaver_data_dir, check=False)
    return beaver_data_dir


def load_beaver_query_dataset(hf_token: str):
    """Loads beaverbench/beaver-query dataset."""
    from datasets import load_dataset
    try:
        return load_dataset("beaverbench/beaver-query", token=hf_token)
    except Exception:
        return load_dataset("beaverbench/beaver-query")


def extract_raw_beaver_suite(bench_variant: str, beaver_table_dir: str, ds) -> Tuple[str, List[str], str]:
    """Returns (base_ddl, raw_queries, source_dialect) for Beaver variants."""
    base_name = "dw" if bench_variant in ["beaver", "beaver_dw", "beaver_real"] else bench_variant.replace("beaver_", "")
    parquet_path = os.path.join(beaver_table_dir, "data", f"{base_name}-00000-of-00001.parquet")

    schema_ddl = ""
    if os.path.exists(parquet_path):
        schema_ddl = parquet_to_base_ddl(parquet_path)
    elif base_name == "dw" and os.path.exists(get_original_path(os.path.join("beaver_tests", "schema.sql"))):
        with open(get_original_path(os.path.join("beaver_tests", "schema.sql")), "r", encoding="utf-8") as f:
            schema_ddl = f.read().strip()

    if not schema_ddl:
        raise RuntimeError(f"Could not construct DDL for {bench_variant}")

    split_key = "dw"
    if bench_variant == "beaver_nova":
        split_key = "nova"
    elif bench_variant == "beaver_neutron":
        split_key = "neutron"
    elif bench_variant == "beaver_real":
        split_key = "dw_real"

    raw_items = list(ds[split_key]) if ds and split_key in ds else []

    queries = []
    seen = set()

    # Seeds from top10_queries.json for dw
    if base_name == "dw":
        top10_file = get_original_path(os.path.join("beaver_tests", "top10_queries.json"))
        if os.path.exists(top10_file):
            try:
                with open(top10_file, "r", encoding="utf-8") as f:
                    top10_data = json.load(f)
                for item in top10_data:
                    q_c = clean_query_to_single_line(item.get("sql", ""))
                    if q_c and q_c not in seen:
                        seen.add(q_c)
                        queries.append(q_c)
            except Exception:
                pass

    for item in raw_items:
        q_raw = item.get("sql", "") if isinstance(item, dict) else ""
        q_c = clean_query_to_single_line(q_raw)
        if q_c and q_c not in seen:
            seen.add(q_c)
            queries.append(q_c)

    return schema_ddl, queries, "mysql"


def extract_raw_tpch_suite() -> Tuple[str, List[str], str]:
    """Returns (base_ddl, raw_queries, source_dialect) for TPC-H."""
    schema_file = get_original_path(os.path.join("tpch_tests", "schema.sql"))
    with open(schema_file, "r", encoding="utf-8") as f:
        schema_ddl = f.read().strip()

    queries_dir = get_original_path(os.path.join("tpch_tests", "queries"))
    sql_files = sorted(
        glob.glob(os.path.join(queries_dir, "q*.sql")),
        key=lambda p: int(re.search(r'\d+', os.path.basename(p)).group()) if re.search(r'\d+', os.path.basename(p)) else 0
    )

    queries = []
    for sf in sql_files:
        with open(sf, "r", encoding="utf-8") as f:
            q_c = clean_query_to_single_line(f.read())
            if q_c:
                queries.append(q_c)

    return schema_ddl, queries, "postgres"


def extract_raw_xdata_bm_suite() -> Tuple[str, List[str], str]:
    """Returns (base_ddl, raw_queries, source_dialect) for XData-BM."""
    xdata_dir = get_original_path(os.path.join("xdatapublic", "benchmarks", "XData-BM"))
    ddl_file = os.path.join(xdata_dir, "DDL.sql")
    queries_file = os.path.join(xdata_dir, "queries.txt")

    with open(ddl_file, "r", encoding="utf-8") as f:
        schema_ddl = f.read().strip()

    queries = []
    with open(queries_file, "r", encoding="utf-8") as f:
        for line in f:
            line_s = line.strip()
            if not line_s or line_s.startswith("--") or line_s.startswith("="):
                continue
            parts = line_s.split("|", 2)
            if len(parts) == 3:
                q_c = clean_query_to_single_line(parts[2])
                if q_c:
                    queries.append(q_c)

    return schema_ddl, queries, "postgres"


def extract_raw_largejoin_suite() -> Tuple[str, List[str], str]:
    """Returns (base_ddl, raw_queries, source_dialect) for LargeJoin."""
    lj_dir = get_original_path(os.path.join("xdatapublic", "benchmarks", "LargeJoin"))
    ddl_file = os.path.join(lj_dir, "DDL.sql")
    queries_file = os.path.join(lj_dir, "queries.txt")

    with open(ddl_file, "r", encoding="utf-8") as f:
        schema_ddl = f.read().strip()

    queries = []
    with open(queries_file, "r", encoding="utf-8") as f:
        for line in f:
            line_s = line.strip()
            if not line_s or line_s.startswith("--") or line_s.startswith("="):
                continue
            parts = line_s.split("|", 2)
            if len(parts) == 3:
                q_c = clean_query_to_single_line(parts[2])
                if q_c:
                    queries.append(q_c)

    return schema_ddl, queries, "postgres"


def extract_raw_many_rows_bm_suite() -> Tuple[str, List[str], str]:
    """Returns (base_ddl, raw_queries, source_dialect) for ManyRowsBM."""
    bench_dir = get_original_path("ManyRowsBM")
    if not os.path.exists(bench_dir):
        bench_dir = get_original_path("many_rows_bm")

    schema_file = os.path.join(bench_dir, "schema.sql")
    if not os.path.exists(schema_file):
        schema_file = os.path.join(bench_dir, "DDL.sql")

    with open(schema_file, "r", encoding="utf-8") as f:
        schema_ddl = f.read().strip()

    queries = []
    json_file = os.path.join(bench_dir, "queries.json")
    txt_file = os.path.join(bench_dir, "queries.txt")

    if os.path.exists(json_file):
        with open(json_file, "r", encoding="utf-8") as f:
            data = json.load(f)
        for item in data:
            if isinstance(item, dict) and "sql" in item:
                q_c = clean_query_to_single_line(item["sql"])
                if q_c:
                    queries.append(q_c)
    elif os.path.exists(txt_file):
        with open(txt_file, "r", encoding="utf-8") as f:
            for line in f:
                line_s = line.strip()
                if not line_s or line_s.startswith("--"):
                    continue
                if "|" in line_s and not line_s.upper().startswith("SELECT") and not line_s.upper().startswith("WITH"):
                    parts = line_s.split("|", 1)
                    q_c = clean_query_to_single_line(parts[1])
                else:
                    q_c = clean_query_to_single_line(line_s)
                if q_c:
                    queries.append(q_c)

    return schema_ddl, queries, "sqlite"


def write_benchmark_dialect(bench_name: str, dialect: str, ddl_sql: str, queries: List[str], out_base_dir: str):
    """Writes DDL.sql and queries.txt under benchmarks/<dialect>/<benchmark_name>/."""
    target_dir = os.path.join(out_base_dir, dialect, bench_name)
    os.makedirs(target_dir, exist_ok=True)

    with open(os.path.join(target_dir, "DDL.sql"), "w", encoding="utf-8") as f:
        f.write(ddl_sql.strip() + "\n")

    with open(os.path.join(target_dir, "queries.txt"), "w", encoding="utf-8") as f:
        for q in queries:
            f.write(q.strip() + "\n")

    # Also copy queries.json if present in original directory
    orig_candidates = [
        get_original_path(os.path.join("ManyRowsBM", "queries.json")),
        get_original_path(os.path.join(bench_name, "queries.json")),
    ]
    for orig_json in orig_candidates:
        if os.path.exists(orig_json):
            import shutil
            shutil.copy2(orig_json, os.path.join(target_dir, "queries.json"))
            break

    # Also mirror SQLite benchmark files at benchmarks/<benchmark_name>/ for backwards compatibility
    if dialect == "sqlite":
        compat_dir = os.path.join(out_base_dir, bench_name)
        os.makedirs(compat_dir, exist_ok=True)
        with open(os.path.join(compat_dir, "DDL.sql"), "w", encoding="utf-8") as f:
            f.write(ddl_sql.strip() + "\n")
        with open(os.path.join(compat_dir, "queries.txt"), "w", encoding="utf-8") as f:
            for q in queries:
                f.write(q.strip() + "\n")
        for orig_json in orig_candidates:
            if os.path.exists(orig_json):
                import shutil
                shutil.copy2(orig_json, os.path.join(compat_dir, "queries.json"))
                break


def build_benchmark_for_all_dialects(
    bench_name: str,
    base_ddl: str,
    raw_queries: List[str],
    src_dialect: str,
    engines: ValidationEngines,
    out_dir: str
) -> Dict[str, Any]:
    """Transpiles DDL and queries across SQLite, MySQL, and PostgreSQL, verifying compatibility."""
    print(f"\n==================================================================")
    print(f"Building benchmark: {bench_name} (Source dialect: {src_dialect})")
    print(f"Total raw queries: {len(raw_queries)}")
    print(f"==================================================================")

    # 1. Transpile DDL
    sqlite_ddl = transpile_ddl(base_ddl, src_dialect, "sqlite")
    mysql_ddl = transpile_ddl(base_ddl, src_dialect, "mysql")
    pg_ddl = transpile_ddl(base_ddl, src_dialect, "postgres")

    # 2. Setup engines
    engines.setup_sqlite(sqlite_ddl)
    engines.setup_mysql(mysql_ddl, bench_name)
    engines.setup_postgres(pg_ddl, bench_name)

    verified_sqlite: List[str] = []
    verified_mysql: List[str] = []
    verified_postgres: List[str] = []

    seen_sqlite = set()
    seen_mysql = set()
    seen_postgres = set()

    t0 = time.time()
    for idx, q_raw in enumerate(raw_queries):
        if (idx + 1) % 500 == 0 or (idx + 1) == len(raw_queries):
            print(f"  Processed {idx + 1}/{len(raw_queries)} queries (SQLite: {len(verified_sqlite)}, MySQL: {len(verified_mysql)}, Postgres: {len(verified_postgres)})...", flush=True)

        # A. SQLite
        q_sq = transpile_query(q_raw, src_dialect, "sqlite")
        if q_sq and q_sq not in seen_sqlite and engines.verify_sqlite(q_sq):
            seen_sqlite.add(q_sq)
            verified_sqlite.append(q_sq)

        # B. MySQL
        q_my = transpile_query(q_raw, src_dialect, "mysql")
        if q_my and q_my not in seen_mysql and engines.verify_mysql(q_my):
            seen_mysql.add(q_my)
            verified_mysql.append(q_my)

        # C. PostgreSQL
        q_pg = transpile_query(q_raw, src_dialect, "postgres")
        if q_pg and q_pg not in seen_postgres and engines.verify_postgres(q_pg):
            seen_postgres.add(q_pg)
            verified_postgres.append(q_pg)

    elapsed = time.time() - t0
    total = len(raw_queries)

    # 3. Write files
    write_benchmark_dialect(bench_name, "sqlite", sqlite_ddl, verified_sqlite, out_dir)
    write_benchmark_dialect(bench_name, "mysql", mysql_ddl, verified_mysql, out_dir)
    write_benchmark_dialect(bench_name, "postgres", pg_ddl, verified_postgres, out_dir)

    stats = {
        "benchmark": bench_name,
        "source_dialect": src_dialect,
        "total_queries": total,
        "elapsed_seconds": round(elapsed, 2),
        "sqlite": {
            "compatible": len(verified_sqlite),
            "percentage": round((len(verified_sqlite) / total * 100) if total else 0.0, 1),
            "verified_via": "EXPLAIN + execution (in-memory)"
        },
        "mysql": {
            "compatible": len(verified_mysql),
            "percentage": round((len(verified_mysql) / total * 100) if total else 0.0, 1),
            "verified_via": "EXPLAIN (live server)" if engines.my_cur else "AST syntax validation"
        },
        "postgres": {
            "compatible": len(verified_postgres),
            "percentage": round((len(verified_postgres) / total * 100) if total else 0.0, 1),
            "verified_via": "EXPLAIN (live server)" if engines.pg_cur else "AST syntax validation"
        }
    }

    # Save per-benchmark stats
    stats_dir = os.path.join(out_dir, "stats")
    os.makedirs(stats_dir, exist_ok=True)
    with open(os.path.join(stats_dir, f"{bench_name}.json"), "w", encoding="utf-8") as f:
        json.dump(stats, f, indent=2)

    return stats


def generate_consolidated_stats(all_stats: List[Dict[str, Any]], stats_dir: str):
    """Generates summary.json, summary.md, and stats.txt in benchmarks/stats/."""
    os.makedirs(stats_dir, exist_ok=True)

    summary = {
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "benchmarks_count": len(all_stats),
        "benchmarks": all_stats
    }

    # 1. summary.json
    with open(os.path.join(stats_dir, "summary.json"), "w", encoding="utf-8") as f:
        json.dump(summary, f, indent=2)

    # 2. Markdown summary table
    md_lines = [
        "# Benchmark Dialect Compatibility & Transpilation Stats",
        "",
        "| Benchmark | Source Dialect | Total Queries | SQLite-Compatible | MySQL-Compatible | PostgreSQL-Compatible | Verification Time (s) |",
        "| :--- | :---: | :---: | :---: | :---: | :---: | :---: |"
    ]

    for s in all_stats:
        b = s["benchmark"]
        src = s["source_dialect"]
        tot = s["total_queries"]
        sq = f"{s['sqlite']['compatible']} ({s['sqlite']['percentage']}%)"
        my = f"{s['mysql']['compatible']} ({s['mysql']['percentage']}%)"
        pg = f"{s['postgres']['compatible']} ({s['postgres']['percentage']}%)"
        el = s["elapsed_seconds"]
        md_lines.append(f"| **{b}** | `{src}` | {tot} | {sq} | {my} | {pg} | {el}s |")

    md_lines.append("")
    md_lines.append("> All SQLite queries are validated via `EXPLAIN` and execution against in-memory schemas.")
    md_lines.append("> PostgreSQL and MySQL queries are validated via engine `EXPLAIN` planning with AST transpilation fallbacks.")

    with open(os.path.join(stats_dir, "summary.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(md_lines) + "\n")

    # 3. Plaintext stats.txt
    txt_lines = [
        "==========================================================================================",
        "BENCHMARK DIALECT COMPATIBILITY & TRANSPILATION SUMMARY",
        "==========================================================================================",
        f"{'Benchmark':<18} {'Source':<10} {'Total':<8} {'SQLite':<18} {'MySQL':<18} {'Postgres':<18} {'Time'}",
        "------------------------------------------------------------------------------------------"
    ]
    for s in all_stats:
        b = s["benchmark"]
        src = s["source_dialect"]
        tot = s["total_queries"]
        sq = f"{s['sqlite']['compatible']} ({s['sqlite']['percentage']}%)"
        my = f"{s['mysql']['compatible']} ({s['mysql']['percentage']}%)"
        pg = f"{s['postgres']['compatible']} ({s['postgres']['percentage']}%)"
        el = f"{s['elapsed_seconds']}s"
        txt_lines.append(f"{b:<18} {src:<10} {tot:<8} {sq:<18} {my:<18} {pg:<18} {el}")
    txt_lines.append("==========================================================================================")

    with open(os.path.join(stats_dir, "stats.txt"), "w", encoding="utf-8") as f:
        f.write("\n".join(txt_lines) + "\n")

    print("\n" + "\n".join(txt_lines))
    print(f"\nStats report saved in: {stats_dir}")


def main():
    parser = argparse.ArgumentParser(description="Extract & Transpile Verified Queries across Dialects (No Limits)")
    parser.add_argument("--benchmark", type=str, default="all",
                        help="Benchmark to extract (beaver, beaver_nova, beaver_neutron, tpch, xdata_bm, largejoin, or all)")
    parser.add_argument("--hf-token", type=str, default=DEFAULT_HF_TOKEN,
                        help="HuggingFace access token")
    parser.add_argument("--out-dir", type=str, default=BENCHMARKS_DIR,
                        help="Target benchmarks directory")
    args = parser.parse_args()

    # Clean up obsolete .json benchmark files in out_dir root
    for old_json in glob.glob(os.path.join(args.out_dir, "*.json")):
        try:
            os.remove(old_json)
        except Exception:
            pass

    available_benches = [
        "beaver",
        "beaver_nova",
        "beaver_neutron",
        "tpch",
        "xdata_bm",
        "largejoin",
        "many_rows_bm"
    ]

    raw_input = args.benchmark.lower().strip()
    if raw_input in ["many_rows_bm", "manyrowsbm"]:
        selected = ["many_rows_bm"]
    elif raw_input == "all":
        selected = available_benches
    else:
        selected = [raw_input]

    print("==================================================================")
    print("Multi-Dialect Benchmark Builder & Transpiler (ALL Queries, No Limits)")
    print(f"Target Benchmarks: {', '.join(selected)}")
    print(f"Output Directory : {args.out_dir}")
    print("==================================================================")

    engines = ValidationEngines()
    print(f"PostgreSQL engine: {'CONNECTED (port ' + str(engines.pg_conn.get_dsn_parameters().get('port')) + ')' if engines.pg_conn else 'Offline (fallback to AST parsing)'}")
    print(f"MySQL engine     : {'CONNECTED (port ' + str(engines.my_conn.port) + ')' if engines.my_conn else 'Offline (fallback to AST parsing)'}")

    # Prepare Beaver resources if needed
    beaver_table_dir = None
    ds_beaver = None
    if any(b.startswith("beaver") for b in selected):
        print("\nEnsuring BeaverBench tables and queries are ready...")
        beaver_table_dir = ensure_beaver_repo_cloned(args.hf_token)
        ds_beaver = load_beaver_query_dataset(args.hf_token)

    all_stats = []

    for b_name in selected:
        try:
            if b_name.startswith("beaver"):
                ddl, queries, src_dialect = extract_raw_beaver_suite(b_name, beaver_table_dir, ds_beaver)
            elif b_name == "tpch":
                ddl, queries, src_dialect = extract_raw_tpch_suite()
            elif b_name == "xdata_bm":
                ddl, queries, src_dialect = extract_raw_xdata_bm_suite()
            elif b_name == "largejoin":
                ddl, queries, src_dialect = extract_raw_largejoin_suite()
            elif b_name in ["many_rows_bm", "manyrowsbm"]:
                ddl, queries, src_dialect = extract_raw_many_rows_bm_suite()
                b_name = "many_rows_bm"
            else:
                print(f"Unknown benchmark: {b_name}. Skipping.")
                continue

            stat = build_benchmark_for_all_dialects(b_name, ddl, queries, src_dialect, engines, args.out_dir)
            all_stats.append(stat)

        except Exception as e:
            print(f"[ERROR] Failed building {b_name}: {e}")
            import traceback
            traceback.print_exc()

    # Generate consolidated stats (including previously built benchmarks in stats_dir)
    stats_dir = os.path.join(args.out_dir, "stats")
    consolidated_map = {}
    for b in available_benches:
        p = os.path.join(stats_dir, f"{b}.json")
        if os.path.exists(p):
            try:
                with open(p, "r", encoding="utf-8") as f:
                    consolidated_map[b] = json.load(f)
            except Exception:
                pass
    for st in all_stats:
        consolidated_map[st["benchmark"]] = st
    ordered_stats = [consolidated_map[b] for b in available_benches if b in consolidated_map]
    generate_consolidated_stats(ordered_stats, stats_dir)


if __name__ == "__main__":
    main()
