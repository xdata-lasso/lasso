"""
ReplaceAttackStrategy Module

Target semantic bugs:
1. Omitted or spurious `REPLACE(expr, pattern, replacement)` string transformations
   (e.g., `SUM(col)` vs `SUM(CAST(REPLACE(REPLACE(col, '{', ''), '}', '') AS INTEGER))`,
   `SELECT col` vs `SELECT REPLACE(col, '-', '')`, or `WHERE col = lit` vs
   `WHERE REPLACE(col, ':', '') = lit`).
2. Incomplete nested `REPLACE` chains (omitting one step of `REPLACE(REPLACE(col, p1, r1), p2, r2)`).
3. Wrong search pattern or replacement literal in `REPLACE(expr, pattern, replacement)`.

Algorithm & Relational Dataset Design:
In SQL semantics, `REPLACE(s, p, r)` is an identity mapping whenever pattern `p` does not
occur as a substring of `s`. To distinguish an expression applying a `REPLACE` chain
`[(p_1, r_1), ..., (p_k, r_k)]` from an expression that omits or mutates `REPLACE`:
1. Extracts maximal nested `REPLACE` chains over target columns (including `SUBSTR`/`SUBSTRING`
   inner slices) and resolves their canonical post-replacement target string `T` from query
   predicate constraints (or a non-zero numeric string `'12'` / `'12.5'` when unconstrained).
2. Synthesizes pre-image strings in the fiber of `T` under the `REPLACE` chain:
   - `prefix`: prepends deleted patterns (or inverts non-empty replacements `r_i -> p_i`) at
     the leading boundary of `T` (e.g., `'{}12'`), causing un-replaced SQLite numeric casts and
     aggregates (`SUM`, `AVG`, `CAST`) to evaluate the leading non-digit prefix to `0` while
     the full `REPLACE` chain evaluates to `12`.
   - `infix`: embeds deleted patterns inside `T` after its first character (e.g., `'1{}2'`,
     `'1+2'`, `'1:40'`), causing un-replaced numeric casts to truncate at the interior
     delimiter (`1`) and `SUM`/`AVG` to evaluate to `0.0`, while the `REPLACE` chain yields `T`.
   - `wrap`: for multi-step deletion chains, wraps `T` with leading and trailing patterns
     (e.g., `'{12}'`).
   - `paired`: combines the canonical string `T` and its pre-image `prefix` across two rows,
     ensuring non-empty baseline filtering while separating `GROUP BY`, `DISTINCT`, `COUNT(DISTINCT)`,
     and aggregate sums with vs without `REPLACE`.
"""

import re
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot
import sqlglot.expressions as exp

from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column
from models import Column, Dataset, Schema


def _parse_char_limit(data_type: str) -> Optional[int]:
    match = re.search(r"(?:(?:var)?char|character\s+varying|text)\s*\((\d+)\)", (data_type or "").lower())
    return int(match.group(1)) if match else None


def _extract_int_literal(node: Optional[exp.Expression]) -> Optional[int]:
    if isinstance(node, exp.Literal):
        try:
            return int(node.this)
        except (ValueError, TypeError):
            return None
    return None


def _extract_replace_step(node: exp.Expression) -> Optional[Tuple[exp.Expression, str, str]]:
    """
    If `node` is a SQL REPLACE(target, old_sub, new_sub) expression with literal
    pattern/replacement arguments, return `(target_expr, old_str, new_str)`.
    """
    target: Optional[exp.Expression] = None
    old_node: Optional[exp.Expression] = None
    new_node: Optional[exp.Expression] = None

    if isinstance(node, exp.Anonymous) and (node.name or "").lower() == "replace":
        exprs = node.expressions or []
        if len(exprs) >= 2:
            target = exprs[0]
            old_node = exprs[1]
            new_node = exprs[2] if len(exprs) >= 3 else exp.Literal.string("")
    elif isinstance(node, exp.Func) and not isinstance(node, exp.Anonymous):
        is_replace = (
            node.__class__.__name__.lower() == "replace"
            or (getattr(node, "key", "") or "").lower() == "replace"
        )
        if is_replace:
            target = node.this
            exprs = node.expressions or []
            old_node = node.args.get("expression") or (exprs[0] if exprs else None)
            if node.args.get("replacement") is not None:
                new_node = node.args.get("replacement")
            elif node.args.get("expression") is not None and exprs:
                new_node = exprs[0]
            elif len(exprs) >= 2:
                new_node = exprs[1]
            else:
                new_node = exp.Literal.string("")

    if target is None or not isinstance(old_node, exp.Literal) or not isinstance(new_node, exp.Literal):
        return None

    old_str = str(old_node.name)
    new_str = str(new_node.name)
    if not old_str or old_str == new_str:
        return None

    return target, old_str, new_str


def _unwrap_transparent(expr: exp.Expression) -> exp.Expression:
    curr = expr
    while isinstance(curr, (exp.Paren, exp.Trim, exp.Lower, exp.Upper)):
        if curr.this is None:
            break
        curr = curr.this
    return curr


class ReplaceAttackStrategy(AttackStrategy):
    """
    Attack strategy targeting `REPLACE(expr, pattern, replacement)` string transformations
    and nested `REPLACE` chains.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._extract_replace_chains(schema, parsed_query))

    def _extract_replace_chains(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Tuple[str, str, List[Tuple[str, str]], int, Optional[int]]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        chains: List[Tuple[str, str, List[Tuple[str, str]], int, Optional[int]]] = []
        seen_keys: Set[Tuple[str, str, Tuple[Tuple[str, str], ...], int, Optional[int]]] = set()

        for node in ast.walk():
            actual = node[0] if isinstance(node, tuple) else node
            if not isinstance(actual, exp.Expression):
                continue
            step = _extract_replace_step(actual)
            if step is None:
                continue

            # Skip inner REPLACE nodes that are the direct target of an enclosing REPLACE
            curr_p = actual.parent
            while isinstance(curr_p, (exp.Paren, exp.Trim, exp.Lower, exp.Upper)):
                curr_p = curr_p.parent
            if curr_p is not None:
                parent_step = _extract_replace_step(curr_p)
                if parent_step is not None and _unwrap_transparent(parent_step[0]) is actual:
                    continue

            steps_outer_to_inner: List[Tuple[str, str]] = []
            curr_expr: exp.Expression = actual
            while True:
                curr_unwrapped = _unwrap_transparent(curr_expr)
                s = _extract_replace_step(curr_unwrapped)
                if s is None:
                    curr_expr = curr_unwrapped
                    break
                steps_outer_to_inner.append((s[1], s[2]))
                curr_expr = s[0]

            if not steps_outer_to_inner:
                continue

            steps = list(reversed(steps_outer_to_inner))

            # Check if the innermost expression is a SUBSTR / SUBSTRING call
            substr_start = 1
            substr_len: Optional[int] = None
            col_node: Optional[exp.Column] = None

            inner = _unwrap_transparent(curr_expr)
            while isinstance(inner, (exp.Cast, exp.TryCast)):
                inner = _unwrap_transparent(inner.this)

            if isinstance(inner, exp.Substring):
                st = _extract_int_literal(inner.args.get("start"))
                ln = _extract_int_literal(inner.args.get("length"))
                if st is not None and st >= 1:
                    substr_start = st
                if ln is not None and ln >= 0:
                    substr_len = ln
                col_node = inner.this if isinstance(inner.this, exp.Column) else inner.find(exp.Column)
            elif isinstance(inner, exp.Anonymous) and (inner.name or "").lower() in ("substr", "substring"):
                exprs = inner.expressions or []
                if exprs:
                    col_node = exprs[0] if isinstance(exprs[0], exp.Column) else exprs[0].find(exp.Column)
                if len(exprs) >= 2:
                    st = _extract_int_literal(exprs[1])
                    if st is not None and st >= 1:
                        substr_start = st
                if len(exprs) >= 3:
                    ln = _extract_int_literal(exprs[2])
                    if ln is not None and ln >= 0:
                        substr_len = ln
            else:
                col_node = inner if isinstance(inner, exp.Column) else inner.find(exp.Column)

            if col_node is None:
                continue

            resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if not resolved:
                continue

            t_name, c_name = resolved
            chain_key = (t_name, c_name, tuple(steps), substr_start, substr_len)
            if chain_key not in seen_keys:
                seen_keys.add(chain_key)
                chains.append((t_name, c_name, steps, substr_start, substr_len))

        return chains

    def _resolve_target_string(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        base_data: Dict[str, List[Dict[str, Any]]],
        t_name: str,
        c_name: str,
        steps: List[Tuple[str, str]],
    ) -> str:
        has_where_constraint = False
        for lit in parsed_query.get("where_literals", []):
            res_lit = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if res_lit == (t_name, c_name) and lit.get("value") not in (None, "NULL"):
                has_where_constraint = True
                break

        if has_where_constraint and base_data.get(t_name):
            base_val = base_data[t_name][0].get(c_name)
            if base_val is not None and str(base_val).strip() not in ("", "0", "0.0"):
                return str(base_val)

        if any(new_s == "." for _, new_s in steps):
            return "12.5"
        for _, new_s in steps:
            if new_s and new_s.isdigit():
                return f"1{new_s}2"
        return "12"

    def _build_preimage_candidates(
        self,
        target_str: str,
        steps: List[Tuple[str, str]],
        substr_start: int,
        char_limit: Optional[int],
    ) -> List[Tuple[str, str]]:
        lead_pad = "_" * (substr_start - 1) if substr_start > 1 else ""

        # 1. Prefix / inverse pre-image
        s_pref = target_str
        for old_s, new_s in reversed(steps):
            if new_s and new_s in s_pref:
                s_pref = s_pref.replace(new_s, old_s)
            else:
                s_pref = old_s + s_pref

        # 2. Infix pre-image (embeds deleted patterns inside target_str after first char)
        s_inf = target_str
        for old_s, new_s in reversed(steps):
            if new_s and new_s in s_inf:
                s_inf = s_inf.replace(new_s, old_s)
            elif len(s_inf) >= 2:
                s_inf = s_inf[0] + old_s + s_inf[1:]
            else:
                s_inf = s_inf + old_s

        raw_candidates: List[Tuple[str, str]] = [
            ("prefix", lead_pad + s_pref),
            ("infix", lead_pad + s_inf),
        ]

        # 3. Wrap pre-image for multi-step deletion chains (e.g. '{12}')
        if len(steps) >= 2 and all(new_s == "" for _, new_s in steps):
            s_wrap = steps[0][0] + target_str + "".join(old_s for old_s, _ in steps[1:])
            raw_candidates.append(("wrap", lead_pad + s_wrap))

        # 4. Raw-length-preserving pre-image for length-shrinking REPLACE chains
        # (e.g. LENGTH(REPLACE(col, ' ', '')) > N vs LENGTH(col) > N)
        shrink_delta = sum(max(0, len(old_s) - len(new_s)) for old_s, new_s in steps)
        if shrink_delta > 0 and len(target_str) > shrink_delta:
            s_shrunk = target_str[: len(target_str) - shrink_delta]
            for old_s, new_s in reversed(steps):
                if new_s and new_s in s_shrunk:
                    s_shrunk = s_shrunk.replace(new_s, old_s, 1)
                elif len(s_shrunk) >= 2:
                    mid = len(s_shrunk) // 2
                    s_shrunk = s_shrunk[:mid] + old_s + s_shrunk[mid:]
                else:
                    s_shrunk = s_shrunk + old_s
            raw_candidates.append(("length_preserving", lead_pad + s_shrunk))

        clean_full = lead_pad + target_str
        results: List[Tuple[str, str]] = []
        seen_vals: Set[str] = {clean_full}
        for label, cand in raw_candidates:
            if char_limit is not None and len(cand) > char_limit:
                cand = cand[:char_limit]
            if cand and cand not in seen_vals:
                seen_vals.add(cand)
                results.append((label, cand))

        return results

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        chains = self._extract_replace_chains(schema, parsed_query)
        if not chains:
            return []

        base_data = generate_base_dataset(schema, parsed_query)
        datasets: List[Dataset] = []
        seen_injections: Set[Tuple[str, str, Any]] = set()

        for chain_idx, (t_name, c_name, steps, substr_start, _) in enumerate(chains):
            col_obj: Optional[Column] = schema.find_column(t_name, c_name)
            char_limit = _parse_char_limit(col_obj.data_type) if col_obj else None

            target_str = self._resolve_target_string(
                schema, parsed_query, base_data, t_name, c_name, steps
            )
            candidates = self._build_preimage_candidates(
                target_str, steps, substr_start, char_limit
            )

            for label, cand_val in candidates:
                inj_key = (t_name, c_name, cand_val)
                if inj_key in seen_injections:
                    continue
                seen_injections.add(inj_key)

                mock_data = generate_base_dataset(
                    schema,
                    parsed_query,
                    value_injections={(t_name, c_name): cand_val},
                    cache_key_salt=f"replace_{label}_{chain_idx}_{t_name}_{c_name}",
                )
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_{c_name}_{label}_{chain_idx}",
                        data=mock_data,
                        tags=["replace_attack", "string_function_attack"],
                        description=(
                            f"Targets REPLACE string transformation bugs on `{t_name}.{c_name}`. "
                            f"Injects pre-image string `{cand_val}` containing the REPLACE pattern(s) "
                            f"so that applying the REPLACE chain yields `{target_str}` whereas omitting "
                            f"or partially applying REPLACE leaves the pattern unstripped."
                        ),
                    )
                )

            if candidates and col_obj and not (col_obj.is_primary_key or col_obj.is_unique):
                lead_pad = "_" * (substr_start - 1) if substr_start > 1 else ""
                clean_full = lead_pad + target_str
                if char_limit is not None and len(clean_full) > char_limit:
                    clean_full = clean_full[:char_limit]
                first_preimage = candidates[0][1]
                pair_key = (t_name, c_name, (clean_full, first_preimage))
                if pair_key not in seen_injections:
                    seen_injections.add(pair_key)
                    paired_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={(t_name, c_name): [clean_full, first_preimage]},
                        cache_key_salt=f"replace_paired_{chain_idx}_{t_name}_{c_name}",
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_paired_{chain_idx}",
                            data=paired_data,
                            tags=["replace_attack", "string_function_attack"],
                            description=(
                                f"Targets REPLACE string transformation bugs on `{t_name}.{c_name}`. "
                                f"Combines canonical value `{clean_full}` with REPLACE pre-image `{first_preimage}` "
                                f"across two rows, separating queries that normalize via REPLACE from those that do not."
                            ),
                        )
                    )

        return datasets
