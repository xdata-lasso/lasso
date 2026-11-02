"""
NullableJoinAttackStrategy Module

Target semantic bug:
Missing, redundant, or relaxed join predicates on nullable columns (both equi-joins and inequality joins).

Algorithm & Dataset Design:
1. Equi-joins (`T1.col = T2.col`):
   Identifies equijoin predicates (in ON or WHERE clauses) involving nullable columns and generates
   datasets forcing join column values to NULL. In SQL, `NULL = NULL` evaluates to UNKNOWN (treated
   as FALSE), so the correct query rejects the row whereas a mutant omitting the predicate accepts it.
2. Null-coalesced join keys (`COALESCE(T1.col, fb) = T2.col` / `IFNULL(T1.col, fb) = T2.col`):
   For each nullable equi-join pair, pairs a row having a `NULL` join key on the nullable side with a
   partner row having the fallback value (`0` for numeric domains, `''` for string domains, or any explicit
   `COALESCE`/`IFNULL` literal extracted from the query) on the opposite side. Under three-valued logic,
   `NULL = fb` evaluates to UNKNOWN and does not join, whereas mutants wrapping the join key in
   `COALESCE(col, fb)` or `IFNULL(col, fb)` erroneously join the rows.
3. Inequality joins (`T1.col <> T2.col`, `<`, `>`, `<=`, `>=`):
   Identifies non-equality join comparisons between distinct table aliases involving nullable columns.
   Injects a paired group of rows that match on all equi-join keys between the two aliases, where one
   row has a non-NULL value for the inequality column and the partner row has NULL. In SQL three-valued
   logic, `val <> NULL` (or `<, >, <=, >=`) evaluates to UNKNOWN and is rejected by the join, whereas
   mutants that rewrite the join into `GROUP BY ..., col` + `COUNT(...) > 1` (treating NULL as a
   distinct group) or `IS DISTINCT FROM` erroneously accept the group.
"""

import copy
from typing import Any, Dict, List

import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import ensure_dataset_uniqueness, generate_base_dataset, resolve_query_column
from dataset_generator.augmentation import repair_orphan_rows
from dataset_generator.constraint_solver import solve_check_constraint_value
from dataset_generator.value_generator import coerce_literal_for_column, generate_unique_value_for_column


class NullableJoinAttackStrategy(AttackStrategy):
    """
    Target semantic bug: missing, redundant, or NULL-unsound join predicates on nullable columns.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query) or self._neq_targets(schema, parsed_query))

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[List[tuple[str, str]]]:
        targets = []
        
        # Check ON clauses
        for join in parsed_query.get("joins", []):
            for pair in join.get("on_pairs", []):
                left_resolved = resolve_query_column(schema, parsed_query, pair["left"]["table"], pair["left"]["column"])
                right_resolved = resolve_query_column(schema, parsed_query, pair["right"]["table"], pair["right"]["column"])
                if left_resolved and right_resolved:
                    left_col = next((c for c in schema.tables[left_resolved[0]].columns if c.name == left_resolved[1]), None)
                    right_col = next((c for c in schema.tables[right_resolved[0]].columns if c.name == right_resolved[1]), None)
                    if left_col and right_col and (left_col.is_nullable or right_col.is_nullable):
                        targets.append([left_resolved, right_resolved])
                        
        # Check WHERE equalities
        for pair in parsed_query.get("where_joins", []):
            left_resolved = resolve_query_column(schema, parsed_query, pair["left"]["table"], pair["left"]["column"])
            right_resolved = resolve_query_column(schema, parsed_query, pair["right"]["table"], pair["right"]["column"])
            if left_resolved and right_resolved:
                left_col = next((c for c in schema.tables[left_resolved[0]].columns if c.name == left_resolved[1]), None)
                right_col = next((c for c in schema.tables[right_resolved[0]].columns if c.name == right_resolved[1]), None)
                if left_col and right_col and (left_col.is_nullable or right_col.is_nullable):
                    targets.append([left_resolved, right_resolved])

        return targets

    def _coalesce_targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[List[tuple[str, str]]]:
        targets = []
        for join in parsed_query.get("joins", []):
            if (join.get("type") or "").upper() in ("EQ_SUBQUERY", "IN_SUBQUERY"):
                continue
            for pair in join.get("on_pairs", []):
                left_resolved = resolve_query_column(schema, parsed_query, pair["left"]["table"], pair["left"]["column"])
                right_resolved = resolve_query_column(schema, parsed_query, pair["right"]["table"], pair["right"]["column"])
                if left_resolved and right_resolved:
                    left_col = next((c for c in schema.tables[left_resolved[0]].columns if c.name == left_resolved[1]), None)
                    right_col = next((c for c in schema.tables[right_resolved[0]].columns if c.name == right_resolved[1]), None)
                    if left_col and right_col and (left_col.is_nullable or right_col.is_nullable):
                        targets.append([left_resolved, right_resolved])

        for pair in parsed_query.get("where_joins", []):
            left_resolved = resolve_query_column(schema, parsed_query, pair["left"]["table"], pair["left"]["column"])
            right_resolved = resolve_query_column(schema, parsed_query, pair["right"]["table"], pair["right"]["column"])
            if left_resolved and right_resolved:
                left_col = next((c for c in schema.tables[left_resolved[0]].columns if c.name == left_resolved[1]), None)
                right_col = next((c for c in schema.tables[right_resolved[0]].columns if c.name == right_resolved[1]), None)
                if left_col and right_col and (left_col.is_nullable or right_col.is_nullable):
                    targets.append([left_resolved, right_resolved])

        return targets

    def _neq_targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dict[str, Any]]:
        ast = parsed_query.get("ast")
        if not ast:
            return []

        clauses = [w.this for w in ast.find_all(exp.Where) if w.this]
        for j in ast.find_all(exp.Join):
            if j.args.get("on"):
                clauses.append(j.args["on"])

        all_eq_pairs = []
        for join in parsed_query.get("joins", []):
            all_eq_pairs.extend(join.get("on_pairs", []))
        all_eq_pairs.extend(parsed_query.get("where_joins", []))

        neq_targets = []
        seen = set()
        for clause in clauses:
            for comp in clause.find_all((exp.NEQ, exp.LT, exp.LTE, exp.GT, exp.GTE)):
                if not (isinstance(comp.left, exp.Column) and isinstance(comp.right, exp.Column)):
                    continue
                lt_alias = comp.left.table or ""
                rt_alias = comp.right.table or ""
                left_resolved = resolve_query_column(schema, parsed_query, lt_alias, comp.left.name)
                right_resolved = resolve_query_column(schema, parsed_query, rt_alias, comp.right.name)
                if not left_resolved or not right_resolved:
                    continue
                if left_resolved == right_resolved and lt_alias.upper() == rt_alias.upper():
                    continue

                left_col = schema.find_column(left_resolved[0], left_resolved[1])
                right_col = schema.find_column(right_resolved[0], right_resolved[1])
                if not left_col or not right_col or not (left_col.is_nullable or right_col.is_nullable):
                    continue

                key = (left_resolved, right_resolved, lt_alias.upper(), rt_alias.upper())
                if key in seen:
                    continue
                seen.add(key)

                eq_pairs = []
                for pair in all_eq_pairs:
                    p_lt = (pair["left"]["table"] or "").upper()
                    p_rt = (pair["right"]["table"] or "").upper()
                    p_l_res = resolve_query_column(schema, parsed_query, pair["left"]["table"], pair["left"]["column"])
                    p_r_res = resolve_query_column(schema, parsed_query, pair["right"]["table"], pair["right"]["column"])
                    if not p_l_res or not p_r_res:
                        continue
                    if p_lt == lt_alias.upper() and p_rt == rt_alias.upper():
                        if (p_l_res[1], p_r_res[1]) not in eq_pairs:
                            eq_pairs.append((p_l_res[1], p_r_res[1]))
                    elif p_lt == rt_alias.upper() and p_rt == lt_alias.upper():
                        if (p_r_res[1], p_l_res[1]) not in eq_pairs:
                            eq_pairs.append((p_r_res[1], p_l_res[1]))

                neq_targets.append({
                    "left_resolved": left_resolved,
                    "right_resolved": right_resolved,
                    "lt_alias": lt_alias.upper(),
                    "rt_alias": rt_alias.upper(),
                    "eq_pairs": eq_pairs,
                })

        return neq_targets

    def _extract_coalesce_fallbacks(
        self,
        schema: Schema,
        parsed_query: Dict[str, Any],
        left_table: str,
        left_col: str,
        right_table: str,
        right_col: str,
        target_col_obj: Any,
        target_tbl: str,
    ) -> List[Any]:
        fallbacks: List[Any] = []
        ast = parsed_query.get("ast")
        target_keys = {(left_table.upper(), left_col.upper()), (right_table.upper(), right_col.upper())}

        if ast:
            clauses = [w.this for w in ast.find_all(exp.Where) if w.this]
            for j in ast.find_all(exp.Join):
                if j.args.get("on"):
                    clauses.append(j.args["on"])

            for clause in clauses:
                for eq in clause.find_all(exp.EQ):
                    for side in (eq.left, eq.right):
                        curr = side
                        while isinstance(curr, (exp.Paren, exp.Cast, exp.TryCast)):
                            curr = curr.this
                        if isinstance(curr, exp.Coalesce) or (
                            isinstance(curr, exp.Anonymous)
                            and (curr.name or "").upper() in ("IFNULL", "NVL", "COALESCE")
                        ):
                            cols = list(curr.find_all(exp.Column))
                            lits = [
                                n for n in curr.find_all((exp.Literal, exp.Neg))
                                if isinstance(n, exp.Literal) or isinstance(n.this, exp.Literal)
                            ]
                            if len(cols) == 1 and lits:
                                res = resolve_query_column(schema, parsed_query, cols[0].table or "", cols[0].name)
                                if res and (res[0].upper(), res[1].upper()) in target_keys:
                                    lit_node = lits[0]
                                    raw_lit = (
                                        f"-{lit_node.this.name}"
                                        if isinstance(lit_node, exp.Neg) and isinstance(lit_node.this, exp.Literal)
                                        else lit_node.name
                                    )
                                    coerced = (
                                        coerce_literal_for_column(target_col_obj, raw_lit)
                                        if target_col_obj
                                        else raw_lit
                                    )
                                    valid_v = solve_check_constraint_value(
                                        schema, target_tbl, target_col_obj.name, target_col_obj, coerced
                                    )
                                    if valid_v == coerced and valid_v not in fallbacks:
                                        fallbacks.append(valid_v)

        if target_col_obj:
            dt_low = (target_col_obj.data_type or "").lower()
            if any(k in dt_low for k in ("int", "real", "floa", "doub", "num", "dec")):
                default_fb: Any = 0.0 if any(k in dt_low for k in ("real", "floa", "doub")) else 0
            elif any(k in dt_low for k in ("char", "text", "clob", "str")):
                default_fb = ""
            else:
                default_fb = None

            if default_fb is not None:
                valid_default = solve_check_constraint_value(
                    schema, target_tbl, target_col_obj.name, target_col_obj, default_fb
                )
                if valid_default == default_fb and valid_default not in fallbacks:
                    fallbacks.append(valid_default)

        return fallbacks

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        targets = self._targets(schema, parsed_query)
        coalesce_targets = self._coalesce_targets(schema, parsed_query)
        coalesce_pair_sigs = {
            (p[0][0].upper(), p[0][1].upper(), p[1][0].upper(), p[1][1].upper())
            for p in coalesce_targets
        }
        seen_coalesce_pairs = set()
        
        for target_pair in targets:
            left_table, left_col = target_pair[0]
            right_table, right_col = target_pair[1]
            
            left_schema_col = next((c for c in schema.tables[left_table].columns if c.name == left_col), None)
            right_schema_col = next((c for c in schema.tables[right_table].columns if c.name == right_col), None)
            
            null_injections = []
            if left_schema_col and left_schema_col.is_nullable:
                null_injections.append((left_table, left_col))
            if right_schema_col and right_schema_col.is_nullable:
                null_injections.append((right_table, right_col))
            
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{left_col}_{right_col}",
                    data=generate_base_dataset(schema, parsed_query, null_injections=null_injections),
                    tags=["nullable_join_attack"],
                    description=f"Targets Nullable Join bugs. Dataset sets both the left join key `{left_table}.{left_col}` and the right join key `{right_table}.{right_col}` to NULL. In standard SQL, NULL = NULL evaluates to UNKNOWN, so these rows should not join. This catches bugs where joins are mutated to accept NULL matches or where conditions are relaxed incorrectly."
                )
            )

            pair_sig = (left_table.upper(), left_col.upper(), right_table.upper(), right_col.upper())
            if (
                pair_sig in coalesce_pair_sigs
                and pair_sig not in seen_coalesce_pairs
                and left_schema_col
                and right_schema_col
            ):
                seen_coalesce_pairs.add(pair_sig)
                l_tbl_obj = schema.tables.get(left_table)
                r_tbl_obj = schema.tables.get(right_table)
                left_refs_right = bool(
                    l_tbl_obj
                    and any(
                        fk.column_name.upper() == left_col.upper()
                        and fk.reference_table.upper() == right_table.upper()
                        for fk in l_tbl_obj.foreign_keys
                    )
                )
                right_refs_left = bool(
                    r_tbl_obj
                    and any(
                        fk.column_name.upper() == right_col.upper()
                        and fk.reference_table.upper() == left_table.upper()
                        for fk in r_tbl_obj.foreign_keys
                    )
                )

                ref_col_obj = right_schema_col if left_refs_right else left_schema_col
                ref_tbl_name = right_table if left_refs_right else left_table
                fallbacks = self._extract_coalesce_fallbacks(
                    schema, parsed_query, left_table, left_col, right_table, right_col, ref_col_obj, ref_tbl_name
                )
                if fallbacks:
                    base_fb = generate_base_dataset(
                        schema, parsed_query, cache_key_salt=f"nullable_coalesce_base_{left_col}_{right_col}"
                    )
                    if base_fb.get(left_table) and base_fb.get(right_table):
                        for fb_val in fallbacks:
                            data_fb = copy.deepcopy(base_fb)
                            injected_any = False

                            if left_schema_col.is_nullable and not right_refs_left:
                                if not any(r.get(left_col) is None for r in data_fb[left_table]):
                                    null_row_l = copy.deepcopy(data_fb[left_table][0])
                                    null_row_l[left_col] = None
                                    for c in l_tbl_obj.columns:
                                        if (c.is_primary_key or c.is_unique) and c.name != left_col:
                                            null_row_l[c.name] = generate_unique_value_for_column(c)
                                    data_fb[left_table].append(null_row_l)
                                if not any(r.get(right_col) == fb_val for r in data_fb[right_table]):
                                    fb_row_r = copy.deepcopy(data_fb[right_table][0])
                                    fb_row_r[right_col] = fb_val
                                    for c in r_tbl_obj.columns:
                                        if (c.is_primary_key or c.is_unique) and c.name != right_col:
                                            fb_row_r[c.name] = generate_unique_value_for_column(c)
                                    data_fb[right_table].append(fb_row_r)
                                injected_any = True

                            if right_schema_col.is_nullable and not left_refs_right:
                                if not any(r.get(right_col) is None for r in data_fb[right_table]):
                                    null_row_r = copy.deepcopy(data_fb[right_table][0])
                                    null_row_r[right_col] = None
                                    for c in r_tbl_obj.columns:
                                        if (c.is_primary_key or c.is_unique) and c.name != right_col:
                                            null_row_r[c.name] = generate_unique_value_for_column(c)
                                    data_fb[right_table].append(null_row_r)
                                if not any(r.get(left_col) == fb_val for r in data_fb[left_table]):
                                    fb_row_l = copy.deepcopy(data_fb[left_table][0])
                                    fb_row_l[left_col] = fb_val
                                    for c in l_tbl_obj.columns:
                                        if (c.is_primary_key or c.is_unique) and c.name != left_col:
                                            fb_row_l[c.name] = generate_unique_value_for_column(c)
                                    data_fb[left_table].append(fb_row_l)
                                injected_any = True

                            if injected_any:
                                repair_orphan_rows(schema, data_fb)
                                data_fb = ensure_dataset_uniqueness(schema, data_fb)
                                datasets.append(
                                    Dataset(
                                        strategy_name=f"{self.__class__.__name__}_coalesce_fallback_{left_col}_{right_col}",
                                        data=data_fb,
                                        tags=["nullable_join_attack", "coalesce_join_attack"],
                                        description=(
                                            f"Targets Null-Coalesced Join Key bugs on `{left_table}.{left_col}` and "
                                            f"`{right_table}.{right_col}`. Pairs a NULL join key on the nullable side "
                                            f"with a row having the fallback value (`{fb_val!r}`) on the partner side. "
                                            f"In standard SQL, `NULL = {fb_val!r}` evaluates to UNKNOWN and does not join, "
                                            f"whereas mutants wrapping the join key in `COALESCE(col, {fb_val!r})` or "
                                            f"`IFNULL(col, {fb_val!r})` erroneously join the rows."
                                        ),
                                    )
                                )

        neq_targets = self._neq_targets(schema, parsed_query)
        if neq_targets:
            alias_to_table = self.get_alias_to_table(schema, parsed_query)
            base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="nullable_neq_join_base")
            for neq_t in neq_targets:
                l_tbl, l_col = neq_t["left_resolved"]
                r_tbl, r_col = neq_t["right_resolved"]
                lt_alias = neq_t.get("lt_alias", "")
                rt_alias = neq_t.get("rt_alias", "")
                eq_pairs = neq_t["eq_pairs"]

                if not base_data.get(l_tbl) or not base_data.get(r_tbl):
                    continue

                left_col_obj = schema.find_column(l_tbl, l_col)
                right_col_obj = schema.find_column(r_tbl, r_col)
                l_table_obj = schema.tables.get(l_tbl)
                r_table_obj = schema.tables.get(r_tbl)
                if not left_col_obj or not right_col_obj or not l_table_obj or not r_table_obj:
                    continue

                l_aliases = [a for a, t in alias_to_table.items() if schema.find_table(t) == l_tbl]
                r_aliases = [a for a, t in alias_to_table.items() if schema.find_table(t) == r_tbl]
                l_idx = l_aliases.index(lt_alias) if lt_alias in l_aliases and l_aliases.index(lt_alias) < len(base_data[l_tbl]) else 0
                if rt_alias in r_aliases and r_aliases.index(rt_alias) < len(base_data[r_tbl]):
                    r_idx = r_aliases.index(rt_alias)
                elif l_tbl == r_tbl and len(base_data[r_tbl]) > 1:
                    r_idx = 1 - l_idx if l_idx in (0, 1) else 1
                else:
                    r_idx = 0

                orig_l = base_data[l_tbl][l_idx]
                orig_r = base_data[r_tbl][r_idx]
                row_l = copy.deepcopy(orig_l)
                row_r = copy.deepcopy(orig_r)

                eq_l_cols = set()
                eq_r_cols = set()
                has_non_null_eq = any(orig_l.get(le) is not None for le, _ in eq_pairs)
                for idx, (le_col, re_col) in enumerate(eq_pairs):
                    eq_l_cols.add(le_col)
                    eq_r_cols.add(re_col)
                    if orig_l.get(le_col) is not None or (not has_non_null_eq and idx == 0):
                        eq_col_obj = schema.find_column(l_tbl, le_col)
                        if eq_col_obj:
                            fresh_val = generate_unique_value_for_column(eq_col_obj)
                            row_l[le_col] = fresh_val
                            row_r[re_col] = fresh_val
                    else:
                        row_l[le_col] = orig_l.get(le_col)
                        row_r[re_col] = orig_l.get(le_col)

                if right_col_obj.is_nullable:
                    if row_l.get(l_col) is None:
                        row_l[l_col] = generate_unique_value_for_column(left_col_obj)
                    row_r[r_col] = None
                elif left_col_obj.is_nullable:
                    if row_r.get(r_col) is None:
                        row_r[r_col] = generate_unique_value_for_column(right_col_obj)
                    row_l[l_col] = None

                for c in l_table_obj.columns:
                    if (c.is_primary_key or c.is_unique) and c.name not in eq_l_cols and c.name != l_col:
                        row_l[c.name] = generate_unique_value_for_column(c)
                for c in r_table_obj.columns:
                    if (c.is_primary_key or c.is_unique) and c.name not in eq_r_cols and c.name != r_col:
                        row_r[c.name] = generate_unique_value_for_column(c)

                data_neq = copy.deepcopy(base_data)
                data_neq[l_tbl].append(row_l)
                data_neq[r_tbl].append(row_r)

                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_neq_{l_col}_{r_col}",
                        data=data_neq,
                        tags=["nullable_join_attack", "inequality_null_attack"],
                        description=(
                            f"Targets Nullable Inequality Join bugs on `{l_tbl}.{l_col}` and `{r_tbl}.{r_col}`. "
                            f"Dataset injects a pair of rows matching on the equi-join keys where one row has a "
                            f"non-NULL `{l_col}` and the partner row has `{r_col}` set to NULL. Under SQL "
                            f"three-valued logic, `{l_col} <> NULL` evaluates to UNKNOWN and is rejected, whereas "
                            f"mutants grouping by `{r_col}` (which treats NULL as a distinct group) or using "
                            f"NULL-safe inequality erroneously include the group."
                        ),
                    )
                )

        return datasets
