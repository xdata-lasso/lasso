try:
    import pysqlite3 as sqlite3
except ImportError:
    import sqlite3
import time
import uuid



import os
import re
from typing import Any, Tuple

def _make_postgres_fk_deferrable(schema_sql: str) -> str:
    """
    Internally transforms PostgreSQL DDL so foreign keys are DEFERRABLE INITIALLY DEFERRED.
    This allows datasets to be loaded in any order inside a transaction without replication hacks,
    and lets the native PostgreSQL engine validate constraints on COMMIT.
    """
    if not schema_sql or not schema_sql.strip():
        return schema_sql
    try:
        import sqlglot
        from sqlglot import exp
        parsed = sqlglot.parse(schema_sql, read='postgres')
        modified = False
        for stmt in parsed:
            for ref in stmt.find_all(exp.Reference):
                opts = list(ref.args.get('options') or [])
                if not any('DEFERRABLE' in str(o).upper() for o in opts):
                    opts.extend(['DEFERRABLE', 'INITIALLY DEFERRED'])
                    ref.set('options', opts)
                    modified = True
        if modified:
            return ';\n'.join(s.sql('postgres') for s in parsed) + ';'
    except Exception:
        pass

    return re.sub(
        r'(\bREFERENCES\s+["`\w]+(?:\s*\([^)]+\))?(?:\s+ON\s+(?:DELETE|UPDATE)\s+[A-Za-z\s]+)*)(?!\s*DEFERRABLE)',
        r'\1 DEFERRABLE INITIALLY DEFERRED',
        schema_sql,
        flags=re.IGNORECASE
    )

class DBConnection:
    def __init__(self, dialect: str, schema: str, dataset: str, db_config: dict = None):
        self.dialect = 'postgres' if dialect == 'postgresql' else dialect
        self.schema = schema
        self.dataset = dataset
        self.db_config = db_config
        self.conn = None

    def __enter__(self):
        self.conn = self.setup_db()
        return self.conn

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def close(self):
        if self.conn:
            try:
                self.conn.close()
            except Exception:
                pass

        if hasattr(self, 'db_name') and self.dialect in ('mysql', 'postgres'):
            try:
                if self.dialect == 'mysql':
                    import pymysql
                    config = self.db_config or {}
                    host = config.get("host", os.environ.get("MYSQL_HOST", "localhost"))
                    port = int(config.get("port", os.environ.get("MYSQL_PORT", 33060)))
                    admin_conn = pymysql.connect(
                        host=host,
                        port=port,
                        user=config.get("user", "root"),
                        password=config.get("password", "test"),
                        autocommit=True
                    )
                    with admin_conn.cursor() as cursor:
                        cursor.execute(f"DROP DATABASE IF EXISTS {self.db_name};")
                    admin_conn.close()
                elif self.dialect == 'postgres':
                    import psycopg2
                    from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
                    config = self.db_config or {}
                    host = config.get("host", os.environ.get("POSTGRES_HOST", "localhost"))
                    port = int(config.get("port", os.environ.get("POSTGRES_PORT", 54320)))
                    admin_conn = psycopg2.connect(
                        host=host,
                        port=port,
                        user=config.get("user", "postgres"),
                        password=config.get("password", "postgres"),
                        dbname=config.get("dbname", "postgres")
                    )
                    admin_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
                    with admin_conn.cursor() as cursor:
                        cursor.execute(f"DROP DATABASE IF EXISTS {self.db_name} WITH (FORCE);")
                    admin_conn.close()
            except Exception as e:
                print(f"Error dropping database {getattr(self, 'db_name', '')}: {e}")

    def reset_random(self):
        if self.dialect == 'sqlite' and hasattr(self, 'rng') and self.rng:
            self.rng.seed(42)
        elif self.dialect == 'postgres' and self.conn:
            try:
                cur = self.conn.cursor()
                cur.execute("SELECT setseed(0.42);")
                cur.close()
            except Exception:
                pass

    def setup_db(self) -> Any:
        try:
            return self._setup_db_inner()
        except Exception:
            self.close()
            raise

    def _setup_db_inner(self) -> Any:
        if self.dialect == 'sqlite':
            import random
            
            conn = sqlite3.connect(':memory:')
            
            self.rng = random.Random(42)
            def mock_random():
                return self.rng.randint(-9223372036854775808, 9223372036854775807)
            def mock_randomblob(n):
                if n is None or n <= 0:
                    return b''
                return bytes([self.rng.randint(0, 255) for _ in range(n)])
            
            conn.create_function("RANDOM", 0, mock_random)
            conn.create_function("RANDOMBLOB", 1, mock_randomblob)
            
            cursor = conn.cursor()
            cursor.execute("PRAGMA foreign_keys = OFF;")
            
            if self.schema:
                try:
                    cursor.executescript(self.schema)
                except Exception as e:
                    raise Exception(f"SCHEMA_ERROR: {e}")
                
            self.conn = conn
            
            cursor = conn.cursor()
            if self.dataset:
                try:
                    cursor.executescript(self.dataset)
                except Exception as e:
                    raise Exception(f"DATASET_ERROR: {e}")
                
            # Always check FK constraints after loading
            try:
                cursor.execute("PRAGMA foreign_keys = ON;")
                cursor.execute("PRAGMA foreign_key_check;")
                if cursor.fetchall():
                    conn.close()
                    raise Exception("DATASET_ERROR: The provided dataset violated foreign key constraints.")
            except Exception as e:
                if str(e).startswith("DATASET_ERROR:"):
                    raise
                raise Exception(f"DATASET_ERROR: Foreign key check failed: {e}")
            return conn

        elif self.dialect == 'postgres':
            import psycopg2
            from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
            
            config = self.db_config or {}
            host = config.get("host", os.environ.get("POSTGRES_HOST", "localhost"))
            port = int(config.get("port", os.environ.get("POSTGRES_PORT", 54320)))
            user = config.get("user", "postgres")
            password = config.get("password", "postgres")
            admin_dbname = config.get("dbname", "postgres")
            
            admin_conn = psycopg2.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                dbname=admin_dbname
            )
            admin_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
            
            self.db_name = f"test_db_{uuid.uuid4().hex}"
            with admin_conn.cursor() as cursor:
                cursor.execute(f"CREATE DATABASE {self.db_name};")
            admin_conn.close()
            
            conn = psycopg2.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                dbname=self.db_name
            )
            self.conn = conn
            conn.autocommit = True
            cursor = conn.cursor()
            
            # Setup seeded random and statement timeout
            cursor.execute("SELECT setseed(0.42);")
            cursor.execute("SET statement_timeout = 5000;")
            
            if self.schema:
                try:
                    schema_to_exec = _make_postgres_fk_deferrable(self.schema)
                    cursor.execute(schema_to_exec)
                except Exception as e:
                    raise Exception(f"SCHEMA_ERROR: {e}")

            if self.dataset:
                try:
                    cursor.execute("BEGIN;")
                    cursor.execute(self.dataset)
                    cursor.execute("COMMIT;")
                except Exception as e:
                    try:
                        cursor.execute("ROLLBACK;")
                    except Exception:
                        pass
                    raise Exception(f"DATASET_ERROR: {e}")
                
            return conn

        elif self.dialect == 'mysql':
            import pymysql
            
            config = self.db_config or {}
            host = config.get("host", os.environ.get("MYSQL_HOST", "localhost"))
            port = int(config.get("port", os.environ.get("MYSQL_PORT", 33060)))
            user = config.get("user", "root")
            password = config.get("password", "test")
            
            admin_conn = pymysql.connect(
                host=host,
                port=port,
                user=user,
                password=password
            )
            admin_conn.autocommit = True
            
            self.db_name = f"test_db_{uuid.uuid4().hex}"
            with admin_conn.cursor() as cursor:
                cursor.execute(f"CREATE DATABASE {self.db_name};")
            admin_conn.close()
            
            conn = pymysql.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                database=self.db_name,
                client_flag=pymysql.constants.CLIENT.MULTI_STATEMENTS
            )
            self.conn = conn
            conn.autocommit = True
            cursor = conn.cursor()
            
            # Disable FK checks to allow inserts in any order and enable ANSI_QUOTES for standard SQL identifier quoting
            cursor.execute("SET FOREIGN_KEY_CHECKS = 0, sql_mode = 'ANSI_QUOTES';")
            
            if self.schema:
                try:
                    cursor.execute(self.schema)
                except Exception as e:
                    raise Exception(f"SCHEMA_ERROR: {e}")
            if self.dataset:
                try:
                    cursor.execute(self.dataset)
                except Exception as e:
                    raise Exception(f"DATASET_ERROR: {e}")
                
            # Always check FK constraints
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
            fk_query = """
            SELECT 
                CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
            FROM 
                information_schema.KEY_COLUMN_USAGE
            WHERE 
                REFERENCED_TABLE_NAME IS NOT NULL AND TABLE_SCHEMA = DATABASE();
            """
            cursor.execute(fk_query)
            fks = cursor.fetchall()
            
            constraints = {}
            for c_name, table, column, ref_table, ref_column in fks:
                if c_name not in constraints:
                    constraints[c_name] = {"table": table, "ref_table": ref_table, "cols": [], "ref_cols": []}
                constraints[c_name]["cols"].append(column)
                constraints[c_name]["ref_cols"].append(ref_column)
                
            for c_name, c_data in constraints.items():
                table = c_data["table"]
                ref_table = c_data["ref_table"]
                join_conds = " AND ".join([f"t.{c} = r.{rc}" for c, rc in zip(c_data["cols"], c_data["ref_cols"])])
                not_null_conds = " AND ".join([f"t.{c} IS NOT NULL" for c in c_data["cols"]])
                
                check_query = f"""
                SELECT 1 
                FROM {table} t
                LEFT JOIN {ref_table} r ON {join_conds}
                WHERE ({not_null_conds}) AND r.{c_data['ref_cols'][0]} IS NULL
                LIMIT 1;
                """
                cursor.execute(check_query)
                if cursor.fetchone():
                    conn.close()
                    raise Exception("DATASET_ERROR: The provided dataset violated foreign key constraints.")
            return conn
        else:
            raise ValueError(f"Unsupported dialect: {self.dialect}")
