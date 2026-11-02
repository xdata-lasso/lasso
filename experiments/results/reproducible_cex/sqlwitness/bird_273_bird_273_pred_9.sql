-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', 'cl'), ('cl', 'default1'), ('default2', 'cl'), ('default1', 'cl'), ('unique_4', '+'), ('unique_5', '+'), ('unique_6', 'default2'), ('unique_7', '+'), ('unique_8', NULL), ('unique_9', '+'), ('unique_10', '+'), ('unique_11', 'default1'), ('unique_12', '+'), ('unique_13', 'default2'), ('unique_14', 'cl'), ('unique_15', 'default2'), ('unique_16', 'default1'), ('unique_17', '+'), ('unique_18', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_13', 'cl'), ('default1', 'unique_8', '+'), ('default2', 'unique_15', NULL), ('cl', '+', 'default1'), ('unique_4', 'default1', 'default2'), ('unique_5', '+', 'default1'), ('unique_6', 'unique_14', 'default2'), ('unique_7', 'unique_13', 'cl'), ('unique_8', 'unique_12', 'default1'), ('unique_9', 'unique_8', NULL), ('unique_10', 'unique_16', NULL), ('unique_11', 'unique_10', NULL), ('unique_12', NULL, '+'), ('unique_13', '+', 'default1'), ('unique_14', 'unique_8', 'default1'), ('unique_15', 'unique_13', '+'), ('unique_16', 'unique_10', 'default2'), ('unique_17', 'unique_6', NULL), ('unique_18', 'unique_15', 'default1'), ('unique_19', 'default1', '+'), ('unique_20', NULL, 'default2'), ('unique_21', 'unique_7', 'cl'), ('unique_22', 'unique_8', 'default2'), ('unique_23', 'unique_9', '+'), ('unique_24', 'unique_15', 'cl'), ('unique_25', 'unique_16', 'cl'), ('unique_26', 'unique_12', 'default1'), ('unique_27', 'unique_9', 'cl'), ('unique_28', '+', 'default2'), ('unique_29', 'unique_8', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+';

/*
Prediction Result:
(28.571428571428573,)
*/