"""
AntiJoinAttackStrategy Module
=============================

Target semantic bugs:
  - Incorrect Anti-Semi-Join semantics (NOT EXISTS subqueries dropped, replaced with EXISTS,
    or with broken correlation).
  - Incorrect NOT IN subquery semantics (omitted NOT IN, corrupted subquery filter, or
    erroneous conversion to IN/JOIN).

Algorithm & Dataset Design:
  In relational algebra, an anti-semi-join (R anti-join S on C) preserves only those tuples in R
  for which NO matching tuple exists in S satisfying condition C.
  The baseline dataset generator satisfies the reference query by ensuring the subquery condition
  evaluates to false (e.g. by leaving subquery tables empty or un-correlated so outer tuples pass).
  However, candidate mutants that omit the NOT EXISTS/NOT IN filter or corrupt its condition
  will also accept all outer tuples, surviving on the baseline dataset.

  This attack intentionally crafts datasets where the subquery condition C IS SATISFIED for outer tuples:
  1. For NOT EXISTS: It identifies the subquery expression, substitutes outer correlated column
     references with concrete values from an outer tuple in the baseline dataset, and synthesizes
     consistent subquery rows satisfying all internal filters and foreign keys. Additionally, for each
     internal literal filter predicate inside the NOT EXISTS subquery, it synthesizes a correlated
     subquery row that satisfies the correlation key and all other subquery filters while violating
     that specific predicate, catching omitted or spuriously added conjuncts inside NOT EXISTS.
  2. For NOT IN: It forces the subquery to produce the outer tuple's join key value, ensuring the
     outer tuple is actively excluded by NOT IN. Furthermore, for each internal literal filter
     predicate inside the NOT IN subquery, it synthesizes a key-matching subquery row that satisfies
     all other subquery filters while violating that specific predicate, catching omitted or
     spuriously added conjuncts inside NOT IN subqueries.
  In both cases, the correct query rejects the outer tuple (yielding an empty or reduced result set),
  while mutants lacking or corrupting the anti-join condition retain the tuple, refuting equivalence.
"""

from typing import Any, Dict, List
import copy
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from attacks.missing_predicate_attack import MissingPredicateAttackStrategy
from parser import parse_sql_to_ast
from dataset_generator import generate_base_dataset, merge_datasets, resolve_query_column
from dataset_generator.utils import next_distinct_value
from dataset_generator.value_generator import DataFactory


class AntiJoinAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Anti-Semi-Join (NOT EXISTS / NOT IN) mutations.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        ast = parsed_query.get("ast")
        if not ast:
            return False

        # Check for NOT EXISTS
        for ne in ast.find_all(exp.Not):
            if isinstance(ne.this, exp.Exists):
                return True

        for ex in ast.find_all(exp.Exists):
            p = ex.parent
            while p:
                if isinstance(p, exp.Not):
                    return True
                if isinstance(p, (exp.Select, exp.Subquery)):
                    break
                p = p.parent

        # Check for NOT IN subqueries
        for in_node in ast.find_all(exp.In):
            if in_node.args.get("query"):
                p = in_node.parent
                while p:
                    if isinstance(p, exp.Not):
                        return True
                    if isinstance(p, (exp.Select, exp.Subquery)):
                        break
                    p = p.parent

        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        ast = parsed_query.get("ast")
        if not ast:
            return datasets

        base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="anti_join_base")
        outer_tables = {
            (t.get("alias") or t.get("name", "")).upper(): t.get("name", "")
            for t in parsed_query.get("tables", [])
        }

        # ── Attack 1: NOT EXISTS Subqueries ──
        seen_not_exists = set()
        not_exists_subq_data_list = []
        for ex_node in ast.find_all(exp.Exists):
            p = ex_node.parent
            is_negated = False
            while p:
                if isinstance(p, exp.Not):
                    is_negated = True
                    break
                if isinstance(p, (exp.Select, exp.Subquery)):
                    break
                p = p.parent

            if not is_negated:
                continue

            subq_node = ex_node.this
            subq_sql_raw = subq_node.sql()
            if subq_sql_raw in seen_not_exists:
                continue
            seen_not_exists.add(subq_sql_raw)

            subq_copy = subq_node.copy()
            # If subq is a Subquery wrapper, unwrap to Select
            select_node = subq_copy.this if isinstance(subq_copy, exp.Subquery) else subq_copy

            inner_tables = {(t.alias or t.name).upper(): t.name for t in select_node.find_all(exp.Table)}
            for sub in select_node.find_all(exp.Subquery):
                if sub.alias:
                    t = sub.find(exp.Table)
                    if t:
                        inner_tables[sub.alias.upper()] = t.name
            outer_scope_tables = {
                (t.get("alias") or t.get("name", "")).upper(): t.get("name", "")
                for t in parsed_query.get("tables", [])
                if (t.get("alias") or t.get("name", "")).upper() not in inner_tables
            }

            # Find outer correlated column references in subquery and bind them to concrete outer row values
            has_unresolved_outer = False
            correlated_inner_cols = set()
            for col in select_node.find_all(exp.Column):
                col_tbl = (col.table or "").upper()
                if col_tbl and col_tbl not in inner_tables:
                    if col_tbl in outer_scope_tables:
                        schema_tbl = schema.find_table(outer_scope_tables[col_tbl])
                        if schema_tbl and base_data.get(schema_tbl):
                            col_obj = schema.find_column(schema_tbl, col.name)
                            c_name = col_obj.name if col_obj else col.name
                            val = base_data[schema_tbl][0].get(c_name)
                            if val is not None:
                                eq_anc = col.find_ancestor(exp.EQ)
                                if eq_anc is not None:
                                    for inner_c in eq_anc.find_all(exp.Column):
                                        if inner_c is not col and inner_c.name:
                                            correlated_inner_cols.add((inner_c.name.upper(), str(val)))
                                if isinstance(val, str):
                                    col.replace(exp.Literal.string(val))
                                else:
                                    col.replace(exp.Literal.number(val))
                            else:
                                has_unresolved_outer = True
                        else:
                            has_unresolved_outer = True
                    else:
                        has_unresolved_outer = True

            if has_unresolved_outer:
                continue

            try:
                subq_sql = select_node.sql()
                subq_parsed = parse_sql_to_ast(subq_sql)
                subq_data = generate_base_dataset(
                    schema, subq_parsed, cache_key_salt=f"anti_join_subq_{len(datasets)}"
                )
                not_exists_subq_data_list.append(subq_data)
                merged = merge_datasets(schema, base_data, subq_data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_not_exists",
                        data=merged,
                        tags=["anti_join", "not_exists"],
                        description=(
                            "Targets Anti-Semi-Join NOT EXISTS bugs. Dataset synthesizes subquery rows "
                            "that satisfy internal predicates and correlation conditions. A correct query "
                            "with NOT EXISTS rejects the outer row, while a mutant dropping or corrupting "
                            "the NOT EXISTS condition erroneously retains it."
                        )
                    )
                )

                pred_helper = MissingPredicateAttackStrategy()
                subq_literals = subq_parsed.get("where_literals", [])
                for lit_idx, target_lit in enumerate(subq_literals):
                    col_up = (target_lit.get("column") or "").upper()
                    val_str = str(target_lit.get("value", ""))
                    if (col_up, val_str) in correlated_inner_cols and target_lit.get("operator", "EQ").upper() == "EQ":
                        continue
                    violating_val = pred_helper._violating_value(schema, subq_parsed, target_lit)
                    modified_subq = copy.deepcopy(subq_parsed)
                    target_col_info = resolve_query_column(
                        schema, subq_parsed, target_lit.get("table", ""), target_lit.get("column", "")
                    )
                    viol_injections = {}
                    if target_col_info and (target_lit.get("substr_start") is None or violating_val is None):
                        viol_injections[target_col_info] = violating_val
                    for idx_l, lit_l in enumerate(modified_subq.get("where_literals", [])):
                        if idx_l == lit_idx:
                            if violating_val is None:
                                lit_l["value"] = "NULL"
                                lit_l["operator"] = "Is"
                            else:
                                lit_l["value"] = violating_val
                                lit_l["operator"] = "EQ"
                        elif lit_l.get("value") != "NULL":
                            lit_l["value"] = pred_helper._satisfying_value(lit_l)
                    viol_subq_data = generate_base_dataset(
                        schema,
                        modified_subq,
                        value_injections=viol_injections,
                        cache_key_salt=f"anti_join_subq_viol_{len(datasets)}_{lit_idx}",
                    )
                    merged_viol = merge_datasets(schema, base_data, viol_subq_data)
                    datasets.append(
                        Dataset(
                            strategy_name=f"{self.__class__.__name__}_not_exists_pred_{target_lit.get('column', 'col')}_{lit_idx}",
                            data=merged_viol,
                            tags=["anti_join", "not_exists", "missing_predicate_attack"],
                            description=(
                                f"Targets Internal Predicate mutations inside NOT EXISTS on `{target_lit.get('column', 'col')}`. "
                                f"Synthesizes a correlated subquery row that satisfies the correlation key and all other "
                                f"subquery predicates while violating predicate {lit_idx + 1} (`{target_lit.get('column', 'col')}`)."
                            ),
                        )
                    )
            except Exception:
                pass

            # ── Attack 1b: Nullable Correlation Key in NOT EXISTS (Three-Valued Logic vs EXCEPT / NOT IN) ──
            # In SQL three-valued logic, NULL = NULL evaluates to UNKNOWN. Therefore, an outer row with a NULL
            # correlation column is never matched by NOT EXISTS (the subquery condition fails, so NOT EXISTS passes),
            # whereas EXCEPT treats NULL as equal to NULL and eliminates the row.
            raw_subq = subq_node.this if isinstance(subq_node, exp.Subquery) else subq_node
            for eq in raw_subq.find_all(exp.EQ):
                cols_l = list(eq.left.find_all(exp.Column)) if isinstance(eq.left, exp.Expression) else []
                cols_r = list(eq.right.find_all(exp.Column)) if isinstance(eq.right, exp.Expression) else []
                if len(cols_l) == 1 and len(cols_r) == 1:
                    c1, c2 = cols_l[0], cols_r[0]
                    t1, t2 = (c1.table or "").upper(), (c2.table or "").upper()
                    outer_tbl_name, inner_tbl_name = None, None
                    outer_col_name, inner_col_name = None, None
                    if t1 in outer_scope_tables and t2 in inner_tables:
                        outer_tbl_name = schema.find_table(outer_scope_tables[t1])
                        inner_tbl_name = schema.find_table(inner_tables[t2])
                        outer_col_name, inner_col_name = c1.name, c2.name
                    elif t2 in outer_scope_tables and t1 in inner_tables:
                        outer_tbl_name = schema.find_table(outer_scope_tables[t2])
                        inner_tbl_name = schema.find_table(inner_tables[t1])
                        outer_col_name, inner_col_name = c2.name, c1.name

                    if outer_tbl_name and inner_tbl_name:
                        col_out = schema.find_column(outer_tbl_name, outer_col_name)
                        col_in = schema.find_column(inner_tbl_name, inner_col_name)
                        if col_out and col_in and col_out.is_nullable and col_in.is_nullable and not col_out.is_primary_key:
                            try:
                                outer_null_data = generate_base_dataset(
                                    schema, parsed_query, null_injections=[(outer_tbl_name, col_out.name)],
                                    cache_key_salt=f"anti_join_null_out_{len(datasets)}"
                                )
                                inner_subq_node = raw_subq.copy()
                                inner_select = inner_subq_node.this if isinstance(inner_subq_node, exp.Subquery) else inner_subq_node
                                for c in inner_select.find_all(exp.Column):
                                    if (c.table or "").upper() in outer_scope_tables:
                                        c.replace(exp.Null())
                                inner_parsed = parse_sql_to_ast(inner_select.sql())
                                inner_null_data = generate_base_dataset(
                                    schema, inner_parsed, null_injections=[(inner_tbl_name, col_in.name)],
                                    cache_key_salt=f"anti_join_null_in_{len(datasets)}"
                                )
                                merged_null = merge_datasets(schema, outer_null_data, inner_null_data)
                                datasets.append(
                                    Dataset(
                                        strategy_name=f"{self.__class__.__name__}_not_exists_null_correlation_{col_out.name}",
                                        data=merged_null,
                                        tags=["anti_join", "not_exists", "null_correlation"],
                                        description=(
                                            f"Targets Anti-Semi-Join NULL correlation bugs on `{outer_tbl_name}.{col_out.name}`. "
                                            f"In SQL three-valued logic, `NULL = NULL` is UNKNOWN, so an outer tuple with a NULL "
                                            f"correlation key is retained by NOT EXISTS, whereas EXCEPT or flawed anti-join "
                                            f"rewrites eliminate the NULL tuple."
                                        )
                                    )
                                )
                            except Exception:
                                pass

            # ── Attack 1c: Uncorrelated Nested Subqueries inside NOT EXISTS ──
            # When NOT EXISTS contains a nested subquery (e.g. EXISTS) correlated to the enclosing subquery,
            # mutants may drop or corrupt this nested correlation. We synthesize an enclosing row matching
            # the outer query but leaving the nested subquery unsatisfied, while creating an inner row
            # satisfying the nested subquery with a distinct, uncorrelated key.
            for nested_ex in select_node.find_all(exp.Exists):
                try:
                    nested_select = nested_ex.this if isinstance(nested_ex.this, exp.Select) else (
                        nested_ex.this.this if isinstance(nested_ex.this, exp.Subquery) else nested_ex.this
                    )
                    if not isinstance(nested_select, exp.Select):
                        continue
                    nested_tables = {(t.alias or t.name).upper(): t.name for t in nested_select.find_all(exp.Table)}
                    if not nested_tables:
                        continue
                    enclosing_tables = {k: v for k, v in inner_tables.items() if k not in nested_tables}
                    enclosing_tables.update(outer_scope_tables)

                    corr_pairs = []
                    for eq in nested_select.find_all(exp.EQ):
                        cols_left = list(eq.left.find_all(exp.Column)) if isinstance(eq.left, exp.Expression) else []
                        cols_right = list(eq.right.find_all(exp.Column)) if isinstance(eq.right, exp.Expression) else []
                        if len(cols_left) == 1 and len(cols_right) == 1:
                            c_l, c_r = cols_left[0], cols_right[0]
                            c_l_tbl = (c_l.table or "").upper()
                            c_r_tbl = (c_r.table or "").upper()
                            if c_l_tbl in nested_tables and c_r_tbl in enclosing_tables:
                                corr_pairs.append((eq, c_l, c_r))
                            elif c_r_tbl in nested_tables and c_l_tbl in enclosing_tables:
                                corr_pairs.append((eq, c_r, c_l))

                    for eq, nested_col, enclosing_col in corr_pairs:
                        select_node_enc = select_node.copy()
                        for ne in select_node_enc.find_all(exp.Exists):
                            if ne.sql() == nested_ex.sql():
                                ne.replace(exp.true())
                                break

                        data_enc = generate_base_dataset(
                            schema, parse_sql_to_ast(select_node_enc.sql()),
                            cache_key_salt=f"anti_join_enc_{len(datasets)}"
                        )

                        enc_alias = (enclosing_col.table or "").upper()
                        enc_table_name = enclosing_tables.get(enc_alias)
                        if not enc_table_name:
                            continue
                        schema_enc_tbl = schema.find_table(enc_table_name)
                        col_obj_enc = schema.find_column(schema_enc_tbl, enclosing_col.name)
                        c_name_enc = col_obj_enc.name if col_obj_enc else enclosing_col.name
                        enclosing_val = None
                        if schema_enc_tbl and data_enc.get(schema_enc_tbl):
                            enclosing_val = data_enc[schema_enc_tbl][0].get(c_name_enc)
                        elif schema_enc_tbl and base_data.get(schema_enc_tbl):
                            enclosing_val = base_data[schema_enc_tbl][0].get(c_name_enc)

                        if enclosing_val is None:
                            continue

                        nested_alias = (nested_col.table or "").upper()
                        nested_tbl_name = nested_tables.get(nested_alias)
                        if not nested_tbl_name:
                            continue
                        schema_tbl_nested = schema.find_table(nested_tbl_name)
                        col_obj_nested = schema.find_column(schema_tbl_nested, nested_col.name)
                        if not col_obj_nested:
                            continue
                        diff_val = next_distinct_value(
                            col_obj_nested, enclosing_val, schema=schema, table_name=schema_tbl_nested
                        )

                        nested_select_diff = nested_select.copy()
                        for col in nested_select_diff.find_all(exp.Column):
                            c_tbl = (col.table or "").upper()
                            if c_tbl not in nested_tables:
                                if c_tbl == enc_alias and col.name.upper() == enclosing_col.name.upper():
                                    if isinstance(diff_val, str):
                                        col.replace(exp.Literal.string(diff_val))
                                    else:
                                        col.replace(exp.Literal.number(diff_val))
                                else:
                                    if c_tbl in enclosing_tables:
                                        tbl_name = enclosing_tables[c_tbl]
                                        st = schema.find_table(tbl_name)
                                        val = None
                                        if st and data_enc.get(st):
                                            co = schema.find_column(st, col.name)
                                            cn = co.name if co else col.name
                                            val = data_enc[st][0].get(cn)
                                        elif st and base_data.get(st):
                                            co = schema.find_column(st, col.name)
                                            cn = co.name if co else col.name
                                            val = base_data[st][0].get(cn)
                                        if val is not None:
                                            if isinstance(val, str):
                                                col.replace(exp.Literal.string(val))
                                            else:
                                                col.replace(exp.Literal.number(val))

                        data_nest = generate_base_dataset(
                            schema, parse_sql_to_ast(nested_select_diff.sql()),
                            cache_key_salt=f"anti_join_nest_{len(datasets)}"
                        )

                        merged = merge_datasets(schema, base_data, data_enc)
                        merged = merge_datasets(schema, merged, data_nest)
                        DataFactory().clear_uniqueness()

                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_uncorrelated_nested_{nested_col.table}_{nested_col.name}",
                                data=merged,
                                tags=["anti_join", "nested_correlation"],
                                description=(
                                    "Targets Broken Nested Subquery Correlation in Anti-Semi-Joins. Synthesizes an enclosing row "
                                    "matching the outer query but leaving the nested subquery unsatisfied, while creating a distinct "
                                    "inner row satisfying the nested subquery with an uncorrelated key. A correct query preserves the "
                                    "outer row because the nested correlation fails, while a mutant dropping the correlation rejects "
                                    "the outer row due to the uncorrelated inner row."
                                )
                            )
                        )
                except Exception:
                    pass

        if len(not_exists_subq_data_list) > 1:
            combined = copy.deepcopy(base_data)
            for s_data in not_exists_subq_data_list:
                combined = merge_datasets(schema, combined, s_data)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_nested_not_exists_combined",
                    data=combined,
                    tags=["anti_join", "not_exists", "nested_not_exists"],
                    description=(
                        "Targets Nested or Multiple NOT EXISTS subquery bugs. Simultaneously synthesizes rows "
                        "satisfying multiple subquery branches, testing interactions where an inner subquery "
                        "activates or deactivates an enclosing subquery's filtering condition."
                    )
                )
            )

        # ── Attack 2: NOT IN Subqueries ──
        seen_not_in = set()
        for in_node in ast.find_all(exp.In):
            subq_expr = in_node.args.get("query")
            if not subq_expr:
                continue

            p = in_node.parent
            is_negated = False
            while p:
                if isinstance(p, exp.Not):
                    is_negated = True
                    break
                if isinstance(p, (exp.Select, exp.Subquery)):
                    break
                p = p.parent

            if not is_negated:
                continue

            in_sql_raw = in_node.sql()
            if in_sql_raw in seen_not_in:
                continue
            seen_not_in.add(in_sql_raw)

            # Left side can be a Column or Tuple of Columns
            left_expr = in_node.this
            left_cols = []
            if isinstance(left_expr, exp.Column):
                left_cols = [left_expr]
            elif isinstance(left_expr, exp.Tuple):
                left_cols = [c for c in left_expr.expressions if isinstance(c, exp.Column)]

            subq_inner = subq_expr
            while isinstance(subq_inner, exp.Subquery):
                subq_inner = subq_inner.this
            right_cols = []
            if hasattr(subq_inner, "expressions"):
                for e in subq_inner.expressions:
                    c = e.this if isinstance(e, exp.Alias) else e
                    if isinstance(c, exp.Column):
                        right_cols.append(c)

            if len(left_cols) == len(right_cols) and len(left_cols) > 0:
                value_injections = {}
                for l_col, r_col in zip(left_cols, right_cols):
                    resolved_l = resolve_query_column(schema, parsed_query, l_col.table, l_col.name)
                    if not resolved_l:
                        continue
                    l_tbl, l_cname = resolved_l
                    if not base_data.get(l_tbl):
                        continue
                    val = base_data[l_tbl][0].get(l_cname)
                    if val is None:
                        continue

                    # Determine table of right column
                    r_tbl_name = r_col.table
                    if not r_tbl_name:
                        for t in subq_inner.find_all(exp.Table):
                            r_tbl_name = t.alias or t.name
                            break
                    if r_tbl_name:
                        resolved_r = schema.find_table(r_tbl_name)
                        if resolved_r:
                            value_injections[(resolved_r, r_col.name)] = val

                if value_injections:
                    try:
                        subq_sql = subq_inner.sql()
                        subq_parsed = parse_sql_to_ast(subq_sql)
                        subq_data = generate_base_dataset(
                            schema, subq_parsed, value_injections=value_injections,
                            cache_key_salt=f"anti_join_not_in_{len(datasets)}"
                        )
                        merged = merge_datasets(schema, base_data, subq_data)
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_not_in",
                                data=merged,
                                tags=["anti_join", "not_in"],
                                description=(
                                    "Targets Anti-Semi-Join NOT IN bugs. Dataset forces the subquery to include "
                                    "the outer row's join key value. A correct query with NOT IN excludes the "
                                    "outer row, whereas a mutant omitting NOT IN or converting it to IN erroneously "
                                    "produces divergent results."
                                )
                            )
                        )

                        # Multi-row NOT IN exclusion dataset: generate a leading decoy row in the NOT IN
                        # subquery BEFORE the outer row's matching exclusion row (so the decoy receives a
                        # smaller primary key / rowid and is scanned first by SQLite), plus a retained outer row.
                        # Mutants that evaluate the NOT IN subquery as a scalar subquery (e.g. `IN ((SELECT ...))`,
                        # `!= (SELECT ...)`, or `LIMIT 1`) only check the first subquery row (the decoy) and
                        # fail to exclude the second outer row.
                        subq_decoy = generate_base_dataset(
                            schema, subq_parsed,
                            cache_key_salt=f"anti_join_not_in_decoy_{len(datasets)}"
                        )
                        subq_match = generate_base_dataset(
                            schema, subq_parsed, value_injections=value_injections,
                            cache_key_salt=f"anti_join_not_in_match_{len(datasets)}"
                        )
                        base_keep = generate_base_dataset(
                            schema, parsed_query,
                            cache_key_salt=f"anti_join_not_in_keep_{len(datasets)}"
                        )
                        multi_merged = merge_datasets(schema, subq_decoy, base_data)
                        multi_merged = merge_datasets(schema, multi_merged, subq_match)
                        multi_merged = merge_datasets(schema, multi_merged, base_keep)
                        datasets.append(
                            Dataset(
                                strategy_name=f"{self.__class__.__name__}_not_in_multi_exclusion",
                                data=multi_merged,
                                tags=["anti_join", "not_in"],
                                description=(
                                    "Targets Scalar-Subquery / Truncated NOT IN bugs (e.g. `NOT col IN ((SELECT ...))`). "
                                    "Places a leading decoy row in the NOT IN subquery followed by a second subquery row "
                                    "matching an outer candidate row and a separate retained outer row. A correct NOT IN "
                                    "set-membership check excludes the second candidate and returns only the retained outer "
                                    "row, whereas a scalar or LIMIT-1 subquery only inspects the first subquery row and "
                                    "erroneously retains both outer rows."
                                )
                            )
                        )

                        pred_helper = MissingPredicateAttackStrategy()
                        subq_literals = subq_parsed.get("where_literals", [])
                        injected_keys_upper = {(t.upper(), c.upper()) for t, c in value_injections.keys()}
                        for lit_idx, target_lit in enumerate(subq_literals):
                            target_col_info = resolve_query_column(
                                schema, subq_parsed, target_lit.get("table", ""), target_lit.get("column", "")
                            )
                            if (
                                target_col_info
                                and (target_col_info[0].upper(), target_col_info[1].upper()) in injected_keys_upper
                                and target_lit.get("operator", "EQ").upper() == "EQ"
                            ):
                                continue
                            violating_val = pred_helper._violating_value(schema, subq_parsed, target_lit)
                            modified_subq = copy.deepcopy(subq_parsed)
                            viol_injections = dict(value_injections)
                            if target_col_info and (target_lit.get("substr_start") is None or violating_val is None):
                                viol_injections[target_col_info] = violating_val
                            for idx_l, lit_l in enumerate(modified_subq.get("where_literals", [])):
                                if idx_l == lit_idx:
                                    if violating_val is None:
                                        lit_l["value"] = "NULL"
                                        lit_l["operator"] = "Is"
                                    else:
                                        lit_l["value"] = violating_val
                                        lit_l["operator"] = "EQ"
                                elif lit_l.get("value") != "NULL":
                                    lit_l["value"] = pred_helper._satisfying_value(lit_l)
                            viol_subq_data = generate_base_dataset(
                                schema,
                                modified_subq,
                                value_injections=viol_injections,
                                cache_key_salt=f"anti_join_not_in_viol_{len(datasets)}_{lit_idx}",
                            )
                            merged_viol = merge_datasets(schema, base_data, viol_subq_data)
                            datasets.append(
                                Dataset(
                                    strategy_name=f"{self.__class__.__name__}_not_in_pred_{target_lit.get('column', 'col')}_{lit_idx}",
                                    data=merged_viol,
                                    tags=["anti_join", "not_in", "missing_predicate_attack"],
                                    description=(
                                        f"Targets Internal Predicate mutations inside NOT IN on `{target_lit.get('column', 'col')}`. "
                                        f"Synthesizes a subquery row matching the outer join key and satisfying all other "
                                        f"subquery predicates while violating predicate {lit_idx + 1} (`{target_lit.get('column', 'col')}`)."
                                    ),
                                )
                            )
                    except Exception:
                        pass

        return datasets
