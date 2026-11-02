-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default1'), ('default1', '#', 'c'), ('#', '#', NULL), ('c', '#', '#'), ('-', '#', 'c'), ('unique_5', '#', '#'), ('unique_6', NULL, 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', '#', 'c'), ('c', '#', 'default2'), ('#', '#', NULL), ('default1', '#', '-'), ('default2', NULL, '#'), ('unique_5', '#', '#'), ('unique_6', NULL, '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('-', 'default1', 'default2'), ('-', 'c', 'unique_6'), ('#', 'default1', 'unique_6'), ('default1', 'unique_5', 'default1'), ('#', '#', 'unique_6'), ('#', 'c', 'default1'), ('#', 'default2', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('#',)
*/

-- Prediction Query
SELECT DISTINCT m.molecule_id FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id INNER JOIN connected AS c ON a.atom_id = c.atom_id INNER JOIN bond AS b ON c.bond_id = b.bond_id WHERE m.label = '-' AND a.element = 'c' AND b.bond_type = '#' LIMIT 2;

/*
Prediction Result:
*/