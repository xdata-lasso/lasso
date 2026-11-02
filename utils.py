import json
import re

def load_json(file_path):
    """Load JSON data from a file."""
    try:
        with open(file_path, 'r') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error reading JSON file {file_path}: {e}")
        raise

def sort_schema_statements(schema_stmts):
    """
    Topologically sort CREATE TABLE SQL statements so that tables that do not have 
    dependencies (foreign keys) are created before tables that depend on them.
    Also lowercases all double-quoted identifiers to prevent case-sensitivity issues in PostgreSQL.
    """
    # Lowercase double-quoted identifiers to ensure case-insensitive matching with generated queries and inserts
    normalized_stmts = []
    for stmt in schema_stmts:
        normalized_stmt = re.sub(r'"([^"]+)"', lambda m: f'"{m.group(1).lower()}"', stmt)
        normalized_stmts.append(normalized_stmt)
    schema_stmts = normalized_stmts

    # Regex to find created table name
    # e.g., CREATE TABLE "DISTRICT" or CREATE TABLE DISTRICT
    create_pattern = re.compile(r'create\s+table\s+(?:"([^"]+)"|([a-zA-Z0-9_]+))', re.IGNORECASE)
    # Regex to find referenced table names
    # e.g., REFERENCES "DISTRICT" or REFERENCES DISTRICT
    ref_pattern = re.compile(r'references\s+(?:"([^"]+)"|([a-zA-Z0-9_]+))', re.IGNORECASE)
    
    # Map from table name to (stmt, dependencies)
    table_to_stmt = {}
    dependencies = {}
    
    # Keep track of statements that don't seem to be CREATE TABLE
    other_stmts = []
    
    for stmt in schema_stmts:
        stmt_strip = stmt.strip()
        if not stmt_strip:
            continue
        create_match = create_pattern.search(stmt_strip)
        if not create_match:
            other_stmts.append(stmt)
            continue
        
        table_name = create_match.group(1) or create_match.group(2)
        table_name_upper = table_name.upper()
        
        # Find all references
        refs = []
        for ref_match in ref_pattern.finditer(stmt_strip):
            ref_table = ref_match.group(1) or ref_match.group(2)
            ref_table_upper = ref_table.upper()
            if ref_table_upper != table_name_upper:  # Avoid self-references
                refs.append(ref_table_upper)
                
        table_to_stmt[table_name_upper] = stmt
        dependencies[table_name_upper] = set(refs)
        
    # Topological sort
    visited = {}
    ordered_tables = []
    
    def visit(node):
        if node in visited:
            if visited[node] == 1:  # Cycle detected
                return
            return
        
        visited[node] = 1 # Visiting
        for dep in dependencies.get(node, []):
            if dep in table_to_stmt: # Only depend on tables we actually create
                visit(dep)
        visited[node] = 2 # Visited
        ordered_tables.append(node)
        
    for table in table_to_stmt:
        visit(table)
        
    sorted_stmts = [table_to_stmt[table] for table in ordered_tables]
    # Add other statements at the end
    sorted_stmts.extend(other_stmts)
    return sorted_stmts

