"""
AggregateFunctionAttackStrategy Module

Target semantic bug: Wrong aggregate function (SUM, AVG, MIN, MAX, COUNT) or AVG rounding/boundary errors over a projected column.
Algorithm & Dataset Design:
Generates datasets with distinct numeric and non-numeric values across properly joined group rows such that:
1. Changing aggregate functions (e.g., SUM vs AVG vs MIN vs MAX vs COUNT) produces mathematically distinct scalar output values.
2. Symmetric 3-row groups test exact AVG comparison boundaries (middle row == AVG).
3. Asymmetric 3-row groups whose sum is not divisible by 3 produce non-terminating repeating decimal averages (e.g., .6666...), refuting missing ROUND, wrong ROUND scale, or CAST-to-REAL/INT mutations.
4. Scaled AVG boundary 2-row groups (`Avg_scaled_boundary`) synthesize integer pairs `[x1, x2]` at the IEEE-754 binary64 significand / representation boundary where cross-multiplied integer comparisons (`col * A OP AVG(col) * B`) diverge from floating-point ratio comparisons (`col OP AVG(col) * R`, where `R = B / A`).
"""

from typing import Any, Dict, List
import copy

import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import distinct_satisfying_where_value
from dataset_generator.value_generator import generate_unique_value_for_column
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    deduplicate_dataset,
    generate_base_dataset,
    get_singleton_having_group_cols,
    next_distinct_value,
    resolve_query_column,
)


class AggregateFunctionAttackStrategy(AttackStrategy):
    """
    Target semantic bug: wrong aggregate function or AVG boundary/precision mutation over a concrete column.

    Algorithm & Dataset Design:
    The strategy finds aggregate calls in the query AST whose argument is a
    real column. For each aggregate argument, it builds multi-row groups that satisfy the
    query constraints, keep GROUP BY keys equal, propagate new primary/unique join keys to
    joined partner tables in the same equivalence class, and assign distinct values to the
    aggregate argument. For AVG over numeric columns, it additionally constructs a 3-row
    symmetric boundary group (average equals middle value) and a 3-row non-terminating
    decimal group (sum not divisible by 3) to distinguish ROUND scales and unrounded casts.
    """

    AGGREGATES = (exp.Sum, exp.Avg, exp.Min, exp.Max, exp.Count)

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query))

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str, str]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        targets = []
        for node in ast.find_all(self.AGGREGATES):
            for col in node.find_all(exp.Column):
                col_tbl = col.table
                if not col_tbl:
                    enclosing_sel = col.find_ancestor(exp.Select)
                    if enclosing_sel:
                        for t_node in enclosing_sel.find_all(exp.Table):
                            if t_node.find_ancestor(exp.Select) is enclosing_sel:
                                st = schema.find_table(t_node.name)
                                if st and schema.find_column(st, col.name):
                                    col_tbl = t_node.alias or t_node.name
                                    break
                resolved = resolve_query_column(schema, parsed_query, col_tbl, col.name)
                if resolved:
                    target = (resolved[0], resolved[1], node.__class__.__name__)
                    if target not in targets:
                        targets.append(target)
        return targets

    def _extract_scaled_avg_targets(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        column_name: str,
    ) -> list[tuple[int, int, float, str]]:
        ast = parsed_query.get("ast")
        if not ast:
            return []

        def _unwrap(node: exp.Expression | None) -> exp.Expression | None:
            curr = node
            while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
                curr = curr.this
            return curr

        def _resolves_to_target(col_node: exp.Column) -> bool:
            col_tbl = col_node.table
            if not col_tbl:
                enc_sel = col_node.find_ancestor(exp.Select)
                if enc_sel:
                    for t_node in enc_sel.find_all(exp.Table):
                        if t_node.find_ancestor(exp.Select) is enc_sel:
                            st = schema.find_table(t_node.name)
                            if st and schema.find_column(st, col_node.name):
                                col_tbl = t_node.alias or t_node.name
                                break
            res = resolve_query_column(schema, parsed_query, col_tbl, col_node.name)
            return bool(res and res[0].upper() == table_name.upper() and res[1].upper() == column_name.upper())

        def _parse_col_side(node: exp.Expression | None) -> float | None:
            curr = _unwrap(node)
            if curr is None or curr.find(exp.Avg) is not None or curr.find(exp.Subquery) is not None:
                return None
            if isinstance(curr, exp.Column) and _resolves_to_target(curr):
                return 1.0
            if isinstance(curr, exp.Mul):
                l_node, r_node = _unwrap(curr.left), _unwrap(curr.right)
                if isinstance(l_node, exp.Column) and isinstance(r_node, exp.Literal) and _resolves_to_target(l_node):
                    try:
                        return float(r_node.name)
                    except ValueError:
                        return None
                if isinstance(r_node, exp.Column) and isinstance(l_node, exp.Literal) and _resolves_to_target(r_node):
                    try:
                        return float(l_node.name)
                    except ValueError:
                        return None
            return None

        def _parse_avg_side(node: exp.Expression | None) -> tuple[str, float] | None:
            if node is None:
                return None
            avg_nodes = [
                a for a in node.find_all(exp.Avg)
                if any(_resolves_to_target(c) for c in a.find_all(exp.Column))
            ]
            if not avg_nodes:
                return None
            for mul_node in node.find_all(exp.Mul):
                l_node, r_node = _unwrap(mul_node.left), _unwrap(mul_node.right)
                if isinstance(r_node, exp.Literal) and l_node and l_node.find(exp.Avg) is not None:
                    try:
                        return str(r_node.name), float(r_node.name)
                    except ValueError:
                        pass
                if isinstance(l_node, exp.Literal) and r_node and r_node.find(exp.Avg) is not None:
                    try:
                        return str(l_node.name), float(l_node.name)
                    except ValueError:
                        pass
            return None

        inv_op = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "EQ": "EQ", "NEQ": "NEQ"}
        results: list[tuple[int, int, float, str]] = []
        seen = set()

        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)):
            op_name = comp.__class__.__name__.upper()
            for col_side, avg_side, eff_op in (
                (comp.left, comp.right, op_name),
                (comp.right, comp.left, inv_op.get(op_name, op_name)),
            ):
                col_mult = _parse_col_side(col_side)
                avg_info = _parse_avg_side(avg_side)
                if col_mult is None or avg_info is None or col_mult <= 0:
                    continue
                avg_str, avg_val = avg_info
                if avg_val <= 0:
                    continue
                if col_mult > 1.0:
                    a_int = int(round(col_mult))
                    b_int = int(round(avg_val))
                    if a_int <= 0 or b_int <= 0:
                        continue
                    r_flt = float(b_int) / float(a_int)
                else:
                    if "." not in avg_str and float(avg_val).is_integer():
                        continue
                    r_flt = float(avg_val)
                    dec_part = avg_str.split(".", 1)[1].rstrip("0") if "." in avg_str else ""
                    a_int = max(100, 10 ** max(1, len(dec_part)))
                    b_int = int(round(r_flt * a_int))
                    if a_int <= 0 or b_int <= 0:
                        continue
                item = (a_int, b_int, r_flt, eff_op)
                if item not in seen:
                    seen.add(item)
                    results.append(item)

        return results

    @staticmethod
    def _find_scaled_avg_boundary_pair(
        a_int: int, b_int: int, r_flt: float, op: str
    ) -> List[int] | None:
        if a_int <= 0 or b_int <= 0 or b_int >= 2 * a_int:
            return None

        def _eval_op(lhs: int | float, rhs: int | float) -> bool:
            if op == "GT":
                return lhs > rhs
            if op == "GTE":
                return lhs >= rhs
            if op == "LT":
                return lhs < rhs
            if op == "LTE":
                return lhs <= rhs
            if op == "EQ":
                return lhs == rhs
            if op == "NEQ":
                return lhs != rhs
            return lhs > rhs

        max_safe = (1 << 62) - 1
        for exp_k in range(44, 53):
            for offset in range(-5, 6):
                k_val = (1 << exp_k) + offset
                for d1 in (0, 1, -1, 2, -2):
                    for d2 in (0, 1, -1, 2, -2):
                        x1 = b_int * k_val + d1
                        x2 = (2 * a_int - b_int) * k_val + d2
                        if x1 <= 0 or x2 <= 0:
                            continue
                        if x1 * a_int >= max_safe or x2 * a_int >= max_safe:
                            continue
                        mu = (x1 + x2) / 2.0
                        rhs_int = mu * float(b_int)
                        rhs_flt = mu * r_flt
                        c_int = (
                            _eval_op(x1 * a_int, int(rhs_int))
                            if rhs_int.is_integer()
                            else _eval_op(float(x1 * a_int), rhs_int)
                        )
                        c_flt = (
                            _eval_op(x1, int(rhs_flt))
                            if rhs_flt.is_integer()
                            else _eval_op(float(x1), rhs_flt)
                        )
                        if c_int != c_flt:
                            return [x1, x2]
        return None

    def _build_group_dataset(
        self,
        schema: Schema,
        base_data: Dict[str, List[Dict[str, Any]]],
        table_name: str,
        column_name: str,
        values: List[Any],
        group_by_cols: set[tuple[str, str]],
        where_lit_cols: set[tuple[str, str]],
        equiv: Any,
        parsed_query: Dict[str, Any] | None = None,
    ) -> Dict[str, List[Dict[str, Any]]]:
        """
        Construct a dataset where `table_name` has `len(values)` rows in the same GROUP BY group
        with `column_name` assigned `values`, and propagate any modified PK/unique join keys
        across equivalence classes so joined tables match every row in the group.
        """
        mock_data = copy.deepcopy(base_data)
        table = schema.tables[table_name]
        first_row = copy.deepcopy(base_data[table_name][0])
        orig_val = first_row.get(column_name)
        first_row[column_name] = values[0]

        if values[0] != orig_val:
            col_root = equiv.find(col_key(table_name, column_name))
            for other_t, other_tbl_obj in schema.tables.items():
                if other_t != table_name and mock_data.get(other_t):
                    for mc in other_tbl_obj.columns:
                        if equiv.find(col_key(other_t, mc.name)) == col_root:
                            mock_data[other_t][0][mc.name] = values[0]

        table_rows = [first_row]
        fk_col_names = {fk.column_name.upper() for fk in table.foreign_keys}
        pk_cols = [col for col in table.columns if col.is_primary_key]
        modifiable_pks = [
            col for col in pk_cols
            if col.name != column_name
            and (table_name, col.name) not in group_by_cols
        ]
        modifiable_pks.sort(
            key=lambda col: (
                (table_name.upper(), col.name.upper()) in where_lit_cols,
                col.name.upper() in fk_col_names,
            )
        )

        cols_to_modify = []
        if modifiable_pks:
            cols_to_modify.append(modifiable_pks[0])
        elif pk_cols and not any(c.name == column_name for c in pk_cols):
            cols_to_modify.append(pk_cols[-1])

        for col in table.columns:
            if col.is_unique and not col.is_primary_key and col.name != column_name:
                if (table_name, col.name) not in group_by_cols:
                    cols_to_modify.append(col)

        singleton_gb_cols = (
            get_singleton_having_group_cols(parsed_query.get("ast"))
            if parsed_query and parsed_query.get("ast")
            else set()
        )
        for col in table.columns:
            if (
                col.name.upper() in singleton_gb_cols
                and col.name != column_name
                and col not in cols_to_modify
            ):
                cols_to_modify.append(col)

        target_col_obj = next((c for c in table.columns if c.name == column_name), None)
        target_is_unique = bool(target_col_obj and (target_col_obj.is_primary_key or target_col_obj.is_unique))

        for val in values[1:]:
            row_dup = copy.deepcopy(first_row)
            row_dup[column_name] = val
            modified_roots = {}

            if target_is_unique and val != first_row.get(column_name):
                modified_roots[equiv.find(col_key(table_name, column_name))] = val

            for column in cols_to_modify:
                existing_vals = {r.get(column.name) for r in table_rows}
                cand = (
                    distinct_satisfying_where_value(
                        schema,
                        parsed_query,
                        table_name,
                        column,
                        first_row,
                        row_dup,
                        allow_in_select=True,
                        disallowed_values=existing_vals,
                    )
                    if parsed_query is not None
                    else None
                )
                if cand is None or cand in existing_vals:
                    cand = generate_unique_value_for_column(column)
                    cand = solve_check_constraint_value(schema, table_name, column.name, column, cand, row_context=row_dup)
                    while cand in existing_vals:
                        cand = next_distinct_value(column, cand, schema=schema, table_name=table_name)
                row_dup[column.name] = cand
                modified_roots[equiv.find(col_key(table_name, column.name))] = cand

            table_rows.append(row_dup)

            if modified_roots:
                processed_tables = {table_name}
                progress = True
                while progress:
                    progress = False
                    for other_t, other_tbl_obj in schema.tables.items():
                        if other_t in processed_tables or not mock_data.get(other_t):
                            continue
                        matching_cols = [
                            c for c in other_tbl_obj.columns
                            if equiv.find(col_key(other_t, c.name)) in modified_roots
                        ]
                        if matching_cols:
                            processed_tables.add(other_t)
                            progress = True
                            other_dup = copy.deepcopy(mock_data[other_t][0])
                            for mc in matching_cols:
                                other_dup[mc.name] = modified_roots[equiv.find(col_key(other_t, mc.name))]

                            other_pks = [c for c in other_tbl_obj.columns if c.is_primary_key]
                            if other_pks and not any(c in matching_cols for c in other_pks):
                                other_mod_pks = [
                                    c for c in other_pks if (other_t, c.name) not in group_by_cols
                                ] or [other_pks[-1]]
                                pk_col = other_mod_pks[0]
                                pk_cand = generate_unique_value_for_column(pk_col)
                                existing_other_pks = {r.get(pk_col.name) for r in mock_data[other_t]}
                                while pk_cand in existing_other_pks:
                                    pk_cand = next_distinct_value(pk_col, pk_cand, schema=schema, table_name=other_t)
                                other_dup[pk_col.name] = pk_cand
                                modified_roots[equiv.find(col_key(other_t, pk_col.name))] = pk_cand

                            for uc in other_tbl_obj.columns:
                                if (
                                    uc.is_unique
                                    and not uc.is_primary_key
                                    and uc not in matching_cols
                                    and (other_t, uc.name) not in group_by_cols
                                ):
                                    uc_cand = generate_unique_value_for_column(uc)
                                    existing_ucs = {r.get(uc.name) for r in mock_data[other_t]}
                                    while uc_cand in existing_ucs:
                                        uc_cand = next_distinct_value(uc, uc_cand, schema=schema, table_name=other_t)
                                    other_dup[uc.name] = uc_cand
                                    modified_roots[equiv.find(col_key(other_t, uc.name))] = uc_cand

                            mock_data[other_t].append(other_dup)

        mock_data[table_name] = table_rows
        return deduplicate_dataset(schema, mock_data)

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)

        where_lit_cols = set()
        for lit in parsed_query.get("where_literals", []):
            res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res_lit:
                where_lit_cols.add((res_lit[0].upper(), res_lit[1].upper()))

        # Parse and resolve all GROUP BY columns
        singleton_gb_cols = get_singleton_having_group_cols(parsed_query.get("ast"))
        group_by_cols = set()
        for entry in parsed_query.get("group_by", []):
            resolved = resolve_query_column(schema, parsed_query, entry.get("table", ""), entry["column"])
            if resolved:
                if resolved[1].upper() not in singleton_gb_cols:
                    group_by_cols.add(resolved)
            else:
                for select in parsed_query.get("selects", []):
                    if select.get("alias") == entry["column"]:
                        resolved = resolve_query_column(schema, parsed_query, select.get("table", ""), select["column"])
                        if resolved and resolved[1].upper() not in singleton_gb_cols:
                            group_by_cols.add(resolved)

        for table_name, column_name, aggregate_name in self._targets(schema, parsed_query):
            base_data = generate_base_dataset(schema, parsed_query)
            if not base_data.get(table_name):
                continue

            table = schema.tables[table_name]
            first_row = base_data[table_name][0]

            aggregate_column = next(
                column for column in table.columns if column.name == column_name
            )

            is_group_by_col = (table_name, column_name) in group_by_cols and not (
                aggregate_column.is_primary_key or aggregate_column.is_unique
            )

            base_val = first_row.get(column_name)
            use_negative_offset = False
            has_eq = False

            if isinstance(base_val, (int, float)) and not isinstance(base_val, bool):
                # Detect constraints from where_literals to determine offset direction
                for literal in parsed_query.get("where_literals", []):
                    lit_resolved = resolve_query_column(schema, parsed_query, literal.get("table", ""), literal["column"])
                    if lit_resolved and lit_resolved[0] == table_name and lit_resolved[1] == column_name:
                        op = literal.get("operator", "EQ")
                        if op in ("LT", "LTE", "BetweenUpper"):
                            use_negative_offset = True
                        elif op in ("EQ", "In"):
                            has_eq = True

                if is_group_by_col:
                    if has_eq:
                        V = base_val
                    else:
                        if use_negative_offset:
                            V = base_val - 5
                            while V in (0, 1, 3):
                                V -= 1
                        else:
                            V = base_val + 5
                            while V in (0, 1, 3):
                                V += 1
                    v1 = v2 = v3 = V
                else:
                    if aggregate_column.is_primary_key or aggregate_column.is_unique:
                        v1 = generate_unique_value_for_column(aggregate_column)
                        v2 = generate_unique_value_for_column(aggregate_column)
                    elif has_eq:
                        v1 = base_val
                        v2 = base_val
                    elif use_negative_offset:
                        v1 = base_val - 2
                        v2 = base_val - 5
                    else:
                        v1 = base_val + 2
                        v2 = base_val + 5
            else:
                # Text, temporal, or boolean column: generate unique distinct values
                if is_group_by_col:
                    V = generate_unique_value_for_column(aggregate_column)
                    v1 = v2 = v3 = V
                else:
                    v1 = generate_unique_value_for_column(aggregate_column)
                    v2 = generate_unique_value_for_column(aggregate_column)

            if is_group_by_col:
                mock_data = self._build_group_dataset(
                    schema, base_data, table_name, column_name,
                    [v1, v2, v3], group_by_cols, where_lit_cols, equiv,
                    parsed_query=parsed_query,
                )
                description = f"Targets Wrong Aggregate Function bug. Dataset injects exactly three distinct, carefully chosen values for `{table_name}.{column_name}` within a single group. This specific combination guarantees that `SUM`, `AVG`, `MIN`, `MAX`, and `COUNT` will each evaluate to completely different outputs, ensuring any mutant replacing the aggregate function is caught."
            else:
                mock_data = self._build_group_dataset(
                    schema, base_data, table_name, column_name,
                    [v1, v2], group_by_cols, where_lit_cols, equiv,
                    parsed_query=parsed_query,
                )
                description = f"Targets Wrong Aggregate Function bug. Dataset injects exactly two distinct values for `{table_name}.{column_name}`. This combination ensures that the output of the target aggregate function differs from other aggregate functions, catching mutated aggregations."

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{aggregate_name}_{table_name}_{column_name}",
                    data=mock_data,
                    tags=["aggregate_attack"],
                    description=description
                )
            )

            if aggregate_name == "Avg" and isinstance(base_val, (int, float)) and not isinstance(base_val, bool) and not is_group_by_col:
                step = 2.0 if isinstance(base_val, float) else 2
                b_data = self._build_group_dataset(
                    schema, base_data, table_name, column_name,
                    [base_val - step, base_val, base_val + step],
                    group_by_cols, where_lit_cols, equiv,
                    parsed_query=parsed_query,
                )
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_Avg_boundary_{table_name}_{column_name}",
                        data=b_data,
                        tags=["aggregate_attack"],
                        description=f"Targets AVG comparison boundary bugs. Dataset injects three symmetric values for `{table_name}.{column_name}` such that the middle value equals the group average, refuting mutants with wrong inequality bounds against AVG."
                    )
                )

                if not has_eq:
                    unit = 1.0 if isinstance(base_val, float) else 1
                    if use_negative_offset:
                        p_vals = [base_val, base_val - unit, base_val - 4 * unit]
                    else:
                        p_vals = [base_val, base_val + unit, base_val + 4 * unit]
                    p_data = self._build_group_dataset(
                        schema, base_data, table_name, column_name,
                        p_vals, group_by_cols, where_lit_cols, equiv,
                        parsed_query=parsed_query,
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_Avg_precision_{table_name}_{column_name}",
                            data=p_data,
                            tags=["aggregate_attack", "math_function_attack"],
                            description=f"Targets AVG rounding and precision bugs. Dataset injects three values for `{table_name}.{column_name}` within the same group whose sum is not divisible by 3, producing a non-terminating repeating decimal average to distinguish ROUND scales from unrounded AVG or CAST expressions."
                        )
                    )

                for a_int, b_int, r_flt, eff_op in self._extract_scaled_avg_targets(
                    schema, parsed_query, table_name, column_name
                ):
                    scaled_pair = self._find_scaled_avg_boundary_pair(a_int, b_int, r_flt, eff_op)
                    if scaled_pair is not None:
                        s_data = self._build_group_dataset(
                            schema,
                            base_data,
                            table_name,
                            column_name,
                            scaled_pair,
                            group_by_cols,
                            where_lit_cols,
                            equiv,
                            parsed_query=parsed_query,
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_Avg_scaled_boundary_{table_name}_{column_name}",
                                data=s_data,
                                tags=["aggregate_attack", "math_function_attack"],
                                description=(
                                    f"Targets cross-multiplied integer (`{column_name} * {a_int} {eff_op} AVG({column_name}) * {b_int}`) "
                                    f"vs floating-point ratio (`{column_name} {eff_op} AVG({column_name}) * {r_flt}`) boundary discrepancies "
                                    f"on `{table_name}.{column_name}`."
                                ),
                            )
                        )

        return datasets
