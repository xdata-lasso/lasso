"""
GroupByAttackStrategy Module

Target semantic bug: Wrong GROUP BY grouping columns, missing GROUP BY terms, or
erroneous scalar combination of multiple GROUP BY keys (e.g. `GROUP BY a || b`).
Algorithm & Dataset Design:
Populates multi-group datasets with non-trivial key combinations across GROUP BY terms,
including prefix key sharing, partial-NULL grouping keys, and boundary-shift concatenation
collisions. Ensures that altering or collapsing GROUP BY columns changes the row grouping,
tuple count, and aggregate results.
"""

from typing import Any, Dict, List, Optional, Set, Tuple
import copy
import re

import sqlglot
import sqlglot.expressions as exp

from models import Column, Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import can_null_column_for_duplicate
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    differentiate_conditional_aggregates_across_groups,
    generate_base_dataset,
    next_distinct_query_value,
    next_distinct_value,
    resolve_query_column,
    deduplicate_mock_data,
)
from dataset_generator.utils import is_unique_column_set


class GroupByAttackStrategy(AttackStrategy):
    """
    Target semantic bug: Missing, extra, or modified GROUP BY clause (including
    scalar-combined grouping expressions such as `GROUP BY k1 || k2`).

    Algorithm & Dataset Design:
    1. Grouped Aggregation Queries (has GROUP BY clause):
       - Dataset 1a (Prefix GROUP BY keys): For each prefix length L of GROUP BY keys,
         injects two groups sharing the first L keys while ensuring distinct values for
         trailing keys (L+1..m). For L = m, both rows share all GROUP BY keys so a correct
         query aggregates them into 1 group while a mutant missing GROUP BY returns 2 rows.
       - Dataset 1b (Partial-NULL GROUP BY key): When m >= 2 and a grouping column k_i is
         nullable (and not filtered by WHERE/JOIN predicates), injects NULL for k_i in
         both groups while forcing distinct non-NULL values on the remaining grouping keys.
         Tuple grouping `GROUP BY k1, k2` keeps `(NULL, v1)` and `(NULL, v2)` as 2 distinct
         groups, whereas null-propagating expressions (`GROUP BY k1 || k2`, `GROUP BY k1 + k2`)
         or single-key `GROUP BY k_i` collapse both rows into a single NULL group.
       - Dataset 1c (Boundary-Shift Concatenation Collision): When m >= 2, constructs two
         non-NULL groups `(a1, b1)` and `(a2, b2)` for adjacent grouping keys `(k1, k2)` by
         shifting a boundary character between `k1` and `k2` so that `(a1, b1) != (a2, b2)`
         (producing 2 groups under `GROUP BY k1, k2`) while `CAST(a1 AS TEXT) || CAST(b1 AS TEXT)`
         equals `CAST(a2 AS TEXT) || CAST(b2 AS TEXT)` (collapsing to 1 group under
         `GROUP BY k1 || k2` or `GROUP BY COALESCE(k1, '') || COALESCE(k2, '')`).
       - Dataset 2 (Empty Dataset): Generates a 0-row dataset across all tables. A grouped
         aggregate query evaluates to 0 groups and returns 0 rows, whereas a scalar aggregate
         mutant (missing GROUP BY) evaluates over the empty relation and returns 1 row of
         NULL/default values.

    2. Scalar Aggregation Queries (has aggregate functions, but NO GROUP BY clause):
       - Dataset 1 (Empty Dataset): Generates a 0-row dataset across all tables. A correct
         scalar aggregate query returns 1 row with NULL/default values, whereas a mutant
         that erroneously adds a GROUP BY clause evaluates to 0 groups and returns 0 rows.
       - Dataset 2 (Multi-Group Dataset): Injects multiple rows with distinct non-aggregated
         column values. The correct scalar aggregate query aggregates all rows globally into 1 row,
         whereas a mutant adding a GROUP BY splits them into multiple group rows.
    """

    def _has_aggregates(self, parsed_query: Dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
            return bool(list(ast.find_all(exp.AggFunc)))
        except Exception:
            return False

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        has_gb = bool(self._targets(schema, parsed_query)) or bool(parsed_query.get("has_group_by"))
        has_agg = self._has_aggregates(parsed_query)
        return has_gb or has_agg

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[tuple[str, str]]:
        targets = []
        for term in parsed_query.get("group_by", []):
            resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
            if resolved and resolved not in targets:
                targets.append(resolved)

        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or (sqlglot.parse_one(raw_query) if raw_query else None)
            if ast:
                for group in ast.find_all(exp.Group):
                    for expr in group.expressions:
                        for col in expr.find_all(exp.Column):
                            resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                            if resolved and resolved not in targets:
                                targets.append(resolved)
        except Exception:
            pass

        return targets

    def _set_equiv_value(
        self,
        schema: Schema,
        equiv: Any,
        dataset: Dict[str, List[Dict[str, Any]]],
        table_name: str,
        column_name: str,
        new_val: Any,
    ) -> None:
        target_root = equiv.find(col_key(table_name, column_name))
        for t_name, rows in dataset.items():
            if not rows or t_name not in schema.tables:
                continue
            for col in schema.tables[t_name].columns:
                if equiv.find(col_key(t_name, col.name)) == target_root:
                    for r in rows:
                        r[col.name] = new_val

    def _get_constrained_columns(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> Tuple[Set[Tuple[str, str]], Set[Tuple[str, str]]]:
        """
        Return `(where_locked_cols, null_unsafe_cols)`:
        - `where_locked_cols`: columns referenced in WHERE/HAVING value literals.
        - `null_unsafe_cols`: columns referenced in non-NULL WHERE/HAVING literals or
          inner join conditions where injecting NULL would filter out the row.
        """
        where_locked: Set[Tuple[str, str]] = set()
        null_unsafe: Set[Tuple[str, str]] = set()

        for lit in parsed_query.get("where_literals", []):
            col_name = lit.get("column", "")
            if not col_name:
                continue
            resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), col_name)
            if not resolved:
                continue
            op_up = (lit.get("operator") or "EQ").upper()
            if (
                lit.get("substr_start") is None
                and not lit.get("strftime_format")
                and not (lit.get("value") == "NULL" and op_up in ("IS NOT", "IS NOT NULL", "NEQ"))
            ):
                where_locked.add(resolved)
            if lit.get("value") != "NULL" or op_up not in ("IS", "IS NULL", "EQ"):
                null_unsafe.add(resolved)

        for pair in parsed_query.get("where_joins", []):
            for side in ("left", "right"):
                s = pair.get(side, {})
                res = resolve_query_column(schema, parsed_query, s.get("table", ""), s.get("column", ""))
                if res:
                    null_unsafe.add(res)

        for join in parsed_query.get("joins", []):
            j_type = (join.get("type") or "INNER").upper()
            if not any(k in j_type for k in ("LEFT", "RIGHT", "FULL")):
                for pair in join.get("on_pairs", []):
                    for side in ("left", "right"):
                        s = pair.get(side, {})
                        res = resolve_query_column(schema, parsed_query, s.get("table", ""), s.get("column", ""))
                        if res:
                            null_unsafe.add(res)

        return where_locked, null_unsafe

    def _coerce_concat_part(self, col: Column, s: str) -> Any:
        if not s:
            return None
        dt = (col.data_type or "").lower()
        if col.is_text:
            match = re.search(r"(?:(?:var)?char|character\s+varying|text)\s*\((\d+)\)", dt)
            if match and len(s) > int(match.group(1)):
                return None
            return s
        if col.is_temporal:
            # SQLite DATE/DATETIME columns have NUMERIC affinity; strings that are not
            # pure numeric literals (e.g. '1970-01-0') are stored verbatim as TEXT.
            if not s.lstrip("-").replace(".", "", 1).isdigit():
                return s
            return None
        if any(k in dt for k in ("int", "serial", "year")):
            if s.lstrip("-").isdigit():
                try:
                    val = int(s)
                    if str(val) == s:
                        return val
                except ValueError:
                    return None
        if any(k in dt for k in ("real", "floa", "doub", "num", "dec")):
            if "." in s and s.lstrip("-").replace(".", "", 1).isdigit():
                try:
                    val = float(s)
                    if str(val) == s:
                        return val
                except ValueError:
                    return None
        return None

    def _build_concat_collision_pair(
        self, col1: Column, v1: Any, col2: Column, v2: Any
    ) -> Optional[Tuple[Any, Any, Any, Any]]:
        """
        Given base values `(v1, v2)` for `(col1, col2)`, construct two distinct pairs
        `(a1, b1)` and `(a2, b2)` with `a1 != a2` and `b1 != b2` such that their SQLite
        string concatenations `str(a1) + str(b1)` and `str(a2) + str(b2)` are identical.
        """
        if v1 is None or v2 is None:
            return None
        s1, s2 = str(v1), str(v2)
        if not s1 or not s2:
            return None

        # 1. Suffix-to-prefix shift: move last char of s1 to start of s2
        if len(s1) >= 2:
            ch = s1[-1]
            cand_a2 = self._coerce_concat_part(col1, s1[:-1])
            cand_b2 = self._coerce_concat_part(col2, ch + s2)
            if (
                cand_a2 is not None
                and cand_b2 is not None
                and cand_a2 != v1
                and cand_b2 != v2
                and str(v1) + str(v2) == str(cand_a2) + str(cand_b2)
            ):
                return (v1, v2, cand_a2, cand_b2)

        # 2. Prefix-to-suffix shift: move first char of s2 to end of s1
        if len(s2) >= 2:
            ch = s2[0]
            cand_a2 = self._coerce_concat_part(col1, s1 + ch)
            cand_b2 = self._coerce_concat_part(col2, s2[1:])
            if (
                cand_a2 is not None
                and cand_b2 is not None
                and cand_a2 != v1
                and cand_b2 != v2
                and str(v1) + str(v2) == str(cand_a2) + str(cand_b2)
            ):
                return (v1, v2, cand_a2, cand_b2)

        # 3. Universal non-zero digit '1' bridge
        cand_a1 = self._coerce_concat_part(col1, s1 + "1")
        cand_b2 = self._coerce_concat_part(col2, "1" + s2)
        if (
            cand_a1 is not None
            and cand_b2 is not None
            and cand_a1 != v1
            and cand_b2 != v2
            and str(cand_a1) + str(v2) == str(v1) + str(cand_b2)
        ):
            return (cand_a1, v2, v1, cand_b2)

        return None

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        targets = self._targets(schema, parsed_query)
        datasets = []

        if targets:
            equiv, _, _ = build_equivalence_classes(schema, parsed_query)
            where_locked, null_unsafe = self._get_constrained_columns(schema, parsed_query)

            # Case 1a: Prefix key sharing datasets
            # For a prefix of length L, group1 and group2 share identical values for the first L keys,
            # but have distinct values for key L+1..m. This ensures that a mutant grouping by fewer keys
            # collapses the rows into fewer groups than the correct query.
            for prefix_len in range(1, len(targets) + 1):
                prefix_targets = targets[:prefix_len]
                group1 = generate_base_dataset(schema, parsed_query, cache_key_salt=f"gb_{prefix_len}_1")
                
                value_injections = {}
                valid = True
                by_table: Dict[str, List[str]] = {}
                for table_name, column_name in prefix_targets:
                    if not group1.get(table_name) or not group1[table_name]:
                        valid = False
                        break
                    val = group1[table_name][0][column_name]
                    value_injections[(table_name, column_name)] = val
                    by_table.setdefault(table_name, []).append(column_name)

                if valid:
                    for t_name, t_cols in by_table.items():
                        if is_unique_column_set(schema, t_name, t_cols) and group1.get(t_name):
                            for col_k, col_v in group1[t_name][0].items():
                                value_injections.setdefault((t_name, col_k), col_v)
                    group2 = generate_base_dataset(schema, parsed_query, value_injections=value_injections, cache_key_salt=f"gb_{prefix_len}_2")

                    # Ensure trailing GROUP BY keys (outside prefix_targets) have distinct values in group2
                    for rem_t, rem_c in targets[prefix_len:]:
                        if (rem_t, rem_c) in where_locked:
                            continue
                        if group1.get(rem_t) and group2.get(rem_t):
                            v1 = group1[rem_t][0].get(rem_c)
                            v2 = group2[rem_t][0].get(rem_c)
                            if v1 is not None and v2 == v1:
                                rem_col = schema.find_column(rem_t, rem_c)
                                if rem_col:
                                    new_val = next_distinct_query_value(schema, parsed_query, rem_t, rem_col, v1)
                                    self._set_equiv_value(schema, equiv, group2, rem_t, rem_c, new_val)

                    differentiate_conditional_aggregates_across_groups(
                        schema, parsed_query, equiv, set(targets), group1, group2, extra_locked=where_locked
                    )

                    merged_data = {t_name: [] for t_name in schema.tables}
                    for g in [group1, group2]:
                        for t_name in merged_data:
                            if t_name in g:
                                merged_data[t_name].extend(copy.deepcopy(g[t_name]))

                    merged_data = deduplicate_mock_data(schema, merged_data)

                    if prefix_len == len(targets) and not self._has_aggregates(parsed_query):
                        for t_name, t_cols in by_table.items():
                            if len(t_cols) >= 2 and is_unique_column_set(schema, t_name, t_cols) and merged_data.get(t_name):
                                null_c = next(
                                    (
                                        c_name
                                        for c_name in reversed(t_cols)
                                        if can_null_column_for_duplicate(
                                            schema, parsed_query, t_name, c_name, allow_in_group_by=True
                                        )
                                    ),
                                    None,
                                )
                                if null_c is not None:
                                    base_r = merged_data[t_name][0]
                                    dup_r1 = copy.deepcopy(base_r)
                                    dup_r1[null_c] = None
                                    dup_r2 = copy.deepcopy(base_r)
                                    dup_r2[null_c] = None
                                    merged_data[t_name].extend([dup_r1, dup_r2])

                    target_str = "_".join([f"{t[0]}.{t[1]}" for t in prefix_targets])
                    
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{target_str}",
                            data=merged_data,
                            tags=["group_by_attack"],
                            description=f"Targets GROUP BY bugs. Dataset contains multiple rows that share identical values for the GROUP BY key prefix: {target_str}. A query with the full GROUP BY will produce separate groups for distinct trailing keys, whereas a mutant grouping by only the prefix keys will collapse them into a single group."
                        )
                    )

            # Case 1b: Partial-NULL grouping key datasets (for multi-column GROUP BY)
            if len(targets) >= 2:
                for table_name, column_name in targets:
                    if (table_name, column_name) in null_unsafe:
                        continue
                    col_obj = schema.find_column(table_name, column_name)
                    if not col_obj or col_obj.is_primary_key or not col_obj.is_nullable:
                        continue

                    group1 = generate_base_dataset(
                        schema,
                        parsed_query,
                        null_injections=[(table_name, column_name)],
                        cache_key_salt=f"gb_null_{table_name}_{column_name}_1",
                    )
                    group2 = generate_base_dataset(
                        schema,
                        parsed_query,
                        null_injections=[(table_name, column_name)],
                        cache_key_salt=f"gb_null_{table_name}_{column_name}_2",
                    )

                    for other_t, other_c in targets:
                        if (other_t, other_c) == (table_name, column_name) or (other_t, other_c) in where_locked:
                            continue
                        if group1.get(other_t) and group2.get(other_t):
                            v1 = group1[other_t][0].get(other_c)
                            v2 = group2[other_t][0].get(other_c)
                            if v1 is not None and v2 == v1:
                                other_col = schema.find_column(other_t, other_c)
                                if other_col:
                                    new_val = next_distinct_query_value(schema, parsed_query, other_t, other_col, v1)
                                    self._set_equiv_value(schema, equiv, group2, other_t, other_c, new_val)

                    merged_data = {t_name: [] for t_name in schema.tables}
                    for g in [group1, group2]:
                        for t_name in merged_data:
                            if t_name in g:
                                merged_data[t_name].extend(copy.deepcopy(g[t_name]))

                    merged_data = deduplicate_mock_data(schema, merged_data)

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_partial_null_{table_name}.{column_name}",
                            data=merged_data,
                            tags=["group_by_attack", "null_attack"],
                            description=(
                                f"Targets GROUP BY expression and partial-NULL key bugs. Injects NULL for "
                                f"`{table_name}.{column_name}` across two rows while assigning distinct non-NULL "
                                f"values to the remaining GROUP BY keys. Standard tuple grouping keeps the two "
                                f"rows in separate groups, whereas null-propagating expressions (e.g. `k1 || k2`) "
                                f"collapse both rows into a single NULL group."
                            ),
                        )
                    )

            # Case 1c: Boundary-shift concatenation collision datasets (for multi-column GROUP BY)
            if len(targets) >= 2:
                for (t1, c1), (t2, c2) in zip(targets, targets[1:]):
                    if (t1, c1) in where_locked or (t2, c2) in where_locked:
                        continue
                    if equiv.find(col_key(t1, c1)) == equiv.find(col_key(t2, c2)):
                        continue
                    col1 = schema.find_column(t1, c1)
                    col2 = schema.find_column(t2, c2)
                    if not col1 or not col2:
                        continue

                    group1 = generate_base_dataset(
                        schema, parsed_query, cache_key_salt=f"gb_concat_{t1}_{c1}_{t2}_{c2}_1"
                    )
                    if not group1.get(t1) or not group1.get(t2):
                        continue

                    v1 = group1[t1][0].get(c1)
                    v2 = group1[t2][0].get(c2)
                    collision = self._build_concat_collision_pair(col1, v1, col2, v2)
                    if collision is None:
                        continue

                    a1, b1, a2, b2 = collision
                    self._set_equiv_value(schema, equiv, group1, t1, c1, a1)
                    self._set_equiv_value(schema, equiv, group1, t2, c2, b1)
                    if len(group1.get(t1, [])) > 1 and t1 == t2:
                        for extra_row in group1[t1][1:]:
                            extra_row[c1] = a2
                            extra_row[c2] = b2

                    value_injections: Dict[Tuple[str, str], Any] = {(t1, c1): a2, (t2, c2): b2}
                    for tk, ck in targets:
                        if (tk, ck) not in value_injections and group1.get(tk):
                            value_injections[(tk, ck)] = group1[tk][0].get(ck)

                    group2 = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections=value_injections,
                        cache_key_salt=f"gb_concat_{t1}_{c1}_{t2}_{c2}_2",
                    )
                    self._set_equiv_value(schema, equiv, group2, t1, c1, a2)
                    self._set_equiv_value(schema, equiv, group2, t2, c2, b2)

                    merged_data = {t_name: [] for t_name in schema.tables}
                    for g in [group1, group2]:
                        for t_name in merged_data:
                            if t_name in g:
                                merged_data[t_name].extend(copy.deepcopy(g[t_name]))

                    merged_data = deduplicate_mock_data(schema, merged_data)

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_concat_collision_{t1}.{c1}_{t2}.{c2}",
                            data=merged_data,
                            tags=["group_by_attack"],
                            description=(
                                f"Targets GROUP BY concatenation bugs (`GROUP BY {c1} || {c2}`). Shifts a boundary "
                                f"character between `{t1}.{c1}` and `{t2}.{c2}` across two rows so that "
                                f"`({c1}, {c2})` are distinct tuples (2 groups) while their string concatenations "
                                f"`{c1} || {c2}` are identical (collapsing into 1 group)."
                            ),
                        )
                    )

            # Dataset 2: Empty dataset for Grouped Aggregation query
            empty_data = {t_name: [] for t_name in schema.tables}
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_empty_dataset",
                    data=empty_data,
                    tags=["group_by_attack"],
                    description="Targets GROUP BY bugs. Dataset contains zero rows (empty dataset). A query with a GROUP BY clause over an empty relation returns 0 rows, whereas a scalar aggregate mutant (missing GROUP BY) returns 1 row of NULL/default values."
                )
            )

            # Dataset 3: Multi-group LIMIT/OFFSET cardinality dataset
            limit_val = parsed_query.get("limit_val") or 0
            offset_val = parsed_query.get("offset_val") or 0
            if not parsed_query.get("has_having") and (limit_val > 1 or offset_val >= 1):
                num_groups = min(max(int(limit_val) + int(offset_val) + 1, 4), 8)
                limit_merged_data: Dict[str, List[Dict[str, Any]]] = {t_name: [] for t_name in schema.tables}
                seen_group_tuples: Set[Tuple[Any, ...]] = set()
                last_vals_by_target: Dict[Tuple[str, str], Any] = {}

                for g_idx in range(num_groups):
                    g_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        include_limit_padding=False,
                        cache_key_salt=f"gb_limit_grp_{g_idx}",
                    )
                    grp_tuple = tuple(
                        g_data[t_g][0].get(c_g) if g_data.get(t_g) else None
                        for t_g, c_g in targets
                    )
                    if grp_tuple in seen_group_tuples:
                        for t_g, c_g in targets:
                            if (t_g, c_g) in where_locked or not g_data.get(t_g):
                                continue
                            g_col = schema.find_column(t_g, c_g)
                            prev_v = last_vals_by_target.get((t_g, c_g), g_data[t_g][0].get(c_g))
                            if g_col is not None and prev_v is not None:
                                new_v = next_distinct_query_value(schema, parsed_query, t_g, g_col, prev_v)
                                self._set_equiv_value(schema, equiv, g_data, t_g, c_g, new_v)
                                last_vals_by_target[(t_g, c_g)] = new_v
                                break
                        grp_tuple = tuple(
                            g_data[t_g][0].get(c_g) if g_data.get(t_g) else None
                            for t_g, c_g in targets
                        )
                    for t_g, c_g in targets:
                        if g_data.get(t_g):
                            last_vals_by_target[(t_g, c_g)] = g_data[t_g][0].get(c_g)
                    seen_group_tuples.add(grp_tuple)
                    for t_name in limit_merged_data:
                        if t_name in g_data:
                            limit_merged_data[t_name].extend(copy.deepcopy(g_data[t_name]))

                limit_merged_data = deduplicate_mock_data(schema, limit_merged_data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_limit_groups",
                        data=limit_merged_data,
                        tags=["group_by_attack", "ordering_attack"],
                        description=(
                            f"Targets LIMIT / OFFSET truncation bugs on GROUP BY queries. "
                            f"Constructs {num_groups} distinct groups satisfying all WHERE and JOIN "
                            f"constraints so queries with different LIMIT or OFFSET bounds over "
                            f"grouped results return different group counts."
                        ),
                    )
                )

        elif self._has_aggregates(parsed_query):
            # Case 2: Scalar Aggregation Query (has aggregate functions, NO GROUP BY)
            # Dataset 1: Empty dataset
            empty_data = {t_name: [] for t_name in schema.tables}
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_empty_dataset",
                    data=empty_data,
                    tags=["group_by_attack"],
                    description="Targets Unexpected GROUP BY bug. Dataset contains zero rows (empty dataset). A correct scalar aggregate query (without GROUP BY) over an empty relation returns exactly one row containing NULL or aggregate defaults, whereas a mutant that erroneously adds a GROUP BY clause evaluates to zero groups and returns zero rows."
                )
            )

            # Dataset 2: Multi-group dataset
            group1 = generate_base_dataset(schema, parsed_query, cache_key_salt="gb_sc_1")
            group2 = generate_base_dataset(schema, parsed_query, cache_key_salt="gb_sc_2")

            merged_data = {t_name: [] for t_name in schema.tables}
            for g in [group1, group2]:
                for t_name in merged_data:
                    if t_name in g:
                        merged_data[t_name].extend(copy.deepcopy(g[t_name]))

            merged_data = deduplicate_mock_data(schema, merged_data)

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_multi_group",
                    data=merged_data,
                    tags=["group_by_attack"],
                    description="Targets Unexpected GROUP BY bug. Dataset generates multiple rows with distinct non-aggregated attribute values. The correct scalar aggregate query combines all rows globally into 1 row, whereas a mutant adding a GROUP BY splits them into multiple group rows."
                )
            )

        return datasets

