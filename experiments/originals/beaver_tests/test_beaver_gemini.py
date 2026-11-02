import os
import sys
import time
import csv
import json
import re
import sqlite3
import argparse
import urllib.request
import urllib.error
from typing import Dict, Any, Optional, List, Tuple

CURR_DIR = os.path.dirname(os.path.abspath(__file__))
EXPERIMENTS_DIR = os.path.abspath(os.path.join(CURR_DIR, ".."))
REPO_ROOT = os.path.abspath(os.path.join(CURR_DIR, "..", ".."))

sys.path.insert(0, os.path.join(REPO_ROOT, "src"))

from parser import parse_ddl_to_schema

SCHEMA_FILE = os.path.join(CURR_DIR, "schema.sql")
QUERIES_FILE = os.path.join(CURR_DIR, "top10_queries.json")


def execute_sqlite_in_memory(schema_sql: str, dataset_sql: str, query_sql: str) -> Tuple[Optional[List[Tuple]], Optional[str]]:
    """Execute schema, dataset inserts, and query directly in an in-memory SQLite database."""
    conn = sqlite3.connect(":memory:")
    try:
        cur = conn.cursor()
        cur.executescript(schema_sql)
        if dataset_sql.strip():
            cur.executescript(dataset_sql)
        cur.execute(query_sql)
        rows = cur.fetchall()
        return rows, None
    except Exception as e:
        return None, str(e)
    finally:
        conn.close()


def get_api_key() -> str:
    """Retrieve Gemini API key from environment variables or ~/.bashrc."""
    api_key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if api_key:
        return api_key.strip()

    home_dir = os.path.expanduser("~")
    for fname in [".bashrc", ".profile", ".zshrc"]:
        path = os.path.join(home_dir, fname)
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
                match = re.search(r'export\s+(?:GEMINI_API_KEY|GOOGLE_API_KEY)=["\']?([^"\'\n]+)["\']?', content)
                if match:
                    return match.group(1).strip()

    raise ValueError("Gemini API key not found. Please set GEMINI_API_KEY in your environment or ~/.bashrc.")


def call_gemini(
    prompt: str,
    model: str = "gemini-3.8-flash",
    api_key: Optional[str] = None,
    temperature: float = 0.1,
    timeout: int = 30
) -> Tuple[str, Dict[str, int]]:
    """Call Gemini REST API to get generated SQL dataset text and token usage metadata."""
    if not api_key:
        api_key = get_api_key()

    url = f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={api_key}"
    payload = {
        "contents": [
            {
                "parts": [
                    {"text": prompt}
                ]
            }
        ],
        "generationConfig": {
            "temperature": temperature,
        }
    }

    req_data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=req_data,
        headers={"Content-Type": "application/json"}
    )

    try:
        with urllib.request.urlopen(req, timeout=timeout) as response:
            res_body = response.read().decode("utf-8")
            data = json.loads(res_body)
            candidates = data.get("candidates", [])
            if not candidates:
                raise ValueError(f"No response candidates returned: {data}")
            text = candidates[0]["content"]["parts"][0]["text"]
            usage = data.get("usageMetadata", {})
            tokens = {
                "prompt_tokens": usage.get("promptTokenCount", 0),
                "candidates_tokens": usage.get("candidatesTokenCount", 0),
                "total_tokens": usage.get("totalTokenCount", 0),
            }
            return text, tokens
    except urllib.error.HTTPError as e:
        err_content = e.read().decode("utf-8")
        try:
            err_json = json.loads(err_content)
            err_msg = err_json.get("error", {}).get("message", err_content)
            err_code = err_json.get("error", {}).get("code", e.code)
            raise RuntimeError(f"Gemini API Error (HTTP {err_code}): {err_msg}") from e
        except json.JSONDecodeError:
            raise RuntimeError(f"Gemini API HTTP {e.code} Error: {err_content}") from e


def load_schema() -> str:
    with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
        return f.read()


def load_queries() -> List[Dict[str, Any]]:
    with open(QUERIES_FILE, "r", encoding="utf-8") as f:
        return json.load(f)


def extract_relevant_ddl(schema_sql: str, table_names: List[str]) -> str:
    """Extract CREATE TABLE statements for only the tables used by the query."""
    table_set = {t.strip('"`[]').upper() for t in table_names}
    statements = []
    
    # Split DDL by semicolons
    for stmt in schema_sql.split(";"):
        stmt = stmt.strip()
        if not stmt:
            continue
        match = re.search(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?["`]?([a-zA-Z0-9_]+)["`]?', stmt, re.IGNORECASE)
        if match:
            t_name = match.group(1).upper()
            if t_name in table_set:
                statements.append(stmt + ";")
    
    if not statements:
        # Fallback to full schema if parsing didn't match
        return schema_sql
    return "\n\n".join(statements)


def parse_sql_inserts_from_llm(text: str) -> str:
    """Extract clean SQL INSERT statements from LLM markdown response."""
    # Look for sql code fence
    fence_match = re.search(r'```(?:sql)?\s*(.*?)\s*```', text, re.DOTALL | re.IGNORECASE)
    if fence_match:
        sql_content = fence_match.group(1)
    else:
        sql_content = text

    # Filter lines that look like INSERT statements or comments
    valid_lines = []
    for line in sql_content.splitlines():
        stripped = line.strip()
        if not stripped:
            continue
        if stripped.upper().startswith("INSERT") or stripped.startswith("--") or stripped.startswith("/*"):
            valid_lines.append(stripped)
        elif valid_lines and not valid_lines[-1].endswith(";"):
            # Multi-line insert statement continuation
            valid_lines.append(stripped)
            
    return "\n".join(valid_lines)


def generate_llm_prompt(schema_ddl: str, query_info: Dict[str, Any]) -> str:
    """Build a detailed prompt guiding the LLM to create data satisfying all query conditions."""
    query_id = query_info.get("id", "")
    question = query_info.get("question", "")
    query_sql = query_info.get("sql", "")
    tables = ", ".join(query_info.get("tables", []))

    prompt = f"""You are a database testing and SQL data generation expert.
Your goal is to generate test data (SQL INSERT statements) for the provided database schema so that executing the target SQL query on this dataset produces a NON-EMPTY result (at least 1 valid result row).

Target Tables: {tables}

Database Schema (DDL):
```sql
{schema_ddl}
```

Target SQL Query ({query_id}):
-- Question: {question}
```sql
{query_sql}
```

Requirements:
1. Generate INSERT INTO statements for the tables used in the query.
2. Construct minimum rows so that query output will have atleast 1 row.
3. Use valid SQLite syntax for INSERT statements.
4. Return ONLY valid SQL INSERT statements inside a ```sql ... ``` block without conversational preamble.
"""
    return prompt


def parse_args():
    parser = argparse.ArgumentParser(description="Gemini LLM Beaver Test Data Generation & Non-Empty Execution Runner")
    parser.add_argument("--queries", type=str, default="", help="Comma-separated query IDs (e.g. dw_0,dw_1) (default: all)")
    parser.add_argument("--model", type=str, default="gemini-3.8-flash", help="Gemini model to use (default: gemini-3.8-flash)")
    parser.add_argument("--timeout", type=int, default=30, help="LLM request timeout in seconds (default: 30)")
    return parser.parse_args()


def main():
    args = parse_args()
    schema_sql = load_schema()
    all_queries = load_queries()

    if args.queries:
        selected = {q.strip().lower() for q in args.queries.split(",") if q.strip()}
        test_queries = [q for q in all_queries if q["id"].lower() in selected]
    else:
        test_queries = all_queries

    results_dir = os.path.join(CURR_DIR, "results_gemini")
    datasets_dir = os.path.join(results_dir, "datasets")
    os.makedirs(datasets_dir, exist_ok=True)

    print("=" * 70)
    print("Gemini LLM Beaver (dw schema) Test Data Generation & Execution")
    print(f"Model: {args.model}")
    print(f"Testing {len(test_queries)} query/queries")
    print("=" * 70, flush=True)

    passed = 0
    total_start = time.perf_counter()
    results_summary = {}

    for q_entry in test_queries:
        q_id = q_entry["id"]
        q_sql = q_entry["sql"]
        tables = q_entry.get("tables", [])

        print(f"\n[{q_id}] Processing...", flush=True)
        t0 = time.perf_counter()

        status = "EMPTY"
        row_count = 0
        dataset_sql = ""
        num_inserts = 0
        err = ""
        gold_res = None
        tokens = {"prompt_tokens": 0, "candidates_tokens": 0, "total_tokens": 0}

        try:
            # 1. Extract only relevant tables for compact prompt
            relevant_ddl = extract_relevant_ddl(schema_sql, tables)
            
            # 2. Build prompt
            prompt = generate_llm_prompt(relevant_ddl, q_entry)

            # 3. Call LLM (Tool Time)
            t_tool_start = time.perf_counter()
            llm_response, tokens = call_gemini(
                prompt=prompt,
                model=args.model,
                timeout=args.timeout
            )
            elapsed = time.perf_counter() - t_tool_start

            # 4. Parse INSERT statements
            dataset_sql = parse_sql_inserts_from_llm(llm_response)
            insert_lines = [l for l in dataset_sql.splitlines() if l.strip().upper().startswith("INSERT")]
            num_inserts = len(insert_lines)

            # 5. Save generated dataset
            dataset_file = os.path.join(datasets_dir, f"{q_id}.sql")
            with open(dataset_file, "w", encoding="utf-8") as f:
                f.write(dataset_sql + "\n")

            # 6. Run In-Memory SQLite Execution Test
            gold_res, err = execute_sqlite_in_memory(
                schema_sql=schema_sql,
                dataset_sql=dataset_sql,
                query_sql=q_sql
            )

            if err:
                status = "ERROR"
                print(f"-> {q_id}: [ERROR] {err} ({elapsed:.2f}s, tokens: {tokens['total_tokens']})", flush=True)
            elif gold_res and len(gold_res) > 0:
                status = "OK"
                row_count = len(gold_res)
                passed += 1
                print(f"-> {q_id}: [OK] {row_count} row(s) returned! ({elapsed:.2f}s, tokens: {tokens['total_tokens']})", flush=True)
                print(f"   Sample row: {gold_res[0]}", flush=True)
            else:
                status = "EMPTY"
                print(f"-> {q_id}: [EMPTY] 0 rows returned ({elapsed:.2f}s, tokens: {tokens['total_tokens']})", flush=True)

        except Exception as e:
            elapsed = time.perf_counter() - t0
            status = "EXCEPTION"
            err = str(e)
            print(f"-> {q_id}: [EXCEPTION] {err} ({elapsed:.2f}s)", flush=True)

        results_summary[q_id] = {
            "status": status,
            "row_count": row_count,
            "elapsed_seconds": round(elapsed, 4),
            "prompt_tokens": tokens.get("prompt_tokens", 0),
            "candidates_tokens": tokens.get("candidates_tokens", 0),
            "total_tokens": tokens.get("total_tokens", 0),
            "dataset_file": f"datasets/{q_id}.sql" if dataset_sql else "",
            "num_insert_statements": num_inserts,
            "error_message": err or "",
            "result_sample": [list(r) for r in gold_res[:3]] if gold_res else [],
        }

    total_time = time.perf_counter() - total_start
    total_q = len(test_queries)
    pass_pct = (passed / total_q * 100) if total_q else 0.0

    print("\n" + "=" * 70)
    print(f"Summary: {passed}/{total_q} queries produced non-empty results ({pass_pct:.1f}%) in {total_time:.2f}s")
    print(f"Saved datasets and results to: {results_dir}")
    print("=" * 70, flush=True)

    results_csv_path = os.path.join(results_dir, "results.csv")
    with open(results_csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "query_id",
                "status",
                "row_count",
                "elapsed_seconds",
                "prompt_tokens",
                "candidates_tokens",
                "total_tokens",
                "dataset_file",
                "num_insert_statements",
                "error_message",
            ],
        )
        writer.writeheader()
        for q_id, q_data in sorted(results_summary.items()):
            writer.writerow({
                "query_id": q_id,
                "status": q_data["status"],
                "row_count": q_data["row_count"],
                "elapsed_seconds": q_data["elapsed_seconds"],
                "prompt_tokens": q_data["prompt_tokens"],
                "candidates_tokens": q_data["candidates_tokens"],
                "total_tokens": q_data["total_tokens"],
                "dataset_file": q_data["dataset_file"],
                "num_insert_statements": q_data["num_insert_statements"],
                "error_message": q_data["error_message"],
            })


if __name__ == "__main__":
    main()
