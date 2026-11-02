"""
AttackStrategy Base Module

Defines the abstract base class AttackStrategy for all semantic attack strategies.
Provides common utility methods for alias-to-table resolution, join equivalence class extraction,
and WHERE literal extraction across SQL AST queries.
"""

from abc import ABC, abstractmethod
from typing import Any

from models import Schema, Dataset
from dataset_generator import UnionFind


class AttackStrategy(ABC):
    """
    Abstract Base Class for all attack strategies.
    """

    @abstractmethod
    def is_applicable(self, schema: Schema, parsed_query: dict[str, Any]) -> bool:
        """
        Check if this attack strategy applies to the given parsed query and schema.
        """
        pass

    @abstractmethod
    def generate(self, schema: Schema, parsed_query: dict[str, Any]) -> list[Dataset]:
        """
        Generate small, targeted datasets likely to kill the mutation.
        """
        pass

    def get_alias_to_table(self, schema: Schema, parsed_query: dict[str, Any]) -> dict[str, str]:
        """
        Returns a mapping of table aliases to actual table names.
        If no tables are found in the query, defaults to all tables in the schema.
        """
        alias_to_table = {}
        for t in parsed_query.get("tables", []):
            alias_to_table[t["alias"]] = schema.find_table(t["name"]) or t["name"]
        if not alias_to_table:
            for t_name in schema.tables:
                alias_to_table[t_name] = t_name
        return alias_to_table

    def get_join_equivalence_classes(self, parsed_query: dict[str, Any]) -> tuple[Any, set[tuple[str, str]]]:
        """
        Builds a UnionFind structure tracking join column equivalences and returns a set of join columns.
        """
        uf = UnionFind()
        join_cols = set()
        for join in parsed_query.get("joins", []):
            for pair in join.get("on_pairs", []):
                left = (pair["left"]["table"], pair["left"]["column"])
                right = (pair["right"]["table"], pair["right"]["column"])
                uf.union(left, right)
                join_cols.add(left)
                join_cols.add(right)
        return uf, join_cols

    def get_where_literals(self, parsed_query: dict[str, Any]) -> list[dict[str, str]]:
        """
        Returns the parsed where_literals list from the query AST.
        """
        return parsed_query.get("where_literals", [])
