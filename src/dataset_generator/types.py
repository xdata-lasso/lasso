"""
Data Structures for the Dataset Generation Pipeline
=====================================================

Contains the foundational types used across all pipeline phases.
This module has zero internal dependencies — it only imports from
stdlib and the ``models`` package.

Types:
  UnionFind   — Disjoint-set structure tracking column equivalence classes.
  ColumnSpec  — Complete specification of constraints on an equivalence class.
  col_key     — Canonical (table, column) key constructor.
"""

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Tuple

from models import Column


class UnionFind:
    """
    Disjoint-set (union-find) with path compression.

    Each element is a (TABLE_OR_ALIAS, COLUMN_NAME) tuple (uppercased).
    Two elements in the same set mean "these columns must share the same
    generated value domain" — typically because of a JOIN, FK, or alias.
    """

    def __init__(self):
        self.parent: Dict[Tuple[str, str], Tuple[str, str]] = {}

    def find(self, i: Tuple[str, str]) -> Tuple[str, str]:
        """Return the canonical root representative for element `i`."""
        if i not in self.parent:
            self.parent[i] = i  # Lazy initialization: first access makes it its own root
        if self.parent[i] != i:
            self.parent[i] = self.find(self.parent[i])  # Path compression
        return self.parent[i]

    def union(self, i: Tuple[str, str], j: Tuple[str, str]) -> None:
        """Merge the equivalence classes containing `i` and `j`."""
        ri, rj = self.find(i), self.find(j)
        if ri != rj:
            self.parent[ri] = rj


def col_key(table_or_alias: str, column: str) -> Tuple[str, str]:
    """
    Canonical key for a (table_or_alias, column) pair.

    All keys are uppercased so that lookups are case-insensitive, matching
    standard SQL identifier semantics.
    """
    return ((table_or_alias or "").upper(), (column or "").upper())


class SymbolTable:
    """
    Symbol table mapping (table_or_alias, column) pairs to resolved
    (schema_table_name, column_name) pairs.
    """

    def __init__(self, alias_to_table: Optional[Dict[str, str]] = None):
        self.alias_to_table: Dict[str, str] = alias_to_table or {}
        self._cache: Dict[Tuple[str, str], Tuple[str, str]] = {}

    def get(self, key: Tuple[str, str]) -> Optional[Tuple[str, str]]:
        """Lookup resolved (schema_table, column) for canonical key."""
        return self._cache.get(key)

    def put(self, key: Tuple[str, str], value: Tuple[str, str]) -> None:
        """Store resolved mapping for canonical key."""
        self._cache[key] = value



@dataclass
class ColumnSpec:
    """
    Complete specification of constraints on an equivalence class.

    This is THE bridge between analysis and generation.  Every feature the
    generator must handle is captured as a field here — no scattered special
    cases elsewhere.

    Value constraints (from query WHERE / HAVING predicates):
      required     — EQ, IN values that must appear
      lower        — GT / GTE lower bound
      upper        — LT / LTE upper bound
      disallowed   — NEQ / NOT IN values to avoid
      pattern      — LIKE / ILIKE pattern string

    Fill strategy (from schema + query structure):
      must_be_unique  — PK or UNIQUE constraint → all values distinct
      is_group_key    — Appears in GROUP BY → repeat values to form groups
      is_subquery     — Originates from subquery predicate
      force_null      — NULL injection override

    Type info (for value generation + coercion):
      column       — Reference to a schema Column object
      data_type    — Column data type string
      char_limit   — Minimum VARCHAR(N) across the equivalence class
      check_exprs  — CHECK constraint expressions from DDL
      table_name   — Resolved schema table name (for CHECK solving)
    """

    # Value constraints
    required: list = field(default_factory=list)
    lower: Any = None
    upper: Any = None
    disallowed: set = field(default_factory=set)
    pattern: Optional[str] = None
    col_bounds: list = field(default_factory=list)

    # Fill strategy
    must_be_unique: bool = False
    is_group_key: bool = False
    is_subquery: bool = False
    is_avg_subquery_col: bool = False
    force_null: bool = False

    # Type info
    column: Optional[Column] = None
    data_type: str = ""
    is_temporal: bool = False
    char_limit: Optional[int] = None
    check_exprs: list = field(default_factory=list)
    table_name: str = ""

    @property
    def has_query_constraints(self) -> bool:
        """Were any constraints derived from the query (not just schema)?"""
        return bool(
            self.required
            or self.lower is not None
            or self.upper is not None
            or self.disallowed
            or self.pattern
        )

    def add_required(self, val: Any) -> None:
        """Add a required value if not already present."""
        if val not in self.required:
            self.required.append(val)

    def add_disallowed(self, val: Any) -> None:
        """Add a disallowed value."""
        self.disallowed.add(val)

    def is_valid_range(self) -> bool:
        """Check if lower and upper bounds are mutually consistent."""
        if self.lower is not None and self.upper is not None:
            if isinstance(self.lower, (int, float)) and isinstance(self.upper, (int, float)):
                return self.lower <= self.upper
        return True

