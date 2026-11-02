"""
AggregateNullAttackStrategy Module

Target semantic bug: Incorrect NULL handling in aggregates (e.g. COUNT(*) vs COUNT(col),
MIN/MAX ignoring NULL vs window ranking ORDER BY placing NULL first, and division by COUNT(col) = 0).
Algorithm & Dataset Design:
Injects NULL values into specific aggregated columns (including SQLite-nullable composite
PRIMARY KEY columns and non-INTEGER single-column PRIMARY KEY columns without explicit NOT NULL
constraints, when no active query table references them via a foreign key). SQL semantics dictate
COUNT(*) counts rows including NULLs whereas COUNT(col) ignores NULLs (returning 0), and
MIN(col)/MAX(col) ignore NULLs within a group whereas window ranking functions
(RANK/DENSE_RANK/ROW_NUMBER) order NULLs first under ASC and tie duplicate NULLs.
"""

from typing import Any, Dict, List
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    deduplicate_mock_data,
    generate_base_dataset,
    get_singleton_having_group_cols,
    resolve_query_column,
)
from dataset_generator.value_generator import generate_unique_value_for_column


class AggregateNullAttackStrategy(AttackStrategy):
    """
    Target semantic bug: aggregate functions (COUNT, SUM, AVG, MIN, MAX) over a nullable column
    (or SQLite-nullable composite or non-INTEGER single-column PRIMARY KEY column) getting mutated
    to count non-nullable columns/COUNT(*), wrap zero-count division in COALESCE, or replace
    GROUP BY MIN/MAX with window ranking functions (RANK/DENSE_RANK/ROW_NUMBER).

    Algorithm & Dataset Design:
    This strategy identifies aggregate calls in the query AST whose argument is a nullable column
    (including composite or non-INTEGER single-column primary key columns without an explicit
    NOT NULL constraint in SQLite, provided no active table in the query references them via FK).
    For each target, it generates:
    1. only_nulls: A normal group plus a group where the targeted column is NULL.
    2. mixed_nulls: A group mixing both NULL and non-NULL values for the targeted column under the
       same GROUP BY key (verifying MIN/MAX/SUM/AVG/COUNT skip NULL rows while window ORDER BY ASC
       places NULL at rank 1).
    3. standalone_nulls: Only the group where the targeted column is NULL.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query))

    def _find_columns(self, node: exp.Expression) -> list[exp.Column]:
        arg = node.this
        if not arg:
            return []
        
        # If the argument is DISTINCT, we get its inner expression
        if isinstance(arg, exp.Distinct):
            arg = arg.expressions[0] if arg.expressions else arg.this

        if not arg:
            return []

        return list(arg.find_all(exp.Column))

    def _active_tables(self, schema: Schema, parsed_query: Dict[str, Any]) -> set[str]:
        active: set[str] = set()
        ast = parsed_query.get("ast")
        if ast:
            for t in ast.find_all(exp.Table):
                st = schema.find_table(t.name)
                if st:
                    active.add(st.upper())
        for t in parsed_query.get("tables", []):
            t_name = t.get("name", "")
            st = schema.find_table(t_name) if t_name else None
            if st:
                active.add(st.upper())
        added = True
        while added:
            added = False
            for t_up in list(active):
                st = schema.find_table(t_up)
                if not st:
                    continue
                for fk in schema.tables[st].foreign_keys:
                    parent_st = schema.find_table(fk.reference_table)
                    if parent_st and parent_st.upper() not in active:
                        active.add(parent_st.upper())
                        added = True
        return active

    def _can_null_column(
        self,
        schema: Schema,
        table_name: str,
        column: Any,
        active_tables: set[str] | None = None,
    ) -> bool:
        if not column or getattr(column, "explicit_not_null", False):
            return False
        table = schema.tables.get(table_name)
        if not table:
            return False
        pk_cols = [c for c in table.columns if c.is_primary_key]
        is_int_single_pk = (
            column.is_primary_key
            and len(pk_cols) == 1
            and "int" in (column.data_type or "").lower()
        )
        if is_int_single_pk:
            return False
        if not column.is_nullable and not column.is_primary_key:
            return False
        for t_obj in schema.tables.values():
            if active_tables is not None and t_obj.name.upper() not in active_tables:
                continue
            for fk in t_obj.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == column.name.upper():
                    return False
        return True

    def _where_constrained_cols(
        self, schema: Schema, parsed_query: Dict[str, Any], ast: exp.Expression
    ) -> set[tuple[str, str]]:
        where_constrained: set[tuple[str, str]] = set()
        for wl in parsed_query.get("where_literals", []):
            res_wl = resolve_query_column(schema, parsed_query, wl.get("table", ""), wl.get("column", ""))
            if res_wl:
                where_constrained.add((res_wl[0].upper(), res_wl[1].upper()))
        for clause in list(ast.find_all((exp.Where, exp.Having))) + [
            j.args.get("on") for j in ast.find_all(exp.Join) if j.args.get("on")
        ]:
            for col_node in clause.find_all(exp.Column):
                res_c = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                if res_c:
                    where_constrained.add((res_c[0].upper(), res_c[1].upper()))
        return where_constrained

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        active_tables = self._active_tables(schema, parsed_query)
        where_constrained = self._where_constrained_cols(schema, parsed_query, ast)

        def _add_nullable_table_cols(t_name: str, limit: int = 2) -> None:
            st_key = schema.find_table(t_name)
            table = schema.tables.get(st_key) if st_key else None
            if not table or not st_key:
                return
            unconstrained = [
                c for c in table.columns
                if (st_key.upper(), c.name.upper()) not in where_constrained
            ]
            constrained = [
                c for c in table.columns
                if (st_key.upper(), c.name.upper()) in where_constrained
            ]
            added = 0
            for col in unconstrained + constrained:
                if not col.is_primary_key and self._can_null_column(
                    schema, st_key, col, active_tables=active_tables
                ):
                    target = (st_key, col.name)
                    if target not in targets:
                        targets.append(target)
                        added += 1
                        if added >= limit:
                            break
            for col in unconstrained + constrained:
                if col.is_primary_key and self._can_null_column(
                    schema, st_key, col, active_tables=active_tables
                ):
                    target = (st_key, col.name)
                    if target not in targets:
                        targets.append(target)
                        break

        targets = []
        deferred_count_tables = []
        for node in ast.find_all(exp.AggFunc):
            if isinstance(node, exp.Count) and isinstance(node.this, exp.Star):
                for t in parsed_query.get("tables", []):
                    t_name = t.get("name")
                    if t_name:
                        _add_nullable_table_cols(t_name, limit=2)
                for act_t in sorted(active_tables):
                    _add_nullable_table_cols(act_t, limit=2)
            else:
                col_nodes = self._find_columns(node)
                for col_node in col_nodes:
                    col_tbl = col_node.table
                    if not col_tbl:
                        enclosing_sel = col_node.find_ancestor(exp.Select)
                        if enclosing_sel:
                            for t_node in enclosing_sel.find_all(exp.Table):
                                if t_node.find_ancestor(exp.Select) is enclosing_sel:
                                    st = schema.find_table(t_node.name)
                                    if st and schema.find_column(st, col_node.name):
                                        col_tbl = t_node.alias or t_node.name
                                        break
                    resolved = resolve_query_column(schema, parsed_query, col_tbl, col_node.name)
                    if not resolved:
                        continue
                    table_name, column_name = resolved
                    table = schema.tables.get(table_name)
                    if not table:
                        continue
                    column = next((c for c in table.columns if c.name == column_name), None)
                    if self._can_null_column(schema, table_name, column, active_tables=active_tables):
                        target = (table_name, column_name)
                        if target not in targets:
                            targets.append(target)
                        if isinstance(node, exp.Count) and (table_name.upper(), column_name.upper()) in where_constrained:
                            if table_name not in deferred_count_tables:
                                deferred_count_tables.append(table_name)
                    elif isinstance(node, exp.Count):
                        _add_nullable_table_cols(table_name, limit=2)
            enclosing_sel = node.find_ancestor(exp.Select)
            if enclosing_sel and enclosing_sel.args.get("group") and enclosing_sel.args.get("having"):
                for gb_col in enclosing_sel.args["group"].find_all(exp.Column):
                    gb_tbl = gb_col.table
                    if not gb_tbl:
                        for t_node in enclosing_sel.find_all(exp.Table):
                            if t_node.find_ancestor(exp.Select) is enclosing_sel:
                                st = schema.find_table(t_node.name)
                                if st and schema.find_column(st, gb_col.name):
                                    gb_tbl = t_node.alias or t_node.name
                                    break
                    gb_res = resolve_query_column(schema, parsed_query, gb_tbl, gb_col.name)
                    if gb_res:
                        gb_t, gb_c = gb_res
                        gb_t_obj = schema.tables.get(gb_t)
                        gb_col_obj = next((c for c in gb_t_obj.columns if c.name == gb_c), None) if gb_t_obj else None
                        if self._can_null_column(schema, gb_t, gb_col_obj, active_tables=active_tables):
                            gb_target = (gb_t, gb_c)
                            if gb_target not in targets:
                                targets.append(gb_target)
        for dt_name in deferred_count_tables:
            _add_nullable_table_cols(dt_name, limit=2)
        return targets

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        targets = self._targets(schema, parsed_query)
        if not targets:
            return []

        datasets = []
        first_group = generate_base_dataset(schema, parsed_query)

        singleton_gb_cols = get_singleton_having_group_cols(parsed_query.get("ast"))
        for table_name, column_name in targets:
            group_by_cols = []
            for term in parsed_query.get("group_by", []):
                resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
                if resolved and resolved[1].upper() not in singleton_gb_cols:
                    group_by_cols.append(resolved)

            second_group = generate_base_dataset(schema, parsed_query, null_injections=[(table_name, column_name)])

            # Dataset 1: Group with ONLY NULLs
            mock_data_1 = {t_name: [] for t_name in schema.tables}
            for g in [first_group, second_group]:
                for t_name in mock_data_1:
                    if t_name in g:
                        mock_data_1[t_name].extend(copy.deepcopy(g[t_name]))

            if (
                group_by_cols
                and not parsed_query.get("has_having")
                and first_group.get(table_name)
                and second_group.get(table_name)
            ):
                table_obj_1 = schema.tables.get(table_name)
                pk_cols_1 = [c for c in table_obj_1.columns if c.is_primary_key] if table_obj_1 else []
                gb_set_upper = {(gt.upper(), gc.upper()) for gt, gc in group_by_cols}
                if not pk_cols_1 and table_obj_1 and (table_name.upper(), column_name.upper()) not in gb_set_upper:
                    r0 = copy.deepcopy(second_group[table_name][0])
                    r1 = copy.deepcopy(r0)
                    made_distinct = False
                    for fk in table_obj_1.foreign_keys:
                        if fk.column_name.upper() == column_name.upper():
                            continue
                        ref_t = schema.find_table(fk.reference_table)
                        if (
                            ref_t
                            and len(second_group.get(ref_t, [])) >= 2
                            and (ref_t.upper(), fk.reference_column.upper()) not in gb_set_upper
                        ):
                            alt_fk_val = second_group[ref_t][1].get(fk.reference_column)
                            if alt_fk_val is not None and alt_fk_val != r0.get(fk.column_name):
                                r1[fk.column_name] = alt_fk_val
                                made_distinct = True
                                break
                    if made_distinct:
                        mock_data_1[table_name] = (
                            copy.deepcopy(first_group[table_name][:1]) + [r0, r1]
                        )

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}_only_nulls",
                    data=deduplicate_mock_data(schema, mock_data_1),
                    tags=["aggregate_attack", "null_attack"],
                    description=f"Targets Aggregate Null Handling bugs. Dataset sets `{table_name}.{column_name}` to NULL for every row in a particular group. This explicitly verifies that the aggregate function handles all-NULL groups correctly (e.g. `SUM` yielding NULL instead of 0), and importantly differentiates `COUNT(*)` (which counts rows) from `COUNT({column_name})` (which should evaluate to 0)."
                )
            )

            # Dataset 2: Group with mix of NULL and valid values
            has_other_group_cols = any(
                (gt.upper(), gc.upper()) != (table_name.upper(), column_name.upper())
                for gt, gc in group_by_cols
            )
            value_injections = {}
            for t, c in group_by_cols:
                if has_other_group_cols and (t.upper(), c.upper()) == (table_name.upper(), column_name.upper()):
                    continue
                if second_group.get(t) and len(second_group[t]) > 0:
                    value_injections[(t, c)] = second_group[t][0][c]
            third_group = generate_base_dataset(
                schema, 
                parsed_query, 
                value_injections=value_injections
            )

            mock_data_2 = {t_name: [] for t_name in schema.tables}
            table_obj = schema.tables.get(table_name)
            pk_cols = [c for c in table_obj.columns if c.is_primary_key] if table_obj else []
            fk_cols = {fk.column_name.upper() for fk in table_obj.foreign_keys} if table_obj else set()
            ref_by_other = (
                {
                    fk.reference_column.upper()
                    for t_other in schema.tables.values()
                    for fk in t_other.foreign_keys
                    if fk.reference_table.upper() == table_name.upper()
                }
                if table_obj else set()
            )
            join_cols = set()
            if table_obj:
                for j in parsed_query.get("joins", []):
                    for pair in j.get("on_pairs", []):
                        for side in ("left", "right"):
                            res_j = resolve_query_column(
                                schema, parsed_query, pair[side].get("table", ""), pair[side].get("column", "")
                            )
                            if res_j and res_j[0].upper() == table_name.upper():
                                join_cols.add(res_j[1].upper())
                for pair in parsed_query.get("where_joins", []):
                    for side in ("left", "right"):
                        res_j = resolve_query_column(
                            schema, parsed_query, pair[side].get("table", ""), pair[side].get("column", "")
                        )
                        if res_j and res_j[0].upper() == table_name.upper():
                            join_cols.add(res_j[1].upper())

            sec_target_rows = copy.deepcopy(second_group.get(table_name, []))
            thd_target_rows = copy.deepcopy(third_group.get(table_name, []))
            if column_name.upper() in singleton_gb_cols:
                if len(thd_target_rows) > 1:
                    thd_target_rows = thd_target_rows[:1]
                if len(sec_target_rows) == 1 and len(pk_cols) > 1:
                    other_pk = next((c for c in pk_cols if c.name.upper() != column_name.upper()), None)
                    if other_pk is not None:
                        dup_sec = copy.deepcopy(sec_target_rows[0])
                        dup_sec[other_pk.name] = generate_unique_value_for_column(other_pk)
                        sec_target_rows.append(dup_sec)
            if pk_cols and sec_target_rows and thd_target_rows:
                has_pk_collision = any(
                    all(
                        r2.get(c.name) is not None and r2.get(c.name) == r3.get(c.name)
                        for c in pk_cols
                    )
                    for r2 in sec_target_rows
                    for r3 in thd_target_rows
                )
                if has_pk_collision:
                    if len(sec_target_rows) > 1 and len(thd_target_rows) > 1:
                        sec_target_rows = sec_target_rows[:1]
                        thd_target_rows = thd_target_rows[1:]
                    elif len(pk_cols) > 1:
                        gb_col_uppers = {
                            gc.upper() for gt, gc in group_by_cols if gt.upper() == table_name.upper()
                        }
                        vary_pk = next(
                            (
                                c for c in pk_cols
                                if c.name.upper() not in gb_col_uppers
                                and c.name.upper() != column_name.upper()
                                and c.name.upper() not in fk_cols
                                and c.name.upper() not in ref_by_other
                                and c.name.upper() not in join_cols
                            ),
                            None,
                        )
                        if vary_pk is not None:
                            for r3 in thd_target_rows:
                                r3[vary_pk.name] = generate_unique_value_for_column(vary_pk)

            for g_idx, g in enumerate([first_group, second_group, third_group]):
                for t_name in mock_data_2:
                    if t_name == table_name and g_idx == 1:
                        mock_data_2[t_name].extend(sec_target_rows)
                    elif t_name == table_name and g_idx == 2:
                        mock_data_2[t_name].extend(thd_target_rows)
                    elif t_name in g:
                        mock_data_2[t_name].extend(copy.deepcopy(g[t_name]))

            if table_obj and first_group.get(table_name):
                if (
                    len(pk_cols) == 1
                    and pk_cols[0].name.upper() != column_name.upper()
                    and pk_cols[0].name.upper() not in fk_cols
                    and pk_cols[0].name.upper() not in ref_by_other
                    and pk_cols[0].name.upper() not in join_cols
                ):
                    companion_row = copy.deepcopy(first_group[table_name][0])
                    companion_row[column_name] = None
                    companion_row[pk_cols[0].name] = generate_unique_value_for_column(pk_cols[0])
                    for u_col in table_obj.columns:
                        if (
                            (u_col.is_unique or u_col.name.upper() in singleton_gb_cols)
                            and not u_col.is_primary_key
                            and u_col.name.upper() != column_name.upper()
                        ):
                            if (
                                u_col.name.upper() not in fk_cols
                                and u_col.name.upper() not in ref_by_other
                                and u_col.name.upper() not in join_cols
                            ):
                                companion_row[u_col.name] = generate_unique_value_for_column(u_col)
                    mock_data_2[table_name].append(companion_row)

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}_mixed_nulls",
                    data=deduplicate_mock_data(schema, mock_data_2),
                    tags=["aggregate_attack", "null_attack"],
                    description=f"Targets Aggregate Null Handling bugs. Dataset creates a group that mixes both NULL and non-NULL values for `{table_name}.{column_name}`. This verifies that aggregate functions (like `SUM` or `AVG`) correctly skip the NULL rows when calculating their results rather than propagating NULL or failing."
                )
            )

            # Dataset 3: Standalone NULL group
            mock_data_3 = {t_name: [] for t_name in schema.tables}
            for t_name in mock_data_3:
                if t_name in second_group:
                    mock_data_3[t_name].extend(copy.deepcopy(second_group[t_name]))

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}_standalone_nulls",
                    data=deduplicate_mock_data(schema, mock_data_3),
                    tags=["aggregate_attack", "null_attack"],
                    description=f"Targets Aggregate Null Handling bugs. Dataset includes ONLY a group where `{table_name}.{column_name}` is entirely NULL, without any other valid groups. This strict dataset isolates aggregate null behavior and prevents unintended cross-pollution of results, which is especially important for catching bugs in scalar subquery aggregations."
                )
            )

        # Cross-table / joint NULL injection:
        # When the same column name appears across multiple tables in the query's aggregate targets,
        # or multiple columns participate in an aggregate, setting only one to NULL leaves the others
        # non-null, preventing the aggregate from evaluating over an entirely NULL domain.
        col_to_tables: Dict[str, List[str]] = {}
        for t_name, c_name in targets:
            col_to_tables.setdefault(c_name, []).append(t_name)

        seen_joint_injections = set()
        for c_name, t_names in col_to_tables.items():
            if len(t_names) > 1:
                joint_injections = tuple(sorted((t, c_name) for t in t_names))
                if joint_injections not in seen_joint_injections:
                    seen_joint_injections.add(joint_injections)
                    joint_group = generate_base_dataset(schema, parsed_query, null_injections=list(joint_injections))
                    mock_data_joint = {t_name: [] for t_name in schema.tables}
                    for t_name in mock_data_joint:
                        if t_name in joint_group:
                            mock_data_joint[t_name].extend(copy.deepcopy(joint_group[t_name]))
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_all_tables_null",
                            data=deduplicate_mock_data(schema, mock_data_joint),
                            tags=["aggregate_attack", "null_attack"],
                            description=f"Targets Aggregate Null Handling bugs across multiple tables. Injects NULL for `{c_name}` across all contributing tables ({', '.join(t_names)}). This ensures that aggregate calculations combining `{c_name}` from multiple tables evaluate over an all-NULL domain (e.g. testing SUM returning NULL vs COALESCE(..., 0))."
                        )
                    )

        # Also inspect aggregate function expressions with multiple column operands
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
            active_tables = self._active_tables(schema, parsed_query)
            for node in ast.find_all(exp.AggFunc):
                col_nodes = self._find_columns(node)
                expr_targets = []
                for cn in col_nodes:
                    resolved = resolve_query_column(schema, parsed_query, cn.table, cn.name)
                    if resolved:
                        t_name, col_name = resolved
                        table = schema.tables.get(t_name)
                        if table:
                            col = next((c for c in table.columns if c.name == col_name), None)
                            if self._can_null_column(schema, t_name, col, active_tables=active_tables):
                                expr_targets.append((t_name, col_name))
                if len(expr_targets) > 1:
                    joint_injections = tuple(sorted(set(expr_targets)))
                    if joint_injections not in seen_joint_injections:
                        seen_joint_injections.add(joint_injections)
                        joint_group = generate_base_dataset(schema, parsed_query, null_injections=list(joint_injections))
                        mock_data_joint = {t_name: [] for t_name in schema.tables}
                        for t_name in mock_data_joint:
                            if t_name in joint_group:
                                mock_data_joint[t_name].extend(copy.deepcopy(joint_group[t_name]))
                        tag = "_".join(f"{t}_{c}" for t, c in joint_injections)
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_{tag}_joint_null",
                                data=deduplicate_mock_data(schema, mock_data_joint),
                                tags=["aggregate_attack", "null_attack"],
                                description=f"Targets Aggregate Null Handling bugs for multi-column aggregate expressions. Injects NULL simultaneously for all operand columns ({tag}) to evaluate the aggregate on an all-NULL input."
                            )
                        )

            has_count_star = any(
                isinstance(n, exp.Count) and isinstance(n.this, exp.Star)
                for n in ast.find_all(exp.AggFunc)
            )
            if has_count_star:
                where_constrained = self._where_constrained_cols(schema, parsed_query, ast)
                gb_constrained = set()
                for term in parsed_query.get("group_by", []):
                    res_gb = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
                    if res_gb:
                        gb_constrained.add((res_gb[0].upper(), res_gb[1].upper()))
                target_set_upper = {(t.upper(), c.upper()) for t, c in targets}
                batch_null_cols: List[ tuple[str, str] ] = []
                has_uncovered_col = False
                for t in parsed_query.get("tables", []):
                    t_name = t.get("name")
                    table = schema.tables.get(t_name) if t_name else None
                    if not table:
                        continue
                    fk_col_uppers = {fk.column_name.upper() for fk in table.foreign_keys}
                    for col in table.columns:
                        key_up = (t_name.upper(), col.name.upper())
                        if (
                            not col.is_primary_key
                            and col.name.upper() not in fk_col_uppers
                            and key_up not in where_constrained
                            and key_up not in gb_constrained
                            and self._can_null_column(schema, t_name, col, active_tables=active_tables)
                        ):
                            if (t_name, col.name) not in batch_null_cols:
                                batch_null_cols.append((t_name, col.name))
                                if key_up not in target_set_upper:
                                    has_uncovered_col = True

                if has_uncovered_col and len(batch_null_cols) > 1:
                    batch_group = generate_base_dataset(schema, parsed_query, null_injections=batch_null_cols)
                    mock_batch_only = {t_name: [] for t_name in schema.tables}
                    for g in [first_group, batch_group]:
                        for t_name in mock_batch_only:
                            if t_name in g:
                                mock_batch_only[t_name].extend(copy.deepcopy(g[t_name]))
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_batch_nullable_cols_only_nulls",
                            data=deduplicate_mock_data(schema, mock_batch_only),
                            tags=["aggregate_attack", "null_attack"],
                            description="Targets Aggregate Null Handling bugs for COUNT(*). Combines a baseline row with a row where all unconstrained nullable columns across active tables are set to NULL, differentiating COUNT(*) from COUNT(col) on any nullable column."
                        )
                    )
                    mock_batch_standalone = {t_name: [] for t_name in schema.tables}
                    for t_name in mock_batch_standalone:
                        if t_name in batch_group:
                            mock_batch_standalone[t_name].extend(copy.deepcopy(batch_group[t_name]))
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_batch_nullable_cols_standalone_nulls",
                            data=deduplicate_mock_data(schema, mock_batch_standalone),
                            tags=["aggregate_attack", "null_attack"],
                            description="Targets Aggregate Null Handling bugs for COUNT(*). Includes only a row where all unconstrained nullable columns across active tables are NULL, isolating COUNT(*) (1) from COUNT(col) (0)."
                        )
                    )
        except Exception:
            pass

        return datasets
