# Experiments: Originals

This directory isolates the raw original benchmark assets, external repository clones, and third-party baseline tool code bases so that the main `experiments/` and `experiments/non-empty-dg/` workspaces remain clean, organized, and focused on evaluation scripts and results.

---

## Directory Contents

### 1. Original Datasets & Benchmarks
- **`beaver_data/`**: Git repository clone of [`beaverbench/beaver-table`](https://huggingface.co/datasets/beaverbench/beaver-table) with raw Parquet files for BeaverBench schemas (`dw`, `nova`, `neutron`).
- **`beaver_tests/`**: Original BeaverBench schema definitions, SQL queries, and sample data.
- **`bird_dev/`**: Original BIRD benchmark dev database SQLite files and queries.
- **`tpch_tests/`**: Standard TPC-H schema definition and reference SQL queries (`q01.sql` - `q22.sql`).
- **`materialized_datasets/`**: Materialized SQLite database instances for BIRD benchmark domains.
- **`ManyRowsBM/`**: High-cardinality benchmark suite (`schema.sql`, `queries.json`) targeting queries requiring 10 to 10,000+ rows to achieve non-empty results across low, medium, and high complexity.

### 2. Baseline Tool Source Code
- **`ParSEval/`**: Source repository for the ParSEval test data generator baseline.
- **`SpotIt-plus/`**: Source repository for the SpotIt+ / VeriEQL equivalence checker baseline.
- **`XData-DataGen/`**: Source repository for the internal XData test data generation engine.
- **`xdatapublic/`**: Source repository for the public XData GitHub distribution.
- **`polygon-artifact-evaluation-extracted/`**: Source repository and artifact benchmarks for Polygon.
- **`SQLWitness/`**: Source repository for the SQLWitness rule-based counterexample search engine.

### 3. Tool Virtual Environments
- **`.parseval_venv/`**: Python virtual environment configured for ParSEval dependencies.
- **`.spotit_venv/`**: Python virtual environment configured for SpotIt+ dependencies.
- **`.polygon_venv/`**: Python virtual environment configured for Polygon dependencies.
- **`.xdata_venv/`**: Python virtual environment configured for XData execution.
- **`.sqlwitness_venv/`**: Python virtual environment configured for SQLWitness execution.
