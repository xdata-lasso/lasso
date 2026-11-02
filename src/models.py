"""
Core Domain Models
==================

Data structures representing database schemas, tables, columns, constraints, and generated datasets.
"""

from dataclasses import dataclass, field
from typing import Any, Optional

@dataclass
class Column:
    name: str
    data_type: str
    is_primary_key: bool = False
    is_unique: bool = False
    is_nullable: bool = True
    explicit_not_null: bool = False
    constraints: list[str] = field(default_factory=list)
    faker_type: Optional[str] = None

    @property
    def is_text(self) -> bool:
        dt = self.data_type.lower()
        return "char" in dt or "text" in dt

    @property
    def is_numeric(self) -> bool:
        dt = self.data_type.lower()
        return any(t in dt for t in ('int', 'numeric', 'decimal', 'real', 'float', 'double', 'number'))

    @property
    def is_temporal(self) -> bool:
        dt = self.data_type.lower()
        return "date" in dt or "time" in dt

@dataclass
class ForeignKey:
    column_name: str
    reference_table: str
    reference_column: str

@dataclass
class Table:
    name: str
    columns: list[Column]
    foreign_keys: list[ForeignKey] = field(default_factory=list)
    constraints: list[str] = field(default_factory=list)
    check_constraints: list[Any] = field(default_factory=list)  # List of {'column': str|None, 'expression': sqlglot AST}
    unique_constraints: list[list[str]] = field(default_factory=list)  # List of composite UNIQUE column lists

@dataclass
class Schema:
    """
    Contains a representation of database tables, columns, constraints, etc.
    """
    tables: dict[str, Table]
    raw_ddl: str = ""

    def find_table(self, name: str) -> Optional[str]:
        """Case-insensitive table name lookup. Returns canonical name or None."""
        if not name:
            return None
        upper = name.upper()
        for t in self.tables:
            if t.upper() == upper:
                return t
        return None

    def find_column(self, table_name: str, col_name: str) -> Optional['Column']:
        """Case-insensitive column lookup within a resolved table."""
        table = self.tables.get(table_name)
        if not table:
            return None
        upper = col_name.upper()
        for c in table.columns:
            if c.name.upper() == upper:
                return c
        return None

@dataclass
class Dataset:
    """
    Represents generated test datasets targeting specific semantic errors.
    """
    strategy_name: str
    data: dict[str, list[dict[str, Any]]]
    tags: list[str]
    description: str
    insert_statements: list[str] = field(default_factory=list)
