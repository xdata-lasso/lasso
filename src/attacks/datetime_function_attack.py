"""
DateTimeFunctionAttackStrategy

Algorithm & Dataset Design:
This attack strategy targets semantic bugs involving date/time functions and date/time comparisons
(e.g., DATE(col) vs col, TIME(col), DATETIME(col), STRFTIME, date function parameter mutations, etc.).

For date/time functions and date comparisons in SQL queries:
1. It walks the parsed query AST (WHERE, HAVING, JOIN ON) to find comparison predicates involving
   date/time functions or temporal columns.
2. For each date/time comparison predicate, it extracts the target column and the compared literal
   value or literal date function expression.
3. If a literal date/datetime value (e.g. '2014-09-01' or '2014-09-01 00:00:00') is found, it parses the
   base date D.
4. It generates 5 boundary-sensitive test dataset injections for the target column:
   - Offset 1: Mid-day timestamp on the literal date D ('YYYY-MM-DD 12:00:00'). This specifically
     distinguishes date truncation DATE(col) (which evaluates to 'YYYY-MM-DD') from raw datetime col
     (which is > 'YYYY-MM-DD 00:00:00').
   - Offset 2: One-second past midnight timestamp ('YYYY-MM-DD 00:00:01').
   - Offset 3: Exact midnight timestamp ('YYYY-MM-DD 00:00:00').
   - Offset 4: Mid-day timestamp on previous date D - 1 day ('(D-1) 12:00:00').
   - Offset 5: Mid-day timestamp on next date D + 1 day ('(D+1) 12:00:00').
5. If no literal date is present, it evaluates current boundary date and generates corresponding
   mid-day, midnight, and offset timestamps.
6. For temporal difference / elapsed-time / age predicates (such as `(JULIANDAY(ref) - JULIANDAY(col)) / 365`,
   `UNIXEPOCH` differences, or `STRFTIME('%Y', ref) - STRFTIME('%Y', col)` with or without month-day
   adjustments), it computes and injects 5 boundary dates around both the exact day-count threshold
   (`D_ref ± V * k_days`) and the calendar anniversary (`D_cal`), distinguishing 365-day division
   from leap-year-aware calendar age, unadjusted year subtraction, and strict vs non-strict inequalities.

This ensures all date truncation, interval, operator, and date-function mutations are killed deterministically.
"""

from datetime import date, datetime, timedelta
import re
import sqlite3
from typing import Any, Dict, List, Optional, Tuple

import sqlglot
import sqlglot.expressions as exp

from attacks.base import AttackStrategy
from dataset_generator import (
    compute_self_offset_values,
    compute_temporal_diff_values,
    extract_self_offset_patterns,
    extract_temporal_diff_patterns,
    generate_base_dataset,
    resolve_query_column,
)
from models import Dataset, Schema


class DateTimeFunctionAttackStrategy(AttackStrategy):
    """
    Target semantic bugs: Wrong date/time functions, date truncation vs raw datetime column,
    boundary comparisons, and date math interval mutations.
    """

    DATE_FUNC_TYPES = (
        exp.Date,
        exp.Time,
        exp.Datetime,
        exp.CurrentDate,
        exp.CurrentTime,
        exp.CurrentTimestamp,
        exp.Extract,
        exp.Year,
        exp.Month,
        exp.Day,
        exp.TimeToStr,
        exp.StrToTime,
        exp.TsOrDsToDate,
        exp.TsOrDsToTimestamp,
        exp.UnixToTime,
        exp.TimeToUnix,
    )

    DATE_FUNC_NAMES = {
        "date",
        "time",
        "datetime",
        "strftime",
        "julianday",
        "unixepoch",
        "to_date",
        "date_trunc",
        "curdate",
        "now",
    }

    def _datetime_string(self, value: datetime) -> str:
        return value.strftime("%Y-%m-%d %H:%M:%S")

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            return False

        # Check for explicit date/time function AST nodes
        for node in parsed.find_all(self.DATE_FUNC_TYPES):
            return True
        for node in parsed.find_all(exp.Anonymous):
            if node.name.lower() in self.DATE_FUNC_NAMES:
                return True

        # Check for literal date/datetime strings in comparisons
        for lit in parsed.find_all(exp.Literal):
            if lit.is_string and self._try_parse_date(lit.name):
                return True

        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            parsed = parsed_query.get("ast") or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        # Find target columns and candidate values
        # Index 0..4 maps to candidate 1..5
        injections_per_candidate: List[Dict[Tuple[str, str], str]] = [{} for _ in range(5)]
        targets_set: set[Tuple[str, str]] = set()

        def is_date_func_node(node: exp.Expression) -> bool:
            if isinstance(node, self.DATE_FUNC_TYPES):
                return True
            if isinstance(node, exp.Anonymous) and node.name.lower() in self.DATE_FUNC_NAMES:
                return True
            return False

        def get_literal_value(node: exp.Expression) -> Optional[str]:
            if isinstance(node, exp.Literal) and node.is_string:
                return node.name
            if is_date_func_node(node) and not list(node.find_all(exp.Column)):
                # Literal date function without columns (e.g. date('now', '-1 year'))
                func_sql = node.sql(dialect="sqlite")
                conn = sqlite3.connect(":memory:")
                try:
                    res = conn.execute(f"SELECT {func_sql};").fetchone()
                    if res and res[0] and isinstance(res[0], str):
                        return res[0]
                except Exception:
                    pass
                finally:
                    conn.close()
            return None

        def _is_temporal_column(table_name: str, col_name: str) -> bool:
            table = schema.tables.get(table_name)
            if not table:
                return False
            col = schema.find_column(table_name, col_name)
            if not col:
                return False
            dt = (col.data_type or "").upper()
            return any(k in dt for k in ["DATE", "TIME", "TIMESTAMP", "YEAR"])

        def is_date_target_column(table_name: str, col_name: str) -> bool:
            table = schema.tables.get(table_name)
            if not table:
                return False
            col = schema.find_column(table_name, col_name)
            if not col:
                return False
            dt = (col.data_type or "").upper()
            # Must be temporal or text/char column, never numeric (int/float/real)
            if _is_temporal_column(table_name, col_name):
                return True
            if any(k in dt for k in ["TEXT", "CHAR", "VARCHAR"]) or dt == "":
                return True
            return False

        # Process binary comparison predicates (WHERE, HAVING, JOIN)
        for comp in parsed.find_all((exp.EQ, exp.NEQ, exp.GT, exp.GTE, exp.LT, exp.LTE, exp.Between)):
            left_node = comp.left if hasattr(comp, "left") else getattr(comp, "this", None)
            right_node = comp.right if hasattr(comp, "right") else None

            left_has_date_func = is_date_func_node(left_node) if left_node else False
            right_has_date_func = is_date_func_node(right_node) if right_node else False

            left_cols = list(left_node.find_all(exp.Column)) if left_node else []
            right_cols = list(right_node.find_all(exp.Column)) if right_node else []

            left_lit_val = get_literal_value(left_node) if left_node else None
            right_lit_val = get_literal_value(right_node) if right_node else None

            left_date_parsed = self._try_parse_date(left_lit_val) if left_lit_val else None
            right_date_parsed = self._try_parse_date(right_lit_val) if right_lit_val else None

            left_temporal = any(
                _is_temporal_column(resolved[0], resolved[1])
                for col in left_cols
                if (resolved := resolve_query_column(schema, parsed_query, col.table, col.name))
            )
            right_temporal = any(
                _is_temporal_column(resolved[0], resolved[1])
                for col in right_cols
                if (resolved := resolve_query_column(schema, parsed_query, col.table, col.name))
            )

            # Predicate MUST involve a date function, date literal, or temporal column
            if not (left_has_date_func or right_has_date_func or left_date_parsed or right_date_parsed or left_temporal or right_temporal):
                continue

            lit_val = right_lit_val or left_lit_val
            col_list = left_cols + right_cols

            for col in col_list:
                resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                if not resolved:
                    continue

                table_name, column_name = resolved
                if not is_date_target_column(table_name, column_name):
                    continue

                targets_set.add((table_name, column_name))

                candidates = self._generate_candidates_for_literal(lit_val)
                for idx in range(5):
                    injections_per_candidate[idx][(table_name, column_name)] = candidates[idx]

        # Process temporal difference / age / duration predicates and projections (e.g. JULIANDAY diff vs STRFTIME diff)
        for pat in extract_temporal_diff_patterns(schema, parsed_query, parsed):
            t_name, c_name = pat["table"], pat["column"]
            if not is_date_target_column(t_name, c_name):
                continue
            targets_set.add((t_name, c_name))
            ref_t = pat.get("ref_table")
            ref_c = pat.get("ref_column")
            if ref_t and ref_c and is_date_target_column(ref_t, ref_c):
                targets_set.add((ref_t, ref_c))
            ref_date_str = pat["ref_dt"].strftime("%Y-%m-%d")
            diff_vals = compute_temporal_diff_values(schema, pat)
            candidates = diff_vals["attack_candidates"]
            for idx in range(min(5, len(candidates))):
                if ref_t and ref_c:
                    if (ref_t.upper(), ref_c.upper()) == (t_name.upper(), c_name.upper()):
                        injections_per_candidate[idx][(t_name, c_name)] = [ref_date_str, candidates[idx]]
                        continue
                    injections_per_candidate[idx][(ref_t, ref_c)] = ref_date_str
                injections_per_candidate[idx][(t_name, c_name)] = candidates[idx]

        # If no specific binary targets were found but date functions exist on columns
        if not targets_set:
            for node in parsed.find_all(self.DATE_FUNC_TYPES + (exp.Anonymous,)):
                if not is_date_func_node(node):
                    continue
                for col in node.find_all(exp.Column):
                    resolved = resolve_query_column(schema, parsed_query, col.table, col.name)
                    if not resolved:
                        continue
                    table_name, column_name = resolved
                    if not is_date_target_column(table_name, column_name):
                        continue
                    targets_set.add((table_name, column_name))
                    candidates = self._generate_candidates_for_literal(None)
                    for idx in range(5):
                        injections_per_candidate[idx][(table_name, column_name)] = candidates[idx]

        if not targets_set:
            return []

        cols_str = ", ".join(f"{t}.{c}" for t, c in targets_set)
        datasets = []

        descriptions = [
            f"Targets Datetime Function bugs. Inject mid-day timestamp ('YYYY-MM-DD 12:00:00') into {cols_str}. Tests date truncation (DATE(col) vs col) where time component > 00:00:00 causes unequal evaluation.",
            f"Targets Datetime Function bugs. Inject 1-second past midnight timestamp ('YYYY-MM-DD 00:00:01') into {cols_str}. Tests subtle boundary conditions around midnight.",
            f"Targets Datetime Function bugs. Inject exact midnight timestamp ('YYYY-MM-DD 00:00:00') into {cols_str}. Tests exact date/time equality boundaries.",
            f"Targets Datetime Function bugs. Inject previous day timestamp ('(D-1) 12:00:00') into {cols_str}. Tests lower boundary comparison operators.",
            f"Targets Datetime Function bugs. Inject next day timestamp ('(D+1) 12:00:00') into {cols_str}. Tests upper boundary comparison operators.",
        ]

        for idx in range(5):
            inj = injections_per_candidate[idx]
            if not inj:
                continue
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{idx + 1}",
                    data=generate_base_dataset(schema, parsed_query, value_injections=inj),
                    tags=["datetime_function_attack"],
                    description=descriptions[idx],
                )
            )

        for pat in extract_self_offset_patterns(schema, parsed_query, parsed):
            if not pat.get("date_func"):
                continue
            t_name, c_name = pat["table"], pat["column"]
            offset_vals = compute_self_offset_values(
                schema, t_name, c_name, pat["offset"], pat["date_func"]
            )
            if offset_vals.get("julian_date_pair"):
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_julian_offset",
                        data=generate_base_dataset(
                            schema, parsed_query, value_injections={(t_name, c_name): offset_vals["julian_date_pair"]}
                        ),
                        tags=["datetime_function_attack"],
                        description=(
                            f"Targets Datetime Function wrapping arithmetic offset on `{t_name}.{c_name}`. "
                            "Injects a Julian day number and its shifted ISO date string within the same group "
                            "to satisfy SQLite DATE(col ± offset) = col semantics."
                        ),
                    )
                )
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_numeric_offset",
                    data=generate_base_dataset(
                        schema, parsed_query, value_injections={(t_name, c_name): offset_vals["numeric_pair"]}
                    ),
                    tags=["datetime_function_attack"],
                    description=(
                        f"Targets Datetime Function vs raw arithmetic offset on `{t_name}.{c_name}`. "
                        "Injects consecutive numeric values within the same group to distinguish DATE(col ± offset) "
                        "from raw numeric (col ± offset)."
                    ),
                )
            )

        return datasets

    def _try_parse_date(self, val_str: str) -> Optional[date]:
        if not val_str or not isinstance(val_str, str):
            return None
        val_str = val_str.strip()
        # ISO / standard date formats
        for fmt in (
            "%Y-%m-%d %H:%M:%S",
            "%Y-%m-%d %H:%M:%S%z",
            "%Y-%m-%dT%H:%M:%S",
            "%Y-%m-%d",
        ):
            try:
                return datetime.strptime(val_str.split("+")[0].split(".")[0], fmt.replace("%z", "")).date()
            except ValueError:
                pass
        match = re.search(r"\b(\d{4})-(\d{2})-(\d{2})\b", val_str)
        if match:
            try:
                return date(int(match.group(1)), int(match.group(2)), int(match.group(3)))
            except ValueError:
                pass
        return None

    def _generate_candidates_for_literal(self, lit_val: Optional[str]) -> List[str]:
        base_d = self._try_parse_date(lit_val) if lit_val else None
        if not base_d:
            # Fallback to evaluated today's date from SQLite
            conn = sqlite3.connect(":memory:")
            try:
                today_str = conn.execute("SELECT DATE('now');").fetchone()[0]
                base_d = self._try_parse_date(today_str)
            except Exception:
                pass
            finally:
                conn.close()
        if not base_d:
            base_d = date(2024, 6, 15)

        d_str = base_d.strftime("%Y-%m-%d")
        prev_str = (base_d - timedelta(days=1)).strftime("%Y-%m-%d")
        next_str = (base_d + timedelta(days=1)).strftime("%Y-%m-%d")

        return [
            f"{d_str} 12:00:00",
            f"{d_str} 00:00:01",
            f"{d_str} 00:00:00",
            f"{prev_str} 12:00:00",
            f"{next_str} 12:00:00",
        ]
