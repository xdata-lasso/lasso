#!/usr/bin/env python3
"""
Generator for Obfuscated Variants of MM-BM:
1. MMO-BM: ManyMutationsObfuscated (renamed using deterministic pseudo-random words from Faker)
2. MMRO-BM: ManyMutationsRandomObfuscated (renamed using random letter strings, no numbers, no words)

Both variants preserve exact schema relational integrity, foreign key references,
and mutant semantics, enabling formal ablation of lexical / semantic priors.
"""

import os
import random
import re
import string
import sqlite3
import sqlglot
import sqlglot.expressions as exp
from sqlglot.dialects import Postgres, MySQL, SQLite
from faker import Faker

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

# Comprehensive set of reserved keywords across SQLite, PostgreSQL, and MySQL
RESERVED_KEYWORDS = set()
for d in [Postgres, MySQL, SQLite]:
    RESERVED_KEYWORDS.update(k.lower() for k in d.Tokenizer.KEYWORDS.keys())

RESERVED_KEYWORDS.update({
    'while', 'for', 'loop', 'until', 'repeat', 'choose', 'never', 'always', 'if', 'else', 'elif',
    'status', 'open', 'close', 'ranked', 'name', 'number', 'system', 'program', 'line', 'point',
    'state', 'side', 'part', 'none', 'true', 'false', 'null', 'will', 'shall', 'can', 'may',
    'might', 'must', 'should', 'would', 'could', 'same', 'like', 'glob', 'regexp', 'match',
    'under', 'over', 'between', 'in', 'out', 'into', 'from', 'where', 'select', 'table', 'view',
    'more', 'less', 'most', 'least', 'some', 'any', 'every', 'each', 'other', 'another', 'such'
})


def load_base_schema_entities(base_dir=SCRIPT_DIR):
    schema_path = os.path.join(base_dir, 'schema.sql')
    with open(schema_path, 'r', encoding='utf-8') as f:
        ddl = f.read()

    tables = []
    columns = []
    for stmt in sqlglot.parse(ddl, read='sqlite'):
        if stmt.key == 'create':
            tables.append(stmt.this.this.name.lower())
            for c in stmt.find_all(exp.ColumnDef):
                cname = c.name.lower()
                if cname not in columns:
                    columns.append(cname)

    return ddl, tables, columns


def transform_ast(ast_node, tbl_map, col_map):
    for node in ast_node.walk():
        if isinstance(node, exp.Identifier):
            val = node.name.lower()
            if isinstance(node.parent, exp.Table) and val in tbl_map:
                node.set('this', tbl_map[val])
            elif val in col_map and not isinstance(node.parent, exp.Table):
                node.set('this', col_map[val])
    return ast_node


def transform_sql(sql_str, tbl_map, col_map):
    parsed = sqlglot.parse_one(sql_str, read='sqlite')
    return transform_ast(parsed, tbl_map, col_map).sql(dialect='sqlite')


def transform_ddl(ddl_str, tbl_map, col_map):
    out_stmts = []
    for stmt in sqlglot.parse(ddl_str, read='sqlite'):
        if stmt.key == 'create':
            transformed = transform_ast(stmt, tbl_map, col_map)
            out_stmts.append(transformed.sql(dialect='sqlite') + ';')
    return '\n\n'.join(out_stmts)


def generate_mmo_variant(base_dir=SCRIPT_DIR, seed=42):
    """Generate MMO-BM using deterministic Faker words."""
    ddl, tables, columns = load_base_schema_entities(base_dir)
    original_names = set(tables + columns)

    fake = Faker()
    Faker.seed(seed)
    words = []
    while len(words) < len(tables) + len(columns):
        w = fake.unique.word().lower()
        if len(w) >= 4 and re.match(r'^[a-z]+$', w) and w not in RESERVED_KEYWORDS and w not in original_names:
            words.append(w)
    fake.unique.clear()

    tbl_map = {t: words[i] for i, t in enumerate(tables)}
    col_map = {c: words[len(tables) + i] for i, c in enumerate(columns)}

    # DDL
    obf_ddl = transform_ddl(ddl, tbl_map, col_map)
    with open(os.path.join(base_dir, 'schema_mmo.sql'), 'w', encoding='utf-8') as f:
        f.write('-- Relational schema for MMO-BM (ManyMutationsObfuscated: Faker Words)\n\n')
        f.write(obf_ddl + '\n')

    # Queries
    with open(os.path.join(base_dir, 'queries.txt'), 'r', encoding='utf-8') as fin, \
         open(os.path.join(base_dir, 'queries_mmo.txt'), 'w', encoding='utf-8') as fout:
        for line in fin:
            if not line.strip() or line.startswith('#'):
                continue
            parts = line.strip().split('|', 2)
            q_id = parts[0].strip()
            q_name = parts[1].strip() + ' (Faker Obfuscated)'
            q_sql = transform_sql(parts[2].strip(), tbl_map, col_map)
            fout.write(f'{q_id}|{q_name}|{q_sql}\n')

    # Mutants
    with open(os.path.join(base_dir, 'mutants.txt'), 'r', encoding='utf-8') as fin, \
         open(os.path.join(base_dir, 'mutants_mmo.txt'), 'w', encoding='utf-8') as fout:
        for line in fin:
            if not line.strip() or line.startswith('#'):
                continue
            parts = line.strip().split('|', 2)
            q_id = parts[0].strip()
            m_tag = parts[1].strip()
            m_sql = transform_sql(parts[2].strip(), tbl_map, col_map)
            fout.write(f'{q_id}|{m_tag}|{m_sql}\n')

    # Self-validation on SQLite
    conn = sqlite3.connect(':memory:')
    conn.executescript(obf_ddl)
    with open(os.path.join(base_dir, 'queries_mmo.txt')) as f:
        for line in f:
            parts = line.strip().split('|', 2)
            conn.execute(parts[-1].strip())
    cnt = 0
    with open(os.path.join(base_dir, 'mutants_mmo.txt')) as f:
        for line in f:
            parts = line.strip().split('|', 2)
            conn.execute(parts[-1].strip())
            cnt += 1
    print(f"[MMO-BM] Successfully generated and verified {cnt} mutants on SQLite (Faker Words).")


def generate_mmro_variant(base_dir=SCRIPT_DIR, seed=42, str_len=6):
    """Generate MMRO-BM using deterministic random letter strings (no numbers, no faker words)."""
    ddl, tables, columns = load_base_schema_entities(base_dir)
    original_names = set(tables + columns)

    rng = random.Random(seed)
    seen = set(original_names)
    letter_strings = []
    while len(letter_strings) < len(tables) + len(columns):
        s = ''.join(rng.choice(string.ascii_lowercase) for _ in range(str_len))
        if s not in RESERVED_KEYWORDS and s not in seen:
            seen.add(s)
            letter_strings.append(s)

    tbl_map = {t: letter_strings[i] for i, t in enumerate(tables)}
    col_map = {c: letter_strings[len(tables) + i] for i, c in enumerate(columns)}

    # DDL
    obf_ddl = transform_ddl(ddl, tbl_map, col_map)
    with open(os.path.join(base_dir, 'schema_mmro.sql'), 'w', encoding='utf-8') as f:
        f.write('-- Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings)\n\n')
        f.write(obf_ddl + '\n')

    # Queries
    with open(os.path.join(base_dir, 'queries.txt'), 'r', encoding='utf-8') as fin, \
         open(os.path.join(base_dir, 'queries_mmro.txt'), 'w', encoding='utf-8') as fout:
        for line in fin:
            if not line.strip() or line.startswith('#'):
                continue
            parts = line.strip().split('|', 2)
            q_id = parts[0].strip()
            q_name = parts[1].strip() + ' (Random Letters Obfuscated)'
            q_sql = transform_sql(parts[2].strip(), tbl_map, col_map)
            fout.write(f'{q_id}|{q_name}|{q_sql}\n')

    # Mutants
    with open(os.path.join(base_dir, 'mutants.txt'), 'r', encoding='utf-8') as fin, \
         open(os.path.join(base_dir, 'mutants_mmro.txt'), 'w', encoding='utf-8') as fout:
        for line in fin:
            if not line.strip() or line.startswith('#'):
                continue
            parts = line.strip().split('|', 2)
            q_id = parts[0].strip()
            m_tag = parts[1].strip()
            m_sql = transform_sql(parts[2].strip(), tbl_map, col_map)
            fout.write(f'{q_id}|{m_tag}|{m_sql}\n')

    # Self-validation on SQLite
    conn = sqlite3.connect(':memory:')
    conn.executescript(obf_ddl)
    with open(os.path.join(base_dir, 'queries_mmro.txt')) as f:
        for line in f:
            parts = line.strip().split('|', 2)
            conn.execute(parts[-1].strip())
    cnt = 0
    with open(os.path.join(base_dir, 'mutants_mmro.txt')) as f:
        for line in f:
            parts = line.strip().split('|', 2)
            conn.execute(parts[-1].strip())
            cnt += 1
    print(f"[MMRO-BM] Successfully generated and verified {cnt} mutants on SQLite (Random Letters).")


if __name__ == '__main__':
    print("Generating MM-BM variants in:", SCRIPT_DIR)
    generate_mmo_variant(SCRIPT_DIR)
    generate_mmro_variant(SCRIPT_DIR)
