"""
DivisionAttackStrategy Module

Target semantic bug:
1. Division or modulo denominator guard issues (e.g. missing, redundant, or incorrect WHERE clauses filtering denominators, like denominator > 0).
2. Real/floating-point vs truncating integer division and comparison boundary mutations on ratio predicates (e.g. CAST(x AS REAL) / y > 0.3 vs x * 100 / y > 30, x / y > c, or > vs >= on ratios).

Algorithm & Dataset Design:
1. Parse raw query to locate division (`exp.Div`) or modulo (`exp.Mod`) operations.
2. Extract all columns referenced in the denominator expression and resolve schema columns.
3. Generate three distinct datasets for each division node:
   a) Zero Denominator: Use Z3 / domain solver to make denominator evaluate to 0.
   b) Negative Denominator: Use Z3 / domain solver to make denominator evaluate to < 0.
   c) Null Denominator: Force denominator columns to NULL.
4. For division expressions compared against numeric literals (e.g. `(s * x) / y OP c` or `(x / y) * s OP c`),
   decompose into canonical ratio `r = p / q = c / s` and generate exact rational and fractional-truncation
   boundary pairs `(p, q)`, `(N_0 + 1, D)`, and `(N_0 - 1, D)` (with `D = lcm(q, 1000)` and `N_0 = r * D`),
   separating floating-point division from SQLite truncating integer division and strict vs non-strict ratio bounds.
5. Construct database inserts satisfying these values to evaluate mutant division behavior.
"""

from fractions import Fraction
import math
from typing import Any, Dict, List, Optional, Tuple
import sqlglot
import sqlglot.expressions as exp
import z3

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column

class DivisionAttackStrategy(AttackStrategy):
    """
    Target semantic bug: division/modulo denominator guard issues (e.g. missing,
    redundant, or incorrect WHERE clauses filtering denominators, like denominator > 0).

    Algorithm & Dataset Design:
    1. Parse raw query to locate division (`exp.Div`) or modulo (`exp.Mod`) operations.
    2. Extract all columns referenced in the denominator expression.
    3. Resolve each column to its schema table and column name.
    4. Generate three distinct datasets for each division node with resolved denominator columns:
       a) Zero Denominator:
          - Use Z3 to solve for column values that make the denominator expression evaluate to 0.
          - If Z3 solving fails, fall back to setting all denominator columns to 0.
       b) Negative Denominator:
          - Use Z3 to solve for column values that make the denominator expression evaluate to < 0.
          - If Z3 solving fails, fall back to setting all denominator columns to -1.
       c) Null Denominator:
          - Mark all denominator columns as null injections.
    5. Construct database inserts satisfying these values to evaluate behavior.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(parsed_query["raw_query"])
            nodes = list(ast.find_all((exp.Div, exp.Mod)))
        except Exception:
            return False

        for node in nodes:
            denom = node.expression
            if denom and list(denom.find_all(exp.Column)):
                return True
        return False

    def ast_to_z3(self, node, z3_vars, schema: Schema, parsed_query: Dict[str, Any]) -> Any:
        if node is None:
            return None
        if isinstance(node, exp.Column):
            resolved = resolve_query_column(schema, parsed_query, node.table, node.name)
            if not resolved:
                return None
            table_name, col_name = resolved
            key = (table_name, col_name)
            if key not in z3_vars:
                column = next(c for c in schema.tables[table_name].columns if c.name == col_name)
                col_type = column.data_type.lower()
                if "int" in col_type:
                    z3_vars[key] = z3.Int(f"{table_name}_{col_name}")
                else:
                    z3_vars[key] = z3.Real(f"{table_name}_{col_name}")
            return z3_vars[key]
        elif isinstance(node, exp.Literal):
            if node.is_string:
                return None
            elif "." in node.name:
                return z3.RealVal(float(node.name))
            else:
                return z3.IntVal(int(node.name))
        elif isinstance(node, exp.Cast):
            return self.ast_to_z3(node.this, z3_vars, schema, parsed_query)
        elif isinstance(node, exp.Paren):
            return self.ast_to_z3(node.this, z3_vars, schema, parsed_query)
        elif isinstance(node, exp.Add):
            l = self.ast_to_z3(node.left, z3_vars, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, schema, parsed_query)
            if l is None or r is None: return None
            return l + r
        elif isinstance(node, exp.Sub):
            l = self.ast_to_z3(node.left, z3_vars, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, schema, parsed_query)
            if l is None or r is None: return None
            return l - r
        elif isinstance(node, exp.Mul):
            l = self.ast_to_z3(node.left, z3_vars, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, schema, parsed_query)
            if l is None or r is None: return None
            return l * r
        elif isinstance(node, exp.Div):
            l = self.ast_to_z3(node.left, z3_vars, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, schema, parsed_query)
            if l is None or r is None: return None
            return l / r
        elif isinstance(node, exp.Mod):
            l = self.ast_to_z3(node.left, z3_vars, schema, parsed_query)
            r = self.ast_to_z3(node.right, z3_vars, schema, parsed_query)
            if l is None or r is None: return None
            return l % r
        return None

    def _solve_and_generate(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        denom_node: Any,
        resolved_cols: List[tuple[str, str]],
        constraint_type: str
    ) -> Dict[str, List[Dict[str, Any]]]:
        z3_vars = {}
        solver = z3.Solver()
        try:
            z3_denom = self.ast_to_z3(denom_node, z3_vars, schema, parsed_query)
            if z3_denom is not None:
                if constraint_type == "zero":
                    solver.add(z3_denom == 0)
                elif constraint_type == "negative":
                    solver.add(z3_denom < 0)
                
                for v in z3_vars.values():
                    solver.add(v > -100000)
                    solver.add(v < 1000000)

                if solver.check() == z3.sat:
                    model = solver.model()
                    value_injections = {}
                    for (table_name, col_name), z3_var in z3_vars.items():
                        val = model[z3_var]
                        if z3.is_rational_value(val):
                            val_real = val.numerator_as_long() / val.denominator_as_long()
                        elif z3.is_int_value(val):
                            val_real = val.as_long()
                        else:
                            continue
                        value_injections[(table_name, col_name)] = val_real
                    
                    return generate_base_dataset(schema, parsed_query, value_injections=value_injections)
        except Exception:
            pass

        fallback_val = 0 if constraint_type == "zero" else -1
        value_injections = {col: fallback_val for col in resolved_cols}
        return generate_base_dataset(schema, parsed_query, value_injections=value_injections)

    @staticmethod
    def _extract_numeric_fraction(node: Optional[exp.Expression]) -> Optional[Fraction]:
        curr = node
        sign = 1
        while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast, exp.Neg)):
            if isinstance(curr, exp.Neg):
                sign *= -1
            curr = curr.this
        if isinstance(curr, exp.Literal):
            s = str(curr.name).strip()
            try:
                return sign * Fraction(s)
            except (ValueError, ZeroDivisionError):
                return None
        return None

    @classmethod
    def _unwrap_scaled_expr(cls, node: Optional[exp.Expression]) -> Tuple[Optional[exp.Expression], Fraction]:
        curr = node
        factor = Fraction(1)
        while curr is not None:
            if isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast, exp.Round)):
                curr = curr.this
                continue
            if isinstance(curr, exp.Mul):
                l_frac = cls._extract_numeric_fraction(curr.left)
                r_frac = cls._extract_numeric_fraction(curr.right)
                if l_frac is not None and l_frac != 0:
                    factor *= l_frac
                    curr = curr.right
                    continue
                if r_frac is not None and r_frac != 0:
                    factor *= r_frac
                    curr = curr.left
                    continue
            break
        return curr, factor

    def _decompose_ratio_expr(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        expr: exp.Expression,
        bound_frac: Fraction,
    ) -> Optional[Tuple[Tuple[str, str], Tuple[str, str], Fraction, Fraction, str]]:
        curr = expr
        target = bound_frac
        outer_scale = Fraction(1)

        while curr is not None:
            if isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast, exp.Round)):
                curr = curr.this
                continue
            if isinstance(curr, exp.Add):
                l_frac = self._extract_numeric_fraction(curr.left)
                r_frac = self._extract_numeric_fraction(curr.right)
                if l_frac is not None:
                    target -= l_frac
                    curr = curr.right
                    continue
                if r_frac is not None:
                    target -= r_frac
                    curr = curr.left
                    continue
            if isinstance(curr, exp.Sub):
                l_frac = self._extract_numeric_fraction(curr.left)
                r_frac = self._extract_numeric_fraction(curr.right)
                if r_frac is not None:
                    target += r_frac
                    curr = curr.left
                    continue
                if l_frac is not None:
                    target = l_frac - target
                    curr = curr.right
                    continue
            if isinstance(curr, exp.Mul):
                l_frac = self._extract_numeric_fraction(curr.left)
                r_frac = self._extract_numeric_fraction(curr.right)
                if l_frac is not None and l_frac != 0:
                    target /= l_frac
                    outer_scale *= abs(l_frac)
                    curr = curr.right
                    continue
                if r_frac is not None and r_frac != 0:
                    target /= r_frac
                    outer_scale *= abs(r_frac)
                    curr = curr.left
                    continue
            if isinstance(curr, exp.Div) and curr.this and curr.this.find(exp.Div):
                r_frac = self._extract_numeric_fraction(curr.expression)
                if r_frac is not None and r_frac != 0:
                    target *= r_frac
                    curr = curr.this
                    continue
            break

        if not isinstance(curr, exp.Div) or curr.this is None or curr.expression is None:
            return None

        num_core, num_factor = self._unwrap_scaled_expr(curr.this)
        denom_core, denom_factor = self._unwrap_scaled_expr(curr.expression)
        if num_core is None or denom_core is None or num_factor == 0 or denom_factor == 0:
            return None

        ratio = target * (denom_factor / num_factor)
        total_scale = abs(outer_scale * num_factor)

        if isinstance(num_core, exp.Column) and isinstance(denom_core, exp.Column):
            res_num = resolve_query_column(schema, parsed_query, num_core.table, num_core.name)
            res_denom = resolve_query_column(schema, parsed_query, denom_core.table, denom_core.name)
            if res_num and res_denom and res_num != res_denom:
                return res_num, res_denom, ratio, total_scale, "direct"

        if isinstance(num_core, (exp.Sub, exp.Add)) and isinstance(denom_core, exp.Column):
            res_denom = resolve_query_column(schema, parsed_query, denom_core.table, denom_core.name)
            l_col, _ = self._unwrap_scaled_expr(num_core.left)
            r_col, _ = self._unwrap_scaled_expr(num_core.right)
            if res_denom and isinstance(l_col, exp.Column) and isinstance(r_col, exp.Column):
                res_l = resolve_query_column(schema, parsed_query, l_col.table, l_col.name)
                res_r = resolve_query_column(schema, parsed_query, r_col.table, r_col.name)
                if res_l and res_r == res_denom and res_l != res_denom:
                    shifted_ratio = ratio + 1 if isinstance(num_core, exp.Sub) else ratio - 1
                    return res_l, res_denom, shifted_ratio, total_scale, "direct"

        if isinstance(num_core, exp.Column) and isinstance(denom_core, exp.Add):
            res_num = resolve_query_column(schema, parsed_query, num_core.table, num_core.name)
            l_col, _ = self._unwrap_scaled_expr(denom_core.left)
            r_col, _ = self._unwrap_scaled_expr(denom_core.right)
            if res_num and isinstance(l_col, exp.Column) and isinstance(r_col, exp.Column):
                res_l = resolve_query_column(schema, parsed_query, l_col.table, l_col.name)
                res_r = resolve_query_column(schema, parsed_query, r_col.table, r_col.name)
                if res_l == res_num and res_r and res_r != res_num:
                    return res_num, res_r, ratio, total_scale, "share_add"
                if res_r == res_num and res_l and res_l != res_num:
                    return res_num, res_l, ratio, total_scale, "share_add"

        return None

    def _extract_ratio_comparison_targets(
        self, schema: Schema, parsed_query: Dict[str, Any], ast: exp.Expression
    ) -> List[Tuple[Tuple[str, str], Tuple[str, str], Fraction, Fraction, str]]:
        targets: List[Tuple[Tuple[str, str], Tuple[str, str], Fraction, Fraction, str]] = []
        seen = set()

        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ, exp.Between)):
            pairs: List[Tuple[exp.Expression, Fraction]] = []
            if isinstance(comp, exp.Between):
                low_f = self._extract_numeric_fraction(comp.args.get("low"))
                high_f = self._extract_numeric_fraction(comp.args.get("high"))
                if comp.this is not None and comp.this.find(exp.Div):
                    if low_f is not None:
                        pairs.append((comp.this, low_f))
                    if high_f is not None:
                        pairs.append((comp.this, high_f))
            elif hasattr(comp, "left") and hasattr(comp, "right"):
                l_f = self._extract_numeric_fraction(comp.left)
                r_f = self._extract_numeric_fraction(comp.right)
                if r_f is not None and comp.left is not None and comp.left.find(exp.Div):
                    pairs.append((comp.left, r_f))
                elif l_f is not None and comp.right is not None and comp.right.find(exp.Div):
                    pairs.append((comp.right, l_f))

            for expr_side, bound_f in pairs:
                decomposed = self._decompose_ratio_expr(schema, parsed_query, expr_side, bound_f)
                if decomposed is not None:
                    res_num, res_denom, ratio, total_scale, mode = decomposed
                    key = (res_num, res_denom, ratio, mode)
                    if key not in seen:
                        seen.add(key)
                        targets.append(decomposed)

        return targets

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(parsed_query["raw_query"])
            nodes = list(ast.find_all((exp.Div, exp.Mod)))
        except Exception:
            return []

        datasets = []
        for i, node in enumerate(nodes):
            denom = node.expression
            if not denom:
                continue

            columns = list(denom.find_all(exp.Column))
            resolved_cols = []
            for col in columns:
                resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                if resolved:
                    resolved_cols.append(resolved)

            if not resolved_cols:
                continue

            # Case 1: Zero Denominator
            zero_data = self._solve_and_generate(schema, parsed_query, denom, resolved_cols, "zero")
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_zero_{i}",
                    data=zero_data,
                    tags=["division_attack"],
                    description=f"Targets Division by Zero handling bugs. Dataset assigns values that force the denominator to evaluate precisely to 0 for division/modulo term {i + 1}. This checks for proper error handling or implicit NULL propagation for division by zero compared to mutants."
                )
            )

            # Case 2: Negative Denominator
            neg_data = self._solve_and_generate(schema, parsed_query, denom, resolved_cols, "negative")
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_negative_{i}",
                    data=neg_data,
                    tags=["division_attack"],
                    description=f"Targets Negative Denominator division bugs. Dataset assigns values forcing the denominator to be strictly negative (e.g. < 0) for term {i + 1}. This tests specific semantic behaviors of modulo or division operations when dealing with negative divisors."
                )
            )

            # Case 3: Null Denominator
            nullable_cols = []
            for t_name, c_name in resolved_cols:
                table = schema.tables.get(t_name)
                if table:
                    for col_def in table.columns:
                        if col_def.name.upper() == c_name.upper() and col_def.is_nullable:
                            nullable_cols.append((t_name, c_name))
                            break
                            
            if nullable_cols:
                null_data = generate_base_dataset(schema, parsed_query, null_injections=nullable_cols)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_null_{i}",
                        data=null_data,
                        tags=["division_attack"],
                        description=f"Targets Division by NULL bugs. Dataset injects a NULL value into the denominator for division/modulo term {i + 1}. This verifies that the division operation correctly yields NULL rather than a runtime error or unexpected default."
                    )
                )

        ratio_targets = self._extract_ratio_comparison_targets(schema, parsed_query, ast)
        for r_idx, (res_num, res_denom, ratio, total_scale, mode) in enumerate(ratio_targets):
            p = ratio.numerator
            q = ratio.denominator
            scale_int = min(100000, max(1000, int(math.ceil(float(total_scale))) * 10))
            d_scaled = math.lcm(q, scale_int)
            if d_scaled > 1000000:
                d_scaled = q * max(1, 1000 // q)
            n_scaled = p * (d_scaled // q)

            if mode == "share_add":
                candidates = [
                    ("exact", p, q - p),
                    ("upper_frac", n_scaled + 1, d_scaled - (n_scaled + 1)),
                    ("lower_frac", n_scaled - 1, d_scaled - (n_scaled - 1)),
                ]
            else:
                candidates = [
                    ("exact", p, q),
                    ("upper_frac", n_scaled + 1, d_scaled),
                    ("lower_frac", n_scaled - 1, d_scaled),
                ]

            for label, num_val, denom_val in candidates:
                if denom_val == 0:
                    continue
                val_inj = {res_num: int(num_val), res_denom: int(denom_val)}
                ratio_data = generate_base_dataset(schema, parsed_query, value_injections=val_inj)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_ratio_{label}_{r_idx}",
                        data=ratio_data,
                        tags=["division_attack", "comparison_attack"],
                        description=(
                            f"Targets Division Ratio Comparison & Integer-Truncation bugs on "
                            f"`{res_num[0]}.{res_num[1]}` / `{res_denom[0]}.{res_denom[1]}` ({label} boundary: "
                            f"{num_val}/{denom_val} vs ratio {p}/{q}). Distinguishes floating-point CAST division "
                            f"from SQLite truncating integer division and tests strict vs non-strict ratio bounds."
                        ),
                    )
                )

        return datasets
