"""
Unified Benchmark Loader for LASSO Evaluation Suite.

Loads benchmark-specific queries, schemas, and sample data directly
from the experiments/benchmarks/ directory structure:
  experiments/benchmarks/<benchmark_name>/
    ├── queries.json
    ├── schemas.json
    └── sample_data/
"""

import os
import re
import json
import logging
from typing import Dict, List, Tuple, Optional, Any

logger = logging.getLogger(__name__)

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, 'benchmarks')


def normalize_benchmark_name(name: str) -> str:
    """Normalize benchmark name to standard lowercase identifier."""
    if not name:
        return ""
    clean = name.strip().lower()
    if clean == "lasso-bm":
        return "lasso-bm"
    if clean in ("xdata_bm", "xdata-bm"):
        return "xdata"
    if clean in ("manymutantsbm", "manymutations", "manymutationsbm", "mm-bm", "mm_bm", "mmbm"):
        return "mm-bm"
    if clean in ("mmo-bm", "mmo_bm", "mmobm", "manymutationsobfuscated"):
        return "mmo-bm"
    if clean in ("mmro-bm", "mmro_bm", "mmro", "mmrobm", "manymutationsrandomobfuscated"):
        return "mmro-bm"
    return clean


def parse_benchmark_selection(benchmark_arg: Optional[str]) -> List[str]:
    """Parse benchmark argument which may be 'all', single benchmark, or multiple separated by space/comma."""
    if not benchmark_arg or benchmark_arg.strip().lower() == 'all':
        return ['all']
    tokens = [normalize_benchmark_name(t) for t in re.split(r'[, \t]+', benchmark_arg.strip()) if t.strip()]
    return tokens if tokens else ['all']


def get_available_benchmarks(base_dir: str = SCRIPT_DIR) -> List[str]:
    """Returns the list of available benchmarks from benchmarks/ directory."""
    bench_dir = os.path.join(base_dir, 'benchmarks')
    found = set()
    if os.path.exists(bench_dir) and os.path.isdir(bench_dir):
        for entry in os.listdir(bench_dir):
            p = os.path.join(bench_dir, entry)
            if os.path.isdir(p) and not entry.startswith('.'):
                q_file = os.path.join(p, 'queries.json')
                if os.path.exists(q_file):
                    found.add(normalize_benchmark_name(entry))
    return sorted(found)


def load_schemas_for_benchmark(bench_name: str, base_dir: str = SCRIPT_DIR) -> Dict[str, Any]:
    """Load schemas specifically for one benchmark from benchmarks/<name>/schemas.json."""
    norm_bench = normalize_benchmark_name(bench_name)
    bench_schemas_file = os.path.join(base_dir, 'benchmarks', norm_bench, 'schemas.json')
    if os.path.exists(bench_schemas_file):
        try:
            with open(bench_schemas_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            logger.warning(f"Error loading {bench_schemas_file}: {e}")
    return {}


def load_all_schemas(base_dir: str = SCRIPT_DIR) -> Dict[str, Any]:
    """Load all schemas merged across all benchmarks in benchmarks/."""
    all_schemas = {}
    bench_dir = os.path.join(base_dir, 'benchmarks')
    if os.path.exists(bench_dir) and os.path.isdir(bench_dir):
        for entry in sorted(os.listdir(bench_dir)):
            p = os.path.join(bench_dir, entry)
            if os.path.isdir(p) and not entry.startswith('.'):
                sch_file = os.path.join(p, 'schemas.json')
                if os.path.exists(sch_file):
                    try:
                        with open(sch_file, 'r', encoding='utf-8') as f:
                            all_schemas.update(json.load(f))
                    except Exception as e:
                        logger.warning(f"Error loading {sch_file}: {e}")
    return all_schemas


def get_schemas(benchmark: Optional[str] = None, base_dir: str = SCRIPT_DIR) -> Dict[str, Any]:
    """
    Get schema dictionary. If a specific benchmark is given, loads from its directory.
    If 'all' or None, merges schemas from all available benchmarks.
    """
    if not benchmark or benchmark.strip().lower() == 'all':
        return load_all_schemas(base_dir=base_dir)

    tokens = parse_benchmark_selection(benchmark)
    if 'all' in tokens:
        return load_all_schemas(base_dir=base_dir)

    schemas = {}
    for t in tokens:
        schemas.update(load_schemas_for_benchmark(t, base_dir=base_dir))
    return schemas


def load_benchmark_data(
    benchmark: str = 'all',
    input_file: Optional[str] = None,
    base_dir: str = SCRIPT_DIR
) -> Tuple[List[Dict[str, Any]], Dict[str, Any]]:
    """
    Loads query items and schema dictionary from benchmarks/ directory according to benchmark selection.
    
    If input_file is given, loads queries directly from that file, and schemas for the benchmarks.
    Otherwise loads queries and schemas directly from benchmarks/<bench>/.
    
    Returns:
      (queries_data, schemas_data)
    """
    if input_file:
        in_path = os.path.join(base_dir, input_file) if not os.path.isabs(input_file) else input_file
        if os.path.exists(in_path):
            with open(in_path, 'r', encoding='utf-8') as f:
                queries_data = json.load(f)
            tokens = parse_benchmark_selection(benchmark)
            if 'all' not in tokens:
                queries_data = [d for d in queries_data if normalize_benchmark_name(d.get('source', '')) in tokens]
            schemas_data = get_schemas(benchmark=benchmark, base_dir=base_dir)
            return queries_data, schemas_data

    tokens = parse_benchmark_selection(benchmark)
    bench_dir = os.path.join(base_dir, 'benchmarks')

    queries_data: List[Dict[str, Any]] = []
    schemas_data: Dict[str, Any] = {}

    if 'all' in tokens:
        if os.path.exists(bench_dir) and os.path.isdir(bench_dir):
            for entry in sorted(os.listdir(bench_dir)):
                p = os.path.join(bench_dir, entry)
                if os.path.isdir(p) and not entry.startswith('.'):
                    q_file = os.path.join(p, 'queries.json')
                    s_file = os.path.join(p, 'schemas.json')
                    if os.path.exists(q_file):
                        try:
                            with open(q_file, 'r', encoding='utf-8') as f:
                                queries_data.extend(json.load(f))
                        except Exception as e:
                            logger.warning(f"Error loading {q_file}: {e}")
                    if os.path.exists(s_file):
                        try:
                            with open(s_file, 'r', encoding='utf-8') as f:
                                schemas_data.update(json.load(f))
                        except Exception as e:
                            logger.warning(f"Error loading {s_file}: {e}")
    else:
        for t in tokens:
            target_bench_dir = os.path.join(bench_dir, t)
            q_file = os.path.join(target_bench_dir, 'queries.json')
            s_file = os.path.join(target_bench_dir, 'schemas.json')

            if os.path.exists(q_file):
                try:
                    with open(q_file, 'r', encoding='utf-8') as f:
                        queries_data.extend(json.load(f))
                except Exception as e:
                    logger.warning(f"Error loading {q_file}: {e}")
            if os.path.exists(s_file):
                try:
                    with open(s_file, 'r', encoding='utf-8') as f:
                        schemas_data.update(json.load(f))
                except Exception as e:
                    logger.warning(f"Error loading {s_file}: {e}")

    return queries_data, schemas_data


def get_sample_data_path(database_id: str, source: Optional[str] = None, base_dir: str = SCRIPT_DIR) -> Optional[str]:
    """
    Locates sample data SQL file for a given database ID and benchmark source
    strictly inside experiments/benchmarks/<source>/sample_data/.
    Returns None if no sample data exists (e.g. for lasso-bm).
    """
    norm_source = normalize_benchmark_name(source) if source else ""
    if not norm_source or norm_source == "lasso-bm":
        # LASSO test cases do not have sample data; XData skips them
        return None

    bench_sample_dir = os.path.join(base_dir, 'benchmarks', norm_source, 'sample_data')
    if os.path.exists(bench_sample_dir):
        for cand in [
            os.path.join(bench_sample_dir, f"{database_id}.sql"),
            os.path.join(bench_sample_dir, f"{norm_source}.sql"),
            os.path.join(bench_sample_dir, "sample_data.sql"),
            os.path.join(bench_sample_dir, "SampleData.sql")
        ]:
            if os.path.exists(cand):
                return cand

        # Known schema alias mappings within the benchmark sample_data folder
        if norm_source == "xdata":
            for cand_name in ["xdata_bm.sql", "university.sql", "xdata.sql"]:
                cand = os.path.join(bench_sample_dir, cand_name)
                if os.path.exists(cand):
                    return cand

    return None
