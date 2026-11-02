-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'cl'), ('cl', 'default2'), ('default2', 'cl'), ('+', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'cl'), ('unique_7', '+'), ('unique_8', '+'), ('unique_9', NULL), ('unique_10', 'cl'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default1'), ('unique_14', '+'), ('unique_15', '+'), ('unique_16', '+'), ('unique_17', 'default2'), ('unique_18', 'cl'), ('unique_19', 'default1'), ('unique_20', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_7', 'cl'), ('default1', 'unique_15', 'default1'), ('cl', 'unique_18', '+'), ('default2', 'unique_15', 'default2'), ('unique_4', 'unique_17', NULL), ('unique_5', 'unique_11', 'cl'), ('unique_6', 'unique_16', NULL), ('unique_7', 'unique_20', 'default1'), ('unique_8', 'unique_5', '+'), ('unique_9', '+', 'default1'), ('unique_10', 'unique_11', 'default1'), ('unique_11', 'unique_15', 'default2'), ('unique_12', 'unique_9', 'default2'), ('unique_13', 'unique_15', 'cl'), ('unique_14', 'unique_20', '+'), ('unique_15', 'unique_13', NULL), ('unique_16', 'default1', 'default2'), ('unique_17', 'unique_7', '+'), ('unique_18', 'unique_16', '+'), ('unique_19', 'unique_18', 'cl'), ('unique_20', 'unique_19', 'cl'), ('unique_21', 'unique_19', 'cl'), ('unique_22', 'unique_18', 'cl'), ('unique_23', 'unique_9', '+'), ('unique_24', 'unique_5', 'cl'), ('unique_25', 'unique_9', 'default1'), ('unique_26', 'unique_7', 'default1'), ('unique_27', 'unique_16', 'default2'), ('unique_28', 'default2', '+'), ('unique_29', 'unique_14', NULL), ('unique_30', 'unique_16', 'default2'), ('unique_31', 'unique_6', '+'), ('unique_32', 'unique_16', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(18.181818181818183,)
*/

-- Prediction Query
SELECT (SUM(element = 'cl') * 100.0 / COUNT(*)) AS percentage FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(15.384615384615385,)
*/