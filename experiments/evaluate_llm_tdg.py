#!/usr/bin/env python3
"""
LLM-TDG: LLM Test Data Generation Evaluator
===========================================

Evaluates the capability of LLMs (default: gemini-4-argon-high) to synthesize test
databases (multiple independent datasets of SQL INSERT statements) given only the
database schema and the single Gold / Reference query.

Each Gold query instance is processed individually via generateContent with a strict 30s
server-side timeout (`X-Server-Timeout: 30`) across 15 CPU cores (multiprocessing +
per-core thread pool) so that per-instance generation time, SQLite execution time, and
token consumption (prompt, candidate, thinking, total) are measured accurately.
Results are stored separately for each model setting under `<model>-tdg`.
"""

import argparse
import contextlib
import csv
import json
import math
import multiprocessing as mp
import os
import queue
import re
import socket
import sys
import time
import urllib.error
import urllib.request
from collections import Counter
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Any, Dict, List, Optional, Tuple

from tqdm import tqdm

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, SCRIPT_DIR)
sys.path.insert(0, os.path.abspath(os.path.join(SCRIPT_DIR, '../src')))
sys.path.insert(0, os.path.abspath(os.path.join(SCRIPT_DIR, '../sql-execution-tester')))

try:
    from execution_tester import execution_test_batch, generate_reproducible_sql
except ImportError as e:
    print(f"Error importing execution_tester: {e}")
    sys.exit(1)

import csv_utils
import benchmark_loader

socket_timeout_error = socket.timeout

BENCHMARK_PRIORITY_ORDER = [
    'largejoin', 'mm-bm', 'mmo-bm', 'mmro-bm', 'literature',
    'tpch', 'calcite', 'xdata', 'lasso-bm', 'leetcode', 'bird', 'cubes'
]

SCHEMAS_DATA_GLOBAL = benchmark_loader.get_schemas(base_dir=SCRIPT_DIR)


def get_ddl(database_id: str) -> str:
    """Retrieve DDL from schemas.json for the given database ID."""
    if database_id in SCHEMAS_DATA_GLOBAL:
        return SCHEMAS_DATA_GLOBAL[database_id].get("ddl", "")
    return ""


def get_api_key(explicit_key: Optional[str] = None) -> str:
    """
    Retrieve Gemini API key from explicit argument, environment variables,
    or shell config files (~/.bashrc, ~/.profile, ~/.zshrc).
    """
    if explicit_key and explicit_key.strip():
        return explicit_key.strip()

    api_key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if api_key and api_key.strip():
        return api_key.strip()

    home_dir = os.path.expanduser("~")
    for fname in [".bashrc", ".profile", ".zshrc"]:
        path = os.path.join(home_dir, fname)
        if os.path.exists(path):
            try:
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                    match = re.search(
                        r'export\s+(?:GEMINI_API_KEY|GOOGLE_API_KEY)=["\']?([^"\'\n]+)["\']?',
                        content
                    )
                    if match:
                        return match.group(1).strip()
            except Exception:
                pass

    raise ValueError(
        "Gemini API key not found. Please provide --api-key or set GEMINI_API_KEY / GOOGLE_API_KEY in environment or ~/.bashrc."
    )


def resolve_model_config(
    model_arg: str,
    thinking_level_arg: Optional[str] = None
) -> Tuple[str, str, Optional[str]]:
    """
    Resolves a user-provided model identifier and optional thinking level into:
      (canonical_model_label, api_model_name, effective_thinking_level)

    Examples:
      'gemini-4-argon-high'    -> ('gemini-4-argon-high', 'gemini-4-argon', 'HIGH')
      'gemini-4-argon-medium'  -> ('gemini-4-argon-medium', 'gemini-4-argon', 'MEDIUM')
      'gemini-4-argon-minimal' -> ('gemini-4-argon-minimal', 'gemini-4-argon', 'MINIMAL')
      'gemini-4-argon-low'     -> ('gemini-4-argon-low', 'gemini-4-argon', 'LOW')
    """
    raw = (model_arg or "gemini-4-argon-high").strip()
    if raw.startswith("models/"):
        raw = raw[len("models/"):]
    if "/" in raw:
        raw = raw.split("/")[-1]

    inferred_thinking = None
    if "#" in raw:
        raw, frag = raw.split("#", 1)
        if frag.strip().upper() in ("HIGH", "MEDIUM", "LOW", "MINIMAL", "NONE", "OFF"):
            inferred_thinking = frag.strip().upper()

    raw_lower = raw.lower().replace("_", "-")
    for suffix, lvl in [
        ("-high", "HIGH"),
        ("-medium", "MEDIUM"),
        ("-low", "LOW"),
        ("-minimal", "MINIMAL"),
        ("-none", "NONE"),
    ]:
        if raw_lower.endswith(suffix):
            base_part = raw_lower[:-len(suffix)]
            if inferred_thinking is None:
                inferred_thinking = lvl
            raw_lower = base_part
            break

    if raw_lower in ("gemini-argon", "gemini-4-argon", "argon"):
        api_model = "gemini-4-argon"
        eff_thinking = (thinking_level_arg or inferred_thinking or "HIGH").strip().upper()
        if eff_thinking == "MINIMAL":
            eff_thinking = "LOW"
    else:
        api_model = raw_lower
        if thinking_level_arg:
            eff_thinking = thinking_level_arg.strip().upper()
        elif inferred_thinking:
            eff_thinking = inferred_thinking
        else:
            eff_thinking = None

    if eff_thinking and eff_thinking in ("HIGH", "MEDIUM", "LOW", "MINIMAL"):
        model_label = f"{api_model}-{eff_thinking.lower()}"
    else:
        model_label = api_model

    return model_label, api_model, eff_thinking


def normalize_model_name(model: str) -> str:
    """Ensure model resource path starts with 'models/'."""
    m = model.strip()
    return m if m.startswith("models/") else f"models/{m}"


def build_generation_config(
    temperature: float = 0.0,
    thinking_level: Optional[str] = "HIGH",
    api_model: str = "gemini-4-argon"
) -> Dict[str, Any]:
    """
    Build generationConfig dictionary with thinkingConfig.
    Note: On gemini-4-argon, the API accepts LOW, MEDIUM, HIGH (where LOW uses 0 thinking tokens).
    When MINIMAL is requested on gemini-4-argon, we pass thinkingLevel='LOW' so the API does not
    reject the request with HTTP 400.
    """
    gen_config: Dict[str, Any] = {"temperature": temperature}
    if thinking_level and thinking_level.strip().upper() not in ("NONE", "OFF", ""):
        lvl = thinking_level.strip().upper()
        if lvl == "MINIMAL" and "argon" in api_model.lower():
            lvl = "LOW"
        gen_config["thinkingConfig"] = {"thinkingLevel": lvl}
    return gen_config


def extract_candidate_text(res_obj: Dict[str, Any]) -> str:
    """Safely extract non-thought text across all parts of the first response candidate."""
    if not isinstance(res_obj, dict):
        return ""
    candidates = res_obj.get("candidates", [])
    if not candidates:
        return ""
    parts = candidates[0].get("content", {}).get("parts", [])
    if not parts:
        return ""
    non_thought = [p.get("text", "") for p in parts if not p.get("thought") and p.get("text")]
    if non_thought:
        return "\n".join(non_thought)
    return "\n".join(p.get("text", "") for p in parts if p.get("text"))


def extract_token_usage(res_obj: Dict[str, Any]) -> Dict[str, int]:
    """
    Extract accurate token usage counts from a GenerateContentResponse dictionary,
    including promptTokenCount, candidatesTokenCount, thoughtsTokenCount, and totalTokenCount.
    """
    usage = res_obj.get("usageMetadata", {}) if isinstance(res_obj, dict) else {}
    prompt_tokens = int(usage.get("promptTokenCount", 0) or 0)
    candidates_tokens = int(usage.get("candidatesTokenCount", 0) or 0)
    thoughts_tokens = int(usage.get("thoughtsTokenCount", 0) or 0)
    total_tokens = int(usage.get("totalTokenCount", 0) or 0)
    if total_tokens == 0 and (prompt_tokens or candidates_tokens or thoughts_tokens):
        total_tokens = prompt_tokens + candidates_tokens + thoughts_tokens
    elif thoughts_tokens == 0 and total_tokens > (prompt_tokens + candidates_tokens):
        thoughts_tokens = total_tokens - prompt_tokens - candidates_tokens
    return {
        "prompt_tokens": prompt_tokens,
        "candidates_tokens": candidates_tokens,
        "thoughts_tokens": thoughts_tokens,
        "total_tokens": total_tokens,
    }


def call_gemini(
    prompt: str,
    api_model: str = "gemini-4-argon",
    api_key: Optional[str] = None,
    temperature: float = 0.0,
    thinking_level: Optional[str] = "HIGH",
    timeout: int = 30,
    max_retries: int = 5
) -> Tuple[str, Dict[str, int], float]:
    """
    Call the Gemini REST API (generateContent) for a single instance with a strict server-side
    timeout (`X-Server-Timeout`, default: 30s). Retries only on HTTP 429/503 or transient SSL
    handshake errors; raises TimeoutError immediately if the request exceeds `timeout` seconds.
    Returns (generated_text, token_usage_dict, generation_time_seconds).
    """
    if not api_key:
        api_key = get_api_key()

    model_path = normalize_model_name(api_model)
    url = f"https://generativelanguage.googleapis.com/v1beta/{model_path}:generateContent?key={api_key}"
    payload = {
        "contents": [
            {
                "parts": [{"text": prompt}],
                "role": "user"
            }
        ],
        "generationConfig": build_generation_config(
            temperature=temperature,
            thinking_level=thinking_level,
            api_model=api_model
        )
    }

    req_data = json.dumps(payload).encode("utf-8")
    has_timeout = timeout is not None and timeout > 0

    for attempt in range(max_retries + 1):
        headers = {"Content-Type": "application/json"}
        if has_timeout:
            headers["X-Server-Timeout"] = str(int(math.ceil(timeout)))
        req = urllib.request.Request(
            url,
            data=req_data,
            headers=headers
        )
        t_start = time.perf_counter()
        try:
            with urllib.request.urlopen(req, timeout=(timeout + 5) if has_timeout else None) as response:
                res_body = response.read().decode("utf-8")
                gen_elapsed = time.perf_counter() - t_start
                data = json.loads(res_body)
                candidates = data.get("candidates", [])
                if not candidates:
                    raise ValueError(f"No response candidates returned: {data}")
                text = extract_candidate_text(data)
                tokens = extract_token_usage(data)
                return text, tokens, gen_elapsed
        except (TimeoutError, socket_timeout_error) as te:
            if not has_timeout and attempt < max_retries:
                time.sleep(1.5 * (attempt + 1))
                continue
            raise TimeoutError(f"Timeout after {timeout}s") from te
        except urllib.error.HTTPError as e:
            err_content = e.read().decode("utf-8")
            err_msg = err_content
            err_code = e.code
            err_status = ""
            try:
                err_json = json.loads(err_content)
                err_msg = err_json.get("error", {}).get("message", err_content)
                err_code = err_json.get("error", {}).get("code", e.code)
                err_status = err_json.get("error", {}).get("status", "")
            except json.JSONDecodeError:
                pass

            if err_code in (408, 504) or err_status == "DEADLINE_EXCEEDED":
                if not has_timeout and attempt < max_retries:
                    time.sleep((2 ** attempt) * 1.5)
                    continue
                raise TimeoutError(f"Timeout after {timeout}s (DEADLINE_EXCEEDED)") from e
            if err_code in (429, 500, 502, 503) and attempt < max_retries:
                wait_time = (2 ** attempt) * 1.5
                time.sleep(wait_time)
                continue
            raise RuntimeError(f"Gemini API Error (HTTP {err_code}): {err_msg}") from e
        except (urllib.error.URLError, OSError) as e:
            if isinstance(getattr(e, "reason", None), (TimeoutError, socket_timeout_error)) or "timed out" in str(e).lower():
                if not has_timeout and attempt < max_retries:
                    time.sleep(1.5 * (attempt + 1))
                    continue
                raise TimeoutError(f"Timeout after {timeout}s") from e
            if attempt < max_retries:
                time.sleep(1.5 * (attempt + 1))
                continue
            reason = getattr(e, "reason", str(e))
            raise RuntimeError(f"Gemini API Network Error: {reason}") from e

    raise RuntimeError("Max retries exceeded when calling Gemini API.")


def generate_tdg_prompt(schema_ddl: str, gold_sql: str, max_datasets: Optional[int] = None) -> str:
    """
    Construct a prompt for the LLM to synthesize test datasets (SQL INSERT statements)
    for a single reference query to test candidate queries and catch/kill potential mistakes.
    Contains strictly NO hints about specific bug types, columns, or relational edge cases to cover.
    """
    if max_datasets is not None and max_datasets > 0:
        objective_text = (
            f"Synthesize exactly {max_datasets} diverse, independent test datasets "
            f"(labeled DATASET 1 to DATASET {max_datasets}) to test the Reference Query "
            f"thoroughly and catch/kill as many potential semantic mistakes and incorrect mutant "
            f"implementations as possible."
        )
        delim_text = (
            f"Format each of the {max_datasets} generated datasets in its own markdown SQL code block, "
            f"prefixed by a comment (e.g. `-- DATASET 1`, `-- DATASET 2`, ..., up to `-- DATASET {max_datasets}`)."
        )
    else:
        objective_text = (
            "Synthesize diverse, independent test datasets to test the Reference Query "
            "thoroughly and catch/kill as many potential semantic mistakes and incorrect mutant "
            "implementations as possible. Generate as many distinct datasets as you deem "
            "necessary to maximize mistake-catching capability."
        )
        delim_text = (
            "Format each generated dataset in its own markdown SQL code block, prefixed by a comment "
            "indicating the dataset number (e.g. `-- DATASET 1`, `-- DATASET 2`, etc., generating as many datasets as needed)."
        )

    prompt = f"""You are an expert in database systems, relational algebra, and SQL test data generation (TDG).
Your objective is to synthesize test database instances (datasets consisting of SQL INSERT statements) for the given database schema and Reference Query (Gold Query).

These test datasets will be executed against candidate mutant queries to refute non-equivalent implementations by causing their execution outputs to differ from the Reference Query.

Database Schema (DDL):
```sql
{schema_ddl.strip()}
```

Reference Query (Gold Query):
```sql
{gold_sql.strip()}
```

Objective:
{objective_text}

Requirements:
1. Generate strictly SQLite-compatible SQL INSERT statements:
   INSERT INTO tablename (col1, col2) VALUES (val1, val2);
2. Generated datasets must strictly consist of INSERT statements only; NEVER include DDL statements (CREATE TABLE, ALTER TABLE, DROP TABLE), schema modifications, or indexing statements (CREATE INDEX).
3. Strict Schema Integrity: Adhere strictly to table definitions, column types, PRIMARY KEY uniqueness, NOT NULL constraints, and FOREIGN KEY references (always insert referenced parent rows before dependent child rows).
4. Independence & Conciseness: Each dataset must be a self-contained, independent database instance. Keep each dataset minimal (only the rows necessary to test a behavior).
5. Delimitation: {delim_text}
```sql
-- DATASET 1
INSERT INTO ...;
```

```sql
-- DATASET 2
INSERT INTO ...;
```
6. Return ONLY executable SQL inside markdown code blocks. Do NOT include markdown explanations outside code blocks or conversational text.
"""
    return prompt


def parse_multiple_datasets_from_llm(text: str, max_datasets: Optional[int] = None) -> List[str]:
    """
    Extracts multiple clean SQL INSERT datasets from the LLM markdown response.
    Supports responses with multiple ```sql ... ``` code blocks,
    as well as single code blocks containing '-- DATASET <n>' delimiter comments.
    Optionally caps at max_datasets if specified.
    """
    code_blocks = re.findall(r'```(?:sql)?\s*(.*?)\s*```', text, re.DOTALL | re.IGNORECASE)

    raw_chunks = []
    delimiter_pattern = r'(?i)(?:^|\n)\s*--\s*(?:DATASET|DATABASE|TEST\s*CASE|SCENARIO)\s*\d*[:\s-]*'

    if len(code_blocks) > 1:
        for block in code_blocks:
            sub_chunks = re.split(delimiter_pattern, block)
            non_empty_subs = [sc.strip() for sc in sub_chunks if sc.strip()]
            if len(non_empty_subs) > 1:
                raw_chunks.extend(non_empty_subs)
            else:
                raw_chunks.append(block.strip())
    elif len(code_blocks) == 1:
        block = code_blocks[0]
        sub_chunks = re.split(delimiter_pattern, block)
        non_empty_subs = [sc.strip() for sc in sub_chunks if sc.strip()]
        if len(non_empty_subs) > 1:
            raw_chunks = non_empty_subs
        else:
            raw_chunks = [block.strip()]
    else:
        sub_chunks = re.split(delimiter_pattern, text)
        non_empty_subs = [sc.strip() for sc in sub_chunks if sc.strip()]
        if len(non_empty_subs) > 1:
            raw_chunks = non_empty_subs
        else:
            raw_chunks = [text.strip()]

    valid_datasets = []
    for chunk in raw_chunks:
        valid_lines = []
        for line in chunk.splitlines():
            stripped = line.strip()
            if not stripped:
                continue
            if stripped.upper().startswith("INSERT") or stripped.startswith("--") or stripped.startswith("/*"):
                valid_lines.append(stripped)
            elif valid_lines and not valid_lines[-1].endswith(";"):
                valid_lines.append(stripped)

        has_insert = any(l.upper().startswith("INSERT") for l in valid_lines)
        if has_insert:
            valid_datasets.append("\n".join(valid_lines))

    if max_datasets is not None and max_datasets > 0:
        valid_datasets = valid_datasets[:max_datasets]

    return valid_datasets


def evaluate_instance_tdg(
    instance_id: str,
    ddl_content: str,
    gold_sql: str,
    prediction_queries: Dict[str, str],
    dialect: str,
    api_model: str,
    api_key: str,
    temperature: float,
    thinking_level: Optional[str],
    timeout: int,
    results_dir: str,
    max_datasets: Optional[int] = None,
    tool_prefix: str = "gemini-4-argon-high-tdg"
) -> Tuple[List[Dict[str, Any]], Dict[str, Any]]:
    """
    Evaluates a single Gold query instance individually using generateContent,
    measuring exact per-instance generation time, execution time, and token consumption.
    Returns: (eval_results_list, datagen_record_dict)
    """
    safe_instance_id = str(instance_id).replace('/', '_').replace('\\', '_')

    tokens = {"prompt_tokens": 0, "candidates_tokens": 0, "thoughts_tokens": 0, "total_tokens": 0}
    raw_llm_response = ""
    api_error = None
    timed_out = False
    t0_fallback = time.perf_counter()
    gen_time = 0.0

    try:
        prompt = generate_tdg_prompt(ddl_content, gold_sql, max_datasets=max_datasets)
        raw_llm_response, tokens, gen_time = call_gemini(
            prompt=prompt,
            api_model=api_model,
            api_key=api_key,
            temperature=temperature,
            thinking_level=thinking_level,
            timeout=timeout
        )
    except TimeoutError as te:
        gen_time = float(timeout) if (timeout and timeout > 0) else (time.perf_counter() - t0_fallback)
        timed_out = True
        api_error = str(te) or f"Timeout after {timeout}s"
    except Exception as e:
        gen_time = time.perf_counter() - t0_fallback
        api_error = str(e)

    t0_exec = time.perf_counter()
    datasets: List[str] = []
    global_error_msg = ""
    global_status = "OK"

    raw_cex_rel = f"raw_cex/{tool_prefix}/{safe_instance_id}.txt"
    raw_cex_full = os.path.join(results_dir, raw_cex_rel)

    if timed_out:
        global_status = "TIMEOUT"
        global_error_msg = api_error
    elif api_error and not raw_llm_response.strip():
        global_status = "TOOL_ERROR"
        global_error_msg = api_error
    else:
        try:
            if raw_llm_response.strip():
                with open(raw_cex_full, "w", encoding="utf-8") as rf:
                    rf.write(raw_llm_response)

            datasets = parse_multiple_datasets_from_llm(raw_llm_response, max_datasets=max_datasets)
            if not datasets:
                global_status = "NO_DATASETS"
                global_error_msg = "No SQL INSERT statements found in LLM output"
        except Exception as e:
            global_status = "TOOL_ERROR"
            global_error_msg = str(e)

    datagen_err_rel = ""
    err_dg_rel = f"error_msg/{tool_prefix}/{safe_instance_id}_datagen.txt"
    err_dg_full = os.path.join(results_dir, err_dg_rel)
    if global_error_msg and global_status in ("TOOL_ERROR", "TIMEOUT", "NO_DATASETS"):
        with open(err_dg_full, "w", encoding="utf-8") as f:
            f.write(global_error_msg)
        datagen_err_rel = err_dg_rel
    elif os.path.exists(err_dg_full):
        try:
            os.remove(err_dg_full)
        except Exception:
            pass

    datagen_record = {
        'instance_id': instance_id,
        'query_id': 'gold',
        'query_type': 'gold',
        'data_gen_time': round(gen_time, 4),
        'num_datasets': len(datasets),
        'prompt_tokens': tokens.get("prompt_tokens", 0),
        'candidates_tokens': tokens.get("candidates_tokens", 0),
        'thoughts_tokens': tokens.get("thoughts_tokens", 0),
        'total_tokens': tokens.get("total_tokens", 0),
        'error_message': datagen_err_rel
    }

    pids = list(prediction_queries.keys())
    pred_states: Dict[str, Dict[str, Any]] = {}
    for pid in pids:
        pred_states[pid] = {
            "status": "unrefuted",
            "execution_result": None,
            "dataset_sql": "",
            "error_message": "",
            "reproducible_cex": ""
        }

    if global_status != "OK" or not datasets:
        for pid in pids:
            pred_states[pid]["status"] = global_status
            pred_states[pid]["error_message"] = global_error_msg
    else:
        unrefuted_pids = list(pids)
        for dataset_sql in datasets:
            if not unrefuted_pids:
                break

            current_queries = [prediction_queries[p] for p in unrefuted_pids]

            test_results = execution_test_batch(
                schema=ddl_content,
                dataset=dataset_sql,
                gold_sql=gold_sql,
                prediction_sqls=current_queries,
                dialect=dialect
            )

            still_unrefuted = []
            for i, res in enumerate(test_results):
                pid = unrefuted_pids[i]
                exec_status = res.get("status", "")

                if not pred_states[pid]["execution_result"]:
                    pred_states[pid]["execution_result"] = res
                    pred_states[pid]["dataset_sql"] = dataset_sql
                    if exec_status.startswith("ERROR"):
                        pred_states[pid]["status"] = exec_status
                        pred_states[pid]["error_message"] = res.get("error_message", "")

                if exec_status == "NEQ":
                    pred_states[pid]["status"] = exec_status
                    pred_states[pid]["execution_result"] = res
                    pred_states[pid]["dataset_sql"] = dataset_sql
                elif exec_status.startswith("NEQ"):
                    if not pred_states[pid]["status"].startswith("NEQ"):
                        pred_states[pid]["status"] = exec_status
                        pred_states[pid]["execution_result"] = res
                        pred_states[pid]["dataset_sql"] = dataset_sql
                    still_unrefuted.append(pid)
                else:
                    if exec_status.startswith("ERROR") and not pred_states[pid]["status"].startswith("NEQ"):
                        pred_states[pid]["status"] = exec_status
                        pred_states[pid]["execution_result"] = res
                        pred_states[pid]["dataset_sql"] = dataset_sql
                        pred_states[pid]["error_message"] = res.get("error_message", "")
                    still_unrefuted.append(pid)

            unrefuted_pids = still_unrefuted

        for pid in pids:
            if pred_states[pid]["status"] == "unrefuted":
                exec_res = pred_states[pid]["execution_result"]
                if exec_res:
                    res_status = exec_res.get("status", "")
                    if res_status in ("EQ_EXEC", "EXEC_EQ", "EQ"):
                        pred_states[pid]["status"] = "EQ_EXEC"
                    elif res_status.startswith("ERROR"):
                        pred_states[pid]["status"] = res_status
                        pred_states[pid]["error_message"] = exec_res.get("error_message", "")
                    else:
                        pred_states[pid]["status"] = "EQ_EXEC"
                else:
                    pred_states[pid]["status"] = "EQ_EXEC"

    exec_elapsed = time.perf_counter() - t0_exec
    total_eval_time = gen_time + exec_elapsed
    per_pred_time = round(total_eval_time / max(len(pids), 1), 4)

    eval_results = []
    for pid in pids:
        safe_pid = str(pid).replace('/', '_').replace('\\', '_')
        st_info = pred_states[pid]
        final_status = st_info["status"]
        exec_res = st_info["execution_result"]
        repro_path = ""
        err_path = ""
        gold_sql_result_str = ""
        pred_sql_result_str = ""

        if exec_res:
            gold_res = exec_res.get("gold_sql_result")
            pred_res = exec_res.get("prediction_sql_result")
            gold_sql_result_str = str(gold_res) if gold_res is not None else ""
            pred_sql_result_str = str(pred_res) if pred_res is not None else ""

        if final_status.startswith("NEQ") and st_info["dataset_sql"]:
            repro_sql = generate_reproducible_sql(
                schema=ddl_content,
                dataset=st_info["dataset_sql"],
                gold_sql=gold_sql,
                prediction_sql=prediction_queries[pid],
                dialect='sqlite',
                gold_res=exec_res.get("gold_sql_result") if exec_res else None,
                pred_res=exec_res.get("prediction_sql_result") if exec_res else None
            )
            repro_rel = f"reproducible_cex/{tool_prefix}/{safe_instance_id}_{safe_pid}.sql"
            with open(os.path.join(results_dir, repro_rel), "w", encoding="utf-8") as rf:
                rf.write(repro_sql)
            repro_path = repro_rel

        err_text = st_info.get("error_message", "")
        err_rel = f"error_msg/{tool_prefix}/{safe_instance_id}_{safe_pid}.txt"
        err_full = os.path.join(results_dir, err_rel)
        if err_text or final_status in ("TOOL_ERROR", "TIMEOUT", "NO_DATASETS") or final_status.startswith("ERROR"):
            with open(err_full, "w", encoding="utf-8") as f:
                f.write(err_text or final_status)
            err_path = err_rel
        elif os.path.exists(err_full):
            try:
                os.remove(err_full)
            except Exception:
                pass

        raw_tool_status = "NEQ" if final_status.startswith("NEQ") else (
            "EQ" if final_status in ("EQ", "EQ_EXEC", "EXEC_EQ") else final_status
        )

        raw_cex_path = raw_cex_rel if (raw_llm_response.strip() and os.path.exists(raw_cex_full)) else ""

        eval_res = {
            'instance_id': instance_id,
            'prediction_id': pid,
            'raw_tool_status': raw_tool_status,
            'EXTEST_STATUS': final_status,
            'dataset_source': 'gold' if len(datasets) > 0 else '',
            'num_datasets': len(datasets),
            'reproducible_cex': repro_path,
            'time_taken': per_pred_time,
            'raw_counterexample': raw_cex_path,
            'error_message': err_path,
            'gold_sql_result': gold_sql_result_str,
            'prediction_sql_result': pred_sql_result_str,
            'prompt_tokens': tokens.get("prompt_tokens", 0),
            'candidates_tokens': tokens.get("candidates_tokens", 0),
            'thoughts_tokens': tokens.get("thoughts_tokens", 0),
            'total_tokens': tokens.get("total_tokens", 0)
        }
        eval_results.append(eval_res)

    return eval_results, datagen_record


def _worker_process_tdg(
    worker_tasks: List[Dict[str, Any]],
    threads_per_core: int,
    api_model: str,
    api_key: str,
    temperature: float,
    thinking_level: Optional[str],
    timeout: int,
    results_dir: str,
    max_datasets: Optional[int],
    tool_prefix: str,
    result_queue: mp.Queue
) -> None:
    """
    Worker process running on a dedicated CPU core with a local ThreadPoolExecutor
    to overlap HTTP requests and execute SQLite batch tests without GIL contention.
    """
    def run_task(t: Dict[str, Any]):
        evs, dg = evaluate_instance_tdg(
            instance_id=t["instance_id"],
            ddl_content=t["ddl_content"],
            gold_sql=t["gold_sql"],
            prediction_queries=t["prediction_queries"],
            dialect=t["dialect"],
            api_model=api_model,
            api_key=api_key,
            temperature=temperature,
            thinking_level=thinking_level,
            timeout=timeout,
            results_dir=results_dir,
            max_datasets=max_datasets,
            tool_prefix=tool_prefix
        )
        return t["src"], evs, dg

    with ThreadPoolExecutor(max_workers=max(1, threads_per_core)) as pool:
        futures = [pool.submit(run_task, t) for t in worker_tasks]
        for fut in as_completed(futures):
            try:
                res = fut.result()
                result_queue.put(("ok", res))
            except Exception as e:
                result_queue.put(("err", str(e)))


def parse_args():
    parser = argparse.ArgumentParser(
        description="LLM-TDG: LLM Test Data Generation Evaluator"
    )
    parser.add_argument(
        '--model',
        type=str,
        default='gemini-4-argon-high',
        help="Model name to evaluate and record in results (default: gemini-4-argon-high)"
    )
    parser.add_argument(
        '--thinking-level',
        type=str,
        default=None,
        help="Thinking level override: LOW, MEDIUM, HIGH, MINIMAL, or NONE (default: inferred from --model)"
    )
    parser.add_argument(
        '--benchmark',
        type=str,
        default='all',
        help="Benchmark to evaluate (e.g. 'bird', 'calcite', 'cubes', 'largejoin', 'leetcode', 'literature', 'tpch', 'xdata', or 'all')"
    )
    parser.add_argument(
        '--cores',
        type=int,
        default=15,
        help="Number of CPU worker processes (default: 15)"
    )
    parser.add_argument(
        '--threads-per-core',
        type=int,
        default=8,
        help="Number of concurrent threads per CPU worker process (default: 8, total concurrency = cores * threads-per-core)"
    )
    parser.add_argument(
        '--workers',
        type=int,
        default=None,
        help="Optional legacy alias for total concurrency"
    )
    parser.add_argument(
        '--timeout',
        type=int,
        default=30,
        help="Per-request server and client timeout in seconds (default: 30)"
    )
    parser.add_argument(
        '--temperature',
        type=float,
        default=0.0,
        help="Sampling temperature for LLM generation (default: 0.0)"
    )
    parser.add_argument(
        '--api-key',
        type=str,
        default=None,
        help="Gemini API Key (optional; defaults to env variable GEMINI_API_KEY / GOOGLE_API_KEY)"
    )
    parser.add_argument(
        '--resume',
        action='store_true',
        help="Resume from last saved item in CSV, skipping completed items"
    )
    parser.add_argument(
        '--retry',
        action='store_true',
        help="Retry evaluation for TOOL_ERROR/NO_DATASETS/missing cases in existing CSV"
    )
    parser.add_argument(
        '--retry-timeout',
        action='store_true',
        help="When used with --retry, also retry TIMEOUT cases"
    )
    parser.add_argument(
        '--retry-eq',
        action='store_true',
        help="When used with --retry, also retry unrefuted (EQ / EQ_EXEC) cases"
    )
    parser.add_argument(
        '--target-dialect',
        type=str,
        default='native',
        choices=['native', 'sqlite', 'mysql', 'postgresql'],
        help="Target SQL dialect to select from input queries"
    )
    parser.add_argument(
        '--instance-id',
        type=str,
        default=None,
        help="Filter evaluation to a specific instance ID"
    )
    parser.add_argument(
        '--prediction-id',
        type=str,
        default=None,
        help="Filter evaluation to a specific prediction ID"
    )
    parser.add_argument(
        '--input-file',
        type=str,
        default=None,
        help="Input JSON file with queries (default: queries.json)"
    )
    parser.add_argument(
        '--mode',
        type=str,
        default='unrestricted',
        choices=['unrestricted', 'bounded'],
        help="Test data generation mode: 'unrestricted' (LLM decides dataset count) or 'bounded' (capped at --max-datasets)"
    )
    parser.add_argument(
        '--max-datasets',
        type=int,
        default=None,
        help="Maximum number of datasets to ask/parse when in 'bounded' mode (e.g. 1, 3, 5, 10). (default: 5 in bounded mode)"
    )
    parser.add_argument(
        '--results-dir',
        type=str,
        default=None,
        help="Directory to save results (default: 'results' for unrestricted, 'gemini_tdg_study/results' for bounded)"
    )
    parser.add_argument(
        '--tool-prefix',
        type=str,
        default=None,
        help="Optional explicit tool prefix override (default: '<model>-tdg' for unrestricted, '<model>-tdg_k{N}' for bounded)"
    )
    return parser.parse_args()


def filter_tdg_predictions(data, results_dir, tool_prefix, resume, retry, retry_timeout, retry_eq, target_inst, target_pred):
    """Filter predictions for resume or retry (skipping TIMEOUT/ERROR_QUERY_EXECUTION unless requested)."""
    if not (resume or retry or retry_timeout) and not target_inst and not target_pred:
        total = sum(len(it.get('predictions', [])) for it in data)
        return data, total

    unique_sources = set(str(it.get('source', 'unknown')).strip().lower() for it in data)
    existing_by_source = {}
    if resume or retry or retry_timeout:
        for src in unique_sources:
            out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
            existing_by_source[src] = csv_utils.load_existing_results(out_csv)

    filtered_data = []
    for item in data:
        src = str(item.get('source', 'unknown')).strip().lower()
        db_id = item.get('schema_id', item.get('database_id'))
        inst_id = str(item.get('id') or item.get('instance_id') or db_id).strip()
        if target_inst and inst_id != str(target_inst).strip():
            continue

        existing_rows = existing_by_source.get(src, {})
        rem_preds = []
        for idx, pred in enumerate(item.get('predictions', [])):
            pred_id = str(pred.get('prediction_id') or f"pred_{idx}").strip()
            if target_pred and pred_id != str(target_pred).strip():
                continue
            pair = (inst_id, pred_id)
            if retry_timeout and not retry and not resume:
                if pair not in existing_rows or (existing_rows[pair].get('EXTEST_STATUS') or '').strip() != 'TIMEOUT':
                    continue
            elif resume and not retry:
                if pair in existing_rows and existing_rows[pair].get('EXTEST_STATUS') not in ('TOOL_ERROR', 'NO_DATASETS'):
                    continue
            elif retry:
                if pair in existing_rows:
                    row = existing_rows[pair]
                    st = (row.get('EXTEST_STATUS') or '').strip()
                    if csv_utils.is_completed_evaluation(row, results_dir, retry_eq=retry_eq):
                        continue
                    if st == 'TIMEOUT' and not retry_timeout:
                        continue
                    if st in ('ERROR_QUERY_EXECUTION', 'ERROR_DATASET_LOADING', 'ERROR_SYNTAX'):
                        continue
            rem_preds.append(pred)

        if rem_preds:
            ic = item.copy()
            ic['predictions'] = rem_preds
            filtered_data.append(ic)

    total_preds = sum(len(it.get('predictions', [])) for it in filtered_data)
    return filtered_data, total_preds


def main():
    args = parse_args()

    try:
        api_key = get_api_key(args.api_key)
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)

    model_label, api_model, thinking_level = resolve_model_config(args.model, args.thinking_level)

    mode = args.mode.lower()
    if mode == 'bounded':
        max_datasets = args.max_datasets if args.max_datasets is not None else 5
        if args.tool_prefix:
            tool_prefix = args.tool_prefix.strip().replace('_', '-')
        else:
            tool_prefix = f"{model_label}-tdg_k{max_datasets}"
        default_results_dir = os.path.join(SCRIPT_DIR, 'gemini_tdg_study', 'results')
    else:
        max_datasets = args.max_datasets
        if args.tool_prefix:
            clean_tp = args.tool_prefix.strip().replace('_', '-')
            tool_prefix = clean_tp if clean_tp.endswith('-tdg') else f"{clean_tp}-tdg"
        else:
            tool_prefix = f"{model_label}-tdg"
        default_results_dir = os.path.join(SCRIPT_DIR, 'results')

    results_dir = args.results_dir or default_results_dir
    os.makedirs(results_dir, exist_ok=True)
    os.makedirs(os.path.join(results_dir, 'reproducible_cex', tool_prefix), exist_ok=True)
    os.makedirs(os.path.join(results_dir, 'raw_cex', tool_prefix), exist_ok=True)
    os.makedirs(os.path.join(results_dir, 'error_msg', tool_prefix), exist_ok=True)

    input_file = args.input_file or os.environ.get('INPUT_FILE')
    data, loaded_schemas = benchmark_loader.load_benchmark_data(
        benchmark=args.benchmark,
        input_file=input_file,
        base_dir=SCRIPT_DIR
    )
    global SCHEMAS_DATA_GLOBAL
    if loaded_schemas:
        SCHEMAS_DATA_GLOBAL = loaded_schemas

    if isinstance(data, dict):
        data = [data]

    available_benchmarks = benchmark_loader.get_available_benchmarks(base_dir=SCRIPT_DIR)

    if not data:
        print(
            f"Error: No queries found for benchmark(s): '{args.benchmark}'.\n"
            f"Available benchmarks are: {', '.join(available_benchmarks)} or 'all'."
        )
        sys.exit(1)

    bm_rank = {b: i for i, b in enumerate(BENCHMARK_PRIORITY_ORDER)}
    data.sort(key=lambda it: bm_rank.get(str(it.get('source', '')).strip().lower(), 999))

    unique_sources = sorted(set(str(item.get('source', 'unknown')).strip().lower() for item in data))

    fieldnames = [
        'instance_id',
        'prediction_id',
        'raw_tool_status',
        'EXTEST_STATUS',
        'dataset_source',
        'num_datasets',
        'reproducible_cex',
        'time_taken',
        'raw_counterexample',
        'error_message',
        'gold_sql_result',
        'prediction_sql_result',
        'prompt_tokens',
        'candidates_tokens',
        'thoughts_tokens',
        'total_tokens'
    ]

    datagen_fieldnames = [
        'instance_id',
        'query_id',
        'query_type',
        'data_gen_time',
        'num_datasets',
        'prompt_tokens',
        'candidates_tokens',
        'thoughts_tokens',
        'total_tokens',
        'error_message'
    ]

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
        mode_write = 'a' if ((args.resume or args.retry or args.retry_timeout) and os.path.exists(out_csv)) else 'w'
        with open(out_csv, mode_write, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            if mode_write == 'w' or os.path.getsize(out_csv) == 0:
                writer.writeheader()

        datagen_csv = os.path.join(results_dir, f'{tool_prefix}_datagen_{src}.csv')
        mode_dg = 'a' if ((args.resume or args.retry or args.retry_timeout) and os.path.exists(datagen_csv)) else 'w'
        with open(datagen_csv, mode_dg, newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=datagen_fieldnames)
            if mode_dg == 'w' or os.path.getsize(datagen_csv) == 0:
                writer.writeheader()

    tool_display_name = f"{tool_prefix} ({mode.capitalize()}{f': max {max_datasets}' if max_datasets else ''})"
    data, total_predictions = filter_tdg_predictions(
        data=data,
        results_dir=results_dir,
        tool_prefix=tool_prefix,
        resume=args.resume,
        retry=args.retry,
        retry_timeout=args.retry_timeout,
        retry_eq=args.retry_eq,
        target_inst=args.instance_id,
        target_pred=args.prediction_id
    )

    num_cores = max(1, args.cores)
    threads_per_core = max(1, args.threads_per_core)

    print("=" * 70)
    print(f"LLM-TDG: LLM Test Data Generation Evaluator ({tool_display_name})")
    print(f"Model Label: {model_label} -> API Model: {api_model} (Thinking Level: {thinking_level or 'DEFAULT'})")
    print(f"Tool Name in Results: {tool_prefix}")
    print(f"Parallelism: {num_cores} CPU cores x {threads_per_core} threads/core ({num_cores * threads_per_core} concurrent workers)")
    print(f"Server/Client Timeout: {f'{args.timeout}s (X-Server-Timeout: {args.timeout})' if args.timeout and args.timeout > 0 else 'Infinite (no timeout)'}")
    print(f"Datasets per query: {f'Bounded (max {max_datasets})' if max_datasets else 'Dynamic (LLM-determined)'}")
    print(f"Output Directory: {results_dir}")
    print(f"Benchmarks: {', '.join(sorted(unique_sources))}")
    print(f"Total instances to process: {len(data)}")
    print(f"Total query pairs to evaluate: {total_predictions}")
    print("=" * 70, flush=True)

    if total_predictions == 0:
        print("All target predictions have already been evaluated.")
        for src in unique_sources:
            out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
            datagen_csv = os.path.join(results_dir, f'{tool_prefix}_datagen_{src}.csv')
            csv_utils.deduplicate_csv(out_csv, fieldnames)
            csv_utils.deduplicate_datagen_csv(datagen_csv, datagen_fieldnames)
        return

    status_counts = Counter()
    total_tokens_accum = {
        "prompt_tokens": 0,
        "candidates_tokens": 0,
        "thoughts_tokens": 0,
        "total_tokens": 0
    }
    last_status = [None]
    total_start_time = time.perf_counter()

    tasks: List[Dict[str, Any]] = []

    with tqdm(total=total_predictions, desc=f"Evaluating with {tool_prefix}") as pbar:
        for item in data:
            src = str(item.get('source', 'unknown')).strip().lower()
            db_id = item.get('schema_id', item.get('database_id'))
            instance_id = str(item.get('id') or item.get('instance_id') or db_id).strip()
            ddl_content = get_ddl(db_id)

            dialect = args.target_dialect if args.target_dialect != 'native' else 'sqlite'
            gold_sql = item.get(f'gold_sql_{dialect}', item.get('gold_sql'))

            out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')

            if not ddl_content or not gold_sql:
                for pred in item.get('predictions', []):
                    pred_id = pred.get('prediction_id')
                    skip_status = "SKIPPED_NO_DDL" if not ddl_content else "SKIPPED_NO_GOLD_SQL"
                    res = {
                        'instance_id': instance_id,
                        'prediction_id': pred_id,
                        'raw_tool_status': skip_status,
                        'EXTEST_STATUS': skip_status,
                        'dataset_source': '',
                        'num_datasets': 0,
                        'reproducible_cex': '',
                        'time_taken': 0.0,
                        'raw_counterexample': '',
                        'error_message': '',
                        'gold_sql_result': '',
                        'prediction_sql_result': '',
                        'prompt_tokens': 0,
                        'candidates_tokens': 0,
                        'thoughts_tokens': 0,
                        'total_tokens': 0
                    }
                    csv_utils.update_or_append_results(out_csv, fieldnames, [res])
                    status_counts[skip_status] += 1
                    pbar.update(1)
                continue

            prediction_queries = {}
            for pred in item.get('predictions', []):
                pred_id = pred.get('prediction_id')
                pred_sql = pred.get(f'prediction_sql_{dialect}', pred.get('prediction_sql'))
                if pred_sql:
                    prediction_queries[pred_id] = pred_sql
                else:
                    skip_status = "SKIPPED_NO_PRED_SQL"
                    res = {
                        'instance_id': instance_id,
                        'prediction_id': pred_id,
                        'raw_tool_status': skip_status,
                        'EXTEST_STATUS': skip_status,
                        'dataset_source': '',
                        'num_datasets': 0,
                        'reproducible_cex': '',
                        'time_taken': 0.0,
                        'raw_counterexample': '',
                        'error_message': '',
                        'gold_sql_result': '',
                        'prediction_sql_result': '',
                        'prompt_tokens': 0,
                        'candidates_tokens': 0,
                        'thoughts_tokens': 0,
                        'total_tokens': 0
                    }
                    csv_utils.update_or_append_results(out_csv, fieldnames, [res])
                    status_counts[skip_status] += 1
                    pbar.update(1)

            if not prediction_queries:
                continue

            tasks.append({
                "src": src,
                "instance_id": instance_id,
                "ddl_content": ddl_content,
                "gold_sql": gold_sql,
                "prediction_queries": prediction_queries,
                "dialect": dialect
            })

        if tasks:
            actual_cores = min(num_cores, len(tasks))
            result_queue: mp.Queue = mp.Queue()
            processes: List[mp.Process] = []

            for c_idx in range(actual_cores):
                slice_tasks = tasks[c_idx::actual_cores]
                p = mp.Process(
                    target=_worker_process_tdg,
                    args=(
                        slice_tasks,
                        threads_per_core,
                        api_model,
                        api_key,
                        args.temperature,
                        thinking_level,
                        args.timeout,
                        results_dir,
                        max_datasets,
                        tool_prefix,
                        result_queue
                    ),
                    daemon=True
                )
                p.start()
                processes.append(p)

            completed_tasks = 0
            total_tasks = len(tasks)
            try:
                while completed_tasks < total_tasks:
                    try:
                        msg_type, payload = result_queue.get(timeout=5.0)
                    except queue.Empty:
                        if not any(p.is_alive() for p in processes) and result_queue.empty():
                            break
                        continue

                    completed_tasks += 1
                    if msg_type == "ok":
                        src, eval_results, datagen_rec = payload
                        out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
                        datagen_csv = os.path.join(results_dir, f'{tool_prefix}_datagen_{src}.csv')
                        for ev in eval_results:
                            status_counts[ev['EXTEST_STATUS']] += 1
                        for tk in total_tokens_accum:
                            total_tokens_accum[tk] += datagen_rec.get(tk, 0)
                        csv_utils.update_or_append_results(out_csv, fieldnames, eval_results)
                        csv_utils.update_or_append_results(datagen_csv, datagen_fieldnames, [datagen_rec])
                        csv_utils.print_status_update(pbar, status_counts, last_status)
                        pbar.update(len(eval_results))
                    else:
                        pbar.write(f"Worker error: {payload}")
            except KeyboardInterrupt:
                pbar.write("\nInterrupted by user. Terminating worker processes...")
                for p in processes:
                    p.terminate()
                sys.exit(0)
            finally:
                for p in processes:
                    p.join(timeout=2.0)

    total_time_taken = time.perf_counter() - total_start_time
    print(f"\nDone. All results saved in {results_dir}")

    for src in unique_sources:
        out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
        datagen_csv = os.path.join(results_dir, f'{tool_prefix}_datagen_{src}.csv')
        csv_utils.deduplicate_csv(out_csv, fieldnames)
        csv_utils.deduplicate_datagen_csv(datagen_csv, datagen_fieldnames)

    for src in unique_sources:
        print(f"\n--- Status Statistics for {src.upper()} ({tool_display_name}) ---")
        try:
            out_csv = os.path.join(results_dir, f'{tool_prefix}_{src}.csv')
            with open(out_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                rows = list(reader)
                counts = Counter(row.get('EXTEST_STATUS', 'UNKNOWN') for row in rows)
                total_rows = len(rows)
                neq_count = counts.get('NEQ', 0) + counts.get('NEQ_SCO', 0)
                ref_pct = (neq_count / total_rows * 100) if total_rows > 0 else 0.0

                for status, count in counts.most_common():
                    print(f"{status}: {count}")
                print(f"Total pairs: {total_rows}")
                print(f"Refutation Rate (NEQ): {neq_count}/{total_rows} ({ref_pct:.1f}%)")

            err_counts = csv_utils.get_error_histogram(out_csv, results_dir, "ERROR_QUERY_EXECUTION")
            csv_utils.print_error_histogram(err_counts, f"Top 5 ERROR_QUERY_EXECUTION Errors for {src.upper()}", top_n=5)
        except Exception as e:
            print(f"Could not print statistics for {src}: {e}")

    print(f"\n--- Overall Token Usage ({tool_prefix}) ---")
    print(f"Prompt Tokens:     {total_tokens_accum['prompt_tokens']:,}")
    print(f"Candidate Tokens:  {total_tokens_accum['candidates_tokens']:,}")
    print(f"Thinking Tokens:   {total_tokens_accum['thoughts_tokens']:,}")
    print(f"Total Tokens:      {total_tokens_accum['total_tokens']:,}")
    print(f"Wall-Clock Time:   {total_time_taken:.2f}s")


if __name__ == '__main__':
    main()
