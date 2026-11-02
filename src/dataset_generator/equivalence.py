"""
Phase 0: Equivalence Class Construction
=========================================

Determines which columns must share the same generated value domain by
unifying them through:
  1. Explicit JOIN ON pairs   (e.g. ``A.id = B.a_id``)
  2. Implicit WHERE joins     (e.g. ``WHERE A.id = B.a_id``)
  3. Foreign key declarations from the DDL schema
  4. Alias ↔ base-table column identity
  5. Set-operation (UNION/INTERSECT/EXCEPT) positional alignment

The result is a UnionFind structure where columns in the same equivalence
class will receive the same generated values, guaranteeing referential
consistency without post-hoc patching.
"""

from typing import Any, Dict, List, Tuple

import sqlglot.expressions as exp

from dataset_generator.types import SymbolTable, UnionFind, col_key
from models import Schema


def build_equivalence_classes(
    schema: Schema, parsed_query: Dict[str, Any], omit_aliases: List[str] = None
) -> Tuple[UnionFind, List[Tuple[str, str]], Dict[str, str]]:
    """
    Phase 0: Build the union-find equivalence structure and symbol table.
    """
    """
    Phase 0: Build the union-find equivalence structure.

    Unifies columns that must share the same value domain via:
      1. Explicit JOIN ON pairs  (e.g. ``A.id = B.a_id``)
      2. Implicit WHERE joins    (e.g. ``WHERE A.id = B.a_id``)
      3. Foreign key declarations from the DDL schema
      4. Alias ↔ base-table column identity
      5. Set-operation (UNION/INTERSECT/EXCEPT) positional alignment

    Also discovers all tables referenced by the query (including FK parent
    tables chased transitively) so that we know which tables need rows.

    Args:
        schema:        The relational schema (tables, columns, FKs, constraints).
        parsed_query:  Dict produced by the query parser (AST, joins, literals, etc.).
        omit_aliases:  Optional list of aliases whose tables should NOT get rows
                       (used by attack strategies that want to exclude subquery tables).

    Returns:
        equiv:          UnionFind mapping (alias, col) → equivalence class root.
        targets:        Ordered list of (alias, table_name) pairs to generate data for.
        alias_to_table: Dict mapping each alias → its resolved schema table name.
    """
    equiv = UnionFind()

    # ── Step 1: Discover all tables referenced in the query ──
    # Walk the AST to find Table nodes; fall back to parsed_query["tables"] dict.
    targets = []
    referenced = set()
    ast = parsed_query.get("ast")
    if ast:
        for t in ast.find_all(exp.Table):
            if t.name.upper() in ("DUAL",):
                continue

            curr = t
            inside_negated_subquery = False
            while curr.parent:
                p = curr.parent
                if isinstance(p, (exp.Exists, exp.In)) and p.parent and isinstance(p.parent, exp.Not):
                    inside_negated_subquery = True
                    break
                curr = p
            if inside_negated_subquery:
                continue

            alias = (t.alias or t.name).upper()
            t_name = t.name.upper()
            if schema.find_table(t_name):
                if (alias, t_name) not in targets:
                    targets.append((alias, t_name))
                referenced.add(t_name)
    if not targets:
        for t in parsed_query.get("tables", []):
            if t.get("name", "").upper() in ("DUAL",):
                continue
            alias = (t.get("alias") or t.get("name")).upper()
            targets.append((alias, t.get("name").upper()))
            referenced.add(t.get("name").upper())

    # ── Step 2: Transitively chase FK parent tables ──
    # If table A has FK → table B, and B is not yet in targets, add B.
    # Repeat until no new tables are discovered.
    added = True
    while added:
        added = False
        new_targets = []
        for _, table_name in targets:
            resolved = schema.find_table(table_name)
            if not resolved:
                continue
            for fk in schema.tables[resolved].foreign_keys:
                parent = fk.reference_table.upper()
                if parent not in referenced and not (omit_aliases and parent in omit_aliases):
                    new_targets.append((parent, parent))
                    referenced.add(parent)
                    added = True
        targets.extend(new_targets)

    # ── Step 3: Build the alias → table mapping & table counts ──
    alias_to_table: Dict[str, str] = {}
    table_counts: Dict[str, int] = {}
    for alias, table_name in targets:
        alias_to_table[alias] = table_name
        table_counts[table_name] = table_counts.get(table_name, 0) + 1

    def _resolve_alias(t: str, c: str) -> str:
        if t:
            return t
        for a, t_name in targets:
            st = schema.find_table(t_name)
            if st and schema.find_column(st, c):
                return a
        return t

    # Collect columns explicitly constrained to IS NULL in WHERE/HAVING so anti-join
    # LEFT JOINs (`LEFT JOIN R ON L.k = R.k WHERE R.k IS NULL`) do not unify `R.k`
    # with inner-joined or non-nullable `L.k` columns (or parent PKs).
    null_constrained_keys = set()
    for wl in parsed_query.get("where_literals", []):
        if wl.get("value") == "NULL" and wl.get("operator", "EQ").upper() in ("IS", "EQ", "IS NULL"):
            wt = _resolve_alias(wl.get("table", ""), wl.get("column", ""))
            if wt and wl.get("column"):
                null_constrained_keys.add(col_key(wt, wl["column"]))

    outer_on_pair_keys = set()
    for join in parsed_query.get("joins", []):
        j_type = (join.get("type") or "INNER").upper()
        if any(outer_kw in j_type for outer_kw in ("LEFT", "RIGHT", "FULL")):
            for pair in join.get("on_pairs", []):
                lt = _resolve_alias(pair["left"]["table"], pair["left"]["column"])
                rt = _resolve_alias(pair["right"]["table"], pair["right"]["column"])
                lk = col_key(lt, pair["left"]["column"])
                rk = col_key(rt, pair["right"]["column"])
                outer_on_pair_keys.add((lk, rk))
                outer_on_pair_keys.add((rk, lk))

    non_null_keys = set()
    for alias, table_name in targets:
        resolved = schema.find_table(table_name)
        if resolved:
            t_obj = schema.tables[resolved]
            pk_cols = [c for c in t_obj.columns if c.is_primary_key]
            for c in t_obj.columns:
                if getattr(c, "explicit_not_null", False) or (c.is_primary_key and len(pk_cols) == 1):
                    non_null_keys.add(col_key(alias, c.name))
    for pair in parsed_query.get("where_joins", []):
        lt = _resolve_alias(pair["left"]["table"], pair["left"]["column"])
        rt = _resolve_alias(pair["right"]["table"], pair["right"]["column"])
        lk = col_key(lt, pair["left"]["column"])
        rk = col_key(rt, pair["right"]["column"])
        if (lk, rk) not in outer_on_pair_keys:
            non_null_keys.add(lk)
            non_null_keys.add(rk)
    for join in parsed_query.get("joins", []):
        j_type = (join.get("type") or "INNER").upper()
        if not any(outer_kw in j_type for outer_kw in ("LEFT", "RIGHT", "FULL")):
            for pair in join.get("on_pairs", []):
                lt = _resolve_alias(pair["left"]["table"], pair["left"]["column"])
                rt = _resolve_alias(pair["right"]["table"], pair["right"]["column"])
                non_null_keys.add(col_key(lt, pair["left"]["column"]))
                non_null_keys.add(col_key(rt, pair["right"]["column"]))

    # ── Step 4: Unify columns linked by explicit JOIN ON clauses, NATURAL JOINs, and USING joins ──
    for join in parsed_query.get("joins", []):
        curr_alias = (join.get("alias") or join.get("table") or "").upper()
        curr_table = alias_to_table.get(curr_alias, curr_alias)
        curr_t_obj = schema.find_table(curr_table)
        j_type = (join.get("type") or "INNER").upper()
        is_outer_join = any(outer_kw in j_type for outer_kw in ("LEFT", "RIGHT", "FULL"))

        if join.get("is_natural") and curr_t_obj:
            curr_idx = next((idx for idx, (a, _) in enumerate(targets) if a.upper() == curr_alias), -1)
            preceding = targets[:curr_idx] if curr_idx > 0 else [(a, alias_to_table.get(a, a)) for a, _ in targets if a.upper() != curr_alias]

            for prev_alias, prev_table in preceding:
                prev_t_obj = schema.find_table(prev_table)
                if not prev_t_obj:
                    continue
                for col in schema.tables[curr_t_obj].columns:
                    if schema.find_column(prev_t_obj, col.name):
                        left = col_key(prev_alias, col.name)
                        right = col_key(curr_alias, col.name)
                        equiv.union(left, right)
                        pair = {
                            "left": {"table": prev_alias, "column": col.name},
                            "right": {"table": curr_alias, "column": col.name}
                        }
                        if pair not in join.get("on_pairs", []):
                            join.setdefault("on_pairs", []).append(pair)

        elif join.get("using_cols") and curr_t_obj:
            curr_idx = next((idx for idx, (a, _) in enumerate(targets) if a.upper() == curr_alias), -1)
            preceding = targets[:curr_idx] if curr_idx > 0 else [(a, alias_to_table.get(a, a)) for a, _ in targets if a.upper() != curr_alias]
            for c_name in join["using_cols"]:
                for prev_alias, prev_table in reversed(preceding):
                    prev_t_obj = schema.find_table(prev_table)
                    if prev_t_obj and schema.find_column(prev_t_obj, c_name):
                        left = col_key(prev_alias, c_name)
                        right = col_key(curr_alias, c_name)
                        equiv.union(left, right)
                        pair = {
                            "left": {"table": prev_alias, "column": c_name},
                            "right": {"table": curr_alias, "column": c_name}
                        }
                        if pair not in join.get("on_pairs", []):
                            join.setdefault("on_pairs", []).append(pair)
                        break

        for pair in join.get("on_pairs", []):
            lt = _resolve_alias(pair["left"]["table"], pair["left"]["column"])
            rt = _resolve_alias(pair["right"]["table"], pair["right"]["column"])
            left = col_key(lt, pair["left"]["column"])
            right = col_key(rt, pair["right"]["column"])
            if is_outer_join and null_constrained_keys and non_null_keys:
                null_roots = {equiv.find(nk) for nk in null_constrained_keys}
                non_null_roots = {equiv.find(nnk) for nnk in non_null_keys}
                l_root = equiv.find(left)
                r_root = equiv.find(right)
                if (l_root in null_roots and r_root in non_null_roots) or (
                    r_root in null_roots and l_root in non_null_roots
                ):
                    continue
            equiv.union(left, right)

    # ── Step 5: Unify columns linked by implicit WHERE equality joins ──
    # e.g. WHERE a.id = b.id (no explicit JOIN keyword)
    for pair in parsed_query.get("where_joins", []):
        lt = _resolve_alias(pair["left"]["table"], pair["left"]["column"])
        rt = _resolve_alias(pair["right"]["table"], pair["right"]["column"])
        left = col_key(lt, pair["left"]["column"])
        right = col_key(rt, pair["right"]["column"])
        if (left, right) in outer_on_pair_keys and null_constrained_keys and non_null_keys:
            null_roots = {equiv.find(nk) for nk in null_constrained_keys}
            non_null_roots = {equiv.find(nnk) for nnk in non_null_keys}
            l_root = equiv.find(left)
            r_root = equiv.find(right)
            if (l_root in null_roots and r_root in non_null_roots) or (
                r_root in null_roots and l_root in non_null_roots
            ):
                continue
        equiv.union(left, right)

    # ── Step 6: Unify FK column pairs from the DDL schema ──
    # e.g. orders.customer_id FK → customers.id → same equivalence class.
    # When a table declares multiple foreign keys referencing the same parent column
    # (e.g. edge/relationship tables like connected(atom_id, atom_id2) -> atom(atom_id)),
    # unify at most one FK column with the parent column so distinct sibling FK columns
    # of the same table are not falsely equated into self-loops.
    literal_constrained_cols = set()
    for wl in parsed_query.get("where_literals", []):
        if wl.get("column"):
            wt = _resolve_alias(wl.get("table", ""), wl["column"])
            literal_constrained_cols.add(col_key(wt, wl["column"]))
            literal_constrained_cols.add(("", wl["column"].upper()))

    query_referenced_cols = set(literal_constrained_cols)
    for gb in parsed_query.get("group_by", []):
        if gb.get("column"):
            gt = _resolve_alias(gb.get("table", ""), gb["column"])
            query_referenced_cols.add(col_key(gt, gb["column"]))
            query_referenced_cols.add(("", gb["column"].upper()))
    strict_ineq_pairs = set()
    if ast:
        for col_node in ast.find_all(exp.Column):
            if col_node.name:
                ct = _resolve_alias(col_node.table or "", col_node.name)
                query_referenced_cols.add(col_key(ct, col_node.name))
                query_referenced_cols.add(("", col_node.name.upper()))
        for comp in ast.find_all((exp.NEQ, exp.LT, exp.GT)):
            if isinstance(comp.left, exp.Column) and isinstance(comp.right, exp.Column):
                curr_p = comp
                in_neg = False
                not_cnt = 0
                while curr_p.parent:
                    if isinstance(curr_p.parent, exp.Not):
                        not_cnt += 1
                    if (
                        isinstance(curr_p.parent, exp.Exists)
                        and curr_p.parent.parent
                        and isinstance(curr_p.parent.parent, exp.Not)
                    ):
                        in_neg = True
                        break
                    curr_p = curr_p.parent
                if in_neg or (not_cnt % 2 == 1):
                    continue
                lt_a = _resolve_alias(comp.left.table or "", comp.left.name)
                rt_a = _resolve_alias(comp.right.table or "", comp.right.name)
                if lt_a and rt_a:
                    lk = col_key(lt_a, comp.left.name)
                    rk = col_key(rt_a, comp.right.name)
                    if lk != rk:
                        strict_ineq_pairs.add((lk, rk))
                        strict_ineq_pairs.add((rk, lk))

    for alias, table_name in targets:
        resolved = schema.find_table(table_name)
        if resolved:
            same_table_aliases = [a for a, t in targets if t.upper() == resolved.upper()]
            fks_sorted = sorted(
                enumerate(schema.tables[resolved].foreign_keys),
                key=lambda item: (
                    0 if (
                        col_key(alias, item[1].column_name) in literal_constrained_cols
                        or ("", item[1].column_name.upper()) in literal_constrained_cols
                    ) else (
                        1 if (
                            col_key(alias, item[1].column_name) in query_referenced_cols
                            or ("", item[1].column_name.upper()) in query_referenced_cols
                        ) else 2
                    ),
                    item[0],
                ),
            )
            for _, fk in fks_sorted:
                fk_ck = col_key(alias, fk.column_name)
                if null_constrained_keys and equiv.find(fk_ck) in {equiv.find(nk) for nk in null_constrained_keys}:
                    continue
                ref_t = schema.find_table(fk.reference_table)
                if ref_t:
                    matching_aliases = [a for a, t in targets if t.upper() == ref_t.upper()]
                    ref_ck = None
                    if len(matching_aliases) == 1:
                        ref_ck = col_key(matching_aliases[0], fk.reference_column)
                    elif len(matching_aliases) > 1:
                        ref_roots = {equiv.find(col_key(a, fk.reference_column)) for a in matching_aliases}
                        if len(ref_roots) == 1:
                            ref_ck = col_key(matching_aliases[0], fk.reference_column)
                    if ref_ck is not None:
                        ref_root = equiv.find(ref_ck)
                        has_sibling_col_in_root = any(
                            c.name.upper() != fk.column_name.upper()
                            and equiv.find(col_key(sib_a, c.name)) == ref_root
                            for sib_a in same_table_aliases
                            for c in schema.tables[resolved].columns
                        )
                        if has_sibling_col_in_root:
                            continue
                        fk_root = equiv.find(fk_ck)
                        has_ineq_conflict = any(
                            (equiv.find(k1) == fk_root and equiv.find(k2) == ref_root)
                            or (equiv.find(k2) == fk_root and equiv.find(k1) == ref_root)
                            for k1, k2 in strict_ineq_pairs
                        )
                        if has_ineq_conflict:
                            continue
                        equiv.union(fk_ck, ref_ck)

    # ── Step 7: Unify alias ↔ base-table columns ──
    # If alias "E" refers to table "EMPLOYEES", then (E, NAME) ≡ (EMPLOYEES, NAME).
    # When multiple aliases of the same table are equated on the table's PRIMARY KEY
    # (functional dependency PK -> all columns), unify non-conflicting columns across
    # those PK-equated aliases so constraints on a second alias are not lost when
    # duplicate PK rows are deduplicated during materialization.
    for t_name, cnt in table_counts.items():
        if cnt <= 1:
            continue
        resolved = schema.find_table(t_name)
        if not resolved:
            continue
        pk_cols = [c for c in schema.tables[resolved].columns if c.is_primary_key]
        if not pk_cols:
            continue
        all_aliases = [a for a, tn in targets if tn == t_name]
        for idx_a, a1 in enumerate(all_aliases):
            for a2 in all_aliases[idx_a + 1 :]:
                if all(
                    equiv.find(col_key(a1, pk.name)) == equiv.find(col_key(a2, pk.name))
                    for pk in pk_cols
                ):
                    for c in schema.tables[resolved].columns:
                        if c.is_primary_key:
                            continue
                        k1 = col_key(a1, c.name)
                        k2 = col_key(a2, c.name)
                        if (k1, k2) in strict_ineq_pairs:
                            continue
                        if k1 in literal_constrained_cols and k2 in literal_constrained_cols:
                            continue
                        equiv.union(k1, k2)

    for alias, t_name in targets:
        resolved = schema.find_table(t_name)
        if resolved:
            if table_counts.get(t_name, 0) == 1:
                for c in schema.tables[resolved].columns:
                    equiv.union(col_key(alias, c.name), col_key(resolved, c.name))
            else:
                all_aliases = [a for a, tn in targets if tn == t_name]
                for c in schema.tables[resolved].columns:
                    roots = {equiv.find(col_key(a, c.name)) for a in all_aliases}
                    if len(roots) == 1:
                        equiv.union(col_key(alias, c.name), col_key(resolved, c.name))

    # ── Step 8: Set operations — unify positional projection columns ──
    # In UNION/INTERSECT/EXCEPT, the i-th column of the left SELECT is
    # positionally aligned with the i-th column of the right SELECT.
    ast = parsed_query.get("ast")
    if ast:
        for set_op in ast.find_all((exp.Union, exp.Intersect, exp.Except)):
            left_sel = set_op.this if isinstance(set_op.this, exp.Select) else (set_op.this.find(exp.Select) if hasattr(set_op.this, 'find') else None)
            right_sel = set_op.expression if isinstance(set_op.expression, exp.Select) else (set_op.expression.find(exp.Select) if hasattr(set_op.expression, 'find') else None)
            if left_sel and right_sel and hasattr(left_sel, "selects") and hasattr(right_sel, "selects"):
                for l_expr, r_expr in zip(left_sel.selects, right_sel.selects):
                    l_col = l_expr.find(exp.Column)
                    r_col = r_expr.find(exp.Column)
                    if l_col and r_col:
                        left_t = l_col.table or (left_sel.find(exp.Table).alias_or_name if left_sel.find(exp.Table) else "")
                        right_t = r_col.table or (right_sel.find(exp.Table).alias_or_name if right_sel.find(exp.Table) else "")
                        equiv.union(col_key(left_t, l_col.name), col_key(right_t, r_col.name))

    if not alias_to_table:
        for t_name in schema.tables:
            alias_to_table[t_name] = t_name

    # ── Step 9: Pre-compute SymbolTable for O(1) column lookups ──
    symbol_table = SymbolTable(alias_to_table)
    for alias, t_name in targets:
        resolved = schema.find_table(t_name)
        if resolved:
            for c in schema.tables[resolved].columns:
                symbol_table.put(col_key(alias, c.name), (resolved, c.name))
                symbol_table.put(col_key(resolved, c.name), (resolved, c.name))

    equiv.symbol_table = symbol_table

    return equiv, targets, alias_to_table
