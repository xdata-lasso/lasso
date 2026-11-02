"""
NullHandlingAttackStrategy Module

Target semantic bug: Incorrect handling of NULL values in explicit NULL predicates
(IS NULL vs IS NOT NULL), COALESCE/IFNULL fallbacks, and comparison/filter predicates
under SQL Three-Valued Logic (3VL).
Algorithm & Dataset Design:
1. For columns in explicit IS NULL / IS NOT NULL predicates, injects NULL into the target
   nullable column (including SQLite-nullable composite PRIMARY KEY columns without explicit
   NOT NULL constraints) so missing or inverted null checks are refuted.
2. For nullable columns participating in WHERE, HAVING, or JOIN ON value/comparison/COALESCE
   predicates (including inside NOT IN / NOT EXISTS subqueries), combines a baseline satisfying
   row with a row where the predicate column is NULL. Under SQL 3VL, comparisons on NULL
   evaluate to UNKNOWN (falsy in WHERE/ON): positive filters reject the NULL row, whereas
   mutants wrapping the column in COALESCE or using negated subqueries retain the tuple.
"""

from typing import Any, Dict, List
import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, merge_datasets, resolve_query_column


class NullHandlingAttackStrategy(AttackStrategy):
    """
    Target semantic bug: incorrect handling of explicit NULL predicates, COALESCE fallbacks,
    and three-valued logic (3VL) comparison predicates on nullable columns.

    Algorithm & Dataset Design:
    1. Explicit NULL checks: Inspects the query AST for columns in IS NULL / IS NOT NULL
       predicates and generates a dataset where that column is NULL.
    2. Predicate 3VL NULLs: Identifies nullable columns (including SQLite-nullable composite
       or non-INTEGER PRIMARY KEY columns not referenced by foreign keys) referenced in
       WHERE/HAVING/JOIN ON comparison or COALESCE predicates. Generates a dataset merging a
       baseline satisfying tuple with a tuple where the target column is NULL. Because both
       P(NULL) and NOT P(NULL) evaluate to UNKNOWN in 3VL, positive filters reject the NULL
       tuple while COALESCE fallbacks and negated subqueries fail to exclude it.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(
            self._targets(schema, parsed_query)
            or self._predicate_null_targets(schema, parsed_query)
        )

    def _can_null_column(self, schema: Schema, table_name: str, column: Any) -> bool:
        if not column or getattr(column, "explicit_not_null", False):
            return False
        table = schema.tables.get(table_name)
        if not table:
            return False
        pk_cols = [c for c in table.columns if c.is_primary_key]
        if (
            column.is_primary_key
            and len(pk_cols) == 1
            and "int" in (column.data_type or "").lower()
        ):
            return False
        if not column.is_nullable and not column.is_primary_key:
            return False
        for t_obj in schema.tables.values():
            for fk in t_obj.foreign_keys:
                if (
                    fk.reference_table.upper() == table_name.upper()
                    and fk.reference_column.upper() == column.name.upper()
                ):
                    return False
        return True

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        targets = []
        for is_expr in ast.find_all(exp.Is):
            if not isinstance(is_expr.expression, exp.Null):
                continue
            if not isinstance(is_expr.this, exp.Column):
                continue
            resolved = resolve_query_column(schema, parsed_query, is_expr.this.table, is_expr.this.name)
            if not resolved:
                continue
            table_name, column_name = resolved
            column = next(c for c in schema.tables[table_name].columns if c.name == column_name)
            if self._can_null_column(schema, table_name, column) and resolved not in targets:
                targets.append(resolved)
        return targets

    def _predicate_null_targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str]]:
        explicit_targets = set(self._targets(schema, parsed_query))
        targets: list[tuple[str, str]] = []

        for lit in parsed_query.get("where_literals", []):
            if lit.get("value") == "NULL" or lit.get("operator", "").upper() in ("IS", "IS NOT", "IS NULL", "IS NOT NULL"):
                continue
            col_name = lit.get("column", "")
            if not col_name:
                continue
            resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), col_name)
            if not resolved or resolved in explicit_targets or resolved in targets:
                continue
            table_name, column_name = resolved
            column = schema.find_column(table_name, column_name)
            if self._can_null_column(schema, table_name, column):
                targets.append(resolved)

        ast = parsed_query.get("ast")
        if ast:
            clauses = list(ast.find_all((exp.Where, exp.Having))) + [
                j.args.get("on") for j in ast.find_all(exp.Join) if j.args.get("on")
            ]
            for clause in clauses:
                for comp in clause.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.NEQ, exp.Between, exp.Like, exp.ILike, exp.Coalesce)):
                    for col_node in comp.find_all(exp.Column):
                        resolved = resolve_query_column(schema, parsed_query, col_node.table, col_node.name)
                        if not resolved or resolved in explicit_targets or resolved in targets:
                            continue
                        table_name, column_name = resolved
                        column = schema.find_column(table_name, column_name)
                        if self._can_null_column(schema, table_name, column):
                            targets.append(resolved)

        return targets

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        for table_name, column_name in self._targets(schema, parsed_query):
            modified_query = dict(parsed_query)
            modified_query["where_literals"] = [dict(literal) for literal in parsed_query.get("where_literals", [])]
            for literal in modified_query["where_literals"]:
                if literal.get("is_length_expr"):
                    continue
                value = literal["value"]
                operator = literal.get("operator", "EQ")
                is_numeric = isinstance(value, (int, float)) or (
                    isinstance(value, str) and value.lstrip("-").replace(".", "", 1).isdigit()
                )
                if not is_numeric:
                    continue
                number = float(value)
                if number.is_integer():
                    number = int(number)
                if operator == "GT":
                    literal["value"] = number + 1
                elif operator == "LT":
                    literal["value"] = number - 1

            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}",
                    data=generate_base_dataset(schema, modified_query, null_injections=[(table_name, column_name)]),
                    tags=["null_attack"],
                    description=f"Targets Explicit NULL Predicate bugs. Dataset explicitly sets `{table_name}.{column_name}` to NULL. This verifies that `IS NULL` or `IS NOT NULL` predicates are strictly enforced. A mutant that incorrectly uses `= NULL` or `<> NULL` will evaluate to UNKNOWN and fail to filter correctly."
                )
            )

        pred_targets = self._predicate_null_targets(schema, parsed_query)
        if pred_targets:
            base_data = generate_base_dataset(schema, parsed_query, cache_key_salt="null_pred_base")
            for table_name, column_name in pred_targets:
                null_data = generate_base_dataset(
                    schema,
                    parsed_query,
                    null_injections=[(table_name, column_name)],
                    cache_key_salt=f"null_pred_{table_name}_{column_name}",
                )
                merged_data = merge_datasets(schema, base_data, null_data)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_predicate_{table_name}_{column_name}",
                        data=merged_data,
                        tags=["null_attack"],
                        description=(
                            f"Targets Three-Valued Logic (3VL) NULL Predicate bugs on `{table_name}.{column_name}`. "
                            f"Combines a baseline satisfying row with a row where `{table_name}.{column_name}` is NULL. "
                            f"In SQL 3VL, comparisons with NULL evaluate to UNKNOWN, which filters out rows in positive "
                            f"WHERE clauses but fails to trigger exclusion in negated subqueries (NOT IN / NOT EXISTS)."
                        ),
                    )
                )

        return datasets
