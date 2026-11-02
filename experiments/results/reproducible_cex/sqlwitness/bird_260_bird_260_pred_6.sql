-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'br'), ('br', 'default1'), ('p', NULL), ('#', 'p'), ('default2', 'default1'), ('unique_5', 'br'), ('unique_6', 'p'), ('unique_7', 'p'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'br'), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', 'p'), ('unique_14', 'default1'), ('unique_15', 'p'), ('unique_16', 'p'), ('unique_17', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('br', 'unique_16', 'default2'), ('default1', 'unique_10', 'br'), ('default2', 'unique_11', 'br'), ('#', 'br', 'default2'), ('p', NULL, NULL), ('unique_5', 'unique_9', '#'), ('unique_6', 'unique_9', '#'), ('unique_7', 'unique_9', 'default1'), ('unique_8', 'unique_7', 'default1'), ('unique_9', 'unique_5', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('#', 'default2', 'default2'), ('default2', 'unique_12', 'br'), ('p', 'unique_10', 'default2'), ('br', 'unique_9', 'default2'), ('default1', 'default2', NULL), ('unique_5', 'unique_7', 'default2'), ('unique_6', 'unique_7', 'default1'), ('unique_7', 'unique_14', 'br'), ('unique_8', 'unique_10', 'default2'), ('unique_9', NULL, 'p'), ('unique_10', NULL, 'default2'), ('unique_11', 'unique_7', '#'), ('unique_12', 'unique_12', '#'), ('unique_13', 'unique_6', NULL), ('unique_14', 'unique_9', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.atom_id) AS total_atoms FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element IN ('p', 'br') AND T2.bond_type = '#';

/*
Prediction Result:
(1,)
*/