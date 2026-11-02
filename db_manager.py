import psycopg2
from src import config
from src.utils import sort_schema_statements

class DBManager:
    def __init__(self, dialect='postgres'):
        self.conn = None
        self.dialect = dialect

    def connect(self):
        """Establish connection to the database."""
        try:
            if self.dialect == 'sqlite':
                import sqlite3
                self.conn = sqlite3.connect(':memory:')
            else:
                self.conn = psycopg2.connect(
                    dbname=config.DB_NAME,
                    user=config.DB_USER,
                    password=config.DB_PASSWORD,
                    host=config.DB_HOST,
                    port=config.DB_PORT
                )
                self.conn.autocommit = True
        except Exception as e:
            print(f"Error connecting to database: {e}")
            raise

    def close(self):
        """Close the database connection."""
        if self.conn:
            self.conn.close()

    def reset_schema(self, schema_stmts):
        """
        Drop existing tables and execute the raw SQL schema provided.
        Ensures a clean state by dropping all tables in the public schema instead of the schema itself.
        """
        if not self.conn:
            self.connect()
        
        cur = self.conn.cursor()
        old_autocommit = getattr(self.conn, 'autocommit', False)
        if self.dialect != 'sqlite':
            self.conn.autocommit = False
            
        try:
            if self.dialect == 'sqlite':
                # For SQLite, just create a fresh in-memory database
                if self.conn:
                    self.conn.close()
                import sqlite3
                self.conn = sqlite3.connect(':memory:')
                cur = self.conn.cursor()
            else:
                # Query all table names in public schema
                cur.execute("SELECT tablename FROM pg_tables WHERE schemaname = 'public';")
                tables = [row[0] for row in cur.fetchall()]
                
                # Drop tables with CASCADE
                if tables:
                    drop_stmts = ", ".join(f'"{t}"' for t in tables)
                    cur.execute(f"DROP TABLE IF EXISTS {drop_stmts} CASCADE;")
            
            import re
            sorted_stmts = sort_schema_statements(schema_stmts)
            for stmt in sorted_stmts:
                if stmt.strip():
                    # Strip foreign key constraints to allow synthetic data insertion
                    # Remove entire FOREIGN KEY (...) REFERENCES ... ON DELETE/UPDATE clauses
                    stmt_no_fk = re.sub(r',?\s*foreign\s+key\s*\([^)]+\)\s*references\s+\w+\s*\([^)]+\)(\s+on\s+(delete|update)\s+(cascade|set\s+null|set\s+default|restrict|no\s+action))*', '', stmt, flags=re.IGNORECASE)
                    # Also strip inline REFERENCES ... ON DELETE/UPDATE
                    stmt_no_fk = re.sub(r'REFERENCES\s+\w+\s*\([^)]+\)(\s+on\s+(delete|update)\s+(cascade|set\s+null|set\s+default|restrict|no\s+action))*', '', stmt_no_fk, flags=re.IGNORECASE)
                    # Strip CHECK constraints (handles nested parens like check(x in ('a','b')))
                    def strip_check(s):
                        result = []
                        i = 0
                        while i < len(s):
                            # Case-insensitive match for 'check' followed by '('
                            if s[i:i+5].lower() == 'check' and i+5 < len(s):
                                j = i + 5
                                while j < len(s) and s[j] == ' ':
                                    j += 1
                                if j < len(s) and s[j] == '(':
                                    depth = 1
                                    j += 1
                                    while j < len(s) and depth > 0:
                                        if s[j] == '(':
                                            depth += 1
                                        elif s[j] == ')':
                                            depth -= 1
                                        j += 1
                                    i = j
                                    continue
                            result.append(s[i])
                            i += 1
                        return ''.join(result)
                    stmt_no_fk = strip_check(stmt_no_fk)
                    
                    # Quote table name if it's a reserved keyword like ORDER
                    if self.dialect == 'sqlite':
                        stmt_no_fk = re.sub(r'CREATE\s+TABLE\s+(ORDER|GROUP|INDEX)\s*\(', r'CREATE TABLE "\1" (', stmt_no_fk, flags=re.IGNORECASE)
                        
                    cur.execute(stmt_no_fk)
            if self.dialect != 'sqlite':
                self.conn.commit()
        except Exception as e:
            if self.dialect != 'sqlite':
                self.conn.rollback()
            print(f"Error resetting schema: {e}")
            import traceback
            traceback.print_exc()
            raise
        finally:
            if self.dialect != 'sqlite':
                self.conn.autocommit = old_autocommit
            cur.close()



    def load_data(self, data_stmts):
        """Execute raw SQL INSERT statements."""
        if not self.conn:
            self.connect()
            
        cur = self.conn.cursor()
        try:
            for stmt in data_stmts:
                if stmt.strip():
                    cur.execute(stmt)
        except Exception as e:
            print(f"Error loading data: {e}")
            raise
        finally:
            cur.close()

    def execute_query(self, sql):
        """Run a SELECT query and return results as a list of tuples."""
        if not self.conn:
            self.connect()
            
        cur = self.conn.cursor()
        try:
            cur.execute(sql)
            if cur.description:
                return cur.fetchall()
            return []
        except Exception as e:
            print(f"Error executing query: {sql}")
            print(f"Error details: {e}")
            raise
        finally:
            cur.close()
