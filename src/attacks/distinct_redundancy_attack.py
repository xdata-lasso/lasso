"""
RedundantDistinctAttackStrategy Module

Target semantic bug:
Mutants that add a redundant or erroneous DISTINCT modifier to a projection.

Algorithm & Dataset Design:
1. Plain projections without DISTINCT or GROUP BY: creates two rows whose selected columns
   are equal but whose primary keys differ.
2. Projections without top-level DISTINCT over a GROUP BY (top-level or derived table) with
   unprojected grouping columns (G \\ P != empty): constructs two distinct satisfying groups
   sharing identical projected column values P, differing on G \\ P, and having distinct
   group cardinalities/aggregate values (N vs N + 1) so the non-DISTINCT projection preserves
   both rows while a mutant adding top-level DISTINCT collapses them.
"""

from typing import Any, Dict, List, Set, Tuple
import copy
import functools

import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import (
    build_partial_group_by_distinct_dataset,
    can_null_column_for_duplicate,
    distinct_satisfying_where_value,
    get_partial_group_by_targets,
)
from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator import generate_base_dataset, resolve_query_column, UnionFind


class RedundantDistinctAttackStrategy(AttackStrategy):
    """
    Target semantic bug: redundant DISTINCT added to a projection.

    Algorithm & Dataset Design:
    When the correct query is a plain projection without DISTINCT or GROUP BY,
    the strategy creates two rows whose selected columns are equal but whose
    primary keys differ (or, when all columns of a composite PRIMARY KEY are
    projected and at least one is nullable under SQLite semantics, sets one
    nullable composite key column to NULL in both rows while varying non-projected
    columns, since SQLite treats NULLs as distinct in PRIMARY KEY / UNIQUE indexes
    whereas SELECT DISTINCT collapses them). The correct query must preserve both
    duplicate result tuples, while a mutant that adds DISTINCT collapses them.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        if parsed_query.get("has_distinct"):
            return False
        return bool(self._targets(schema, parsed_query)) or (
            get_partial_group_by_targets(schema, parsed_query) is not None
        )

    def _get_projected_columns(self, schema: Schema, parsed_query: Dict[str, Any]) -> Set[Tuple[str, str]]:
        projected: Set[Tuple[str, str]] = set()
        ast = parsed_query.get("ast")
        if isinstance(ast, exp.Select):
            for expr in ast.expressions or []:
                for col in expr.find_all(exp.Column):
                    res = resolve_query_column(schema, parsed_query, col.table, col.name)
                    if res:
                        projected.add(res)
        for select in parsed_query.get("selects", []):
            resolved = resolve_query_column(schema, parsed_query, select.get("table", ""), select["column"])
            if resolved:
                projected.add(resolved)
        return projected

    def _can_null_column_for_duplicate(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        return can_null_column_for_duplicate(schema, parsed_query, table_name, column_name)

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        if parsed_query.get("has_distinct") or parsed_query.get("has_group_by"):
            return []

        projected_cols = self._get_projected_columns(schema, parsed_query)
        projected_cols_upper = {(t.upper(), c.upper()) for t, c in projected_cols}
        alias_to_table = self.get_alias_to_table(schema, parsed_query)
        alias_to_table_upper = {a.upper(): t.upper() for a, t in alias_to_table.items()}
        uf, join_cols = self._build_join_classes(schema, parsed_query, alias_to_table)
        single_pk_projected_aliases: Set[str] = set()
        for alias, t_name in alias_to_table.items():
            if t_name in schema.tables:
                t_obj = schema.tables[t_name]
                t_pk_cols = [c for c in t_obj.columns if c.is_primary_key]
                for c_obj in t_obj.columns:
                    if c_obj.is_unique or (c_obj.is_primary_key and len(t_pk_cols) <= 1):
                        key_up = (alias.upper(), c_obj.name.upper())
                        is_proj_col = (t_name.upper(), c_obj.name.upper()) in projected_cols_upper
                        is_joined_to_proj = False
                        if key_up in join_cols:
                            root = uf.find(key_up)
                            root_members = [k for k in join_cols if uf.find(k) == root]
                            is_joined_to_proj = any(
                                (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                                for k in root_members
                            )
                        if is_proj_col or is_joined_to_proj:
                            single_pk_projected_aliases.add(alias.upper())
                            break
        has_duplicable_join_alias = any(
            a.upper() not in single_pk_projected_aliases and t_n in schema.tables
            for a, t_n in alias_to_table.items()
        )

        targets = []
        for select in parsed_query.get("selects", []):
            resolved = resolve_query_column(schema, parsed_query, select.get("table", ""), select["column"])
            if resolved:
                table_name, col_name = resolved
                table = schema.tables.get(table_name)
                if not table:
                    continue
                col = next((c for c in table.columns if c.name == col_name), None)
                if not col:
                    continue
                pk_cols = [c for c in table.columns if c.is_primary_key]
                can_duplicate = False
                if not col.is_primary_key and not col.is_unique:
                    can_duplicate = True
                elif col.is_primary_key and not col.is_unique and len(pk_cols) > 1:
                    if any((table_name, pk_c.name) not in projected_cols for pk_c in pk_cols):
                        can_duplicate = True
                    elif any(self._can_null_column_for_duplicate(schema, parsed_query, table_name, pk_c.name) for pk_c in pk_cols):
                        can_duplicate = True
                elif has_duplicable_join_alias:
                    can_duplicate = True
                if can_duplicate and resolved not in targets:
                    targets.append(resolved)
        return targets

    def _build_join_classes(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        alias_to_table: Dict[str, str],
    ) -> Tuple[UnionFind, Set[Tuple[str, str]]]:
        uf = UnionFind()
        join_cols: Set[Tuple[str, str]] = set()
        alias_lookup = {a.upper(): a for a in alias_to_table}

        def _norm_side(info: Dict[str, str]) -> Tuple[str, str] | None:
            raw_t = info.get("table", "")
            raw_c = info.get("column", "")
            if not raw_c:
                return None
            if raw_t and raw_t.upper() in alias_lookup:
                return (raw_t.upper(), raw_c.upper())
            resolved = resolve_query_column(schema, parsed_query, raw_t, raw_c)
            if resolved:
                t_name, c_name = resolved
                for a, tn in alias_to_table.items():
                    if tn.upper() == t_name.upper():
                        return (a.upper(), c_name.upper())
            return (raw_t.upper(), raw_c.upper()) if raw_t else None

        for join in parsed_query.get("joins", []):
            j_type = (join.get("type") or "").upper()
            if j_type == "EQ_SUBQUERY":
                continue
            if j_type == "IN_SUBQUERY" and (
                join.get("agg_func")
                or join.get("agg_pairs")
                or join.get("has_group_by")
                or join.get("has_limit")
            ):
                continue
            for pair in join.get("on_pairs", []):
                left = _norm_side(pair.get("left", {}))
                right = _norm_side(pair.get("right", {}))
                if left and right and left != right:
                    if j_type == "IN_SUBQUERY":
                        l_tbl = alias_to_table.get(alias_lookup.get(left[0], ""), left[0])
                        r_tbl = alias_to_table.get(alias_lookup.get(right[0], ""), right[0])
                        if l_tbl.upper() == r_tbl.upper():
                            continue
                    uf.union(left, right)
                    join_cols.add(left)
                    join_cols.add(right)

        for pair in parsed_query.get("where_joins", []):
            left = _norm_side(pair.get("left", {}))
            right = _norm_side(pair.get("right", {}))
            if left and right and left != right:
                uf.union(left, right)
                join_cols.add(left)
                join_cols.add(right)

        return uf, join_cols

    def _select_row_index(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        rows: List[Dict[str, Any]],
        alias_idx: int,
        alias_count: int,
        all_table_rows: Dict[str, List[Dict[str, Any]]] | None = None,
    ) -> int | None:
        n = len(rows)
        if alias_idx >= n or n == 0:
            return None
        if n >= alias_count and alias_count > 0:
            chunk = max(1, n // alias_count)
            start_idx = alias_idx * chunk
            end_idx = n if alias_idx == alias_count - 1 else (alias_idx + 1) * chunk
        else:
            start_idx = alias_idx
            end_idx = alias_idx + 1

        if end_idx - start_idx <= 1:
            return start_idx

        ast = parsed_query.get("ast")
        if ast:
            for agg_node in ast.find_all((exp.Max, exp.Min)):
                col_node = agg_node.find(exp.Column)
                if not col_node:
                    continue
                res = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                if not res or res[0].upper() != table_name.upper():
                    continue
                target_col = res[1]
                want_max = isinstance(agg_node, exp.Max)
                subq = agg_node.find_ancestor(exp.Subquery)
                if subq and subq.parent:
                    parent = subq.parent
                    if isinstance(parent, exp.NEQ) or (
                        isinstance(parent, exp.In) and isinstance(parent.parent, exp.Not)
                    ):
                        want_max = not want_max
                    elif isinstance(parent, exp.LT) and parent.expression is subq:
                        want_max = False
                    elif isinstance(parent, exp.GT) and parent.expression is subq:
                        want_max = True
                valid_indices = [
                    i for i in range(start_idx, end_idx)
                    if rows[i].get(target_col) is not None
                ]
                if valid_indices:
                    def _sqlite_sort_key(idx: int) -> Tuple[int, Any]:
                        val = rows[idx][target_col]
                        if isinstance(val, (int, float)) and not isinstance(val, bool):
                            return (0, float(val))
                        return (1, str(val))

                    if want_max:
                        return max(valid_indices, key=_sqlite_sort_key)
                    return min(valid_indices, key=_sqlite_sort_key)

        order_bys = parsed_query.get("order_by") or []
        if order_bys:
            resolved_terms: List[Tuple[List[Dict[str, Any]], str, bool, bool]] = []
            for term in order_bys:
                col_name = term.get("column", "")
                if not col_name:
                    continue
                res = resolve_query_column(schema, parsed_query, term.get("table", ""), col_name)
                if not res:
                    continue
                ord_t, ord_c = res
                t_rows = None
                if ord_t.upper() == table_name.upper():
                    t_rows = rows
                elif alias_count == 1 and all_table_rows:
                    cand_rows = all_table_rows.get(ord_t)
                    if cand_rows is not None and len(cand_rows) == n:
                        t_rows = cand_rows
                if t_rows is not None and len(t_rows) >= end_idx:
                    is_desc = bool(term.get("desc", False))
                    nf = term.get("nulls_first")
                    nulls_first = (not is_desc) if nf is None else bool(nf)
                    resolved_terms.append((t_rows, ord_c, is_desc, nulls_first))

            if resolved_terms:
                def _cmp_order(idx_a: int, idx_b: int) -> int:
                    for t_rows, ord_c, is_desc, nulls_first in resolved_terms:
                        va = t_rows[idx_a].get(ord_c)
                        vb = t_rows[idx_b].get(ord_c)
                        if va is None and vb is None:
                            continue
                        if va is None:
                            return -1 if nulls_first else 1
                        if vb is None:
                            return 1 if nulls_first else -1
                        ka = (0, float(va)) if isinstance(va, (int, float)) and not isinstance(va, bool) else (1, str(va))
                        kb = (0, float(vb)) if isinstance(vb, (int, float)) and not isinstance(vb, bool) else (1, str(vb))
                        if ka == kb:
                            continue
                        cmp_val = -1 if ka < kb else 1
                        return -cmp_val if is_desc else cmp_val
                    return idx_a - idx_b

                sorted_indices = sorted(range(start_idx, end_idx), key=functools.cmp_to_key(_cmp_order))
                off_val = parsed_query.get("offset_val")
                if isinstance(off_val, int) and 0 <= off_val < len(sorted_indices):
                    return sorted_indices[off_val]
                return sorted_indices[0]

        return start_idx

    def _can_vary_keyless_column(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> bool:
        table = schema.tables.get(table_name)
        if not table:
            return False
        if any(fk.column_name.upper() == column_name.upper() for fk in table.foreign_keys):
            return False
        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column_name.upper():
                    return False
        ast = parsed_query.get("ast")
        if ast:
            for c in ast.find_all(exp.Column):
                if (c.name or "").upper() != column_name.upper():
                    continue
                count_anc = c.find_ancestor(exp.Count)
                if count_anc is not None:
                    continue
                return False
        return True

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:

        base_data = generate_base_dataset(schema, parsed_query, include_limit_padding=False)
        mock_data = {t_name: [] for t_name in schema.tables}
        projected_cols = self._get_projected_columns(schema, parsed_query)
        projected_cols_upper = {(t.upper(), c.upper()) for t, c in projected_cols}
        first_selected = None
        for select in parsed_query.get("selects", []):
            resolved = resolve_query_column(schema, parsed_query, select.get("table", ""), select["column"])
            if resolved:
                first_selected = resolved
                break

        where_constrained_cols: Set[Tuple[str, str]] = set()
        for lit in parsed_query.get("where_literals", []):
            res = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res:
                where_constrained_cols.add((res[0].upper(), res[1].upper()))

        # 1. Map aliases to table names and build UnionFind for joins
        alias_to_table = self.get_alias_to_table(schema, parsed_query)
        alias_to_table_upper = {a.upper(): t.upper() for a, t in alias_to_table.items()}
        uf, join_cols = self._build_join_classes(schema, parsed_query, alias_to_table)

        # First add all original rows from the base dataset
        for t_name, rows in base_data.items():
            mock_data[t_name].extend(copy.deepcopy(rows))

        single_pk_projected_aliases: Set[str] = set()
        for alias, table_name in alias_to_table.items():
            if table_name in schema.tables:
                table = schema.tables[table_name]
                pk_cols = [c for c in table.columns if c.is_primary_key]
                for col in table.columns:
                    if col.is_unique or (col.is_primary_key and len(pk_cols) <= 1):
                        key_up = (alias.upper(), col.name.upper())
                        is_proj_col = (table_name.upper(), col.name.upper()) in projected_cols_upper
                        is_joined_to_proj = False
                        if key_up in join_cols:
                            root = uf.find(key_up)
                            root_members = [k for k in join_cols if uf.find(k) == root]
                            is_joined_to_proj = any(
                                (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                                for k in root_members
                            )
                        if is_proj_col or is_joined_to_proj:
                            single_pk_projected_aliases.add(alias.upper())
                            break

        # Now build duplicate rows for each alias
        duplicate_rows_by_table = {t_name: [] for t_name in schema.tables}
        root_to_new_value = {}
        table_row_index = {t_name: 0 for t_name in schema.tables}
        alias_counts_by_table: Dict[str, int] = {}
        for _, t_name in alias_to_table.items():
            alias_counts_by_table[t_name] = alias_counts_by_table.get(t_name, 0) + 1

        for alias, table_name in alias_to_table.items():
            if table_name not in schema.tables:
                continue
            if alias.upper() in single_pk_projected_aliases:
                continue
            table = schema.tables[table_name]
            alias_idx = table_row_index[table_name]
            table_row_index[table_name] += 1
            idx = self._select_row_index(
                schema,
                parsed_query,
                table_name,
                mock_data[table_name],
                alias_idx,
                alias_counts_by_table.get(table_name, 1),
                all_table_rows=mock_data,
            )
            if idx is None:
                continue
            original_row = mock_data[table_name][idx]

            pk_cols = [c for c in table.columns if c.is_primary_key]
            has_any_unique = bool(pk_cols) or any(c.is_unique for c in table.columns) or bool(getattr(table, "unique_constraints", []))
            all_pk_projected = len(pk_cols) > 1 and all((table_name.upper(), c.name.upper()) in projected_cols_upper for c in pk_cols)
            null_pk_col_name = None
            if all_pk_projected:
                eligible_null_pks = [
                    c for c in pk_cols
                    if not c.is_unique
                    and (alias.upper(), c.name.upper()) not in join_cols
                    and self._can_null_column_for_duplicate(schema, parsed_query, table_name, c.name)
                ]
                if not eligible_null_pks:
                    eligible_null_pks = [
                        c for c in pk_cols
                        if not c.is_unique
                        and self._can_null_column_for_duplicate(schema, parsed_query, table_name, c.name)
                    ]
                if eligible_null_pks:
                    chosen_pk = next(
                        (c for c in eligible_null_pks if (table_name, c.name) != first_selected),
                        eligible_null_pks[0],
                    )
                    null_pk_col_name = chosen_pk.name
                    if (alias.upper(), null_pk_col_name.upper()) in join_cols:
                        null_companion_row = copy.deepcopy(original_row)
                        null_companion_row[null_pk_col_name] = None
                        duplicate_rows_by_table[table_name].append(null_companion_row)
                    else:
                        original_row[null_pk_col_name] = None

            duplicate_row = {}
            varied_keyless = False
            for col in table.columns:
                key = (alias.upper(), col.name.upper())
                is_join = key in join_cols
                is_proj = (table_name.upper(), col.name.upper()) in projected_cols_upper

                if null_pk_col_name is not None and col.name == null_pk_col_name:
                    duplicate_row[col.name] = None
                elif is_join:
                    root = uf.find(key)
                    root_members = [k for k in join_cols if uf.find(k) == root]
                    joins_to_anchored = any(
                        k[0] in single_pk_projected_aliases
                        or (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                        for k in root_members
                    )
                    if joins_to_anchored:
                        duplicate_row[col.name] = original_row[col.name]
                    else:
                        if root not in root_to_new_value:
                            cand_val = generate_unique_value_for_column(col)
                            cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                            root_to_new_value[root] = cand_val
                        duplicate_row[col.name] = root_to_new_value[root]
                elif col.is_unique or (col.is_primary_key and len(pk_cols) == 1):
                    distinct_where_val = None
                    if (table_name.upper(), col.name.upper()) in where_constrained_cols:
                        distinct_where_val = distinct_satisfying_where_value(
                            schema, parsed_query, table_name, col, original_row, duplicate_row
                        )
                    if distinct_where_val is not None:
                        duplicate_row[col.name] = distinct_where_val
                    else:
                        cand_val = generate_unique_value_for_column(col)
                        cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                        duplicate_row[col.name] = cand_val
                elif col.is_primary_key and len(pk_cols) > 1:
                    if is_proj and (not all_pk_projected or null_pk_col_name is not None):
                        duplicate_row[col.name] = original_row[col.name]
                    else:
                        distinct_where_val = None
                        if (table_name.upper(), col.name.upper()) in where_constrained_cols:
                            distinct_where_val = distinct_satisfying_where_value(
                                schema, parsed_query, table_name, col, original_row, duplicate_row
                            )
                        if distinct_where_val is not None:
                            duplicate_row[col.name] = distinct_where_val
                        elif (
                            not col.is_unique
                            and (table_name.upper(), col.name.upper()) in where_constrained_cols
                            and any(
                                other_pk.name != col.name
                                and (table_name.upper(), other_pk.name.upper()) not in projected_cols_upper
                                and (
                                    (
                                        (alias.upper(), other_pk.name.upper()) in join_cols
                                        and not any(
                                            k[0] in single_pk_projected_aliases
                                            or (alias_to_table_upper.get(k[0], ""), k[1]) in projected_cols_upper
                                            for k in join_cols
                                            if uf.find(k) == uf.find((alias.upper(), other_pk.name.upper()))
                                        )
                                    )
                                    or (
                                        (alias.upper(), other_pk.name.upper()) not in join_cols
                                        and (
                                            (table_name.upper(), other_pk.name.upper()) not in where_constrained_cols
                                            or distinct_satisfying_where_value(
                                                schema, parsed_query, table_name, other_pk, original_row, duplicate_row
                                            ) is not None
                                        )
                                    )
                                )
                                for other_pk in pk_cols
                            )
                        ):
                            duplicate_row[col.name] = original_row[col.name]
                        else:
                            cand_val = generate_unique_value_for_column(col)
                            cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                            duplicate_row[col.name] = cand_val
                elif (
                    all_pk_projected
                    and null_pk_col_name is not None
                    and not is_proj
                    and (table_name.upper(), col.name.upper()) not in where_constrained_cols
                    and not any(fk.column_name.upper() == col.name.upper() for fk in table.foreign_keys)
                ):
                    cand_val = generate_unique_value_for_column(col)
                    cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                    duplicate_row[col.name] = cand_val
                elif (
                    not has_any_unique
                    and not varied_keyless
                    and not is_proj
                    and (table_name.upper(), col.name.upper()) not in where_constrained_cols
                    and self._can_vary_keyless_column(schema, parsed_query, table_name, col.name)
                ):
                    cand_val = generate_unique_value_for_column(col)
                    cand_val = solve_check_constraint_value(schema, table_name, col.name, col, cand_val, row_context=duplicate_row)
                    duplicate_row[col.name] = cand_val
                    varied_keyless = True
                else:
                    duplicate_row[col.name] = original_row[col.name]

            duplicate_rows_by_table[table_name].append(duplicate_row)

        for t_name, rows in duplicate_rows_by_table.items():
            mock_data[t_name].extend(rows)

        datasets: List[Dataset] = []
        if self._targets(schema, parsed_query):
            datasets.append(
                Dataset(
                    strategy_name=self.__class__.__name__,
                    data=mock_data,
                    tags=["distinct_redundancy_attack"],
                    description="Targets Redundant DISTINCT bugs. Dataset generates two rows whose selected projection columns are completely identical, but whose primary keys differ. A correct query without DISTINCT will preserve both rows, whereas a mutant that incorrectly adds a DISTINCT clause will erroneously deduplicate them."
                )
            )

        if not parsed_query.get("has_distinct"):
            partial_gb_ds = build_partial_group_by_distinct_dataset(
                schema,
                parsed_query,
                strategy_name=f"{self.__class__.__name__}_partial_group_by",
                tags=["distinct_redundancy_attack", "group_by_attack"],
                description="Targets Spurious DISTINCT over partial GROUP BY projections. Dataset constructs two distinct groups sharing identical projected column values, differing on unprojected GROUP BY columns, satisfying all HAVING/WHERE predicates, and yielding distinct group cardinalities/aggregate values.",
            )
            if partial_gb_ds is not None:
                datasets.append(partial_gb_ds)

        return datasets
