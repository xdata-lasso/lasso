"""
WindowTieAttackStrategy Module

Algorithm for Semantic Test Data Generation:
1. Target: Window function ranking semantics (e.g. ROW_NUMBER vs RANK vs DENSE_RANK, and window
   ORDER BY ranking vs MIN/MAX GROUP BY aggregation under NULLs).
2. Applicability: Query contains window functions with ORDER BY specifications.
3. Dataset Generation:
   - Construct two row groups (`group_a` and `group_b`) that belong to the exact same partition.
   - Force all `ORDER BY` columns in both groups to have identical values (creating a tie). When
     the partition and order columns together span a composite PRIMARY KEY or UNIQUE constraint
     whose order column is nullable in SQLite, both rows set the order column to NULL to form a
     valid tie in SQLite.
   - Additionally, when an `ORDER BY` column is nullable (including SQLite-nullable composite
     PRIMARY KEY columns), generate a dataset pairing a NULL order value and a non-NULL order
     value in the same partition to expose NULL-first ordering vs MIN/MAX aggregate semantics.
"""

from typing import Any, Dict, List
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column, merge_datasets


class WindowTieAttackStrategy(AttackStrategy):
    """
    Target semantic bug: ROW_NUMBER vs RANK vs DENSE_RANK substitutions and window ORDER BY
    NULL placement vs aggregate MIN/MAX in window functions.

    Generates two rows within the exact same window partition having identical
    ORDER BY sorting values (a tie), as well as a mixed NULL / non-NULL pair in the
    same partition when the ORDER BY column is nullable under SQLite semantics.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._windows(schema, parsed_query))

    def _can_null_column(self, schema: Schema, table_name: str, column: Any) -> bool:
        if not column or getattr(column, "explicit_not_null", False):
            return False
        table = next((t for t_name, t in schema.tables.items() if t_name.upper() == table_name.upper()), None)
        if not table:
            return False
        pk_cols = [c for c in table.columns if c.is_primary_key]
        if column.is_primary_key and len(pk_cols) == 1:
            return False
        if not column.is_nullable and not (column.is_primary_key and len(pk_cols) > 1):
            return False
        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table.name.upper() and fk.reference_column.upper() == column.name.upper():
                    return False
        return True

    def _windows(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[dict[str, Any]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        windows = []
        for window in ast.find_all(exp.Window):
            partitions = []
            for expr in window.args.get("partition_by") or []:
                if isinstance(expr, exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, expr.table, expr.name)
                    if resolved:
                        partitions.append(resolved)
            order_bys = []
            order_spec = window.args.get("order")
            if order_spec:
                for expr in order_spec.find_all(exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, expr.table, expr.name)
                    if resolved:
                        order_bys.append(resolved)
            if order_bys:
                windows.append({"partition_by": partitions, "order_by": order_bys, "function": window.this})
        return windows

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        for window_index, window in enumerate(self._windows(schema, parsed_query)):
            tie_group_a = generate_base_dataset(schema, parsed_query, cache_key_salt="win_tie_a")
            tie_group_b = generate_base_dataset(schema, parsed_query, cache_key_salt="win_tie_b")

            for table_name, column_name in window["partition_by"]:
                g1a_key = next((k for k in tie_group_a if k.upper() == table_name.upper()), None)
                g1b_key = next((k for k in tie_group_b if k.upper() == table_name.upper()), None)
                if g1a_key and g1b_key and tie_group_a[g1a_key] and tie_group_b[g1b_key]:
                    val = tie_group_a[g1a_key][0][column_name]
                    tie_group_b[g1b_key][0][column_name] = val
                    for child_t_name, child_t in schema.tables.items():
                        for fk in child_t.foreign_keys:
                            if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                                child_g1b_key = next((k for k in tie_group_b if k.upper() == child_t_name.upper()), None)
                                if child_g1b_key and tie_group_b[child_g1b_key]:
                                    for r in tie_group_b[child_g1b_key]:
                                        r[fk.column_name] = val

            null_order_groups = None
            for table_name, column_name in window.get("order_by", []):
                t_obj = next((t for t_name, t in schema.tables.items() if t_name.upper() == table_name.upper()), None)
                c_obj = next((c for c in t_obj.columns if c.name.upper() == column_name.upper()), None) if t_obj else None
                g1a_key = next((k for k in tie_group_a if k.upper() == table_name.upper()), None)
                g1b_key = next((k for k in tie_group_b if k.upper() == table_name.upper()), None)
                if not (g1a_key and g1b_key and tie_group_a[g1a_key] and tie_group_b[g1b_key]):
                    continue

                if c_obj and self._can_null_column(schema, table_name, c_obj) and null_order_groups is None:
                    ng_a = copy.deepcopy(tie_group_a)
                    ng_b = copy.deepcopy(tie_group_b)
                    ng_b[g1b_key][0][column_name] = None
                    null_order_groups = (ng_a, ng_b, table_name, column_name)

                if c_obj and (c_obj.is_primary_key or c_obj.is_unique):
                    pk_cols = [c for c in t_obj.columns if c.is_primary_key] if t_obj else []
                    tied_in_table = {
                        c_name.upper()
                        for t_n, c_name in (window.get("partition_by", []) + window.get("order_by", []))
                        if t_n.upper() == table_name.upper()
                    }
                    all_pk_fixed = bool(pk_cols) and all(pk.name.upper() in tied_in_table for pk in pk_cols)
                    if not c_obj.is_unique and len(pk_cols) > 1 and not all_pk_fixed:
                        tie_group_b[g1b_key][0][column_name] = tie_group_a[g1a_key][0][column_name]
                    elif self._can_null_column(schema, table_name, c_obj):
                        tie_group_a[g1a_key][0][column_name] = None
                        tie_group_b[g1b_key][0][column_name] = None
                    continue

                tie_group_b[g1b_key][0][column_name] = tie_group_a[g1a_key][0][column_name]

            tie_data = merge_datasets(schema, tie_group_a, tie_group_b)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{window_index}",
                    data=tie_data,
                    tags=["window_tie_attack"],
                    description="Targets ROW_NUMBER vs RANK vs DENSE_RANK window function bugs. Dataset generates two rows in the exact same partition with identical ORDER BY sorting values (a tie). ROW_NUMBER will assign sequential numbers (1, 2) whereas RANK will assign identical rank numbers (1, 1), exposing function substitution errors."
                )
            )

            if null_order_groups is not None:
                ng_a, ng_b, ord_t, ord_c = null_order_groups
                null_order_data = merge_datasets(schema, ng_a, ng_b)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_null_order_{window_index}",
                        data=null_order_data,
                        tags=["window_tie_attack", "null_attack"],
                        description=f"Targets window ORDER BY NULL placement vs aggregate MIN/MAX bugs on `{ord_t}.{ord_c}`. Dataset places one NULL and one non-NULL value for `{ord_t}.{ord_c}` within the same window partition."
                    )
                )

        return datasets
