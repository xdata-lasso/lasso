"""
HavingAggregateAttackStrategy Module

Target semantic bug:
Comparison operator mismatch (>, <, >=, <=, =, !=, <>) or threshold mutations
on aggregate expressions (SUM, AVG, MIN, MAX) in HAVING clauses.

Algorithm & Dataset Design:
1. Locate HAVING clauses containing comparison predicates between aggregate functions
   (SUM, AVG, MIN, MAX) and numeric literal thresholds.
2. Formulate an exact boundary constraint system for group sizes N in [1, 2, 3]:
   - Target aggregate evaluates to exact boundary values: threshold, threshold + offset, threshold - offset.
   - All other co-occurring HAVING predicates (e.g. MAX(col) < 75 alongside SUM(col) > 100)
     are preserved as simultaneous constraints to ensure joint satisfiability.
3. Solve for valid column values across the N group rows using Z3 SMT solver.
4. Materialize exactly N rows for the aggregated table sharing join/foreign keys with
   a single parent row in joined tables, forming exactly one group that lands on the
   operator boundary. This refutes strict vs non-strict inequality and off-by-one mutations.
"""

from typing import Any, Dict, List, Optional, Tuple
import copy
import sqlglot
import sqlglot.expressions as exp
import z3

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.distinct_attack import distinct_satisfying_where_value
from dataset_generator import (
    build_equivalence_classes,
    col_key,
    deduplicate_dataset,
    generate_base_dataset,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.value_generator import (
    DataFactory,
    generate_unique_value_for_column,
)


class HavingAggregateAttackStrategy(AttackStrategy):
    """
    Target semantic bug: HAVING aggregate comparison boundary mutations.
    Generates datasets where an aggregate group evaluates to threshold, threshold + 1, or threshold - 1,
    while simultaneously satisfying all co-occurring HAVING predicates.
    """

    AGGREGATES = (exp.Sum, exp.Avg, exp.Min, exp.Max)
    COMPARISONS = (exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ)

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._find_targets(schema, parsed_query))

    def _find_targets(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Tuple[str, str, Any, float, Any, exp.Having]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        targets = []
        for having in ast.find_all(exp.Having):
            for comp in having.find_all(self.COMPARISONS):
                left, right = comp.left, comp.right
                agg_node = None
                lit_node = None
                is_reversed = False

                if isinstance(left, self.AGGREGATES) and isinstance(right, exp.Literal):
                    agg_node = left
                    lit_node = right
                elif isinstance(right, self.AGGREGATES) and isinstance(left, exp.Literal):
                    agg_node = right
                    lit_node = left
                    is_reversed = True

                if not agg_node or not lit_node or lit_node.is_string:
                    continue

                # Find the column inside agg_node
                cols = list(agg_node.find_all(exp.Column))
                if not cols:
                    continue
                col_expr = cols[0]
                resolved = resolve_query_column(schema, parsed_query, col_expr.table, col_expr.name)
                if not resolved:
                    continue

                table_name, col_name = resolved
                try:
                    val = float(lit_node.name)
                except (ValueError, TypeError):
                    continue

                op_class = comp.__class__
                if is_reversed:
                    reverse_map = {
                        exp.GT: exp.LT,
                        exp.GTE: exp.LTE,
                        exp.LT: exp.GT,
                        exp.LTE: exp.GTE,
                        exp.EQ: exp.EQ,
                        exp.NEQ: exp.NEQ,
                    }
                    op_class = reverse_map.get(op_class, op_class)

                targets.append((table_name, col_name, agg_node.__class__, val, op_class, having))

        return targets

    def _solve_group_values(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        target_table: str,
        target_col: str,
        target_agg_cls: Any,
        boundary_val: float,
        having_node: exp.Having,
        group_size: int,
    ) -> Optional[List[Dict[str, Any]]]:
        """
        Use Z3 to find concrete values for target_col (and any other columns in target_table
        referenced in the HAVING clause) across group_size rows, such that:
        1. target_agg(target_col) == boundary_val
        2. All other comparison predicates in having_node evaluate to True.
        """
        solver = z3.Solver()
        N = group_size

        # Identify all columns of target_table referenced in having_node
        table_obj = schema.tables.get(target_table)
        if not table_obj:
            return None

        referenced_cols: Dict[str, Any] = {}
        for c in having_node.find_all(exp.Column):
            res = resolve_query_column(schema, parsed_query, c.table, c.name)
            if res and res[0] == target_table:
                col_name = res[1]
                col_obj = next((col for col in table_obj.columns if col.name == col_name), None)
                if col_obj:
                    referenced_cols[col_name] = col_obj

        if target_col not in referenced_cols:
            col_obj = next((col for col in table_obj.columns if col.name == target_col), None)
            if col_obj:
                referenced_cols[target_col] = col_obj

        # Create Z3 variables: for each referenced column, N row variables
        z3_vars: Dict[str, List[Any]] = {}
        is_int_target = False

        for c_name, c_obj in referenced_cols.items():
            dt = (c_obj.data_type or "").lower()
            is_int = "int" in dt or "serial" in dt
            if c_name == target_col and is_int:
                is_int_target = True

            vars_for_c = []
            for i in range(N):
                var = z3.Int(f"{c_name}_{i}") if is_int else z3.Real(f"{c_name}_{i}")
                vars_for_c.append(var)
                # Lower bound heuristic: if boundary_val >= 0, keep values >= 0
                if boundary_val >= 0:
                    solver.add(var >= (0 if is_int else z3.RealVal(0)))
            z3_vars[c_name] = vars_for_c

        # Helper to build Z3 aggregate expression
        def build_z3_agg(agg_cls: Any, c_name: str) -> Any:
            row_vars = z3_vars.get(c_name)
            if not row_vars:
                return None
            if agg_cls == exp.Sum:
                return z3.Sum(row_vars)
            elif agg_cls == exp.Avg:
                real_vars = [z3.ToReal(v) if v.sort() == z3.IntSort() else v for v in row_vars]
                return z3.Sum(real_vars) / z3.RealVal(N)
            elif agg_cls == exp.Max:
                max_v = z3.Int(f"max_{c_name}") if row_vars[0].sort() == z3.IntSort() else z3.Real(f"max_{c_name}")
                for v in row_vars:
                    solver.add(max_v >= v)
                solver.add(z3.Or([max_v == v for v in row_vars]))
                return max_v
            elif agg_cls == exp.Min:
                min_v = z3.Int(f"min_{c_name}") if row_vars[0].sort() == z3.IntSort() else z3.Real(f"min_{c_name}")
                for v in row_vars:
                    solver.add(min_v <= v)
                solver.add(z3.Or([min_v == v for v in row_vars]))
                return min_v
            return None

        # 1. Target aggregate boundary constraint
        target_z3_agg = build_z3_agg(target_agg_cls, target_col)
        if target_z3_agg is None:
            return None

        if is_int_target:
            solver.add(target_z3_agg == int(round(boundary_val)))
        else:
            solver.add(target_z3_agg == z3.RealVal(boundary_val))

        # 2. Add other predicates from having_node
        for comp in having_node.find_all(self.COMPARISONS):
            left, right = comp.left, comp.right
            # Check if this comparison is the target one
            cols_in_left = list(left.find_all(exp.Column))
            cols_in_right = list(right.find_all(exp.Column))
            is_target_comp = False
            if isinstance(left, self.AGGREGATES) and cols_in_left:
                res = resolve_query_column(schema, parsed_query, cols_in_left[0].table, cols_in_left[0].name)
                if res and res == (target_table, target_col) and isinstance(left, target_agg_cls):
                    is_target_comp = True
            elif isinstance(right, self.AGGREGATES) and cols_in_right:
                res = resolve_query_column(schema, parsed_query, cols_in_right[0].table, cols_in_right[0].name)
                if res and res == (target_table, target_col) and isinstance(right, target_agg_cls):
                    is_target_comp = True

            if is_target_comp:
                continue

            # Translate this other predicate
            def translate_operand(op_node: exp.Expression) -> Any:
                if isinstance(op_node, exp.Count):
                    return z3.IntVal(N)
                if isinstance(op_node, self.AGGREGATES):
                    c_list = list(op_node.find_all(exp.Column))
                    if c_list:
                        r = resolve_query_column(schema, parsed_query, c_list[0].table, c_list[0].name)
                        if r and r[0] == target_table:
                            return build_z3_agg(op_node.__class__, r[1])
                elif isinstance(op_node, exp.Literal) and not op_node.is_string:
                    try:
                        n = float(op_node.name)
                        return int(n) if n.is_integer() else z3.RealVal(n)
                    except Exception:
                        return None
                return None

            z3_l = translate_operand(left)
            z3_r = translate_operand(right)
            if z3_l is not None and z3_r is not None:
                if isinstance(comp, exp.GT):
                    solver.add(z3_l > z3_r)
                elif isinstance(comp, exp.GTE):
                    solver.add(z3_l >= z3_r)
                elif isinstance(comp, exp.LT):
                    solver.add(z3_l < z3_r)
                elif isinstance(comp, exp.LTE):
                    solver.add(z3_l <= z3_r)
                elif isinstance(comp, exp.EQ):
                    solver.add(z3_l == z3_r)
                elif isinstance(comp, exp.NEQ):
                    solver.add(z3_l != z3_r)

        spread_applied = False
        if N >= 2 and target_agg_cls == exp.Sum and boundary_val > 0 and target_col in z3_vars:
            t_vars = z3_vars[target_col]
            if is_int_target:
                b_int = int(round(boundary_val))
                if b_int >= N:
                    low_v = max(1, b_int // (N + 1))
                    high_v = max(low_v, b_int - low_v)
                    solver.push()
                    for v in t_vars:
                        solver.add(v >= low_v, v <= high_v)
                    if solver.check() == z3.sat:
                        spread_applied = True
                    else:
                        solver.pop()
            else:
                if boundary_val >= N:
                    low_v = float(max(1, int(boundary_val) // (N + 1)))
                else:
                    low_v = boundary_val / 4.0
                high_v = boundary_val - low_v
                solver.push()
                for v in t_vars:
                    solver.add(v >= z3.RealVal(low_v), v <= z3.RealVal(high_v))
                if solver.check() == z3.sat:
                    spread_applied = True
                else:
                    solver.pop()

        if spread_applied or solver.check() == z3.sat:
            model = solver.model()
            solved_rows = []
            for i in range(N):
                row_vals: Dict[str, Any] = {}
                for c_name, v_list in z3_vars.items():
                    m_val = model[v_list[i]]
                    if m_val is not None:
                        if z3.is_int(m_val):
                            row_vals[c_name] = m_val.as_long()
                        elif z3.is_real(m_val):
                            row_vals[c_name] = float(m_val.as_decimal(4).rstrip("?"))
                solved_rows.append(row_vals)
            return solved_rows

        return None

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets: List[Dataset] = []
        targets = self._find_targets(schema, parsed_query)
        if not targets:
            return datasets

        base_data = generate_base_dataset(schema, parsed_query)
        equiv, _, _ = build_equivalence_classes(schema, parsed_query)
        where_lit_cols = set()
        for lit in parsed_query.get("where_literals", []):
            res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res_lit:
                where_lit_cols.add((res_lit[0].upper(), res_lit[1].upper()))

        group_by_cols = set()
        for entry in parsed_query.get("group_by", []):
            resolved_gb = resolve_query_column(schema, parsed_query, entry.get("table", ""), entry["column"])
            if resolved_gb:
                group_by_cols.add(resolved_gb)
        ast = parsed_query.get("ast")
        if ast:
            for grp in ast.find_all(exp.Group):
                for col_node in grp.find_all(exp.Column):
                    res_gb = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                    if res_gb:
                        group_by_cols.add(res_gb)

        generated_signatures = set()

        for target_table, target_col, agg_cls, threshold_val, op_cls, having_node in targets:
            if not base_data.get(target_table):
                continue

            table = schema.tables[target_table]
            base_row = base_data[target_table][0]
            fk_col_names = {fk.column_name.upper() for fk in table.foreign_keys}
            pk_cols = [col for col in table.columns if col.is_primary_key]

            is_int_thresh = threshold_val.is_integer()
            offsets = [0, 1, -1] if is_int_thresh else [0.0, 1.0, -1.0]

            for offset in offsets:
                boundary_val = threshold_val + offset
                # Only explore reasonable non-negative boundaries if threshold was positive
                if threshold_val >= 0 and boundary_val < 0:
                    continue

                # Try group sizes N in [1, 2] (or [2] for SUM when threshold > 0 and N=1 fails),
                # plus any minimum group size required by co-occurring HAVING COUNT predicates.
                candidate_sizes = [1, 2] if agg_cls != exp.Sum else [2, 1]
                for comp in having_node.find_all(self.COMPARISONS):
                    cnt_lit = None
                    op_c = comp.__class__
                    if isinstance(comp.left, exp.Count) and isinstance(comp.right, exp.Literal) and not comp.right.is_string:
                        cnt_lit = comp.right
                    elif isinstance(comp.right, exp.Count) and isinstance(comp.left, exp.Literal) and not comp.left.is_string:
                        cnt_lit = comp.left
                        rev = {exp.GT: exp.LT, exp.GTE: exp.LTE, exp.LT: exp.GT, exp.LTE: exp.GTE, exp.EQ: exp.EQ, exp.NEQ: exp.NEQ}
                        op_c = rev.get(op_c, op_c)
                    if cnt_lit is not None:
                        try:
                            c_val = int(float(cnt_lit.name))
                            req_n = c_val + 1 if op_c == exp.GT else (max(1, c_val - 1) if op_c == exp.LT else max(1, c_val))
                            if req_n not in candidate_sizes:
                                candidate_sizes.insert(0, req_n)
                        except (ValueError, TypeError):
                            pass

                for group_size in candidate_sizes:
                    sig = (target_table, target_col, agg_cls.__name__, boundary_val, group_size)
                    if sig in generated_signatures:
                        continue

                    solved_rows = self._solve_group_values(
                        schema,
                        parsed_query,
                        target_table,
                        target_col,
                        agg_cls,
                        boundary_val,
                        having_node,
                        group_size,
                    )

                    if not solved_rows:
                        continue

                    generated_signatures.add(sig)

                    # Reset uniqueness in Faker before dataset creation
                    DataFactory.get_instance().clear_uniqueness()

                    modifiable_pks = [
                        col for col in pk_cols
                        if col.name not in solved_rows[0]
                        and (target_table, col.name) not in group_by_cols
                    ]
                    modifiable_pks.sort(
                        key=lambda col: (
                            (target_table.upper(), col.name.upper()) in where_lit_cols,
                            col.name.upper() in fk_col_names,
                        )
                    )
                    cols_to_modify = []
                    if modifiable_pks:
                        cols_to_modify.append(modifiable_pks[0])
                    elif pk_cols and not any(c.name in solved_rows[0] for c in pk_cols):
                        cols_to_modify.append(pk_cols[-1])

                    for col in table.columns:
                        if col.is_unique and not col.is_primary_key and col.name not in solved_rows[0]:
                            if (target_table, col.name) not in group_by_cols:
                                cols_to_modify.append(col)

                    # Materialize table rows preserving group-by keys, join keys, and WHERE constraints
                    mock_data = {
                        t_name: ([copy.deepcopy(rows[0])] if rows else [])
                        for t_name, rows in base_data.items()
                    }
                    first_row = copy.deepcopy(base_row)
                    for col_name, val in solved_rows[0].items():
                        first_row[col_name] = val
                    new_rows = [first_row]

                    for s_vals in solved_rows[1:]:
                        row_dup = copy.deepcopy(first_row)
                        for col_name, val in s_vals.items():
                            row_dup[col_name] = val
                        modified_roots = {}
                        for column in cols_to_modify:
                            existing_vals = {r.get(column.name) for r in new_rows}
                            cand = distinct_satisfying_where_value(
                                schema,
                                parsed_query,
                                target_table,
                                column,
                                first_row,
                                row_dup,
                                allow_in_select=True,
                                disallowed_values=existing_vals,
                            )
                            if cand is None or cand in existing_vals:
                                cand = generate_unique_value_for_column(column)
                                cand = solve_check_constraint_value(
                                    schema,
                                    target_table,
                                    column.name,
                                    column,
                                    cand,
                                    disallowed_values=existing_vals,
                                    row_context=row_dup,
                                )
                                while cand in existing_vals:
                                    cand = next_distinct_value(column, cand, schema=schema, table_name=target_table)
                            row_dup[column.name] = cand
                            modified_roots[equiv.find(col_key(target_table, column.name))] = cand

                        new_rows.append(row_dup)

                        if modified_roots:
                            for other_t, other_tbl_obj in schema.tables.items():
                                if other_t == target_table or not mock_data.get(other_t):
                                    continue
                                matching_cols = [
                                    c for c in other_tbl_obj.columns
                                    if equiv.find(col_key(other_t, c.name)) in modified_roots
                                ]
                                if matching_cols:
                                    other_dup = copy.deepcopy(mock_data[other_t][0])
                                    for mc in matching_cols:
                                        other_dup[mc.name] = modified_roots[equiv.find(col_key(other_t, mc.name))]
                                    mock_data[other_t].append(other_dup)

                    mock_data[target_table] = new_rows
                    mock_data = deduplicate_dataset(schema, mock_data)

                    strategy_name = (
                        f"{self.__class__.__name__}_{target_table}_{target_col}_"
                        f"{agg_cls.__name__}_b{int(boundary_val) if is_int_thresh else boundary_val}_n{group_size}"
                    )

                    datasets.append(
                        Dataset(
                            strategy_name=strategy_name,
                            data=mock_data,
                            tags=["having_aggregate_attack", "comparison_attack"],
                            description=(
                                f"Targets HAVING {agg_cls.__name__} comparison boundary mutations. "
                                f"Constructs {group_size} rows in `{target_table}` where {agg_cls.__name__}({target_col}) "
                                f"evaluates to exact boundary value {boundary_val} (offset {offset} from threshold {threshold_val}), "
                                f"while satisfying all other co-occurring HAVING conditions. This refutes strict vs non-strict "
                                f"operator mutations."
                            ),
                        )
                    )

        return datasets
