"""
Dataset Generation Package
============================

Public API for the equivalence-class-driven test data generator.
All symbols are re-exported from the internal modules so that
consumers can continue to use ``from dataset_generator import X``.

Internal module structure:
  types.py         — Data structures (UnionFind, ColumnSpec, col_key)
  equivalence.py   — Phase 0: Equivalence class construction
  constraints.py   — Phase 1: Constraint collection into ColumnSpecs
  resolver.py      — Phase 2: Value resolution (column-centric)
  row_assembly.py  — Phase 3: Row assembly
  augmentation.py  — Phase 4: Unmatched row augmentation
  pipeline.py      — Orchestrator: generate_base_dataset, caching
  uniqueness.py    — Safety net: PK/UNIQUE enforcement, merge_datasets, deduplicate_dataset
  utils.py         — General helpers: resolve_query_column, find_column_equivalence_roots
"""

# ── Data structures (types.py) ──
from dataset_generator.types import (
    UnionFind,
    ColumnSpec,
    SymbolTable,
    col_key,
)

# ── Phase 0: Equivalence (equivalence.py) ──
from dataset_generator.equivalence import (
    build_equivalence_classes,
)

# ── Phase 1: Constraint collection & Cardinality analysis (constraints.py) ──
from dataset_generator.constraints import (
    analyze_constraints_and_cardinality,
    build_column_specs,
    extract_not_in_roots,
    get_singleton_having_group_cols,
)

# ── Phase 2: Value resolution (resolver.py) ──
from dataset_generator.resolver import (
    resolve_values,
)

# ── Phase 3: Row assembly (row_assembly.py) ──
from dataset_generator.row_assembly import (
    materialize_rows,
)

# ── Phase 4: Augmentation (augmentation.py) ──
from dataset_generator.augmentation import (
    add_unmatched_rows,
)

# ── Pipeline orchestrator (pipeline.py) ──
from dataset_generator.pipeline import (
    generate_base_dataset,
    clear_dataset_cache,
    memoize_dataset,
)

# ── Safety net & uniqueness post-processing (uniqueness.py) ──
from dataset_generator.uniqueness import (
    merge_datasets,
    merge_with_shifted_companion,
    deduplicate_dataset,
    ensure_dataset_uniqueness,
)

# ── Utilities (utils.py) ──
from dataset_generator.utils import (
    build_alias_to_table,
    compute_additive_sum_values,
    compute_self_offset_values,
    compute_temporal_diff_values,
    differentiate_conditional_aggregates_across_groups,
    extract_additive_sum_patterns,
    extract_self_offset_patterns,
    extract_temporal_diff_patterns,
    find_column_equivalence_roots,
    resolve_query_column,
    next_distinct_value,
    next_distinct_query_value,
)

# ── Backward-compatible aliases ──
# These names were used in older versions and may still be referenced.
_uf_key = col_key
_find_schema_table = lambda schema, name: schema.find_table(name)
_find_schema_column = lambda schema, table_name, col_name: schema.find_column(table_name, col_name)
extract_constraints = build_column_specs
deduplicate_mock_data = deduplicate_dataset

__all__ = [
    # Data structures
    "UnionFind", "ColumnSpec", "SymbolTable", "col_key", "_uf_key",
    # Phase 0
    "build_equivalence_classes",
    # Phase 1
    "analyze_constraints_and_cardinality", "build_column_specs", "extract_constraints", "extract_not_in_roots",
    "get_singleton_having_group_cols",
    # Phase 2
    "resolve_values",
    # Phase 3 & 4
    "materialize_rows", "add_unmatched_rows",
    # Pipeline & Post-processing
    "generate_base_dataset",
    "merge_datasets", "merge_with_shifted_companion", "deduplicate_dataset", "ensure_dataset_uniqueness", "deduplicate_mock_data",
    "clear_dataset_cache", "memoize_dataset",
    # Utilities
    "build_alias_to_table", "compute_additive_sum_values", "compute_self_offset_values", "compute_temporal_diff_values",
    "differentiate_conditional_aggregates_across_groups",
    "extract_additive_sum_patterns", "extract_self_offset_patterns", "extract_temporal_diff_patterns",
    "find_column_equivalence_roots", "resolve_query_column", "next_distinct_value", "next_distinct_query_value",
    # Backward-compat
    "_find_schema_table", "_find_schema_column",
]
