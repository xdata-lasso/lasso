"""
LikePatternAttackStrategy Module

Target semantic bug: Mutations in SQL LIKE / NOT LIKE wildcard patterns
(e.g., substituting '%' with '_', altering wildcard placement, or changing wildcard counts).

Algorithm & Relational Dataset Design:
SQL pattern matching uses '%' to match zero or more arbitrary characters and '_' to match
exactly one arbitrary character. A mutant altering a pattern (for instance, replacing '%' with '_'
or tightening wildcard constraints) creates distinct boundary evaluation differences:
1. Zero-length substitution for '%': Testing strings where the wildcard matches zero characters
   (e.g., prefix '%' omitted, or suffix '%' omitted). Such strings satisfy '%' but violate '_',
   causing LIKE to succeed where '_' would fail, and causing NOT LIKE to evaluate to FALSE where
   a mutant with '_' evaluates to TRUE.
2. Multi-character substitution for '%' / single-character boundary for '_': Testing strings
   where wildcards match multiple characters (e.g., two spaces instead of one). Such strings
   satisfy '%' but violate single '_' placeholders.
3. For NOT LIKE predicates: Injects values strictly satisfying the reference pattern so that
   the reference query suppresses or filters out the tuple, while any mutant whose mutated pattern
   fails to match will improperly retain or aggregate the tuple.
For each targeted LIKE / NOT LIKE predicate, datasets are generated with these boundary strings
injected into the target column, while preserving all other relational join and filter integrity.
"""

from typing import Any, Dict, List, Set, Tuple
import copy

from models import Schema, Dataset
from attacks.base import AttackStrategy
from dataset_generator import generate_base_dataset, resolve_query_column, ensure_dataset_uniqueness
from dataset_generator.augmentation import repair_orphan_rows


def _generate_wildcard_boundary_values(pattern: str) -> List[str]:
    """
    Generate boundary test values for a SQL LIKE pattern containing '%' or '_'.
    Derives deterministic candidate strings testing zero-length, single-length,
    and multi-length wildcard matches.
    """
    candidates = []

    # 1. Zero-character expansion for '%': replace '%' with empty string
    zero_pct = pattern.replace("%", "").replace("_", "x")
    if zero_pct and zero_pct not in candidates:
        candidates.append(zero_pct)

    # 2. Split pattern by '%' and test with single space / separator between tokens
    pct_tokens = [tok.replace("_", "x") for tok in pattern.split("%") if tok]
    if pct_tokens:
        single_sep = " ".join(pct_tokens)
        if single_sep not in candidates:
            candidates.append(single_sep)

        # 3. Two-character expansion between tokens (to violate single '_' mutant)
        double_sep = "  ".join(pct_tokens)
        if double_sep not in candidates:
            candidates.append(double_sep)

    # 4. If pattern contains '_', test boundary omitting '_' (0 chars) vs two chars
    if "_" in pattern:
        zero_underscore = pattern.replace("_", "").replace("%", "")
        if zero_underscore and zero_underscore not in candidates:
            candidates.append(zero_underscore)

        double_underscore = pattern.replace("_", "xx").replace("%", "")
        if double_underscore and double_underscore not in candidates:
            candidates.append(double_underscore)

    return candidates


class LikePatternAttackStrategy(AttackStrategy):
    """
    Attack strategy targeting wildcard pattern mutations in LIKE and NOT LIKE predicates.
    """

    def is_applicable(self, schema: Schema, parsed_query: Dict[str, Any]) -> bool:
        for literal in parsed_query.get("where_literals", []):
            op = literal.get("operator", "").upper()
            if "LIKE" in op and isinstance(literal.get("value"), str):
                val = literal["value"]
                if "%" in val or "_" in val:
                    return True
        return False

    def generate(self, schema: Schema, parsed_query: Dict[str, Any]) -> List[Dataset]:
        datasets: List[Dataset] = []
        where_literals = parsed_query.get("where_literals", [])

        seen_targets: Set[Tuple[str, str, str]] = set()

        for target_index, lit in enumerate(where_literals):
            op = lit.get("operator", "").upper()
            if "LIKE" not in op or not isinstance(lit.get("value"), str):
                continue

            pattern = lit["value"]
            if "%" not in pattern and "_" not in pattern:
                continue

            resolved = resolve_query_column(schema, parsed_query, lit.get("table", ""), lit.get("column", ""))
            if not resolved:
                continue

            table_name, column_name = resolved
            if table_name not in schema.tables:
                continue

            key = (table_name, column_name, pattern)
            if key in seen_targets:
                continue
            seen_targets.add(key)

            boundary_values = _generate_wildcard_boundary_values(pattern)

            for b_idx, test_val in enumerate(boundary_values):
                value_injections = {(table_name, column_name): test_val}

                data = generate_base_dataset(
                    schema, parsed_query,
                    value_injections=value_injections,
                    cache_key_salt=f"like_pattern_{table_name}_{column_name}_{target_index}_{b_idx}"
                )
                data = ensure_dataset_uniqueness(schema, data)
                repair_orphan_rows(schema, data)

                datasets.append(
                    Dataset(
                        strategy_name=f"{self.__class__.__name__}_{column_name}_{b_idx}",
                        data=data,
                        tags=["like_pattern_attack"],
                        description=(
                            f"Targets LIKE wildcard mutations in {table_name}.{column_name}. "
                            f"Tests pattern boundary value '{test_val}' against pattern '{pattern}'. "
                            f"Evaluates semantics of zero-length vs multi-character wildcard expansions."
                        )
                    )
                )

        return datasets
