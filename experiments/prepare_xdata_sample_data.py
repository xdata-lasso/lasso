import os
import sys
import sqlite3
import json
import re

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
def get_original_path(rel_path: str) -> str:
    cand = os.path.join(SCRIPT_DIR, 'originals', rel_path)
    if os.path.exists(cand):
        return cand
    return os.path.join(SCRIPT_DIR, rel_path)

SAMPLE_DATA_DIR = os.path.join(get_original_path('XData-DataGen'), 'sample_data')
os.makedirs(SAMPLE_DATA_DIR, exist_ok=True)

BIRD_DB_DIR = os.path.join(get_original_path('bird_dev'), 'dev_20240627', 'dev_databases')
XDATA_TEST_DIR = os.path.join(get_original_path('XData-DataGen'), 'XData', 'test')

def format_sql_value(val):
    if val is None:
        return 'NULL'
    if isinstance(val, bool):
        return 'TRUE' if val else 'FALSE'
    if isinstance(val, (int, float)):
        return str(val)
    # String or bytes
    s = str(val)
    escaped = s.replace("'", "''")
    return f"'{escaped}'"

def extract_bird_sample_data():
    """
    Extracts representative rows from each table in each BIRD sqlite database,
    ensuring foreign key consistency and topological ordering of inserts.
    """
    if not os.path.exists(BIRD_DB_DIR):
        print(f"BIRD db dir not found: {BIRD_DB_DIR}")
        return {}

    extracted = {}
    db_dirs = [d for d in os.listdir(BIRD_DB_DIR) if os.path.isdir(os.path.join(BIRD_DB_DIR, d))]
    
    for db_id in sorted(db_dirs):
        sqlite_file = os.path.join(BIRD_DB_DIR, db_id, f"{db_id}.sqlite")
        if not os.path.exists(sqlite_file):
            continue

        output_sql_path = os.path.join(SAMPLE_DATA_DIR, f"{db_id}.sql")
        statements = []

        try:
            conn = sqlite3.connect(sqlite_file)
            cursor = conn.cursor()
            cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
            tables = [row[0] for row in cursor.fetchall()]

            # Determine FK dependencies
            deps = {}
            fk_info = {}
            for tbl in tables:
                cursor.execute(f'PRAGMA foreign_key_list("{tbl}");')
                fks = cursor.fetchall()
                deps[tbl] = set()
                fk_info[tbl] = []
                for fk in fks:
                    ptbl = fk[2]
                    from_col = fk[3]
                    to_col = fk[4]
                    deps[tbl].add(ptbl)
                    fk_info[tbl].append((from_col, ptbl, to_col))

            # Topo sort: parent tables first with cycle protection
            ordered = []
            visited = set()
            visiting = set()
            def visit(t):
                if t in visiting:
                    return # cycle broken
                if t not in visited:
                    visiting.add(t)
                    for p in deps.get(t, []):
                        if p in tables:
                            visit(p)
                    visiting.remove(t)
                    visited.add(t)
                    ordered.append(t)

            for t in tables:
                visit(t)

            # Query rows with FK consistency
            collected_pks = {}
            for tbl in ordered:
                cursor.execute(f'PRAGMA table_info("{tbl}");')
                col_records = cursor.fetchall()
                col_names = [col[1].lower() for col in col_records]
                pk_indices = [idx for idx, col in enumerate(col_records) if col[5] > 0]
                if not col_names:
                    continue

                cols_quoted = ", ".join(f'"{c}"' for c in col_names)
                tbl_lower = tbl.lower()
                
                # Check if we should filter by foreign keys
                fks = fk_info.get(tbl, [])
                where_clauses = []
                for from_col, ptbl, to_col in fks:
                    if ptbl in collected_pks and collected_pks[ptbl]:
                        valid_vals = list(collected_pks[ptbl])[:50]
                        val_list = [format_sql_value(v) for v in valid_vals]
                        if val_list:
                            where_clauses.append(f'"{from_col.lower()}" IN ({", ".join(val_list)})')

                where_sql = ""
                if where_clauses:
                    where_sql = " WHERE " + " AND ".join(where_clauses)

                cursor.execute(f'SELECT * FROM "{tbl}"{where_sql} LIMIT 20;')
                rows = cursor.fetchall()

                # If FK filter returned 0 rows, fall back to plain limit
                if not rows:
                    cursor.execute(f'SELECT * FROM "{tbl}" LIMIT 20;')
                    rows = cursor.fetchall()

                # Record primary keys for child tables
                collected_pks[tbl] = set()
                for row in rows:
                    for pk_idx in pk_indices:
                        if pk_idx < len(row):
                            collected_pks[tbl].add(row[pk_idx])

                    vals_str = ", ".join(format_sql_value(v) for v in row)
                    statements.append(f'INSERT INTO "{tbl_lower}" ({cols_quoted}) VALUES ({vals_str});')

            conn.close()

            if statements:
                with open(output_sql_path, "w", encoding="utf-8") as f:
                    f.write("\n".join(statements) + "\n")
                extracted[db_id] = output_sql_path
                print(f"[BIRD] Extracted FK-consistent sample data for {db_id} ({len(statements)} inserts)")
        except Exception as e:
            print(f"[BIRD] Error extracting {db_id}: {e}")

    return extracted

def extract_calcite_sample_data():
    calcite_sample_src = os.path.join(XDATA_TEST_DIR, 'Calcite', 'sample', 'calcite.sql')
    if os.path.exists(calcite_sample_src):
        output_path = os.path.join(SAMPLE_DATA_DIR, 'calcite.sql')
        with open(calcite_sample_src, 'r', encoding='utf-8') as sf, open(output_path, 'w', encoding='utf-8') as df:
            df.write(sf.read())
        print(f"[Calcite] Copied sample data to {output_path}")
        return {'calcite': output_path}
    return {}

def extract_xdata_sample_data():
    xdata_sample_src = os.path.join(XDATA_TEST_DIR, 'universityTest', 'sampleData.sql')
    if os.path.exists(xdata_sample_src):
        with open(xdata_sample_src, 'r', encoding='utf-8') as sf:
            content = sf.read()
        for name in ['university.sql', 'xdata_bm.sql', 'xdata.sql']:
            out = os.path.join(SAMPLE_DATA_DIR, name)
            with open(out, 'w', encoding='utf-8') as df:
                df.write(content)
        print(f"[XData] Copied sample data to xdata_bm.sql, xdata.sql, university.sql")
        return {'university': os.path.join(SAMPLE_DATA_DIR, 'university.sql'), 'xdata_bm': os.path.join(SAMPLE_DATA_DIR, 'xdata_bm.sql')}
    return {}

def extract_tpch_sample_data():
    tpch_sample_src = get_original_path('xdatapublic/benchmarks/TPCH/SampleData.sql')
    if os.path.exists(tpch_sample_src):
        output_path = os.path.join(SAMPLE_DATA_DIR, 'tpch.sql')
        with open(tpch_sample_src, 'r', encoding='utf-8') as sf, open(output_path, 'w', encoding='utf-8') as df:
            df.write(sf.read())
        print(f"[TPCH] Copied sample data to {output_path}")
        return {'tpch': output_path}
    return {}

def extract_largejoin_sample_data():
    largejoin_sample_src = get_original_path('xdatapublic/benchmarks/LargeJoin/SampleData.sql')
    if os.path.exists(largejoin_sample_src):
        output_path = os.path.join(SAMPLE_DATA_DIR, 'largejoin.sql')
        with open(largejoin_sample_src, 'r', encoding='utf-8') as sf, open(output_path, 'w', encoding='utf-8') as df:
            df.write(sf.read())
        print(f"[LargeJoin] Copied sample data to {output_path}")
        return {'largejoin': output_path}
    return {}

def main():
    print("Preparing XData sample data (calcite, xdata, tpch, largejoin)...")
    calcite_samples = extract_calcite_sample_data()
    xdata_samples = extract_xdata_sample_data()
    tpch_samples = extract_tpch_sample_data()
    largejoin_samples = extract_largejoin_sample_data()

    # Clean up any obsolete default_empty.sql
    default_empty_path = os.path.join(SAMPLE_DATA_DIR, 'default_empty.sql')
    if os.path.exists(default_empty_path):
        try:
            os.remove(default_empty_path)
        except OSError:
            pass

    manifest = {
        'calcite': list(calcite_samples.keys()),
        'xdata': list(xdata_samples.keys()),
        'tpch': list(tpch_samples.keys()),
        'largejoin': list(largejoin_samples.keys())
    }

    manifest_path = os.path.join(SAMPLE_DATA_DIR, 'manifest.json')
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2)

    # Sync to benchmarks/<bench>/sample_data/
    benchmarks_dir = os.path.join(SCRIPT_DIR, 'benchmarks')
    if os.path.exists(benchmarks_dir):
        import shutil
        mapping = {
            'calcite': calcite_samples,
            'xdata': xdata_samples,
            'tpch': tpch_samples,
            'largejoin': largejoin_samples
        }
        for bench_name, samples in mapping.items():
            b_sample_dir = os.path.join(benchmarks_dir, bench_name, 'sample_data')
            os.makedirs(b_sample_dir, exist_ok=True)
            for path in samples.values():
                if os.path.exists(path):
                    shutil.copy2(path, os.path.join(b_sample_dir, os.path.basename(path)))

    print(f"Sample data preparation complete. Manifest saved to {manifest_path}")

if __name__ == '__main__':
    main()

