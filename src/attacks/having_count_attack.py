"""
HavingCountAttackStrategy Module

Target semantic feature:
HAVING thresholds over COUNT(column) or COUNT(DISTINCT column).

Algorithm & Dataset Design:
1. Locate HAVING predicates comparing COUNT(...) or COUNT(DISTINCT ...) with an integer literal.
2. Generate base joined rows satisfying FROM/WHERE constraints.
3. Duplicate the table containing the counted column (with distinct values for the counted column if unconstrained) to hit exact count thresholds.
4. Construct satisfying threshold datasets, null-injected datasets, and boundary datasets (threshold - 1) to expose threshold and operator mutations.
"""

from typing import Any, Dict, List
import copy

import sqlglot
import sqlglot.expressions as exp

from models import Schema, Dataset
from dataset_generator.value_generator import DataFactory
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column, next_distinct_value
from dataset_generator.value_generator import generate_unique_id_for_column, generate_unique_string_for_column


class HavingCountAttackStrategy(AttackStrategy):
    """
    Target semantic feature: HAVING thresholds over COUNT(column) or COUNT(DISTINCT column).

    Algorithm & Dataset Design:
    The strategy finds HAVING predicates comparing COUNT(...) or COUNT(DISTINCT ...) with an integer literal.
    It generates one base joined row satisfying the query's FROM/WHERE relationships, then duplicates the
    table containing the counted column enough times (with distinct values for the counted column if not constrained)
    to satisfy the COUNT threshold while preserving all join keys. Primary keys are regenerated so the rows
    can coexist. It generates exact satisfying threshold datasets, null-injected datasets, and boundary datasets
    (one row short of the threshold) to kill operator and threshold mutations.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        return bool(self._targets(schema, parsed_query))

    def _extract_count_info(self, count_node: exp.Count) -> tuple[exp.Expression | None, bool]:
        is_distinct = False
        arg = count_node.this
        if isinstance(arg, exp.Distinct):
            is_distinct = True
            exprs = arg.expressions if hasattr(arg, "expressions") and arg.expressions else ([arg.this] if arg.this else [])
            arg = exprs[0] if exprs else None
        elif count_node.args.get("distinct"):
            is_distinct = True
        return arg, is_distinct

    def _targets(self, schema: Schema, parsed_query: Dict[str, Any]) -> list[tuple[str, str, int, bool]]:
        raw_query = parsed_query.get("raw_query", "")
        try:
            ast = parsed_query.get('ast') or sqlglot.parse_one(raw_query)
        except Exception:
            return []

        having = ast.args.get("having")
        if not having:
            return []

        targets = []
        for predicate in having.find_all((exp.GT, exp.GTE, exp.LT, exp.LTE, exp.EQ)):
            count_node = None
            literal = None
            op = predicate.__class__

            if isinstance(predicate.left, exp.Count) and isinstance(predicate.right, exp.Literal):
                count_node = predicate.left
                literal = predicate.right
                if op == exp.GT:
                    required = int(float(literal.name)) + 1
                elif op in (exp.GTE, exp.EQ):
                    required = int(float(literal.name))
                elif op == exp.LT:
                    required = max(1, int(float(literal.name)) - 1)
                elif op == exp.LTE:
                    required = int(float(literal.name))
            elif isinstance(predicate.right, exp.Count) and isinstance(predicate.left, exp.Literal):
                count_node = predicate.right
                literal = predicate.left
                if op == exp.LT:
                    required = int(float(literal.name)) + 1
                elif op in (exp.LTE, exp.EQ):
                    required = int(float(literal.name))
                elif op == exp.GT:
                    required = max(1, int(float(literal.name)) - 1)
                elif op == exp.GTE:
                    required = int(float(literal.name))

            if not count_node or not literal or literal.is_string:
                continue

            arg, is_distinct = self._extract_count_info(count_node)
            if not arg:
                continue

            if isinstance(arg, exp.Star):
                for table_info in parsed_query.get("tables", []):
                    c_name = schema.find_table(table_info["name"]) or table_info["name"]
                    targets.append((c_name, "*", required, is_distinct))
                continue

            if not isinstance(arg, exp.Column):
                continue

            resolved = resolve_query_column(schema, parsed_query, arg.table, arg.name)
            if not resolved:
                continue
            c_name = schema.find_table(resolved[0]) or resolved[0]
            targets.append((c_name, resolved[1], required, is_distinct))
        return targets

    def _duplicate_single_row(
        self,
        base_row: dict[str, Any],
        table,
        table_name: str,
        group_by_cols: set[tuple[str, str]],
        col_obj,
        column_name: str,
        curr_val: Any,
        eq_constrained_cols: set[tuple[str, str]],
        schema: Schema,
    ) -> tuple[dict[str, Any], Any]:
        duplicate_row = copy.deepcopy(base_row)
        for column in table.columns:
            if column.is_primary_key or column.is_unique:
                if (table_name, column.name) in group_by_cols:
                    continue
                if "char" in (column.data_type or "").lower() or "text" in (column.data_type or "").lower():
                    duplicate_row[column.name] = generate_unique_string_for_column(column)
                else:
                    duplicate_row[column.name] = generate_unique_id_for_column(column)
        if col_obj and not (col_obj.is_primary_key or col_obj.is_unique):
            if (table_name, column_name) not in eq_constrained_cols:
                new_val = next_distinct_value(col_obj, curr_val, schema=schema, table_name=table_name)
                duplicate_row[column_name] = new_val
                curr_val = new_val
        return duplicate_row, curr_val

    def _build_group_dataset(
        self,
        base_data: Dict[str, List[Dict[str, Any]]],
        table_name: str,
        target_rows: List[Dict[str, Any]],
    ) -> Dict[str, List[Dict[str, Any]]]:
        """
        Assemble a dataset with `target_rows` for `table_name` and a single
        matching row for joined tables so that join multiplicity does not
        inflate the target HAVING COUNT group size.
        """
        mock_data: Dict[str, List[Dict[str, Any]]] = {}
        for t_name, rows in base_data.items():
            if t_name == table_name:
                mock_data[t_name] = target_rows
            else:
                mock_data[t_name] = [copy.deepcopy(rows[0])] if rows else []
        return mock_data

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets = []
        group_by_cols = set()
        for entry in parsed_query.get("group_by", []):
            resolved = resolve_query_column(schema, parsed_query, entry.get("table", ""), entry["column"])
            if resolved:
                group_by_cols.add((schema.find_table(resolved[0]) or resolved[0], resolved[1]))

        for target in self._targets(schema, parsed_query):
            table_name, column_name, required_count = target[:3]
            table_name = schema.find_table(table_name) or table_name
            is_distinct = target[3] if len(target) > 3 else False

            if required_count <= 1:
                continue

            base_data = generate_base_dataset(schema, parsed_query)
            if not base_data.get(table_name):
                continue

            table = schema.tables[table_name]
            base_row = base_data[table_name][0]
            col_obj = next((c for c in table.columns if c.name == column_name), None) if column_name != "*" else None

            where_cols = set()
            eq_constrained_cols = set()
            for literal in parsed_query.get("where_literals", []):
                resolved = resolve_query_column(schema, parsed_query, literal.get("table", ""), literal["column"])
                if resolved:
                    where_cols.add(resolved)
                    if literal.get("operator") in ("EQ", "In"):
                        eq_constrained_cols.add(resolved)

            # Clear faker uniqueness state for dataset independence
            DataFactory.get_instance().clear_uniqueness()

            # 1. Satisfying dataset
            rows_satisfy = [base_row]
            curr_val = base_row.get(column_name) if col_obj else None
            for _ in range(required_count - 1):
                duplicate_row, curr_val = self._duplicate_single_row(
                    base_row, table, table_name, group_by_cols, col_obj,
                    column_name, curr_val, eq_constrained_cols, schema
                )
                rows_satisfy.append(duplicate_row)

            mock_data_satisfy = self._build_group_dataset(base_data, table_name, rows_satisfy)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_{table_name}_{column_name}_{required_count}",
                    data=mock_data_satisfy,
                    tags=["having_count_attack"],
                    description=f"Targets HAVING COUNT bugs. Dataset includes exactly {required_count} matching rows for table `{table_name}`. This forms a tight boundary condition (e.g. exactly equaling the threshold) to satisfy the COUNT-based HAVING clause. Mutants that alter the condition (like modifying >= to > or increasing threshold) will incorrectly filter this group out."
                )
            )

            # 2. Satisfying dataset with NULLs
            DataFactory.get_instance().clear_uniqueness()
            base_row_nulls = copy.deepcopy(base_row)
            for column in table.columns:
                if column.is_nullable and not column.is_primary_key and not column.is_unique:
                    if (table_name, column.name) not in where_cols:
                        base_row_nulls[column.name] = None

            rows_satisfy_nulls = [base_row_nulls]
            curr_val_n = base_row_nulls.get(column_name) if col_obj else None
            for _ in range(required_count - 1):
                duplicate_row, curr_val_n = self._duplicate_single_row(
                    base_row_nulls, table, table_name, group_by_cols, col_obj,
                    column_name, curr_val_n, eq_constrained_cols, schema
                )
                rows_satisfy_nulls.append(duplicate_row)

            mock_data_satisfy_nulls = self._build_group_dataset(base_data, table_name, rows_satisfy_nulls)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_nulls_{table_name}_{column_name}_{required_count}",
                    data=mock_data_satisfy_nulls,
                    tags=["having_count_attack", "null_attack"],
                    description=f"Targets HAVING COUNT bugs. Dataset has exactly {required_count} matching rows for table `{table_name}`, but with NULL values deliberately injected into its nullable columns. This ensures the group satisfies a `COUNT(*)` threshold, but will fail a `COUNT(column)` check, effectively distinguishing `COUNT(*)` from `COUNT(column)` mutations."
                )
            )

            # 3. Boundary dataset
            if required_count - 1 >= 1:
                DataFactory.get_instance().clear_uniqueness()
                rows_boundary = [base_row]
                curr_val_b = base_row.get(column_name) if col_obj else None
                for _ in range(required_count - 2):
                    duplicate_row, curr_val_b = self._duplicate_single_row(
                        base_row, table, table_name, group_by_cols, col_obj,
                        column_name, curr_val_b, eq_constrained_cols, schema
                    )
                    rows_boundary.append(duplicate_row)

                mock_data_boundary = self._build_group_dataset(base_data, table_name, rows_boundary)
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_boundary_{table_name}_{column_name}_{required_count-1}",
                        data=mock_data_boundary,
                        tags=["having_count_attack"],
                        description=f"Targets HAVING COUNT bugs. Dataset contains exactly {required_count - 1} rows for table `{table_name}`, intentionally falling one row short of the threshold. The correct query's HAVING clause will correctly filter this group out, whereas a mutant that incorrectly lowers the threshold or removes the HAVING clause will erroneously return it."
                    )
                )

            # 4. Upper boundary dataset (exceeding threshold by 1 row)
            DataFactory.get_instance().clear_uniqueness()
            rows_upper = [base_row]
            curr_val_u = base_row.get(column_name) if col_obj else None
            for _ in range(required_count):
                duplicate_row, curr_val_u = self._duplicate_single_row(
                    base_row, table, table_name, group_by_cols, col_obj,
                    column_name, curr_val_u, eq_constrained_cols, schema
                )
                rows_upper.append(duplicate_row)

            mock_data_upper = self._build_group_dataset(base_data, table_name, rows_upper)
            datasets.append(
                Dataset(
                    strategy_name=f"{self.__class__.__name__}_upper_boundary_{table_name}_{column_name}_{required_count+1}",
                    data=mock_data_upper,
                    tags=["having_count_attack"],
                    description=f"Targets HAVING COUNT equality vs inequality bugs. Dataset contains exactly {required_count + 1} rows for table `{table_name}`, exceeding the threshold. A correct query with `COUNT(...) = {required_count}` will filter this group out, whereas a mutant with `COUNT(...) >= {required_count}` will erroneously accept it."
                )
            )

            # 5. Composite GROUP BY nulls dataset (targets grouping column concatenation bugs)
            gb_terms = parsed_query.get("group_by", [])
            gb_cols = []
            for term in gb_terms:
                resolved = resolve_query_column(schema, parsed_query, term.get("table", ""), term["column"])
                if resolved and resolved[0] == table_name:
                    col = next((c for c in table.columns if c.name == resolved[1]), None)
                    if col and col not in gb_cols:
                        gb_cols.append(col)

            if len(gb_cols) >= 2 and any(c.is_nullable for c in gb_cols) and required_count >= 2:
                DataFactory.get_instance().clear_uniqueness()
                nullable_gb_cols = [c for c in gb_cols if c.is_nullable]
                rows_composite_nulls = []
                for i in range(required_count):
                    row = copy.deepcopy(base_row)
                    for column in table.columns:
                        if column.is_primary_key or column.is_unique:
                            if "char" in (column.data_type or "").lower() or "text" in (column.data_type or "").lower():
                                row[column.name] = generate_unique_string_for_column(column)
                            else:
                                row[column.name] = generate_unique_id_for_column(column)

                    null_col = nullable_gb_cols[i % len(nullable_gb_cols)]
                    for c in gb_cols:
                        if c == null_col:
                            row[c.name] = None
                        else:
                            if "char" in (c.data_type or "").lower() or "text" in (c.data_type or "").lower():
                                row[c.name] = generate_unique_string_for_column(c)
                            elif c.is_temporal:
                                row[c.name] = next_distinct_value(c, base_row.get(c.name), schema=schema, table_name=table_name)
                            else:
                                row[c.name] = generate_unique_id_for_column(c)
                    rows_composite_nulls.append(row)

                mock_data_comp = self._build_group_dataset(base_data, table_name, rows_composite_nulls)
                DataFactory.get_instance().clear_uniqueness()
                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_composite_nulls_{table_name}_{column_name}_{required_count}",
                        data=mock_data_comp,
                        tags=["having_count_attack", "composite_null_attack"],
                        description=(
                            f"Targets Composite GROUP BY vs Concatenation bugs. Dataset generates {required_count} rows "
                            f"with distinct partial-NULL combinations across composite grouping columns in `{table_name}`. "
                            f"In correct relational algebra, each partial-NULL tuple forms an independent group of size 1 (< {required_count}) "
                            f"so the HAVING filter rejects all groups. Mutants concatenating columns collapse all partial-NULL rows into "
                            f"a single NULL group of size {required_count}, erroneously passing the HAVING threshold."
                        )
                    )
                )

        return datasets

