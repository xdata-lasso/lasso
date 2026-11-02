"""
SQL Serializer Module
=====================

Serializes generated table dictionary datasets into topologically ordered SQL INSERT statements.
"""

from models import Schema, Dataset
from dataset_generator.augmentation import topological_sort_tables

def generate_inserts(schema: Schema, dataset: Dataset) -> list[str]:
    """
    Synthesizes INSERT INTO statements from the dataset data.
    """
    insert_statements = []
    sorted_tables = topological_sort_tables(schema, list(dataset.data.keys()))
    
    for table_name in sorted_tables:
        rows = dataset.data[table_name]
        if not rows:
            continue
            
        columns = list(rows[0].keys())
        col_str = ", ".join(f'"{c.lower()}"' for c in columns)
        
        for row in rows:
            values = []
            for col in columns:
                val = row[col]
                if val is None:
                    values.append("NULL")
                elif isinstance(val, str):
                    escaped_val = val.replace("'", "''")
                    values.append(f"'{escaped_val}'")
                elif isinstance(val, bool):
                    values.append("TRUE" if val else "FALSE")
                else:
                    values.append(str(val))
                    
            val_str = ", ".join(values)
            stmt = f'INSERT INTO "{table_name.lower()}" ({col_str}) VALUES ({val_str});'
            insert_statements.append(stmt)
            
    return insert_statements
