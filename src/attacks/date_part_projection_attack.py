"""
Date-part projection attack.

Algorithm & Dataset Design:
This attack walks the SQL AST and finds literal predicates whose compared
expression is a deterministic date-part extraction over exactly one query
column, currently SQLite STRFTIME(format, column). For each predicate, it
resolves the column through the query alias map and schema, then constructs a
valid timestamp from the predicate literal and the format string. The timestamp
is checked with SQLite against the original projected predicate before it is
used. For closed upper ranges and equalities, the generated timestamp is placed
at the end of the represented date part, e.g. year Y becomes
Y-12-31 23:59:59. This row satisfies predicates such as
STRFTIME('%Y', col) BETWEEN low AND high, while falsifying mutants that compare
the unprojected raw timestamp to a date-only interval ending at midnight. Other
parsed WHERE literals are preserved by the shared base-dataset generator, so the
row is admitted or rejected because of the date-part semantics rather than an
unrelated predicate.
"""

from dataclasses import dataclass
from calendar import monthrange
from datetime import time
from typing import Any
import sqlite3

import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column


@dataclass(frozen=True)
class DatePartPredicate:
    table_name: str
    column_name: str
    format_string: str
    operator: str
    low_value: str = None
    high_value: str = None
    value: str = None


class DatePartProjectionAttackStrategy(AttackStrategy):
    """
    Target semantic bug: a predicate compares a projected date part, such as
    STRFTIME('%Y', date_col), but a mutant compares the raw date/datetime value
    or otherwise changes the date-part projection.
    """

    _COMPARISON_TYPES = (exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE)

    def is_applicable(self, schema: Schema, parsed_query: dict[str, Any]) -> bool:
        return bool(self._find_predicates(schema, parsed_query))

    def generate(self, schema: Schema, parsed_query: dict[str, Any]) -> list[Dataset]:
        datasets = []
        for index, predicate in enumerate(self._find_predicates(schema, parsed_query)):
            injected_value = self._candidate_for_predicate(predicate)
            if injected_value is None:
                continue

            datasets.append(
                Dataset(
                    strategy_name=(
                        f"{self.__class__.__name__}_{predicate.column_name}_{index}"
                    ),
                    data=generate_base_dataset(
                        schema,
                        parsed_query,
                        value_injections={
                            (predicate.table_name, predicate.column_name): injected_value
                        },
                    ),
                    tags=["date_part_projection_attack"],
                    description=(
                        f"Targets Date Part Projection bug. The dataset forces `{predicate.table_name}.{predicate.column_name}` to have highly distinctive date components (e.g., different year, month, day, hour). "
                        f"This specifically verifies that extracting '{predicate.format_string}' returns the exact expected component, and effectively catches mutants that extract the wrong date part (e.g., month instead of year) or omit the extraction."
                    ),
                )
            )

        return datasets

    def _find_predicates(
        self, schema: Schema, parsed_query: dict[str, Any]
    ) -> list[DatePartPredicate]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        predicates = []
        where = parsed.args.get("where")
        if where is None:
            return predicates

        for between in where.find_all(exp.Between):
            extract = self._strftime_column_extract(between.this)
            if extract is None:
                continue
            low = between.args.get("low")
            high = between.args.get("high")
            if not isinstance(low, exp.Literal) or not isinstance(high, exp.Literal):
                continue
            predicate = self._build_between_predicate(
                schema, parsed_query, extract, low.name, high.name
            )
            if predicate:
                predicates.append(predicate)

        for comparison in where.find_all(self._COMPARISON_TYPES):
            predicate = self._build_comparison_predicate(
                schema, parsed_query, comparison
            )
            if predicate:
                predicates.append(predicate)

        return predicates

    def _build_between_predicate(
        self,
        schema: Schema,
        parsed_query: dict[str, Any],
        extract: tuple[str, exp.Column],
        low_value: str,
        high_value: str,
    ):
        format_string, column = extract
        resolved = resolve_query_column(
            schema, parsed_query, column.table, column.name
        )
        if resolved is None:
            return None
        table_name, column_name = resolved
        return DatePartPredicate(
            table_name=table_name,
            column_name=column_name,
            format_string=format_string,
            operator="BETWEEN",
            low_value=low_value,
            high_value=high_value,
        )

    def _build_comparison_predicate(
        self,
        schema: Schema,
        parsed_query: dict[str, Any],
        comparison: exp.Expression,
    ):
        left_extract = self._strftime_column_extract(comparison.left)
        right_extract = self._strftime_column_extract(comparison.right)

        if left_extract and isinstance(comparison.right, exp.Literal):
            extract = left_extract
            operator = comparison.__class__.__name__.upper()
            literal_value = comparison.right.name
        elif right_extract and isinstance(comparison.left, exp.Literal):
            extract = right_extract
            operator = self._invert_operator(comparison.__class__.__name__.upper())
            literal_value = comparison.left.name
        else:
            return None

        format_string, column = extract
        resolved = resolve_query_column(
            schema, parsed_query, column.table, column.name
        )
        if resolved is None:
            return None

        table_name, column_name = resolved
        return DatePartPredicate(
            table_name=table_name,
            column_name=column_name,
            format_string=format_string,
            operator=operator,
            value=literal_value,
        )

    def _strftime_column_extract(
        self, expression: exp.Expression
    ):
        if not isinstance(expression, exp.Anonymous):
            return None
        if expression.name.lower() != "strftime":
            return None

        args = list(expression.expressions)
        if len(args) < 2 or not isinstance(args[0], exp.Literal):
            return None
        columns = list(expression.find_all(exp.Column))
        if len(columns) != 1:
            return None
        return args[0].name, columns[0]

    def _candidate_for_predicate(self, predicate: DatePartPredicate):
        seed_values = self._seed_values_for_predicate(predicate)
        for seed_value in seed_values:
            candidate = self._timestamp_for_format(predicate.format_string, seed_value)
            if candidate and self._satisfies_predicate(predicate, candidate):
                return candidate
        return None

    def _seed_values_for_predicate(self, predicate: DatePartPredicate) -> list[str]:
        if predicate.operator == "BETWEEN":
            return [
                v for v in [predicate.high_value, predicate.low_value] if v is not None
            ]
        if predicate.value is None:
            return []

        value = predicate.value
        if predicate.operator in ("EQ", "GTE", "LTE"):
            return [value]

        numeric_value = self._parse_int(value)
        if numeric_value is None:
            return [value]
        if predicate.operator == "GT":
            return [str(numeric_value + 1)]
        if predicate.operator == "LT":
            return [str(numeric_value - 1)]
        if predicate.operator == "NEQ":
            return [str(numeric_value + 1)]
        return [value]

    def _timestamp_for_format(self, format_string: str, value: str):
        min_iso_year = 1
        end_of_day = time.max.replace(microsecond=0).isoformat()

        if format_string == "%Y":
            year = self._parse_int(value)
            if year is None:
                return None
            month = 12
            day = monthrange(year, month)[1]
            return f"{year:04d}-{month:02d}-{day:02d} {end_of_day}"

        if format_string == "%m":
            month = self._parse_int(value)
            if month is None or not 1 <= month <= 12:
                return None
            day = monthrange(min_iso_year, month)[1]
            return f"{min_iso_year:04d}-{month:02d}-{day:02d} {end_of_day}"

        if format_string == "%d":
            day = self._parse_int(value)
            if day is None:
                return None
            for month in range(1, 13):
                if 1 <= day <= monthrange(min_iso_year, month)[1]:
                    return f"{min_iso_year:04d}-{month:02d}-{day:02d} {end_of_day}"
            return None

        if format_string == "%Y-%m":
            parts = value.split("-")
            if len(parts) != 2:
                return None
            year = self._parse_int(parts[0])
            month = self._parse_int(parts[1])
            if year is None or month is None or not 1 <= month <= 12:
                return None
            day = monthrange(year, month)[1]
            return f"{year:04d}-{month:02d}-{day:02d} {end_of_day}"

        if format_string == "%Y-%m-%d":
            parts = value.split("-")
            if len(parts) != 3:
                return None
            year = self._parse_int(parts[0])
            month = self._parse_int(parts[1])
            day = self._parse_int(parts[2])
            if (
                year is None
                or month is None
                or day is None
                or not 1 <= month <= 12
                or day < 1
                or day > monthrange(year, month)[1]
            ):
                return None
            return f"{year:04d}-{month:02d}-{day:02d} {end_of_day}"

        return None

    def _satisfies_predicate(
        self, predicate: DatePartPredicate, candidate: str
    ) -> bool:
        extracted = self._evaluate_strftime(predicate.format_string, candidate)
        if extracted is None:
            return False

        if predicate.operator == "BETWEEN":
            return (
                predicate.low_value is not None
                and predicate.high_value is not None
                and predicate.low_value <= extracted <= predicate.high_value
            )
        if predicate.value is None:
            return False
        if predicate.operator == "EQ":
            return extracted == predicate.value
        if predicate.operator == "NEQ":
            return extracted != predicate.value
        if predicate.operator == "GT":
            return extracted > predicate.value
        if predicate.operator == "GTE":
            return extracted >= predicate.value
        if predicate.operator == "LT":
            return extracted < predicate.value
        if predicate.operator == "LTE":
            return extracted <= predicate.value
        return False

    def _evaluate_strftime(self, format_string: str, value: str):
        try:
            conn = sqlite3.connect(":memory:")
            result = conn.execute(
                "SELECT STRFTIME(?, ?)", (format_string, value)
            ).fetchone()
            conn.close()
        except sqlite3.Error:
            return None
        return result[0] if result else None

    def _parse_int(self, value: str):
        try:
            return int(value)
        except (TypeError, ValueError):
            return None

    def _invert_operator(self, operator: str) -> str:
        return {
            "GT": "LT",
            "GTE": "LTE",
            "LT": "GT",
            "LTE": "GTE",
        }.get(operator, operator)
