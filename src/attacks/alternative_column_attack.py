"""
AlternativeColumnAttackStrategy Module

Target semantic bugs: Alternative/Spurious Column Predicates.
Bugs where a mutant query checks alternative or additional columns in a table
using literal values from the reference query (e.g., checking `alt_col = 'val'` or `col2 = 'val'`
in addition to or instead of `col1 = 'val'`).

Algorithm & Dataset Design:
1. Extract literal predicates (table, column, value) from the WHERE clause of the parsed query.
2. For each table referenced in the predicates:
   - Identify candidate alternative columns in the table that have compatible types but are not part of the predicate.
   - Generate datasets that assign the reference predicate's literal value(s) to candidate alternative column(s),
     while assigning violating (distinct) value(s) to the original predicate column(s).
3. The reference query rejects the row because the original predicate fails (0 rows returned).
   A mutant query that improperly checks alternative columns with those literal values admits the row (>=1 rows returned).
"""

from typing import Any, Dict, List, Optional, Set

import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import (
    generate_base_dataset,
    next_distinct_value,
    resolve_query_column,
    deduplicate_mock_data,
)
from dataset_generator.constraints import _coerce_temporal
from dataset_generator.value_generator import synthesize_string_of_length


class AlternativeColumnAttackStrategy(AttackStrategy):
    """
    Targets semantic bugs where alternative/additional columns in a table
    are queried using literal values from the reference query.
    """

    def _is_valid_literal(self, lit: dict[str, Any]) -> bool:
        val = lit.get("value")
        op = str(lit.get("operator", "")).upper()
        if val is None or val == "NULL" or op.startswith("IS"):
            return False
        return True

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        where_lits = parsed_query.get("where_literals", [])
        return any(self._is_valid_literal(l) for l in where_lits)

    def _is_numeric(self, value: Any) -> bool:
        return isinstance(value, (int, float)) or (
            isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit()
        )

    def _satisfying_value(
        self,
        literal: dict[str, Any],
        col_literals: Optional[List[dict[str, Any]]] = None,
    ) -> Any:
        value = literal["value"]
        operator = str(literal.get("operator", "EQ")).upper()

        if literal.get("is_length_expr") and self._is_numeric(value):
            num = int(float(value))
            offset = int(literal.get("length_offset") or 0)
            if operator in ("GT", "NEQ"):
                expr_len = max(0, num + 1)
            elif operator == "LT":
                expr_len = max(0, num - 1)
            else:
                expr_len = max(0, num)
            col_len = 0 if (expr_len == 0 and offset == 0) else max(0, expr_len + offset)
            return synthesize_string_of_length(None, col_len)

        if literal.get("substr_start") is not None and int(literal["substr_start"]) >= 1:
            substr_lits = [
                l for l in (col_literals or [literal])
                if l.get("substr_start") is not None
                and int(l["substr_start"]) >= 1
                and str(l.get("operator", "EQ")).upper() in ("EQ", "IN")
                and l.get("value") != "NULL"
            ]
            if not substr_lits:
                substr_lits = [literal]
            cmap: Dict[int, str] = {}
            for slit in substr_lits:
                st_pos = int(slit["substr_start"])
                sub_len = slit.get("substr_length")
                s_val = str(slit["value"])
                if sub_len is not None and int(sub_len) >= 0:
                    s_val = s_val[: int(sub_len)]
                for k, ch in enumerate(s_val):
                    pos = (st_pos - 1) + k
                    if pos not in cmap:
                        cmap[pos] = ch
            if not cmap:
                return ""
            max_idx = max(cmap.keys())
            return "".join(cmap.get(i, "_") for i in range(max_idx + 1))

        res: Any = value
        if self._is_numeric(value):
            num_f = float(value)
            number: int | float = int(num_f) if num_f.is_integer() else num_f
            if operator == "GT":
                res = number + 1
            elif operator == "LT":
                res = number - 1
            elif operator == "NEQ":
                res = number + 1
            else:
                res = number

        if literal.get("is_temporal_expr") or literal.get("strftime_format"):
            return _coerce_temporal(res, "EQ", literal.get("strftime_format"))
        return res

    def _violating_value(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        literal: dict[str, Any],
    ) -> Any:
        value = literal["value"]
        if literal.get("is_length_expr") and self._is_numeric(value):
            operator = str(literal.get("operator", "EQ")).upper()
            num = int(float(value))
            offset = int(literal.get("length_offset") or 0)
            if operator in ("GT", "LT", "NEQ"):
                expr_len = max(0, num)
            elif operator in ("GTE", "BETWEENLOWER"):
                expr_len = max(0, num - 1)
            else:
                expr_len = max(0, num + 1)
            col_len = offset if (expr_len == 0 and offset > 0) else max(0, expr_len + offset)
            resolved = resolve_query_column(
                schema, parsed_query, literal.get("table", ""), literal["column"]
            )
            col_obj = schema.find_column(resolved[0], resolved[1]) if resolved else None
            return synthesize_string_of_length(col_obj, col_len)

        if literal.get("substr_start") is not None and int(literal["substr_start"]) >= 1:
            st_pos = int(literal["substr_start"])
            sub_len = literal.get("substr_length")
            orig_str = str(value)
            target_len = int(sub_len) if (sub_len is not None and int(sub_len) > 0) else max(1, len(orig_str))
            if self._is_numeric(orig_str):
                cand_int = int(float(orig_str)) + 1
                viol_slice = str(cand_int).zfill(target_len)[-target_len:]
                if viol_slice == orig_str[:target_len]:
                    alt_ch = "9" if orig_str[:1] != "9" else "8"
                    viol_slice = alt_ch + viol_slice[1:]
            else:
                alt_ch = "Z" if orig_str[:1].upper() != "Z" else "Y"
                viol_slice = (alt_ch + orig_str[1:] + ("X" * target_len))[:target_len]
            return ("_" * (st_pos - 1)) + viol_slice

        resolved = resolve_query_column(
            schema, parsed_query, literal.get("table", ""), literal["column"]
        )
        if resolved is None:
            if isinstance(value, str):
                return value[::-1] if len(value) > 1 else value + "x"
            return value + 1 if isinstance(value, (int, float)) else value
        table_name, column_name = resolved
        column = next(
            (col for col in schema.tables[table_name].columns if col.name == column_name),
            None,
        )
        if column is None:
            return value + "_mismatch" if isinstance(value, str) else value + 1
        return next_distinct_value(column, value, schema=schema, table_name=table_name)

    def _is_key_or_fk_column(self, schema: Schema, table_name: str, col_name: str) -> bool:
        col = schema.find_column(table_name, col_name)
        if col is None:
            return False
        if getattr(col, "is_primary_key", False) or getattr(col, "is_unique", False):
            return True
        table_schema = schema.tables.get(table_name)
        if table_schema:
            for fk in table_schema.foreign_keys:
                if fk.column_name.upper() == col_name.upper():
                    return True
        for other_t in schema.tables.values():
            for fk in other_t.foreign_keys:
                if fk.reference_table.upper() == table_name.upper() and fk.reference_column.upper() == col_name.upper():
                    return True
        return False

    def _is_candidate_alt_column(
        self, schema: Schema, table_name: str, orig_col_names: List[str], col_name: str
    ) -> bool:
        col = schema.find_column(table_name, col_name)
        if col is None:
            return False
        if not self._is_key_or_fk_column(schema, table_name, col_name):
            return True
        if any(
            self._is_key_or_fk_column(schema, table_name, oc)
            for oc in orig_col_names
        ):
            return True
        return False

    def _find_alternative_column_groups(
        self, schema: Schema, table_name: str, orig_col_names: List[str]
    ) -> List[List[str]]:
        table_schema = schema.tables.get(table_name)
        if not table_schema:
            return []

        groups = []
        seen = set()

        # Pattern 1: Digit substitution (e.g. '1' -> '2', '3', etc.)
        for digit in "0123456789":
            if all(digit in col for col in orig_col_names):
                for replacement in "0123456789":
                    if replacement == digit:
                        continue
                    candidate_group = [col.replace(digit, replacement) for col in orig_col_names]
                    if all(
                        self._is_candidate_alt_column(schema, table_name, [orig_col], c)
                        for orig_col, c in zip(orig_col_names, candidate_group)
                    ):
                        group_tuple = tuple(candidate_group)
                        if group_tuple not in seen and set(candidate_group).isdisjoint(set(orig_col_names)):
                            seen.add(group_tuple)
                            groups.append(candidate_group)

        # Pattern 2: Common prefixes/suffixes
        affixes = [
            ("alt_", ""), ("secondary_", ""), ("other_", ""),
            ("", "_alt"), ("", "_2"), ("", "_3"), ("", "_other"),
        ]
        for pfx, sfx in affixes:
            candidate_group = [f"{pfx}{col}{sfx}" for col in orig_col_names]
            if all(
                self._is_candidate_alt_column(schema, table_name, [orig_col], c)
                for orig_col, c in zip(orig_col_names, candidate_group)
            ):
                group_tuple = tuple(candidate_group)
                if group_tuple not in seen and set(candidate_group).isdisjoint(set(orig_col_names)):
                    seen.add(group_tuple)
                    groups.append(candidate_group)

        # Pattern 3: Sub-string matching (excluding short substrings <= 2 chars)
        fuzzy_group = []
        for orig_col in orig_col_names:
            match = None
            for col in table_schema.columns:
                if col.name in orig_col_names or not self._is_candidate_alt_column(
                    schema, table_name, [orig_col], col.name
                ):
                    continue
                orig_l = orig_col.lower()
                col_l = col.name.lower()
                if len(col_l) > 2 and len(orig_l) > 2 and (orig_l in col_l or col_l in orig_l):
                    match = col.name
                    break
            if match:
                fuzzy_group.append(match)
        if len(fuzzy_group) == len(orig_col_names):
            group_tuple = tuple(fuzzy_group)
            if group_tuple not in seen and set(fuzzy_group).isdisjoint(set(orig_col_names)):
                seen.add(group_tuple)
                groups.append(fuzzy_group)

        return groups

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        where_literals = parsed_query.get("where_literals", [])
        valid_literals = [lit for lit in where_literals if self._is_valid_literal(lit)]
        if not valid_literals:
            return datasets

        # Group literals by resolved table name (deduplicating identical predicates)
        table_literals: Dict[str, List[dict[str, Any]]] = {}
        seen_lit_keys = set()
        for lit in valid_literals:
            res = resolve_query_column(
                schema, parsed_query, lit.get("table", ""), lit["column"]
            )
            if res:
                t_name, col_name = res
                lit_key = (t_name, col_name, lit["value"])
                if lit_key in seen_lit_keys:
                    continue
                seen_lit_keys.add(lit_key)
                if t_name not in table_literals:
                    table_literals[t_name] = []
                table_literals[t_name].append({
                    "column": col_name,
                    "value": lit["value"],
                    "orig_literal": lit,
                })

        dataset_idx = 0
        for t_name, lits in table_literals.items():
            if t_name not in schema.tables:
                continue

            table_schema = schema.tables[t_name]
            orig_col_names = [l["column"] for l in lits]

            # High-confidence matched column groups
            matched_groups = self._find_alternative_column_groups(schema, t_name, orig_col_names)

            for group in matched_groups:
                val_inj = {}
                # Set original predicate columns to violating values
                for lit in lits:
                    orig_col = lit["column"]
                    violating_val = self._violating_value(schema, parsed_query, lit["orig_literal"])
                    val_inj[(t_name, orig_col)] = violating_val

                # Set matched alternative columns to satisfying query literal values
                for idx, lit in enumerate(lits):
                    alt_col_name = group[idx]
                    same_col_lits = [l["orig_literal"] for l in lits if l["column"] == lit["column"]]
                    val_inj[(t_name, alt_col_name)] = self._satisfying_value(
                        lit["orig_literal"], same_col_lits
                    )

                mock_data = generate_base_dataset(
                    schema, parsed_query, value_injections=val_inj, cache_key_salt=f"alt_group_{dataset_idx}"
                )
                mock_data = deduplicate_mock_data(schema, mock_data)

                group_str = ", ".join(group)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_{t_name}_group_{'_'.join(group)}_{dataset_idx}",
                        data=mock_data,
                        tags=["alternative_column_attack"],
                        description=(
                            f"Targets Alternative Column Group bugs. Assigns query literal values "
                            f"to alternative column group `{group_str}` in `{t_name}` while setting original "
                            "predicate columns to non-matching values. Mutants checking alternative column groups will admit this row."
                        ),
                    )
                )
                dataset_idx += 1

            # Fallback Strategy: Single column mappings for any non-predicate column
            alt_columns = [
                col for col in table_schema.columns
                if col.name not in set(orig_col_names)
                and self._is_candidate_alt_column(schema, t_name, orig_col_names, col.name)
            ]

            ast = parsed_query.get("ast")
            query_ref_cols: Set[str] = {
                (c.name or "").upper()
                for c in (ast.find_all(exp.Column) if ast else [])
                if c.name
            }
            fk_cols_upper: Set[str] = {fk.column_name.upper() for fk in table_schema.foreign_keys}
            for other_t in schema.tables.values():
                for fk in other_t.foreign_keys:
                    if fk.reference_table.upper() == t_name.upper():
                        fk_cols_upper.add(fk.reference_column.upper())
            check_cols_upper: Set[str] = {
                (c.name or "").upper()
                for cc in getattr(table_schema, "check_constraints", [])
                if cc.get("expression")
                for c in cc["expression"].find_all(exp.Column)
                if c.name
            }

            seen_col_alt = set()
            for lit in lits:
                orig_col = lit["column"]
                same_col_lits = [l["orig_literal"] for l in lits if l["column"] == orig_col]
                lit_val = self._satisfying_value(lit["orig_literal"], same_col_lits)
                orig_col_obj = schema.find_column(t_name, orig_col)
                orig_dt = orig_col_obj.data_type.upper() if orig_col_obj else ""
                orig_is_str = any(k in orig_dt for k in ("CHAR", "TEXT", "VARCHAR", "STRING", "DATE", "TIME"))
                is_num = (
                    self._is_numeric(lit_val)
                    and not orig_is_str
                    and lit["orig_literal"].get("substr_start") is None
                    and not lit["orig_literal"].get("is_length_expr")
                )

                compatible_alt_cols = []
                for alt_col in alt_columns:
                    if (orig_col, alt_col.name) in seen_col_alt:
                        continue
                    if not self._is_candidate_alt_column(schema, t_name, [orig_col], alt_col.name):
                        continue
                    alt_dt = alt_col.data_type.upper()
                    alt_is_num = any(k in alt_dt for k in ("INT", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL"))
                    alt_is_int_only = "INT" in alt_dt and not any(
                        k in alt_dt for k in ("REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL")
                    )
                    if alt_is_int_only and isinstance(lit_val, float) and not lit_val.is_integer():
                        continue
                    alt_is_str = any(k in alt_dt for k in ("CHAR", "TEXT", "VARCHAR", "STRING"))
                    if is_num and not alt_is_num:
                        continue
                    if not is_num and not alt_is_str:
                        continue
                    seen_col_alt.add((orig_col, alt_col.name))
                    compatible_alt_cols.append(alt_col)

                violating_val = self._violating_value(schema, parsed_query, lit["orig_literal"])

                if len(compatible_alt_cols) <= 8:
                    individual_alt_cols = compatible_alt_cols
                    batched_alt_cols = []
                else:
                    individual_alt_cols = []
                    batched_alt_cols = []
                    for alt_col in compatible_alt_cols:
                        col_up = alt_col.name.upper()
                        if (
                            alt_col.is_primary_key
                            or alt_col.is_unique
                            or col_up in query_ref_cols
                            or col_up in fk_cols_upper
                            or col_up in check_cols_upper
                        ):
                            individual_alt_cols.append(alt_col)
                        else:
                            batched_alt_cols.append(alt_col)

                for alt_col in individual_alt_cols:
                    val_inj = {
                        (t_name, orig_col): violating_val,
                        (t_name, alt_col.name): lit_val,
                    }

                    mock_data = generate_base_dataset(
                        schema, parsed_query, value_injections=val_inj, cache_key_salt=f"alt_col_{dataset_idx}"
                    )
                    mock_data = deduplicate_mock_data(schema, mock_data)

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{t_name}_{orig_col}_to_{alt_col.name}_{dataset_idx}",
                            data=mock_data,
                            tags=["alternative_column_attack"],
                            description=(
                                f"Targets Alternative Column bugs. Assigns query literal `{lit_val}` "
                                f"to alternative column `{t_name}.{alt_col.name}` while setting original "
                                f"predicate column `{t_name}.{orig_col}` to a non-matching value. "
                                "Mutants that incorrectly check alternative columns will admit this row."
                            ),
                        )
                    )
                    dataset_idx += 1

                if batched_alt_cols:
                    val_inj = {(t_name, orig_col): violating_val}
                    for alt_col in batched_alt_cols:
                        val_inj[(t_name, alt_col.name)] = lit_val

                    mock_data = generate_base_dataset(
                        schema, parsed_query, value_injections=val_inj, cache_key_salt=f"alt_col_batch_{dataset_idx}"
                    )
                    mock_data = deduplicate_mock_data(schema, mock_data)

                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_{t_name}_{orig_col}_to_batch_{dataset_idx}",
                            data=mock_data,
                            tags=["alternative_column_attack"],
                            description=(
                                f"Targets Alternative Column bugs. Assigns query literal `{lit_val}` "
                                f"to unreferenced compatible alternative columns in `{t_name}` while setting original "
                                f"predicate column `{t_name}.{orig_col}` to a non-matching value. "
                                "Mutants that incorrectly check alternative columns will admit this row."
                            ),
                        )
                    )
                    dataset_idx += 1

        return datasets
