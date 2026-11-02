-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('=', 'default1'), ('c', 'default2'), ('default1', 'default2'), ('default2', 'default2'), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', '='), ('unique_9', 'c'), ('unique_10', NULL), ('unique_11', 'c'), ('unique_12', NULL), ('unique_13', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', NULL, 'c'), ('c', 'unique_6', '='), ('default2', 'default2', 'default1'), ('default1', 'unique_12', NULL), ('unique_4', 'unique_4', '='), ('unique_5', 'unique_9', NULL), ('unique_6', 'unique_5', '='), ('unique_7', 'default2', NULL), ('unique_8', 'unique_12', '='), ('unique_9', 'unique_4', 'c'), ('unique_10', 'unique_5', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_13', NULL), ('default1', 'unique_7', '='), ('c', 'unique_6', 'default2'), ('=', 'unique_5', NULL), ('unique_4', 'unique_11', '='), ('unique_5', 'default2', '='), ('unique_6', 'unique_7', 'default1'), ('unique_7', 'unique_12', '='), ('unique_8', 'unique_10', NULL), ('unique_9', 'unique_10', '='), ('unique_10', 'unique_4', 'default1'), ('unique_11', 'unique_10', 'c'), ('unique_12', 'unique_13', 'c'), ('unique_13', 'unique_6', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN atom.element = 'c' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(atom.atom_id) AS carbon_percentage FROM atom INNER JOIN bond ON atom.molecule_id = bond.molecule_id WHERE bond.bond_type = '=';

/*
Prediction Result:
(16.666666666666668,)
*/