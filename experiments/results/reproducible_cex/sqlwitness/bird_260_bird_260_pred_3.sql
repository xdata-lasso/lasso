-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'br'), ('default1', 'default1'), ('#', '#'), ('br', 'br'), ('p', 'p'), ('unique_5', 'default2'), ('unique_6', 'br'), ('unique_7', 'default1'), ('unique_8', 'default1'), ('unique_9', 'br'), ('unique_10', 'default2'), ('unique_11', 'br'), ('unique_12', '#'), ('unique_13', 'br'), ('unique_14', 'br'), ('unique_15', 'default2'), ('unique_16', 'p'), ('unique_17', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_13', '#'), ('default1', 'unique_9', '#'), ('p', NULL, 'br'), ('br', 'unique_9', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('#', 'unique_9', 'br'), ('default1', 'unique_17', '#'), ('br', 'unique_14', '#'), ('p', NULL, 'default2'), ('default2', 'unique_8', 'default1'), ('unique_5', 'unique_11', 'p'), ('unique_6', 'default1', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_5', NULL), ('p', 'p', NULL), ('default1', 'unique_6', 'br'), ('p', 'unique_6', 'br'), ('#', '#', 'br'), ('unique_6', 'default2', NULL), ('br', '#', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#' AND (T3.element = 'p' OR T3.element = 'br');

/*
Prediction Result:
(1,)
*/