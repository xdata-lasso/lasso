"""
CLI and experiment utility for schema foreign key repair and validation.
"""

from __future__ import annotations

import argparse
import json
import os
import sys

# Ensure src is importable
SRC_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "src"))
if SRC_DIR not in sys.path:
    sys.path.insert(0, SRC_DIR)

from schema_fixer import (
    canonical_identifier,
    ensure_foreign_key_constraints,
    extract_identifier_name,
    fix_foreign_key_constraints,
    parse_ddl_statements,
    verify_ddl_with_sqlite,
)

__all__ = [
    "canonical_identifier",
    "ensure_foreign_key_constraints",
    "extract_identifier_name",
    "fix_foreign_key_constraints",
    "parse_ddl_statements",
    "verify_ddl_with_sqlite",
]


def main():
    parser = argparse.ArgumentParser(description="Fix and validate SQL DDL foreign key constraints for SQLite.")
    parser.add_argument("--ddl", type=str, help="DDL string to fix.")
    parser.add_argument("--file", "-f", type=str, help="Path to SQL DDL file to fix.")
    parser.add_argument("--output", "-o", type=str, help="Path to write fixed DDL output.")
    parser.add_argument("--schemas-json", type=str, help="Path to schemas.json file to validate/fix.")
    parser.add_argument("--verify-sqlite", action="store_true", help="Verify DDL execution in SQLite with PRAGMA foreign_keys = ON.")

    args = parser.parse_args()

    if args.schemas_json:
        if not os.path.exists(args.schemas_json):
            print(f"Error: File not found: {args.schemas_json}")
            sys.exit(1)
        with open(args.schemas_json, "r") as f:
            schemas = json.load(f)

        print(f"Processing {len(schemas)} schemas from {args.schemas_json}...")
        fixed_count = 0
        sqlite_errors = 0

        for db_id, data in schemas.items():
            ddl = data.get("ddl", "")
            if not ddl:
                continue
            fixed_ddl = fix_foreign_key_constraints(ddl)
            if fixed_ddl != ddl:
                fixed_count += 1
                data["ddl"] = fixed_ddl

            if args.verify_sqlite:
                valid, err = verify_ddl_with_sqlite(fixed_ddl)
                if not valid:
                    sqlite_errors += 1
                    print(f"  [FAIL] {db_id}: {err}")

        print(f"Summary: {fixed_count} schemas modified/fixed.")
        if args.verify_sqlite:
            print(f"SQLite verification: {len(schemas) - sqlite_errors}/{len(schemas)} passed ({sqlite_errors} failed).")

        if args.output:
            with open(args.output, "w") as f:
                json.dump(schemas, f, indent=2)
            print(f"Saved updated schemas to {args.output}")

    elif args.file:
        if not os.path.exists(args.file):
            print(f"Error: File not found: {args.file}")
            sys.exit(1)
        with open(args.file, "r") as f:
            content = f.read()
        fixed = fix_foreign_key_constraints(content)
        if args.output:
            with open(args.output, "w") as f:
                f.write(fixed)
            print(f"Saved fixed DDL to {args.output}")
        else:
            print(fixed)

        if args.verify_sqlite:
            valid, err = verify_ddl_with_sqlite(fixed)
            print(f"SQLite verification: {'PASSED' if valid else 'FAILED: ' + str(err)}")

    elif args.ddl:
        fixed = fix_foreign_key_constraints(args.ddl)
        print(fixed)
        if args.verify_sqlite:
            valid, err = verify_ddl_with_sqlite(fixed)
            print(f"SQLite verification: {'PASSED' if valid else 'FAILED: ' + str(err)}")
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
