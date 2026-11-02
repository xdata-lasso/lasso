-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('cl', 'default1'), ('+', 'default1'), ('default1', '+'), ('unique_4', '+'), ('unique_5', NULL), ('unique_6', 'cl'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'cl'), ('unique_10', 'cl'), ('unique_11', '+'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', '+'), ('unique_16', 'default1'), ('unique_17', NULL), ('unique_18', '+'), ('unique_19', '+'), ('unique_20', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_9', 'default2'), ('+', 'unique_19', 'default1'), ('cl', 'unique_18', 'default2'), ('default1', 'unique_12', NULL), ('unique_4', 'unique_15', 'default1'), ('unique_5', 'unique_5', 'default2'), ('unique_6', 'unique_15', 'default1'), ('unique_7', 'unique_12', 'default1'), ('unique_8', 'default1', 'default2'), ('unique_9', 'unique_18', NULL), ('unique_10', 'unique_13', 'cl'), ('unique_11', 'unique_16', 'default1'), ('unique_12', 'unique_12', NULL), ('unique_13', 'unique_17', 'default2'), ('unique_14', 'unique_5', 'cl'), ('unique_15', 'cl', 'default1'), ('unique_16', 'unique_6', 'cl'), ('unique_17', 'unique_6', 'default1'), ('unique_18', 'unique_18', 'cl'), ('unique_19', 'unique_5', 'default2'), ('unique_20', 'unique_17', 'cl'), ('unique_21', '+', NULL), ('unique_22', 'unique_12', '+'), ('unique_23', 'unique_17', 'cl'), ('unique_24', 'unique_13', 'cl'), ('unique_25', 'default2', 'default2'), ('unique_26', NULL, 'cl'), ('unique_27', 'cl', 'default2'), ('unique_28', 'unique_6', 'default1'), ('unique_29', 'default1', '+'), ('unique_30', 'unique_5', 'default1'), ('unique_31', 'unique_15', 'cl'), ('unique_32', 'unique_6', 'default2'), ('unique_33', 'unique_13', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN a.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(m.molecule_id) AS percentage FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+';

/*
Prediction Result:
(22.22222222222222,)
*/