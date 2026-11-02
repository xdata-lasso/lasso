-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('p', 'default1'), ('br', 'default2'), ('#', 'default2'), ('default2', 'br'), ('default1', NULL), ('unique_5', NULL), ('unique_6', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default2', 'p'), ('#', 'default2', 'default1'), ('br', '#', NULL), ('default1', 'unique_6', '#'), ('p', 'unique_6', 'default2'), ('unique_5', NULL, 'p'), ('unique_6', 'unique_6', '#'), ('unique_7', 'unique_6', 'br'), ('unique_8', '#', 'default1'), ('unique_9', NULL, NULL), ('unique_10', '#', '#'), ('unique_11', 'unique_5', '#'), ('unique_12', '#', 'p'), ('unique_13', 'br', 'default2'), ('unique_14', 'unique_6', 'p'), ('unique_15', 'unique_6', 'default2'), ('unique_16', 'unique_5', NULL), ('unique_17', 'unique_5', 'default1'), ('unique_18', '#', 'default1'), ('unique_19', 'default1', '#'), ('unique_20', 'br', 'default2'), ('unique_21', 'br', 'default2'), ('unique_22', NULL, NULL), ('unique_23', 'default1', 'default2'), ('unique_24', 'default2', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', '#', 'p'), ('br', 'p', 'p'), ('p', 'unique_5', 'p'), ('default2', 'default2', NULL), ('#', 'default2', 'default2'), ('unique_5', 'unique_5', 'p'), ('unique_6', 'br', 'default2'), ('unique_7', 'default2', NULL), ('unique_8', 'unique_6', '#'), ('unique_9', 'default1', 'default2'), ('unique_10', NULL, 'br'), ('unique_11', 'unique_5', 'default1'), ('unique_12', 'default2', 'p'), ('unique_13', 'default2', 'br'), ('unique_14', 'default1', '#'), ('unique_15', 'unique_6', 'p'), ('unique_16', 'default1', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.atom_id) FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE b.bond_type = '#' AND a.element IN ('p', 'br');

/*
Prediction Result:
(4,)
*/