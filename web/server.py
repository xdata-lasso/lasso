#!/usr/bin/env python3
"""
LASSO Research Project & Evaluation Web Server
==============================================
Serves:
  - `/` or `/index.html`                  -> Research Project Home Page with Interactive Try-Out (`web/pages/index.html`)
  - `/results` (or `/analysis`)           -> Evaluation Results & Analysis (`web/pages/results.html`)
  - `/static/*`                           -> Static CSS, JS, fonts, and vendor libraries (`web/static/*`)
  - `POST /api/try_lasso`                 -> Interactive Test Data Generation & Equivalence Refutation API
  - `GET  /api/summary`                   -> Evaluation tables, strategy breakdown, token stats, and benchmark totals
  - `GET  /api/lasso_exclusive`           -> Queries where ONLY LASSO proved NEQ and other tools failed
  - `GET  /api/query_detail`              -> Structured counterexample tables, results, queries, and full `.sql` file
  - `GET  /results/*`                     -> Direct access to `.sql` counterexamples and `.csv` files
"""

import contextlib
import csv
import glob
import html
import http.server
import json
import mimetypes
import os
import re
import socketserver
import sqlite3
import sys
import threading
import time
from collections import Counter, defaultdict, deque
from urllib.parse import parse_qs, unquote, urlparse

WEB_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_DIR = os.path.abspath(os.path.join(WEB_DIR, ".."))
EXPERIMENTS_DIR = os.path.abspath(
    os.environ.get("EXPERIMENTS_DIR", os.path.join(REPO_DIR, "experiments"))
)
RESULTS_DIR = os.path.join(EXPERIMENTS_DIR, "results")
PORT = int(os.environ.get("PORT", "8000"))

# Ensure LASSO src, sql-execution-tester, and local venv site-packages are importable
_venv_site_pkgs = sorted(
    glob.glob(os.path.join(REPO_DIR, "venv", "lib", "python3*", "site-packages"))
    + glob.glob(os.path.join(REPO_DIR, ".venv", "lib", "python3*", "site-packages"))
)
for extra_path in [
    os.path.join(REPO_DIR, "src"),
    os.path.join(REPO_DIR, "sql-execution-tester"),
    *_venv_site_pkgs,
]:
    if os.path.isdir(extra_path) and extra_path not in sys.path:
        sys.path.insert(0, extra_path)

try:
    import sqlglot
except ImportError:
    sqlglot = None

try:
    from main import generate_test_data
    from execution_tester import execution_test
    from query_normalizer import normalize_sql
except Exception:
    generate_test_data = None
    execution_test = None
    normalize_sql = None

BENCHMARKS = [
    "bird", "cubes", "leetcode", "literature", "calcite",
    "xdata", "tpch", "largejoin", "lasso-bm", "mm-bm", "mmo-bm", "mmro-bm"
]

TOOL_CSV_MAP = {
    "spotit": "spotit_{bm}.csv",
    "polygon": "polygon_{bm}.csv",
    "sqlwitness": "sqlwitness_{bm}.csv",
    "parseval": "parseval_{bm}.csv",
    "parseval-tdg": "parseval_tdg_{bm}.csv",
    "xdata": "xdata_{bm}.csv",
    "xdatapublic": "xdatapublic_{bm}.csv",
    "gemini-4-argon-high-er": "gemini-4-argon-high-er_{bm}.csv",
    "gemini-4-argon-high-tdg": "gemini-4-argon-high-tdg_{bm}.csv",
    "gemini-4-argon-medium-er": "gemini-4-argon-medium-er_{bm}.csv",
    "gemini-4-argon-medium-tdg": "gemini-4-argon-medium-tdg_{bm}.csv",
    "gemini-4-argon-low-er": "gemini-4-argon-low-er_{bm}.csv",
    "gemini-4-argon-low-tdg": "gemini-4-argon-low-tdg_{bm}.csv",
    "lasso": "lasso_{bm}.csv",
}

SYMBOLIC_BASELINES = {
    "spotit", "polygon", "sqlwitness", "parseval",
    "parseval-tdg", "xdata", "xdatapublic"
}
TDG_BASELINES = SYMBOLIC_BASELINES | {
    "gemini-4-argon-high-tdg",
    "gemini-4-argon-medium-tdg",
    "gemini-4-argon-low-tdg",
}
ALL_BASELINES = SYMBOLIC_BASELINES | {
    "gemini-4-argon-high-er",
    "gemini-4-argon-high-tdg",
    "gemini-4-argon-medium-er",
    "gemini-4-argon-medium-tdg",
    "gemini-4-argon-low-er",
    "gemini-4-argon-low-tdg",
}

# Production Rate-Limiting & Resource Safeguards
TRY_LASSO_BURST_LIMIT = int(os.environ.get("TRY_LASSO_BURST_LIMIT", "4"))
TRY_LASSO_BURST_WINDOW_SEC = float(os.environ.get("TRY_LASSO_BURST_WINDOW_SEC", "10.0"))
TRY_LASSO_RATE_LIMIT_PER_MIN = int(os.environ.get("TRY_LASSO_RATE_LIMIT_PER_MIN", "15"))
API_RATE_LIMIT_PER_MIN = int(os.environ.get("API_RATE_LIMIT_PER_MIN", "120"))
MAX_CONCURRENT_TRY_LASSO = int(os.environ.get("MAX_CONCURRENT_TRY_LASSO", "4"))
TRY_LASSO_LOCK_TIMEOUT_SEC = float(os.environ.get("TRY_LASSO_LOCK_TIMEOUT_SEC", "12.0"))
MAX_REQUEST_BODY_BYTES = int(os.environ.get("MAX_REQUEST_BODY_BYTES", "65536"))
MAX_SQL_INPUT_CHARS = int(os.environ.get("MAX_SQL_INPUT_CHARS", "20000"))
SQLITE_INSPECT_TIMEOUT_SEC = float(os.environ.get("SQLITE_INSPECT_TIMEOUT_SEC", "1.5"))

_TRY_LASSO_SEMAPHORE = threading.BoundedSemaphore(MAX_CONCURRENT_TRY_LASSO)
_TRY_LASSO_EXEC_LOCK = threading.Lock()


class SlidingWindowRateLimiter:
    """Thread-safe per-IP sliding-window rate limiter with bounded memory."""

    def __init__(self, max_tracked_keys: int = 5000):
        self._lock = threading.Lock()
        self._buckets = {}
        self._max_tracked_keys = max_tracked_keys
        self._last_cleanup = time.monotonic()

    def check_and_record(self, key: str, rules: list[tuple[int, float]]) -> tuple[bool, int]:
        """
        Check whether `key` is within all `(max_requests, window_seconds)` rules.
        Returns `(allowed, retry_after_seconds)`.
        """
        now = time.monotonic()
        max_window = max(w for _, w in rules) if rules else 60.0

        with self._lock:
            # Periodic cleanup of stale IP buckets
            if now - self._last_cleanup > 60.0 or len(self._buckets) > self._max_tracked_keys:
                cutoff = now - max_window
                stale_keys = [
                    k for k, dq in self._buckets.items()
                    if not dq or dq[-1] < cutoff
                ]
                for k in stale_keys:
                    self._buckets.pop(k, None)
                if len(self._buckets) > self._max_tracked_keys:
                    # Evict oldest keys if still above cap
                    oldest = sorted(
                        self._buckets.items(),
                        key=lambda kv: kv[1][-1] if kv[1] else 0.0
                    )[: len(self._buckets) - self._max_tracked_keys]
                    for k, _ in oldest:
                        self._buckets.pop(k, None)
                self._last_cleanup = now

            dq = self._buckets.get(key)
            if dq is None:
                dq = deque()
                self._buckets[key] = dq

            # Prune timestamps older than the longest window
            while dq and dq[0] <= now - max_window:
                dq.popleft()

            # Check each rule (e.g., burst window + 1-minute window)
            for limit, window in rules:
                window_start = now - window
                # Count timestamps within `window`
                in_window = [ts for ts in dq if ts > window_start]
                if len(in_window) >= limit:
                    retry_after = max(1, int(round(window - (now - in_window[0]))))
                    return False, retry_after

            dq.append(now)
            return True, 0


RATE_LIMITER = SlidingWindowRateLimiter()


def extract_strategy_class(raw_strategy: str) -> str:
    """Extract canonical AttackStrategy class name from dataset_strategy column."""
    if not raw_strategy:
        return "BaseDatasetStrategy"
    s = raw_strategy.strip()
    m = re.match(r"^([A-Za-z0-9]+Strategy)", s)
    if m:
        return m.group(1)
    return s.split("_")[0] if "_" in s else s


def format_sql_pretty(sql_str: str) -> str:
    """Pretty-format SQL query using sqlglot when available."""
    if not sql_str or not sql_str.strip():
        return ""
    if sqlglot is not None:
        try:
            formatted = sqlglot.transpile(sql_str, pretty=True)
            if formatted:
                return formatted[0]
        except Exception:
            pass
    return sql_str.strip()


def serialize_cell(val):
    if val is None:
        return None
    if isinstance(val, (int, float, str, bool)):
        return val
    if isinstance(val, (bytes, bytearray, memoryview)):
        return bytes(val).decode("utf-8", errors="replace")
    return str(val)


def execute_sqlite_inspect(schema_ddl: str, insert_sql: str, gold_sql: str = "", pred_sql: str = ""):
    """
    Executes schema DDL + INSERT statements in an in-memory SQLite database
    to extract populated relational tables and formatted query result tables.
    Enforces a VM instruction deadline so runaway queries cannot hang the server.
    """
    dataset_tables = []
    gold_res_table = {"columns": [], "rows": [], "error": None}
    pred_res_table = {"columns": [], "rows": [], "error": None}

    conn = sqlite3.connect(":memory:")
    try:
        deadline = time.monotonic() + SQLITE_INSPECT_TIMEOUT_SEC
        conn.set_progress_handler(lambda: 1 if time.monotonic() > deadline else 0, 5000)

        cur = conn.cursor()
        cur.execute("PRAGMA foreign_keys = OFF;")
        if schema_ddl:
            cur.executescript(schema_ddl)
        if insert_sql:
            cur.executescript(insert_sql)

        cur.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
        )
        table_names = [r[0] for r in cur.fetchall()]
        for tname in table_names:
            try:
                cur.execute(f'SELECT * FROM "{tname}"')
                cols = [d[0] for d in (cur.description or [])]
                rows = [[serialize_cell(v) for v in row] for row in cur.fetchall()]
                if rows:
                    dataset_tables.append({
                        "table_name": tname,
                        "columns": cols,
                        "rows": rows[:100],
                        "total_rows": len(rows),
                    })
            except Exception:
                continue

        if gold_sql and gold_sql.strip():
            try:
                deadline = time.monotonic() + SQLITE_INSPECT_TIMEOUT_SEC
                cur.execute(gold_sql)
                cols = [d[0] for d in (cur.description or [])]
                rows = [[serialize_cell(v) for v in row] for row in cur.fetchall()]
                gold_res_table = {"columns": cols, "rows": rows[:100], "total_rows": len(rows), "error": None}
            except Exception as ex:
                gold_res_table = {"columns": [], "rows": [], "total_rows": 0, "error": str(ex)}

        if pred_sql and pred_sql.strip():
            try:
                deadline = time.monotonic() + SQLITE_INSPECT_TIMEOUT_SEC
                cur.execute(pred_sql)
                cols = [d[0] for d in (cur.description or [])]
                rows = [[serialize_cell(v) for v in row] for row in cur.fetchall()]
                pred_res_table = {"columns": cols, "rows": rows[:100], "total_rows": len(rows), "error": None}
            except Exception as ex:
                pred_res_table = {"columns": [], "rows": [], "total_rows": 0, "error": str(ex)}
    except Exception:
        pass
    finally:
        conn.close()

    return dataset_tables, gold_res_table, pred_res_table


def parse_cex_sql_file(cex_sql: str, fallback_gold_sql: str = "", fallback_pred_sql: str = ""):
    """
    Parses a self-contained reproducible `.sql` counterexample file into:
      - setup_sql (DDL + INSERTs)
      - gold_sql, pred_sql
      - gold_raw_result, pred_raw_result (from block comments)
      - dataset_tables, gold_res_table, pred_res_table (via in-memory SQLite execution)
    """
    if not cex_sql:
        return {
            "dataset_tables": [],
            "gold_result_table": {"columns": [], "rows": [], "raw_text": ""},
            "pred_result_table": {"columns": [], "rows": [], "raw_text": ""},
            "gold_sql_extracted": fallback_gold_sql,
            "pred_sql_extracted": fallback_pred_sql,
        }

    setup_sql = cex_sql
    gold_q = fallback_gold_sql
    pred_q = fallback_pred_sql
    gold_raw_res = ""
    pred_raw_res = ""

    if "-- Gold Query" in cex_sql:
        parts = cex_sql.split("-- Gold Query", 1)
        setup_sql = parts[0]
        rest = parts[1]
        if "-- Prediction Query" in rest:
            g_part, p_part = rest.split("-- Prediction Query", 1)
        else:
            g_part, p_part = rest, ""

        # Extract Gold SQL and comment result
        g_comment_match = re.search(r"/\*\s*Gold Result:\s*(.*?)\*/", g_part, re.DOTALL)
        if g_comment_match:
            gold_raw_res = g_comment_match.group(1).strip()
            gold_q_cand = g_part[:g_comment_match.start()].strip()
        else:
            gold_q_cand = g_part.strip()
        if gold_q_cand:
            gold_q = gold_q_cand

        # Extract Prediction SQL and comment result
        p_comment_match = re.search(r"/\*\s*Prediction Result:\s*(.*?)\*/", p_part, re.DOTALL)
        if p_comment_match:
            pred_raw_res = p_comment_match.group(1).strip()
            pred_q_cand = p_part[:p_comment_match.start()].strip()
        else:
            pred_q_cand = p_part.strip()
        if pred_q_cand:
            pred_q = pred_q_cand

    dataset_tables, gold_res_table, pred_res_table = execute_sqlite_inspect(
        schema_ddl="",
        insert_sql=setup_sql,
        gold_sql=gold_q,
        pred_sql=pred_q,
    )
    gold_res_table["raw_text"] = gold_raw_res
    pred_res_table["raw_text"] = pred_raw_res

    return {
        "dataset_tables": dataset_tables,
        "gold_result_table": gold_res_table,
        "pred_result_table": pred_res_table,
        "gold_sql_extracted": gold_q,
        "pred_sql_extracted": pred_q,
    }


class DataCache:
    """Thread-safe cache for summary data, exclusive NEQ queries, and SQL lookups."""

    def __init__(self):
        self._lock = threading.Lock()
        self._summary_mtime = 0.0
        self._summary_payload = None
        self._exclusive_index = None
        self._csv_rows_cache = {}
        self._benchmark_queries_cache = {}

    def _parse_strategy_summary(self):
        path = os.path.join(EXPERIMENTS_DIR, "strategy_summary.txt")
        if not os.path.isfile(path):
            return None
        try:
            with open(path, "r", encoding="utf-8") as f:
                lines = [ln.rstrip("\n") for ln in f]

            ranked_rows = []
            matrix_headers = []
            matrix_rows = []
            mode = None

            for ln in lines:
                s = ln.strip()
                if s.startswith("Rank") and "Attack Strategy" in s:
                    mode = "rank"
                    continue
                if s.startswith("Attack Strategy") and "|" in s and "Total" in s:
                    mode = "matrix"
                    matrix_headers = [c.strip() for c in s.split("|")]
                    continue
                if s.startswith("---") or not s:
                    continue

                if mode == "rank" and "|" in s:
                    parts = [c.strip() for c in s.split("|")]
                    if len(parts) >= 4 and parts[0].isdigit():
                        ranked_rows.append(parts[:4])
                elif mode == "matrix" and "|" in s:
                    parts = [c.strip() for c in s.split("|")]
                    if len(parts) == len(matrix_headers):
                        matrix_rows.append(parts)

            return {
                "ranked": {
                    "headers": ["Rank", "Attack Strategy", "Confirmed Kills", "% of Refuted Pairs"],
                    "rows": ranked_rows,
                },
                "matrix": {
                    "headers": matrix_headers,
                    "rows": matrix_rows,
                },
            }
        except Exception:
            return None

    def _parse_bounded_study(self):
        path = os.path.join(EXPERIMENTS_DIR, "gemini_tdg_study", "study_summary.md")
        if not os.path.isfile(path):
            return None
        try:
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()

            tables = []
            current_title = None
            current_headers = None
            current_rows = []

            for line in content.splitlines():
                s = line.strip()
                if s.startswith("## "):
                    if current_title and current_headers:
                        tables.append({
                            "title": current_title,
                            "headers": current_headers,
                            "rows": current_rows,
                        })
                    current_title = s[3:].strip()
                    current_headers = None
                    current_rows = []
                elif s.startswith("|") and s.endswith("|"):
                    cells = [c.strip() for c in s.strip("|").split("|")]
                    if all(re.match(r"^:?-{2,}:?$", c) for c in cells):
                        continue
                    if current_headers is None:
                        current_headers = cells
                    else:
                        current_rows.append(cells)

            if current_title and current_headers:
                tables.append({
                    "title": current_title,
                    "headers": current_headers,
                    "rows": current_rows,
                })
            return tables
        except Exception:
            return None

    def get_benchmark_lookup(self, benchmark):
        """Lazy-load per-benchmark queries.json and schemas.json for SQL & DDL inspection."""
        bm = benchmark.lower().strip()
        with self._lock:
            if bm in self._benchmark_queries_cache:
                return self._benchmark_queries_cache[bm]

        bm_dir = os.path.join(EXPERIMENTS_DIR, "benchmarks", bm)
        q_path = os.path.join(bm_dir, "queries.json")
        s_path = os.path.join(bm_dir, "schemas.json")

        schemas = {}
        if os.path.isfile(s_path):
            try:
                with open(s_path, "r", encoding="utf-8") as f:
                    schemas = json.load(f)
            except Exception:
                pass

        by_pred = {}
        by_inst = {}
        if os.path.isfile(q_path):
            try:
                with open(q_path, "r", encoding="utf-8") as f:
                    q_list = json.load(f)
                for item in q_list:
                    inst_id = str(item.get("id") or item.get("instance_id") or "").strip()
                    db_id = str(item.get("database") or item.get("db_id") or item.get("schema_id") or "").strip()
                    gold_sql = item.get("gold_sql") or item.get("gold_sql_sqlite") or ""
                    ddl = ""
                    if db_id in schemas:
                        ddl = schemas[db_id].get("ddl") or schemas[db_id].get("ddl_postgres") or ""
                    inst_meta = {
                        "instance_id": inst_id,
                        "database_id": db_id,
                        "gold_sql": gold_sql,
                        "ddl": ddl,
                    }
                    by_inst[inst_id] = inst_meta
                    for p in item.get("predictions", []):
                        pid = str(p.get("prediction_id") or "").strip()
                        pred_sql = p.get("prediction_sql") or p.get("prediction_sql_sqlite") or ""
                        by_pred[pid] = {
                            **inst_meta,
                            "prediction_id": pid,
                            "prediction_sql": pred_sql,
                        }
            except Exception:
                pass

        lookup = {"by_pred": by_pred, "by_inst": by_inst}
        with self._lock:
            self._benchmark_queries_cache[bm] = lookup
        return lookup

    def _build_exclusive_index(self):
        """
        Scan evaluation CSVs across all benchmarks to find instances where LASSO proved NEQ
        and other tools failed (all baselines, TDG baselines, or symbolic baselines).
        """
        summary_by_bm = []
        exclusive_records = []
        by_key = {}
        strategy_counter_by_mode = {
            "all": Counter(),
            "tdg": Counter(),
            "symbolic": Counter(),
        }

        for bm in BENCHMARKS:
            lookup = self.get_benchmark_lookup(bm)
            pred_tool_status = defaultdict(dict)
            lasso_rows = {}

            for tool, pat in TOOL_CSV_MAP.items():
                csv_path = os.path.join(RESULTS_DIR, pat.format(bm=bm))
                if not os.path.isfile(csv_path):
                    continue
                try:
                    with open(csv_path, "r", encoding="utf-8", errors="replace") as f:
                        for r in csv.DictReader(f):
                            pid = (r.get("prediction_id") or "").strip()
                            if not pid:
                                continue
                            st = (r.get("EXTEST_STATUS") or r.get("raw_tool_status") or "").strip()
                            pred_tool_status[pid][tool] = st
                            if tool == "lasso" and st in ("NEQ", "NEQ_SCO"):
                                raw_strat = (r.get("dataset_strategy") or "BaseDatasetStrategy").strip()
                                strat_cls = extract_strategy_class(raw_strat)
                                inst_id = (r.get("instance_id") or "").strip()
                                q_meta = lookup["by_pred"].get(pid) or lookup["by_inst"].get(inst_id) or {}
                                lasso_rows[pid] = {
                                    "benchmark": bm,
                                    "instance_id": inst_id,
                                    "prediction_id": pid,
                                    "database_id": q_meta.get("database_id", ""),
                                    "lasso_status": st,
                                    "dataset_source": (r.get("dataset_source") or "gold").strip() or "gold",
                                    "dataset_strategy": raw_strat,
                                    "strategy_class": strat_cls,
                                    "dataset_tags": (r.get("dataset_tags") or "").strip(),
                                    "num_datasets": r.get("num_datasets") or "",
                                    "reproducible_cex": (r.get("reproducible_cex") or "").strip(),
                                    "gold_sql": q_meta.get("gold_sql", ""),
                                    "prediction_sql": q_meta.get("prediction_sql", ""),
                                    "gold_result": (r.get("gold_sql_result") or "")[:200],
                                    "pred_result": (r.get("prediction_sql_result") or "")[:200],
                                }
                except Exception:
                    continue

            lasso_cc_count = len(lasso_rows)
            lasso_gold_count = 0
            excl_sym_count = 0
            excl_tdg_count = 0
            excl_all_count = 0

            for pid, lrec in lasso_rows.items():
                if lrec["dataset_source"] == "gold":
                    lasso_gold_count += 1
                tmap = pred_tool_status[pid]
                killed_by_sym = any(
                    tmap.get(t) in ("NEQ", "NEQ_SCO") for t in SYMBOLIC_BASELINES
                )
                killed_by_tdg = any(
                    tmap.get(t) in ("NEQ", "NEQ_SCO") for t in TDG_BASELINES
                )
                killed_by_all = any(
                    tmap.get(t) in ("NEQ", "NEQ_SCO") for t in ALL_BASELINES
                )

                if not killed_by_sym:
                    excl_sym_count += 1
                    strategy_counter_by_mode["symbolic"][lrec["strategy_class"]] += 1
                if not killed_by_tdg:
                    excl_tdg_count += 1
                    strategy_counter_by_mode["tdg"][lrec["strategy_class"]] += 1
                if not killed_by_all:
                    excl_all_count += 1
                    strategy_counter_by_mode["all"][lrec["strategy_class"]] += 1

                if not killed_by_sym or not killed_by_tdg or not killed_by_all:
                    other_statuses = {
                        t: tmap.get(t, "--")
                        for t in [
                            "sqlwitness", "parseval", "polygon", "spotit",
                            "xdata", "xdatapublic", "parseval-tdg",
                            "gemini-4-argon-high-tdg", "gemini-4-argon-high-er",
                            "gemini-4-argon-medium-tdg", "gemini-4-argon-medium-er",
                            "gemini-4-argon-low-tdg", "gemini-4-argon-low-er"
                        ]
                        if t in tmap
                    }
                    rec = dict(lrec)
                    rec["exclusive_vs_symbolic"] = not killed_by_sym
                    rec["exclusive_vs_tdg"] = not killed_by_tdg
                    rec["exclusive_vs_all"] = not killed_by_all
                    rec["other_statuses"] = other_statuses
                    rec["_hay"] = (
                        f"{rec['benchmark']} {rec['instance_id']} {rec['prediction_id']} "
                        f"{rec['dataset_strategy']} {rec['gold_sql']} {rec['prediction_sql']}"
                    ).lower()
                    exclusive_records.append(rec)
                    by_key[(bm, pid)] = rec

            summary_by_bm.append({
                "benchmark": bm,
                "lasso_gold_kills": lasso_gold_count,
                "lasso_cc_kills": lasso_cc_count,
                "exclusive_vs_symbolic": excl_sym_count,
                "exclusive_vs_tdg": excl_tdg_count,
                "exclusive_vs_all": excl_all_count,
            })

        strategies_by_mode = {
            m: [{"strategy": k, "count": v} for k, v in cnt.most_common()]
            for m, cnt in strategy_counter_by_mode.items()
        }

        return {
            "summary_by_benchmark": summary_by_bm,
            "strategies_by_mode": strategies_by_mode,
            "records": exclusive_records,
            "by_key": by_key,
        }

    def get_summary_payload(self):
        summary_path = os.path.join(EXPERIMENTS_DIR, "analysis_summary.json")
        mtime = os.path.getmtime(summary_path) if os.path.isfile(summary_path) else 0.0

        with self._lock:
            if self._summary_payload is not None and mtime == self._summary_mtime:
                return self._summary_payload

        data = {}
        if os.path.isfile(summary_path):
            with open(summary_path, "r", encoding="utf-8") as f:
                data = json.load(f)

        excl_idx = self._build_exclusive_index()
        data["strategy_data"] = self._parse_strategy_summary()
        data["bounded_study"] = self._parse_bounded_study()
        data["lasso_exclusive_summary"] = excl_idx["summary_by_benchmark"]
        data["lasso_exclusive_strategies"] = excl_idx["strategies_by_mode"].get("all", [])

        with self._lock:
            self._exclusive_index = excl_idx
            self._summary_mtime = mtime
            self._summary_payload = data
            return self._summary_payload

    def get_exclusive_index(self):
        self.get_summary_payload()
        with self._lock:
            return self._exclusive_index

    def get_csv_rows(self, benchmark, tool):
        key = (benchmark, tool)
        with self._lock:
            if key in self._csv_rows_cache:
                return self._csv_rows_cache[key]

        pat = TOOL_CSV_MAP.get(tool)
        if not pat:
            return []
        csv_path = os.path.join(RESULTS_DIR, pat.format(bm=benchmark))
        if not os.path.isfile(csv_path):
            return []

        rows = []
        try:
            with open(csv_path, "r", encoding="utf-8", errors="replace") as f:
                for r in csv.DictReader(f):
                    rows.append({
                        "benchmark": benchmark,
                        "tool": tool,
                        "instance_id": (r.get("instance_id") or "").strip(),
                        "prediction_id": (r.get("prediction_id") or "").strip(),
                        "status": (r.get("EXTEST_STATUS") or r.get("raw_tool_status") or "").strip(),
                        "source": (r.get("dataset_source") or "").strip(),
                        "strategy": (r.get("dataset_strategy") or "").strip(),
                        "time_taken": r.get("time_taken") or "",
                        "cex": (r.get("reproducible_cex") or "").strip(),
                        "error": (r.get("error_message") or "").strip(),
                        "gold_res": (r.get("gold_sql_result") or "")[:200],
                        "pred_res": (r.get("prediction_sql_result") or "")[:200],
                    })
        except Exception:
            pass

        with self._lock:
            self._csv_rows_cache[key] = rows
        return rows


CACHE = DataCache()


class LassoWebHandler(http.server.BaseHTTPRequestHandler):
    def get_client_ip(self) -> str:
        xff = self.headers.get("X-Forwarded-For")
        if xff:
            return xff.split(",")[0].strip()
        xri = self.headers.get("X-Real-IP")
        if xri:
            return xri.strip()
        return self.client_address[0] if self.client_address else "unknown"

    def send_json(self, payload, status=200, extra_headers=None):
        body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-cache")
        if extra_headers:
            for hk, hv in extra_headers.items():
                self.send_header(hk, str(hv))
        self.end_headers()
        self.wfile.write(body)

    def enforce_rate_limit(self, bucket_prefix: str, rules: list[tuple[int, float]]) -> bool:
        client_ip = self.get_client_ip()
        allowed, retry_after = RATE_LIMITER.check_and_record(f"{bucket_prefix}:{client_ip}", rules)
        if not allowed:
            self.send_json(
                {
                    "error": f"Rate limit exceeded ({client_ip}). Please wait {retry_after}s before trying again.",
                    "retry_after": retry_after,
                },
                status=429,
                extra_headers={"Retry-After": str(retry_after)},
            )
            return False
        return True

    def send_file_response(self, file_path):
        if not os.path.isfile(file_path):
            self.send_error(404, "File not found")
            return
        ctype, _ = mimetypes.guess_type(file_path)
        if not ctype:
            if file_path.endswith(".sql"):
                ctype = "text/plain; charset=utf-8"
            elif file_path.endswith(".woff"):
                ctype = "font/woff"
            else:
                ctype = "application/octet-stream"
        elif ctype.startswith("text/") or ctype in ("application/javascript", "application/json"):
            ctype += "; charset=utf-8"

        try:
            with open(file_path, "rb") as f:
                data = f.read()
            self.send_response(200)
            self.send_header("Content-Type", ctype)
            self.send_header("Content-Length", str(len(data)))
            self.send_header("Cache-Control", "no-cache")
            self.end_headers()
            self.wfile.write(data)
        except Exception as e:
            self.send_error(500, f"Error reading file: {e}")

    def handle_api_try_lasso(self):
        """
        Interactive playground endpoint supporting:
          1. Test Data Generation (`mode = "tdg"`): schema + gold_sql -> datasets + metadata + tables + query outputs
          2. Equivalence Refutation (`mode = "er"`): schema + gold_sql + prediction_sql -> NEQ/EQ_EXEC verdict + counterexample + datasets
        Protected by per-IP burst & per-minute rate limits, payload size limits, and global concurrency limits.
        """
        if not self.enforce_rate_limit(
            "try_lasso",
            [
                (TRY_LASSO_BURST_LIMIT, TRY_LASSO_BURST_WINDOW_SEC),
                (TRY_LASSO_RATE_LIMIT_PER_MIN, 60.0),
            ],
        ):
            return

        if generate_test_data is None:
            self.send_json({"error": "LASSO generator module is not available in this Python environment."}, status=500)
            return

        try:
            content_len = int(self.headers.get("Content-Length", "0"))
        except ValueError:
            self.send_json({"error": "Invalid Content-Length header."}, status=400)
            return

        if content_len > MAX_REQUEST_BODY_BYTES:
            self.send_json(
                {"error": f"Request payload too large (max {MAX_REQUEST_BODY_BYTES // 1024} KB)."},
                status=413,
            )
            return

        try:
            raw_body = self.rfile.read(content_len).decode("utf-8") if content_len > 0 else "{}"
            body = json.loads(raw_body)
        except Exception as ex:
            self.send_json({"error": f"Invalid JSON request: {ex}"}, status=400)
            return

        mode = str(body.get("mode") or "tdg").strip().lower()
        schema_ddl = str(body.get("schema") or "").strip()
        gold_sql = str(body.get("gold_sql") or "").strip()
        pred_sql = str(body.get("prediction_sql") or "").strip()

        if not schema_ddl or not gold_sql:
            self.send_json({"error": "Both Database Schema (DDL) and SQL Query are required."}, status=400)
            return
        if mode == "er" and not pred_sql:
            self.send_json({"error": "Candidate / Prediction SQL Query is required for Equivalence Refutation."}, status=400)
            return
        if (
            len(schema_ddl) > MAX_SQL_INPUT_CHARS
            or len(gold_sql) > MAX_SQL_INPUT_CHARS
            or len(pred_sql) > MAX_SQL_INPUT_CHARS
        ):
            self.send_json(
                {"error": f"Schema or SQL query exceeds maximum length ({MAX_SQL_INPUT_CHARS} characters)."},
                status=400,
            )
            return

        # Global concurrency guard so simultaneous demo requests cannot exhaust server resources
        if not _TRY_LASSO_SEMAPHORE.acquire(blocking=False):
            self.send_json(
                {
                    "error": "Server is currently busy processing other demo requests. Please try again in a few seconds.",
                    "retry_after": 3,
                },
                status=429,
                extra_headers={"Retry-After": "3"},
            )
            return

        t0 = time.perf_counter()
        lock_acquired = False
        try:
            lock_acquired = _TRY_LASSO_EXEC_LOCK.acquire(timeout=TRY_LASSO_LOCK_TIMEOUT_SEC)
            if not lock_acquired:
                self.send_json(
                    {
                        "error": "Server is busy processing another query. Please try again in a few seconds.",
                        "retry_after": 3,
                    },
                    status=429,
                    extra_headers={"Retry-After": "3"},
                )
                return

            norm_gold = gold_sql
            norm_pred = pred_sql
            if normalize_sql is not None:
                try:
                    norm_gold = normalize_sql(gold_sql, schema_ddl, dialect="sqlite", mock_time=True, augment_order=True)
                except Exception:
                    norm_gold = gold_sql
                if pred_sql:
                    try:
                        norm_pred = normalize_sql(pred_sql, schema_ddl, dialect="sqlite", mock_time=True, augment_order=True)
                    except Exception:
                        norm_pred = pred_sql

            with open(os.devnull, "w") as devnull, contextlib.redirect_stdout(devnull):
                gold_datasets = generate_test_data(schema_ddl, norm_gold)

            all_datasets_out = []
            killing_dataset = None
            overall_verdict = "EQ_EXEC" if mode == "er" else "GENERATED"

            def process_ds_list(ds_list, source_label):
                nonlocal killing_dataset, overall_verdict
                for idx, ds in enumerate(ds_list, 1):
                    insert_sql = "\n".join(ds.insert_statements or [])
                    tables, gold_res, pred_res = execute_sqlite_inspect(
                        schema_ddl=schema_ddl,
                        insert_sql=insert_sql,
                        gold_sql=norm_gold,
                        pred_sql=norm_pred if mode == "er" else "",
                    )
                    total_rows = sum(t["total_rows"] for t in tables)

                    comp_status = None
                    comp_reason = None
                    kills = False
                    if mode == "er" and execution_test is not None:
                        try:
                            with open(os.devnull, "w") as devnull, contextlib.redirect_stdout(devnull):
                                cmp_res = execution_test(
                                    schema=schema_ddl,
                                    dataset=insert_sql,
                                    gold_sql=norm_gold,
                                    prediction_sql=norm_pred,
                                    dialect="sqlite",
                                )
                            comp_status = cmp_res.get("status", "EQ_EXEC")
                            comp_reason = cmp_res.get("reason")
                            if comp_status.startswith("NEQ"):
                                kills = True
                                if killing_dataset is None:
                                    overall_verdict = comp_status
                        except Exception as ex:
                            comp_status = "ERROR"
                            comp_reason = str(ex)

                    ds_item = {
                        "dataset_idx": len(all_datasets_out) + 1,
                        "strategy": ds.strategy_name,
                        "strategy_class": extract_strategy_class(ds.strategy_name),
                        "tags": list(ds.tags or []),
                        "description": ds.description or "",
                        "source": source_label,
                        "total_rows": total_rows,
                        "tables": tables,
                        "insert_sql": insert_sql,
                        "gold_result": gold_res,
                        "pred_result": pred_res if mode == "er" else None,
                        "status": comp_status,
                        "reason": comp_reason,
                        "kills_mutant": kills,
                    }
                    all_datasets_out.append(ds_item)
                    if kills and killing_dataset is None:
                        killing_dataset = ds_item

            process_ds_list(gold_datasets, "gold")

            # In Equivalence Refutation mode, if mutant survived 1-way datasets, run 2-way (LASSO-CC)
            if mode == "er" and killing_dataset is None and norm_pred:
                try:
                    with open(os.devnull, "w") as devnull, contextlib.redirect_stdout(devnull):
                        pred_datasets = generate_test_data(schema_ddl, norm_pred)
                    process_ds_list(pred_datasets, "pred")
                except Exception:
                    pass

            elapsed_ms = round((time.perf_counter() - t0) * 1000, 1)
            self.send_json({
                "mode": mode,
                "verdict": overall_verdict,
                "elapsed_ms": elapsed_ms,
                "num_datasets": len(all_datasets_out),
                "killing_dataset": killing_dataset,
                "datasets": all_datasets_out,
                "gold_sql_pretty": format_sql_pretty(gold_sql),
                "pred_sql_pretty": format_sql_pretty(pred_sql) if pred_sql else "",
            })
        except Exception as ex:
            self.send_json({"error": f"Failed to process SQL / Schema: {ex}"}, status=400)
        finally:
            if lock_acquired:
                _TRY_LASSO_EXEC_LOCK.release()
            _TRY_LASSO_SEMAPHORE.release()

    def handle_api_lasso_exclusive(self, qs):
        idx = CACHE.get_exclusive_index()
        bm_filter = (qs.get("benchmark", ["all"])[0] or "all").lower().strip()
        # Default mode is "all" (where NO other tool proved NEQ, only LASSO proved NEQ)
        mode = (qs.get("mode", ["all"])[0] or "all").lower().strip()
        source_filter = (qs.get("source", ["all"])[0] or "all").lower().strip()
        strategy_filter = (qs.get("strategy", ["all"])[0] or "all").strip()
        search = (qs.get("search", [""])[0] or "").lower().strip()
        limit = min(int(qs.get("limit", ["25"])[0] or 25), 500)
        offset = max(int(qs.get("offset", ["0"])[0] or 0), 0)

        filtered = []
        for r in idx["records"]:
            if mode == "all" and not r["exclusive_vs_all"]:
                continue
            elif mode == "tdg" and not r["exclusive_vs_tdg"]:
                continue
            elif mode == "symbolic" and not r["exclusive_vs_symbolic"]:
                continue

            if bm_filter != "all" and r["benchmark"] != bm_filter:
                continue
            if source_filter != "all" and r["dataset_source"] != source_filter:
                continue
            if strategy_filter != "all" and r["strategy_class"] != strategy_filter:
                continue
            if search and search not in r.get("_hay", ""):
                continue
            filtered.append(r)

        strategies = idx["strategies_by_mode"].get(mode, idx["strategies_by_mode"].get("all", []))
        page_rows = [
            {k: v for k, v in r.items() if k != "_hay"}
            for r in filtered[offset : offset + limit]
        ]

        self.send_json({
            "total": len(filtered),
            "limit": limit,
            "offset": offset,
            "mode": mode,
            "summary_by_benchmark": idx["summary_by_benchmark"],
            "strategies": strategies,
            "rows": page_rows,
        })

    def handle_api_query_detail(self, qs):
        bm = (qs.get("benchmark", [""])[0] or "").lower().strip()
        inst_id = (qs.get("instance_id", [""])[0] or "").strip()
        pred_id = (qs.get("prediction_id", [""])[0] or "").strip()
        cex_rel = (qs.get("cex", [""])[0] or "").strip()

        lookup = CACHE.get_benchmark_lookup(bm) if bm else {"by_pred": {}, "by_inst": {}}
        meta = lookup["by_pred"].get(pred_id) or lookup["by_inst"].get(inst_id) or {}

        tool_comparison = []
        lasso_match = None
        idx = CACHE.get_exclusive_index()
        cached_rec = idx.get("by_key", {}).get((bm, pred_id)) if idx else None
        if cached_rec:
            lasso_match = {
                "tool": "lasso",
                "status": cached_rec.get("lasso_status", "NEQ"),
                "source": cached_rec.get("dataset_source", "gold"),
                "strategy": cached_rec.get("dataset_strategy", ""),
                "cex": cached_rec.get("reproducible_cex", ""),
            }
            tool_comparison.append(lasso_match)
            if not cex_rel and lasso_match["cex"]:
                cex_rel = lasso_match["cex"]
            for t, st in (cached_rec.get("other_statuses") or {}).items():
                tool_comparison.append({"tool": t, "status": st})
        elif bm and pred_id:
            for t in [
                "lasso", "sqlwitness", "parseval", "polygon", "spotit",
                "xdata", "xdatapublic", "parseval-tdg",
                "gemini-4-argon-high-tdg", "gemini-4-argon-high-er",
                "gemini-4-argon-medium-tdg", "gemini-4-argon-medium-er",
                "gemini-4-argon-low-tdg", "gemini-4-argon-low-er"
            ]:
                t_rows = CACHE.get_csv_rows(bm, t)
                match = next((r for r in t_rows if r["prediction_id"] == pred_id), None)
                if match:
                    tool_comparison.append(match)
                    if t == "lasso":
                        lasso_match = match
                        if not cex_rel and match.get("cex"):
                            cex_rel = match["cex"]

        cex_sql = ""
        if cex_rel:
            safe_cex = os.path.abspath(os.path.join(RESULTS_DIR, cex_rel.lstrip("/")))
            if safe_cex.startswith(RESULTS_DIR) and os.path.isfile(safe_cex):
                try:
                    with open(safe_cex, "r", encoding="utf-8", errors="replace") as f:
                        cex_sql = f.read()
                except Exception:
                    pass

        gold_sql = meta.get("gold_sql", "")
        pred_sql = meta.get("prediction_sql", "")
        parsed_cex = parse_cex_sql_file(cex_sql, fallback_gold_sql=gold_sql, fallback_pred_sql=pred_sql)

        final_gold_sql = gold_sql or parsed_cex["gold_sql_extracted"]
        final_pred_sql = pred_sql or parsed_cex["pred_sql_extracted"]

        self.send_json({
            "benchmark": bm,
            "instance_id": inst_id,
            "prediction_id": pred_id,
            "database_id": meta.get("database_id", ""),
            "gold_sql": final_gold_sql,
            "gold_sql_pretty": format_sql_pretty(final_gold_sql),
            "prediction_sql": final_pred_sql,
            "prediction_sql_pretty": format_sql_pretty(final_pred_sql),
            "ddl": meta.get("ddl", ""),
            "cex_path": cex_rel,
            "cex_sql": cex_sql,
            "dataset_tables": parsed_cex["dataset_tables"],
            "gold_result_table": parsed_cex["gold_result_table"],
            "pred_result_table": parsed_cex["pred_result_table"],
            "lasso_meta": lasso_match,
            "tool_comparison": tool_comparison,
        })

    def do_POST(self):
        parsed = urlparse(self.path)
        path = unquote(parsed.path)
        if path == "/api/try_lasso":
            self.handle_api_try_lasso()
            return
        self.send_error(404, f"Not found: {html.escape(path)}")

    def do_HEAD(self):
        self.do_GET(head_only=True)

    def do_GET(self, head_only=False):
        parsed = urlparse(self.path)
        path = unquote(parsed.path)
        qs = parse_qs(parsed.query)

        # 1. Pages
        if path in ("/", "/index.html"):
            self.send_file_response(os.path.join(WEB_DIR, "pages", "index.html"))
            return

        if path in ("/results", "/results.html", "/analysis", "/analysis.html", "/reports"):
            self.send_file_response(os.path.join(WEB_DIR, "pages", "results.html"))
            return

        # 2. API Endpoints (protected by per-IP rate limit)
        if path in ("/api/summary", "/analysis_summary.json", "/api/lasso_exclusive", "/api/query_detail"):
            if not self.enforce_rate_limit("api_read", [(API_RATE_LIMIT_PER_MIN, 60.0)]):
                return

        if path in ("/api/summary", "/analysis_summary.json"):
            self.send_json(CACHE.get_summary_payload())
            return

        if path == "/api/lasso_exclusive":
            self.handle_api_lasso_exclusive(qs)
            return

        if path == "/api/query_detail":
            self.handle_api_query_detail(qs)
            return

        # 3. Static Assets (web/static/*)
        if path.startswith("/static/"):
            rel = path[len("/static/"):].lstrip("/")
            cand_web = os.path.abspath(os.path.join(WEB_DIR, "static", rel))
            if cand_web.startswith(os.path.join(WEB_DIR, "static")) and os.path.isfile(cand_web):
                self.send_file_response(cand_web)
                return
            cand_vendor = os.path.abspath(os.path.join(WEB_DIR, "static", "vendor", rel))
            if cand_vendor.startswith(os.path.join(WEB_DIR, "static")) and os.path.isfile(cand_vendor):
                self.send_file_response(cand_vendor)
                return
            self.send_error(404, "Static asset not found")
            return

        # 4. Results files (/results/* -> experiments/results/*)
        if path.startswith("/results/"):
            if not self.enforce_rate_limit("api_read", [(API_RATE_LIMIT_PER_MIN, 60.0)]):
                return
            rel = path[len("/results/"):].lstrip("/")
            safe = os.path.abspath(os.path.join(RESULTS_DIR, rel))
            if safe.startswith(RESULTS_DIR) and os.path.isfile(safe):
                self.send_file_response(safe)
                return
            self.send_error(404, "Result file not found")
            return

        self.send_error(404, f"Not found: {html.escape(path)}")

    def log_message(self, fmt, *args):
        sys.stderr.write(f"[{self.log_date_time_string()}] {fmt % args}\n")


class ThreadedHTTPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True
    daemon_threads = True
    request_queue_size = 64


def run():
    with ThreadedHTTPServer(("0.0.0.0", PORT), LassoWebHandler) as httpd:
        print(f"LASSO Web Server running on http://0.0.0.0:{PORT}")
        print(f"  - Research Home:  http://localhost:{PORT}/")
        print(f"  - Results Page:   http://localhost:{PORT}/results")
        httpd.serve_forever()


if __name__ == "__main__":
    run()
