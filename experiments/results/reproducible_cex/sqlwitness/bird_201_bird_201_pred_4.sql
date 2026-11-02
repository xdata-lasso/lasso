-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('=', 'c'), ('default1', 'c'), ('default2', 'default2'), ('c', 'default1'), ('unique_4', NULL), ('unique_5', '='), ('unique_6', 'c'), ('unique_7', 'c'), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default2'), ('unique_12', '='), ('unique_13', 'default1'), ('unique_14', 'default2'), ('unique_15', '='), ('unique_16', 'default2'), ('unique_17', '='), ('unique_18', 'default2'), ('unique_19', NULL), ('unique_20', NULL), ('unique_21', 'c'), ('unique_22', 'default1'), ('unique_23', 'default2'), ('unique_24', 'c'), ('unique_25', '='), ('unique_26', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('c', 'unique_26', 'default2'), ('default2', 'unique_8', 'default2'), ('default1', 'default2', NULL), ('=', 'unique_18', '='), ('unique_4', 'unique_5', 'c'), ('unique_5', 'unique_14', 'c'), ('unique_6', 'unique_4', NULL), ('unique_7', 'unique_20', NULL), ('unique_8', 'unique_17', '='), ('unique_9', 'unique_12', NULL), ('unique_10', 'unique_22', '='), ('unique_11', '=', 'c'), ('unique_12', NULL, '='), ('unique_13', 'unique_23', 'c'), ('unique_14', 'unique_26', 'default1'), ('unique_15', 'c', NULL), ('unique_16', 'unique_13', '='), ('unique_17', 'unique_4', 'default2'), ('unique_18', 'unique_15', '='), ('unique_19', 'unique_14', '='), ('unique_20', 'unique_15', 'default2'), ('unique_21', 'unique_11', 'default1'), ('unique_22', 'unique_14', 'default1'), ('unique_23', 'unique_5', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('=', 'unique_9', 'default2'), ('c', 'unique_10', 'c'), ('default1', 'unique_6', 'c'), ('default2', 'unique_26', '='), ('unique_4', 'default2', 'c'), ('unique_5', 'c', NULL), ('unique_6', 'c', '='), ('unique_7', 'unique_22', NULL), ('unique_8', 'unique_21', NULL), ('unique_9', 'unique_26', NULL), ('unique_10', 'unique_8', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(a.element = 'c') AS REAL) / CAST(COUNT(a.atom_id) AS REAL)) * 100 AS carbon_percentage FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE b.bond_type = '=';

/*
Prediction Result:
(None,)
*/