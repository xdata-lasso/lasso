"""
ComparisonAttackStrategy Module

Target semantic bugs: Operator Mismatch (>, <, >=, <=, =, !=, BETWEEN), Sign-Symmetric / Multiplicative Predicate Substitution, and Lexicographical vs Numeric-Cast Comparisons.
Algorithm & Dataset Design:
Extracts all predicate comparison boundaries across WHERE and HAVING clauses.
Generates targeted boundary datasets containing exact boundary values V, V+1, and V-1 for numeric conditions,
additive-inverse (-V) sign-negation datasets (combined with the positive baseline via translation-invariant
component shifting as well as standalone) to distinguish direct comparisons (col = V, col > 0) from
even/bilinear sign-invariant expressions (col1 * col2 = V^2, col * col = V^2, ABS(col) = |V|),
exact vs distinct values for string comparisons, and non-canonical numeric/alphanumeric boundary strings
(leading-zero strings and in-range alphanumeric prefixes over TEXT columns and SUBSTR extractions) that
separate lexicographical TEXT comparison from SQLite numeric CAST prefix evaluation.
"""

from typing import Any, Dict, List
import sqlglot
import sqlglot.expressions as exp
from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    generate_base_dataset,
    merge_with_shifted_companion,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import (
    _eval_sqlglot_ast_python,
    solve_check_constraint_value,
)
from dataset_generator.value_generator import synthesize_string_of_length

class ComparisonAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Wrong comparison operators (>, <, >=, <=, =, !=, BETWEEN).
    Generates datasets targeting the boundary values of comparison literals anywhere in the query.
    For a numeric literal value V, it generates rows with V, V+1, and V-1 to catch off-by-one and flipped operators.
    For string literals, it generates the exact value and a distinct mismatching value.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return False
            
        for _ in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ, exp.Between)):
            return True
        return False

    def _distinct_literal_value(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        table_alias: str,
        column_name: str,
        value: Any,
    ) -> Any:
        resolved = resolve_query_column(
            schema, parsed_query, table_alias, column_name
        )
        if resolved is None:
            return None
        table_name, col_name = resolved
        column = next(
            (col for col in schema.tables[table_name].columns if col.name == col_name), None
        )
        if column is None:
            return None
        return next_distinct_value(column, value, schema=schema, table_name=table_name)

    def _collect_union_selects(self, node: exp.Expression | None) -> List[exp.Select]:
        if node is None:
            return []
        curr = node
        while isinstance(curr, (exp.Paren, exp.Subquery)):
            curr = curr.this
        if isinstance(curr, exp.Select):
            return [curr]
        if isinstance(curr, (exp.Union, exp.Intersect, exp.Except)):
            return self._collect_union_selects(curr.left) + self._collect_union_selects(curr.right)
        return []

    def _build_cte_constant_column_map(
        self, ast: exp.Expression, schema: Schema | None = None
    ) -> Dict[tuple[str, str], List[str]]:
        const_map: Dict[tuple[str, str], List[str]] = {}
        non_const_types = (exp.Column, exp.AggFunc, exp.Window, exp.Subquery, exp.Exists, exp.Star, exp.Null)

        for sq in ast.find_all((exp.CTE, exp.Subquery)):
            if isinstance(sq, exp.Subquery) and not isinstance(sq.parent, (exp.From, exp.Join)):
                continue
            sq_alias = (sq.alias or "").upper()
            if not sq_alias:
                continue
            selects = self._collect_union_selects(sq.this)
            if not selects:
                continue

            alias_node = sq.args.get("alias")
            explicit_cols = (
                [c.name.upper() for c in (alias_node.columns or []) if hasattr(c, "name") and c.name]
                if isinstance(alias_node, exp.TableAlias)
                else []
            )
            first_exprs = list(selects[0].expressions or [])
            col_names: List[str] = []
            for idx, e in enumerate(first_exprs):
                if idx < len(explicit_cols):
                    col_names.append(explicit_cols[idx])
                else:
                    col_names.append((e.alias_or_name or "").upper())

            for branch_sel in selects:
                branch_exprs = list(branch_sel.expressions or [])
                for idx, proj_expr in enumerate(branch_exprs):
                    if idx >= len(col_names) or not col_names[idx]:
                        continue
                    c_name = col_names[idx]
                    inner = proj_expr.this if isinstance(proj_expr, exp.Alias) else proj_expr
                    if inner is None or inner.find(non_const_types) is not None:
                        continue
                    val_str: str | None = None
                    if isinstance(inner, exp.Literal):
                        val_str = inner.name
                    elif inner.find(exp.Literal) is not None:
                        try:
                            eval_v = _eval_sqlglot_ast_python(inner, None, "")
                            if isinstance(eval_v, (int, float)) and not isinstance(eval_v, bool):
                                val_str = (
                                    str(int(round(eval_v)))
                                    if isinstance(eval_v, int) or float(eval_v).is_integer()
                                    else str(eval_v)
                                )
                            elif isinstance(eval_v, str):
                                val_str = eval_v
                        except Exception:
                            val_str = None
                    if val_str is not None:
                        lst = const_map.setdefault((sq_alias, c_name), [])
                        if val_str not in lst:
                            lst.append(val_str)

        for t_node in ast.find_all(exp.Table):
            t_name_up = (t_node.name or "").upper()
            t_alias_up = (t_node.alias or t_node.name or "").upper()
            if not t_name_up or not t_alias_up or t_name_up == t_alias_up:
                continue
            if schema and schema.find_table(t_name_up):
                continue
            for (src_tbl, col_up), vals in list(const_map.items()):
                if src_tbl == t_name_up:
                    alias_lst = const_map.setdefault((t_alias_up, col_up), [])
                    for v in vals:
                        if v not in alias_lst:
                            alias_lst.append(v)

        for (_, col_up), vals in list(const_map.items()):
            is_schema_col = bool(schema and any(schema.find_column(t, col_up) for t in schema.tables))
            if not is_schema_col:
                unqual_lst = const_map.setdefault(("", col_up), [])
                for v in vals:
                    if v not in unqual_lst:
                        unqual_lst.append(v)

        return const_map

    def _extract_constant_values(
        self,
        expr: exp.Expression | None,
        cte_const_map: Dict[tuple[str, str], List[str]] | None = None,
    ) -> List[str]:
        if expr is None:
            return []
        if isinstance(expr, exp.Literal):
            return [expr.name]
        unwrapped = expr
        while isinstance(unwrapped, (exp.Paren, exp.Cast, exp.TryCast)):
            unwrapped = unwrapped.this
        if isinstance(unwrapped, exp.Literal):
            return [unwrapped.name]
        if isinstance(unwrapped, exp.Column) and cte_const_map:
            key = ((unwrapped.table or "").upper(), (unwrapped.name or "").upper())
            if key in cte_const_map:
                return list(cte_const_map[key])
            return []
        non_const_types = (exp.Column, exp.AggFunc, exp.Window, exp.Subquery, exp.Exists, exp.Star, exp.Null)
        if expr.find(non_const_types) is None and expr.find(exp.Literal) is not None:
            try:
                eval_v = _eval_sqlglot_ast_python(expr, None, "")
                if isinstance(eval_v, (int, float)) and not isinstance(eval_v, bool):
                    val_str = (
                        str(int(round(eval_v)))
                        if isinstance(eval_v, int) or float(eval_v).is_integer()
                        else str(eval_v)
                    )
                    return [val_str]
            except Exception:
                pass
        return []

    def _unwrap_column_and_invert_val(
        self, expr: exp.Expression | None, raw_val: str
    ) -> tuple[str, str, str] | None:
        if expr is None:
            return None
        if isinstance(expr, exp.Column):
            return (expr.table, expr.name, raw_val)

        cols = list(expr.find_all(exp.Column))
        if len(cols) != 1:
            return None

        curr = expr
        while isinstance(curr, exp.Paren):
            curr = curr.this
        if isinstance(curr, exp.Column):
            return (curr.table, curr.name, raw_val)

        is_num = isinstance(raw_val, (int, float)) or (
            isinstance(raw_val, str) and raw_val.lstrip("-").replace(".", "", 1).isdigit()
        )
        if not is_num:
            return None

        v = float(raw_val)
        curr = expr
        non_const_types = (exp.Column, exp.AggFunc, exp.Window, exp.Subquery, exp.Exists, exp.Star, exp.Null)
        while not isinstance(curr, exp.Column):
            if isinstance(curr, exp.Paren):
                curr = curr.this
            elif isinstance(curr, (exp.Cast, exp.TryCast)):
                to_str = str(curr.to).lower() if curr.to else ""
                if not any(k in to_str for k in ("int", "real", "floa", "doub", "num", "dec")):
                    return None
                curr = curr.this
            elif isinstance(curr, exp.Neg):
                v = -v
                curr = curr.this
            elif isinstance(curr, (exp.Add, exp.Sub, exp.Mul, exp.Div)):
                l_node, r_node = curr.left, curr.right
                if l_node is None or r_node is None:
                    return None
                l_has_col = l_node.find(exp.Column) is not None
                r_has_col = r_node.find(exp.Column) is not None
                if l_has_col and not r_has_col and r_node.find(non_const_types) is None:
                    k_val = _eval_sqlglot_ast_python(r_node, None, "")
                    col_branch = l_node
                    col_on_left = True
                elif r_has_col and not l_has_col and l_node.find(non_const_types) is None:
                    k_val = _eval_sqlglot_ast_python(l_node, None, "")
                    col_branch = r_node
                    col_on_left = False
                else:
                    return None
                if not isinstance(k_val, (int, float)) or isinstance(k_val, bool):
                    return None
                k = float(k_val)
                if isinstance(curr, exp.Add):
                    v = v - k
                elif isinstance(curr, exp.Sub):
                    v = (v + k) if col_on_left else (k - v)
                elif isinstance(curr, exp.Mul):
                    if k == 0:
                        return None
                    v = v / k
                elif isinstance(curr, exp.Div):
                    if col_on_left:
                        v = v * k
                    else:
                        if v == 0:
                            return None
                        v = k / v
                curr = col_branch
            else:
                return None

        val_str = str(int(round(v))) if abs(v - round(v)) < 1e-9 else str(v)
        return (curr.table, curr.name, val_str)

    def extract_literals(
        self,
        node: exp.Expression,
        cte_const_map: Dict[tuple[str, str], List[str]] | None = None,
    ) -> List[tuple[str, str, str]]:
        literals: List[tuple[str, str, str]] = []
        if isinstance(node, exp.Between):
            for bound_key in ("low", "high"):
                bound_vals = self._extract_constant_values(node.args.get(bound_key), cte_const_map)
                for b_val in bound_vals:
                    inv = self._unwrap_column_and_invert_val(node.this, b_val)
                    if inv and inv not in literals:
                        literals.append(inv)
        elif hasattr(node, "left") and hasattr(node, "right"):
            left, right = node.left, node.right
            right_vals = self._extract_constant_values(right, cte_const_map)
            for r_val in right_vals:
                inv = self._unwrap_column_and_invert_val(left, r_val)
                if inv and inv not in literals:
                    literals.append(inv)
            left_vals = self._extract_constant_values(left, cte_const_map)
            for l_val in left_vals:
                inv = self._unwrap_column_and_invert_val(right, l_val)
                if inv and inv not in literals:
                    literals.append(inv)
        return literals

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        datasets = []
        target_index = 0
        base_data = None
        
        # Keep track of generated injections to avoid duplicates
        generated_injections = set()
        cte_const_map = self._build_cte_constant_column_map(ast, schema=schema)

        for comp in ast.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ, exp.NEQ, exp.Between)):
            extracted = self.extract_literals(comp, cte_const_map=cte_const_map)
            for table_alias, column_name, val in extracted:
                is_num = isinstance(val, int) or isinstance(val, float) or (isinstance(val, str) and val.lstrip('-').replace(".", "").isdigit())
                
                if is_num:
                    base_val = float(val)
                    if base_val.is_integer():
                        base_val = int(base_val)
                        offsets = [0, 1, -1]
                    else:
                        offsets = [0.0, 1.0, -1.0]

                    for offset in offsets:
                        new_val = base_val + offset
                        resolved_target = resolve_query_column(schema, parsed_query, table_alias, column_name)
                        if resolved_target:
                            t_name, c_name = resolved_target
                            inj_key = (t_name, c_name, new_val)
                            if inj_key not in generated_injections:
                                generated_injections.add(inj_key)
                                val_injections = {(t_name, c_name): new_val}
                                mock_data = generate_base_dataset(schema, parsed_query, value_injections=val_injections)
                                datasets.append(
                                    Dataset(
                                        strategy_name=f"{self.__class__.__name__}_numeric_{column_name}_offset_{offset}",
                                        data=mock_data,
                                        tags=["comparison_attack"],
                                        description=f"Targets Comparison Operator bugs. Dataset injects a value into `{column_name}` that is offset by exactly {offset} relative to the comparison literal. This specifically tests boundary conditions, ensuring that subtle operator mutations (like mutating `<` to `<=`, or `>` to `>=`) will produce different row filtering outcomes."
                                    )
                                )

                    if base_val != 0:
                        neg_val = -base_val
                        resolved_target = resolve_query_column(schema, parsed_query, table_alias, column_name)
                        if resolved_target:
                            t_name, c_name = resolved_target
                            col_obj = schema.find_column(t_name, c_name)
                            if col_obj and not col_obj.is_primary_key and not col_obj.is_temporal:
                                checked_neg = solve_check_constraint_value(
                                    schema, t_name, c_name, col_obj, neg_val
                                )
                                neg_key = (t_name, c_name, "sign_neg", neg_val)
                                if checked_neg == neg_val and neg_key not in generated_injections:
                                    generated_injections.add(neg_key)
                                    if base_data is None:
                                        base_data = generate_base_dataset(schema, parsed_query)
                                    neg_data = generate_base_dataset(
                                        schema, parsed_query, value_injections={(t_name, c_name): neg_val}
                                    )
                                    merged_neg = merge_with_shifted_companion(
                                        schema,
                                        parsed_query,
                                        base_data,
                                        neg_data,
                                        preserved_cols={(t_name, c_name)},
                                    )
                                    datasets.append(
                                        Dataset(
                                            strategy_name=f"{self.__class__.__name__}_numeric_{column_name}_sign_neg",
                                            data=merged_neg,
                                            tags=["comparison_attack", "sign_inversion"],
                                            description=(
                                                f"Targets Sign-Symmetric Comparison / Multiplicative Predicate bugs on `{t_name}.{c_name}`. "
                                                f"Combines baseline rows (`{base_val}`) with a shifted companion component setting `{c_name}` "
                                                f"to its additive inverse (`{neg_val}`), separating direct comparisons (`{c_name} = {base_val}`) "
                                                f"from sign-invariant expressions (`col1 * col2 = {base_val * base_val}`, `ABS({c_name}) = {abs(base_val)}`)."
                                            ),
                                        )
                                    )
                                    if (t_name, c_name, neg_val) not in generated_injections:
                                        generated_injections.add((t_name, c_name, neg_val))
                                        datasets.append(
                                            Dataset(
                                                strategy_name=f"{self.__class__.__name__}_numeric_{column_name}_sign_neg_standalone",
                                                data=neg_data,
                                                tags=["comparison_attack", "sign_inversion"],
                                                description=(
                                                    f"Standalone sign-negation dataset setting `{t_name}.{c_name}` to `{neg_val}` "
                                                    f"(additive inverse of `{base_val}`)."
                                                ),
                                            )
                                        )
                else:
                    distinct_value = self._distinct_literal_value(
                        schema, parsed_query, table_alias, column_name, val
                    )
                    candidates = [("match", val)]
                    str_val = str(val)
                    greater_val = str_val + "_z"
                    smaller_val = str_val[:max(1, len(str_val) - 1)] if len(str_val) > 1 else (chr(max(32, ord(str_val[0]) - 1)) if str_val else "A")
                    if greater_val != val:
                        candidates.append(("greater", greater_val))
                    if smaller_val != val:
                        candidates.append(("smaller", smaller_val))
                    if distinct_value is not None and distinct_value not in (val, greater_val, smaller_val):
                        candidates.append(("mismatch", distinct_value))

                    for label, new_val in candidates:
                        resolved_target = resolve_query_column(schema, parsed_query, table_alias, column_name)
                        if resolved_target:
                            t_name, c_name = resolved_target
                            inj_key = (t_name, c_name, new_val)
                            if inj_key not in generated_injections:
                                generated_injections.add(inj_key)
                                val_injections = {(t_name, c_name): new_val}
                                mock_data = generate_base_dataset(schema, parsed_query, value_injections=val_injections)
                                datasets.append(
                                    Dataset(
                                        strategy_name=f"{self.__class__.__name__}_string_{column_name}_{label}_{target_index}",
                                        data=mock_data,
                                        tags=["comparison_attack"],
                                        description=f"Targets String Comparison bugs. Dataset explicitly sets `{column_name}` to a `{label}` string literal to check exact string matching semantics. This verifies correct distinguishing between string operators like `=`, `LIKE`, or `IN` by injecting boundary strings."
                                    )
                                )
                target_index += 1

        # Target CAST(text_col AS INTEGER/REAL) vs uncast text_col comparisons by injecting
        # a non-canonical leading-zero numeric string (e.g. '01'), which is invariant under
        # numeric cast (CAST('01' AS INTEGER) = 1) but distinct under string affinity ('01' != '1').
        for cast_node in ast.find_all((exp.Cast, exp.TryCast)):
            col_node = cast_node.this if isinstance(cast_node.this, exp.Column) else cast_node.this.find(exp.Column)
            if not col_node:
                continue
            target_type_str = str(cast_node.to).lower() if cast_node.to else ""
            if not any(k in target_type_str for k in ("int", "real", "floa", "doub", "num", "dec")):
                continue
            resolved_target = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if not resolved_target:
                continue
            t_name, c_name = resolved_target
            col_obj = schema.find_column(t_name, c_name)
            if not col_obj or not col_obj.is_text:
                continue

            base_num_str = "1"
            for lit in parsed_query.get("where_literals", []):
                res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
                if res_lit == (t_name, c_name):
                    lit_val = str(lit.get("value", ""))
                    if lit_val.lstrip("-").isdigit():
                        base_num_str = lit_val
                        break

            padded_val = f"0{base_num_str}" if not base_num_str.startswith("-") else f"-0{base_num_str[1:]}"
            inj_key = (t_name, c_name, padded_val)
            if inj_key not in generated_injections:
                generated_injections.add(inj_key)
                mock_data = generate_base_dataset(schema, parsed_query, value_injections={(t_name, c_name): padded_val})
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_cast_leading_zero_{c_name}",
                        data=mock_data,
                        tags=["comparison_attack", "type_cast"],
                        description=(
                            f"Targets Type Cast Comparison bugs on `{t_name}.{c_name}`. Injects leading-zero numeric "
                            f"string `{padded_val}` which evaluates to `{base_num_str}` under numeric CAST but fails "
                            f"direct string equality under TEXT affinity."
                        ),
                    )
                )

        # Target lexicographical string range/comparison vs numeric CAST comparison on TEXT columns
        # (including SUBSTR/SUBSTRING extractions), e.g. SUBSTR(col, 1, 4) BETWEEN '1987' AND '1992'
        # vs CAST(SUBSTR(col, 1, 4) AS INTEGER) BETWEEN 1987 AND 1992.
        # An alphanumeric boundary string such as '198a' lies strictly inside the lexicographical
        # interval ['1987', '1992'] while SQLite CAST('198a' AS INTEGER) truncates at the non-digit
        # suffix to 198, falling outside the numeric interval [1987, 1992].
        for comp in ast.find_all((exp.Between, exp.GT, exp.GTE, exp.LT, exp.LTE)):
            for t_name, c_name, cand_val in self._extract_lex_vs_num_cast_candidates(schema, parsed_query, comp):
                inj_key = (t_name, c_name, cand_val)
                if inj_key not in generated_injections:
                    generated_injections.add(inj_key)
                    mock_data = generate_base_dataset(
                        schema, parsed_query, value_injections={(t_name, c_name): cand_val}
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_lex_vs_num_cast_{c_name}",
                            data=mock_data,
                            tags=["comparison_attack", "type_cast"],
                            description=(
                                f"Targets Lexicographical vs Numeric Cast comparison bugs on `{t_name}.{c_name}`. "
                                f"Injects alphanumeric boundary string `{cand_val}` which satisfies lexicographical "
                                f"TEXT comparison but truncates under numeric CAST to a value outside the numeric bound."
                            ),
                        )
                    )

        # Target string-length comparisons (e.g. LENGTH(col) > N, LENGTH(TRIM(col)) > N,
        # LENGTH(REPLACE(col, ' ', '')) > N) by injecting boundary-length strings (N-1, N, N+1)
        # as well as whitespace-padded and interior-space strings at the threshold length.
        seen_len_bounds = set()
        for lit in parsed_query.get("where_literals", []):
            if not lit.get("is_length_expr"):
                continue
            raw_v = lit.get("value")
            if raw_v in (None, "NULL"):
                continue
            try:
                base_n = int(round(float(raw_v)))
            except (ValueError, TypeError):
                continue
            offset_n = int(lit.get("length_offset") or 0)
            eff_bound = max(0, base_n + offset_n)
            resolved_len_col = resolve_query_column(
                schema, parsed_query, lit.get("table", ""), lit.get("column", "")
            )
            if not resolved_len_col:
                continue
            t_name, c_name = resolved_len_col
            bound_key = (t_name, c_name, eff_bound)
            if bound_key in seen_len_bounds:
                continue
            seen_len_bounds.add(bound_key)

            col_obj = schema.find_column(t_name, c_name)
            if base_data is None:
                base_data = generate_base_dataset(schema, parsed_query)
            sat_str = None
            if base_data.get(t_name):
                first_v = base_data[t_name][0].get(c_name)
                if isinstance(first_v, str) and first_v:
                    sat_str = first_v
            if sat_str is None:
                sat_str = str(synthesize_string_of_length(col_obj, max(1, eff_bound + 1)))

            can_multi = bool(col_obj is None or not (col_obj.is_primary_key or col_obj.is_unique))
            for delta in (0, 1, -1):
                cand_len = max(0, eff_bound + delta)
                cand_str = synthesize_string_of_length(col_obj, cand_len)
                inj_key = (t_name, c_name, "len_bound", cand_len)
                if inj_key not in generated_injections:
                    generated_injections.add(inj_key)
                    mock_data = generate_base_dataset(
                        schema, parsed_query, value_injections={(t_name, c_name): cand_str}
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_length_{c_name}_offset_{delta}",
                            data=mock_data,
                            tags=["comparison_attack", "length_boundary"],
                            description=(
                                f"Targets String Length Comparison boundary bugs on `{t_name}.{c_name}`. "
                                f"Injects a string of exact length {cand_len} (offset {delta} from threshold {eff_bound})."
                            ),
                        )
                    )
                if can_multi and isinstance(cand_str, str) and len(cand_str) != len(sat_str):
                    pair_key = (t_name, c_name, "len_pair", len(sat_str), cand_len)
                    if pair_key not in generated_injections:
                        generated_injections.add(pair_key)
                        pair_data = generate_base_dataset(
                            schema,
                            parsed_query,
                            value_injections={(t_name, c_name): [sat_str, cand_str]},
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_length_{c_name}_paired_offset_{delta}",
                                data=pair_data,
                                tags=["comparison_attack", "length_boundary"],
                                description=(
                                    f"Targets String Length Comparison boundary bugs on `{t_name}.{c_name}`. "
                                    f"Combines a satisfying row (length {len(sat_str)}) with a boundary row of exact length {cand_len}."
                                ),
                            )
                        )

            if col_obj is None or col_obj.is_text:
                for ws_len in (eff_bound + 1, eff_bound):
                    if ws_len < 1:
                        continue
                    if ws_len >= 3:
                        core_edge = str(synthesize_string_of_length(col_obj, ws_len - 2))
                        ws_edge = f" {core_edge} "
                    elif ws_len == 2:
                        core_edge = str(synthesize_string_of_length(col_obj, 1))
                        ws_edge = f"{core_edge} "
                    else:
                        ws_edge = " "

                    ws_edge_inj = [sat_str, ws_edge] if can_multi else ws_edge
                    edge_key = (t_name, c_name, "len_ws_edge", ws_len)
                    if edge_key not in generated_injections:
                        generated_injections.add(edge_key)
                        edge_data = generate_base_dataset(
                            schema,
                            parsed_query,
                            value_injections={(t_name, c_name): ws_edge_inj},
                        )
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_length_trim_ws_{c_name}_{ws_len}",
                                data=edge_data,
                                tags=["comparison_attack", "string_function_attack"],
                                description=(
                                    f"Targets LENGTH vs LENGTH(TRIM/LTRIM/RTRIM/REPLACE) bugs on `{t_name}.{c_name}`. "
                                    f"Injects whitespace-padded string of raw length {ws_len} and trimmed length {len(ws_edge.strip())}."
                                ),
                            )
                        )

                    if ws_len >= 3:
                        core_inf = str(synthesize_string_of_length(col_obj, ws_len - 1))
                        mid = max(1, len(core_inf) // 2)
                        ws_infix = core_inf[:mid] + " " + core_inf[mid:]
                        ws_inf_inj = [sat_str, ws_infix] if can_multi else ws_infix
                        inf_key = (t_name, c_name, "len_ws_infix", ws_len)
                        if inf_key not in generated_injections:
                            generated_injections.add(inf_key)
                            inf_data = generate_base_dataset(
                                schema,
                                parsed_query,
                                value_injections={(t_name, c_name): ws_inf_inj},
                            )
                            datasets.append(
                                Dataset(
                                    strategy_name=f"{self.__class__.__name__}_length_infix_ws_{c_name}_{ws_len}",
                                    data=inf_data,
                                    tags=["comparison_attack", "string_function_attack"],
                                    description=(
                                        f"Targets LENGTH/TRIM vs LENGTH(REPLACE(col, ' ', '')) bugs on `{t_name}.{c_name}`. "
                                        f"Injects interior-space string of raw/trimmed length {ws_len} and space-stripped length {ws_len - 1}."
                                    ),
                                )
                            )

        return datasets

    def _unwrap_text_col_or_substr(
        self, schema: Schema, parsed_query: Dict[str, Any], expr: exp.Expression
    ) -> tuple[str, str, int, int | None, bool] | None:
        if expr is None:
            return None
        curr = expr
        has_num_cast = False
        while isinstance(curr, (exp.Cast, exp.TryCast, exp.Paren)):
            if isinstance(curr, (exp.Cast, exp.TryCast)):
                to_str = str(curr.to).lower() if curr.to else ""
                if any(k in to_str for k in ("int", "real", "floa", "doub", "num", "dec")):
                    has_num_cast = True
            curr = curr.this

        start_pos = 1
        sub_len = None
        has_substr = False
        col_node = None

        if isinstance(curr, exp.Substring):
            has_substr = True
            col_node = curr.this if isinstance(curr.this, exp.Column) else curr.this.find(exp.Column) if curr.this else None
            start_arg = curr.args.get("start")
            len_arg = curr.args.get("length")
            if isinstance(start_arg, exp.Literal) and str(start_arg.name).isdigit():
                start_pos = max(1, int(start_arg.name))
            if isinstance(len_arg, exp.Literal) and str(len_arg.name).isdigit():
                sub_len = int(len_arg.name)
        elif isinstance(curr, exp.Anonymous) and curr.name.lower() in ("substr", "substring") and curr.expressions:
            has_substr = True
            first_arg = curr.expressions[0]
            col_node = first_arg if isinstance(first_arg, exp.Column) else first_arg.find(exp.Column)
            if len(curr.expressions) >= 2 and isinstance(curr.expressions[1], exp.Literal) and str(curr.expressions[1].name).isdigit():
                start_pos = max(1, int(curr.expressions[1].name))
            if len(curr.expressions) >= 3 and isinstance(curr.expressions[2], exp.Literal) and str(curr.expressions[2].name).isdigit():
                sub_len = int(curr.expressions[2].name)
        elif isinstance(curr, exp.Column):
            col_node = curr

        if not col_node:
            return None
        resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
        if not resolved:
            return None
        t_name, c_name = resolved
        col_obj = schema.find_column(t_name, c_name)
        if not col_obj or not col_obj.is_text:
            return None
        return t_name, c_name, start_pos, sub_len, (has_substr or has_num_cast)

    def _extract_lex_vs_num_cast_candidates(
        self, schema: Schema, parsed_query: Dict[str, Any], comp: exp.Expression
    ) -> List[tuple[str, str, str]]:
        results: List[tuple[str, str, str]] = []
        prefix_for = lambda pos: ("1" * (pos - 1)) if pos > 1 else ""

        if isinstance(comp, exp.Between):
            unwrapped = self._unwrap_text_col_or_substr(schema, parsed_query, comp.this)
            if not unwrapped:
                return results
            t_name, c_name, start_pos, sub_len, _ = unwrapped
            low_node = comp.args.get("low")
            high_node = comp.args.get("high")
            if not (isinstance(low_node, exp.Literal) and isinstance(high_node, exp.Literal)):
                return results
            low_s = str(low_node.name)
            high_s = str(high_node.name)
            if not (low_s.lstrip("-").isdigit() and high_s.lstrip("-").isdigit()):
                return results

            pref = prefix_for(start_pos)
            if len(low_s) >= 2 and low_s[:-1] < high_s[:len(low_s) - 1]:
                results.append((t_name, c_name, pref + low_s[:-1] + "a"))
            if low_s < high_s and (sub_len is None or sub_len > len(low_s)):
                results.append((t_name, c_name, pref + low_s + "a"))
            if sub_len is None or sub_len > len(high_s):
                results.append((t_name, c_name, pref + high_s + "a"))
            return results

        if hasattr(comp, "left") and hasattr(comp, "right"):
            left_unwrapped = self._unwrap_text_col_or_substr(schema, parsed_query, comp.left)
            right_unwrapped = self._unwrap_text_col_or_substr(schema, parsed_query, comp.right)
            if left_unwrapped and isinstance(comp.right, exp.Literal):
                t_name, c_name, start_pos, sub_len, has_wrap = left_unwrapped
                lit_node = comp.right
                op = comp.__class__.__name__.upper()
            elif right_unwrapped and isinstance(comp.left, exp.Literal):
                t_name, c_name, start_pos, sub_len, has_wrap = right_unwrapped
                lit_node = comp.left
                invert_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE"}
                op = invert_map.get(comp.__class__.__name__.upper(), comp.__class__.__name__.upper())
            else:
                return results

            lit_s = str(lit_node.name)
            if not lit_s.isdigit() or not (has_wrap or lit_node.is_string):
                return results

            pref = prefix_for(start_pos)
            if op in ("GT", "GTE") and len(lit_s) >= 2:
                results.append((t_name, c_name, pref + lit_s[:-1] + "a"))
            elif op in ("LT", "LTE") and len(lit_s) >= 2 and lit_s[0] < "9":
                results.append((t_name, c_name, pref + str(int(lit_s[0]) + 1)))

        return results
