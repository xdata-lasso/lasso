-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('cl', NULL), ('+', '+'), ('default2', '+'), ('default1', NULL), ('unique_4', 'default1'), ('unique_5', '+'), ('unique_6', 'cl'), ('unique_7', 'cl'), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', 'cl'), ('unique_11', '+'), ('unique_12', 'default1'), ('unique_13', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'cl', 'default1'), ('+', 'unique_7', '+'), ('cl', NULL, 'cl'), ('default1', 'unique_13', 'cl'), ('unique_4', 'unique_11', NULL), ('unique_5', 'default2', 'default2'), ('unique_6', 'unique_11', 'default1'), ('unique_7', '+', '+'), ('unique_8', 'unique_6', 'default2'), ('unique_9', 'unique_5', 'cl'), ('unique_10', 'unique_11', 'cl'), ('unique_11', 'unique_6', '+'), ('unique_12', '+', NULL), ('unique_13', NULL, '+'), ('unique_14', 'unique_12', NULL), ('unique_15', 'unique_7', 'default2'), ('unique_16', 'unique_10', 'default1'), ('unique_17', 'unique_7', 'cl'), ('unique_18', 'unique_11', NULL), ('unique_19', 'unique_4', 'cl'), ('unique_20', 'unique_12', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' AND T2.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Prediction Result:
(10.526315789473685,)
*/