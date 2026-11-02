"""
MissingPredicateAttackStrategy Module

Target semantic bug: Missing Predicate (a WHERE, HAVING, or JOIN ON filter predicate from the correct query is removed or partially omitted).
Algorithm & Dataset Design:
1. Literal predicates (`Column OP Literal`):
   For each literal predicate parsed from the query, builds a row that satisfies all other parsed predicates
   and violates only the target predicate.
2. Column-to-column inequality and range predicates (`Column OP Column`, `Column BETWEEN Column AND Column`):
   For each column-to-column comparison or range bound in WHERE, HAVING, or JOIN ON:
   - Clones the satisfying row of the target table (preserving its equi-join, foreign-key, and GROUP BY
     attributes when non-unique so the violating row belongs to the same active group/entity) and sets
     the target column to a value strictly violating the comparison bound relative to the reference column.
   - When non-unique join/group keys are preserved, also injects an isolated group with distinct join keys
     in which the target alias row violates the comparison bound while its partner row(s) remain valid, so
     queries projecting `DISTINCT` join keys or semi-joins (`IN` / `EXISTS`) cannot mask the violation behind
     the base group's satisfying tuple.
"""

from typing import Any, Dict, List, Optional, Tuple
import copy

import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, merge_datasets, next_distinct_value, resolve_query_column, deduplicate_mock_data
from dataset_generator.constraints import _coerce_temporal
from dataset_generator.value_generator import (
    generate_unique_value_for_column,
    synthesize_string_of_length,
)
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.resolver import _is_temporal_context, _step_above, _step_below
from dataset_generator.utils import (
    compute_temporal_diff_values,
    extract_temporal_diff_patterns,
    is_unique_column_set,
    safe_max,
    safe_min,
)


class MissingPredicateAttackStrategy(AttackStrategy):
    """
    Target semantic bug: a WHERE, HAVING, or JOIN ON predicate from the query is removed or partially omitted.

    Algorithm & Dataset Design:
    For each literal or column-to-column predicate parsed from the query, this strategy builds
    a dataset containing a row that satisfies every predicate and an additional row that violates
    the target predicate (preserving equi-join/FK/group keys on many-side tables so partial-filter
    subqueries and grouped aggregations diverge on the active group).
    """

    def _extract_column_predicates(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Tuple[str, str, str, str, str]]:
        ast = parsed_query.get("ast")
        if not ast:
            return []

        def _resolve_scoped_col(col_node: exp.Column) -> Optional[Tuple[str, str]]:
            if col_node.table:
                return resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            enc_sel = col_node.find_ancestor(exp.Select)
            if enc_sel:
                for t_node in enc_sel.find_all(exp.Table):
                    if t_node.find_ancestor(exp.Select) is enc_sel:
                        st = schema.find_table(t_node.name)
                        if st:
                            c_obj = schema.find_column(st, col_node.name)
                            if c_obj:
                                return st, c_obj.name
            return resolve_query_column(schema, parsed_query, "", col_node.name)

        clauses = list(ast.find_all((exp.Where, exp.Having)))
        for j in ast.find_all(exp.Join):
            if j.args.get("on"):
                clauses.append(j.args["on"])

        inv_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "NEQ": "NEQ"}
        preds: List[Tuple[str, str, str, str, str]] = []
        seen = set()

        for clause in clauses:
            for comp in clause.find_all((exp.Between, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ)):
                curr = comp
                not_count = 0
                in_negated_subq = False
                while curr.parent:
                    if isinstance(curr.parent, exp.Not):
                        not_count += 1
                    if isinstance(curr.parent, (exp.Exists, exp.In)) and curr.parent.parent and isinstance(curr.parent.parent, exp.Not):
                        in_negated_subq = True
                        break
                    curr = curr.parent
                if in_negated_subq or (not_count % 2 == 1) or comp.find_ancestor(exp.Case) is not None:
                    continue

                if isinstance(comp, exp.Between):
                    c_node = comp.this
                    while isinstance(c_node, (exp.Cast, exp.TryCast, exp.Paren)):
                        c_node = c_node.this
                    low_node = comp.args.get("low")
                    high_node = comp.args.get("high")
                    if isinstance(c_node, exp.Column):
                        res_c = _resolve_scoped_col(c_node)
                        if res_c:
                            if isinstance(low_node, exp.Column):
                                res_low = _resolve_scoped_col(low_node)
                                if res_low:
                                    item = (res_c[0], res_c[1], "GTE", res_low[0], res_low[1])
                                    if item not in seen:
                                        seen.add(item)
                                        preds.append(item)
                            if isinstance(high_node, exp.Column):
                                res_high = _resolve_scoped_col(high_node)
                                if res_high:
                                    item = (res_c[0], res_c[1], "LTE", res_high[0], res_high[1])
                                    if item not in seen:
                                        seen.add(item)
                                        preds.append(item)
                elif isinstance(comp.left, exp.Column) and isinstance(comp.right, exp.Column):
                    res_l = _resolve_scoped_col(comp.left)
                    res_r = _resolve_scoped_col(comp.right)
                    if res_l and res_r:
                        op_name = comp.__class__.__name__.upper()
                        inv_op = inv_map.get(op_name, op_name)
                        for item in (
                            (res_l[0], res_l[1], op_name, res_r[0], res_r[1]),
                            (res_r[0], res_r[1], inv_op, res_l[0], res_l[1]),
                        ):
                            if item not in seen:
                                seen.add(item)
                                preds.append(item)

        return preds

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(
            parsed_query.get("where_literals")
            or self._extract_column_predicates(schema, parsed_query)
            or any(
                p.get("from_comparison", True)
                for p in extract_temporal_diff_patterns(schema, parsed_query)
            )
        )

    def _is_numeric(self, value: Any) -> bool:
        return isinstance(value, (int, float)) or (
            isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit()
        )

    def _coerce_number(self, value: Any):
        if isinstance(value, (int, float)):
            return value
        number = float(value)
        return int(number) if number.is_integer() else number

    def _satisfying_value(self, literal: dict[str, Any]) -> Any:
        value = literal["value"]
        operator = literal.get("operator", "EQ")

        if literal.get("is_length_expr") and self._is_numeric(value):
            num = int(float(value))
            offset = int(literal.get("length_offset") or 0)
            if operator in ("GT", "NEQ"):
                expr_len = max(0, num + 1)
            elif operator in ("LT",):
                expr_len = max(0, num - 1)
            else:
                expr_len = max(0, num)
            col_len = 0 if (expr_len == 0 and offset == 0) else max(0, expr_len + offset)
            return synthesize_string_of_length(None, col_len)

        if self._is_numeric(value):
            number = self._coerce_number(value)
            res = value
            if operator in ("GT",):
                res = number + 1
            elif operator in ("GTE", "EQ", "BetweenLower", "BetweenUpper", "In"):
                res = number
            elif operator in ("LT",):
                res = number - 1
            elif operator in ("LTE",):
                res = number
            elif operator in ("NEQ",):
                res = number + 1
            if literal.get("is_temporal_expr") or literal.get("strftime_format"):
                return _coerce_temporal(res, "EQ", literal.get("strftime_format"))
            return res
        if operator in ("GT", "NEQ"):
            if _is_temporal_context(value, "", None, bool(literal.get("is_temporal_expr"))):
                return _step_above(value, "", None, is_temporal=True)
            return str(value) + "_z"
        if operator in ("LT",):
            if _is_temporal_context(value, "", None, bool(literal.get("is_temporal_expr"))):
                return _step_below(value, "", None, is_temporal=True)
            str_val = str(value)
            return (
                str_val[: max(1, len(str_val) - 1)]
                if len(str_val) > 1
                else (chr(max(32, ord(str_val[0]) - 1)) if str_val else "")
            )
        return value

    def _distinct_literal_value(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        literal: dict[str, Any],
    ) -> Any:
        resolved = resolve_query_column(
            schema, parsed_query, literal.get("table", ""), literal["column"]
        )
        if resolved is None:
            v = literal["value"]
            if isinstance(v, str):
                return v[::-1] if len(v) > 1 else v + "x"
            return v + 1 if isinstance(v, (int, float)) else v
        table_name, column_name = resolved
        column = next(
            col for col in schema.tables[table_name].columns if col.name == column_name
        )
        return next_distinct_value(column, literal["value"])

    def _violating_value(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        literal: dict[str, Any],
    ) -> Any:
        value = literal["value"]
        operator = literal.get("operator", "EQ")
        op_upper = operator.upper()

        if value == "NULL":
            resolved = resolve_query_column(
                schema, parsed_query, literal.get("table", ""), literal["column"]
            )
            if op_upper in ("IS", "IS NULL", "EQ"):
                if resolved is not None:
                    table_name, column_name = resolved
                    column = schema.find_column(table_name, column_name)
                    if column is not None:
                        cand = generate_unique_value_for_column(column)
                        return solve_check_constraint_value(schema, table_name, column_name, column, cand)
                return 1
            else:
                return None

        if literal.get("is_length_expr") and self._is_numeric(value):
            num = int(float(value))
            offset = int(literal.get("length_offset") or 0)
            if operator in ("GT", "LT", "NEQ"):
                expr_len = num
            elif operator in ("GTE", "BetweenLower"):
                expr_len = num - 1
            elif operator in ("LTE", "BetweenUpper", "EQ", "In"):
                expr_len = num + 1
            else:
                expr_len = num
            if expr_len < 0:
                return None
            col_len = offset if (expr_len == 0 and offset > 0) else max(0, expr_len + offset)
            resolved = resolve_query_column(
                schema, parsed_query, literal.get("table", ""), literal["column"]
            )
            col_obj = schema.find_column(resolved[0], resolved[1]) if resolved else None
            return synthesize_string_of_length(col_obj, col_len)

        if self._is_numeric(value):
            number = self._coerce_number(value)
            res = value
            if operator in ("GT",):
                res = number
            elif operator in ("GTE", "BetweenLower"):
                res = number - 1
            elif operator in ("LT",):
                res = number
            elif operator in ("LTE", "BetweenUpper"):
                res = number + 1
            elif operator in ("EQ", "In"):
                res = number + 1
            elif operator in ("NEQ",):
                res = number
            if literal.get("is_temporal_expr") or literal.get("strftime_format"):
                return _coerce_temporal(res, "EQ", literal.get("strftime_format"))
            return res
        if operator in ("EQ", "In"):
            return self._distinct_literal_value(schema, parsed_query, literal)
        if operator in ("NEQ", "GT", "LT"):
            return value
        resolved = resolve_query_column(
            schema, parsed_query, literal.get("table", ""), literal["column"]
        )
        column = schema.find_column(resolved[0], resolved[1]) if resolved else None
        data_type = column.data_type if column else ""
        if operator in ("GTE", "BetweenLower"):
            if _is_temporal_context(value, data_type, column, bool(literal.get("is_temporal_expr"))):
                return _step_below(value, data_type, column, is_temporal=True)
            str_val = str(value)
            return (
                str_val[: max(1, len(str_val) - 1)]
                if len(str_val) > 1
                else (chr(max(32, ord(str_val[0]) - 1)) if str_val else "")
            )
        if operator in ("LTE", "BetweenUpper"):
            if _is_temporal_context(value, data_type, column, bool(literal.get("is_temporal_expr"))):
                return _step_above(value, data_type, column, is_temporal=True)
            return str(value) + "_z"
        return value

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        where_literals = parsed_query.get("where_literals", [])
        col_predicates = self._extract_column_predicates(schema, parsed_query)
        temporal_diff_preds = [
            p
            for p in extract_temporal_diff_patterns(schema, parsed_query)
            if p.get("from_comparison", True)
        ]
        if not where_literals and not col_predicates and not temporal_diff_preds:
            return []

        base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="missing_pred_base")
        seen_targets = set()

        for target_index, target_literal in enumerate(where_literals):
            t_key = (target_literal.get("table", ""), target_literal.get("column", ""), target_literal.get("operator", "EQ"), str(target_literal.get("value", "")))
            if t_key in seen_targets:
                continue
            seen_targets.add(t_key)

            violating_val = self._violating_value(
                schema, parsed_query, target_literal
            )
            if target_literal.get("substr_start") is not None and violating_val is not None:
                orig_str = str(target_literal.get("value", ""))
                viol_str = str(violating_val)
                sub_len = target_literal.get("substr_length")
                target_len = int(sub_len) if sub_len is not None and int(sub_len) > 0 else max(1, len(orig_str))
                if len(viol_str) < target_len:
                    viol_str = (viol_str + ("x" * target_len))[:target_len]
                else:
                    viol_str = viol_str[:target_len]
                if viol_str == orig_str[:target_len]:
                    alt_ch = "9" if orig_str[:1] != "9" else "8"
                    viol_str = alt_ch + viol_str[1:]
                violating_val = viol_str

            modified_query = copy.deepcopy(parsed_query)
            target_col_info = resolve_query_column(
                schema, parsed_query, target_literal.get("table", ""), target_literal["column"]
            )
            value_injections = {}
            if target_col_info and (target_literal.get("substr_start") is None or violating_val is None):
                other_eq_vals = []
                other_avoid_vals = set()
                if parsed_query.get("group_by") or parsed_query.get("has_group_by"):
                    for other_idx, other_lit in enumerate(where_literals):
                        if other_idx == target_index or other_lit.get("value") == "NULL":
                            continue
                        other_col_info = resolve_query_column(
                            schema, parsed_query, other_lit.get("table", ""), other_lit["column"]
                        )
                        if other_col_info == target_col_info:
                            other_op = other_lit.get("operator", "EQ").upper()
                            other_sat = self._satisfying_value(other_lit)
                            other_avoid_vals.add(other_lit.get("value"))
                            if other_op in ("EQ", "IN") and other_sat not in other_eq_vals:
                                other_eq_vals.append(other_sat)
                if (
                    violating_val is not None
                    and target_literal.get("operator", "EQ").upper() in ("EQ", "IN")
                    and other_avoid_vals
                    and violating_val in other_avoid_vals
                ):
                    col_obj = schema.find_column(target_col_info[0], target_col_info[1])
                    if col_obj:
                        attempts = 0
                        while violating_val in other_avoid_vals and attempts < 20:
                            attempts += 1
                            violating_val = next_distinct_value(col_obj, violating_val)
                if other_eq_vals:
                    value_injections[target_col_info] = other_eq_vals + [violating_val]
                else:
                    value_injections[target_col_info] = violating_val

            for literal_index, literal in enumerate(modified_query.get("where_literals", [])):
                literal.pop("is_length_expr", None)
                literal.pop("length_offset", None)
                if literal_index == target_index:
                    if violating_val is None:
                        literal["value"] = "NULL"
                        literal["operator"] = "Is"
                    else:
                        literal["value"] = violating_val
                        literal["operator"] = "EQ"
                else:
                    if literal.get("value") != "NULL":
                        literal["value"] = self._satisfying_value(where_literals[literal_index])

            violating_data = generate_base_dataset(
                schema, modified_query, value_injections=value_injections, cache_key_salt=f"violating_{target_index}"
            )
            
            merged_data = {t_name: [] for t_name in schema.tables}
            for t_name in merged_data:
                if t_name in base_data:
                    merged_data[t_name].extend(copy.deepcopy(base_data[t_name]))
                if t_name in violating_data:
                    merged_data[t_name].extend(copy.deepcopy(violating_data[t_name]))

            merged_data = deduplicate_mock_data(schema, merged_data)

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{target_literal.get('column', 'col')}_{target_index}",
                    data=merged_data,
                    tags=["missing_predicate_attack"],
                    description=f"Targets Missing Predicate bugs. Dataset includes a row satisfying all predicates, plus a row violating exactly predicate {target_index + 1} on `{target_literal.get('column', 'col')}`. A mutant missing this predicate will return the violating row."
                )
            )

        if col_predicates:
            preserved_by_table: Dict[str, set] = {t: set() for t in schema.tables}
            for t_name, tbl_obj in schema.tables.items():
                for fk in tbl_obj.foreign_keys:
                    preserved_by_table[t_name].add(fk.column_name.upper())
            for j in parsed_query.get("joins", []):
                for pair in j.get("on_pairs", []):
                    for side in ("left", "right"):
                        res = resolve_query_column(schema, parsed_query, pair[side].get("table", ""), pair[side].get("column", ""))
                        if res and res[0] in preserved_by_table:
                            preserved_by_table[res[0]].add(res[1].upper())
            for pair in parsed_query.get("where_joins", []):
                for side in ("left", "right"):
                    res = resolve_query_column(schema, parsed_query, pair[side].get("table", ""), pair[side].get("column", ""))
                    if res and res[0] in preserved_by_table:
                        preserved_by_table[res[0]].add(res[1].upper())
            for gb in parsed_query.get("group_by", []):
                res = resolve_query_column(schema, parsed_query, gb.get("table", ""), gb.get("column", ""))
                if res and res[0] in preserved_by_table:
                    preserved_by_table[res[0]].add(res[1].upper())

            for pred_idx, (target_tbl, target_col, op_name, ref_tbl, ref_col) in enumerate(col_predicates):
                if not base_data.get(target_tbl) or not base_data.get(ref_tbl):
                    continue
                target_col_obj = schema.find_column(target_tbl, target_col)
                target_table_obj = schema.tables.get(target_tbl)
                if not target_col_obj or not target_table_obj:
                    continue

                ref_vals = [r.get(ref_col) for r in base_data[ref_tbl] if r.get(ref_col) is not None]
                if not ref_vals:
                    continue

                if op_name in ("GTE", "GT"):
                    bound_val = ref_vals[0]
                    for rv in ref_vals[1:]:
                        bound_val = safe_min(bound_val, rv)
                    violating_val = _step_below(bound_val, target_col_obj.data_type, target_col_obj)
                elif op_name in ("LTE", "LT"):
                    bound_val = ref_vals[0]
                    for rv in ref_vals[1:]:
                        bound_val = safe_max(bound_val, rv)
                    violating_val = _step_above(bound_val, target_col_obj.data_type, target_col_obj)
                elif op_name == "NEQ":
                    violating_val = ref_vals[0]
                else:
                    continue

                orig_row = base_data[target_tbl][0]
                viol_row = copy.deepcopy(orig_row)
                viol_row[target_col] = violating_val

                preserved = preserved_by_table.get(target_tbl, set()) - {target_col.upper()}
                can_share_group = not is_unique_column_set(schema, target_tbl, list(preserved))

                for c in target_table_obj.columns:
                    if c.name == target_col:
                        continue
                    if can_share_group and c.name.upper() in preserved:
                        continue
                    if c.is_primary_key or c.is_unique:
                        viol_row[c.name] = generate_unique_value_for_column(c)
                    elif can_share_group and c.is_numeric and isinstance(viol_row.get(c.name), (int, float)) and not isinstance(viol_row.get(c.name), bool):
                        step = 1 if isinstance(viol_row[c.name], int) else 1.0
                        cand = viol_row[c.name] + step
                        viol_row[c.name] = solve_check_constraint_value(
                            schema, target_tbl, c.name, c, cand, row_context=viol_row
                        )

                merged_data = copy.deepcopy(base_data)
                merged_data[target_tbl].append(viol_row)

                pres_cols = [c.name for c in target_table_obj.columns if c.name.upper() in preserved]
                if can_share_group and pres_cols:
                    iso_indices = (
                        list(range(len(base_data[target_tbl])))
                        if target_tbl == ref_tbl and len(base_data[target_tbl]) > 1
                        else [0]
                    )
                    for iso_idx in iso_indices:
                        iso_data = generate_base_dataset(
                            schema, parsed_query, cache_key_salt=f"missing_pred_iso_{pred_idx}_{iso_idx}"
                        )
                        if iso_data.get(target_tbl) and iso_data.get(ref_tbl) and iso_idx < len(iso_data[target_tbl]):
                            base_key = tuple(orig_row.get(c) for c in pres_cols)
                            iso_key = tuple(iso_data[target_tbl][0].get(c) for c in pres_cols)
                            iso_ref_vals = [
                                r.get(ref_col) for r in iso_data[ref_tbl] if r.get(ref_col) is not None
                            ]
                            if iso_key != base_key and iso_ref_vals:
                                if op_name in ("GTE", "GT"):
                                    iso_bound = iso_ref_vals[0]
                                    for rv in iso_ref_vals[1:]:
                                        iso_bound = safe_min(iso_bound, rv)
                                    iso_viol_val = _step_below(iso_bound, target_col_obj.data_type, target_col_obj)
                                elif op_name in ("LTE", "LT"):
                                    iso_bound = iso_ref_vals[0]
                                    for rv in iso_ref_vals[1:]:
                                        iso_bound = safe_max(iso_bound, rv)
                                    iso_viol_val = _step_above(iso_bound, target_col_obj.data_type, target_col_obj)
                                else:
                                    iso_viol_val = iso_ref_vals[0]
                                iso_data[target_tbl][iso_idx][target_col] = solve_check_constraint_value(
                                    schema,
                                    target_tbl,
                                    target_col,
                                    target_col_obj,
                                    iso_viol_val,
                                    row_context=iso_data[target_tbl][iso_idx],
                                )
                                merged_data = merge_datasets(schema, merged_data, iso_data)

                merged_data = deduplicate_mock_data(schema, merged_data)

                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_col_{target_tbl}_{target_col}_{op_name}_{pred_idx}",
                        data=merged_data,
                        tags=["missing_predicate_attack", "column_predicate_attack"],
                        description=(
                            f"Targets Missing or Partially Omitted Column Predicate bugs on `{target_tbl}.{target_col}` "
                            f"({op_name} `{ref_tbl}.{ref_col}`). Injects a companion row violating the bound while "
                            f"preserving group/join keys so queries or subqueries missing the filter diverge."
                        ),
                    )
                )

        for t_idx, pat in enumerate(temporal_diff_preds):
            target_tbl = pat["table"]
            target_col = pat["column"]
            ref_tbl = pat.get("ref_table")
            ref_col = pat.get("ref_column")
            diff_vals = compute_temporal_diff_values(schema, pat)
            viol_date = diff_vals["violating_date"]
            inj: Dict[Tuple[str, str], Any] = {(target_tbl, target_col): viol_date}
            if ref_tbl and ref_col:
                ref_date_str = pat["ref_dt"].strftime("%Y-%m-%d")
                if (ref_tbl.upper(), ref_col.upper()) == (target_tbl.upper(), target_col.upper()):
                    inj[(target_tbl, target_col)] = [ref_date_str, viol_date]
                else:
                    inj[(ref_tbl, ref_col)] = ref_date_str
            viol_data = generate_base_dataset(
                schema,
                parsed_query,
                value_injections=inj,
                cache_key_salt=f"missing_pred_tdiff_{t_idx}",
            )
            merged_tdiff = deduplicate_mock_data(
                schema, merge_datasets(schema, copy.deepcopy(base_data), viol_data)
            )
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_temporal_diff_{target_col}_{t_idx}",
                    data=merged_tdiff,
                    tags=["missing_predicate_attack", "temporal_diff_predicate_attack"],
                    description=(
                        f"Targets Missing Temporal Difference Predicate bugs on `{target_tbl}.{target_col}`. "
                        "Dataset combines a row satisfying all predicates with a row violating the temporal "
                        "difference threshold."
                    ),
                )
            )

        return datasets
