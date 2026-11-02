-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', 'default1'), ('default2', NULL), ('default1', '-'), ('c', 'default2'), ('unique_4', 'default1'), ('unique_5', '-'), ('unique_6', 'default2'), ('unique_7', '-'), ('unique_8', 'c'), ('unique_9', 'default1'), ('unique_10', NULL), ('unique_11', 'default2'), ('unique_12', 'default2'), ('unique_13', 'default2'), ('unique_14', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_9', '-'), ('-', 'unique_4', 'c'), ('c', NULL, 'default1'), ('default2', 'unique_5', NULL), ('unique_4', 'unique_14', 'default2'), ('unique_5', 'default2', 'default1'), ('unique_6', 'unique_12', 'c'), ('unique_7', 'unique_7', 'default2'), ('unique_8', 'unique_6', 'default2'), ('unique_9', 'unique_8', '-'), ('unique_10', NULL, 'c'), ('unique_11', '-', 'default2'), ('unique_12', 'c', '-'), ('unique_13', 'unique_6', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', 'unique_8', '-'), ('c', 'unique_7', '-'), ('default1', 'unique_5', 'default2'), ('default2', 'unique_12', 'default2'), ('unique_4', 'unique_4', 'default1'), ('unique_5', 'unique_12', 'default2'), ('unique_6', 'unique_7', 'c'), ('unique_7', 'unique_5', NULL), ('unique_8', 'unique_7', 'default2'), ('unique_9', 'unique_13', 'c'), ('unique_10', 'unique_9', NULL), ('unique_11', NULL, 'default1'), ('unique_12', 'unique_11', 'default1'), ('unique_13', 'default2', 'default1'), ('unique_14', NULL, 'default2'), ('unique_15', 'default2', '-'), ('unique_16', 'default1', 'default1'), ('unique_17', 'unique_14', NULL), ('unique_18', 'unique_14', 'c');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('c', 'default2', 'c'), ('unique_18', 'unique_7', '-'), ('c', 'unique_5', 'unique_12'), ('unique_4', 'unique_13', 'unique_13'), ('unique_9', 'unique_13', 'unique_9'), ('unique_14', 'unique_12', 'unique_7'), ('unique_13', 'c', 'default2'), ('unique_12', 'unique_5', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('unique_6',)
('unique_18',)
*/

-- Prediction Query
SELECT atom.atom_id FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE atom.element = 'c' AND molecule.label = '-';

/*
Prediction Result:
*/