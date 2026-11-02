"""
SubstringAttackStrategy Module

Target semantic bugs: Mutations in SQL SUBSTRING / SUBSTR and INSTR / STRPOS expressions, including:
1. Substring decomposition / skipped interior delimiter mutations (e.g., splitting
   `SUBSTRING(col, 1, 7) = '1970-10'` into `SUBSTRING(col, 1, 4) = '1970' AND SUBSTRING(col, 6, 2) = '10'`,
   leaving the delimiter position unconstrained).
2. Omitted SUBSTRING function (`col = lit`) or expanded length parameter (`SUBSTRING(col, start, len + 1)`).
3. Truncated length parameter (`SUBSTRING(col, start, len - 1)`) or prefix/suffix-only checks.
4. Shifted start offset parameter (`SUBSTRING(col, start + 1, len)`).
5. Delimiter-based `SUBSTRING` + `INSTR` / `STRPOS` / `POSITION` / `CHARINDEX` parsing mutations:
   - `CAST(SUBSTRING(col, 1, INSTR(col, d) - 1) AS INTEGER)` vs `CAST(... AS REAL)` (or on the
     post-delimiter suffix `SUBSTRING(col, INSTR(col, d) + 1)`), where `INTEGER` cast truncates
     fractional digits while `REAL` cast preserves them.
   - Off-by-one boundary shifts around the delimiter index (`INSTR(col, d)` vs `INSTR(col, d) - 1`
     or `INSTR(col, d) + 1`), fixed-offset substring substitution (`SUBSTRING(col, 1, k)` vs
     dynamic `INSTR`), and prefix/suffix swap mutations.

Algorithm & Relational Dataset Design:
Part A — Predicate `SUBSTRING(col, start, length)` slices:
1. Constructs the baseline composite character map from all compatible `SUBSTRING` equality/IN
   slices on that column, filling any unconstrained interior or prefix positions with `'_'`.
2. Generates a standalone suffix-extended dataset (`suffix_extension`) by appending a non-space
   character after the constrained slice end. This satisfies the `SUBSTRING` predicate while
   falsifying mutants that omit `SUBSTRING` (`col = lit`) or increase `length`.
3. Generates merged datasets combining a baseline satisfying row with targeted boundary rows:
   - `delimiter_mutation`: replaces non-alphanumeric delimiter characters (such as `'-'`, `'/'`,
     `':'`, `'.'`, `' '`) inside the target slice with a distinct separator (`'_'` or `'#'`),
     preserving all alphanumeric sub-tokens at their exact 1-based offsets. The reference query
     rejects the mutated row while retaining the baseline row, whereas a mutant that decomposes
     the check across delimiters admits both rows.
   - `boundary_last_char` / `boundary_first_char`: mutates the final or initial character of the
     target slice to catch off-by-one length/start mutations or partial slice checks.
   - `shifted_start`: shifts the target slice by +1 character position to catch start-offset
     off-by-one mutations.

Part B — Delimiter-based `INSTR` / `SUBSTRING` and `CAST(SUBSTRING(...) AS INT/REAL)` projections:
1. Extracts columns searched by `INSTR` / `STRPOS` / `POSITION` / `CHARINDEX` (`exp.StrPosition`)
   and collects their ordered literal delimiters `[d_1, ..., d_k]`.
2. Generates a `delimiter_fractional_tokens` dataset joining distinct multi-digit decimal numbers
   with non-zero, linearly independent fractional parts (e.g., `'12.5'` and `'34.75'` -> `'12.5:34.75'`;
   or scientific notation `'1e1'` / `'2e1'` if `'.'` is in the delimiter). Under SQLite semantics,
   `CAST('12.5' AS INTEGER)` truncates to `12` whereas `CAST('12.5' AS REAL)` evaluates to `12.5`,
   while off-by-one `INSTR` offsets either include the delimiter (`':34.75'` -> `0.0`) or drop a digit.
3. Generates a `delimiter_varied_offset` dataset with distinct prefix lengths across rows
   (e.g., `['12.5:34.75', '7.5:18.25']`) so the delimiter index varies per row, refuting mutants
   that replace `INSTR(col, d)` with a constant substring offset/length.
"""

import copy
import re
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot
import sqlglot.expressions as exp

from attacks.base import AttackStrategy
from dataset_generator import deduplicate_mock_data, generate_base_dataset, resolve_query_column
from models import Column, Dataset, Schema


def _parse_char_limit(data_type: str) -> Optional[int]:
    match = re.search(r"(?:(?:var)?char|character\s+varying|text)\s*\((\d+)\)", (data_type or "").lower())
    return int(match.group(1)) if match else None


def _distinct_char(ch: str) -> str:
    if ch.isdigit():
        return "9" if ch != "9" else "8"
    if ch.isalpha():
        if ch.isupper():
            return "Z" if ch != "Z" else "Y"
        return "z" if ch != "z" else "y"
    return "_" if ch != "_" else "#"


class SubstringAttackStrategy(AttackStrategy):
    """
    Attack strategy targeting SUBSTRING / SUBSTR slice boundary, length, offset,
    and interior delimiter decomposition mutations.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for lit in parsed_query.get("where_literals", []):
            if (
                lit.get("substr_start") is not None
                and int(lit["substr_start"]) >= 1
                and lit.get("value") != "NULL"
            ):
                return True
        if self._extract_delimiter_targets(schema, parsed_query):
            return True
        return False

    def _extract_delimiter_targets(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Tuple[str, str, List[str]]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get("ast") or (sqlglot.parse_one(raw_query) if raw_query else None)
        except Exception:
            ast = None
        if ast is None:
            return []

        constrained_cols: Set[Tuple[str, str]] = set()
        for lit in parsed_query.get("where_literals", []):
            op = (lit.get("operator") or "EQ").upper()
            if op in ("EQ", "IN", "LIKE", "ILIKE", "BETWEENLOWER", "BETWEENUPPER") and lit.get("value") != "NULL":
                resolved_lit = resolve_query_column(
                    schema, parsed_query, lit.get("table", ""), lit.get("column", "")
                )
                if resolved_lit:
                    constrained_cols.add(resolved_lit)

        delims_by_col: Dict[Tuple[str, str], List[str]] = {}
        for pos_node in ast.find_all((exp.StrPosition, exp.Anonymous)):
            target_expr: Optional[exp.Expression] = None
            substr_expr: Optional[exp.Expression] = None
            if isinstance(pos_node, exp.StrPosition):
                target_expr = pos_node.this
                substr_expr = pos_node.args.get("substr")
            elif isinstance(pos_node, exp.Anonymous):
                fn_lower = (pos_node.name or "").lower()
                exprs = pos_node.expressions or []
                if fn_lower in ("instr", "strpos") and len(exprs) >= 2:
                    target_expr, substr_expr = exprs[0], exprs[1]
                elif fn_lower == "charindex" and len(exprs) >= 2:
                    substr_expr, target_expr = exprs[0], exprs[1]

            if target_expr is None or not isinstance(substr_expr, exp.Literal):
                continue
            delim_str = str(substr_expr.name)
            if not delim_str:
                continue
            col_node = target_expr if isinstance(target_expr, exp.Column) else target_expr.find(exp.Column)
            if col_node is None:
                continue
            resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if not resolved or resolved in constrained_cols:
                continue
            t_name, c_name = resolved
            col_obj = schema.find_column(t_name, c_name)
            if not col_obj or not col_obj.is_text or col_obj.is_temporal:
                continue
            col_delims = delims_by_col.setdefault(resolved, [])
            if delim_str not in col_delims:
                col_delims.append(delim_str)

        return [(t_name, c_name, delims) for (t_name, c_name), delims in delims_by_col.items() if delims]

    def _build_delimiter_string(
        self, delims: List[str], token_candidates: List[str], char_limit: Optional[int]
    ) -> str:
        filtered = [
            tok for tok in token_candidates
            if all(d not in tok and tok not in d for d in delims)
        ]
        if len(filtered) < len(delims) + 1:
            filtered = token_candidates
        parts: List[str] = [filtered[0]]
        for idx, d in enumerate(delims):
            parts.append(d)
            parts.append(filtered[(idx + 1) % len(filtered)])
        res = "".join(parts)
        if char_limit is not None and len(res) > char_limit:
            res = res[:char_limit]
        return res

    def _generate_delimiter_datasets(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Dataset]:
        datasets: List[Dataset] = []
        targets = self._extract_delimiter_targets(schema, parsed_query)
        if not targets:
            return datasets

        seen_injections: Set[Tuple[str, str, Any]] = set()
        for t_name, c_name, delims in targets:
            col_obj: Optional[Column] = schema.find_column(t_name, c_name)
            char_limit = _parse_char_limit(col_obj.data_type) if col_obj else None

            if any("." in d for d in delims):
                primary_tokens = ["1e1", "2e1", "3e1", "4e1"]
                shifted_tokens = ["3e1", "4e1", "5e1", "6e1"]
            else:
                primary_tokens = ["12.5", "34.75", "56.25", "78.125", "98.5", "76.25"]
                shifted_tokens = ["7.5", "18.25", "29.75", "41.5", "63.5", "84.25"]

            frac_str = self._build_delimiter_string(delims, primary_tokens, char_limit)
            shifted_str = self._build_delimiter_string(delims, shifted_tokens, char_limit)

            if frac_str:
                inj_key = (t_name, c_name, frac_str)
                if inj_key not in seen_injections:
                    seen_injections.add(inj_key)
                    frac_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={(t_name, c_name): frac_str},
                        cache_key_salt=f"substr_delim_frac_{t_name}_{c_name}",
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_delimiter_fractional_tokens",
                            data=frac_data,
                            tags=["substring_attack", "type_cast"],
                            description=(
                                f"Targets delimiter-based SUBSTRING / INSTR extraction and numeric CAST bugs on "
                                f"`{t_name}.{c_name}`. Injects `{frac_str}` containing fractional decimal tokens "
                                f"around each delimiter so `CAST(SUBSTRING(...) AS INTEGER)` truncates the fractional "
                                f"part while `CAST(SUBSTRING(...) AS REAL)` preserves it, and off-by-one `INSTR` "
                                f"start/length offsets include the delimiter or truncate digits."
                            ),
                        )
                    )

            if (
                frac_str
                and shifted_str
                and shifted_str != frac_str
                and col_obj is not None
                and not (col_obj.is_primary_key or col_obj.is_unique)
            ):
                pair_key = (t_name, c_name, (frac_str, shifted_str))
                if pair_key not in seen_injections:
                    seen_injections.add(pair_key)
                    varied_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={(t_name, c_name): [frac_str, shifted_str]},
                        cache_key_salt=f"substr_delim_varied_{t_name}_{c_name}",
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_delimiter_varied_offset",
                            data=varied_data,
                            tags=["substring_attack"],
                            description=(
                                f"Targets dynamic INSTR vs fixed-offset SUBSTRING bugs on `{t_name}.{c_name}` by "
                                f"injecting rows with distinct prefix lengths (`{frac_str}`, `{shifted_str}`), "
                                f"ensuring the delimiter index varies across rows."
                            ),
                        )
                    )

        return datasets

    def _build_base_char_map(self, col_lits: List[dict]) -> Dict[int, str]:
        cmap: Dict[int, str] = {}
        for lit in col_lits:
            if lit.get("operator", "EQ").upper() not in ("EQ", "IN"):
                continue
            start_pos = int(lit["substr_start"])
            if start_pos < 1:
                continue
            sub_len = lit.get("substr_length")
            s_val = str(lit["value"])
            if sub_len is not None and int(sub_len) >= 0:
                s_val = s_val[: int(sub_len)]
            slice_map = {(start_pos - 1) + k: ch for k, ch in enumerate(s_val)}
            if all(pos not in cmap or cmap[pos] == ch for pos, ch in slice_map.items()):
                cmap.update(slice_map)
        return cmap

    def _render_char_map(
        self, cmap: Dict[int, str], filler: str = "_", suffix: str = "", char_limit: Optional[int] = None
    ) -> str:
        if not cmap:
            res = suffix
        else:
            max_idx = max(cmap.keys())
            res = "".join(cmap.get(i, filler) for i in range(max_idx + 1)) + suffix
        if char_limit is not None and len(res) > char_limit:
            res = res[:char_limit]
        return res

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets: List[Dataset] = []
        where_literals = parsed_query.get("where_literals", [])

        # Group substring literals by resolved (table_name, column_name)
        lits_by_col: Dict[Tuple[str, str], List[dict]] = {}
        for lit in where_literals:
            if lit.get("substr_start") is None or int(lit["substr_start"]) < 1 or lit.get("value") == "NULL":
                continue
            resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if not resolved:
                continue
            lits_by_col.setdefault(resolved, []).append(lit)

        if not lits_by_col:
            return self._generate_delimiter_datasets(schema, parsed_query)

        seen_Standalone: Set[Tuple[str, str, str]] = set()
        seen_Merged: Set[Tuple[str, str, str]] = set()

        for (t_name, c_name), col_lits in lits_by_col.items():
            col_obj: Optional[Column] = schema.find_column(t_name, c_name)
            char_limit = _parse_char_limit(col_obj.data_type) if col_obj else None

            base_cmap = self._build_base_char_map(col_lits)
            if not base_cmap:
                continue

            satisfying_extended = self._render_char_map(base_cmap, filler="_", suffix="Z", char_limit=char_limit)
            satisfying_exact = self._render_char_map(base_cmap, filler="_", suffix="", char_limit=char_limit)

            # 1. Standalone suffix-extension dataset: satisfies SUBSTRING(col, start, len) = lit
            # while falsifying `col = lit` or `SUBSTRING(col, start, len + 1) = lit`.
            if satisfying_extended != satisfying_exact:
                st_key = (t_name, c_name, satisfying_extended)
                if st_key not in seen_Standalone:
                    seen_Standalone.add(st_key)
                    ext_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={(t_name, c_name): satisfying_extended},
                        cache_key_salt=f"substr_ext_{t_name}_{c_name}",
                    )
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_suffix_extension",
                            data=ext_data,
                            tags=["substring_attack"],
                            description=(
                                f"Targets SUBSTRING length and omission bugs on `{t_name}.{c_name}`. "
                                f"Injects `{satisfying_extended}` containing trailing characters beyond the "
                                f"constrained substring slice so `SUBSTRING` predicates succeed while full-column "
                                f"equality or over-length `SUBSTRING` mutants fail."
                            ),
                        )
                    )

            # Baseline dataset for merged positive + boundary-violating rows
            base_data = generate_base_dataset(
                schema,
                parsed_query,
                value_injections={(t_name, c_name): satisfying_extended},
                cache_key_salt=f"substr_base_{t_name}_{c_name}",
            )

            # Generate slice-specific boundary mutations
            for lit_idx, lit in enumerate(col_lits):
                if lit.get("operator", "EQ").upper() not in ("EQ", "IN"):
                    continue
                start_pos = int(lit["substr_start"])
                sub_len = lit.get("substr_length")
                s_val = str(lit["value"])
                if sub_len is not None and int(sub_len) >= 0:
                    s_val = s_val[: int(sub_len)]
                if not s_val:
                    continue

                candidates: List[Tuple[str, str, str]] = []

                # (a) Delimiter / non-alphanumeric interior character mutation
                delim_positions = [k for k, ch in enumerate(s_val) if not ch.isalnum()]
                if delim_positions:
                    delim_cmap = dict(base_cmap)
                    for k in delim_positions:
                        pos = (start_pos - 1) + k
                        delim_cmap[pos] = _distinct_char(s_val[k])
                    delim_str = self._render_char_map(delim_cmap, filler="_", suffix="Z", char_limit=char_limit)
                    candidates.append(
                        (
                            f"delimiter_mutation_{lit_idx}",
                            delim_str,
                            f"Targets SUBSTRING delimiter decomposition bugs on `{t_name}.{c_name}` by replacing "
                            f"delimiter characters in `{s_val}` to produce `{delim_str}`.",
                        )
                    )

                # (b) Last-character boundary mutation of the slice
                last_cmap = dict(base_cmap)
                last_pos = (start_pos - 1) + len(s_val) - 1
                last_cmap[last_pos] = _distinct_char(s_val[-1])
                last_str = self._render_char_map(last_cmap, filler="_", suffix="Z", char_limit=char_limit)
                candidates.append(
                    (
                        f"boundary_last_char_{lit_idx}",
                        last_str,
                        f"Targets SUBSTRING length/prefix truncation bugs on `{t_name}.{c_name}` by mutating "
                        f"the final character of slice `{s_val}` to produce `{last_str}`.",
                    )
                )

                # (c) First-character boundary mutation of the slice (if length > 1)
                if len(s_val) > 1:
                    first_cmap = dict(base_cmap)
                    first_pos = start_pos - 1
                    first_cmap[first_pos] = _distinct_char(s_val[0])
                    first_str = self._render_char_map(first_cmap, filler="_", suffix="Z", char_limit=char_limit)
                    candidates.append(
                        (
                            f"boundary_first_char_{lit_idx}",
                            first_str,
                            f"Targets SUBSTRING start-offset/suffix bugs on `{t_name}.{c_name}` by mutating "
                            f"the first character of slice `{s_val}` to produce `{first_str}`.",
                        )
                    )

                # (d) Shifted start-offset (+1 position)
                shifted_cmap = {pos + 1: ch for pos, ch in base_cmap.items()}
                shifted_cmap[0] = _distinct_char(s_val[0])
                shifted_str = self._render_char_map(shifted_cmap, filler="_", suffix="", char_limit=char_limit)
                candidates.append(
                    (
                        f"shifted_start_{lit_idx}",
                        shifted_str,
                        f"Targets SUBSTRING start-offset shift bugs on `{t_name}.{c_name}` by shifting "
                        f"the slice by +1 character position (`{shifted_str}`).",
                    )
                )

                for label, cand_val, desc in candidates:
                    if cand_val in (satisfying_extended, satisfying_exact):
                        continue
                    m_key = (t_name, c_name, cand_val)
                    if m_key in seen_Merged:
                        continue
                    seen_Merged.add(m_key)

                    viol_data = generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={(t_name, c_name): cand_val},
                        cache_key_salt=f"substr_{label}_{t_name}_{c_name}",
                    )
                    merged_data = {tbl: [] for tbl in schema.tables}
                    for tbl in merged_data:
                        if tbl in base_data:
                            merged_data[tbl].extend(copy.deepcopy(base_data[tbl]))
                        if tbl in viol_data:
                            merged_data[tbl].extend(copy.deepcopy(viol_data[tbl]))
                    merged_data = deduplicate_mock_data(schema, merged_data)

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{c_name}_{label}",
                            data=merged_data,
                            tags=["substring_attack"],
                            description=desc,
                        )
                    )

        datasets.extend(self._generate_delimiter_datasets(schema, parsed_query))
        return datasets
