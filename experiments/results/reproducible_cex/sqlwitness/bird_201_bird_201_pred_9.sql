-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('c', '='), ('default2', 'default1'), ('=', 'default2'), ('default1', NULL), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'c'), ('unique_9', NULL), ('unique_10', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default1'), ('=', 'unique_10', NULL), ('default1', NULL, 'c'), ('c', 'unique_7', 'default2'), ('unique_4', 'default1', 'default1'), ('unique_5', 'unique_4', NULL), ('unique_6', '=', NULL), ('unique_7', 'unique_4', NULL), ('unique_8', 'unique_7', NULL), ('unique_9', 'default1', 'default1'), ('unique_10', 'unique_5', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_7', NULL), ('c', 'c', 'c'), ('=', NULL, NULL), ('default1', 'unique_5', 'c'), ('unique_4', 'unique_9', NULL), ('unique_5', 'c', 'default2'), ('unique_6', 'c', 'default2'), ('unique_7', '=', 'c');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_4', 'unique_7', 'unique_6'), ('=', 'c', 'unique_10'), ('unique_6', 'unique_5', 'unique_5'), ('unique_7', 'unique_6', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'c' THEN 1 END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '=';

/*
Prediction Result:
(None,)
*/