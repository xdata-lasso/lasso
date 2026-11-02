"""
DisjunctivePredicateAttackStrategy Module

Target semantic bugs:
Disjunctive (`OR` and column-list `IN`) predicate and join condition mutations in `JOIN ... ON`, `WHERE`, or `HAVING` clauses:
1. Spurious Disjunctive Relaxation: A single join or filter predicate `B_i` is relaxed into a disjunction
   `B_1 OR B_2 OR ... OR B_k` or a column-list `IN` predicate `lhs IN (col_1, col_2, ..., col_k)` over multiple
   candidate columns or conditions.
2. Missing Disjunct Branch: One or more branches of a valid disjunction `B_1 OR B_2 OR ... OR B_k` or `lhs IN (col_1, ..., col_k)` are omitted.
3. Connective Mutation (`OR` <-> `AND`): A disjunction `B_1 OR ... OR B_k` is mutated into a conjunction
   `B_1 AND ... AND B_k` (or vice versa).

Algorithm & Dataset Design:
In the baseline dataset generator, all column equalities (`on_pairs`, `where_joins`) and literal predicates
(`where_literals`) across all branches of an `exp.Or` expression are unified and satisfied simultaneously
(effectively satisfying `B_1 AND B_2 AND ... AND B_k`). While this yields a valid baseline row, any query
checking a strict subset of branches or a conjunction over those branches also accepts the row.

To refute equivalence between a disjunction `D = B_1 OR B_2 OR ... OR B_k` ($k \ge 2$) and any tighter or
looser reformulation, this strategy generates single-branch witness datasets for each branch $B_i$:
1. Active Branch Satisfaction ($B_i = \text{TRUE}$):
   Starts from an isolated baseline dataset satisfying all query constraints outside `D` as well as $B_i$.
   Columns referenced outside `D` and columns referenced in the active branch $B_i$ are marked as protected.
2. Inactive Branch Falsification ($\forall j \neq i, B_j = \text{FALSE}$):
   For every other branch $B_j$ ($j \neq i$):
   - Column-to-column equalities (`L = R`): Modifies the non-protected endpoint column to a distinct value
     (or `NULL` when the column is a nullable foreign key referencing an unfiltered parent table) so `L = R`
     evaluates to FALSE/UNKNOWN without disturbing $B_i$ or outer joins.
   - Column-to-column inequalities (`<, <=, >, >=, <>`): Modifies the non-protected endpoint column to a
     boundary value that violates the comparison relative to the partner column.
   - Column-to-literal comparisons: Assigns a violating value to the target column (checking compatibility
     with $B_i$ when $B_i$ and $B_j$ constrain the same column).
3. Each isolated single-branch witness dataset is merged with the baseline dataset so that both the reference
   query and mutant query produce non-empty results while diverging on the isolated branch tuple, accompanied
   by a standalone single-branch dataset when `LIMIT` or ungrouped aggregation could mask the added tuple.
"""

import copy
import logging
from typing import Any, Dict, List, Optional, Set, Tuple

import sqlglot.expressions as exp

from attacks.base import AttackStrategy
from dataset_generator import (
    deduplicate_mock_data,
    generate_base_dataset,
    merge_datasets,
    next_distinct_value,
    resolve_query_column,
)
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.constraints import _coerce_temporal
from dataset_generator.resolver import _step_above, _step_below
from dataset_generator.value_generator import (
    generate_unique_value_for_column,
    synthesize_string_of_length,
)
from models import Dataset, Schema
from parser import _extract_length_meta, _extract_substring_meta, _extract_temporal_meta

logger = logging.getLogger(__name__)

_MAX_BRANCHES_PER_DISJUNCTION = 25


class DisjunctivePredicateAttackStrategy(AttackStrategy):
    """
    Targets semantic bugs in disjunctive (`OR`) join conditions and filter predicates
    by isolating each disjunct branch $B_i$ ($B_i = \text{TRUE}, \forall j \neq i: B_j = \text{FALSE}$).
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._extract_disjunctions(schema, parsed_query))

    def _resolve_col(
        self, schema: Schema, parsed_query: Dict[str, Any], col_node: exp.Column
    ) -> Optional[Tuple[str, str]]:
        if col_node.table:
            res = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
            if res:
                return res
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

    def _is_column_in_list(self, node: exp.Expression) -> bool:
        if not isinstance(node, exp.In):
            return False
        if node.args.get("query") is not None or node.args.get("field") is not None:
            return False
        if bool(node.args.get("negate")) or node.this is None:
            return False
        exprs = node.expressions or []
        if len(exprs) < 2:
            return False
        return any(isinstance(e, exp.Column) or e.find(exp.Column) is not None for e in exprs)

    def _flatten_or(self, node: exp.Expression) -> List[exp.Expression]:
        curr = node
        while isinstance(curr, exp.Paren):
            curr = curr.this
        if isinstance(curr, exp.Or):
            return self._flatten_or(curr.left) + self._flatten_or(curr.right)
        if self._is_column_in_list(curr):
            lhs = curr.this
            branches: List[exp.Expression] = []
            for e in curr.expressions or []:
                if (
                    isinstance(lhs, exp.Tuple)
                    and isinstance(e, exp.Tuple)
                    and len(lhs.expressions) == len(e.expressions)
                ):
                    eq_atoms = [
                        exp.EQ(this=l_i.copy(), expression=r_i.copy())
                        for l_i, r_i in zip(lhs.expressions, e.expressions)
                    ]
                    if eq_atoms:
                        conj = eq_atoms[0]
                        for atom in eq_atoms[1:]:
                            conj = exp.And(this=conj, expression=atom)
                        branches.append(conj)
                else:
                    branches.append(exp.EQ(this=lhs.copy(), expression=e.copy()))
            return branches
        return [curr] if curr is not None else []

    def _extract_disjunctions(
        self, schema: Schema, parsed_query: Dict[str, Any]
    ) -> List[Dict[str, Any]]:
        ast = parsed_query.get("ast")
        if not ast:
            return []

        clauses: List[exp.Expression] = []
        for j in ast.find_all(exp.Join):
            if j.args.get("on"):
                clauses.append(j.args["on"])
        for w in ast.find_all(exp.Where):
            if w.this:
                clauses.append(w.this)
        for h in ast.find_all(exp.Having):
            if h.this:
                clauses.append(h.this)

        disjunctions: List[Dict[str, Any]] = []
        seen_or_ids: Set[int] = set()

        for clause in clauses:
            or_candidates = (
                [clause]
                if (isinstance(clause, exp.Or) or self._is_column_in_list(clause))
                else []
            ) + [
                n
                for n in clause.find_all((exp.Or, exp.In))
                if n is not clause and (isinstance(n, exp.Or) or self._is_column_in_list(n))
            ]
            for or_node in or_candidates:
                if id(or_node) in seen_or_ids:
                    continue

                # Only process top-level Or nodes (not nested immediately inside another Or)
                p = or_node.parent
                while isinstance(p, exp.Paren):
                    p = p.parent
                if isinstance(p, exp.Or):
                    continue

                # Skip negated Or nodes, CASE/IF conditions, or negated subqueries
                curr: Optional[exp.Expression] = or_node
                not_count = 0
                skip_context = False
                while curr and curr.parent:
                    parent = curr.parent
                    if isinstance(parent, exp.Not):
                        not_count += 1
                    if isinstance(parent, (exp.Case, exp.If)):
                        skip_context = True
                        break
                    if (
                        isinstance(parent, (exp.Exists, exp.In))
                        and parent.parent
                        and isinstance(parent.parent, exp.Not)
                    ):
                        skip_context = True
                        break
                    curr = parent

                if skip_context or (not_count % 2 == 1):
                    continue

                branches = self._flatten_or(or_node)
                if len(branches) < 2:
                    continue

                seen_or_ids.add(id(or_node))

                # Collect columns referenced in any clause outside this `or_node`
                outside_cols: Set[Tuple[str, str]] = set()
                for c_clause in clauses:
                    for col_node in c_clause.find_all(exp.Column):
                        anc = col_node
                        inside_this_or = False
                        while anc:
                            if anc is or_node:
                                inside_this_or = True
                                break
                            anc = anc.parent
                        if not inside_this_or:
                            res = self._resolve_col(schema, parsed_query, col_node)
                            if res:
                                outside_cols.add(res)

                disjunctions.append(
                    {
                        "or_node": or_node,
                        "branches": branches[:_MAX_BRANCHES_PER_DISJUNCTION],
                        "outside_cols": outside_cols,
                    }
                )

        return disjunctions

    def _is_numeric(self, value: Any) -> bool:
        return isinstance(value, (int, float)) and not isinstance(value, bool) or (
            isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit()
        )

    def _values_equal(self, v1: Any, v2: Any) -> bool:
        if v1 is None or v2 is None:
            return False
        if self._is_numeric(v1) and self._is_numeric(v2):
            return float(v1) == float(v2)
        return str(v1) == str(v2)

    def _coerce_number(self, value: Any) -> int | float:
        if isinstance(value, (int, float)) and not isinstance(value, bool):
            return value
        number = float(value)
        return int(number) if number.is_integer() else number

    def _extract_expr_meta(self, expr: Optional[exp.Expression]) -> Dict[str, Any]:
        if expr is None:
            return {}
        meta: Dict[str, Any] = {}
        sub_meta = _extract_substring_meta(expr)
        if sub_meta:
            meta["substr_start"] = sub_meta[0]
            meta["substr_length"] = sub_meta[1]
        meta.update(_extract_temporal_meta(expr))
        meta.update(_extract_length_meta(expr))
        return meta

    def _satisfying_literal_val(
        self,
        op_name: str,
        raw_val: Any,
        meta: Optional[Dict[str, Any]] = None,
        curr_val: Any = None,
    ) -> Any:
        op_up = op_name.upper()
        if raw_val == "NULL":
            return None if op_up in ("IS", "IS NULL", "EQ") else 1

        if meta and meta.get("is_length_expr") and self._is_numeric(raw_val):
            num = int(float(raw_val))
            offset = int(meta.get("length_offset") or 0)
            if op_up in ("GT", "NEQ"):
                expr_len = max(0, num + 1)
            elif op_up == "LT":
                expr_len = max(0, num - 1)
            else:
                expr_len = max(0, num)
            col_len = 0 if (expr_len == 0 and offset == 0) else max(0, expr_len + offset)
            return synthesize_string_of_length(None, col_len)

        if meta and meta.get("substr_start") is not None and int(meta["substr_start"]) >= 1:
            st_pos = int(meta["substr_start"])
            sub_len = meta.get("substr_length")
            if op_up in ("EQ", "IN"):
                slice_str = str(raw_val)
            else:
                slice_str = str(self._satisfying_literal_val(op_name, raw_val))
            if sub_len is not None and int(sub_len) >= 0:
                slice_str = slice_str[: int(sub_len)]
            base_s = str(curr_val) if (curr_val is not None and not isinstance(curr_val, (int, float))) else ""
            prefix = base_s[: st_pos - 1].ljust(st_pos - 1, "_")
            suffix = base_s[st_pos - 1 + len(slice_str) :] if len(base_s) > st_pos - 1 + len(slice_str) else ""
            return prefix + slice_str + suffix

        res: Any = raw_val
        if self._is_numeric(raw_val):
            num = self._coerce_number(raw_val)
            if op_up == "GT":
                res = num + 1
            elif op_up == "LT":
                res = num - 1
            elif op_up == "NEQ":
                res = num + 1
            else:
                res = num

        if meta and (meta.get("is_temporal_expr") or meta.get("strftime_format")):
            return _coerce_temporal(res, "EQ", meta.get("strftime_format"))
        return res

    def _violating_literal_val(
        self,
        schema: Schema,
        table_name: str,
        col_name: str,
        op_name: str,
        raw_val: Any,
        meta: Optional[Dict[str, Any]] = None,
        curr_val: Any = None,
    ) -> Any:
        op_up = op_name.upper()
        col_obj = schema.find_column(table_name, col_name)
        if raw_val == "NULL":
            if op_up in ("IS", "IS NULL", "EQ"):
                if col_obj is not None:
                    cand = generate_unique_value_for_column(col_obj)
                    return solve_check_constraint_value(schema, table_name, col_name, col_obj, cand)
                return 1
            return None

        if meta and meta.get("is_length_expr") and self._is_numeric(raw_val):
            num = int(float(raw_val))
            offset = int(meta.get("length_offset") or 0)
            if op_up in ("GT", "LT", "NEQ"):
                expr_len = num
            elif op_up in ("GTE", "BETWEENLOWER"):
                expr_len = num - 1
            else:
                expr_len = num + 1
            if expr_len < 0:
                return None
            col_len = offset if (expr_len == 0 and offset > 0) else max(0, expr_len + offset)
            return synthesize_string_of_length(col_obj, col_len)

        if meta and meta.get("substr_start") is not None and int(meta["substr_start"]) >= 1:
            st_pos = int(meta["substr_start"])
            sub_len = meta.get("substr_length")
            orig_str = str(raw_val)
            target_len = int(sub_len) if (sub_len is not None and int(sub_len) > 0) else max(1, len(orig_str))
            if self._is_numeric(orig_str):
                v_num = self._violating_literal_val(schema, table_name, col_name, op_name, raw_val)
                viol_slice = str(v_num).zfill(target_len)[-target_len:]
                if viol_slice == orig_str[:target_len]:
                    alt_ch = "9" if orig_str[:1] != "9" else "8"
                    viol_slice = alt_ch + viol_slice[1:]
            else:
                alt_ch = "Z" if orig_str[:1].upper() != "Z" else "Y"
                viol_slice = (alt_ch + orig_str[1:] + ("X" * target_len))[:target_len]
            base_s = str(curr_val) if (curr_val is not None and not isinstance(curr_val, (int, float))) else ""
            prefix = base_s[: st_pos - 1].ljust(st_pos - 1, "_")
            suffix = base_s[st_pos - 1 + len(viol_slice) :] if len(base_s) > st_pos - 1 + len(viol_slice) else ""
            return prefix + viol_slice + suffix

        if self._is_numeric(raw_val):
            num = self._coerce_number(raw_val)
            if op_up == "GT":
                res = num
            elif op_up == "GTE":
                res = num - 1
            elif op_up == "LT":
                res = num
            elif op_up == "LTE":
                res = num + 1
            elif op_up in ("EQ", "IN"):
                res = num + 1
            elif op_up == "NEQ":
                res = num
            else:
                res = num + 1
            if meta and (meta.get("is_temporal_expr") or meta.get("strftime_format")):
                return _coerce_temporal(res, "EQ", meta.get("strftime_format"))
            return res

        if op_up in ("EQ", "IN", "LIKE", "ILIKE"):
            if col_obj is not None:
                return next_distinct_value(col_obj, raw_val, schema=schema, table_name=table_name)
            return str(raw_val) + "_alt"
        if op_up in ("NEQ", "NOT IN", "NOT LIKE", "NOT ILIKE"):
            return raw_val
        return raw_val

    def _eval_literal_pred(
        self,
        val: Any,
        op_name: str,
        target_val: Any,
        meta: Optional[Dict[str, Any]] = None,
    ) -> bool:
        op_up = op_name.upper()
        if target_val == "NULL":
            if op_up in ("IS", "IS NULL", "EQ"):
                return val is None
            return val is not None
        if val is None:
            return False
        if meta:
            if meta.get("is_length_expr"):
                offset = int(meta.get("length_offset") or 0)
                s_full = str(val)
                val = len(s_full[offset:]) if offset > 0 else len(s_full)
            elif meta.get("substr_start") is not None and int(meta["substr_start"]) >= 1:
                st_pos = int(meta["substr_start"])
                sub_len = meta.get("substr_length")
                s_full = str(val)
                val = (
                    s_full[st_pos - 1 : st_pos - 1 + int(sub_len)]
                    if (sub_len is not None and int(sub_len) >= 0)
                    else s_full[st_pos - 1 :]
                )
            elif meta.get("strftime_format"):
                fmt = meta["strftime_format"]
                s_full = str(val)
                if fmt == "%Y" and len(s_full) >= 4:
                    val = s_full[:4]
                elif fmt == "%m" and len(s_full) >= 7:
                    val = s_full[5:7]
                elif fmt == "%d" and len(s_full) >= 10:
                    val = s_full[8:10]
        if self._is_numeric(val) and self._is_numeric(target_val):
            v_num = float(val)
            t_num = float(target_val)
            if op_up in ("EQ", "IN"):
                return v_num == t_num
            if op_up in ("NEQ", "NOT IN"):
                return v_num != t_num
            if op_up == "GT":
                return v_num > t_num
            if op_up in ("GTE", "BETWEENLOWER"):
                return v_num >= t_num
            if op_up == "LT":
                return v_num < t_num
            if op_up in ("LTE", "BETWEENUPPER"):
                return v_num <= t_num
        s_val = str(val)
        s_target = str(target_val)
        if op_up in ("EQ", "IN"):
            return s_val == s_target
        if op_up in ("NEQ", "NOT IN"):
            return s_val != s_target
        if op_up == "GT":
            return s_val > s_target
        if op_up in ("GTE", "BETWEENLOWER"):
            return s_val >= s_target
        if op_up == "LT":
            return s_val < s_target
        if op_up in ("LTE", "BETWEENUPPER"):
            return s_val <= s_target
        return False

    def _extract_branch_atoms(
        self, schema: Schema, parsed_query: Dict[str, Any], branch: exp.Expression
    ) -> Dict[str, Any]:
        col_comparisons: List[Tuple[str, Tuple[str, str], Tuple[str, str]]] = []
        literal_preds: List[Tuple[Tuple[str, str], str, Any, Dict[str, Any]]] = []
        branch_cols: Set[Tuple[str, str]] = set()

        for col_node in branch.find_all(exp.Column):
            res = self._resolve_col(schema, parsed_query, col_node)
            if res:
                branch_cols.add(res)

        comp_types = (
            exp.EQ,
            exp.NEQ,
            exp.GT,
            exp.GTE,
            exp.LT,
            exp.LTE,
            exp.Is,
            exp.In,
            exp.Between,
            exp.Like,
            exp.ILike,
        )
        comp_nodes = ([branch] if isinstance(branch, comp_types) else []) + [
            n for n in branch.find_all(comp_types) if n is not branch
        ]

        neg_op_map = {
            "EQ": "NEQ",
            "NEQ": "EQ",
            "GT": "LTE",
            "GTE": "LT",
            "LT": "GTE",
            "LTE": "GT",
            "IS": "IS NOT",
            "IN": "NOT IN",
            "LIKE": "NOT LIKE",
            "ILIKE": "NOT ILIKE",
        }

        for comp in comp_nodes:
            not_cnt = 0
            curr = comp.parent
            while curr and curr is not branch.parent:
                if isinstance(curr, exp.Not):
                    not_cnt += 1
                curr = curr.parent
            is_neg = (not_cnt % 2 == 1) or bool(comp.args.get("negate"))
            raw_op = comp.__class__.__name__.upper()
            op_name = neg_op_map.get(raw_op, "NOT " + raw_op) if is_neg else raw_op

            if isinstance(comp, exp.Is) and isinstance(comp.expression, exp.Null):
                c_node = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                if c_node:
                    res_c = self._resolve_col(schema, parsed_query, c_node)
                    if res_c:
                        literal_preds.append((res_c, op_name, "NULL", {}))
            elif isinstance(comp, exp.In):
                c_node = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                if c_node:
                    res_c = self._resolve_col(schema, parsed_query, c_node)
                    if res_c:
                        meta = self._extract_expr_meta(comp.this)
                        for expr in comp.expressions or []:
                            if isinstance(expr, exp.Literal):
                                literal_preds.append((res_c, op_name, expr.name, meta))
            elif isinstance(comp, exp.Between):
                c_node = comp.this if isinstance(comp.this, exp.Column) else comp.this.find(exp.Column)
                if c_node:
                    res_c = self._resolve_col(schema, parsed_query, c_node)
                    if res_c:
                        meta = self._extract_expr_meta(comp.this)
                        low_e = comp.args.get("low")
                        high_e = comp.args.get("high")
                        if isinstance(low_e, exp.Literal):
                            literal_preds.append(
                                (res_c, "LT" if is_neg else "GTE", low_e.name, meta)
                            )
                        if isinstance(high_e, exp.Literal):
                            literal_preds.append(
                                (res_c, "GT" if is_neg else "LTE", high_e.name, meta)
                            )
            elif hasattr(comp, "left") and hasattr(comp, "right") and comp.left and comp.right:
                if isinstance(comp.left, exp.Column) and isinstance(comp.right, exp.Column):
                    res_l = self._resolve_col(schema, parsed_query, comp.left)
                    res_r = self._resolve_col(schema, parsed_query, comp.right)
                    if res_l and res_r:
                        col_comparisons.append((op_name, res_l, res_r))
                else:
                    l_col = comp.left if isinstance(comp.left, exp.Column) else comp.left.find(exp.Column)
                    r_col = comp.right if isinstance(comp.right, exp.Column) else comp.right.find(exp.Column)
                    if l_col and isinstance(comp.right, exp.Literal):
                        res_c = self._resolve_col(schema, parsed_query, l_col)
                        if res_c:
                            meta = self._extract_expr_meta(comp.left)
                            literal_preds.append((res_c, op_name, comp.right.name, meta))
                    elif r_col and isinstance(comp.left, exp.Literal):
                        res_c = self._resolve_col(schema, parsed_query, r_col)
                        if res_c:
                            flip_map = {
                                "GT": "LT",
                                "GTE": "LTE",
                                "LT": "GT",
                                "LTE": "GTE",
                                "EQ": "EQ",
                                "NEQ": "NEQ",
                            }
                            flipped_op = flip_map.get(op_name, op_name)
                            meta = self._extract_expr_meta(comp.right)
                            literal_preds.append((res_c, flipped_op, comp.left.name, meta))

        return {
            "col_comparisons": col_comparisons,
            "literal_preds": literal_preds,
            "branch_cols": branch_cols,
        }

    def _falsify_col_comparison(
        self,
        schema: Schema,
        branch_data: Dict[str, List[Dict[str, Any]]],
        op_name: str,
        res_l: Tuple[str, str],
        res_r: Tuple[str, str],
        protected_cols: Set[Tuple[str, str]],
    ) -> bool:
        l_tbl, l_col = res_l
        r_tbl, r_col = res_r
        if not branch_data.get(l_tbl) or not branch_data.get(r_tbl):
            return False

        l_col_obj = schema.find_column(l_tbl, l_col)
        r_col_obj = schema.find_column(r_tbl, r_col)
        if not l_col_obj or not r_col_obj:
            return False

        # Choose which side to modify: prefer non-protected, non-PK column
        target_side: Optional[str] = None
        if res_r not in protected_cols and (res_l in protected_cols or not r_col_obj.is_primary_key):
            target_side = "right"
        elif res_l not in protected_cols:
            target_side = "left"
        else:
            return False

        if target_side == "right":
            target_tbl, target_col, target_col_obj = r_tbl, r_col, r_col_obj
            other_tbl, other_col = l_tbl, l_col
            eff_op = op_name
        else:
            target_tbl, target_col, target_col_obj = l_tbl, l_col, l_col_obj
            other_tbl, other_col = r_tbl, r_col
            inv_map = {"GT": "LT", "GTE": "LTE", "LT": "GT", "LTE": "GTE", "EQ": "EQ", "NEQ": "NEQ"}
            eff_op = inv_map.get(op_name, op_name)

        ref_vals = [r.get(other_col) for r in branch_data[other_tbl] if r.get(other_col) is not None]
        ref_val = ref_vals[0] if ref_vals else None

        is_fk_to_other = any(
            fk.column_name.upper() == target_col.upper()
            and fk.reference_table.upper() == other_tbl.upper()
            for fk in schema.tables[target_tbl].foreign_keys
        )

        for row in branch_data[target_tbl]:
            if eff_op == "EQ":
                if is_fk_to_other and target_col_obj.is_nullable:
                    row[target_col] = None
                elif row.get(target_col) is None or any(
                    self._values_equal(row.get(target_col), rv) for rv in ref_vals
                ):
                    new_val = generate_unique_value_for_column(target_col_obj)
                    if any(self._values_equal(new_val, rv) for rv in ref_vals) and ref_val is not None:
                        new_val = next_distinct_value(
                            target_col_obj, ref_val, schema=schema, table_name=target_tbl
                        )
                    new_val = solve_check_constraint_value(
                        schema, target_tbl, target_col, target_col_obj, new_val, row_context=row
                    )
                    row[target_col] = new_val
            elif eff_op == "NEQ" and ref_val is not None:
                row[target_col] = ref_val
            elif eff_op in ("GT", "GTE") and ref_val is not None:
                # Target is right side of `other > target` (or left of `target < other`),
                # so falsifying requires `target >= other` -> step above `ref_val`
                cand = _step_above(ref_val, target_col_obj.data_type, target_col_obj)
                row[target_col] = solve_check_constraint_value(
                    schema, target_tbl, target_col, target_col_obj, cand, row_context=row
                )
            elif eff_op in ("LT", "LTE") and ref_val is not None:
                cand = _step_below(ref_val, target_col_obj.data_type, target_col_obj)
                row[target_col] = solve_check_constraint_value(
                    schema, target_tbl, target_col, target_col_obj, cand, row_context=row
                )

        return True

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        disjunctions = self._extract_disjunctions(schema, parsed_query)
        if not disjunctions:
            return []

        datasets: List[Dataset] = []
        base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="disj_base")
        iso_base = generate_base_dataset(schema, parsed_query, cache_key_salt="disj_iso")

        needs_standalone = bool(
            parsed_query.get("has_limit") or not parsed_query.get("has_group_by")
        )
        standalone_datasets: List[Dataset] = []

        for disj_idx, disj in enumerate(disjunctions):
            branches = disj["branches"]
            outside_cols = disj["outside_cols"]
            branch_atoms = [
                self._extract_branch_atoms(schema, parsed_query, b) for b in branches
            ]

            for b_idx, active_atoms in enumerate(branch_atoms):
                branch_data = copy.deepcopy(iso_base)
                active_protected: Set[Tuple[str, str]] = set(outside_cols) | set(
                    active_atoms["branch_cols"]
                )

                # Step 1: Ensure active branch B_i is satisfied on branch_data
                for op_name, res_l, res_r in active_atoms["col_comparisons"]:
                    l_tbl, l_col = res_l
                    r_tbl, r_col = res_r
                    if not branch_data.get(l_tbl) or not branch_data.get(r_tbl):
                        continue
                    l_val = branch_data[l_tbl][0].get(l_col)
                    r_val = branch_data[r_tbl][0].get(r_col)
                    if op_name == "EQ" and not self._values_equal(l_val, r_val):
                        r_col_obj = schema.find_column(r_tbl, r_col)
                        if r_col_obj and not r_col_obj.is_primary_key and l_val is not None:
                            l_rows = branch_data[l_tbl]
                            for idx_r, row in enumerate(branch_data[r_tbl]):
                                cand_l = l_rows[idx_r % len(l_rows)].get(l_col)
                                row[r_col] = cand_l if cand_l is not None else l_val
                        elif r_val is not None:
                            r_rows = branch_data[r_tbl]
                            for idx_l, row in enumerate(branch_data[l_tbl]):
                                cand_r = r_rows[idx_l % len(r_rows)].get(r_col)
                                row[l_col] = cand_r if cand_r is not None else r_val

                for res_c, op_name, raw_val, meta in active_atoms["literal_preds"]:
                    c_tbl, c_col = res_c
                    if not branch_data.get(c_tbl):
                        continue
                    curr_val = branch_data[c_tbl][0].get(c_col)
                    if not self._eval_literal_pred(curr_val, op_name, raw_val, meta):
                        sat_val = self._satisfying_literal_val(op_name, raw_val, meta, curr_val)
                        c_obj = schema.find_column(c_tbl, c_col)
                        for row in branch_data[c_tbl]:
                            if c_obj and sat_val is not None:
                                row[c_col] = solve_check_constraint_value(
                                    schema, c_tbl, c_col, c_obj, sat_val, row_context=row
                                )
                            else:
                                row[c_col] = sat_val

                # Step 2: Falsify all inactive branches B_j (j != b_idx)
                for j_idx, other_atoms in enumerate(branch_atoms):
                    if j_idx == b_idx:
                        continue

                    falsified_in_branch = False
                    for op_name, res_l, res_r in other_atoms["col_comparisons"]:
                        if self._falsify_col_comparison(
                            schema, branch_data, op_name, res_l, res_r, active_protected
                        ):
                            falsified_in_branch = True
                            break

                    if falsified_in_branch:
                        continue

                    for res_c, op_name, raw_val, meta in other_atoms["literal_preds"]:
                        c_tbl, c_col = res_c
                        if not branch_data.get(c_tbl):
                            continue
                        curr_val = branch_data[c_tbl][0].get(c_col)
                        if not self._eval_literal_pred(curr_val, op_name, raw_val, meta):
                            falsified_in_branch = True
                            break

                        viol_val = self._violating_literal_val(
                            schema, c_tbl, c_col, op_name, raw_val, meta, curr_val
                        )
                        if res_c not in active_protected:
                            c_obj = schema.find_column(c_tbl, c_col)
                            for row in branch_data[c_tbl]:
                                if c_obj and viol_val is not None:
                                    row[c_col] = solve_check_constraint_value(
                                        schema, c_tbl, c_col, c_obj, viol_val, row_context=row
                                    )
                                else:
                                    row[c_col] = viol_val
                            falsified_in_branch = True
                            break
                        else:
                            # Same column is constrained in active branch B_i: check if viol_val
                            # (or any active satisfying value) satisfies B_i while violating B_j.
                            active_same_col_lits = [
                                (a_op, a_val, a_meta)
                                for a_res, a_op, a_val, a_meta in active_atoms["literal_preds"]
                                if a_res == res_c
                            ]
                            candidates = [viol_val] + [
                                self._satisfying_literal_val(a_op, a_val, a_meta, curr_val)
                                for a_op, a_val, a_meta in active_same_col_lits
                            ]
                            for cand in candidates:
                                if not self._eval_literal_pred(cand, op_name, raw_val, meta) and all(
                                    self._eval_literal_pred(cand, a_op, a_val, a_meta)
                                    for a_op, a_val, a_meta in active_same_col_lits
                                ):
                                    for row in branch_data[c_tbl]:
                                        row[c_col] = cand
                                    falsified_in_branch = True
                                    break
                            if falsified_in_branch:
                                break

                branch_data = deduplicate_mock_data(schema, branch_data)
                merged_data = merge_datasets(schema, base_data, branch_data)

                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_disj_{disj_idx}_branch_{b_idx}",
                        data=merged_data,
                        tags=["disjunctive_predicate_attack", "logical_operator"],
                        description=(
                            f"Targets Disjunctive (`OR`) Predicate/Join bugs (disjunction {disj_idx + 1}, "
                            f"branch {b_idx + 1}). Combines a baseline row with an isolated witness row "
                            f"that satisfies only branch {b_idx + 1} while falsifying all other disjunct "
                            f"branches. Queries omitting this branch, restricting to a single branch, or "
                            f"replacing `OR` with `AND` reject the witness row."
                        ),
                    )
                )

                if needs_standalone:
                    standalone_datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_standalone_disj_{disj_idx}_branch_{b_idx}",
                            data=branch_data,
                            tags=["disjunctive_predicate_attack", "logical_operator"],
                            description=(
                                f"Standalone single-branch witness dataset for disjunction {disj_idx + 1}, "
                                f"branch {b_idx + 1}, satisfying only branch {b_idx + 1} while falsifying "
                                f"all other disjunct branches."
                            ),
                        )
                    )

        datasets.extend(standalone_datasets)
        return datasets
