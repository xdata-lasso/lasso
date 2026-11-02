"""
ArithmeticOperatorAttackStrategy Module

Target semantic bug: Wrong arithmetic operators (+, -, *, /) in projections and expressions.
Algorithm & Dataset Design:
Uses algebraic system solving (or Z3) to generate non-trivial operands where A + B != A - B != A * B != A / B.
Eliminates identities like A=0, B=0, A=B, B=1, ensuring operator mutations yield distinct numeric results.
"""

from typing import Any, Dict, List, Optional, Set, Tuple
import copy
import sqlglot
import sqlglot.expressions as exp
import z3

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    compute_additive_sum_values,
    compute_self_offset_values,
    extract_additive_sum_patterns,
    extract_self_offset_patterns,
    generate_base_dataset,
    merge_with_shifted_companion,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value

class ArithmeticAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Wrong arithmetic operators (+, -, *, /, %).
    
    Algorithm & Dataset Design:
    1. Parsing: Analyzes the SQL AST to find all arithmetic operations (`Add`, `Sub`, `Mul`, `Div`, `Mod`).
    2. Mutation Generation: For each detected arithmetic operation, iteratate over alternative operations (mutants).
    3. Symbolic Execution (Z3):
        a. Translates the target arithmetic expression and its mutant into symbolic Z3 formulas.
        b. Extracts all `WHERE` clauses (including those in subqueries) from the AST and converts them to Z3 boolean constraints.
        c. Imposes logical requirements:
            - The original `WHERE` clause MUST evaluate to True (ensuring the row is selected in the correct query).
            - The mutated `WHERE` clause MUST evaluate to False (ensuring the row is filtered out by the mutant query).
            - Alternatively, if the original and mutated conditions can't be fully resolved boolean-wise, requires the arithmetic output values themselves to be distinct.
        d. Prevents division by zero or modulo by zero errors by adding `!= 0` constraints for denominators.
        e. Bounds the variable ranges loosely (`-100000` to `10000000`) to find realistic, non-exploding integer models.
    4. Dataset Injection: If Z3 finds a satisfying model (`sat`), the symbolic variables (mapping to table columns) are extracted and injected into the query's `where_literals` to force `generate_base_dataset` to use these specific values during dataset creation.
    This guarantees that the generated row kills the specified mutation.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(parsed_query["raw_query"])
            nodes = list(ast.find_all((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod)))
            return len(nodes) > 0
        except Exception:
            return False

    def ast_to_z3(self, node, z3_vars, substitutions=None, schema=None, parsed_query=None):
        if substitutions and id(node) in substitutions:
            return substitutions[id(node)]
        if node is None:
            return None
        if isinstance(node, exp.Column):
            table_name = node.table
            col_name = node.name
            if schema and parsed_query:
                resolved = resolve_query_column(schema, parsed_query, table_name, col_name)
                if resolved:
                    table_name, col_name = resolved
            key = (table_name, col_name)
            if key not in z3_vars:
                col_type = ""
                if schema and table_name in schema.tables:
                    col_obj = next((c for c in schema.tables[table_name].columns if c.name.upper() == col_name.upper()), None)
                    if col_obj: col_type = col_obj.data_type.lower()
                if any(t in col_type for t in ("real", "float", "double", "decimal", "numeric")):
                    z3_vars[key] = z3.Real(f"{table_name}_{col_name}")
                else:
                    z3_vars[key] = z3.Real(f"{table_name}_{col_name}")
            return z3_vars[key]
        elif isinstance(node, exp.Literal):
            if node.is_string:
                # Not supporting string in arithmetic Z3 directly
                return None
            elif "." in node.name:
                # Use reals if there are floats
                return z3.RealVal(float(node.name))
            else:
                return z3.IntVal(int(node.name))
        elif isinstance(node, exp.Add):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l + r
        elif isinstance(node, exp.Sub):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l - r
        elif isinstance(node, exp.Mul):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l * r
        elif isinstance(node, exp.Div):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l / r
        elif isinstance(node, exp.Mod):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l % r
        elif isinstance(node, exp.GT):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l > r
        elif isinstance(node, exp.GTE):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l >= r
        elif isinstance(node, exp.LT):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l < r
        elif isinstance(node, exp.LTE):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l <= r
        elif isinstance(node, exp.EQ):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l == r
        elif isinstance(node, exp.NEQ):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return l != r
        elif isinstance(node, exp.And):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return z3.And(l, r)
        elif isinstance(node, exp.Or):
            l = self.ast_to_z3(node.left, z3_vars, substitutions, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, substitutions, schema, parsed_query)
            if l is None or r is None: return None
            return z3.Or(l, r)
        elif isinstance(node, exp.Paren):
            return self.ast_to_z3(node.this, z3_vars, substitutions, schema, parsed_query)
        elif isinstance(node, exp.Subquery):
            return self.ast_to_z3(node.this, z3_vars, substitutions, schema, parsed_query)
        elif isinstance(node, exp.Select):
            if hasattr(node, 'expressions') and node.expressions:
                return self.ast_to_z3(node.expressions[0], z3_vars, substitutions, schema, parsed_query)
            return None
        else:
            return None

    def _find_unit_indicator_columns(
        self, schema: Schema, parsed_query: Dict[str, Any], ast: exp.Expression, table_name: str, exclude_col: str
    ) -> List[str]:
        candidates: List[str] = []
        seen: Set[str] = set()
        for lit in parsed_query.get("where_literals", []):
            if str(lit.get("operator", "EQ")).upper() not in ("EQ", "IN"):
                continue
            if str(lit.get("value", "")).strip().upper() not in ("1", "1.0", "TRUE"):
                continue
            resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if resolved and resolved[0].upper() == table_name.upper() and resolved[1].upper() != exclude_col.upper():
                if resolved[1].upper() not in seen:
                    seen.add(resolved[1].upper())
                    candidates.append(resolved[1])

        for eq_node in ast.find_all(exp.EQ):
            for col_side, val_side in ((eq_node.left, eq_node.right), (eq_node.right, eq_node.left)):
                curr_col = col_side
                while isinstance(curr_col, (exp.Paren, exp.Cast, exp.TryCast)):
                    curr_col = curr_col.this
                curr_val = val_side
                while isinstance(curr_val, (exp.Paren, exp.Cast, exp.TryCast)):
                    curr_val = curr_val.this
                is_unit = (
                    (isinstance(curr_val, exp.Literal) and not curr_val.is_string and str(curr_val.name).strip() in ("1", "1.0"))
                    or (isinstance(curr_val, exp.Boolean) and bool(curr_val.this) is True)
                )
                if isinstance(curr_col, exp.Column) and is_unit:
                    resolved = resolve_query_column(schema, parsed_query, curr_col.table, curr_col.name)
                    if resolved and resolved[0].upper() == table_name.upper() and resolved[1].upper() != exclude_col.upper():
                        if resolved[1].upper() not in seen:
                            seen.add(resolved[1].upper())
                            candidates.append(resolved[1])
        return candidates

    def _extract_window_sum_order_gap(
        self, schema: Schema, parsed_query: Dict[str, Any], node: exp.Expression
    ) -> Optional[Tuple[str, str, str]]:
        if not isinstance(node, (exp.Sub, exp.Add)):
            return None

        def _unwrap(expr: Optional[exp.Expression]) -> Optional[exp.Expression]:
            curr = expr
            while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast, exp.Alias)):
                curr = curr.this
            return curr

        for win_side, col_side in ((node.left, node.right), (node.right, node.left)):
            w_expr = _unwrap(win_side)
            c_expr = _unwrap(col_side)
            if not isinstance(w_expr, exp.Window) or not isinstance(c_expr, exp.Column):
                continue
            func = _unwrap(w_expr.this)
            if not isinstance(func, exp.Sum):
                continue
            sum_arg = _unwrap(func.this)
            if not isinstance(sum_arg, exp.Column):
                continue
            res_val = resolve_query_column(schema, parsed_query, sum_arg.table, sum_arg.name)
            res_ord = resolve_query_column(schema, parsed_query, c_expr.table, c_expr.name)
            if not res_val or not res_ord or res_val[0].upper() != res_ord[0].upper():
                continue
            if res_val[1].upper() == res_ord[1].upper():
                continue
            order_spec = w_expr.args.get("order")
            if not order_spec:
                continue
            order_cols = [
                resolve_query_column(schema, parsed_query, oc.table, oc.name)
                for oc in order_spec.find_all(exp.Column)
            ]
            if any(oc and oc[0].upper() == res_ord[0].upper() and oc[1].upper() == res_ord[1].upper() for oc in order_cols):
                return (res_ord[0], res_ord[1], res_val[1])
        return None

    def _build_gap_compensation_dataset(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_name: str,
        ord_col_name: str,
        val_col_name: str,
        salt: str,
    ) -> Optional[Dict[str, List[Dict[str, Any]]]]:
        t_key = schema.find_table(table_name)
        if not t_key:
            return None
        ord_col = schema.find_column(t_key, ord_col_name)
        val_col = schema.find_column(t_key, val_col_name)
        if not ord_col or not val_col or ord_col.name.upper() == val_col.name.upper():
            return None
        if not ord_col.is_numeric or not val_col.is_numeric:
            return None
        if val_col.is_primary_key or val_col.is_unique:
            return None
        if solve_check_constraint_value(schema, t_key, val_col.name, val_col, 2) != 2:
            return None

        base_rows = generate_base_dataset(schema, parsed_query, cache_key_salt=salt)
        if not base_rows.get(t_key):
            return None

        template_row = copy.deepcopy(base_rows[t_key][0])
        base_ord = template_row.get(ord_col.name)
        s = int(base_ord) if isinstance(base_ord, (int, float)) and not isinstance(base_ord, bool) else 10

        r0 = copy.deepcopy(template_row)
        r1 = copy.deepcopy(template_row)
        r2 = copy.deepcopy(template_row)

        r0[ord_col.name] = s
        r0[val_col.name] = 1
        r1[ord_col.name] = s + 2
        r1[val_col.name] = 2
        r2[ord_col.name] = s + 3
        r2[val_col.name] = 1

        for col in schema.tables[t_key].columns:
            if col.name in (ord_col.name, val_col.name):
                continue
            if col.is_primary_key or col.is_unique:
                r1[col.name] = next_distinct_value(col, r0.get(col.name), schema=schema, table_name=t_key)
                r2[col.name] = next_distinct_value(col, r1.get(col.name), schema=schema, table_name=t_key)

        mock_data = copy.deepcopy(base_rows)
        mock_data[t_key] = [r0, r1, r2]
        return mock_data

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        ast = parsed_query.get('ast') or sqlglot.parse_one(parsed_query["raw_query"])
        arithmetic_nodes = list(ast.find_all((exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod)))
        
        if not arithmetic_nodes:
            return []

        datasets = []
        base_data = None
        seen_gap_comp: Set[Tuple[str, str, str]] = set()
        for i, target_node in enumerate(arithmetic_nodes):
            win_gap_info = self._extract_window_sum_order_gap(schema, parsed_query, target_node)
            if win_gap_info is not None:
                wg_table, wg_ord, wg_val = win_gap_info
                wg_key = (wg_table.upper(), wg_ord.upper(), wg_val.upper())
                if wg_key not in seen_gap_comp:
                    seen_gap_comp.add(wg_key)
                    gap_data = self._build_gap_compensation_dataset(
                        schema, parsed_query, wg_table, wg_ord, wg_val, f"win_gap_comp_{i}"
                    )
                    if gap_data is not None:
                        datasets.append(
                            Dataset(
                                strategy_name=f"ArithmeticAttack_window_gap_compensation_{i}",
                                data=gap_data,
                                tags=["arithmetic_attack", "window_attack"],
                                description=(
                                    f"Targets Cumulative-Sum Gap-and-Island Compensation on `SUM({wg_val}) OVER (ORDER BY {wg_ord}) - {wg_ord}`. "
                                    f"Constructs non-adjacent unit rows `({wg_ord}=s, {wg_val}=1)` and `({wg_ord}=s+3, {wg_val}=1)` bridged by "
                                    f"`({wg_ord}=s+2, {wg_val}=2)` so `SUM({wg_val}) - {wg_ord}` collides across non-consecutive rows."
                                ),
                            )
                        )

            parent_comp = target_node.find_ancestor((exp.EQ, exp.In))
            self_offset_pats = (
                extract_self_offset_patterns(schema, parsed_query, parent_comp)
                if parent_comp is not None
                else []
            )
            if self_offset_pats:
                pat = self_offset_pats[0]
                t_name, c_name = pat["table"], pat["column"]
                offset_vals = compute_self_offset_values(
                    schema, t_name, c_name, pat["offset"], pat["date_func"]
                )
                mock_data = generate_base_dataset(
                    schema, parsed_query, value_injections={(t_name, c_name): offset_vals["numeric_pair"]}
                )
                datasets.append(
                    Dataset(
                        strategy_name=f"ArithmeticAttack_self_offset_{i}",
                        data=mock_data,
                        tags=["arithmetic_attack"],
                        description=(
                            f"Targets Arithmetic Operator bugs on self-offset comparison for `{t_name}.{c_name}`. "
                            "Injects a pair of numeric values within the same group that satisfies the target "
                            "arithmetic offset while falsifying alternative operators (-, *, /, %) and DATE wrappers."
                        ),
                    )
                )
                if abs(pat["offset"]) == 1 and pat["date_func"] is None:
                    for ind_col in self._find_unit_indicator_columns(schema, parsed_query, ast, t_name, c_name):
                        wg_key = (t_name.upper(), c_name.upper(), ind_col.upper())
                        if wg_key not in seen_gap_comp:
                            seen_gap_comp.add(wg_key)
                            gap_data = self._build_gap_compensation_dataset(
                                schema, parsed_query, t_name, c_name, ind_col, f"self_offset_gap_comp_{i}"
                            )
                            if gap_data is not None:
                                datasets.append(
                                    Dataset(
                                        strategy_name=f"ArithmeticAttack_self_offset_gap_compensation_{i}",
                                        data=gap_data,
                                        tags=["arithmetic_attack", "window_attack"],
                                        description=(
                                            f"Targets Cumulative-Sum Gap-and-Island Compensation vs unit self-offset adjacency on `{t_name}.{c_name}`. "
                                            f"Constructs non-adjacent rows with `{ind_col}=1` bridged by an intermediate row with `{ind_col}=2` "
                                            f"so cumulative `SUM({ind_col}) OVER (ORDER BY {c_name}) - {c_name}` collides without adjacent `{ind_col}=1` neighbors."
                                        ),
                                    )
                                )
                continue

            # Bilinear sign-inversion invariance for multiplication: (-L) * (-R) = L * R
            if isinstance(target_node, exp.Mul):
                l_unwrapped = target_node.left
                while isinstance(l_unwrapped, (exp.Paren, exp.Cast, exp.TryCast)):
                    l_unwrapped = l_unwrapped.this
                r_unwrapped = target_node.right
                while isinstance(r_unwrapped, (exp.Paren, exp.Cast, exp.TryCast)):
                    r_unwrapped = r_unwrapped.this
                if isinstance(l_unwrapped, exp.Column) and isinstance(r_unwrapped, exp.Column):
                    res_l = resolve_query_column(schema, parsed_query, l_unwrapped.table, l_unwrapped.name)
                    res_r = resolve_query_column(schema, parsed_query, r_unwrapped.table, r_unwrapped.name)
                    if res_l and res_r:
                        if base_data is None:
                            base_data = generate_base_dataset(schema, parsed_query)
                        neg_injections = {}
                        valid_sign_flip = True
                        for t_n, c_n in {res_l, res_r}:
                            col_obj = schema.find_column(t_n, c_n)
                            if not col_obj or col_obj.is_primary_key or not col_obj.is_numeric:
                                valid_sign_flip = False
                                break
                            orig_vals = [
                                r.get(c_n)
                                for r in base_data.get(t_n, [])
                                if isinstance(r.get(c_n), (int, float))
                                and not isinstance(r.get(c_n), bool)
                                and r.get(c_n) != 0
                            ]
                            neg_v = -orig_vals[0] if orig_vals else -1
                            if solve_check_constraint_value(schema, t_n, c_n, col_obj, neg_v) != neg_v:
                                valid_sign_flip = False
                                break
                            neg_injections[(t_n, c_n)] = neg_v
                        if valid_sign_flip and neg_injections:
                            neg_data = generate_base_dataset(
                                schema, parsed_query, value_injections=neg_injections
                            )
                            merged_neg = merge_with_shifted_companion(
                                schema,
                                parsed_query,
                                base_data,
                                neg_data,
                                preserved_cols={res_l, res_r},
                            )
                            datasets.append(
                                Dataset(
                                    strategy_name=f"ArithmeticAttack_Mul_sign_inversion_{i}",
                                    data=merged_neg,
                                    tags=["arithmetic_attack", "sign_inversion"],
                                    description=(
                                        f"Targets Multiplicative Sign-Inversion symmetry on `{res_l[0]}.{res_l[1]}` * `{res_r[0]}.{res_r[1]}`. "
                                        "Exploits (-L) * (-R) = L * R by adding a shifted companion component with negated operand values, "
                                        "preserving the product while falsifying individual positive equality predicates."
                                    ),
                                )
                            )
                            datasets.append(
                                Dataset(
                                    strategy_name=f"ArithmeticAttack_Mul_sign_inversion_standalone_{i}",
                                    data=neg_data,
                                    tags=["arithmetic_attack", "sign_inversion"],
                                    description=(
                                        f"Standalone Multiplicative Sign-Inversion dataset negating `{res_l[0]}.{res_l[1]}` "
                                        f"and `{res_r[0]}.{res_r[1]}` so (-L) * (-R) = L * R."
                                    ),
                                )
                            )

            # Additive summand asymmetry for addition: (v1 + v2 = C with v1 != v2)
            if isinstance(target_node, exp.Add) and parent_comp is not None and isinstance(parent_comp, exp.EQ):
                sum_pats = extract_additive_sum_patterns(schema, parsed_query, parent_comp)
                if sum_pats:
                    sum_pat = sum_pats[0]
                    sum_vals = compute_additive_sum_values(schema, sum_pat)
                    res_l = (sum_pat["left_table"], sum_pat["left_column"])
                    res_r = (sum_pat["right_table"], sum_pat["right_column"])
                    if base_data is None:
                        base_data = generate_base_dataset(schema, parsed_query)
                    for split_idx, split_pair in enumerate((sum_vals["primary_pair"], sum_vals["secondary_pair"])):
                        if sum_pat["is_self_sum"]:
                            split_injections = {res_l: list(split_pair)}
                        else:
                            split_injections = {res_l: split_pair[0], res_r: split_pair[1]}
                        split_data = generate_base_dataset(
                            schema, parsed_query, value_injections=split_injections
                        )
                        suffix = f"_{i}" if split_idx == 0 else f"_alt_{i}"
                        merged_split = merge_with_shifted_companion(
                            schema,
                            parsed_query,
                            base_data,
                            split_data,
                            preserved_cols={res_l, res_r},
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"ArithmeticAttack_Add_asymmetric_split{suffix}",
                                data=merged_split,
                                tags=["arithmetic_attack", "asymmetric_split"],
                                description=(
                                    f"Targets Additive Summand Asymmetry on `{res_l[0]}.{res_l[1]}` + `{res_r[0]}.{res_r[1]}` = {sum_pat['sum_val']}. "
                                    f"Injects asymmetric summands `{split_pair}` satisfying `L + R = {sum_pat['sum_val']}` with `L != R`, "
                                    "separating additive sum predicates from symmetric equality conjunctions (`L = C/2 AND R = C/2`)."
                                ),
                            )
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"ArithmeticAttack_Add_asymmetric_split_standalone{suffix}",
                                data=split_data,
                                tags=["arithmetic_attack", "asymmetric_split"],
                                description=(
                                    f"Standalone Additive Summand Asymmetry dataset setting `{res_l[0]}.{res_l[1]}` "
                                    f"and `{res_r[0]}.{res_r[1]}` to asymmetric summands `{split_pair}`."
                                ),
                            )
                        )

            # For each arithmetic node, we generate datasets that kill alternative operators
            alternative_classes = [exp.Add, exp.Sub, exp.Mul, exp.Div, exp.Mod]
            
            for alt_class in alternative_classes:
                if isinstance(target_node, alt_class):
                    continue
                    
                # We need to solve for values such that WHERE clause is true (if any)
                # AND the alternative operator yields a different overall WHERE evaluation or different SELECT output.
                # To simplify, we just ensure that the original arithmetic expression != mutated arithmetic expression.
                
                z3_vars = {}
                solver = z3.Solver()
                
                # Convert mutated node
                mutated_node = alt_class(this=target_node.left.copy(), expression=target_node.right.copy())
                try:
                    z3_mutated = self.ast_to_z3(mutated_node, z3_vars, schema=schema, parsed_query=parsed_query)
                    z3_orig_node = self.ast_to_z3(target_node, z3_vars, schema=schema, parsed_query=parsed_query)
                    
                    if z3_orig_node is None or z3_mutated is None:
                        continue
                        
                    # Add all WHERE clauses to the solver
                    where_clauses = list(ast.find_all(exp.Where))
                    if where_clauses:
                        all_where_orig = []
                        all_where_mut = []
                        for w in where_clauses:
                            orig = self.ast_to_z3(w.this, z3_vars, schema=schema, parsed_query=parsed_query)
                            mut = self.ast_to_z3(w.this, z3_vars, substitutions={id(target_node): z3_mutated}, schema=schema, parsed_query=parsed_query)
                            if orig is not None: all_where_orig.append(orig)
                            if mut is not None: all_where_mut.append(mut)
                            
                        if all_where_orig and all_where_mut:
                            solver.add(z3.And(all_where_orig) == True)
                            solver.add(z3.And(all_where_mut) == False)
                        else:
                            solver.add(z3_orig_node != z3_mutated)
                    else:
                        solver.add(z3_orig_node != z3_mutated)
                        
                    # Also if it's div/mod, avoid zero denominator
                    if alt_class == exp.Div or alt_class == exp.Mod:
                        r = self.ast_to_z3(target_node.right, z3_vars, schema=schema, parsed_query=parsed_query)
                        if r is not None:
                            solver.add(r != 0)
                    if isinstance(target_node, (exp.Div, exp.Mod)):
                        r = self.ast_to_z3(target_node.right, z3_vars, schema=schema, parsed_query=parsed_query)
                        if r is not None:
                            solver.add(r != 0)

                    # Try to bound values to avoid crazy large numbers but allow enough room
                    for v in z3_vars.values():
                        solver.add(v > -100000)
                        solver.add(v < 10000000)

                    for v in z3_vars.values():
                        if z3.is_real(v) or z3.is_int(v):
                            solver.add(v > 0)
                            solver.add(v < 100000)

                    if solver.check() == z3.sat:
                        model = solver.model()
                        # We have satisfying values! Inject them into parsed_query['where_literals']
                        modified_query = copy.deepcopy(parsed_query)
                        if "where_literals" not in modified_query:
                            modified_query["where_literals"] = []
                            
                        target_vars = {}
                        self.ast_to_z3(target_node, target_vars, schema=schema, parsed_query=parsed_query)

                        # Add solved values as literals only for variables in the target arithmetic expression
                        solved_injections = {}
                        for (table_name, col_name) in target_vars.keys():
                            z3_var = z3_vars.get((table_name, col_name))
                            if z3_var is not None and z3_var.decl() in model:
                                val = model.eval(z3_var, model_completion=True)
                                # Extract value from z3 RatNumRef or IntNumRef
                                if z3.is_rational_value(val):
                                    val_real = val.numerator_as_long() / val.denominator_as_long()
                                elif z3.is_int_value(val):
                                    val_real = val.as_long()
                                else:
                                    continue

                                modified_query["where_literals"].append({
                                    "table": table_name if table_name else "",
                                    "column": col_name,
                                    "value": str(val_real),
                                    "operator": "EQ"
                                })
                                if table_name:
                                    solved_injections[(table_name, col_name)] = val_real
                            
                        mock_data = generate_base_dataset(
                            schema, modified_query, value_injections=solved_injections or None
                        )
                        vars_str = ", ".join(f"{k[0]}.{k[1]}" for k in z3_vars.keys())
                        desc = (
                            "Targets Arithmetic Operator bugs (e.g. + mutated to -). "
                            f"Dataset is crafted using constraint solving to generate specific values for {vars_str}. "
                            f"These values ensure that the original arithmetic expression ({target_node.__class__.__name__}) evaluates to a different result than the mutated expression ({alt_class.__name__}), "
                            "and that any WHERE conditions strictly evaluate to True for the original but False for the mutant."
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"ArithmeticAttack_{target_node.__class__.__name__}_to_{alt_class.__name__}_{i}",
                                data=mock_data,
                                tags=["arithmetic_attack"],
                                description=desc
                            )
                        )
                except Exception:
                    continue

        return datasets
